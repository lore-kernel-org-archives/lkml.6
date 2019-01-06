Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A2BC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B92720665
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LmeJUL0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfAFQCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:02:50 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54912 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfAFQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:02:46 -0500
Received: from localhost.localdomain (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CFE43BB9;
        Sun,  6 Jan 2019 17:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1546790564;
        bh=aT4DqHvI03yWEuNNCJuWMO7H2olZIVUJCWVfSGVTFJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmeJUL0zfdR9U9PWSdCcmHUteDhOx5yY1z6Y6hrTggBqokfsN416ykTE717JGW0F7
         txsrB1LaOr6A0Yppu7dQ30D4GXa9fAyCE06IUbj6nquOYC6ZeIFXGluViAfTPj2tkG
         Bbb27vJTLBIHi5mZwSeESEtLli1r/qOVXQriYHQk=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] usb: musb: gadget: implement optional explicit status stage
Date:   Sun,  6 Jan 2019 11:02:20 -0500
Message-Id: <20190106160221.4480-6-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190106160221.4480-1-paul.elder@ideasonboard.com>
References: <20190106160221.4480-1-paul.elder@ideasonboard.com>
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
 drivers/usb/musb/musb_gadget_ep0.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index d3f33f449445..a7a992ab0c9d 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -145,6 +145,8 @@ __acquires(ep->musb->lock)
 
 	trace_musb_req_gb(req);
 	usb_gadget_giveback_request(&req->ep->end_point, &req->request);
+	usb_gadget_control_complete(&musb->g, request->explicit_status,
+			request->status);
 	spin_lock(&musb->lock);
 	ep->busy = busy;
 }
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 91a5027b5c1f..bbce8a9d77e4 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -458,6 +458,23 @@ __acquires(musb->lock)
 	return handled;
 }
 
+static int ep0_send_ack(struct musb *musb)
+{
+	void __iomem *regs = musb->control_ep->regs;
+	u16 ackpend;
+
+	if (musb->ep0_state != MUSB_EP0_STAGE_RX &&
+	    musb->ep0_state != MUSB_EP0_STAGE_STATUSIN)
+		return -EINVAL;
+
+	ackpend = MUSB_CSR0_P_DATAEND | MUSB_CSR0_P_SVDRXPKTRDY;
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
@@ -504,10 +521,13 @@ static void ep0_rxstate(struct musb *musb)
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
@@ -939,6 +959,9 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	case MUSB_EP0_STAGE_ACKWAIT:	/* zero-length data */
 		status = 0;
 		break;
+	case MUSB_EP0_STAGE_STATUSIN:
+		status = ep0_send_ack(musb);
+		goto cleanup;
 	default:
 		musb_dbg(musb, "ep0 request queued in state %d",
 				musb->ep0_state);
-- 
2.19.2

