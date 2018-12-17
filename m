Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1D620675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HGWhB+TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeLQGDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:03:00 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53906 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731478AbeLQGC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:02:57 -0500
Received: from localhost.localdomain (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDF51E4C;
        Mon, 17 Dec 2018 07:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545026576;
        bh=1cO5OcvmM7RlA7UDmMxrJSgFT3YVDjBpi+db/Hv7iDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGWhB+TN985fN5UH32G7NAIE2MA2YRCFzRRxNNzo9U3WZfGyHGxp2Ui8IuUGcqgcc
         4UuM0YbApEo8jHCDDR9ohhpRPkeb+Y6m+YznOPXMn48tQaeFmzIvvj2LuR+UfT+BQE
         LL2p9p5XJDpqh+KhCw0QJhlul6+aSuFu3YFxCs/Y=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] usb: musb: gadget: implement optional explicit status stage
Date:   Mon, 17 Dec 2018 01:02:15 -0500
Message-Id: <20181217060216.26368-6-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217060216.26368-1-paul.elder@ideasonboard.com>
References: <20181217060216.26368-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the mechanism for optional explicit status stage for the MUSB
driver. This allows a function driver to specify what to reply for the
status stage. The functionality for an implicit status stage is
retained.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
v1 Acked-by: Bin Liu <b-liu@ti.com>
---
Changes from v1:
- obvious change to implement v2 mechanism laid out by 4/6 of this
  series (send_response, and musb_g_ep0_send_response function has
  been removed, call to usb_gadget_control_complete has been added)
- ep0_send_response's ack argument has been changed from stall
- last_packet flag in ep0_rxstate has been removed, since it is equal to
  req != NULL

 drivers/usb/musb/musb_gadget.c     |  1 +
 drivers/usb/musb/musb_gadget_ep0.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index d3f33f449445..d83315dd22b2 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -145,6 +145,7 @@ __acquires(ep->musb->lock)
 
 	trace_musb_req_gb(req);
 	usb_gadget_giveback_request(&req->ep->end_point, &req->request);
+	usb_gadget_control_complete(&musb->g, request->explicit_status);
 	spin_lock(&musb->lock);
 	ep->busy = busy;
 }
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 91a5027b5c1f..b3da48f4c63c 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -458,6 +458,25 @@ __acquires(musb->lock)
 	return handled;
 }
 
+static int ep0_send_response(struct musb *musb, bool ack)
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
+		| (ack ? 0 : MUSB_CSR0_P_SENDSTALL);
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
@@ -504,10 +523,13 @@ static void ep0_rxstate(struct musb *musb)
 	if (req) {
 		musb->ackpend = csr;
 		musb_g_ep0_giveback(musb, req);
+		if (req->explicit_status)
+			return;
 		if (!musb->ackpend)
 			return;
 		musb->ackpend = 0;
 	}
+
 	musb_ep_select(musb->mregs, 0);
 	musb_writew(regs, MUSB_CSR0, csr);
 }
@@ -939,6 +961,12 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	case MUSB_EP0_STAGE_ACKWAIT:	/* zero-length data */
 		status = 0;
 		break;
+	case MUSB_EP0_STAGE_STATUSIN:
+		if (r->explicit_status)
+			status = ep0_send_response(musb, r->zero);
+		else
+			status = ep0_send_response(musb, 1);
+		goto cleanup;
 	default:
 		musb_dbg(musb, "ep0 request queued in state %d",
 				musb->ep0_state);
-- 
2.19.2

