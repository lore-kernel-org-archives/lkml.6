Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932957AbeE2J60 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:58:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932476AbeE2J6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:13 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/9] HID: multitouch: Store per collection multitouch data
Date: Tue, 29 May 2018 11:57:54 +0200
Message-Id: <20180529095800.13504-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, hid-multitouch can only handle one multitouch collection at
a time. This is an issue for the Dell Canvas, as the Totem (a dial tool)
is also using a multitouch-like collection.

Factor out the multitouch collection data in their own struct.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 376 ++++++++++++++++++++++++++-----------------
 1 file changed, 230 insertions(+), 146 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 187d27f26eec..b3eb43ce2969 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -28,14 +28,11 @@
  */
 
 /*
- * This driver is regularly tested thanks to the tool hid-test[1].
- * This tool relies on hid-replay[2] and a database of hid devices[3].
+ * This driver is regularly tested thanks to the test suite in hid-tools[1].
  * Please run these regression tests before patching this module so that
  * your patch won't break existing known devices.
  *
- * [1] https://github.com/bentiss/hid-test
- * [2] https://github.com/bentiss/hid-replay
- * [3] https://github.com/bentiss/hid-devices
+ * [1] https://github.com/bentiss/hid-tools
  */
 
 #include <linux/device.h>
@@ -99,6 +96,37 @@ struct mt_slot {
 	bool has_azimuth;       /* the contact reports azimuth */
 };
 
