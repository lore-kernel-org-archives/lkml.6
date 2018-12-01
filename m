Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E441C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0A32081C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrZ6ofSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0A32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbeLBGNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:13:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52766 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBGNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:13:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so2021999wmb.2;
        Sat, 01 Dec 2018 11:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=So2tL7z9HtsecapZEZBWjKWteM+02BoFNG78Jaulrho=;
        b=lrZ6ofSnHbxEW2Sm7CFpwZe8ohBQKnbgN0+vd/Y7/wGAmDffaJIVX2m/cxvwzJ72+z
         v2uLUS8d9pCaJNsnmspjCV8RT8fKzh9UmRo3AeqYZu/xNADh71eIILgiuBlmNYYvNw4W
         uYZ6s9j04/+6lDWachgA1Jtcw1a/VIYgPUtsUPnNtrl8nq0NQQt2XltmZWk6KSZw/UgZ
         an/Or3ub06GyZPjO26w4uLTQWLtmAQ10bzACzegeJP/0upt2w+0eFxkGHjoL7O+khDqF
         4wphmkNX7GdFI4moY3jaVGZf1aYVUToJbAd53JL9W7lDRh8PdcECeJF50Ru+zz0rGoTo
         0xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=So2tL7z9HtsecapZEZBWjKWteM+02BoFNG78Jaulrho=;
        b=ClTAnxAXBCP5CgpmBRS1Td/K57IiCeRmxGexi0RStlwTHxcO+XNF3nJQ6pbBg/fSjO
         j7LoQ+9qMiPk1h/AhCS2gpFAtcaWq6SGqBt60gChyl+qhrfj4NaPwXuoCmwWD7F3wS9w
         mXXobmWw8Jc+j+uggOcMbysNyo3A3jsrbGOvA35irM6PlttyosIJhVQSn/ny7uVxl+OC
         7xd6AppL+TXLiEydt2ECMm54+QnlecWnjjxW+FYDlljV1ierkqdPomnWylK9mEgI5ttw
         Lhwtld3IujKRqb53F4pM4ck78IfbDVw0WHa5QPvOx6yr9xMdtd7Aa/mERNZm+iqChKRK
         SfEg==
X-Gm-Message-State: AA+aEWau1AfLehiPMectKpRr0+SYREzvmAr8ZEdonBC+ZivtksayB7Ks
        J2i7UshvUVfMO9IkIGaMsZbrgibsRL0=
X-Google-Smtp-Source: AFSGD/VCdnL2IYPQWxxEJWGPVLEONHnrcls5+HuyBnZAklFU8l9caBQeZorgQqI0LFG4ozJD/x69+Q==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr3077102wmg.51.1543690841132;
        Sat, 01 Dec 2018 11:00:41 -0800 (PST)
Received: from arks.localdomain (36.red-88-18-46.staticip.rima-tde.net. [88.18.46.36])
        by smtp.gmail.com with ESMTPSA id j33sm15936859wre.91.2018.12.01.11.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 11:00:40 -0800 (PST)
Date:   Sat, 1 Dec 2018 20:01:53 +0100
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: asus: Add support for the ASUS T101HA keyboard dock
Message-ID: <20181201190153.GB4995@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS T101HA keyboard dock generates HID events using the ASUS vendor
specific UsagePage 0xff31. In consequence, some multimedia keys such as
brightness up and down are not working with hid-generic.

This commit adds the T101HA dock into the supported device list of the
hid-asus driver. It also prevents the dock's integrated touchpad to be
bound with hid-asus given that it is already working fine with
hid-multitouch.

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---

This is my very first kernel patch done in my free time (be aware of the
newbie!!) so please, let me know if I can improve anything and I will
happily do it :)

 drivers/hid/hid-asus.c | 12 ++++++++++++
 drivers/hid/hid-ids.h  |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ab8bd40a77ed..d8b55dca97c6 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -42,6 +42,7 @@ MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
 MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define T100_TPAD_INTF 2
+#define T101HA_TPAD_INTF 2
 
 #define T100CHI_MOUSE_REPORT_ID 0x06
 #define FEATURE_REPORT_ID 0x0d
@@ -70,6 +71,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_T100_KEYBOARD		BIT(6)
 #define QUIRK_T100CHI			BIT(7)
 #define QUIRK_G752_KEYBOARD		BIT(8)
+#define QUIRK_T101HA_DOCK		BIT(9)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -649,6 +651,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret;
 	struct asus_drvdata *drvdata;
 
+	if (id->driver_data & QUIRK_T101HA_DOCK) {
+		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+
+		/* use hid-multitouch for T101HA touchpad */
+		if (intf->altsetting->desc.bInterfaceNumber == T101HA_TPAD_INTF)
+			return -ENODEV;
+	}
+
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (drvdata == NULL) {
 		hid_err(hdev, "Can't alloc Asus descriptor\n");
@@ -830,6 +840,8 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
 	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD), QUIRK_T101HA_DOCK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4206428c0ba2..f1eee2778b70 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -184,6 +184,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD	0x17e0
 #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
 #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
+#define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
-- 
2.19.2

