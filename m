Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeE2J6T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:58:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932866AbeE2J6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:16 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/9] HID: multitouch: ditch mt_report_id
Date: Tue, 29 May 2018 11:57:56 +0200
Message-Id: <20180529095800.13504-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver can handle more than one multitouch collection in
a single HID device, ditch the last bit that contains us to use only
one mt collection.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 126 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 9356e4ba4e01..ff763c0b936a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -147,6 +147,13 @@ struct mt_fields {
 	unsigned int length;
 };
 
+struct mt_report_data {
+	struct list_head list;
+	struct hid_report *report;
+	struct mt_application *application;
+	bool is_mt_collection;
+};
+
 struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
@@ -154,13 +161,13 @@ struct mt_device {
 	struct mt_fields *fields;	/* temporary placeholder for storing the
 					   multitouch fields */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
-	unsigned mt_report_id;	/* the report ID of the multitouch device */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
 	bool serial_maybe;	/* need to check for serial protocol */
 
 	struct list_head applications;
+	struct list_head reports;
 };
 
 static void mt_post_parse_default_settings(struct mt_device *td,
@@ -526,6 +533,60 @@ static struct mt_application *mt_find_application(struct mt_device *td,
 	return mt_application;
 }
 
+static struct mt_report_data *mt_allocate_report_data(struct mt_device *td,
+						      struct hid_report *report)
+{
+	struct mt_report_data *rdata;
+	struct hid_field *field;
+	int r, n;
+
+	rdata = devm_kzalloc(&td->hdev->dev, sizeof(*rdata), GFP_KERNEL);
+	if (!rdata)
+		return NULL;
+
+	rdata->report = report;
+	rdata->application = mt_find_application(td, report->application);
+
+	if (!rdata->application) {
+		devm_kfree(&td->hdev->dev, rdata);
+		return NULL;
+	}
+
+	for (r = 0; r < report->maxfield; r++) {
+		field = report->field[r];
+
+		if (!(HID_MAIN_ITEM_VARIABLE & field->flags))
+			continue;
+
+		for (n = 0; n < field->report_count; n++) {
+			if (field->usage[n].hid == HID_DG_CONTACTID)
+				rdata->is_mt_collection = true;
+		}
+	}
+
+	list_add_tail(&rdata->list, &td->reports);
+
+	return rdata;
+}
+
+static struct mt_report_data *mt_find_report_data(struct mt_device *td,
+						  struct hid_report *report)
+{
+	struct mt_report_data *tmp, *rdata = NULL;
+
+	list_for_each_entry(tmp, &td->reports, list) {
+		if (report == tmp->report) {
+			rdata = tmp;
+			break;
+		}
+	}
+
+	if (!rdata)
+		rdata = mt_allocate_report_data(td, report);
+
+	return rdata;
+}
+
 static void mt_store_field(struct hid_usage *usage, struct mt_device *td,
 		struct hid_input *hi)
 {
@@ -614,7 +675,6 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONTACTID:
 			mt_store_field(usage, td, hi);
 			app->touches_by_report++;
-			td->mt_report_id = field->report->id;
 			return 1;
 		case HID_DG_WIDTH:
 			hid_map_usage(hi, usage, bit, max,
@@ -980,10 +1040,12 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 	}
 }
 
-static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
+static void mt_touch_report(struct hid_device *hid,
+			    struct mt_report_data *rdata)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
-	struct mt_application *app;
+	struct hid_report *report = rdata->report;
+	struct mt_application *app = rdata->application;
 	struct hid_field *field;
 	bool first_packet;
 	unsigned count;
@@ -995,11 +1057,6 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	if (test_and_set_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
 
-	app = mt_find_application(td, report->application);
-
-	if (!app)
-		return;
-
 	/*
 	 * Includes multi-packet support where subsequent
 	 * packets are sent with zero contactcount.
@@ -1120,8 +1177,15 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_application *application;
+	struct mt_report_data *rdata;
+
+	rdata = mt_find_report_data(td, field->report);
+	if (!rdata) {
+		hid_err(hdev, "failed to allocate data for report\n");
+		return 0;
+	}
 
-	application = mt_find_application(td, field->application);
+	application = rdata->application;
 
 	/*
 	 * If mtclass.export_all_inputs is not set, only map fields from
@@ -1164,22 +1228,9 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 1;
 	}
 
-	/*
-	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
-	 * for the stylus.
-	 * The check for mt_report_id ensures we don't process
-	 * HID_DG_CONTACTCOUNT from the pen report as it is outside the physical
-	 * collection, but within the report ID.
-	 */
-	if (field->physical == HID_DG_STYLUS)
-		return 0;
-	else if ((field->physical == 0) &&
-		 (field->report->id != td->mt_report_id) &&
-		 (td->mt_report_id != -1))
-		return 0;
-
-	if (field->application == HID_DG_TOUCHSCREEN ||
-	    field->application == HID_DG_TOUCHPAD)
+	if (rdata->is_mt_collection &&
+	    (field->application == HID_DG_TOUCHSCREEN ||
+	     field->application == HID_DG_TOUCHPAD))
 		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
 					      application);
 
@@ -1212,8 +1263,10 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 				struct hid_usage *usage, __s32 value)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
+	struct mt_report_data *rdata;
 
-	if (field->report->id == td->mt_report_id)
+	rdata = mt_find_report_data(td, field->report);
+	if (rdata && rdata->is_mt_collection)
 		return mt_touch_event(hid, field, usage, value);
 
 	return 0;
@@ -1223,12 +1276,14 @@ static void mt_report(struct hid_device *hid, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
 	struct hid_field *field = report->field[0];
+	struct mt_report_data *rdata;
 
 	if (!(hid->claimed & HID_CLAIMED_INPUT))
 		return;
 
-	if (report->id == td->mt_report_id)
-		return mt_touch_report(hid, report);
+	rdata = mt_find_report_data(td, report);
+	if (rdata && rdata->is_mt_collection)
+		return mt_touch_report(hid, rdata);
 
 	if (field && field->hidinput && field->hidinput->input)
 		input_sync(field->hidinput->input);
@@ -1369,15 +1424,22 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	char *name;
 	const char *suffix = NULL;
 	unsigned int application = 0;
+	struct mt_report_data *rdata;
 	struct mt_application *mt_application = NULL;
 	struct hid_report *report;
 	int ret;
 
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
 		application = report->application;
-		mt_application = mt_find_application(td, application);
+		rdata = mt_find_report_data(td, report);
+		if (!rdata) {
+			hid_err(hdev, "failed to allocate data for report\n");
+			return -ENOMEM;
+		}
+
+		mt_application = rdata->application;
 
-		if (report->id == td->mt_report_id) {
+		if (rdata->is_mt_collection) {
 			ret = mt_touch_input_configured(hdev, hi,
 							mt_application);
 			if (ret)
@@ -1530,10 +1592,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
-	td->mt_report_id = -1;
 	hid_set_drvdata(hdev, td);
 
 	INIT_LIST_HEAD(&td->applications);
+	INIT_LIST_HEAD(&td->reports);
 
 	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
 				  GFP_KERNEL);
-- 
2.14.3
