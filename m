Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeCTLKZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:10:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752679AbeCTLFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:00 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/7] HID: multitouch: export a quirk for the button handling of touchpads
Date: Tue, 20 Mar 2018 12:04:45 +0100
Message-Id: <20180320110451.16582-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the class name, we better have a specific quirk for it
so other classes can make use of it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a144d3064829..fc80a9bf3e39 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -74,6 +74,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
 #define MT_QUIRK_STICKY_FINGERS		BIT(16)
 #define MT_QUIRK_ASUS_CUSTOM_UP		BIT(17)
+#define MT_QUIRK_WIN8_PTP_BUTTONS	BIT(18)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -241,7 +242,8 @@ static struct mt_class mt_classes[] = {
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_HOVERING |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
-			MT_QUIRK_STICKY_FINGERS },
+			MT_QUIRK_STICKY_FINGERS |
+			MT_QUIRK_WIN8_PTP_BUTTONS },
 	{ .name = MT_CLS_EXPORT_ALL_INPUTS,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
@@ -250,7 +252,8 @@ static struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_HOVERING |
-			MT_QUIRK_CONTACT_CNT_ACCURATE,
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_WIN8_PTP_BUTTONS,
 		.export_all_inputs = true },
 
 	/*
@@ -660,8 +663,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		 * MS PTP spec says that external buttons left and right have
 		 * usages 2 and 3.
 		 */
-		if ((cls->name == MT_CLS_WIN_8 ||
-			cls->name == MT_CLS_WIN_8_DUAL) &&
+		if ((cls->quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
 		    field->application == HID_DG_TOUCHPAD &&
 		    (usage->hid & HID_USAGE) > 1)
 			code--;
@@ -773,9 +775,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
  */
 static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 {
-	__s32 cls = td->mtclass.name;
-
-	if (cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL)
+	if (td->mtclass.quirks & MT_QUIRK_WIN8_PTP_BUTTONS)
 		input_event(input, EV_KEY, BTN_LEFT, td->left_button_state);
 
 	input_mt_sync_frame(input);
@@ -827,7 +827,6 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 				bool first_packet)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
-	__s32 cls = td->mtclass.name;
 	__s32 quirks = td->mtclass.quirks;
 	struct input_dev *input = field->hidinput->input;
 
@@ -905,7 +904,7 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			 * non finger/touch events in the first_packet of
 			 * a (possible) multi-packet frame.
 			 */
-			if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+			if ((quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
 			    !first_packet)
 				return;
 
@@ -916,7 +915,7 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			 * BTN_LEFT if either is pressed, so we or all values
 			 * together and report the result in mt_sync_frame().
 			 */
-			if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+			if ((quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
 			    usage->type == EV_KEY && usage->code == BTN_LEFT) {
 				td->left_button_state |= value;
 				return;
@@ -940,7 +939,6 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
-	__s32 cls = td->mtclass.name;
 	struct hid_field *field;
 	bool first_packet;
 	unsigned count;
@@ -969,7 +967,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 		 * of a possible multi-packet frame be checking that the
 		 * timestamp has changed.
 		 */
-		if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+		if ((td->mtclass.quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
 		    td->num_received == 0 && td->prev_scantime != scantime)
 			td->num_expected = value;
 		/* A non 0 contact count always indicates a first packet */
-- 
2.14.3
