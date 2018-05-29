Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeE2KAE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:00:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932882AbeE2J6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:19 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 7/9] HID: input: enable Totem on the Dell Canvas 27
Date: Tue, 29 May 2018 11:57:58 +0200
Message-Id: <20180529095800.13504-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell Canvas 27 has a tool that can be put on the surface and acts
as a dial. The firmware processes the detection of the tool and forward
regular HID reports with X, Y, Azimuth, rotation, width/height.

The firmware also exports Contact ID, Countact Count which may hint that
several totems can be used at the same time (the FW only supports one).

We need a way to express that MT_TOOL_DIAL will be reported. However,
there is not much to do besides adding a new ioctl, so we will currently
use a special udev hwdb entries in user space.

This tool is aimed at being used by the system and not the applications,
so the user space processing should not go through the regular touch
inputs.
We set INPUT_PROP_DIRECT which applies ID_INPUT_TOUCHSCREEN to this new
type of devices, but we will counter this for the time being with the
special udev hwdb entry mentioned above.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1511846

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c      |  3 +++
 drivers/hid/hid-multitouch.c | 43 +++++++++++++++++++++++++++++--------------
 include/linux/hid.h          |  6 ++++++
 include/uapi/linux/input.h   |  3 ++-
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ab93dd5927c3..4e94ea3e280a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1550,6 +1550,9 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 		case HID_GD_WIRELESS_RADIO_CTLS:
 			suffix = "Wireless Radio Control";
 			break;
+		case HID_GD_SYSTEM_MULTIAXIS:
+			suffix = "System Multi Axis";
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 424fb5f66b7d..fa56b0b020df 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -665,7 +665,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	/*
 	 * Model touchscreens providing buttons as touchpads.
 	 */
-	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
+	if (field->application == HID_DG_TOUCHSCREEN &&
+	    (usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
 		app->mt_flags |= INPUT_MT_POINTER;
 		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
 	}
@@ -692,6 +693,14 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 			set_abs(hi->input, code, field, cls->sn_move);
 
+			/*
+			 * A system multi-axis that exports X and Y has a high
+			 * chance of being used directly on a surface
+			 */
+			if (field->application == HID_GD_SYSTEM_MULTIAXIS)
+				__set_bit(INPUT_PROP_DIRECT,
+					  hi->input->propbit);
+
 			return 1;
 		case HID_GD_Y:
 			if (prev_usage && (prev_usage->hid == usage->hid)) {
@@ -725,7 +734,9 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			MT_STORE_FIELD(confidence_state);
 			return 1;
 		case HID_DG_TIPSWITCH:
-			input_set_capability(hi->input, EV_KEY, BTN_TOUCH);
+			if (field->application != HID_GD_SYSTEM_MULTIAXIS)
+				input_set_capability(hi->input,
+						     EV_KEY, BTN_TOUCH);
 			MT_STORE_FIELD(tip_state);
 			return 1;
 		case HID_DG_CONTACTID:
@@ -802,6 +813,10 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		    field->application == HID_DG_TOUCHPAD &&
 		    (usage->hid & HID_USAGE) > 1)
 			code--;
+
+		if (field->application == HID_GD_SYSTEM_MULTIAXIS)
+			code = BTN_0  + ((usage->hid - 1) & HID_USAGE);
+
 		hid_map_usage(hi, usage, bit, max, EV_KEY, code);
 		input_set_capability(hi->input, EV_KEY, code);
 		return 1;
@@ -899,6 +914,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 	bool inrange_state = false;
 	int active;
 	int slotnum;
+	int tool = MT_TOOL_FINGER;
 
 	if (!slot)
 		return -EINVAL;
@@ -939,8 +955,11 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 
 	active = (*slot->tip_state || inrange_state) && confidence_state;
 
+	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
+		tool = MT_TOOL_DIAL;
+
 	input_mt_slot(input, slotnum);
-	input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
+	input_mt_report_slot_state(input, tool, active);
 	if (active) {
 		/* this finger is in proximity of the sensor */
 		int wide = (*slot->w > *slot->h);
@@ -1203,6 +1222,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    field->application != HID_GD_SYSTEM_CONTROL &&
 	    field->application != HID_CP_CONSUMER_CONTROL &&
 	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
+	    field->application != HID_GD_SYSTEM_MULTIAXIS &&
 	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
 	      application->quirks & MT_QUIRK_ASUS_CUSTOM_UP))
 		return -1;
@@ -1230,9 +1250,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 1;
 	}
 
-	if (rdata->is_mt_collection &&
-	    (field->application == HID_DG_TOUCHSCREEN ||
-	     field->application == HID_DG_TOUCHPAD))
+	if (rdata->is_mt_collection)
 		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
 					      application);
 
@@ -1244,15 +1262,11 @@ static int mt_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	/*
-	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
-	 * for the stylus.
-	 */
-	if (field->physical == HID_DG_STYLUS)
-		return 0;
+	struct mt_device *td = hid_get_drvdata(hdev);
+	struct mt_report_data *rdata;
 
-	if (field->application == HID_DG_TOUCHSCREEN ||
-	    field->application == HID_DG_TOUCHPAD) {
+	rdata = mt_find_report_data(td, field->report);
+	if (rdata && rdata->is_mt_collection) {
 		/* We own these mappings, tell hid-input to ignore them */
 		return -1;
 	}
@@ -1460,6 +1474,7 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		case HID_GD_SYSTEM_CONTROL:
 		case HID_CP_CONSUMER_CONTROL:
 		case HID_GD_WIRELESS_RADIO_CTLS:
+		case HID_GD_SYSTEM_MULTIAXIS:
 			/* already handled by hid core */
 			break;
 		case HID_DG_TOUCHSCREEN:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 41a3d5775394..9caa193e0c67 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -190,6 +190,12 @@ struct hid_item {
  * http://www.usb.org/developers/hidpage/HUTRR40RadioHIDUsagesFinal.pdf
  */
 #define HID_GD_WIRELESS_RADIO_CTLS	0x0001000c
+/*
+ * System Multi-Axis, see:
+ * http://www.usb.org/developers/hidpage/HUTRR62_-_Generic_Desktop_CA_for_System_Multi-Axis_Controllers.txt
+ */
+#define HID_GD_SYSTEM_MULTIAXIS	0x0001000e
+
 #define HID_GD_X		0x00010030
 #define HID_GD_Y		0x00010031
 #define HID_GD_Z		0x00010032
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 7288a7c573cc..e01caa038778 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -273,7 +273,8 @@ struct input_mask {
 #define MT_TOOL_FINGER		0
 #define MT_TOOL_PEN		1
 #define MT_TOOL_PALM		2
-#define MT_TOOL_MAX		2
+#define MT_TOOL_DIAL		3
+#define MT_TOOL_MAX		3
 
 /*
  * Values describing the status of a force-feedback effect
-- 
2.14.3
