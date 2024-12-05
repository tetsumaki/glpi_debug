#!/usr/bin/env bash

MY_RANDOM="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
mkdir -p gen/

for SEQ in {1..50}; do
	URL_INVENTORY='https://CHANGE.THIS/front/inventory.php'
	REPLACE_SRV_NAME="test-${RANDOM}"
	REPLACE_VMSYSTEM="test-${MY_RANDOM}"
	REPLACE_SMODEL="test-${MY_RANDOM}"
	REPLACE_BMANUFACTURER="test.-${MY_RANDOM}"
	REPLACE_SMANUFACTURER="test-${MY_RANDOM}"
	REPLACE_MMANUFACTURER="test-${MY_RANDOM}"
	REPLACE_CHASSIS_TYPE="test-${MY_RANDOM}"

	sed -e "s/REPLACE_SRV_NAME/${REPLACE_SRV_NAME}/g" \
		-e "s/REPLACE_VMSYSTEM/${REPLACE_VMSYSTEM}/g" \
		-e "s/REPLACE_SMODEL/${REPLACE_SMODEL}/g" \
		-e "s/REPLACE_BMANUFACTURER/${REPLACE_BMANUFACTURER}/g" \
		-e "s/REPLACE_SMANUFACTURER/${REPLACE_SMANUFACTURER}/g" \
		-e "s/REPLACE_MMANUFACTURER/${REPLACE_MMANUFACTURER}/g" \
		-e "s/REPLACE_CHASSIS_TYPE/${REPLACE_CHASSIS_TYPE}/g" \
		'populate.json' > "gen/populate_generated_${SEQ}.json"

	curl -X POST -H "Content-Type: application/json" -d @gen/populate_generated_"${SEQ}".json "${URL_INVENTORY}" &
done
