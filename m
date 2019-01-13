Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E290C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D7720657
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfAMLDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 06:03:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAMLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 06:03:05 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gidXf-0000n6-U9; Sun, 13 Jan 2019 11:03:00 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] staging: rtl8712u: Remove dummy reset-resume callback
Date:   Sun, 13 Jan 2019 19:02:53 +0800
Message-Id: <20190113110254.24721-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An USB wireless dongle uses rtl8712u stops working after system
suspend/resume.

When a USB device lost its power during suspend, the USB core knows the
power was lost and a reset-resume or a re-probe is required. But rtl8712u
provides a dummy reset-resume callback, which gets called and renders
the device dead after resume.

So remove the reset-resume call back, if power was lost during suspend,
let the USB core unbind and probe the device to solve the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/staging/rtl8712/usb_intf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 92d75d7c51ae..9cf2a798cfca 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -232,13 +232,6 @@ static int r871x_resume(struct usb_interface *pusb_intf)
 	rtl871x_intf_resume(padapter);
 	return 0;
 }
-
-static int r871x_reset_resume(struct usb_interface *pusb_intf)
-{
-	/* dummy routine */
-	return 0;
-}
-
 #endif
 
 static struct drv_priv drvpriv = {
@@ -249,7 +242,6 @@ static struct drv_priv drvpriv = {
 #ifdef CONFIG_PM
 	.r871xu_drv.suspend = r871x_suspend,
 	.r871xu_drv.resume = r871x_resume,
-	.r871xu_drv.reset_resume = r871x_reset_resume,
 #endif
 };
 
-- 
2.17.1

