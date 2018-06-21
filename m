Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F389C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A152208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A152208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933647AbeFUMK6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:10:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933440AbeFUMJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:09:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 656B6402345E;
        Thu, 21 Jun 2018 12:09:24 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-117-99.ams2.redhat.com [10.36.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 266412026D6B;
        Thu, 21 Jun 2018 12:09:23 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 07/12] HID: input: enable Totem on the Dell Canvas 27
Date:   Thu, 21 Jun 2018 14:09:03 +0200
Message-Id: <20180621120908.16706-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 21 Jun 2018 12:09:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 21 Jun 2018 12:09:24 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell Canvas 27 has a tool that can be put on the surface and acts
as a dial. The firmware processes the detection of the tool and forward
regular HID reports with X, Y, Azimuth, rotation, width/height.

The firmware also exports Contact ID, Countact Count which may hint that
several totems can be used at the same time (the FW only supports one).

We can tell that MT_TOOL_DIAL will be reported by setting the min/max
of ABS_MT_TOOL_TYPE to MT_TOOL_DIAL.

This tool is aimed at being used by the system and not the applications,
so the user space processing should not go through the regular touch
inputs.
We set INPUT_PROP_DIRECT which applies ID_INPUT_TOUCHSCREEN to this new
type of devices, but we will counter this for the time being with the
special udev hwdb entry mentioned above.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1511846

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- manually declare ABS_MT_TOOL_TYPE and set its min/max to MT_TOOL_DIAL
  to explain which tool it will set

no changes in v3
---
 drivers/hid/hid-input.c      |  3 +++
 drivers/hid/hid-multitouch.c | 48 +++++++++++++++++++++++++++++++-------------
 include/linux/hid.h          |  6 ++++++
 3 files changed, 43 insertions(+), 14 deletions(-)

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
index 346e9caef6f3..a4a274ebfbef 100644
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
@@ -692,6 +693,19 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 			set_abs(hi->input, code, field, cls->sn_move);
 
+			/*
+			 * A system multi-axis that exports X and Y has a high
+			 * chance of being used directly on a surface
+			 */
+			if (field->application == HID_GD_SYSTEM_MULTIAXIS) {
+				__set_bit(INPUT_PROP_DIRECT,
+					  hi->input->propbit);
+				input_set_abs_params(hi->input,
+						     ABS_MT_TOOL_TYPE,
+						     MT_TOOL_DIAL,
+						     MT_TOOL_DIAL, 0, 0);
+			}
+
 			return 1;
 		case HID_GD_Y:
 			if (prev_usage && (prev_usage->hid == usage->hid)) {
@@ -725,7 +739,9 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
@@ -802,6 +818,10 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
@@ -899,6 +919,7 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 	bool inrange_state = false;
 	int active;
 	int slotnum;
+	int tool = MT_TOOL_FINGER;
 
 	if (!slot)
 		return -EINVAL;
@@ -939,8 +960,11 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 
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
@@ -1203,6 +1227,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    field->application != HID_GD_SYSTEM_CONTROL &&
 	    field->application != HID_CP_CONSUMER_CONTROL &&
 	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
+	    field->application != HID_GD_SYSTEM_MULTIAXIS &&
 	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
 	      application->quirks & MT_QUIRK_ASUS_CUSTOM_UP))
 		return -1;
@@ -1230,9 +1255,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 1;
 	}
 
-	if (rdata->is_mt_collection &&
-	    (field->application == HID_DG_TOUCHSCREEN ||
-	     field->application == HID_DG_TOUCHPAD))
+	if (rdata->is_mt_collection)
 		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
 					      application);
 
@@ -1244,15 +1267,11 @@ static int mt_input_mapped(struct hid_device *hdev, struct hid_input *hi,
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
@@ -1460,6 +1479,7 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		case HID_GD_SYSTEM_CONTROL:
 		case HID_CP_CONSUMER_CONTROL:
 		case HID_GD_WIRELESS_RADIO_CTLS:
+		case HID_GD_SYSTEM_MULTIAXIS:
 			/* already handled by hid core */
 			break;
 		case HID_DG_TOUCHSCREEN:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 773bcb1d4044..2e4498d52a2f 100644
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
-- 
2.14.3

