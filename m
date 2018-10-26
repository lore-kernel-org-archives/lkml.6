Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48908C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ED520824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8ED520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeJZOIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 10:08:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54402 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJZOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 10:08:55 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gFukJ-0002cZ-SU; Fri, 26 Oct 2018 05:33:20 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] USB: quirks: Add no-lpm quirk for Raydium touchscreens
Date:   Fri, 26 Oct 2018 13:33:15 +0800
Message-Id: <20181026053315.32188-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raydium USB touchscreen fails to set config if LPM is enabled:
[    2.030658] usb 1-8: New USB device found, idVendor=2386, idProduct=3119
[    2.030659] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.030660] usb 1-8: Product: Raydium Touch System
[    2.030661] usb 1-8: Manufacturer: Raydium Corporation
[    7.132209] usb 1-8: can't set config #1, error -110

Same behavior can be observed on 2386:3114.

Raydium claims the touchscreen supports LPM under Windows, so I used
Microsoft USB Test Tools (MUTT) [1] to check its LPM status. MUTT shows
that the LPM doesn't work under Windows, either. So let's just disable LPM
for Raydium touchscreens.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/usbcon/usb-test-tools

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/quirks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 178d6c6063c0..99f525ac4b2e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -411,6 +411,11 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* Raydium Touchscreen */
+	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
+
+	{ USB_DEVICE(0x2386, 0x3119), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
-- 
2.19.1

