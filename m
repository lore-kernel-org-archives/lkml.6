Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeDXIGD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:06:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756358AbeDXIEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:04:48 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, Mario.Limonciello@dell.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/6] HID: input: append a suffix matching the application
Date: Tue, 24 Apr 2018 10:04:34 +0200
Message-Id: <20180424080437.21367-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that we create one input node per application, we should name
the input node accordingly to not lose userspace.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 67 +++++++++++++++++++++++++++++++++++++++++++------
 include/linux/hid.h     |  1 +
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 361643683c08..ab93dd5927c3 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1510,15 +1510,56 @@ static void report_features(struct hid_device *hid)
 		}
 }
 
-static struct hid_input *hidinput_allocate(struct hid_device *hid)
+static struct hid_input *hidinput_allocate(struct hid_device *hid,
+					   unsigned int application)
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
@@ -1528,7 +1569,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
 	input_dev->setkeycode = hidinput_setkeycode;
 	input_dev->getkeycode = hidinput_getkeycode;
 
-	input_dev->name = hid->name;
+	input_dev->name = hidinput->name ? hidinput->name : hid->name;
 	input_dev->phys = hid->phys;
 	input_dev->uniq = hid->uniq;
 	input_dev->id.bustype = hid->bus;
@@ -1543,6 +1584,12 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
 	INIT_LIST_HEAD(&hidinput->reports);
 
 	return hidinput;
+
+fail:
+	kfree(hidinput);
+	input_free_device(input_dev);
+	hid_err(hid, "Out of memory during hid input probe\n");
+	return NULL;
 }
 
 static bool hidinput_has_been_populated(struct hid_input *hidinput)
@@ -1588,6 +1635,7 @@ static void hidinput_cleanup_hidinput(struct hid_device *hid,
 
 	list_del(&hidinput->list);
 	input_free_device(hidinput->input);
+	kfree(hidinput->name);
 
 	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++) {
 		if (k == HID_OUTPUT_REPORT &&
@@ -1656,6 +1704,7 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 	struct hid_driver *drv = hid->driver;
 	struct hid_report *report;
 	struct hid_input *next, *hidinput = NULL;
+	unsigned int application;
 	int i, k;
 
 	INIT_LIST_HEAD(&hid->inputs);
@@ -1688,6 +1737,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 			if (!report->maxfield)
 				continue;
 
+			application = report->application;
+
 			/*
 			 * Find the previous hidinput report attached
 			 * to this report id.
@@ -1699,7 +1750,7 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 				hidinput = hidinput_match_application(report);
 
 			if (!hidinput) {
-				hidinput = hidinput_allocate(hid);
+				hidinput = hidinput_allocate(hid, application);
 				if (!hidinput)
 					goto out_unwind;
 			}
diff --git a/include/linux/hid.h b/include/linux/hid.h
index d5ebeacc3b57..d3bd83d9127f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -512,6 +512,7 @@ struct hid_input {
 	struct list_head list;
 	struct hid_report *report;
 	struct input_dev *input;
+	const char *name;
 	bool registered;
 	struct list_head reports;	/* the list of reports */
 };
-- 
2.14.3