+struct mt_application {
+	struct list_head list;
+	unsigned int application;
+	struct mt_slot curdata;		/* placeholder of incoming data */
+
+	int cc_index;	/* contact count field index in the report */
+	int cc_value_index;	/* contact count value index in the field */
+	int scantime_index;	/* scantime field index in the report */
+	int scantime_val_index;	/* scantime value index in the field */
+	unsigned int last_slot_field;	/* the last field of a slot */
+	bool curvalid;		/* is the current contact valid? */
+
+	int left_button_state;		/* left button state */
+	unsigned int mt_flags;		/* flags to pass to input-mt */
+
+	__u8 num_received;	/* how many contacts we received */
+	__u8 num_expected;	/* expected last contact index */
+	__u8 buttons_count;	/* number of physical buttons per touchpad */
+	__u8 touches_by_report;	/* how many touches are present in one report:
+				 * 1 means we should use a serial protocol
+				 * > 1 means hybrid (multitouch) protocol
+				 */
+
+	__s32 dev_time;		/* the scan time provided by the device */
+	unsigned long jiffies;	/* the frame's jiffies */
+	int timestamp;		/* the timestamp to be sent */
+	int prev_scantime;		/* scantime reported previously */
+
+	bool have_contact_count;
+};
+
 struct mt_class {
 	__s32 name;	/* MT_CLS */
 	__s32 quirks;
@@ -117,40 +145,24 @@ struct mt_fields {
 };
 
 struct mt_device {
-	struct mt_slot curdata;	/* placeholder of incoming data */
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_device *hdev;	/* hid_device we're attached to */
 	struct mt_fields *fields;	/* temporary placeholder for storing the
 					   multitouch fields */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
-	int cc_index;	/* contact count field index in the report */
-	int cc_value_index;	/* contact count value index in the field */
-	int scantime_index;	/* scantime field index in the report */
-	int scantime_val_index;	/* scantime value index in the field */
-	int prev_scantime;	/* scantime reported in the previous packet */
-	int left_button_state;	/* left button state */
-	unsigned last_slot_field;	/* the last field of a slot */
 	unsigned mt_report_id;	/* the report ID of the multitouch device */
 	__u8 inputmode_value;	/* InputMode HID feature value */
-	__u8 num_received;	/* how many contacts we received */
-	__u8 num_expected;	/* expected last contact index */
 	__u8 maxcontacts;
-	__u8 touches_by_report;	/* how many touches are present in one report:
-				* 1 means we should use a serial protocol
-				* > 1 means hybrid (multitouch) protocol */
-	__u8 buttons_count;	/* number of physical buttons per touchpad */
 	bool is_buttonpad;	/* is this device a button pad? */
 	bool serial_maybe;	/* need to check for serial protocol */
-	bool curvalid;		/* is the current contact valid? */
-	unsigned mt_flags;	/* flags to pass to input-mt */
-	__s32 dev_time;		/* the scan time provided by the device */
-	unsigned long jiffies;	/* the frame's jiffies */
-	int timestamp;		/* the timestamp to be sent */
+
+	struct list_head applications;
 };
 
-static void mt_post_parse_default_settings(struct mt_device *td);
-static void mt_post_parse(struct mt_device *td);
+static void mt_post_parse_default_settings(struct mt_device *td,
+					   struct mt_application *app);
+static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 
 /* classes of device behavior */
 #define MT_CLS_DEFAULT				0x0001
@@ -203,10 +215,10 @@ static void mt_post_parse(struct mt_device *td);
  * to a valid contact that was just read.
  */
 
-static int cypress_compute_slot(struct mt_device *td)
+static int cypress_compute_slot(struct mt_application *app)
 {
-	if (td->curdata.contactid != 0 || td->num_received == 0)
-		return td->curdata.contactid;
+	if (app->curdata.contactid != 0 || app->num_received == 0)
+		return app->curdata.contactid;
 	else
 		return -1;
 }
@@ -353,15 +365,22 @@ static ssize_t mt_set_quirks(struct device *dev,
 {
 	struct hid_device *hdev = to_hid_device(dev);
 	struct mt_device *td = hid_get_drvdata(hdev);
+	struct mt_application *application;
 
 	unsigned long val;
+	bool confidence_found = false;
 
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	td->mtclass.quirks = val;
 
-	if (td->cc_index < 0)
+	list_for_each_entry(application, &td->applications, list) {
+		if (application->have_contact_count)
+			confidence_found = true;
+	}
+
+	if (!confidence_found)
 		td->mtclass.quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 
 	return count;
@@ -457,6 +476,55 @@ static void set_abs(struct input_dev *input, unsigned int code,
 	input_abs_set_res(input, code, hidinput_calc_abs_res(field, code));
 }
 
+static struct mt_application *mt_allocate_application(struct mt_device *td,
+						      unsigned int application)
+{
+	struct mt_application *mt_application;
+
+	mt_application = devm_kzalloc(&td->hdev->dev, sizeof(*mt_application),
+				      GFP_KERNEL);
+	if (!mt_application)
+		return NULL;
+
+	mt_application->application = application;
+
+	if (application == HID_DG_TOUCHSCREEN)
+		mt_application->mt_flags |= INPUT_MT_DIRECT;
+
+	/*
+	 * Model touchscreens providing buttons as touchpads.
+	 */
+	if (application == HID_DG_TOUCHPAD) {
+		mt_application->mt_flags |= INPUT_MT_POINTER;
+		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
+	}
+
+	mt_application->cc_index = -1;
+	mt_application->scantime_index = -1;
+
+	list_add_tail(&mt_application->list, &td->applications);
+
+	return mt_application;
+}
+
+static struct mt_application *mt_find_application(struct mt_device *td,
+						  unsigned int application)
+{
+	struct mt_application *tmp, *mt_application = NULL;
+
+	list_for_each_entry(tmp, &td->applications, list) {
+		if (application == tmp->application) {
+			mt_application = tmp;
+			break;
+		}
+	}
+
+	if (!mt_application)
+		mt_application = mt_allocate_application(td, application);
+
+	return mt_application;
+}
+
 static void mt_store_field(struct hid_usage *usage, struct mt_device *td,
 		struct hid_input *hi)
 {
@@ -470,28 +538,24 @@ static void mt_store_field(struct hid_usage *usage, struct mt_device *td,
 
 static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
+		unsigned long **bit, int *max, struct mt_application *app)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_class *cls = &td->mtclass;
 	int code;
 	struct hid_usage *prev_usage = NULL;
 
-	if (field->application == HID_DG_TOUCHSCREEN)
-		td->mt_flags |= INPUT_MT_DIRECT;
-
 	/*
 	 * Model touchscreens providing buttons as touchpads.
 	 */
-	if (field->application == HID_DG_TOUCHPAD ||
-	    (usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
-		td->mt_flags |= INPUT_MT_POINTER;
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
+		app->mt_flags |= INPUT_MT_POINTER;
 		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
 	}
 
 	/* count the buttons on touchpads */
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON)
-		td->buttons_count++;
+		app->buttons_count++;
 
 	if (usage->usage_index)
 		prev_usage = &field->usage[usage->usage_index - 1];
@@ -501,33 +565,23 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_GENDESK:
 		switch (usage->hid) {
 		case HID_GD_X:
-			if (prev_usage && (prev_usage->hid == usage->hid)) {
-				hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOOL_X);
-				set_abs(hi->input, ABS_MT_TOOL_X, field,
-					cls->sn_move);
-			} else {
-				hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_X);
-				set_abs(hi->input, ABS_MT_POSITION_X, field,
-					cls->sn_move);
-			}
+			if (prev_usage && (prev_usage->hid == usage->hid))
+				code = ABS_MT_TOOL_X;
+			else
+				code = ABS_MT_POSITION_X;
 
+			hid_map_usage(hi, usage, bit, max, EV_ABS, code);
+			set_abs(hi->input, code, field, cls->sn_move);
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_GD_Y:
-			if (prev_usage && (prev_usage->hid == usage->hid)) {
-				hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOOL_Y);
-				set_abs(hi->input, ABS_MT_TOOL_Y, field,
-					cls->sn_move);
-			} else {
-				hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_Y);
-				set_abs(hi->input, ABS_MT_POSITION_Y, field,
-					cls->sn_move);
-			}
+			if (prev_usage && (prev_usage->hid == usage->hid))
+				code = ABS_MT_TOOL_Y;
+			else
+				code = ABS_MT_POSITION_Y;
 
+			hid_map_usage(hi, usage, bit, max, EV_ABS, code);
+			set_abs(hi->input, code, field, cls->sn_move);
 			mt_store_field(usage, td, hi);
 			return 1;
 		}
