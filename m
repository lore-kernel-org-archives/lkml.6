Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BA12077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BA12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeIGPQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:16:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728183AbeIGPPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:15:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D363402315B;
        Fri,  7 Sep 2018 10:35:00 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F22D6A30C9;
        Fri,  7 Sep 2018 10:34:58 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Simon Wood <simon@mungewell.org>,
        Olivier Gay <ogay@logitech.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/7] HID: logitech-hidpp: support non-DJ receivers
Date:   Fri,  7 Sep 2018 12:34:46 +0200
Message-Id: <20180907103450.13890-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 10:35:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 10:35:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non unifying receivers are similar to a Unifying one, but not
entirely. They don't come with the DJ collections and thus can't be
handled by hid-logitech-dj.

To enable connection notifications, we need to instruct the receiver (0xff)
that we can handle those. Then, we need to retrieve the device index(es)
of the connected devices by manually enumerating the 6 available slots.
The two non DJ can actually handle two devices, one keyboard in slot
1 and one mouse in slot 2. The HID++ collection is in the second
interface, so we should be sure not to assign the attached keyboard
to the mouse input node. The proper keyboard matching will be added in
a following patch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 119 +++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d635e9685581..315ef209a0c4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -67,6 +67,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(26)
 #define HIDPP_QUIRK_HI_RES_SCROLL_X2120		BIT(27)
 #define HIDPP_QUIRK_HI_RES_SCROLL_X2121		BIT(28)
+#define HIDPP_QUIRK_RECEIVER			BIT(29)
 
 /* Convenience constant to check for any high-res support. */
 #define HIDPP_QUIRK_HI_RES_SCROLL	(HIDPP_QUIRK_HI_RES_SCROLL_1P0 | \
@@ -145,6 +146,7 @@ struct hidpp_device {
 	bool answer_available;
 	u8 protocol_major;
 	u8 protocol_minor;
+	u8 device_index;
 
 	void *private_data;
 
@@ -202,11 +204,7 @@ static int __hidpp_send_report(struct hid_device *hdev,
 		return -ENODEV;
 	}
 
-	/*
-	 * set the device_index as the receiver, it will be overwritten by
-	 * hid_hw_request if needed
-	 */
-	hidpp_report->device_index = 0xff;
+	hidpp_report->device_index = hidpp->device_index;
 
 	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
 		ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
@@ -458,6 +456,36 @@ static int hidpp10_enable_scrolling_acceleration(struct hidpp_device *hidpp_dev)
 	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_FEATURES, 0, 6);
 }
 
+/* Must be called with 0xff as device index */
+static int hidpp_unifying_enable_notifications(struct hidpp_device *hidpp_dev)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 params[3] = { 0 };
+
+	ret = hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_GENERAL,
+					NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	memcpy(params, response.rap.params, 3);
+
+	/* Set the wireless notification bit */
+	params[1] |= BIT(0);
+	params[1] |= BIT(3);
+
+	ret = hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_SET_REGISTER,
+					HIDPP_REG_GENERAL,
+					params, 3, &response);
+
+	return ret;
+}
+
 #define HIDPP_REG_BATTERY_STATUS			0x07
 
 static int hidpp10_battery_status_map_level(u8 param)
@@ -636,14 +664,41 @@ static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
 }
 
 #define HIDPP_REG_PAIRING_INFORMATION			0xB5
+#define HIDPP_PAIRING_INFORMATION			0x20
 #define HIDPP_EXTENDED_PAIRING				0x30
 #define HIDPP_DEVICE_NAME				0x40
 
-static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev)
+static inline bool hidpp_unifying_type_is_keyboard(u8 type)
+{
+	return type == 0x01;
+}
+
+static int hidpp_unifying_get_quadid(struct hidpp_device *hidpp_dev, int index,
+				     __be16 *quadid, u8 *type)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 params[1] = { HIDPP_PAIRING_INFORMATION | ((index - 1) & 0x0F) };
+
+	ret = hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_LONG_REGISTER,
+					HIDPP_REG_PAIRING_INFORMATION,
+					params, 1, &response);
+	if (ret)
+		return ret;
+
+	*quadid = get_unaligned_be16(&response.rap.params[3]);
+	*type = response.rap.params[7];
+
+	return ret;
+}
+
+static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev, int index)
 {
 	struct hidpp_report response;
 	int ret;
-	u8 params[1] = { HIDPP_DEVICE_NAME };
+	u8 params[1] = { HIDPP_DEVICE_NAME | ((index - 1) & 0x0F) };
 	char *name;
 	int len;
 
@@ -672,11 +727,12 @@ static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev)
 	return name;
 }
 
-static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, u32 *serial)
+static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, int index,
+				     u32 *serial)
 {
 	struct hidpp_report response;
 	int ret;
-	u8 params[1] = { HIDPP_EXTENDED_PAIRING };
+	u8 params[1] = { HIDPP_EXTENDED_PAIRING | ((index - 1) & 0x0F) };
 
 	ret = hidpp_send_rap_command_sync(hidpp,
 					REPORT_ID_HIDPP_SHORT,
@@ -699,23 +755,42 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	struct hid_device *hdev = hidpp->hid_dev;
 	const char *name;
 	u32 serial;
-	int ret;
+	u16 quadid, q;
+	int device_index, ret;
+	u8 type = 0;
+
+	device_index = 0;
+	quadid = hdev->product;
+
+	if (hidpp->quirks & HIDPP_QUIRK_RECEIVER) {
+		/*
+		 * On the receiver, the HID++ collection is on the mouse
+		 * interface, so match only there.
+		 */
+		ret = hidpp_unifying_get_quadid(hidpp, 2, &q, &type);
+		if (!ret && !hidpp_unifying_type_is_keyboard(type)) {
+			device_index = 2;
+			quadid = q;
+		}
+		hidpp_unifying_enable_notifications(hidpp);
+	}
 
-	ret = hidpp_unifying_get_serial(hidpp, &serial);
+	ret = hidpp_unifying_get_serial(hidpp, device_index, &serial);
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD", quadid, &serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
-	name = hidpp_unifying_get_name(hidpp);
+	name = hidpp_unifying_get_name(hidpp, device_index);
 	if (!name)
 		return -EIO;
 
 	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
 	dbg_hid("HID++ Unifying: Got name: %s\n", name);
 
+	hidpp->device_index = device_index;
+
 	kfree(name);
 	return 0;
 }
@@ -2800,6 +2875,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	struct hidpp_report *report = (struct hidpp_report *)data;
 	int ret;
 
+	if ((hidpp->quirks & HIDPP_QUIRK_RECEIVER) &&
+	    data[1] != hidpp->device_index)
+		return 0;
+
 	/*
 	 * If the mutex is locked then we have a pending answer from a
 	 * previously sent command.
@@ -3239,6 +3318,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
 		hidpp->quirks |= HIDPP_QUIRK_UNIFYING;
 
+	/*
+	 * set the device_index as the receiver, it will be overwritten by
+	 * hid_hw_request if needed
+	 */
+	hidpp->device_index = 0xFF;
+
 	if (disable_raw_mode) {
 		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
 		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
@@ -3426,11 +3511,13 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech Nano (non DJ) receiver */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
-			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER) },
+			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER),
+	  .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },
 
 	{ /* Logitech Nano (non DJ) receiver */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
-			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2) },
+			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2),
+	  .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },
 
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
-- 
2.14.3

