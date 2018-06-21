Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70FC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7922B208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7922B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933654AbeFUMLT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:11:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933417AbeFUMJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:09:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32F8C407565D;
        Thu, 21 Jun 2018 12:09:21 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-117-99.ams2.redhat.com [10.36.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8C832026D6B;
        Thu, 21 Jun 2018 12:09:19 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 05/12] HID: multitouch: ditch mt_report_id
Date:   Thu, 21 Jun 2018 14:09:01 +0200
Message-Id: <20180621120908.16706-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 12:09:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 12:09:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver can handle more than one multitouch collection in
a single HID device, ditch the last bit that contains us to use only
one mt collection.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
no changes in v3
---
 drivers/hid/hid-multitouch.c | 126 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index beaac36f61a7..a2c10fc62ef2 100644
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
@@ -979,10 +1039,12 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
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
@@ -994,11 +1056,6 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
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
@@ -1119,8 +1176,15 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
@@ -1163,22 +1227,9 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
 
@@ -1211,8 +1262,10 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 				struct hid_usage *usage, __s32 value)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
+	struct mt_report_data *rdata;
 
-	if (field->report->id == td->mt_report_id)
+	rdata = mt_find_report_data(td, field->report);
+	if (rdata && rdata->is_mt_collection)
 		return mt_touch_event(hid, field, usage, value);
 
 	return 0;
@@ -1222,12 +1275,14 @@ static void mt_report(struct hid_device *hid, struct hid_report *report)
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
@@ -1368,15 +1423,22 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
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
@@ -1529,10 +1591,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
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

