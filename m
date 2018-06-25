Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F117C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AF425466
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AF425466
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeFYFUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:20:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37954 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeFYFUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:20:16 -0400
Received: from 1.general.khfeng.uk.vpn ([10.172.196.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fXJv7-0004eB-Ka; Mon, 25 Jun 2018 05:20:10 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] usb: xhci: dbc: Don't decrement runtime PM counter if DBC is not started
Date:   Mon, 25 Jun 2018 13:20:04 +0800
Message-Id: <20180625052004.15298-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_put_sync() gets called everytime in xhci_dbc_stop().

If dbc is not started, this makes the runtime PM counter incorrectly
becomes 0, and calls autosuspend function. Then we'll keep seeing this:
[54664.762220] xhci_hcd 0000:00:14.0: Root hub is not suspended

So only calls pm_runtime_put_sync() when dbc was started.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-dbgcap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 1fbfd89d0a0f..387f124a8334 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -508,16 +508,18 @@ static int xhci_do_dbc_start(struct xhci_hcd *xhci)
 	return 0;
 }
 
-static void xhci_do_dbc_stop(struct xhci_hcd *xhci)
+static int xhci_do_dbc_stop(struct xhci_hcd *xhci)
 {
 	struct xhci_dbc		*dbc = xhci->dbc;
 
 	if (dbc->state == DS_DISABLED)
-		return;
+		return -1;
 
 	writel(0, &dbc->regs->control);
 	xhci_dbc_mem_cleanup(xhci);
 	dbc->state = DS_DISABLED;
+
+	return 0;
 }
 
 static int xhci_dbc_start(struct xhci_hcd *xhci)
@@ -544,6 +546,7 @@ static int xhci_dbc_start(struct xhci_hcd *xhci)
 
 static void xhci_dbc_stop(struct xhci_hcd *xhci)
 {
+	int ret;
 	unsigned long		flags;
 	struct xhci_dbc		*dbc = xhci->dbc;
 	struct dbc_port		*port = &dbc->port;
@@ -556,10 +559,11 @@ static void xhci_dbc_stop(struct xhci_hcd *xhci)
 		xhci_dbc_tty_unregister_device(xhci);
 
 	spin_lock_irqsave(&dbc->lock, flags);
-	xhci_do_dbc_stop(xhci);
+	ret = xhci_do_dbc_stop(xhci);
 	spin_unlock_irqrestore(&dbc->lock, flags);
 
-	pm_runtime_put_sync(xhci_to_hcd(xhci)->self.controller);
+	if (!ret)
+		pm_runtime_put_sync(xhci_to_hcd(xhci)->self.controller);
 }
 
 static void
-- 
2.17.0

