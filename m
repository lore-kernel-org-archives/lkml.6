Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034453AbeE1PcW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032113AbeE1KS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:18:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Youn <johnyoun@synopsys.com>,
        Vardan Mikayelyan <mvardan@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 080/268] usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()
Date: Mon, 28 May 2018 12:00:54 +0200
Message-Id: <20180528100211.176621780@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vardan Mikayelyan <mvardan@synopsys.com>

[ Upstream commit 755d739534f998d92e348fba8ffb0478416576e7 ]

We should call dwc2_hsotg_enqueue_setup() after properly
setting lx_state. Because it may cause error-out from
dwc2_hsotg_enqueue_setup() due to wrong value in lx_state.

Issue can be reproduced by loading driver while connected
A-Connector (start in A-HOST mode) then disconnect A-Connector
to switch to B-DEVICE.

Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: Vardan Mikayelyan <mvardan@synopsys.com>
Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/gadget.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2424,12 +2424,6 @@ void dwc2_hsotg_core_init_disconnected(s
 	dwc2_writel(dwc2_hsotg_ep0_mps(hsotg->eps_out[0]->ep.maxpacket) |
 	       DXEPCTL_USBACTEP, hsotg->regs + DIEPCTL0);
 
-	dwc2_hsotg_enqueue_setup(hsotg);
-
-	dev_dbg(hsotg->dev, "EP0: DIEPCTL0=0x%08x, DOEPCTL0=0x%08x\n",
-		dwc2_readl(hsotg->regs + DIEPCTL0),
-		dwc2_readl(hsotg->regs + DOEPCTL0));
-
 	/* clear global NAKs */
 	val = DCTL_CGOUTNAK | DCTL_CGNPINNAK;
 	if (!is_usb_reset)
@@ -2440,6 +2434,12 @@ void dwc2_hsotg_core_init_disconnected(s
 	mdelay(3);
 
 	hsotg->lx_state = DWC2_L0;
+
+	dwc2_hsotg_enqueue_setup(hsotg);
+
+	dev_dbg(hsotg->dev, "EP0: DIEPCTL0=0x%08x, DOEPCTL0=0x%08x\n",
+		dwc2_readl(hsotg->regs + DIEPCTL0),
+		dwc2_readl(hsotg->regs + DOEPCTL0));
 }
 
 static void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg)
