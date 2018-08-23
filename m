Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446D8208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446D8208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeHWM05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:26:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbeHWM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:26:57 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2E853C83;
        Thu, 23 Aug 2018 08:58:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 165/324] usb: xhci: dbc: Dont decrement runtime PM counter if DBC is not started
Date:   Thu, 23 Aug 2018 09:53:51 +0200
Message-Id: <20180823075004.329838866@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 74cb319bd97dd62881f97ea5a3228f7c2546bf56 ]

pm_runtime_put_sync() gets called everytime in xhci_dbc_stop().

If dbc is not started, this makes the runtime PM counter incorrectly
becomes 0, and calls autosuspend function. Then we'll keep seeing this:
[54664.762220] xhci_hcd 0000:00:14.0: Root hub is not suspended

So only calls pm_runtime_put_sync() when dbc was started.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-dbgcap.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -507,16 +507,18 @@ static int xhci_do_dbc_start(struct xhci
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
@@ -543,6 +545,7 @@ static int xhci_dbc_start(struct xhci_hc
 
 static void xhci_dbc_stop(struct xhci_hcd *xhci)
 {
+	int ret;
 	unsigned long		flags;
 	struct xhci_dbc		*dbc = xhci->dbc;
 	struct dbc_port		*port = &dbc->port;
@@ -555,10 +558,11 @@ static void xhci_dbc_stop(struct xhci_hc
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


