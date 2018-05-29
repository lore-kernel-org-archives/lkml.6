Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeE2KAz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:00:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932867AbeE2J6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:17 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/9] HID: multitouch: remove one copy of values
Date: Tue, 29 May 2018 11:57:57 +0200
Message-Id: <20180529095800.13504-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current way of handling multitouch data is not very straightforward:
- in mt_event() we do nothing
- in mt_report() we:
  - do some gym to fetch the scantime and the contact count
  - then iterate over the input fields where we copy the data to a
    temporary place
  - when we see the last field in a slot, we then use this data to emit
    the input data

A more streamlined way is to first get all of the address in the report
of all fields, and then just pick the fields we are interested in in
mt_report()

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 546 +++++++++++++++++++++----------------------
 1 file changed, 264 insertions(+), 282 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index ff763c0b936a..424fb5f66b7d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -87,30 +87,34 @@ enum latency_mode {
 #define MT_IO_FLAGS_ACTIVE_SLOTS	1
 #define MT_IO_FLAGS_PENDING_SLOTS	2
 
-struct mt_slot {
-	__s32 x, y, cx, cy, p, w, h, a;
-	__s32 contactid;	/* the device ContactID assigned to this slot */
-	bool touch_state;	/* is the touch valid? */
-	bool inrange_state;	/* is the finger in proximity of the sensor? */
-	bool confidence_state;  /* is the touch made by a finger? */
-	bool has_azimuth;       /* the contact reports azimuth */
+static const bool mtrue = true;		/* default for true */
+static const bool mfalse;		/* default for false */
+static const __s32 mzero;		/* default for 0 */
+
+#define DEFAULT_TRUE	((void *)&mtrue)
+#define DEFAULT_FALSE	((void *)&mfalse)
+#define DEFAULT_ZERO	((void *)&mzero)
+
+struct mt_usages {
+	struct list_head list;
+	__s32 *x, *y, *cx, *cy, *p, *w, *h, *a;
+	__s32 *contactid;	/* the device ContactID assigned to this slot */
+	bool *tip_state;	/* is the touch valid? */
+	bool *inrange_state;	/* is the finger in proximity of the sensor? */
+	bool *confidence_state;	/* is the touch made by a finger? */
 };
 
 struct mt_application {
 	struct list_head list;
 	unsigned int application;
+	struct list_head mt_usages;	/* mt usages list */
 
 	__s32 quirks;
 
-	struct mt_slot curdata;		/* placeholder of incoming data */
-
-	int cc_index;	/* contact count field index in the report */
-	int cc_value_index;	/* contact count value index in the field */
-	int scantime_index;	/* scantime field index in the report */
-	int scantime_val_index;	/* scantime value index in the field */
-	unsigned int last_slot_field;	/* the last field of a slot */
-	bool curvalid;		/* is the current contact valid? */
+	__s32 *scantime;		/* scantime reported */
+	__s32 scantime_logical_max;	/* max value for raw scantime */
 
+	__s32 *raw_cc;			/* contact count in the report */
 	int left_button_state;		/* left button state */
 	unsigned int mt_flags;		/* flags to pass to input-mt */
 
@@ -142,11 +146,6 @@ struct mt_class {
 	bool export_all_inputs;	/* do not ignore mouse, keyboards, etc... */
 };
 
-struct mt_fields {
-	unsigned usages[HID_MAX_FIELDS];
-	unsigned int length;
-};
-
 struct mt_report_data {
 	struct list_head list;
 	struct hid_report *report;
@@ -158,8 +157,6 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	struct mt_fields *fields;	/* temporary placeholder for storing the
-					   multitouch fields */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
@@ -225,10 +222,11 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
  * to a valid contact that was just read.
  */
 
-static int cypress_compute_slot(struct mt_application *app)
+static int cypress_compute_slot(struct mt_application *application,
+				struct mt_usages *slot)
 {
-	if (app->curdata.contactid != 0 || app->num_received == 0)
-		return app->curdata.contactid;
+	if (*slot->contactid != 0 || application->num_received == 0)
+		return *slot->contactid;
 	else
 		return -1;
 }
@@ -483,6 +481,34 @@ static void set_abs(struct input_dev *input, unsigned int code,
 	input_abs_set_res(input, code, hidinput_calc_abs_res(field, code));
 }
 
+static struct mt_usages *mt_allocate_usage(struct hid_device *hdev,
+					   struct mt_application *application)
+{
+	struct mt_usages *usage;
+
+	usage = devm_kzalloc(&hdev->dev, sizeof(*usage), GFP_KERNEL);
+	if (!usage)
+		return NULL;
+
+	/* set some defaults so we do not need to check for null pointers */
+	usage->x = DEFAULT_ZERO;
+	usage->y = DEFAULT_ZERO;
+	usage->cx = DEFAULT_ZERO;
+	usage->cy = DEFAULT_ZERO;
+	usage->p = DEFAULT_ZERO;
+	usage->w = DEFAULT_ZERO;
+	usage->h = DEFAULT_ZERO;
+	usage->a = DEFAULT_ZERO;
+	usage->contactid = DEFAULT_ZERO;
+	usage->tip_state = DEFAULT_FALSE;
+	usage->inrange_state = DEFAULT_FALSE;
+	usage->confidence_state = DEFAULT_TRUE;
+
+	list_add_tail(&usage->list, &application->mt_usages);
+
+	return usage;
+}
+
 static struct mt_application *mt_allocate_application(struct mt_device *td,
 						      unsigned int application)
 {
@@ -494,6 +520,7 @@ static struct mt_application *mt_allocate_application(struct mt_device *td,
 		return NULL;
 
 	mt_application->application = application;
+	INIT_LIST_HEAD(&mt_application->mt_usages);
 
 	if (application == HID_DG_TOUCHSCREEN)
 		mt_application->mt_flags |= INPUT_MT_DIRECT;
@@ -506,8 +533,8 @@ static struct mt_application *mt_allocate_application(struct mt_device *td,
 		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
 	}
 
-	mt_application->cc_index = -1;
-	mt_application->scantime_index = -1;
+	mt_application->scantime = DEFAULT_ZERO;
+	mt_application->raw_cc = DEFAULT_ZERO;
 	mt_application->quirks = td->mtclass.quirks;
 
 	list_add_tail(&mt_application->list, &td->applications);
@@ -587,17 +614,45 @@ static struct mt_report_data *mt_find_report_data(struct mt_device *td,
 	return rdata;
 }
 
-static void mt_store_field(struct hid_usage *usage, struct mt_device *td,
-		struct hid_input *hi)
+static void mt_store_field(struct hid_device *hdev,
+			   struct mt_application *application,
+			   __s32 *value,
+			   size_t offset)
 {
-	struct mt_fields *f = td->fields;
+	struct mt_usages *usage;
+	__s32 **target;
+
+	if (list_empty(&application->mt_usages))
+		usage = mt_allocate_usage(hdev, application);
+	else
+		usage = list_last_entry(&application->mt_usages,
+					struct mt_usages,
+					list);
 
-	if (f->length >= HID_MAX_FIELDS)
+	if (!usage)
 		return;
 
-	f->usages[f->length++] = usage->hid;
+	target = (__s32 **)((char *)usage + offset);
+
+	/* the value has already been filled, create a new slot */
+	if (*target != DEFAULT_TRUE &&
+	    *target != DEFAULT_FALSE &&
+	    *target != DEFAULT_ZERO) {
+		usage = mt_allocate_usage(hdev, application);
+		if (!usage)
+			return;
+
+		target = (__s32 **)((char *)usage + offset);
+	}
+
+	*target = value;
 }
 
+#define MT_STORE_FIELD(__name)						\
+	mt_store_field(hdev, app,					\
+		       &field->value[usage->usage_index],		\
+		       offsetof(struct mt_usages, __name))
+
 static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max, struct mt_application *app)
@@ -627,24 +682,28 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_GENDESK:
 		switch (usage->hid) {
 		case HID_GD_X:
-			if (prev_usage && (prev_usage->hid == usage->hid))
+			if (prev_usage && (prev_usage->hid == usage->hid)) {
 				code = ABS_MT_TOOL_X;
-			else
+				MT_STORE_FIELD(cx);
+			} else {
 				code = ABS_MT_POSITION_X;
+				MT_STORE_FIELD(x);
+			}
 
-			hid_map_usage(hi, usage, bit, max, EV_ABS, code);
 			set_abs(hi->input, code, field, cls->sn_move);
-			mt_store_field(usage, td, hi);
+
 			return 1;
 		case HID_GD_Y:
-			if (prev_usage && (prev_usage->hid == usage->hid))
+			if (prev_usage && (prev_usage->hid == usage->hid)) {
 				code = ABS_MT_TOOL_Y;
-			else
+				MT_STORE_FIELD(cy);
+			} else {
 				code = ABS_MT_POSITION_Y;
+				MT_STORE_FIELD(y);
+			}
 
-			hid_map_usage(hi, usage, bit, max, EV_ABS, code);
 			set_abs(hi->input, code, field, cls->sn_move);
-			mt_store_field(usage, td, hi);
+
 			return 1;
 		}
 		return 0;
@@ -653,40 +712,33 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		switch (usage->hid) {
 		case HID_DG_INRANGE:
 			if (app->quirks & MT_QUIRK_HOVERING) {
-				hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_DISTANCE);
 				input_set_abs_params(hi->input,
 					ABS_MT_DISTANCE, 0, 1, 0, 0);
 			}
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(inrange_state);
 			return 1;
 		case HID_DG_CONFIDENCE:
 			if ((cls->name == MT_CLS_WIN_8 ||
 				cls->name == MT_CLS_WIN_8_DUAL) &&
 				field->application == HID_DG_TOUCHPAD)
 				app->quirks |= MT_QUIRK_CONFIDENCE;
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(confidence_state);
 			return 1;
 		case HID_DG_TIPSWITCH:
-			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
 			input_set_capability(hi->input, EV_KEY, BTN_TOUCH);
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(tip_state);
 			return 1;
 		case HID_DG_CONTACTID:
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(contactid);
 			app->touches_by_report++;
 			return 1;
 		case HID_DG_WIDTH:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOUCH_MAJOR);
 			if (!(app->quirks & MT_QUIRK_NO_AREA))
 				set_abs(hi->input, ABS_MT_TOUCH_MAJOR, field,
 					cls->sn_width);
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(w);
 			return 1;
 		case HID_DG_HEIGHT:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOUCH_MINOR);
 			if (!(app->quirks & MT_QUIRK_NO_AREA)) {
 				set_abs(hi->input, ABS_MT_TOUCH_MINOR, field,
 					cls->sn_height);
@@ -700,38 +752,23 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 					input_set_abs_params(hi->input,
 						ABS_MT_ORIENTATION, 0, 1, 0, 0);
 			}
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(h);
 			return 1;
 		case HID_DG_TIPPRESSURE:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_PRESSURE);
 			set_abs(hi->input, ABS_MT_PRESSURE, field,
 				cls->sn_pressure);
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(p);
 			return 1;
 		case HID_DG_SCANTIME:
-			hid_map_usage(hi, usage, bit, max,
-				EV_MSC, MSC_TIMESTAMP);
 			input_set_capability(hi->input, EV_MSC, MSC_TIMESTAMP);
-			mt_store_field(usage, td, hi);
-			/* Ignore if indexes are out of bounds. */
-			if (field->index >= field->report->maxfield ||
-			    usage->usage_index >= field->report_count)
-				return 1;
-			app->scantime_index = field->index;
-			app->scantime_val_index = usage->usage_index;
+			app->scantime = &field->value[usage->usage_index];
+			app->scantime_logical_max = field->logical_maximum;
 			return 1;
 		case HID_DG_CONTACTCOUNT:
-			/* Ignore if indexes are out of bounds. */
-			if (field->index >= field->report->maxfield ||
-			    usage->usage_index >= field->report_count)
-				return 1;
-			app->cc_index = field->index;
-			app->cc_value_index = usage->usage_index;
+			app->have_contact_count = true;
+			app->raw_cc = &field->value[usage->usage_index];
 			return 1;
 		case HID_DG_AZIMUTH:
-			hid_map_usage(hi, usage, bit, max,
-				EV_ABS, ABS_MT_ORIENTATION);
 			/*
 			 * Azimuth has the range of [0, MAX) representing a full
 			 * revolution. Set ABS_MT_ORIENTATION to a quarter of
@@ -742,11 +779,10 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				field->logical_maximum / 4,
 				cls->sn_move ?
 				field->logical_maximum / cls->sn_move : 0, 0);
-			mt_store_field(usage, td, hi);
+			MT_STORE_FIELD(a);
 			return 1;
 		case HID_DG_CONTACTMAX:
-			/* we don't set td->last_slot_field as contactcount and
-			 * contact max are global to the report */
+			/* contact max are global to the report */
 			return -1;
 		case HID_DG_TOUCH:
 			/* Legacy devices use TIPSWITCH and not TOUCH.
@@ -779,95 +815,24 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 }
 
 static int mt_compute_slot(struct mt_device *td, struct mt_application *app,
+			   struct mt_usages *slot,
 			   struct input_dev *input)
 {
 	__s32 quirks = app->quirks;
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTID)
-		return app->curdata.contactid;
+		return *slot->contactid;
 
 	if (quirks & MT_QUIRK_CYPRESS)
-		return cypress_compute_slot(app);
+		return cypress_compute_slot(app, slot);
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTNUMBER)
 		return app->num_received;
 
 	if (quirks & MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE)
-		return app->curdata.contactid - 1;
+		return *slot->contactid - 1;
 
-	return input_mt_get_slot_by_key(input, app->curdata.contactid);
-}
-
-/*
- * this function is called when a whole contact has been processed,
- * so that it can assign it to a slot and store the data there
- */
-static void mt_complete_slot(struct mt_device *td, struct mt_application *app,
-			     struct input_dev *input)
-{
-	if ((app->quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
-	    app->num_received >= app->num_expected)
-		return;
-
-	if (app->curvalid || (app->quirks & MT_QUIRK_ALWAYS_VALID)) {
-		int active;
-		int slotnum = mt_compute_slot(td, app, input);
-		struct mt_slot *s = &app->curdata;
-		struct input_mt *mt = input->mt;
-
-		if (slotnum < 0 || slotnum >= td->maxcontacts)
-			return;
-
-		if ((app->quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
-			struct input_mt_slot *slot = &mt->slots[slotnum];
-			if (input_mt_is_active(slot) &&
-			    input_mt_is_used(mt, slot))
-				return;
-		}
-
-		if (!(app->quirks & MT_QUIRK_CONFIDENCE))
-			s->confidence_state = true;
-		active = (s->touch_state || s->inrange_state) &&
-							s->confidence_state;
-
-		input_mt_slot(input, slotnum);
-		input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
-		if (active) {
-			/* this finger is in proximity of the sensor */
-			int wide = (s->w > s->h);
-			int major = max(s->w, s->h);
-			int minor = min(s->w, s->h);
-			int orientation = wide;
-
-			if (s->has_azimuth)
-				orientation = s->a;
-
-			/*
-			 * divided by two to match visual scale of touch
-			 * for devices with this quirk
-			 */
-			if (app->quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
-				major = major >> 1;
-				minor = minor >> 1;
-			}
-
-			input_event(input, EV_ABS, ABS_MT_POSITION_X, s->x);
-			input_event(input, EV_ABS, ABS_MT_POSITION_Y, s->y);
-			input_event(input, EV_ABS, ABS_MT_TOOL_X, s->cx);
-			input_event(input, EV_ABS, ABS_MT_TOOL_Y, s->cy);
-			input_event(input, EV_ABS, ABS_MT_DISTANCE,
-				!s->touch_state);
-			input_event(input, EV_ABS, ABS_MT_ORIENTATION,
-				orientation);
-			input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
-			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
-			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
-
-			set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
-		}
-	}
-
-	app->num_received++;
+	return input_mt_get_slot_by_key(input, *slot->contactid);
 }
 
 /*
@@ -893,8 +858,7 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
-static int mt_compute_timestamp(struct mt_application *app,
-				struct hid_field *field, __s32 value)
+static int mt_compute_timestamp(struct mt_application *app, __s32 value)
 {
 	long delta = value - app->prev_scantime;
 	unsigned long jdelta = jiffies_to_usecs(jiffies - app->jiffies);
@@ -902,7 +866,7 @@ static int mt_compute_timestamp(struct mt_application *app,
 	app->jiffies = jiffies;
 
 	if (delta < 0)
-		delta += field->logical_maximum;
+		delta += app->scantime_logical_max;
 
 	/* HID_DG_SCANTIME is expressed in 100us, we want it in us. */
 	delta *= 100;
@@ -924,64 +888,69 @@ static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
 	return 1;
 }
 
-static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
-				struct hid_usage *usage, __s32 value,
-				struct mt_application *app, bool first_packet)
+static int mt_process_slot(struct mt_device *td, struct input_dev *input,
+			    struct mt_application *app,
+			    struct mt_usages *slot)
 {
-	struct mt_device *td = hid_get_drvdata(hid);
+	struct input_mt *mt = input->mt;
 	__s32 quirks = app->quirks;
-	struct input_dev *input = field->hidinput->input;
+	bool valid = true;
+	bool confidence_state = true;
+	bool inrange_state = false;
+	int active;
+	int slotnum;
 
-	if (hid->claimed & HID_CLAIMED_INPUT) {
-		switch (usage->hid) {
-		case HID_DG_INRANGE:
-			if (quirks & MT_QUIRK_VALID_IS_INRANGE)
-				app->curvalid = value;
-			if (quirks & MT_QUIRK_HOVERING)
-				app->curdata.inrange_state = value;
-			break;
-		case HID_DG_TIPSWITCH:
-			if (quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
-				app->curvalid = value;
-			app->curdata.touch_state = value;
-			break;
-		case HID_DG_CONFIDENCE:
-			if (quirks & MT_QUIRK_CONFIDENCE)
-				app->curdata.confidence_state = value;
-			if (quirks & MT_QUIRK_VALID_IS_CONFIDENCE)
-				app->curvalid = value;
-			break;
-		case HID_DG_CONTACTID:
-			app->curdata.contactid = value;
-			break;
-		case HID_DG_TIPPRESSURE:
-			app->curdata.p = value;
-			break;
-		case HID_GD_X:
-			if (usage->code == ABS_MT_TOOL_X)
-				app->curdata.cx = value;
-			else
-				app->curdata.x = value;
-			break;
-		case HID_GD_Y:
-			if (usage->code == ABS_MT_TOOL_Y)
-				app->curdata.cy = value;
-			else
-				app->curdata.y = value;
-			break;
-		case HID_DG_WIDTH:
-			app->curdata.w = value;
-			break;
-		case HID_DG_HEIGHT:
-			app->curdata.h = value;
-			break;
-		case HID_DG_SCANTIME:
-			app->timestamp = mt_compute_timestamp(app, field,
-							      value);
-			break;
-		case HID_DG_CONTACTCOUNT:
-			break;
-		case HID_DG_AZIMUTH:
+	if (!slot)
+		return -EINVAL;
+
+	if ((quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
+	    app->num_received >= app->num_expected)
+		return -EAGAIN;
+
+	if (!(quirks & MT_QUIRK_ALWAYS_VALID)) {
+		if (quirks & MT_QUIRK_VALID_IS_INRANGE)
+			valid = *slot->inrange_state;
+		if (quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
+			valid = *slot->tip_state;
+		if (quirks & MT_QUIRK_VALID_IS_CONFIDENCE)
+			valid = *slot->confidence_state;
+
+		if (!valid)
+			return 0;
+	}
+
+	slotnum = mt_compute_slot(td, app, slot, input);
+	if (slotnum < 0 || slotnum >= td->maxcontacts)
+		return 0;
+
+	if ((quirks & MT_QUIRK_IGNORE_DUPLICATES) && mt) {
+		struct input_mt_slot *i_slot = &mt->slots[slotnum];
+
+		if (input_mt_is_active(i_slot) &&
+		    input_mt_is_used(mt, i_slot))
+			return -EAGAIN;
+	}
+
+	if (quirks & MT_QUIRK_CONFIDENCE)
+		confidence_state = *slot->confidence_state;
+
+	if (quirks & MT_QUIRK_HOVERING)
+		inrange_state = *slot->inrange_state;
+
+	active = (*slot->tip_state || inrange_state) && confidence_state;
+
+	input_mt_slot(input, slotnum);
+	input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
+	if (active) {
+		/* this finger is in proximity of the sensor */
+		int wide = (*slot->w > *slot->h);
+		int major = max(*slot->w, *slot->h);
+		int minor = min(*slot->w, *slot->h);
+		int orientation = wide;
+		int max_azimuth;
+		int azimuth;
+
+		if (slot->a != DEFAULT_ZERO) {
 			/*
 			 * Azimuth is counter-clockwise and ranges from [0, MAX)
 			 * (a full revolution). Convert it to clockwise ranging
@@ -992,52 +961,76 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			 * out of range to [-MAX/2, MAX/2] to report an upside
 			 * down ellipsis.
 			 */
-			if (value > field->logical_maximum / 2)
-				value -= field->logical_maximum;
-			app->curdata.a = -value;
-			app->curdata.has_azimuth = true;
-			break;
-		case HID_DG_TOUCH:
-			/* do nothing */
-			break;
+			azimuth = *slot->a;
+			max_azimuth = input_abs_get_max(input,
+							ABS_MT_ORIENTATION);
+			if (azimuth > max_azimuth * 2)
+				azimuth -= max_azimuth * 4;
+			orientation = -azimuth;
+		}
 
-		default:
-			/*
-			 * For Win8 PTP touchpads we should only look at
-			 * non finger/touch events in the first_packet of
-			 * a (possible) multi-packet frame.
-			 */
-			if ((quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
-			    !first_packet)
-				return;
+		/*
+		 * divided by two to match visual scale of touch
+		 * for devices with this quirk
+		 */
+		if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
+			major = major >> 1;
+			minor = minor >> 1;
+		}
 
-			/*
-			 * For Win8 PTP touchpads we map both the clickpad click
-			 * and any "external" left buttons to BTN_LEFT if a
-			 * device claims to have both we need to report 1 for
-			 * BTN_LEFT if either is pressed, so we or all values
-			 * together and report the result in mt_sync_frame().
-			 */
-			if ((quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
-			    usage->type == EV_KEY && usage->code == BTN_LEFT) {
-				app->left_button_state |= value;
-				return;
-			}
+		input_event(input, EV_ABS, ABS_MT_POSITION_X, *slot->x);
+		input_event(input, EV_ABS, ABS_MT_POSITION_Y, *slot->y);
+		input_event(input, EV_ABS, ABS_MT_TOOL_X, *slot->cx);
+		input_event(input, EV_ABS, ABS_MT_TOOL_Y, *slot->cy);
+		input_event(input, EV_ABS, ABS_MT_DISTANCE, !*slot->tip_state);
+		input_event(input, EV_ABS, ABS_MT_ORIENTATION, orientation);
+		input_event(input, EV_ABS, ABS_MT_PRESSURE, *slot->p);
+		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
+		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
+
+		set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
+	}
 
-			if (usage->type)
-				input_event(input, usage->type, usage->code,
-						value);
+	return 0;
+}
+
+static void mt_process_mt_event(struct hid_device *hid,
+				struct mt_application *app,
+				struct hid_field *field,
+				struct hid_usage *usage,
+				__s32 value,
+				bool first_packet)
+{
+	__s32 quirks = app->quirks;
+	struct input_dev *input = field->hidinput->input;
+
+	if (!usage->type || !(hid->claimed & HID_CLAIMED_INPUT))
+		return;
+
+	if (quirks & MT_QUIRK_WIN8_PTP_BUTTONS) {
+
+		/*
+		 * For Win8 PTP touchpads we should only look at
+		 * non finger/touch events in the first_packet of a
+		 * (possible) multi-packet frame.
+		 */
+		if (!first_packet)
 			return;
-		}
 
-		if (usage->usage_index + 1 == field->report_count) {
-			/* we only take into account the last report. */
-			if (usage->hid == app->last_slot_field)
-				mt_complete_slot(td, app,
-						 field->hidinput->input);
+		/*
+		 * For Win8 PTP touchpads we map both the clickpad click
+		 * and any "external" left buttons to BTN_LEFT if a
+		 * device claims to have both we need to report 1 for
+		 * BTN_LEFT if either is pressed, so we or all values
+		 * together and report the result in mt_sync_frame().
+		 */
+		if (usage->type == EV_KEY && usage->code == BTN_LEFT) {
+			app->left_button_state |= value;
+			return;
 		}
-
 	}
+
+	input_event(input, usage->type, usage->code, value);
 }
 
 static void mt_touch_report(struct hid_device *hid,
@@ -1047,6 +1040,8 @@ static void mt_touch_report(struct hid_device *hid,
 	struct hid_report *report = rdata->report;
 	struct mt_application *app = rdata->application;
 	struct hid_field *field;
+	struct input_dev *input;
+	struct mt_usages *slot;
 	bool first_packet;
 	unsigned count;
 	int r, n;
@@ -1057,18 +1052,16 @@ static void mt_touch_report(struct hid_device *hid,
 	if (test_and_set_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
 
+	scantime = *app->scantime;
+	app->timestamp = mt_compute_timestamp(app, scantime);
+	if (app->raw_cc != DEFAULT_ZERO)
+		contact_count = *app->raw_cc;
+
 	/*
 	 * Includes multi-packet support where subsequent
 	 * packets are sent with zero contactcount.
 	 */
-	if (app->scantime_index >= 0) {
-		field = report->field[app->scantime_index];
-		scantime = field->value[app->scantime_val_index];
-	}
-	if (app->cc_index >= 0) {
-		field = report->field[app->cc_index];
-		contact_count = field->value[app->cc_value_index];
-
+	if (contact_count >= 0) {
 		/*
 		 * For Win8 PTPs the first packet (td->num_received == 0) may
 		 * have a contactcount of 0 if there only is a button event.
@@ -1087,6 +1080,14 @@ static void mt_touch_report(struct hid_device *hid,
 	app->prev_scantime = scantime;
 
 	first_packet = app->num_received == 0;
+
+	input = report->field[0]->hidinput->input;
+
+	list_for_each_entry(slot, &app->mt_usages, list) {
+		if (!mt_process_slot(td, input, app, slot))
+			app->num_received++;
+	}
+
 	for (r = 0; r < report->maxfield; r++) {
 		field = report->field[r];
 		count = field->report_count;
@@ -1095,12 +1096,13 @@ static void mt_touch_report(struct hid_device *hid,
 			continue;
 
 		for (n = 0; n < count; n++)
-			mt_process_mt_event(hid, field, &field->usage[n],
-					    field->value[n], app, first_packet);
+			mt_process_mt_event(hid, app, field,
+					    &field->usage[n], field->value[n],
+					    first_packet);
 	}
 
 	if (app->num_received >= app->num_expected)
-		mt_sync_frame(td, app, report->field[0]->hidinput->input);
+		mt_sync_frame(td, app, input);
 
 	/*
 	 * Windows 8 specs says 2 things:
@@ -1392,7 +1394,7 @@ static void mt_post_parse_default_settings(struct mt_device *td,
 	__s32 quirks = app->quirks;
 
 	/* unknown serial device needs special quirks */
-	if (app->touches_by_report == 1) {
+	if (list_is_singular(&app->mt_usages)) {
 		quirks |= MT_QUIRK_ALWAYS_VALID;
 		quirks &= ~MT_QUIRK_NOT_SEEN_MEANS_UP;
 		quirks &= ~MT_QUIRK_VALID_IS_INRANGE;
@@ -1405,16 +1407,7 @@ static void mt_post_parse_default_settings(struct mt_device *td,
 
 static void mt_post_parse(struct mt_device *td, struct mt_application *app)
 {
-	struct mt_fields *f = td->fields;
-
-	if (app->touches_by_report > 0) {
-		int field_count_per_touch;
-
-		field_count_per_touch = f->length / app->touches_by_report;
-		app->last_slot_field = f->usages[field_count_per_touch - 1];
-	}
-
-	if (app->cc_index < 0)
+	if (!app->have_contact_count)
 		app->quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 }
 
@@ -1597,13 +1590,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	INIT_LIST_HEAD(&td->applications);
 	INIT_LIST_HEAD(&td->reports);
 
-	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
-				  GFP_KERNEL);
-	if (!td->fields) {
-		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
-		return -ENOMEM;
-	}
-
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
 		td->serial_maybe = true;
 
@@ -1639,10 +1625,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, true, true);
 
-	/* release .fields memory as it is not used anymore */
-	devm_kfree(&hdev->dev, td->fields);
-	td->fields = NULL;
-
 	return 0;
 }
 
-- 
2.14.3
