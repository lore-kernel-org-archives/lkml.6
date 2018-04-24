Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeDXIFk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:05:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932739AbeDXIEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:04:49 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, Mario.Limonciello@dell.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 4/6] HID: multitouch: make use of HID_QUIRK_INPUT_PER_APP
Date: Tue, 24 Apr 2018 10:04:35 +0200
Message-Id: <20180424080437.21367-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have HID_QUIRK_INPUT_PER_APPLICATION that splits the devices
into several devices. This helps us as we can now rely on hid-input
to set the names for us.

Also, this helps removing some magical numbers '0' when calling
.input_configured().

The only thing to take care of is that the field .report in struct
hid_input is now null. We need to iterate over the full list of
reports attached to a hid_input.

This is required for some Advanced Silicon touchscreen to correctly apply
the HID_QUIRK_INPUT_PER_APPLICATION as they have 2 reports associated
with the hidinput node. One contains the Input data, the other one
contains the Output data.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 72 ++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index dad2fbb0e3f8..43784d31a1a3 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1274,54 +1274,48 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct mt_device *td = hid_get_drvdata(hdev);
 	char *name;
 	const char *suffix = NULL;
-	struct hid_field *field = hi->report->field[0];
+	unsigned int application = 0;
+	struct hid_report *report;
 	int ret;
 
-	if (hi->report->id == td->mt_report_id) {
-		ret = mt_touch_input_configured(hdev, hi);
-		if (ret)
-			return ret;
+	list_for_each_entry(report, &hi->reports, hidinput_list) {
+		application = report->application;
+		if (report->id == td->mt_report_id) {
+			ret = mt_touch_input_configured(hdev, hi);
+			if (ret)
+				return ret;
+		}
+
+		/*
+		 * some egalax touchscreens have "application == DG_TOUCHSCREEN"
+		 * for the stylus. Check this first, and then rely on
+		 * the application field.
+		 */
+		if (report->field[0]->physical == HID_DG_STYLUS) {
+			suffix = "Pen";
+			/* force BTN_STYLUS to allow tablet matching in udev */
+			__set_bit(BTN_STYLUS, hi->input->keybit);
+		}
 	}
 
-	/*
-	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
-	 * for the stylus. Check this first, and then rely on the application
-	 * field.
-	 */
-	if (hi->report->field[0]->physical == HID_DG_STYLUS) {
-		suffix = "Pen";
-		/* force BTN_STYLUS to allow tablet matching in udev */
-		__set_bit(BTN_STYLUS, hi->input->keybit);
-	} else {
-		switch (field->application) {
+	if (!suffix) {
+		switch (application) {
 		case HID_GD_KEYBOARD:
-			suffix = "Keyboard";
-			break;
 		case HID_GD_KEYPAD:
-			suffix = "Keypad";
-			break;
 		case HID_GD_MOUSE:
-			suffix = "Mouse";
-			break;
-		case HID_DG_STYLUS:
-			suffix = "Pen";
-			/* force BTN_STYLUS to allow tablet matching in udev */
-			__set_bit(BTN_STYLUS, hi->input->keybit);
-			break;
-		case HID_DG_TOUCHSCREEN:
-			/* we do not set suffix = "Touchscreen" */
-			break;
 		case HID_DG_TOUCHPAD:
-			suffix = "Touchpad";
-			break;
 		case HID_GD_SYSTEM_CONTROL:
-			suffix = "System Control";
-			break;
 		case HID_CP_CONSUMER_CONTROL:
-			suffix = "Consumer Control";
-			break;
 		case HID_GD_WIRELESS_RADIO_CTLS:
-			suffix = "Wireless Radio Control";
+			/* already handled by hid core */
+			break;
+		case HID_DG_TOUCHSCREEN:
+			/* we do not set suffix = "Touchscreen" */
+			hi->input->name = hdev->name;
+			break;
+		case HID_DG_STYLUS:
+			/* force BTN_STYLUS to allow tablet matching in udev */
+			__set_bit(BTN_STYLUS, hi->input->keybit);
 			break;
 		case HID_VD_ASUS_CUSTOM_MEDIA_KEYS:
 			suffix = "Custom Media Keys";
@@ -1459,10 +1453,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/*
 	 * This allows the driver to handle different input sensors
-	 * that emits events through different reports on the same HID
+	 * that emits events through different applications on the same HID
 	 * device.
 	 */
-	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
 	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
-- 
2.14.3
