Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D4FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E297420868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E297420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeKZDtO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:49:14 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21839 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKZDtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:49:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1543165061; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=jfeZXOWZhfy188x06IYs26fULeE8FXk2TyAVY4Cd5MYhoMrTOcLtNdKaSBvGA4zUHIeuwYT0Ug4jIO5A1vsDPe9+m5sxRZ9YvZ7rVHhQFCgum0AfvLAKfNiXSdhCIDJl3RPvk7wXierh4j4wUIHtcaLQEgQL1qNHsDb3D1O3OjE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1543165061; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=7NX2E9WRbjbCE7YQ45f2VflH8nz/0PVhz2mQ6sstecY=; 
        b=Ry63FiTehbN3rCTaukcQ9sWgM76mv3b0cEPreH6UXtg/FVYtEotujp36zfaLsJvs+9mKYiJ3/Ysw0Hf8c5drgc7IZSpdDGw1mf3DmJiZSyNP2msWmNhrmJSdB8wfz5Co6pixTRgypyM/SKXl+lKv2p4wvt+qaz1FbP7IsuxvAS8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1543165058645856.8186003044875; Sun, 25 Nov 2018 08:57:38 -0800 (PST)
Message-ID: <d90d4827c192c43aa3b2f53af17f0b04d6f2f250.camel@mniewoehner.de>
Subject: [PATCH] usb: core: quirks: add RESET_RESUME quirk for Cherry G230
 Stream series
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 25 Nov 2018 17:57:33 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cherry G230 Stream 2.0 (G85-231) and 3.0 (G85-232) need this quirk to
function correctly. This fixes a but where double pressing numlock locks
up the device completely with need to replug the keyboard.

Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f9ff03e6a..0690fcff0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -209,6 +209,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Microsoft LifeCam-VX700 v2.0 */
 	{ USB_DEVICE(0x045e, 0x0770), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Cherry Stream G230 2.0 (G85-231) and 3.0 (G85-232) */
+	{ USB_DEVICE(0x046a, 0x0023), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0841), .driver_info = USB_QUIRK_DELAY_INIT },


