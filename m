Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09FFC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92024218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfBCNul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53982 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbfBCNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:04 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0003ts-CF; Sun, 03 Feb 2019 13:50:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9h-0007Dd-Vo; Sun, 03 Feb 2019 14:49:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.255461897@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 206/305] iio/hid-sensors: Fix IIO_CHAN_INFO_RAW
 returning wrong values for signed numbers
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 0145b50566e7de5637e80ecba96c7f0e6fff1aad upstream.

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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[bwh: Backported to 3.16:
 - sensor_hub_input_attr_get_raw_value() doesn't take a sync/async flag
   parameter
 - In sensor_hub_input_attr_get_raw_value() keep using data->pending instead of
   hsdev->pending
 - In magn_3d_read_raw() keep using chan->scan_index intstead of chan->address
 - Drop changes in hid-sensor-{custom,humidity,temperature}
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -257,7 +257,8 @@ EXPORT_SYMBOL_GPL(sensor_hub_get_feature
 
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
-					u32 attr_usage_id, u32 report_id)
+					u32 attr_usage_id, u32 report_id,
+					bool is_signed)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
 	unsigned long flags;
@@ -282,10 +283,16 @@ int sensor_hub_input_attr_get_raw_value(
 	wait_for_completion_interruptible_timeout(&data->pending.ready, HZ*5);
 	switch (data->pending.raw_size) {
 	case 1:
-		ret_val = *(u8 *)data->pending.raw_data;
+		if (is_signed)
+			ret_val = *(s8 *)data->pending.raw_data;
+		else
+			ret_val = *(u8 *)data->pending.raw_data;
 		break;
 	case 2:
-		ret_val = *(u16 *)data->pending.raw_data;
+		if (is_signed)
+			ret_val = *(s16 *)data->pending.raw_data;
+		else
+			ret_val = *(u16 *)data->pending.raw_data;
 		break;
 	case 4:
 		ret_val = *(u32 *)data->pending.raw_data;
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -112,6 +112,7 @@ static int accel_3d_read_raw(struct iio_
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -125,12 +126,14 @@ static int accel_3d_read_raw(struct iio_
 		hid_sensor_power_state(&accel_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
 		report_id = accel_state->accel[chan->scan_index].report_id;
+		min = accel_state->accel[chan->scan_index].logical_minimum;
 		address = accel_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 					accel_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ACCEL_3D, address,
-					report_id);
+					report_id,
+					min < 0);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&accel_state->common_attributes,
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -112,6 +112,7 @@ static int gyro_3d_read_raw(struct iio_d
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -125,12 +126,14 @@ static int gyro_3d_read_raw(struct iio_d
 		hid_sensor_power_state(&gyro_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
 		report_id = gyro_state->gyro[chan->scan_index].report_id;
+		min = gyro_state->gyro[chan->scan_index].logical_minimum;
 		address = gyro_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 					gyro_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_GYRO_3D, address,
-					report_id);
+					report_id,
+					min < 0);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&gyro_state->common_attributes,
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -81,6 +81,7 @@ static int als_read_raw(struct iio_dev *
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -89,8 +90,8 @@ static int als_read_raw(struct iio_dev *
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_ILLUM:
 			report_id = als_state->als_illum.report_id;
-			address =
-			HID_USAGE_SENSOR_LIGHT_ILLUM;
+			min = als_state->als_illum.logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
 		default:
 			report_id = -1;
@@ -109,7 +110,8 @@ static int als_read_raw(struct iio_dev *
 			*val = sensor_hub_input_attr_get_raw_value(
 					als_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ALS, address,
-					report_id);
+					report_id,
+					min < 0);
 			hid_sensor_power_state(&als_state->common_attributes,
 						false);
 		} else {
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -74,6 +74,7 @@ static int prox_read_raw(struct iio_dev
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -82,8 +83,8 @@ static int prox_read_raw(struct iio_dev
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
@@ -103,7 +104,8 @@ static int prox_read_raw(struct iio_dev
 			*val = sensor_hub_input_attr_get_raw_value(
 				prox_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PROX, address,
-				report_id);
+				report_id,
+				min < 0);
 			hid_sensor_power_state(&prox_state->common_attributes,
 						false);
 		} else {
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -112,6 +112,7 @@ static int magn_3d_read_raw(struct iio_d
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -125,14 +126,15 @@ static int magn_3d_read_raw(struct iio_d
 		hid_sensor_power_state(&magn_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
 
-		report_id =
-			magn_state->magn[chan->scan_index].report_id;
+		report_id = magn_state->magn[chan->scan_index].report_id;
+		min = magn_state->magn[chan->scan_index].logical_minimum;
 		address = magn_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 				magn_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_COMPASS_3D, address,
-				report_id);
+				report_id,
+				min < 0);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&magn_state->common_attributes,
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -112,6 +112,7 @@ static int incl_3d_read_raw(struct iio_d
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -125,14 +126,15 @@ static int incl_3d_read_raw(struct iio_d
 		hid_sensor_power_state(&incl_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
 
-		report_id =
-			incl_state->incl[chan->scan_index].report_id;
+		report_id = incl_state->incl[chan->scan_index].report_id;
+		min = incl_state->incl[chan->scan_index].logical_minimum;
 		address = incl_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
 			*val = sensor_hub_input_attr_get_raw_value(
 				incl_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_INCLINOMETER_3D, address,
-				report_id);
+				report_id,
+				min < 0);
 		else {
 			hid_sensor_power_state(&incl_state->common_attributes,
 						false);
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -78,6 +78,7 @@ static int press_read_raw(struct iio_dev
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
 
 	*val = 0;
 	*val2 = 0;
@@ -86,8 +87,8 @@ static int press_read_raw(struct iio_dev
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
@@ -106,7 +107,8 @@ static int press_read_raw(struct iio_dev
 			*val = sensor_hub_input_attr_get_raw_value(
 				press_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PRESSURE, address,
-				report_id);
+				report_id,
+				min < 0);
 			hid_sensor_power_state(&press_state->common_attributes,
 						false);
 		} else {
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -213,7 +213,7 @@ static int hid_rtc_read_time(struct devi
 	/* get a report with all values through requesting one value */
 	sensor_hub_input_attr_get_raw_value(time_state->common_attributes.hsdev,
 			HID_USAGE_SENSOR_TIME, hid_time_addresses[0],
-			time_state->info[0].report_id);
+			time_state->info[0].report_id, false);
 	/* wait for all values (event) */
 	ret = wait_for_completion_killable_timeout(
 			&time_state->comp_last_time, HZ*6);
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -149,6 +149,7 @@ int sensor_hub_input_get_attribute_info(
 * @usage_id:	Attribute usage id of parent physical device as per spec
 * @attr_usage_id:	Attribute usage id as per spec
 * @report_id:	Report id to look for
+* @is_signed:   If true then fields < 32 bits will be sign-extended
 *
 * Issues a synchronous read request for an input attribute. Returns
 * data upto 32 bits. Since client can get events, so this call should
@@ -157,7 +158,8 @@ int sensor_hub_input_get_attribute_info(
 
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id,
-			u32 attr_usage_id, u32 report_id);
+			u32 attr_usage_id, u32 report_id,
+			bool is_signed);
 /**
 * sensor_hub_set_feature() - Feature set request
 * @report_id:	Report id to look for

