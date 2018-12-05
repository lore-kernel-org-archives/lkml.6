Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2209C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D30214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/RsNSIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D30214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeLEJiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbeLEJiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:07 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847FA2084C;
        Wed,  5 Dec 2018 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002685;
        bh=LjxQo3QrJBCCSBND7Nec/3BUSZ1VAYQEsJCNLJJ2HDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/RsNSIO452/ONOytC2xeNdZQKoNnvakR0Dhe9yNmdt1pQ8hs9M4VzVFDDQE+3FRt
         sMEkmZOw7/t/FbANzO11fU7vrIPruSN+/xK9GJykfA2XMvVGVsD3JbBn/TjXe14v47
         ko39Lq+SvXaHmjONNQoweXVXwW2Kcitpm8rKHBAo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 038/123] iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for signed numbers
Date:   Wed,  5 Dec 2018 04:34:30 -0500
Message-Id: <20181205093555.5386-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0145b50566e7de5637e80ecba96c7f0e6fff1aad ]

Before this commit sensor_hub_input_attr_get_raw_value() failed to take
the signedness of 16 and 8 bit values into account, returning e.g.
65436 instead of -100 for the z-axis reading of an accelerometer.

This commit adds a new is_signed parameter to the function and makes all
callers pass the appropriate value for this.

While at it, this commit also fixes up some neighboring lines where
statements were needlessly split over 2 lines to improve readability.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sensor-custom.c                  |  2 +-
 drivers/hid/hid-sensor-hub.c                     | 13 ++++++++++---
 drivers/iio/accel/hid-sensor-accel-3d.c          |  5 ++++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c            |  5 ++++-
 drivers/iio/humidity/hid-sensor-humidity.c       |  3 ++-
 drivers/iio/light/hid-sensor-als.c               |  8 +++++---
 drivers/iio/light/hid-sensor-prox.c              |  8 +++++---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c    |  8 +++++---
 drivers/iio/orientation/hid-sensor-incl-3d.c     |  8 +++++---
 drivers/iio/pressure/hid-sensor-press.c          |  8 +++++---
 drivers/iio/temperature/hid-sensor-temperature.c |  3 ++-
 drivers/rtc/rtc-hid-sensor-time.c                |  2 +-
 include/linux/hid-sensor-hub.h                   |  4 +++-
 13 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index e8a114157f87..bb012bc032e0 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -358,7 +358,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 						sensor_inst->hsdev,
 						sensor_inst->hsdev->usage,
 						usage, report_id,
-						SENSOR_HUB_SYNC);
+						SENSOR_HUB_SYNC, false);
 	} else if (!strncmp(name, "units", strlen("units")))
 		value = sensor_inst->fields[field_index].attribute.units;
 	else if (!strncmp(name, "unit-expo", strlen("unit-expo")))
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 2b63487057c2..4256fdc5cd6d 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -299,7 +299,8 @@ EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
 					u32 attr_usage_id, u32 report_id,
-					enum sensor_hub_read_flags flag)
+					enum sensor_hub_read_flags flag,
+					bool is_signed)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
 	unsigned long flags;
@@ -331,10 +332,16 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 						&hsdev->pending.ready, HZ*5);
 		switch (hsdev->pending.raw_size) {
 		case 1:
-			ret_val = *(u8 *)hsdev->pending.raw_data;
+			if (is_signed)
+				ret_val = *(s8 *)hsdev->pending.raw_data;
+			else
+				ret_val = *(u8 *)hsdev->pending.raw_data;
 			break;
 		case 2:
-			ret_val = *(u16 *)hsdev->pending.raw_data;
+			if (is_signed)
+				ret_val = *(s16 *)hsdev->pending.raw_data;
+			else
+				ret_val = *(u16 *)hsdev->pending.raw_data;
 			break;
 		case 4:
 			ret_val = *(u32 *)hsdev->pending.raw_data;
diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 41d97faf5013..38ff374a3ca4 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -149,6 +149,7 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 min;
 	struct hid_sensor_hub_device *hsdev =
 					accel_state->common_attributes.hsdev;
 
@@ -158,12 +159,14 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		hid_sensor_power_state(&accel_state->common_attributes, true);
 		report_id = accel_state->accel[chan->scan_index].report_id;
+		min = accel_state->accel[chan->scan_index].logical_minimum;
 		address = accel_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 					accel_state->common_attributes.hsdev,
 					hsdev->usage, address, report_id,
-					SENSOR_HUB_SYNC);
+					SENSOR_HUB_SYNC,
+					min < 0);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&accel_state->common_attributes,
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 36941e69f959..88e857c4baf4 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -111,6 +111,7 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -118,13 +119,15 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		hid_sensor_power_state(&gyro_state->common_attributes, true);
 		report_id = gyro_state->gyro[chan->scan_index].report_id;
+		min = gyro_state->gyro[chan->scan_index].logical_minimum;
 		address = gyro_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 					gyro_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_GYRO_3D, address,
 					report_id,
-					SENSOR_HUB_SYNC);
+					SENSOR_HUB_SYNC,
+					min < 0);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&gyro_state->common_attributes,
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index beab6d6fd6e1..4bc95f31c730 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -75,7 +75,8 @@ static int humidity_read_raw(struct iio_dev *indio_dev,
 				HID_USAGE_SENSOR_HUMIDITY,
 				HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
 				humid_st->humidity_attr.report_id,
-				SENSOR_HUB_SYNC);
+				SENSOR_HUB_SYNC,
+				humid_st->humidity_attr.logical_minimum < 0);
 		hid_sensor_power_state(&humid_st->common_attributes, false);
 
 		return IIO_VAL_INT;
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 406caaee9a3c..94f33250ba5a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -93,6 +93,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -102,8 +103,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 		case  CHANNEL_SCAN_INDEX_INTENSITY:
 		case  CHANNEL_SCAN_INDEX_ILLUM:
 			report_id = als_state->als_illum.report_id;
