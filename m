Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093FDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7E520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7E520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeKGAQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:16:41 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36610 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388428AbeKGAQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:16:41 -0500
Received: (qmail 2264 invoked by uid 2102); 6 Nov 2018 09:51:06 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Nov 2018 09:51:06 -0500
Date:   Tue, 6 Nov 2018 09:51:06 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Felipe Balbi <balbi@kernel.org>
cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, <kieran.bingham@ideasonboard.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rogerq@ti.com>
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
In-Reply-To: <87d0riv4jw.fsf@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.1811060939160.1450-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018, Felipe Balbi wrote:

> DATA stage always depends on a usb_ep_queue() from gadget driver. So
> it's always "delayed" in that sense.

However, it's conceivable that some UDC drivers might behave 
differently depending on whether the usb_ep_queue call occurs within 
the setup callback or after that callback returns.  They _shouldn't_, 
but they might.

> it avoids all the special cases. UDC drivers can implement a single
> handling for struct usb_request. We could do away with special return
> values and so on...

It's not quite so simple, because the UDC driver will need to keep 
track of whether a request queued on ep0 should be in the IN or the OUT 
direction.  (Maybe they have to do this already, I don't know.)

> > request and the UDC would then need to check whether that request corresponds 
> > to a status stage and process it accordingly. A new operation specific to this 
> 
> no, it wouldn't. UDC would have to check the size of request, that's
> all:
> 
> 	if (r->length == 0)
>         	special_zlp_handling();
> 	else
>         	regular_non_zlp_handling();

Checking the length isn't enough.  A data stage can have 0 length.

> But we don't need to care about special return values and the like. We
> don't even need to care (from UDC perspective) if we're dealing with
> 2-stage or 3-stage control transfers (well, dwc3 needs to care because
> of different TRB types that needs to be used, but that's another story)

No, we do need to care because of the direction issue.

> > There's also the fact that requests can specify a completion handler, but only 
> > the data stage request would see its completion handler called (unless we 
> > require UDCs to call completion requests at the completion of the status 
> > stage, but I'm not sure that all UDCs can report the event to the driver, and 
> > that would likely be useless as nobody needs that feature).
> 
> you still wanna know if the host actually processed your status
> stage. udc-core can (and should) provide a generic status stage
> completion function which, at a minimum, aids with some tracepoints.

Helping with tracepoints is fine.  However, I don't think function 
drivers really need to know whether the status stage was processed by 
the host.  Can you point out any examples where such information would 
be useful?

> One way to satisfy what you want, with what I want is to have UDC core
> implement something like below:
> 
> int usb_ep_start_status_stage(struct usb_gadget *g)
> {
> 	return usb_ep_queue(g->ep0, &g->ep0_status_request);
> }
> 
> special function for you, usb_ep_queue() for me :-p

Sure, this is one of the options Laurent and I have discussed.

> >> (But it does involve a
> >> race in cases where the host gets tired of waiting and issues another
> >> SETUP packet before the processing of the first transfer is finished.)
> 
> Host would stall first in that case.

I don't follow.  Suppose the host sends a SETUP packet for an IN 
transfer, but the gadget takes so long to send the IN data back that 
the host times out.  So then the host sends a SETUP packet for a new 
transfer.  No stalls.

(Besides, hosts never send STALL packets anyway.  Only peripherals do.)

> Driver is already required to
> handle stalls for several other conditions. If thehre are bugs in that
> area, I'd prefer catching them.

> > To simplify function drivers, do you think the above proposal of adding a flag 
> > to the (data stage) request to request an automatic transition to the status 
> > stage is a good idea ? We could even possibly invert the logic and transition 
> 
> no, I don't think so. Making the status phase always explicit is far
> better. UDCs won't have to check flags, or act on magic return
> values. It just won't do anything until a request is queued.

I don't agree.  This would be a simple test in a localized area (the 
completion callback for control requests).  It could even be 
implemented by a library routine; the UDC driver would simply have to 
call this routine immediately after invoking the callback.

Alan Stern