@@ -558,7 +612,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			return 1;
 		case HID_DG_CONTACTID:
 			mt_store_field(usage, td, hi);
-			td->touches_by_report++;
+			app->touches_by_report++;
 			td->mt_report_id = field->report->id;
 			return 1;
 		case HID_DG_WIDTH:
@@ -603,16 +657,16 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			if (field->index >= field->report->maxfield ||
 			    usage->usage_index >= field->report_count)
 				return 1;
-			td->scantime_index = field->index;
-			td->scantime_val_index = usage->usage_index;
+			app->scantime_index = field->index;
+			app->scantime_val_index = usage->usage_index;
 			return 1;
 		case HID_DG_CONTACTCOUNT:
 			/* Ignore if indexes are out of bounds. */
 			if (field->index >= field->report->maxfield ||
 			    usage->usage_index >= field->report_count)
 				return 1;
-			td->cc_index = field->index;
-			td->cc_value_index = usage->usage_index;
+			app->cc_index = field->index;
+			app->cc_value_index = usage->usage_index;
 			return 1;
 		case HID_DG_AZIMUTH:
 			hid_map_usage(hi, usage, bit, max,
@@ -663,39 +717,41 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static int mt_compute_slot(struct mt_device *td, struct input_dev *input)
+static int mt_compute_slot(struct mt_device *td, struct mt_application *app,
+			   struct input_dev *input)
 {
 	__s32 quirks = td->mtclass.quirks;
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTID)
-		return td->curdata.contactid;
+		return app->curdata.contactid;
 
 	if (quirks & MT_QUIRK_CYPRESS)
-		return cypress_compute_slot(td);
+		return cypress_compute_slot(app);
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTNUMBER)
-		return td->num_received;
+		return app->num_received;
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE)
-		return td->curdata.contactid - 1;
+		return app->curdata.contactid - 1;
 
-	return input_mt_get_slot_by_key(input, td->curdata.contactid);
+	return input_mt_get_slot_by_key(input, app->curdata.contactid);
 }
 
 /*
  * this function is called when a whole contact has been processed,
  * so that it can assign it to a slot and store the data there
  */
-static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
+static void mt_complete_slot(struct mt_device *td, struct mt_application *app,
+			     struct input_dev *input)
 {
 	if ((td->mtclass.quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
-	    td->num_received >= td->num_expected)
+	    app->num_received >= app->num_expected)
 		return;
 
-	if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
+	if (app->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
 		int active;
-		int slotnum = mt_compute_slot(td, input);
-		struct mt_slot *s = &td->curdata;
+		int slotnum = mt_compute_slot(td, app, input);
+		struct mt_slot *s = &app->curdata;
 		struct input_mt *mt = input->mt;
 
 		if (slotnum < 0 || slotnum >= td->maxcontacts)
@@ -750,23 +806,25 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 		}
 	}
 
-	td->num_received++;
+	app->num_received++;
 }
 
 /*
  * this function is called when a whole packet has been received and processed,
  * so that it can decide what to send to the input layer.
  */
