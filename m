Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25812C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80CD21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DLTiKGka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfAXDCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:02:54 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52924 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfAXDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:02:50 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B5122F5;
        Thu, 24 Jan 2019 04:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548298968;
        bh=jK9l6KTbRd/p2CLZjYqss5k9r6Xs5TVksT3qoRQaUbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLTiKGkaqBzTpO2S/LFs1cSuEOE3E109/tAp1vEeMr1fSpQ04DEj9YjAJJG5mBE4v
         qLIZxAANU3tceHJl9SvkwLHgwAPmmMCfwgWo9RKVWgrXFOrl5jGrtEY9Al98M+t2vR
         w6nGlz3JmavKU5JQr/dRUDEji+U+6HV51hxLrS+c=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/6] usb: musb: gadget: implement optional explicit status stage
Date:   Wed, 23 Jan 2019 22:02:27 -0500
Message-Id: <20190124030228.19840-6-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124030228.19840-1-paul.elder@ideasonboard.com>
References: <20190124030228.19840-1-paul.elder@ideasonboard.com>
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
Changes from v6:

- check that the request queued for the status stage of a control
  OUT request has zero length

Changes from v5:

- giveback usb request to gadget driver after enqueueing for the status
  stage

Changes from v4:

- call usb_gadget_control_complete before usb_gadget_giveback_request
- set musb ep0 state to statusin in ep0_send_ack
- make sure to not double-write musb register in ep0_rxstate, since
  musb_g_ep0_giveback will take care of writing them

No change from v3

Changes from v2:
- update call to usb_gadget_control_complete to include status
- since sending STALL from the function driver is now done with
  usb_ep_set_halt, there is no need for the internal ep0_send_response to
  take a stall/ack parameter; remove the parameter and make the function
  only send ack, and remove checking for the status reply in the
  usb_request for the status stage

Changes from v1:
- obvious change to implement v2 mechanism laid out by 4/6 of this
  series (send_response, and musb_g_ep0_send_response function has
  been removed, call to usb_gadget_control_complete has been added)
- ep0_send_response's ack argument has been changed from stall
- last_packet flag in ep0_rxstate has been removed, since it is equal to
  req != NULL

 drivers/usb/musb/musb_gadget.c     |  2 ++
 drivers/usb/musb/musb_gadget_ep0.c | 36 ++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index ffe462a657b1..2a36bebf955d 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -144,6 +144,8 @@ __acquires(ep->musb->lock)
 		unmap_dma_buffer(req, musb);
 
 	trace_musb_req_gb(req);
+	if (req->ep->end_point.address == 0)
+		usb_gadget_control_complete(&musb->g, &req->request);
 	usb_gadget_giveback_request(&req->ep->end_point, &req->request);
 	spin_lock(&musb->lock);
 	ep->busy = busy;
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 91a5027b5c1f..e6531ebe789e 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -458,6 +458,25 @@ __acquires(musb->lock)
 	return handled;
 }
 
+static int ep0_send_ack(struct musb *musb)
+{
+	void __iomem *regs = musb->control_ep->regs;
+	u16 csr;
+
+	if (musb->ep0_state != MUSB_EP0_STAGE_RX &&
+	    musb->ep0_state != MUSB_EP0_STAGE_STATUSIN)
+		return -EINVAL;
+
+	csr = MUSB_CSR0_P_DATAEND | MUSB_CSR0_P_SVDRXPKTRDY;
+
+	musb_ep_select(musb->mregs, 0);
+	musb_writew(regs, MUSB_CSR0, csr);
+
+	musb->ep0_state = MUSB_EP0_STAGE_STATUSIN;
+
+	return 0;
+}
+
 /* we have an ep0out data packet
  * Context:  caller holds controller lock
  */
@@ -504,12 +523,15 @@ static void ep0_rxstate(struct musb *musb)
 	if (req) {
 		musb->ackpend = csr;
 		musb_g_ep0_giveback(musb, req);
+		if (req->explicit_status)
+			return;
 		if (!musb->ackpend)
 			return;
 		musb->ackpend = 0;
+	} else {
+		musb_ep_select(musb->mregs, 0);
+		musb_writew(regs, MUSB_CSR0, csr);
 	}
-	musb_ep_select(musb->mregs, 0);
-	musb_writew(regs, MUSB_CSR0, csr);
 }
 
 /*
@@ -937,6 +959,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	case MUSB_EP0_STAGE_RX:		/* control-OUT data */
 	case MUSB_EP0_STAGE_TX:		/* control-IN data */
 	case MUSB_EP0_STAGE_ACKWAIT:	/* zero-length data */
+	case MUSB_EP0_STAGE_STATUSIN:
 		status = 0;
 		break;
 	default:
@@ -978,6 +1001,15 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	} else if (musb->ackpend) {
 		musb_writew(regs, MUSB_CSR0, musb->ackpend);
 		musb->ackpend = 0;
+
+	/* status stage of OUT with data, issue IN status, then giveback */
+	} else if (musb->ep0_state == MUSB_EP0_STAGE_STATUSIN) {
+		if (req->request.length)
+			status = -EINVAL;
+		else {
+			status = ep0_send_ack(musb);
+			musb_g_ep0_giveback(ep->musb, r);
+		}
 	}
 
 cleanup:
-- 
2.20.1

