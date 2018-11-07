Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1E0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78E920827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78E920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeKHByW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:54:22 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:47664 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727546AbeKHByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:54:21 -0500
Received: (qmail 3368 invoked by uid 2102); 7 Nov 2018 11:23:17 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Nov 2018 11:23:17 -0500
Date:   Wed, 7 Nov 2018 11:23:17 -0500 (EST)
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
In-Reply-To: <87r2fxtlrj.fsf@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.1811071049370.1542-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018, Felipe Balbi wrote:

> Hi,
> 
> Alan Stern <stern@rowland.harvard.edu> writes:
> >> Alan Stern <stern@rowland.harvard.edu> writes:
> >> > There's a similar race at the hardware level.  What happens if the
> >> > controller receives a new SETUP packet and concurrently the driver is
> >> > setting up the controller registers for a response to an earlier
> >> > SETUP?  I don't know how real controllers handle this.
> >> 
> >> That's HW implementation detail. DWC3, for instance, will ignore the
> >> TRBs and return me the status "setup packet pending". Then I just start
> >> a new SETUP TRB.
> >
> > You mean the UDC hardware sets a "setup pending" flag in some register,
> > and then ignores any attempts to do anything with ep0 until the driver
> > clears this flag?
> 
> Yes, except that the "flag" is a status on the TRB itself (TRB is dwc3's
> DMA transfer descriptor).

Hmmm.  So there must be a mechanism for the driver to tell the hardware 
that the endpoint's ring should start up again, right?  (I'm assuming 
the controller stops the ring when the SETUP is received, to avoid 
taking invalid actions for TRBs that are now out of date.)


> >> > Another thing we should do is give function drivers a way to send a
> >> > STALL response for the status stage.  Currently there's no way to do
> >> > it, if a data stage is present.
> >> 
> >> Status stage can only be stalled if host tries to move data on the wrong
> >> direction.
> >
> > The USB-2 spec disagrees.  See Table 8-7 in section 8.5.3.1 and the
> > following paragraphs.  (Although, I can't see why a function would ever
> > fail to complete the command sequence for a control-IN transfer after
> > the data had already been sent.)
> 
> I can't see how we could ever STALL after returning the data requested
> by the host. Seems like that wasn't well thought out.

Yes, it doesn't make a lot of sense.  However, STALLing the status
stage of a control-OUT transfer does make sense, so we should be able
to do it.  The obvious approach is to call ep0's set_halt() method
instead of submitting an explicit status request.


> > Checking the length isn't enough.  A data stage can have 0 length.
> 
> apologies, I meant wLength, like so:
> 
> 	len = le16_to_cpu(ctrl->wLength);
> 	if (!len) {
> 		dwc->three_stage_setup = false;
> 		dwc->ep0_expect_in = false;
> 		dwc->ep0_next_event = DWC3_EP0_NRDY_STATUS;
> 	} else {
> 		dwc->three_stage_setup = true;
> 		dwc->ep0_expect_in = !!(ctrl->bRequestType & USB_DIR_IN);
> 		dwc->ep0_next_event = DWC3_EP0_NRDY_DATA;
> 	}

Presumably you invert the value of ep0_expect_in and set ep0_next_event
to DWC3_EP0_NRDY_STATUS when the next (data-stage) request is submitted
for ep0.  Okay.

> special return values would be rendered uncessary if there's agreement
> that status stage is always explicit. Why would need
> USB_GADGET_DELAYED_STATUS if every case returns that?

Agreed.

> >> > There's also the fact that requests can specify a completion handler, but only 
> >> > the data stage request would see its completion handler called (unless we 
> >> > require UDCs to call completion requests at the completion of the status 
> >> > stage, but I'm not sure that all UDCs can report the event to the driver, and 
> >> > that would likely be useless as nobody needs that feature).
> >> 
> >> you still wanna know if the host actually processed your status
> >> stage. udc-core can (and should) provide a generic status stage
> >> completion function which, at a minimum, aids with some tracepoints.
> >
> > Helping with tracepoints is fine.  However, I don't think function 
> > drivers really need to know whether the status stage was processed by 
> > the host.  Can you point out any examples where such information would 
> > be useful?
> 
> If you know your STATUS stage completed, you have a guarantee that your
> previous control transfer is complete. It's a very clear signal that you
> should prepare for more control transfers.

That doesn't seem to make sense, because in reality you don't have
this guarantee.  Consider the following scenario: The host starts a
control-IN transfer.  You send the data-stage request succesfully and
then submit the status-stage request.  That request will complete
before the host receives the ACK for its 0-length status OUT
transaction.  In fact, the host may never receive that ACK and so the
transfer may never complete.

Besides, you don't need a signal (clear or otherwise) to prepare for
more control transfers.  You should start preparing as soon as the
status-stage request has been submitted.  At that point, what else is
there for you to do?

For that matter, you should be prepared to receive a new setup callback 
at any time.  The host doesn't have to wait for an old control transfer 
to complete before starting a new one.

I just don't see any value in knowing the completion code of a
status-stage request.

> >> > To simplify function drivers, do you think the above proposal of adding a flag 
> >> > to the (data stage) request to request an automatic transition to the status 
> >> > stage is a good idea ? We could even possibly invert the logic and transition 
> >> 
> >> no, I don't think so. Making the status phase always explicit is far
> >> better. UDCs won't have to check flags, or act on magic return
> >> values. It just won't do anything until a request is queued.
> >
> > I don't agree.  This would be a simple test in a localized area (the 
> > completion callback for control requests).  It could even be 
> > implemented by a library routine; the UDC driver would simply have to 
> > call this routine immediately after invoking the callback.
> 
> I don't follow what you mean here.

Suppose we have a core library routine like this:

void usb_gadget_control_complete(struct usb_gadget *gadget,
		unsigned int no_implicit_status, int status)
{
	struct usb_request *req;

	if (no_implicit_status || status != 0)
		return;

	/* Send an implicit status-stage request for ep0 */
	req = usb_ep_alloc_request(gadget->ep0, GFP_ATOMIC);
	if (req) {
		req->length = 0;
		req->no_implicit_status = 1;
		req->complete = /* req's deallocation routine */
		usb_ep_queue(gadget->ep0, req, GFP_ATOMIC);
	}
}

Then all a UDC driver would need to do is call 
usb_gadget_control_complete() after invoking a control request's 
completion handler.  The no_implicit_status and status arguments would 
be taken from the request that was just completed.

With this one call added to each UDC, all the existing function drivers
would work correctly.  Even though they don't explicitly queue
status-stage requests, the new routine will do so for them,
transparently.  Function drivers that want to handle their own
status-stage requests explicitly will merely have to set the
req->no_implicit_status bit.

(We might or might not need to watch out for 0-length control-OUT 
transfers.  Function drivers _do_ queue status-stage requests for 
those.)

Alan Stern