-static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
+static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
+			  struct input_dev *input)
 {
 	if (td->mtclass.quirks & MT_QUIRK_WIN8_PTP_BUTTONS)
-		input_event(input, EV_KEY, BTN_LEFT, td->left_button_state);
+		input_event(input, EV_KEY, BTN_LEFT, app->left_button_state);
 
 	input_mt_sync_frame(input);
-	input_event(input, EV_MSC, MSC_TIMESTAMP, td->timestamp);
+	input_event(input, EV_MSC, MSC_TIMESTAMP, app->timestamp);
 	input_sync(input);
-	td->num_received = 0;
-	td->left_button_state = 0;
+	app->num_received = 0;
+	app->left_button_state = 0;
+
 	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
 		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
 	else
@@ -774,14 +832,13 @@ static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
-static int mt_compute_timestamp(struct mt_device *td, struct hid_field *field,
-		__s32 value)
+static int mt_compute_timestamp(struct mt_application *app,
+				struct hid_field *field, __s32 value)
 {
-	long delta = value - td->dev_time;
-	unsigned long jdelta = jiffies_to_usecs(jiffies - td->jiffies);
+	long delta = value - app->prev_scantime;
+	unsigned long jdelta = jiffies_to_usecs(jiffies - app->jiffies);
 
-	td->jiffies = jiffies;
-	td->dev_time = value;
+	app->jiffies = jiffies;
 
 	if (delta < 0)
 		delta += field->logical_maximum;
@@ -793,7 +850,7 @@ static int mt_compute_timestamp(struct mt_device *td, struct hid_field *field,
 		/* No data received for a while, resync the timestamp. */
 		return 0;
 	else
-		return td->timestamp + delta;
+		return app->timestamp + delta;
 }
 
 static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
@@ -808,7 +865,7 @@ static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
 
 static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 				struct hid_usage *usage, __s32 value,
-				bool first_packet)
+				struct mt_application *app, bool first_packet)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
 	__s32 quirks = td->mtclass.quirks;