-			address =
-			HID_USAGE_SENSOR_LIGHT_ILLUM;
+			min = als_state->als_illum.logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
 		default:
 			report_id = -1;
@@ -116,7 +117,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 					als_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ALS, address,
 					report_id,
-					SENSOR_HUB_SYNC);
+					SENSOR_HUB_SYNC,
+					min < 0);
 			hid_sensor_power_state(&als_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 45107f7537b5..cf5a0c242609 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -73,6 +73,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -81,8 +82,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_PRESENCE:
 			report_id = prox_state->prox_attr.report_id;
-			address =
-			HID_USAGE_SENSOR_HUMAN_PRESENCE;
+			min = prox_state->prox_attr.logical_minimum;
+			address = HID_USAGE_SENSOR_HUMAN_PRESENCE;
 			break;
 		default:
 			report_id = -1;
@@ -95,7 +96,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 				prox_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PROX, address,
 				report_id,
-				SENSOR_HUB_SYNC);
+				SENSOR_HUB_SYNC,
+				min < 0);
 			hid_sensor_power_state(&prox_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index d55c4885211a..f3c0d41e5a8c 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -163,21 +163,23 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		hid_sensor_power_state(&magn_state->magn_flux_attributes, true);
-		report_id =
-			magn_state->magn[chan->address].report_id;
+		report_id = magn_state->magn[chan->address].report_id;
+		min = magn_state->magn[chan->address].logical_minimum;
 		address = magn_3d_addresses[chan->address];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 				magn_state->magn_flux_attributes.hsdev,
 				HID_USAGE_SENSOR_COMPASS_3D, address,
 				report_id,
-				SENSOR_HUB_SYNC);
+				SENSOR_HUB_SYNC,
+				min < 0);
 		else {
 			*val = 0;
 			hid_sensor_power_state(
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 1e5451d1ff88..bdc5e4554ee4 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -111,21 +111,23 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		hid_sensor_power_state(&incl_state->common_attributes, true);
-		report_id =
-			incl_state->incl[chan->scan_index].report_id;
+		report_id = incl_state->incl[chan->scan_index].report_id;
+		min = incl_state->incl[chan->scan_index].logical_minimum;
 		address = incl_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 				incl_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_INCLINOMETER_3D, address,
 				report_id,
-				SENSOR_HUB_SYNC);
+				SENSOR_HUB_SYNC,
+				min < 0);
 		else {
 			hid_sensor_power_state(&incl_state->common_attributes,
 						false);
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 4c437918f1d2..d7b1c00ceb4d 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -77,6 +77,7 @@ static int press_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -85,8 +86,8 @@ static int press_read_raw(struct iio_dev *indio_dev,
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_PRESSURE:
 			report_id = press_state->press_attr.report_id;
-			address =
-			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE;
+			min = press_state->press_attr.logical_minimum;
+			address = HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE;
 			break;
 		default:
 			report_id = -1;
@@ -99,7 +100,8 @@ static int press_read_raw(struct iio_dev *indio_dev,
 				press_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PRESSURE, address,
 				report_id,
-				SENSOR_HUB_SYNC);
+				SENSOR_HUB_SYNC,
+				min < 0);
 			hid_sensor_power_state(&press_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index beaf6fd3e337..b592fc4f007e 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -76,7 +76,8 @@ static int temperature_read_raw(struct iio_dev *indio_dev,
 			HID_USAGE_SENSOR_TEMPERATURE,
 			HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE,
 			temp_st->temperature_attr.report_id,
-			SENSOR_HUB_SYNC);
+			SENSOR_HUB_SYNC,
+			temp_st->temperature_attr.logical_minimum < 0);
 		hid_sensor_power_state(
 				&temp_st->common_attributes,
 				false);
diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index 2751dba850c6..3e1abb455472 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -213,7 +213,7 @@ static int hid_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* get a report with all values through requesting one value */
 	sensor_hub_input_attr_get_raw_value(time_state->common_attributes.hsdev,
 			HID_USAGE_SENSOR_TIME, hid_time_addresses[0],
-			time_state->info[0].report_id, SENSOR_HUB_SYNC);
+			time_state->info[0].report_id, SENSOR_HUB_SYNC, false);
 	/* wait for all values (event) */
 	ret = wait_for_completion_killable_timeout(
 			&time_state->comp_last_time, HZ*6);
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 331dc377c275..dc12f5c4b076 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -177,6 +177,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 * @attr_usage_id:	Attribute usage id as per spec
 * @report_id:	Report id to look for
 * @flag:      Synchronous or asynchronous read
+* @is_signed:   If true then fields < 32 bits will be sign-extended
 *
 * Issues a synchronous or asynchronous read request for an input attribute.
 * Returns data upto 32 bits.
@@ -190,7 +191,8 @@ enum sensor_hub_read_flags {
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
  					u32 usage_id,
  					u32 attr_usage_id, u32 report_id,
- 					enum sensor_hub_read_flags flag
+					enum sensor_hub_read_flags flag,
+					bool is_signed
 );
 
 /**
-- 
2.17.1

