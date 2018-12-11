Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7220855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543951;
	bh=AY4xZHC5dhkWBgK+VCzRFjrJaePPW6CAmDlVRLDIHOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FdprK969CNAlJ07D9fmoSNMJEnq8jjUnYR0hhIiSm9Iula/j807e/OXDtRop16Pep
	 IOGYRBVFKUY+B/klv5y8jaiPElr2jg+AaVOVhvWL8VzTScVz8F0I9sL199MYVi5m5A
	 y8EmSg+5+TOVZm7AKXbPX+PJUT9YdlOotOHRyPKc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C7220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbeLKP7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:59:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730736AbeLKP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:59:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914D520855;
        Tue, 11 Dec 2018 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543946;
        bh=AY4xZHC5dhkWBgK+VCzRFjrJaePPW6CAmDlVRLDIHOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKP+ZcBZBNEnRGWoJ5cpIE6c4pQlkrYP6nUPr2Ngp9Tfn0R/d8NErd9IwD3YX1qS0
         s3NRp/KrPwugQ+PN8TGnMbdWVzz6RXAWjb+rCt/zHGTVXbwusbzU1NqEx9DEdHOYLt
         9LovkfdwugV6r/tcehoZR9w1Jyk9XIJP7YRHNiKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Nic=20Soud=C3=A9e?= <nsoudee@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4.19 118/118] HID: quirks: fix RetroUSB.com devices
Date:   Tue, 11 Dec 2018 16:42:17 +0100
Message-Id: <20181211151649.019105782@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nic Soudée <nsoudee@gmail.com>

commit 868613f1c0ccf7b832f38b48b18cca31cdeb3d26 upstream.

SNES RetroPort and RetroPad register only 4 gamepad buttons
when they should register all 8 buttons. This is described here:

https://ask.fedoraproject.org/en/question/128102

This is happening because of:

Commit 190d7f02ce8e ("HID: input: do not increment usages when
    duplicate is found")

Here, I add the quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE
(created for backward compatibility with the change in 190d7f02ce8e)
for the two products.

Tested with both RetroPort and RetroPad.

Cc: stable@vger.kernel.org  # v4.18+

Signed-off-by: Nic Soudée <nsoudee@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-ids.h    |    4 ++++
 drivers/hid/hid-quirks.c |    2 ++
 2 files changed, 6 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -934,6 +934,10 @@
 #define USB_VENDOR_ID_REALTEK		0x0bda
 #define USB_DEVICE_ID_REALTEK_READER	0x0152
 
+#define USB_VENDOR_ID_RETROUSB		0xf000
+#define USB_DEVICE_ID_RETROUSB_SNES_RETROPAD	0x0003
+#define USB_DEVICE_ID_RETROUSB_SNES_RETROPORT	0x00f1
+
 #define USB_VENDOR_ID_ROCCAT		0x1e7d
 #define USB_DEVICE_ID_ROCCAT_ARVO	0x30d4
 #define USB_DEVICE_ID_ROCCAT_ISKU	0x319c
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -136,6 +136,8 @@ static const struct hid_device_id hid_qu
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_RETROUSB, USB_DEVICE_ID_RETROUSB_SNES_RETROPAD), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_RETROUSB, USB_DEVICE_ID_RETROUSB_SNES_RETROPORT), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },


