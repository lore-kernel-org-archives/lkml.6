Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321AC20645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975711;
	bh=8f48xnXwT00hMoT5H9kMZxf3mbQ6SF0A/uKZOc6hmLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6Fas/dWwHZL5bcba1ZMldN89NiVG+rGNT5GycQecX1GFbCdd0xu/T0YhKkU44Ef5
	 WZITkvr9FroTWOjmuUGP2dDetwe7P8zVwmgSdtIYg6EejVHd5SPNRHMzzhl1puvdyo
	 EQyBh/E4mftzDUE1KsgLiZGVIOp3UGulr35JFLzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfAHT2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730006AbfAHT2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB0E20827;
        Tue,  8 Jan 2019 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975703;
        bh=8f48xnXwT00hMoT5H9kMZxf3mbQ6SF0A/uKZOc6hmLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOSqHb1FgQ18LWqYrmmvwJWkIUURVQq5YVWSnRGidCE80GpRR3FuIvlHBSa1EvMqG
         se5Eq7gbKMj31yPXsSqntDa6SO0ex8I5XqLNn22+yiEdsRhlK4psgBNM0fvKk/8YhA
         UjbnBV5TSxJoGW7KAoJcBeXlvRQi6CXTiyAUhRP4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 065/117] usb: dwc2: Fix disable all EP's on disconnect
Date:   Tue,  8 Jan 2019 14:25:33 -0500
Message-Id: <20190108192628.121270-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minas Harutyunyan <minas.harutyunyan@synopsys.com>

[ Upstream commit 4fe4f9fecc36956fd53c8edf96dd0c691ef98ff9 ]

Disabling all EP's allow to reset EP's to initial state.
Introduced new function dwc2_hsotg_ep_disable_lock() which
before calling dwc2_hsotg_ep_disable() function acquire
hsotg->lock and release on exiting.
From dwc2_hsotg_ep_disable() function removed acquiring
hsotg->lock.
In dwc2_hsotg_core_init_disconnected() function when USB
reset interrupt asserted disabling all ep’s by
dwc2_hsotg_ep_disable() function.
This updates eliminating sparse imbalance warnings.

Reverted changes in dwc2_hostg_disconnect() function.
Introduced new function dwc2_hsotg_ep_disable_lock().
Changed dwc2_hsotg_ep_ops. Now disable point to
dwc2_hsotg_ep_disable_lock() function.
In functions dwc2_hsotg_udc_stop() and dwc2_hsotg_suspend()
dwc2_hsotg_ep_disable() function replaced by
dwc2_hsotg_ep_disable_lock() function.
In dwc2_hsotg_ep_disable() function removed acquiring
of hsotg->lock.

Fixes: dccf1bad4be7 ("usb: dwc2: Disable all EP's on disconnect")
Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 41 ++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 2d6d2c8244de..a00a56b4ae79 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3165,8 +3165,6 @@ static void kill_all_requests(struct dwc2_hsotg *hsotg,
 		dwc2_hsotg_txfifo_flush(hsotg, ep->fifo_index);
 }
 
-static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
-
 /**
  * dwc2_hsotg_disconnect - disconnect service
  * @hsotg: The device state.
@@ -3188,9 +3186,11 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
 	/* all endpoints should be shutdown */
 	for (ep = 0; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+			kill_all_requests(hsotg, hsotg->eps_in[ep],
+					  -ESHUTDOWN);
 		if (hsotg->eps_out[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+			kill_all_requests(hsotg, hsotg->eps_out[ep],
+					  -ESHUTDOWN);
 	}
 
 	call_gadget(hsotg, disconnect);
@@ -3234,6 +3234,7 @@ static void dwc2_hsotg_irq_fifoempty(struct dwc2_hsotg *hsotg, bool periodic)
 			GINTSTS_PTXFEMP |  \
 			GINTSTS_RXFLVL)
 
+static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
 /**
  * dwc2_hsotg_core_init - issue softreset to the core
  * @hsotg: The device state
@@ -4069,10 +4070,8 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 	struct dwc2_hsotg *hsotg = hs_ep->parent;
 	int dir_in = hs_ep->dir_in;
 	int index = hs_ep->index;
-	unsigned long flags;
 	u32 epctrl_reg;
 	u32 ctrl;
-	int locked;
 
 	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
 
@@ -4088,10 +4087,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 
 	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
 
-	locked = spin_is_locked(&hsotg->lock);
-	if (!locked)
-		spin_lock_irqsave(&hsotg->lock, flags);
-
 	ctrl = dwc2_readl(hsotg, epctrl_reg);
 
 	if (ctrl & DXEPCTL_EPENA)
@@ -4114,12 +4109,22 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 	hs_ep->fifo_index = 0;
 	hs_ep->fifo_size = 0;
 
-	if (!locked)
-		spin_unlock_irqrestore(&hsotg->lock, flags);
-
 	return 0;
 }
 
+static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep)
+{
+	struct dwc2_hsotg_ep *hs_ep = our_ep(ep);
+	struct dwc2_hsotg *hsotg = hs_ep->parent;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	ret = dwc2_hsotg_ep_disable(ep);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+	return ret;
+}
+
 /**
  * on_list - check request is on the given endpoint
  * @ep: The endpoint to check.
@@ -4267,7 +4272,7 @@ static int dwc2_hsotg_ep_sethalt_lock(struct usb_ep *ep, int value)
 
 static const struct usb_ep_ops dwc2_hsotg_ep_ops = {
 	.enable		= dwc2_hsotg_ep_enable,
-	.disable	= dwc2_hsotg_ep_disable,
+	.disable	= dwc2_hsotg_ep_disable_lock,
 	.alloc_request	= dwc2_hsotg_ep_alloc_request,
 	.free_request	= dwc2_hsotg_ep_free_request,
 	.queue		= dwc2_hsotg_ep_queue_lock,
@@ -4407,9 +4412,9 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	/* all endpoints should be shutdown */
 	for (ep = 1; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
 		if (hsotg->eps_out[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
 	}
 
 	spin_lock_irqsave(&hsotg->lock, flags);
@@ -4857,9 +4862,9 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
 
 		for (ep = 0; ep < hsotg->num_of_eps; ep++) {
 			if (hsotg->eps_in[ep])
-				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+				dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
 			if (hsotg->eps_out[ep])
-				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+				dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
 		}
 	}
 
-- 
2.19.1

