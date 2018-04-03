Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeDCRwZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:52:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45851 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeDCRwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:52:23 -0400
X-Google-Smtp-Source: AIpwx49Kci/zI3rulXElMAyHYnfyL58W2PnuuS6N98JaIaC4+C8JyYIMzgpEjxN1vvZy18WUk76yrw==
Date: Tue, 3 Apr 2018 10:52:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Martin <bugs@mrvanes.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: input: fix battery level reporting on BT mice
Message-ID: <20180403175220.GA148162@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 581c4484769e ("HID: input: map digitizer battery usage")
assumed that devices having input (qas opposed to feature) report for
battery strength would report the data on their own, without the need to
be polled by the kernel; unfortunately it is not so. Many wireless mice
do not send unsolicited reports with battery strength data and have to
be polled explicitly. As a complication, stylus devices on digitizers
are not normally connected to the base and thus can not be polled - the
base can only determine battery strength in the stylus when it is in
proximity.

To solve this issue, we add a special flag that tells the kernel
to avoid polling the device (and expect unsolicited reports) and set it
when report field with physical usage of digitizer stylus (HID_DG_STYLUS).
Unless this flag is set, and we have not seen the unsolicited reports,
the kernel will attempt to poll the device when userspace attempts to
read "capacity" and "state" attributes of power_supply object
corresponding to the devices battery.

Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198095
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Martin, give this patch a try and reply with your name/email if you
want to be credited for reporting/testing.

Thanks!

 drivers/hid/hid-input.c | 24 +++++++++++++++++-------
 include/linux/hid.h     |  9 ++++++++-
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 6836a856c243..930652c25120 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -387,7 +387,8 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (dev->battery_report_type == HID_FEATURE_REPORT) {
+		if (dev->battery_status != HID_BATTERY_REPORTED &&
+		    !dev->battery_avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
 			if (value < 0)
 				return value;
@@ -403,17 +404,17 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_STATUS:
-		if (!dev->battery_reported &&
-		    dev->battery_report_type == HID_FEATURE_REPORT) {
+		if (dev->battery_status != HID_BATTERY_REPORTED &&
+		    !dev->battery_avoid_query) {
 			value = hidinput_query_battery_capacity(dev);
 			if (value < 0)
 				return value;
 
 			dev->battery_capacity = value;
-			dev->battery_reported = true;
+			dev->battery_status = HID_BATTERY_QUERIED;
 		}
 
-		if (!dev->battery_reported)
+		if (dev->battery_status == HID_BATTERY_UNKNOWN)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else if (dev->battery_capacity == 100)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
@@ -486,6 +487,14 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
 
+	/*
+	 * Stylus is normally not connected to the device and thus we
+	 * can't query the device and get meaningful battery strength.
+	 * We have to wait for the device to report it on its own.
+	 */
+	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
+				   field->physical == HID_DG_STYLUS;
+
 	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
@@ -530,9 +539,10 @@ static void hidinput_update_battery(struct hid_device *dev, int value)
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
 
-	if (!dev->battery_reported || capacity != dev->battery_capacity) {
+	if (dev->battery_status != HID_BATTERY_REPORTED ||
+	    capacity != dev->battery_capacity) {
 		dev->battery_capacity = capacity;
-		dev->battery_reported = true;
+		dev->battery_status = HID_BATTERY_REPORTED;
 		power_supply_changed(dev->battery);
 	}
 }
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8da3e1f48195..26240a22978a 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -516,6 +516,12 @@ enum hid_type {
 	HID_TYPE_USBNONE
 };
 
+enum hid_battery_status {
+	HID_BATTERY_UNKNOWN = 0,
+	HID_BATTERY_QUERIED,		/* Kernel explicitly queried battery strength */
+	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
+};
+
 struct hid_driver;
 struct hid_ll_driver;
 
@@ -558,7 +564,8 @@ struct hid_device {							/* device report descriptor */
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
-	bool battery_reported;
+	enum hid_battery_status battery_status;
+	bool battery_avoid_query;
 #endif
 
 	unsigned int status;						/* see STAT flags above */
-- 
2.17.0.rc1.321.gba9d0f2565-goog


-- 
Dmitry
