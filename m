Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54875C32789
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2D4214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Lsq9lUfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2D4214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJJKJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:09:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44310 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJJKJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:09:25 -0400
Received: from garnet.amanokami.net (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6547D1C3D;
        Wed, 10 Oct 2018 04:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539139766;
        bh=LQaoT+rmlpkEpS2F515HIOIpAYO4V9yxI7kW1uHehsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lsq9lUfEgwo4coUIsp3ownL4+06BUij/gk556FxV34cGDNqj0IVRf0KjUL4QdchBT
         gLvQEbBFq3Gg/4M2LYy6vpbypu4o80hnMDhhV1jO8ZmYzV5AfA/rT1sE9iOq5ANXWT
         m1uVb3qGcYpJo5rJMJbiNmcMlYb3VE33ie9qEZic=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Subject: [PATCH 5/6] usb: musb: gadget: implement send_response
Date:   Tue,  9 Oct 2018 22:49:02 -0400
Message-Id: <20181010024903.1633-6-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181010024903.1633-1-paul.elder@ideasonboard.com>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a mechanism to signal the MUSB driver to reply to
a control OUT request with STALL or ACK.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/usb/musb/musb_gadget_ep0.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 91a5027b5c1f..f0ed1f7472a3 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -458,6 +458,25 @@ __acquires(musb->lock)
 	return handled;
 }
 
+static int ep0_send_response(struct musb *musb, bool stall)
+{
+	void __iomem *regs = musb->control_ep->regs;
+	u16 ackpend;
+
+	if (musb->ep0_state != MUSB_EP0_STAGE_RX &&
+	    musb->ep0_state != MUSB_EP0_STAGE_STATUSIN)
+		return -EINVAL;
+
+	ackpend = MUSB_CSR0_P_DATAEND
+		| MUSB_CSR0_P_SVDRXPKTRDY
+		| (stall ? MUSB_CSR0_P_SENDSTALL : 0);
+
+	musb_ep_select(musb->mregs, 0);
+	musb_writew(regs, MUSB_CSR0, ackpend);
+
+	return 0;
+}
+
 /* we have an ep0out data packet
  * Context:  caller holds controller lock
  */
@@ -466,10 +485,13 @@ static void ep0_rxstate(struct musb *musb)
 	void __iomem		*regs = musb->control_ep->regs;
 	struct musb_request	*request;
 	struct usb_request	*req;
+	struct usb_ep		*ep;
 	u16			count, csr;
+	bool			last_packet = false;
 
 	request = next_ep0_request(musb);
 	req = &request->request;
+	ep = &request->ep->end_point;
 
 	/* read packet and ack; or stall because of gadget driver bug:
 	 * should have provided the rx buffer before setup() returned.
@@ -492,6 +514,7 @@ static void ep0_rxstate(struct musb *musb)
 		if (count < 64 || req->actual == req->length) {
 			musb->ep0_state = MUSB_EP0_STAGE_STATUSIN;
 			csr |= MUSB_CSR0_P_DATAEND;
+			last_packet = true;
 		} else
 			req = NULL;
 	} else
@@ -508,6 +531,10 @@ static void ep0_rxstate(struct musb *musb)
 			return;
 		musb->ackpend = 0;
 	}
+
+	if (last_packet && ep->delayed_status)
+		return;
+
 	musb_ep_select(musb->mregs, 0);
 	musb_writew(regs, MUSB_CSR0, csr);
 }
@@ -991,6 +1018,19 @@ static int musb_g_ep0_dequeue(struct usb_ep *ep, struct usb_request *req)
 	return -EINVAL;
 }
 
+static int musb_g_ep0_send_response(struct usb_ep *e, bool stall)
+{
+	struct musb_ep *ep = to_musb_ep(e);
+	struct musb *musb = ep->musb;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&musb->lock, flags);
+	ret = ep0_send_response(musb, stall);
+	spin_unlock_irqrestore(&musb->lock, flags);
+	return ret;
+}
+
 static int musb_g_ep0_halt(struct usb_ep *e, int value)
 {
 	struct musb_ep		*ep;
@@ -1059,4 +1099,5 @@ const struct usb_ep_ops musb_g_ep0_ops = {
 	.queue		= musb_g_ep0_queue,
 	.dequeue	= musb_g_ep0_dequeue,
 	.set_halt	= musb_g_ep0_halt,
+	.send_response  = musb_g_ep0_send_response,
 };
-- 
2.18.0

