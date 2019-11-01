#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://06d449da.ngrok.io/project/5dbbc69483657a6132039c24/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://06d449da.ngrok.io/pull/5dbbc69483657a6132039c24 
fi
curl -s -X POST https://06d449da.ngrok.io/project/5dbbc69483657a6132039c24/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://06d449da.ngrok.io/project/5dbbc69483657a6132039c24/webhook/build/publish > /dev/null
