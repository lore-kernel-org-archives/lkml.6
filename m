Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49688C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386720657
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfAMLDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 06:03:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49180 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAMLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 06:03:08 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gidXj-0000nI-Uu; Sun, 13 Jan 2019 11:03:04 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] staging: rtl8712u: Fix suspend and resume callbacks
Date:   Sun, 13 Jan 2019 19:02:54 +0800
Message-Id: <20190113110254.24721-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190113110254.24721-1-kai.heng.feng@canonical.com>
References: <20190113110254.24721-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system resume and the rtl8712u dongle didn't lose its power, it
doesn't work quite right:
[  146.844241] r8712u 2-3:1.0 wlp0s4f1u3: Unable to resume
...
[  154.029573] r8712u 2-3:1.0 wlp0s4f1u3: In r8711_wx_set_scan: bDriverStopped=1

The !netif_running() check in PM callbacks aren't correct because
rtl8712u doesn't support runtime suspend, so the when the PM ops get
called, it's system suspend or system resume, hence we want to "stop
everthing" or "resume everything".

The NULL check on pnetdev is also redundant, the only place pnetdev can
become NULL is the disconnect callback, which is mutually exclusive to
PM callbacks.

This can make rtl8712u starts working after system resume.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/staging/rtl8712/usb_intf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 9cf2a798cfca..005010de9997 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -196,10 +196,6 @@ static int r871x_suspend(struct usb_interface *pusb_intf, pm_message_t state)
 	struct _adapter *padapter = netdev_priv(pnetdev);
 
 	netdev_info(pnetdev, "Suspending...\n");
-	if (!pnetdev || !netif_running(pnetdev)) {
-		netdev_info(pnetdev, "Unable to suspend\n");
-		return 0;
-	}
 	padapter->bSuspended = true;
 	rtl871x_intf_stop(padapter);
 	if (pnetdev->netdev_ops->ndo_stop)
@@ -221,10 +217,6 @@ static int r871x_resume(struct usb_interface *pusb_intf)
 	struct _adapter *padapter = netdev_priv(pnetdev);
 
 	netdev_info(pnetdev,  "Resuming...\n");
-	if (!pnetdev || !netif_running(pnetdev)) {
-		netdev_info(pnetdev, "Unable to resume\n");
-		return 0;
-	}
 	netif_device_attach(pnetdev);
 	if (pnetdev->netdev_ops->ndo_open)
 		pnetdev->netdev_ops->ndo_open(pnetdev);
-- 
2.17.1