@@ -818,47 +875,48 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 		switch (usage->hid) {
 		case HID_DG_INRANGE:
 			if (quirks & MT_QUIRK_VALID_IS_INRANGE)
-				td->curvalid = value;
+				app->curvalid = value;
 			if (quirks & MT_QUIRK_HOVERING)
-				td->curdata.inrange_state = value;
+				app->curdata.inrange_state = value;
 			break;
 		case HID_DG_TIPSWITCH:
 			if (quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
-				td->curvalid = value;
-			td->curdata.touch_state = value;
+				app->curvalid = value;
+			app->curdata.touch_state = value;
 			break;
 		case HID_DG_CONFIDENCE:
 			if (quirks & MT_QUIRK_CONFIDENCE)
-				td->curdata.confidence_state = value;
+				app->curdata.confidence_state = value;
 			if (quirks & MT_QUIRK_VALID_IS_CONFIDENCE)
-				td->curvalid = value;
+				app->curvalid = value;
 			break;
 		case HID_DG_CONTACTID:
-			td->curdata.contactid = value;
+			app->curdata.contactid = value;
 			break;
 		case HID_DG_TIPPRESSURE:
-			td->curdata.p = value;
+			app->curdata.p = value;
 			break;
 		case HID_GD_X:
 			if (usage->code == ABS_MT_TOOL_X)
-				td->curdata.cx = value;
+				app->curdata.cx = value;
 			else
-				td->curdata.x = value;
+				app->curdata.x = value;
 			break;
 		case HID_GD_Y:
 			if (usage->code == ABS_MT_TOOL_Y)
-				td->curdata.cy = value;
+				app->curdata.cy = value;
 			else
-				td->curdata.y = value;
+				app->curdata.y = value;
 			break;
 		case HID_DG_WIDTH:
-			td->curdata.w = value;
+			app->curdata.w = value;
 			break;
 		case HID_DG_HEIGHT:
-			td->curdata.h = value;
+			app->curdata.h = value;
 			break;
 		case HID_DG_SCANTIME:
-			td->timestamp = mt_compute_timestamp(td, field, value);
+			app->timestamp = mt_compute_timestamp(app, field,
+							      value);
 			break;
 		case HID_DG_CONTACTCOUNT:
 			break;
@@ -875,8 +933,8 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			 */
 			if (value > field->logical_maximum / 2)
 				value -= field->logical_maximum;
-			td->curdata.a = -value;
-			td->curdata.has_azimuth = true;
+			app->curdata.a = -value;
+			app->curdata.has_azimuth = true;
 			break;
 		case HID_DG_TOUCH:
 			/* do nothing */
@@ -901,7 +959,7 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			 */
 			if ((quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
 			    usage->type == EV_KEY && usage->code == BTN_LEFT) {
-				td->left_button_state |= value;
+				app->left_button_state |= value;
 				return;
 			}
 
@@ -913,8 +971,9 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 
 		if (usage->usage_index + 1 == field->report_count) {
 			/* we only take into account the last report. */
-			if (usage->hid == td->last_slot_field)
-				mt_complete_slot(td, field->hidinput->input);
+			if (usage->hid == app->last_slot_field)
+				mt_complete_slot(td, app,
+						 field->hidinput->input);
 		}
 
 	}
@@ -923,26 +982,34 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
+	struct mt_application *app;
 	struct hid_field *field;
 	bool first_packet;
 	unsigned count;
-	int r, n, scantime = 0;
+	int r, n;
+	int scantime = 0;
+	int contact_count = -1;
 
 	/* sticky fingers release in progress, abort */
 	if (test_and_set_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
 
+	app = mt_find_application(td, report->application);
+
+	if (!app)
+		return;
+
 	/*
 	 * Includes multi-packet support where subsequent
 	 * packets are sent with zero contactcount.
 	 */
-	if (td->scantime_index >= 0) {
-		field = report->field[td->scantime_index];
-		scantime = field->value[td->scantime_val_index];
+	if (app->scantime_index >= 0) {
+		field = report->field[app->scantime_index];
+		scantime = field->value[app->scantime_val_index];
 	}
-	if (td->cc_index >= 0) {
-		struct hid_field *field = report->field[td->cc_index];
-		int value = field->value[td->cc_value_index];
+	if (app->cc_index >= 0) {
+		field = report->field[app->cc_index];
+		contact_count = field->value[app->cc_value_index];
 
 		/*
 		 * For Win8 PTPs the first packet (td->num_received == 0) may
@@ -952,15 +1019,16 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 		 * timestamp has changed.
 		 */
 		if ((td->mtclass.quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
-		    td->num_received == 0 && td->prev_scantime != scantime)
-			td->num_expected = value;
+		    app->num_received == 0 &&
+		    app->prev_scantime != scantime)
+			app->num_expected = contact_count;
 		/* A non 0 contact count always indicates a first packet */
-		else if (value)
-			td->num_expected = value;
+		else if (contact_count)
+			app->num_expected = contact_count;
 	}
-	td->prev_scantime = scantime;
+	app->prev_scantime = scantime;
 
-	first_packet = td->num_received == 0;
+	first_packet = app->num_received == 0;
 	for (r = 0; r < report->maxfield; r++) {
 		field = report->field[r];
 		count = field->report_count;
@@ -970,11 +1038,11 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 
 		for (n = 0; n < count; n++)
 			mt_process_mt_event(hid, field, &field->usage[n],
-					    field->value[n], first_packet);
+					    field->value[n], app, first_packet);
 	}
 
-	if (td->num_received >= td->num_expected)
-		mt_sync_frame(td, report->field[0]->hidinput->input);
+	if (app->num_received >= app->num_expected)
+		mt_sync_frame(td, app, report->field[0]->hidinput->input);
 
 	/*
 	 * Windows 8 specs says 2 things:
@@ -1006,7 +1074,8 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 }
 
 static int mt_touch_input_configured(struct hid_device *hdev,
-					struct hid_input *hi)
+				     struct hid_input *hi,
+				     struct mt_application *app)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_class *cls = &td->mtclass;
@@ -1016,28 +1085,29 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (!td->maxcontacts)
 		td->maxcontacts = MT_DEFAULT_MAXCONTACT;
 
-	mt_post_parse(td);
+	mt_post_parse(td, app);
 	if (td->serial_maybe)
-		mt_post_parse_default_settings(td);
+		mt_post_parse_default_settings(td, app);
 
 	if (cls->is_indirect)
-		td->mt_flags |= INPUT_MT_POINTER;
+		app->mt_flags |= INPUT_MT_POINTER;
 
 	if (cls->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
-		td->mt_flags |= INPUT_MT_DROP_UNUSED;
+		app->mt_flags |= INPUT_MT_DROP_UNUSED;
 
 	/* check for clickpads */
-	if ((td->mt_flags & INPUT_MT_POINTER) && (td->buttons_count == 1))
+	if ((app->mt_flags & INPUT_MT_POINTER) &&
+	    (app->buttons_count == 1))
 		td->is_buttonpad = true;
 
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 
-	ret = input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
+	ret = input_mt_init_slots(input, td->maxcontacts, app->mt_flags);
 	if (ret)
 		return ret;
 
-	td->mt_flags = 0;
+	app->mt_flags = 0;
 	return 0;
 }
 
@@ -1048,6 +1118,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		unsigned long **bit, int *max)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
+	struct mt_application *application;
 
 	/*
 	 * If mtclass.export_all_inputs is not set, only map fields from
@@ -1090,6 +1161,8 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 1;
 	}
 
+	application = mt_find_application(td, field->application);
+
 	/*
 	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
 	 * for the stylus.
@@ -1106,7 +1179,8 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 	if (field->application == HID_DG_TOUCHSCREEN ||
 	    field->application == HID_DG_TOUCHPAD)
-		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max);
+		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
+					      application);
 
 	/* let hid-core decide for the others */
 	return 0;
@@ -1256,12 +1330,13 @@ static void mt_set_modes(struct hid_device *hdev, enum latency_mode latency,
 	}
 }
 
-static void mt_post_parse_default_settings(struct mt_device *td)
+static void mt_post_parse_default_settings(struct mt_device *td,
+					   struct mt_application *app)
 {
 	__s32 quirks = td->mtclass.quirks;
 
 	/* unknown serial device needs special quirks */
-	if (td->touches_by_report == 1) {
+	if (app->touches_by_report == 1) {
 		quirks |= MT_QUIRK_ALWAYS_VALID;
 		quirks &= ~MT_QUIRK_NOT_SEEN_MEANS_UP;
 		quirks &= ~MT_QUIRK_VALID_IS_INRANGE;
@@ -1272,17 +1347,19 @@ static void mt_post_parse_default_settings(struct mt_device *td)
 	td->mtclass.quirks = quirks;
 }
 
-static void mt_post_parse(struct mt_device *td)
+static void mt_post_parse(struct mt_device *td, struct mt_application *app)
 {
 	struct mt_fields *f = td->fields;
 	struct mt_class *cls = &td->mtclass;
 
-	if (td->touches_by_report > 0) {
-		int field_count_per_touch = f->length / td->touches_by_report;
-		td->last_slot_field = f->usages[field_count_per_touch - 1];
+	if (app->touches_by_report > 0) {
+		int field_count_per_touch;
+
+		field_count_per_touch = f->length / app->touches_by_report;
+		app->last_slot_field = f->usages[field_count_per_touch - 1];
 	}
 
-	if (td->cc_index < 0)
+	if (app->cc_index < 0)
 		cls->quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 }
 
@@ -1292,13 +1369,17 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	char *name;
 	const char *suffix = NULL;
 	unsigned int application = 0;
+	struct mt_application *mt_application = NULL;
 	struct hid_report *report;
 	int ret;
 
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
 		application = report->application;
+		mt_application = mt_find_application(td, application);
+
 		if (report->id == td->mt_report_id) {
-			ret = mt_touch_input_configured(hdev, hi);
+			ret = mt_touch_input_configured(hdev, hi,
+							mt_application);
 			if (ret)
 				return ret;
 		}
@@ -1387,6 +1468,7 @@ static void mt_fix_const_fields(struct hid_device *hdev, unsigned int usage)
 static void mt_release_contacts(struct hid_device *hid)
 {
 	struct hid_input *hidinput;
+	struct mt_application *application;
 	struct mt_device *td = hid_get_drvdata(hid);
 
 	list_for_each_entry(hidinput, &hid->inputs, list) {
@@ -1406,7 +1488,9 @@ static void mt_release_contacts(struct hid_device *hid)
 		}
 	}
 
-	td->num_received = 0;
+	list_for_each_entry(application, &td->applications, list) {
+		application->num_received = 0;
+	}
 }
 
 static void mt_expired_timeout(struct timer_list *t)
@@ -1446,11 +1530,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
-	td->cc_index = -1;
-	td->scantime_index = -1;
 	td->mt_report_id = -1;
 	hid_set_drvdata(hdev, td);
 
+	INIT_LIST_HEAD(&td->applications);
+
 	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
 				  GFP_KERNEL);
 	if (!td->fields) {
-- 
2.14.3
