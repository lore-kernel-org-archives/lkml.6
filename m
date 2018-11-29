Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABC52147D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wEQ4I4lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABC52147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbeK3Beh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbeK3Beg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E211D2146F;
        Thu, 29 Nov 2018 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501743;
        bh=/AmGkwG5XlI6MXB3ymuR/AtaJIVJa9HBcjeVfh+3y8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wEQ4I4lQoGxB3EUxevcPNrEuETOF/MsdIkTkOvGqP9TCWHH1F6HMMyqzkkABaqkja
         jnrOf1Gw0wgV5baFNNTAOPZzEk4tOztbfq2S6a8FDZsaKWNhXogXWpPsdQJQooy/O2
         0OUB/hnXJ5HesO+BrfLBkJU8Fo2NpuXOppqDxVzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jack Pham <jackp@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 008/110] xhci: Fix leaking USB3 shared_hcd at xhci removal
Date:   Thu, 29 Nov 2018 15:11:39 +0100
Message-Id: <20181129135921.578477412@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit f068090426ea8d72c408ebd42953a82a88e2282c upstream.

Ensure that the shared_hcd pointer is valid when calling usb_put_hcd()

The shared_hcd is removed and freed in xhci by first calling
usb_remove_hcd(xhci->shared_hcd), and later
usb_put_hcd(xhci->shared_hcd)

Afer commit fe190ed0d602 ("xhci: Do not halt the host until both HCD have
disconnected their devices.") the shared_hcd was never properly put as
xhci->shared_hcd was set to NULL before usb_put_hcd(xhci->shared_hcd) was
called.

shared_hcd (USB3) is removed before primary hcd (USB2).
While removing the primary hcd we might need to handle xhci interrupts
to cleanly remove last USB2 devices, therefore we need to set
xhci->shared_hcd to NULL before removing the primary hcd to let xhci
interrupt handler know shared_hcd is no longer available.

xhci-plat.c, xhci-histb.c and xhci-mtk first create both their hcd's before
adding them. so to keep the correct reverse removal order use a temporary
shared_hcd variable for them.
For more details see commit 4ac53087d6d4 ("usb: xhci: plat: Create both
HCDs before adding them")

Fixes: fe190ed0d602 ("xhci: Do not halt the host until both HCD have disconnected their devices.")
Cc: Joel Stanley <joel@jms.id.au>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
Cc: <stable@vger.kernel.org>
Reported-by: Jack Pham <jackp@codeaurora.org>
Tested-by: Jack Pham <jackp@codeaurora.org>
Tested-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-histb.c |    6 ++++--
 drivers/usb/host/xhci-mtk.c   |    6 ++++--
 drivers/usb/host/xhci-pci.c   |    1 +
 drivers/usb/host/xhci-plat.c  |    6 ++++--
 drivers/usb/host/xhci-tegra.c |    1 +
 drivers/usb/host/xhci.c       |    2 --
 6 files changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/usb/host/xhci-histb.c
+++ b/drivers/usb/host/xhci-histb.c
@@ -325,14 +325,16 @@ static int xhci_histb_remove(struct plat
 	struct xhci_hcd_histb *histb = platform_get_drvdata(dev);
 	struct usb_hcd *hcd = histb->hcd;
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	struct usb_hcd *shared_hcd = xhci->shared_hcd;
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	usb_remove_hcd(xhci->shared_hcd);
+	usb_remove_hcd(shared_hcd);
+	xhci->shared_hcd = NULL;
 	device_wakeup_disable(&dev->dev);
 
 	usb_remove_hcd(hcd);
-	usb_put_hcd(xhci->shared_hcd);
+	usb_put_hcd(shared_hcd);
 
 	xhci_histb_host_disable(histb);
 	usb_put_hcd(hcd);
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -590,12 +590,14 @@ static int xhci_mtk_remove(struct platfo
 	struct xhci_hcd_mtk *mtk = platform_get_drvdata(dev);
 	struct usb_hcd	*hcd = mtk->hcd;
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
 
-	usb_remove_hcd(xhci->shared_hcd);
+	usb_remove_hcd(shared_hcd);
+	xhci->shared_hcd = NULL;
 	device_init_wakeup(&dev->dev, false);
 
 	usb_remove_hcd(hcd);
-	usb_put_hcd(xhci->shared_hcd);
+	usb_put_hcd(shared_hcd);
 	usb_put_hcd(hcd);
 	xhci_mtk_sch_exit(mtk);
 	xhci_mtk_clks_disable(mtk);
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -356,6 +356,7 @@ static void xhci_pci_remove(struct pci_d
 	if (xhci->shared_hcd) {
 		usb_remove_hcd(xhci->shared_hcd);
 		usb_put_hcd(xhci->shared_hcd);
+		xhci->shared_hcd = NULL;
 	}
 
 	/* Workaround for spurious wakeups at shutdown with HSW */
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -359,14 +359,16 @@ static int xhci_plat_remove(struct platf
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct clk *clk = xhci->clk;
 	struct clk *reg_clk = xhci->reg_clk;
+	struct usb_hcd *shared_hcd = xhci->shared_hcd;
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	usb_remove_hcd(xhci->shared_hcd);
+	usb_remove_hcd(shared_hcd);
+	xhci->shared_hcd = NULL;
 	usb_phy_shutdown(hcd->usb_phy);
 
 	usb_remove_hcd(hcd);
-	usb_put_hcd(xhci->shared_hcd);
+	usb_put_hcd(shared_hcd);
 
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1240,6 +1240,7 @@ static int tegra_xusb_remove(struct plat
 
 	usb_remove_hcd(xhci->shared_hcd);
 	usb_put_hcd(xhci->shared_hcd);
+	xhci->shared_hcd = NULL;
 	usb_remove_hcd(tegra->hcd);
 	usb_put_hcd(tegra->hcd);
 
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -719,8 +719,6 @@ static void xhci_stop(struct usb_hcd *hc
 
 	/* Only halt host and free memory after both hcds are removed */
 	if (!usb_hcd_is_primary_hcd(hcd)) {
-		/* usb core will free this hcd shortly, unset pointer */
-		xhci->shared_hcd = NULL;
 		mutex_unlock(&xhci->mutex);
 		return;
 	}


