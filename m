Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F334C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEF9214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfAITGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:06:33 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50414 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727722AbfAITGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:06:33 -0500
Received: (qmail 1361 invoked by uid 2102); 9 Jan 2019 14:06:31 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jan 2019 14:06:31 -0500
Date:   Wed, 9 Jan 2019 14:06:31 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
In-Reply-To: <20190109070856.27460-5-paul.elder@ideasonboard.com>
Message-ID: <Pine.LNX.4.44L0.1901091359020.1205-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Paul Elder wrote:

> A usb gadget function driver may or may not want to delay the status
> stage of a control OUT request. An instance where it might want to is to
> asynchronously validate the data of a class-specific request.
> 
> A function driver that wants an explicit status stage should set the
> newly added explicit_status flag of the usb_request corresponding to the
> data stage. Later on, the function driver can explicitly complete the
> status stage by enqueueing a usb_request for ACK, or calling
> usb_ep_set_halt() for STALL.
> 
> To support both explicit and implicit status stages, a UDC driver must
> call the newly added usb_gadget_control_complete function right before
> calling usb_gadget_giveback_request. To support the explicit status
> stage, it might then check what stage the usb_request was queued in, and
> for control IN ACK the host's zero-length data packet, or for control
> OUT send a zero-length DATA1 ACK packet.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> v4 Acked-by: Alan Stern <stern@rowland.harvard.edu>
> v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

This looks good and has passed my tests so far.  Can you check your uvc
changes using dummy_hcd with the patch below?

Alan Stern



Index: usb-4.x/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-4.x.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-4.x/drivers/usb/gadget/udc/dummy_hcd.c
@@ -88,6 +88,7 @@ struct dummy_ep {
 	unsigned			wedged:1;
 	unsigned			already_seen:1;
 	unsigned			setup_stage:1;
+	unsigned			status_stage:1;
 	unsigned			stream_en:1;
 };
 
@@ -1037,7 +1038,7 @@ static void init_dummy_udc_hw(struct dum
 		ep->ep.ops = &dummy_ep_ops;
 		list_add_tail(&ep->ep.ep_list, &dum->gadget.ep_list);
 		ep->halted = ep->wedged = ep->already_seen =
-				ep->setup_stage = 0;
+				ep->setup_stage = ep->status_stage = 0;
 		usb_ep_set_maxpacket_limit(&ep->ep, ~0);
 		ep->ep.max_streams = 16;
 		ep->last_io = jiffies;
@@ -1386,6 +1387,7 @@ static int transfer(struct dummy_hcd *du
 	struct dummy		*dum = dum_hcd->dum;
 	struct dummy_request	*req;
 	int			sent = 0;
+	bool			is_ep0 = (ep == &dum->ep[0]);
 
 top:
 	/* if there's no request queued, the device is NAKing; return */
@@ -1407,6 +1409,11 @@ top:
 		 * terminate reads.
 		 */
 		host_len = urb->transfer_buffer_length - urb->actual_length;
+		if (ep->status_stage)
+			host_len = 0;
+		else if (is_ep0 && host_len == 0)
+			ep->status_stage = 1;
+
 		dev_len = req->req.length - req->req.actual;
 		len = min(host_len, dev_len);
 
@@ -1471,6 +1478,12 @@ top:
 					req->req.status = 0;
 			}
 
+			/* Truncated control-IN => start the status stage */
+			if (*status == 0 && is_ep0 && !ep->status_stage) {
+				ep->status_stage = 1;
+				*status = -EINPROGRESS;
+			}
+
 		/*
 		 * many requests terminate without a short packet.
 		 * send a zlp if demanded by flags.
@@ -1486,6 +1499,8 @@ top:
 				if (urb->transfer_flags & URB_ZERO_PACKET &&
 				    !to_host)
 					rescan = 1;
+				else if (is_ep0 && !ep->status_stage)
+					ep->status_stage = rescan = 1;
 				else
 					*status = 0;
 			}
@@ -1496,6 +1511,9 @@ top:
 			list_del_init(&req->queue);
 
 			spin_unlock(&dum->lock);
+			if (is_ep0)
+				usb_gadget_control_complete(&dum->gadget,
+						&req->req);
 			usb_gadget_giveback_request(&ep->ep, &req->req);
 			spin_lock(&dum->lock);
 
@@ -1849,6 +1867,7 @@ restart:
 		ep->already_seen = 1;
 		if (ep == &dum->ep[0] && urb->error_count) {
 			ep->setup_stage = 1;	/* a new urb */
+			ep->status_stage = 0;
 			urb->error_count = 0;
 		}
 		if (ep->halted && !ep->setup_stage) {

