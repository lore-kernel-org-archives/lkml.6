Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C904D20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBDSFIds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C904D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeHaCAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:00:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38324 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbeHaCAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:00:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so4493059pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rfg9rzUuVH60O1UxfmaDA50ly54WqIEeTGdSH0qZedo=;
        b=jBDSFIdsNFgf07jX7/BSm57CebfNJqzTKc8JtFNuVGTaHfsIzBXelTqIqkJAdjNsD6
         BD60X6IGBOpLUt3uCJDkM+O0kugzwToXPijABaCXgOxo3loFgycmoPY8QtSPa1LNuWWz
         7B4HyHJf9+/4770rN4D8RFPbsraMBTDtZxqWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rfg9rzUuVH60O1UxfmaDA50ly54WqIEeTGdSH0qZedo=;
        b=MSE2AIyddIph9opMnWOPSw/epuRM180LKuKI+Hw7O5SqHO2vHwSnszkNBKJPjxLUdt
         ScIn9wdt0omN7JWGFWs1nACxoME2BuwOTIoKOLjdJZAX2HQ5CSk2iKMZHqTr3D/6MgnO
         oewyAdDEe69PLc2BesFLVIZWcBX0pXWajXPn26CrAXZK5M5F0v6htxMCH5Vgzet8Amqf
         MgWza2TtD8llndtplklvZImkGdlLThq/PZhKvmGQj0K17B178j86XIKy6TYat+l5jsdZ
         KGPdxZtJAaJu39eLC+lKMdJOh1ZWkiujfly+s31zlKRSArbcULUqJ9lCarpEqDPpQPk0
         poew==
X-Gm-Message-State: APzg51CVYh8Vgwx7apa0jOPx0NVLd7jy1jinqVIVAYOk+mIrPq9SnH5V
        et+wkMPmh5M3Bixx666dY/SwCg==
X-Google-Smtp-Source: ANB0VdZ1AnKQkcVAqlSIPxYIYysZ/EtSTB1QT71LfcuX81JVI7olzs7qouw5xrQNdcvB0RUDVrbeVA==
X-Received: by 2002:a62:2285:: with SMTP id p5-v6mr12472726pfj.53.1535666192116;
        Thu, 30 Aug 2018 14:56:32 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id h132-v6sm13516828pfc.100.2018.08.30.14.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:56:31 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH v2 5/5] Use LDJ_DEVICE macro for existing Logitech mice
Date:   Thu, 30 Aug 2018 14:56:22 -0700
Message-Id: <20180830215622.47550-6-hcutts@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
References: <20180830215622.47550-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

Changes in v2:
* Changed the REL_WHEEL_HI_RES code to use micrometres (a.k.a. microns)
  as its units, instead of 256ths of a millimetre.
* Removed support for mice connecting over Bluetooth, due to a bug where
  the mouse's high-res mode and the driver's settings get out of sync
  when the mouse is power cycled.
* Moved the creation of the HID++ 1.0 function and the refactor to use
  the LDJ_DEVICE macro into separate patches.
* Added a couple of explanatory comments to the Logitech driver.

 drivers/hid/hid-logitech-hidpp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index fd6a8c325fa0..5f0c080059c6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3314,13 +3314,11 @@ static void hidpp_remove(struct hid_device *hdev)
 
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4011),
+	  LDJ_DEVICE(0x4011),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT |
 			 HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS },
 	{ /* wireless touchpad T650 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4101),
+	  LDJ_DEVICE(0x4101),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
@@ -3360,16 +3358,13 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Mouse Logitech Performance MX */
 	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Keyboard logitech K400 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4024),
+	  LDJ_DEVICE(0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
 	{ /* Solar Keyboard Logitech K750 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4002),
+	  LDJ_DEVICE(0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
 
-	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
+	{ LDJ_DEVICE(HID_ANY_ID) },
 
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

