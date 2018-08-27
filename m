Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA68C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F9B208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F9B208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH0Xum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:50:42 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54882 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH0Xum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:50:42 -0400
Received: by mail-pl1-f201.google.com with SMTP id k17-v6so22496pll.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 13:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qOPJ1Lm/VEOOwFL6Aumtpuxb4QZ0lauwOVoD8FNkv2Q=;
        b=FJ1y9CKw0jyo1IHqNPZj5fbWYUkcni3kPcNSeU43vzzFna0ZkMAUxAnERUfbXR2c3i
         75uKrcvkrm1qCSqYFc4asI2cz+FhXFUDRuzvEzgudG5Y+QANPw0wvq1wBFfu8yfUYKwn
         EY8yFYG9ocwMi9BigI/NS3WESesmHkb7LOaQJc3PzllFTnBVwMfbdE2cqgNnK8G+u1Xl
         vs6XAT12BORNVy/xzRqwsJ6/S10I9INrAvnYFrGPZ1jGQqRXMnkKvGHRklA/58aiFOAL
         q5m+6PLTR2XEbXcZ4dFqfFjV/qdxruHv5byMRNzilJVJtDSGXsVpgKXkzHu3+sS+Ibh9
         sTwA==
X-Gm-Message-State: APzg51DFRLOhmCmHkWHyA+EwEf9wljA1UCVmwkHGTc1v6zmry9P0FGOO
        QTnkepO088oZiMWFQ/mZSP6AKUFjdmC+yA==
X-Google-Smtp-Source: ANB0Vdb9ETRlp8dIe/CXq4BS9txPvZ7F5VzhSWTNpLc1LFDt3M+oz2tlTfnwdSKDB3s1g0N7ONhNB8wWcteIZA==
X-Received: by 2002:a63:d74e:: with SMTP id w14-v6mr80085pgi.105.1535400157357;
 Mon, 27 Aug 2018 13:02:37 -0700 (PDT)
Date:   Mon, 27 Aug 2018 13:02:15 -0700
Message-Id: <20180827200215.172838-1-seobrien@chromium.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH] [v2] HID: add support for Apple Magic Keyboards
From:   "Sean O'Brien" <seobrien@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB device
	Vendor 05ac (Apple)
	Device 026c (Magic Keyboard with Numeric Keypad)

Bluetooth devices
	Vendor 004c (Apple)
	Device 0267 (Magic Keyboard)
	Device 026c (Magic Keyboard with Numeric Keypad)

Support already exists for the Magic Keyboard over USB connection.
Add support for the Magic Keyboard over Bluetooth connection, and for
the Magic Keyboard with Numeric Keypad over Bluetooth and USB
connection.

Signed-off-by: Sean O'Brien <seobrien@chromium.org>
---

 drivers/hid/hid-apple.c | 9 ++++++++-
 drivers/hid/hid-ids.h   | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 25b7bd56ae11..1cb41992aaa1 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -335,7 +335,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	if (usage->hid == (HID_UP_CUSTOM | 0x0003)) {
+	if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
+			usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
 		/* The fn key on Apple USB keyboards */
 		set_bit(EV_REP, hi->input->evbit);
 		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
@@ -472,6 +473,12 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
 		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
+		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 79bdf0c7e351..5dbe3fb82690 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -88,6 +88,7 @@
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
 
 #define USB_VENDOR_ID_APPLE		0x05ac
+#define BT_VENDOR_ID_APPLE		0x004c
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 #define USB_DEVICE_ID_APPLE_MAGICMOUSE	0x030d
 #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD	0x030e
@@ -157,6 +158,7 @@
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

