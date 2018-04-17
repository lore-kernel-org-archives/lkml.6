Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeDQNSo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:18:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753276AbeDQNSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:18:42 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] HID: generic: create one input report per application type
Date: Tue, 17 Apr 2018 15:18:32 +0200
Message-Id: <20180417131833.8551-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180417131833.8551-1-benjamin.tissoires@redhat.com>
References: <CAO-hwJKQRFBP8g_o5rZ68k1XGG3DPHoeaM64gNoDeF9ngYE9rg@mail.gmail.com>
 <20180417131833.8551-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not a good idea to try to fit all types of applications in the
same input report. There are a lot of devices that are needing
the quirk HID_MULTI_INPUT but this quirk doesn't match the actual HID
description as it is based on the report ID.

Given that most devices with MULTI_INPUT I can think of split nicely
the devices inputs into application, it is a good thing to split the
devices by default based on this assumption.

Also make hid-multitouch following this rule, to not have to deal
with too many input created

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c       | 10 +++++++---
 drivers/hid/hid-generic.c    | 15 +++++++++++++++
 drivers/hid/hid-gfrm.c       |  2 +-
 drivers/hid/hid-input.c      | 20 +++++++++++++++++++-
 drivers/hid/hid-magicmouse.c |  6 +++---
 drivers/hid/hid-multitouch.c |  4 ++--
 include/linux/hid.h          |  5 ++++-
 7 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5d7cc6bbbac6..ac4799abcc4d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -57,7 +57,8 @@ MODULE_PARM_DESC(ignore_special_drivers, "Ignore any special drivers and handle
  * Register a new report for a device.
  */
 
-struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id)
+struct hid_report *hid_register_report(struct hid_device *device, unsigned type,
+				       unsigned id, unsigned application)
 {
 	struct hid_report_enum *report_enum = device->report_enum + type;
 	struct hid_report *report;
@@ -78,6 +79,7 @@ struct hid_report *hid_register_report(struct hid_device *device, unsigned type,
 	report->type = type;
 	report->size = 0;
 	report->device = device;
+	report->application = application;
 	report_enum->report_id_hash[id] = report;
 
 	list_add_tail(&report->list, &report_enum->report_list);
@@ -224,8 +226,10 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 	unsigned usages;
 	unsigned offset;
 	unsigned i;
+	unsigned application = hid_lookup_collection(parser, HID_COLLECTION_APPLICATION);
 
-	report = hid_register_report(parser->device, report_type, parser->global.report_id);
+	report = hid_register_report(parser->device, report_type,
+				     parser->global.report_id, application);
 	if (!report) {
 		hid_err(parser->device, "hid_register_report failed\n");
 		return -1;
@@ -259,7 +263,7 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 
 	field->physical = hid_lookup_collection(parser, HID_COLLECTION_PHYSICAL);
 	field->logical = hid_lookup_collection(parser, HID_COLLECTION_LOGICAL);
-	field->application = hid_lookup_collection(parser, HID_COLLECTION_APPLICATION);
+	field->application = application;
 
 	for (i = 0; i < usages; i++) {
 		unsigned j = i;
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index c25b4718de44..3b6eccbc2519 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -56,6 +56,20 @@ static bool hid_generic_match(struct hid_device *hdev,
 	return true;
 }
 
+static int hid_generic_probe(struct hid_device *hdev,
+			     const struct hid_device_id *id)
+{
+	int ret;
+
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+}
+
 static const struct hid_device_id hid_table[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
 	{ }
@@ -66,6 +80,7 @@ static struct hid_driver hid_generic = {
 	.name = "hid-generic",
 	.id_table = hid_table,
 	.match = hid_generic_match,
+	.probe = hid_generic_probe,
 };
 module_hid_driver(hid_generic);
 
diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index 075b1c020846..cf477f8c8f4c 100644
--- a/drivers/hid/hid-gfrm.c
+++ b/drivers/hid/hid-gfrm.c
@@ -116,7 +116,7 @@ static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 * those reports reach gfrm_raw_event() from hid_input_report().
 		 */
 		if (!hid_register_report(hdev, HID_INPUT_REPORT,
-					 GFRM100_SEARCH_KEY_REPORT_ID)) {
+					 GFRM100_SEARCH_KEY_REPORT_ID, 0)) {
 			ret = -ENOMEM;
 			goto done;
 		}
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 04056773102e..0803d5adefa7 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1607,6 +1607,20 @@ static struct hid_input *hidinput_match(struct hid_report *report)
 	return NULL;
 }
 
+static struct hid_input *hidinput_match_application(struct hid_report *report)
+{
+	struct hid_device *hid = report->device;
+	struct hid_input *hidinput;
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		if (hidinput->report &&
+		    hidinput->report->application == report->application)
+			return hidinput;
+	}
+
+	return NULL;
+}
+
 static inline void hidinput_configure_usages(struct hid_input *hidinput,
 					     struct hid_report *report)
 {
@@ -1667,6 +1681,9 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 			 */
 			if (hid->quirks & HID_QUIRK_MULTI_INPUT)
 				hidinput = hidinput_match(report);
+			else if (hid->maxapplication > 1 &&
+				 (hid->quirks & HID_QUIRK_INPUT_PER_APP))
+				hidinput = hidinput_match_application(report);
 
 			if (!hidinput) {
 				hidinput = hidinput_allocate(hid);
@@ -1676,7 +1693,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 
 			hidinput_configure_usages(hidinput, report);
 
-			if (hid->quirks & HID_QUIRK_MULTI_INPUT)
+			if (hid->quirks &
+			    (HID_QUIRK_MULTI_INPUT | HID_QUIRK_INPUT_PER_APP))
 				hidinput->report = report;
 		}
 	}
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 42ed887ba0be..b454c4386157 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -531,12 +531,12 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE)
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			MOUSE_REPORT_ID);
+			MOUSE_REPORT_ID, 0);
 	else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			TRACKPAD_REPORT_ID);
+			TRACKPAD_REPORT_ID, 0);
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			DOUBLE_REPORT_ID);
+			DOUBLE_REPORT_ID, 0);
 	}
 
 	if (!report) {
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8551766b75fa..2a0caf2e24ce 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1458,10 +1458,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/*
 	 * This allows the driver to handle different input sensors
-	 * that emits events through different reports on the same HID
+	 * that emits events through different applications on the same HID
 	 * device.
 	 */
-	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
 	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 0267aa5c1ea3..8d52cefedfe5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -341,6 +341,7 @@ struct hid_item {
 /* BIT(8) reserved for backward compatibility, was HID_QUIRK_NO_EMPTY_INPUT */
 /* BIT(9) reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
 #define HID_QUIRK_ALWAYS_POLL			BIT(10)
+#define HID_QUIRK_INPUT_PER_APP			BIT(11)
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
@@ -466,6 +467,7 @@ struct hid_report {
 	struct list_head list;
 	unsigned id;					/* id of this report */
 	unsigned type;					/* report type */
+	unsigned application;				/* application usage for this report */
 	struct hid_field *field[HID_MAX_FIELDS];	/* fields of the report */
 	unsigned maxfield;				/* maximum valid field index */
 	unsigned size;					/* size of the report (bits) */
@@ -859,7 +861,8 @@ void hid_output_report(struct hid_report *report, __u8 *data);
 void __hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype);
 u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
 struct hid_device *hid_allocate_device(void);
-struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id);
+struct hid_report *hid_register_report(struct hid_device *device, unsigned type,
+				       unsigned id, unsigned application);
 int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
 struct hid_report *hid_validate_values(struct hid_device *hid,
 				       unsigned int type, unsigned int id,
-- 
2.14.3
