#!/bin/bash

set -e

minor_version=$(grep "ARG ZBX_VERSION=${MAJOR_VERSION}." dir3/Dockerfile | grep -oP '([\d]+)$')
echo "current version: ${minor_version}"

new_minor_version=$(($minor_version + 1))
echo "new version: ${new_minor_version}"

git checkout master
./update_ver.sh 3.2.${new_minor_version}
git add -A
git commit -m "Zabbix v3.2.${new_minor_version} release"
git tag -a 3.2.${new_minor_version} -m "tag hello-world v3.2.${new_minor_version} release"
git push origin master
curl --data '{"tag_name": "3.2.${new_minor_version}","target_commitish": "master","name": "3.2.${new_minor_version}","body": "example.com","draft": false,"prerelease": false}' https://api.github.com/repos/vtjarve/hello-world/releases?access_token=46ccda6367dce20585f9e2e7643fc40084badc05

echo "Done."

exit 0
