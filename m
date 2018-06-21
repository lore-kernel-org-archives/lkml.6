Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE5EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F300208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F300208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeFUMJW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:09:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933199AbeFUMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:09:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA52387AAC;
        Thu, 21 Jun 2018 12:09:19 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-117-99.ams2.redhat.com [10.36.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B7DC2026D6B;
        Thu, 21 Jun 2018 12:09:18 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 04/12] HID: multitouch: store a per application quirks value
Date:   Thu, 21 Jun 2018 14:09:00 +0200
Message-Id: <20180621120908.16706-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 21 Jun 2018 12:09:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 21 Jun 2018 12:09:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device has more than one multitouch collection, there is a chance
we need per tool quirks. This is the case for the Totem on the Dell
Canvas.

Note that thesysfs attribute quirks can now get out of sync, but there
should not be much users of it as it's debugging only.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
no changes in v3
---
 drivers/hid/hid-multitouch.c | 64 ++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index cd207e99d26a..beaac36f61a7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -99,6 +99,9 @@ struct mt_slot {
 struct mt_application {
 	struct list_head list;
 	unsigned int application;
+
+	__s32 quirks;
+
 	struct mt_slot curdata;		/* placeholder of incoming data */
 
 	int cc_index;	/* contact count field index in the report */
@@ -368,7 +371,6 @@ static ssize_t mt_set_quirks(struct device *dev,
 	struct mt_application *application;
 
 	unsigned long val;
-	bool confidence_found = false;
 
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
@@ -376,13 +378,11 @@ static ssize_t mt_set_quirks(struct device *dev,
 	td->mtclass.quirks = val;
 
 	list_for_each_entry(application, &td->applications, list) {
-		if (application->have_contact_count)
-			confidence_found = true;
+		application->quirks = val;
+		if (!application->have_contact_count)
+			application->quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 	}
 
-	if (!confidence_found)
-		td->mtclass.quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
-
 	return count;
 }
 
@@ -501,6 +501,7 @@ static struct mt_application *mt_allocate_application(struct mt_device *td,
 
 	mt_application->cc_index = -1;
 	mt_application->scantime_index = -1;
+	mt_application->quirks = td->mtclass.quirks;
 
 	list_add_tail(&mt_application->list, &td->applications);
 
@@ -590,7 +591,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_DIGITIZER:
 		switch (usage->hid) {
 		case HID_DG_INRANGE:
-			if (cls->quirks & MT_QUIRK_HOVERING) {
+			if (app->quirks & MT_QUIRK_HOVERING) {
 				hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_DISTANCE);
 				input_set_abs_params(hi->input,
@@ -602,7 +603,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			if ((cls->name == MT_CLS_WIN_8 ||
 				cls->name == MT_CLS_WIN_8_DUAL) &&
 				field->application == HID_DG_TOUCHPAD)
-				cls->quirks |= MT_QUIRK_CONFIDENCE;
+				app->quirks |= MT_QUIRK_CONFIDENCE;
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_TIPSWITCH:
@@ -618,7 +619,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_WIDTH:
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_TOUCH_MAJOR);
-			if (!(cls->quirks & MT_QUIRK_NO_AREA))
+			if (!(app->quirks & MT_QUIRK_NO_AREA))
 				set_abs(hi->input, ABS_MT_TOUCH_MAJOR, field,
 					cls->sn_width);
 			mt_store_field(usage, td, hi);
@@ -626,7 +627,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_HEIGHT:
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_TOUCH_MINOR);
-			if (!(cls->quirks & MT_QUIRK_NO_AREA)) {
+			if (!(app->quirks & MT_QUIRK_NO_AREA)) {
 				set_abs(hi->input, ABS_MT_TOUCH_MINOR, field,
 					cls->sn_height);
 
@@ -700,7 +701,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		 * MS PTP spec says that external buttons left and right have
 		 * usages 2 and 3.
 		 */
-		if ((cls->quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
+		if ((app->quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
 		    field->application == HID_DG_TOUCHPAD &&
 		    (usage->hid & HID_USAGE) > 1)
 			code--;
@@ -719,7 +720,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 static int mt_compute_slot(struct mt_device *td, struct mt_application *app,
 			   struct input_dev *input)
 {
-	__s32 quirks = td->mtclass.quirks;
+	__s32 quirks = app->quirks;
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTID)
 		return app->curdata.contactid;
@@ -743,11 +744,11 @@ static int mt_compute_slot(struct mt_device *td, struct mt_application *app,
 static void mt_complete_slot(struct mt_device *td, struct mt_application *app,
 			     struct input_dev *input)
 {
-	if ((td->mtclass.quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
+	if ((app->quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
 	    app->num_received >= app->num_expected)
 		return;
 
-	if (app->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
+	if (app->curvalid || (app->quirks & MT_QUIRK_ALWAYS_VALID)) {
 		int active;
 		int slotnum = mt_compute_slot(td, app, input);
 		struct mt_slot *s = &app->curdata;
@@ -756,14 +757,14 @@ static void mt_complete_slot(struct mt_device *td, struct mt_application *app,
 		if (slotnum < 0 || slotnum >= td->maxcontacts)
 			return;
 
-		if ((td->mtclass.quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
+		if ((app->quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
 			struct input_mt_slot *slot = &mt->slots[slotnum];
 			if (input_mt_is_active(slot) &&
 			    input_mt_is_used(mt, slot))
 				return;
 		}
 
-		if (!(td->mtclass.quirks & MT_QUIRK_CONFIDENCE))
+		if (!(app->quirks & MT_QUIRK_CONFIDENCE))
 			s->confidence_state = true;
 		active = (s->touch_state || s->inrange_state) &&
 							s->confidence_state;
@@ -784,7 +785,7 @@ static void mt_complete_slot(struct mt_device *td, struct mt_application *app,
 			 * divided by two to match visual scale of touch
 			 * for devices with this quirk
 			 */
-			if (td->mtclass.quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
+			if (app->quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
 				major = major >> 1;
 				minor = minor >> 1;
 			}
@@ -815,7 +816,7 @@ static void mt_complete_slot(struct mt_device *td, struct mt_application *app,
 static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 			  struct input_dev *input)
 {
-	if (td->mtclass.quirks & MT_QUIRK_WIN8_PTP_BUTTONS)
+	if (app->quirks & MT_QUIRK_WIN8_PTP_BUTTONS)
 		input_event(input, EV_KEY, BTN_LEFT, app->left_button_state);
 
 	input_mt_sync_frame(input);
@@ -867,7 +868,7 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 				struct mt_application *app, bool first_packet)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
-	__s32 quirks = td->mtclass.quirks;
+	__s32 quirks = app->quirks;
 	struct input_dev *input = field->hidinput->input;
 
 	if (hid->claimed & HID_CLAIMED_INPUT) {
@@ -1017,7 +1018,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 		 * of a possible multi-packet frame be checking that the
 		 * timestamp has changed.
 		 */
-		if ((td->mtclass.quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
+		if ((app->quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
 		    app->num_received == 0 &&
 		    app->prev_scantime != scantime)
 			app->num_expected = contact_count;
@@ -1061,7 +1062,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	 * only affect laggish machines and the ones that have a firmware
 	 * defect.
 	 */
-	if (td->mtclass.quirks & MT_QUIRK_STICKY_FINGERS) {
+	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
 		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
@@ -1091,7 +1092,7 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (cls->is_indirect)
 		app->mt_flags |= INPUT_MT_POINTER;
 
-	if (cls->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
+	if (app->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
 		app->mt_flags |= INPUT_MT_DROP_UNUSED;
 
 	/* check for clickpads */
@@ -1119,6 +1120,8 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_application *application;
 
+	application = mt_find_application(td, field->application);
+
 	/*
 	 * If mtclass.export_all_inputs is not set, only map fields from
 	 * TouchScreen or TouchPad collections. We need to ignore fields
@@ -1134,7 +1137,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    field->application != HID_CP_CONSUMER_CONTROL &&
 	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
 	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
-	      td->mtclass.quirks & MT_QUIRK_ASUS_CUSTOM_UP))
+	      application->quirks & MT_QUIRK_ASUS_CUSTOM_UP))
 		return -1;
 
 	/*
@@ -1143,7 +1146,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	 * map usages to input keys.
 	 */
 	if (field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
-	    td->mtclass.quirks & MT_QUIRK_ASUS_CUSTOM_UP &&
+	    application->quirks & MT_QUIRK_ASUS_CUSTOM_UP &&
 	    (usage->hid & HID_USAGE_PAGE) == HID_UP_CUSTOM) {
 		set_bit(EV_REP, hi->input->evbit);
 		if (field->flags & HID_MAIN_ITEM_VARIABLE)
@@ -1160,8 +1163,6 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 1;
 	}
 
-	application = mt_find_application(td, field->application);
-
 	/*
 	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
 	 * for the stylus.
@@ -1267,9 +1268,9 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 		return true;
 
 	case HID_DG_CONTACTMAX:
-		if (td->mtclass.maxcontacts) {
+		if (cls->maxcontacts) {
 			max = min_t(int, field->logical_maximum,
-				    td->mtclass.maxcontacts);
+				    cls->maxcontacts);
 			if (field->value[index] != max) {
 				field->value[index] = max;
 				return true;
@@ -1332,7 +1333,7 @@ static void mt_set_modes(struct hid_device *hdev, enum latency_mode latency,
 static void mt_post_parse_default_settings(struct mt_device *td,
 					   struct mt_application *app)
 {
-	__s32 quirks = td->mtclass.quirks;
+	__s32 quirks = app->quirks;
 
 	/* unknown serial device needs special quirks */
 	if (app->touches_by_report == 1) {
@@ -1343,13 +1344,12 @@ static void mt_post_parse_default_settings(struct mt_device *td,
 		quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 	}
 
-	td->mtclass.quirks = quirks;
+	app->quirks = quirks;
 }
 
 static void mt_post_parse(struct mt_device *td, struct mt_application *app)
 {
 	struct mt_fields *f = td->fields;
-	struct mt_class *cls = &td->mtclass;
 
 	if (app->touches_by_report > 0) {
 		int field_count_per_touch;
@@ -1359,7 +1359,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app)
 	}
 
 	if (app->cc_index < 0)
-		cls->quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
+		app->quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 }
 
 static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
-- 
2.14.3

