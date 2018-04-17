Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDQNS6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:18:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753070AbeDQNSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:18:43 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: input: append a suffix matching the application
Date: Tue, 17 Apr 2018 15:18:33 +0200
Message-Id: <20180417131833.8551-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180417131833.8551-1-benjamin.tissoires@redhat.com>
References: <CAO-hwJKQRFBP8g_o5rZ68k1XGG3DPHoeaM64gNoDeF9ngYE9rg@mail.gmail.com>
 <20180417131833.8551-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that we create one input node per application, we should name
the input node accordingly to not lose userspace.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c      | 64 ++++++++++++++++++++++++++++++++++++++------
 drivers/hid/hid-multitouch.c | 30 +++++++--------------
 include/linux/hid.h          |  1 +
 3 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 0803d5adefa7..886d81df50d4 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1500,15 +1500,56 @@ static void report_features(struct hid_device *hid)
 		}
 }
 
-static struct hid_input *hidinput_allocate(struct hid_device *hid)
+static struct hid_input *hidinput_allocate(struct hid_device *hid,
+					   unsigned application)
 {
 	struct hid_input *hidinput = kzalloc(sizeof(*hidinput), GFP_KERNEL);
 	struct input_dev *input_dev = input_allocate_device();
-	if (!hidinput || !input_dev) {
-		kfree(hidinput);
-		input_free_device(input_dev);
-		hid_err(hid, "Out of memory during hid input probe\n");
-		return NULL;
+	const char *suffix = NULL;
+
+	if (!hidinput || !input_dev)
+		goto fail;
+
+	if ((hid->quirks & HID_QUIRK_INPUT_PER_APP) &&
+	    hid->maxapplication > 1) {
+		switch (application) {
+		case HID_GD_KEYBOARD:
+			suffix = "Keyboard";
+			break;
+		case HID_GD_KEYPAD:
+			suffix = "Keypad";
+			break;
+		case HID_GD_MOUSE:
+			suffix = "Mouse";
+			break;
+		case HID_DG_STYLUS:
+			suffix = "Pen";
+			break;
+		case HID_DG_TOUCHSCREEN:
+			suffix = "Touchscreen";
+			break;
+		case HID_DG_TOUCHPAD:
+			suffix = "Touchpad";
+			break;
+		case HID_GD_SYSTEM_CONTROL:
+			suffix = "System Control";
+			break;
+		case HID_CP_CONSUMER_CONTROL:
+			suffix = "Consumer Control";
+			break;
+		case HID_GD_WIRELESS_RADIO_CTLS:
+			suffix = "Wireless Radio Control";
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (suffix) {
+		hidinput->name = kasprintf(GFP_KERNEL, "%s %s",
+					   hid->name, suffix);
+		if (!hidinput->name)
+			goto fail;
 	}
 
 	input_set_drvdata(input_dev, hid);
@@ -1518,7 +1559,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
 	input_dev->setkeycode = hidinput_setkeycode;
 	input_dev->getkeycode = hidinput_getkeycode;
 
-	input_dev->name = hid->name;
+	input_dev->name = hidinput->name ? hidinput->name : hid->name;
 	input_dev->phys = hid->phys;
 	input_dev->uniq = hid->uniq;
 	input_dev->id.bustype = hid->bus;
@@ -1530,6 +1571,12 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
 	list_add_tail(&hidinput->list, &hid->inputs);
 
 	return hidinput;
+
+fail:
+	kfree(hidinput);
+	input_free_device(input_dev);
+	hid_err(hid, "Out of memory during hid input probe\n");
+	return NULL;
 }
 
 static bool hidinput_has_been_populated(struct hid_input *hidinput)
@@ -1575,6 +1622,7 @@ static void hidinput_cleanup_hidinput(struct hid_device *hid,
 
 	list_del(&hidinput->list);
 	input_free_device(hidinput->input);
+	kfree(hidinput->name);
 
 	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++) {
 		if (k == HID_OUTPUT_REPORT &&
@@ -1686,7 +1734,7 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 				hidinput = hidinput_match_application(report);
 
 			if (!hidinput) {
-				hidinput = hidinput_allocate(hid);
+				hidinput = hidinput_allocate(hid, report->application);
 				if (!hidinput)
 					goto out_unwind;
 			}
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2a0caf2e24ce..cfbaedc55e02 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1294,33 +1294,21 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	} else {
 		switch (field->application) {
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
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d52cefedfe5..1d1387773a7c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -511,6 +511,7 @@ struct hid_input {
 	struct list_head list;
 	struct hid_report *report;
 	struct input_dev *input;
+	const char *name;
 	bool registered;
 };
 
-- 
2.14.3
