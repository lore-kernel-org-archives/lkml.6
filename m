Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeDXIFq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:05:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932818AbeDXIEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:04:51 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, Mario.Limonciello@dell.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 5/6] HID: multitouch: simplify the settings of the various features
Date: Tue, 24 Apr 2018 10:04:36 +0200
Message-Id: <20180424080437.21367-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Win8 spec also declare other features we want to support:
latency and surface and button switches.

Though it doesn't seem we need to activate those by default, we have been
proved in the past that manufacturers rely on the Windows driver behavior
so we better mimic it to prevent further issues.

The current way of setting the features is cumbersome. It avoids iterating
over the list of features, but the way we store/retrieve the data just
doesn't scale with more than two values.

So iterate over the features when we decide to switch on the device and
make it simpler to extend.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 131 ++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 71 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 43784d31a1a3..8878de9eedba 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -127,11 +127,7 @@ struct mt_device {
 	int left_button_state;	/* left button state */
 	unsigned last_slot_field;	/* the last field of a slot */
 	unsigned mt_report_id;	/* the report ID of the multitouch device */
-	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
-	__s16 inputmode_index;	/* InputMode HID feature index in the report */
-	__s16 maxcontact_report_id;	/* Maximum Contact Number HID feature,
-				   -1 if non-existent */
-	__u8 inputmode_value;  /* InputMode HID feature value */
+	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 num_received;	/* how many contacts we received */
 	__u8 num_expected;	/* expected last contact index */
 	__u8 maxcontacts;
@@ -415,32 +411,9 @@ static void mt_feature_mapping(struct hid_device *hdev,
 	struct mt_device *td = hid_get_drvdata(hdev);
 
 	switch (usage->hid) {
-	case HID_DG_INPUTMODE:
-		/* Ignore if value index is out of bounds. */
-		if (usage->usage_index >= field->report_count) {
-			dev_err(&hdev->dev, "HID_DG_INPUTMODE out of range\n");
-			break;
-		}
-
-		if (td->inputmode < 0) {
-			td->inputmode = field->report->id;
-			td->inputmode_index = usage->usage_index;
-		} else {
-			/*
-			 * Some elan panels wrongly declare 2 input mode
-			 * features, and silently ignore when we set the
-			 * value in the second field. Skip the second feature
-			 * and hope for the best.
-			 */
-			dev_info(&hdev->dev,
-				 "Ignoring the extra HID_DG_INPUTMODE\n");
-		}
-
-		break;
 	case HID_DG_CONTACTMAX:
 		mt_get_feature(hdev, field->report);
 
-		td->maxcontact_report_id = field->report->id;
 		td->maxcontacts = field->value[0];
 		if (!td->maxcontacts &&
 		    field->logical_maximum <= MT_MAX_MAXCONTACT)
@@ -1181,61 +1154,81 @@ static void mt_report(struct hid_device *hid, struct hid_report *report)
 		input_sync(field->hidinput->input);
 }
 
-static void mt_set_input_mode(struct hid_device *hdev)
+static bool mt_need_to_apply_feature(struct hid_device *hdev,
+				     struct hid_field *field,
+				     struct hid_usage *usage)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	struct hid_report *r;
-	struct hid_report_enum *re;
 	struct mt_class *cls = &td->mtclass;
+	struct hid_report *report = field->report;
+	unsigned int index = usage->usage_index;
 	char *buf;
 	u32 report_len;
+	int max;
 
-	if (td->inputmode < 0)
-		return;
-
-	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
-	r = re->report_id_hash[td->inputmode];
-	if (r) {
+	switch (usage->hid) {
+	case HID_DG_INPUTMODE:
 		if (cls->quirks & MT_QUIRK_FORCE_GET_FEATURE) {
-			report_len = hid_report_len(r);
-			buf = hid_alloc_report_buf(r, GFP_KERNEL);
+			report_len = hid_report_len(report);
+			buf = hid_alloc_report_buf(report, GFP_KERNEL);
 			if (!buf) {
-				hid_err(hdev, "failed to allocate buffer for report\n");
-				return;
+				hid_err(hdev,
+					"failed to allocate buffer for report\n");
+				return false;
 			}
-			hid_hw_raw_request(hdev, r->id, buf, report_len,
+			hid_hw_raw_request(hdev, report->id, buf, report_len,
 					   HID_FEATURE_REPORT,
 					   HID_REQ_GET_REPORT);
 			kfree(buf);
 		}
-		r->field[0]->value[td->inputmode_index] = td->inputmode_value;
-		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
-	}
-}
 
-static void mt_set_maxcontacts(struct hid_device *hdev)
-{
-	struct mt_device *td = hid_get_drvdata(hdev);
-	struct hid_report *r;
-	struct hid_report_enum *re;
-	int fieldmax, max;
+		field->value[index] = td->inputmode_value;
+		return true;
 
-	if (td->maxcontact_report_id < 0)
-		return;
+	case HID_DG_CONTACTMAX:
+		if (td->mtclass.maxcontacts) {
+			max = min_t(int, field->logical_maximum,
+				    td->mtclass.maxcontacts);
+			if (field->value[index] != max) {
+				field->value[index] = max;
+				return true;
+			}
+		}
+		break;
+	}
 
-	if (!td->mtclass.maxcontacts)
-		return;
+	return false; /* no need to update the report */
+}
 
-	re = &hdev->report_enum[HID_FEATURE_REPORT];
-	r = re->report_id_hash[td->maxcontact_report_id];
-	if (r) {
-		max = td->mtclass.maxcontacts;
-		fieldmax = r->field[0]->logical_maximum;
-		max = min(fieldmax, max);
-		if (r->field[0]->value[0] != max) {
-			r->field[0]->value[0] = max;
-			hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+static void mt_set_modes(struct hid_device *hdev)
+{
+	struct hid_report_enum *rep_enum;
+	struct hid_report *rep;
+	struct hid_usage *usage;
+	int i, j;
+	bool update_report;
+
+	rep_enum = &hdev->report_enum[HID_FEATURE_REPORT];
+	list_for_each_entry(rep, &rep_enum->report_list, list) {
+		update_report = false;
+
+		for (i = 0; i < rep->maxfield; i++) {
+			/* Ignore if report count is out of bounds. */
+			if (rep->field[i]->report_count < 1)
+				continue;
+
+			for (j = 0; j < rep->field[i]->maxusage; j++) {
+				usage = &rep->field[i]->usage[j];
+
+				if (mt_need_to_apply_feature(hdev,
+							     rep->field[i],
+							     usage))
+					update_report = true;
+			}
 		}
+
+		if (update_report)
+			hid_hw_request(hdev, rep, HID_REQ_SET_REPORT);
 	}
 }
 
@@ -1428,8 +1421,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
-	td->inputmode = -1;
-	td->maxcontact_report_id = -1;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
 	td->cc_index = -1;
 	td->scantime_index = -1;
@@ -1476,8 +1467,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_warn(&hdev->dev, "Cannot allocate sysfs group for %s\n",
 				hdev->name);
 
-	mt_set_maxcontacts(hdev);
-	mt_set_input_mode(hdev);
+	mt_set_modes(hdev);
 
 	/* release .fields memory as it is not used anymore */
 	devm_kfree(&hdev->dev, td->fields);
@@ -1490,8 +1480,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static int mt_reset_resume(struct hid_device *hdev)
 {
 	mt_release_contacts(hdev);
-	mt_set_maxcontacts(hdev);
-	mt_set_input_mode(hdev);
+	mt_set_modes(hdev);
 	return 0;
 }
 
-- 
2.14.3
