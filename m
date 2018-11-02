Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1382EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26D72081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26D72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeKCB0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:26:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37440 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726707AbeKCB0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:26:24 -0400
Received: (qmail 3249 invoked by uid 2102); 2 Nov 2018 12:18:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Nov 2018 12:18:45 -0400
Date:   Fri, 2 Nov 2018 12:18:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
cc:     Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, <kieran.bingham@ideasonboard.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rogerq@ti.com>
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
In-Reply-To: <1864168.qYyPzk9PJV@avalon>
Message-ID: <Pine.LNX.4.44L0.1811021050190.1469-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018, Laurent Pinchart wrote:

> Hi Felipe,
> 
> On Friday, 2 November 2018 15:17:20 EET Felipe Balbi wrote:
> > Laurent Pinchart writes:
> > >>>>> +void usb_ep_delay_status(struct usb_ep *ep)
> > >>>>> 
> > >>>>> +{
> > >>>>> +	ep->delayed_status = true;
> > >>>>> +}
> > >>>>> +EXPORT_SYMBOL_GPL(usb_ep_delay_status);
> > >>>> 
> > >>>> Is usb_ep_set_delay_status() better? I thought it implies get/return
> > >>>> action if a verb is missing in the function name.
> > >>> 
> > >>> For what it's worth, I understand the function name as "delay the
> > >>> status stage", with "delay" being a verb. Maybe the short description
> > >>> could be updated accordingly.
> > >>> 
> > >>> Is there a reason for adding a new function for this?  This is exactly
> > >>> what the USB_GADGET_DELAYED_STATUS return value from the setup callback
> > >>> is meant for (and it is already used by some gadget drivers).
> > >> 
> > >> In theory, we might be able to use USB_GADGET_DELAYED_STATUS for this.
> > >> However, there are a few ambiguities that prevent us from doing so.
> > >> 
> > >> First of all, we want to delay only the status stage for control OUT
> > >> requests; according to composite.h, USB_GADGET_DELAYED_STATUS is for
> > >> delaying the "data/status stages". Does this mean that it delays the
> > >> status stage only or does it delay both stages? If the slash means
> > >> "and", then we cannot use USB_GADGET_DELAYED_STATUS.

The comment in composite.h is wrong; it should refer only to the status
stage.  In fact, it should refer only to the status stage for
control-OUT transfers; there's no reason ever to delay the status stage
of a control-IN transfer (the driver should instead delay the data
stage if it needs to).

> > >> Furthermore, we have found that USB_GADGET_DELAYED_STATUS is racey,
> > >> which has already been observed in the UVC gadget driver previously [0].
> > >> The raceiness stems from the fact that things can happen in between
> > >> returning USB_GADGET_DELAYED_STATUS and the composite layer reacting to
> > >> it - especially if usb_composite_setup_continue is called within that
> > >> window it causes a WARN. In any case, the fact that the mechanism itself
> > >> is racey suggests that it needs improvement, and using it wouldn't be a
> > >> good solution in this case.

I don't understand this at all.  The composite layer reacts to 
USB_GADGET_DELAYED_STATUS as soon as it receives the return value.  Can 
Paul or Laurent give a more explicit example of this race?

Assuming you are correct, wouldn't it make sense to fix or eliminate 
the race by changing composite.c?

> > >>> Is it a question of when the gadget driver learns that it will need to
> > >>> delay the status stage?  If that's the case,
> > >> 
> > >> Not really.
> > >> 
> > >>> why not always return
> > >>> USB_GADGET_DELAYED_STATUS from the setup callback?  Then instead of
> > >>> calling usb_ep_delay_status() when a delay is needed, you could queue
> > >>> the status request when a delay isn't needed.
> > >> 
> > >> Theoretically this might work, but see the problems mentioned above.
> > >> 
> > >>> As a more general solution, Felipe has said that a UDC driver should
> > >>> _never_ carry out the status stage transaction until the gadget driver
> > >>> has told it to do so.  Then there would be no need for any sort of
> > >>> delay indicator.
> > >> 
> > >> Yeah, but,
> > >> 
> > >>> (But implementing this would require significant
> > >>> changes to a bunch of different drivers...)
> > >> 
> > >> exactly :/
> > 
> > add a flag to gadget structure. Something like
> > "supports_explicit_status_stage" and add a new return value
> > USB_EXPLICIT_STATUS_STAGE.
> > 
> > Then, take uvc for example, implement the new setup:
> > 
> > if (supports_explicit_status_stage)
> > 	return USB_EXPLICIT_STATUS_STAGE;
> > 
> > then on dwc3 you would:
> > 
> > switch (ret) {
> > case USB_EXPLICIT_STATUS_STAGE:
> > case USB_GADGET_DELAYED_STATUS:
> > 	wait_for_status_request_queue();
> >         break;
> > default:
> > 	start_status_stage();
> > }
> > 
> > If this works with dwc3 + uvc, then we have a good recipe on how to
> > implement for the other drivers.
> 
> Given that we need to delay the status stage and not the data stage, we can't 
> explicitly request the status stage through a usb request queue.

Why not?  The status stage for a control-OUT transfer is simply a
zero-length IN transaction.  It's easy to queue a request for such a
transaction.  Is the issue that there's no way to specify the direction
of the request (hence no direct way to tell whether a zero-length
request is for the data stage or the status stage)?

Admittedly, it might be nice to provide a library routine in the UDC
core to queue such requests, since it involves a bunch of uninteresting
boilerplate operations.

> Would a new 
> explicit function call work for you for that purpose ?

It would be okay, but I question whether one is really needed.

> > > Alan, Felipe, how do we move forward with this ? There are several issues
> > > with the existing control request handling mechanism in the USB gadget
> > > stack, and while Paul could work on improving the mechanism, we need to
> > > provide clear guidance regarding the direction we want to take.
> > > 
> > > For reference, the issues I know about for the USB_GADGET_DELAYED_STATUS
> > > mechanism are
> > > 
> > > - The mechanism is inherently racy. It relies on signaling the delay at
> > > the very end of the processing in the setup handler, which by definition
> > > occurs after the work to process the control request is queued (in the
> > > generic sense, regardless of whether this involves a kernel workqueue or
> > > passing the work to userspace). There is thus a race window after queuing
> > > the work and before signaling the delay during which the work handler
> > > could signal completion.

I'm not at all sure what you're talking about here.  Do you mean this 
code near the end of composite_setup()?

check_value:
	/* respond with data transfer before status phase? */
	if (value >= 0 && value != USB_GADGET_DELAYED_STATUS) {
		req->length = value;
		req->context = cdev;
		req->zero = value < w_length;
		value = composite_ep0_queue(cdev, req, GFP_ATOMIC);

Plainly the code checks for USB_GADGET_DELAYED_STATUS _before_ queuing 
req, not after.  So where's the race?

> > We won't fix this until all functions and UDCs are converted over, but
> > it's doable.
> 
> It could be fixed by signaling the delay through an explicit function call 
> before queueing the work instead of through a return value though, but I agree 
> that long term requesting the status stage explicitly would likely be cleaner.

Yes, I agree that relying on an implicit status stage is not a good 
idea for the long term.

> > > - The mechanism is poorly documented. As Paul mentioned, comments in the
> > > code state that USB_GADGET_DELAYED_STATUS delay the "data/status stages".
> > > This is very unclear, and the only three UDCs that implement the
> > > mechanism seem to do so in different ways:

We can fix comments and documentation pretty easily.  :-)

> > >   - The mtu driver states in a comment that it will "handle the delay
> > >   STATUS phase till receive ep_queue on ep0".
> > > 
> > >   - The bdc driver states in a comment that "The ep0 state will remain
> > >   WAIT_FOR_DATA_START till we received ep_queue on ep0".
> > > 
> > >   - The dwc3 driver seems to handle USB_GADGET_DELAYED_STATUS for the
> > >   SET_CONFIG request only.
> > 
> > that's the only one that has needed it so far. I'm all for making status
> > stage ALWAYS explicit, that will, in the long run, simplify UDC
> > drivers and make the API easier to understand.
> > 
> > > - The mechanism relies on queueing a request to the UDC to signal that it
> > > should continue with the status stage. That request can be queued either
> > > by the USB gadget function driver directly, or by the composite layer in
> > > usb_composite_setup_continue() (the latter is restricted to requests that
> > > carry no data as it sets the request length to 0). This is problematic if
> > > we want to delay the status phase after completing the data phase, in
> > > order to validate the setup phase data and the data phase data (for a
> > > control OUT request) together.
> > 
> > It shouldn't cause problems, actually. Most of the issues come from the
> > fact that sometimes gadget driver just returns a success and expects UDC
> > to initiate status stage and sometimes gadget driver wants to handle
> > status stage explicitly.
> 
> Requesting the status stage explicitly requires an API to do so (quite 
> obviously). Your proposal is to use the usb request queue as a signal to 
> continue to the next stage. My point is that this can't work for control OUT 
> requests, where we may want to delay the status stage after the data is 
> received by the UDC, and thus after the request is queued. We need a different 
> API for that.

Why so?  Consider the following logic for ep0 in the UDC:

	A SETUP packet is received, for an OUT transfer.

	If setup.wLength > 0 then the next request queued for ep0 is
	the data stage, so it is an OUT request.

	Otherwise (i.e., if setup.wLength == 0 or for the second
	request queued after the SETUP is received), the next request
	is the status stage, so it must be a 0-length IN request.

This requires the UDC to specifically keep track of the direction of
the current transfer and whether or not a data-stage transfer has
already been queued.  That shouldn't be hard.  (But it does involve a
race in cases where the host gets tired of waiting and issues another
SETUP packet before the processing of the first transfer is finished.)

The corresponding logic for IN transfers is simpler, since IN transfers 
are not allowed to have zero length.  The first request following the 
SETUP packet is the data stage and the second is the status stage.

> For control IN, we may want to delay the data stage if we can't respond 
> directly, or proceed with the data stage immediately. In both cases this can 
> be signaled by a request being queued. There is no need to delay the status 
> stage as it's initiated by the host.

Yes.

> For control OUT, we may want to delay the data stage if we need to validate 
> the setup stage data asynchronously. Proceeding to the data stage can be 
> signaled by queueing a request. We may also want to delay the status stage if 
> we need to validate the data stage data asynchronously. This can't be signaled 
> by queueing a request.

It can be, if we use the logic outlined above.

> I wonder if there's really a use case for delaying the data stage of control 
> OUT requests, as it seems to me that we can perform the asynchronous 
> validation of the setup and data stages together, in which case we would 
> always proceed to the data stage, and only potentially delay the status stage. 
> However, if we switch to an explicit API where the transition from the setup 
> to the data stage is triggered by queueing a request, and given that such a 
> transition may need to be delayed for the control IN case, delaying the data 
> stage for control OUT would essentially come for free.
> 
> In any case we need an API to delay the status stage of a control OUT request. 
> There are two options here. We can consider that the status stage shouldn't be 
> delayed by default and add a new function to be called from the data stage 
> completion handler to request a status stage delay (using the return value of 
> the completion handler isn't a good idea as it would be racy as explained 
> above). A second function would be needed to request the status stage (which, 
> as explained above too, can't be done by queueing a request). A second option 
> is to consider that the status stage is delayed by default until explcitly 
> required. In both cases the same new function is needed to request the status 
> stage.
> 
> Note that delaying the data stage and delaying the status stage are two 
> different problems, and don't necessarily need to be solved together. However, 
> if I understand things correctly, we currently delay the data stage of a few 
> control OUT requests (they all have a 0 bytes data stage) as a mean to 
> completion of the request. I believe that this use case could be implemented 
> by delaying the status stage instead, so the two are still related in a way.
> 
> If we end up moving to explicit state handling, with the data stage being 
> entered by queueing a request, and the status stage being entered by calling a 
> new function, control OUT requests with 0 bytes of data that can be handled 
> synchronously in the setup handler would require function drivers to both 
> queue a zero-length request and call the status function. This would make the 
> function code more complex, and I wonder whether a shortcut would be a good 
> idea, perhaps in the form of a flag in the request that tells the UDC to 
> automatically proceed to the status stage immediately after the data stage. Or 
> we could make that behaviour the default when the request doesn't have a 
> completion handler (as moving explicitly to the status stage should be done at 
> the earliest from the data stage completion handler).
> 
> > > For those reasons I think a new mechanism is needed. It should either
> > > signal the status phase delay through an explicit function call instead
> > > of a return value (to solve the race mentioned above), or by requiring
> > > all requests to be explicitly completed (but that will require changing
> > > all USB function drivers). Furthermore, the mechanism need to support
> > > delaying the status phase after queuing the request for the data phase,
> > > so we need an explicit way to signal that the UDC should proceed with the
> > > status phase, other than queueing the request.
> > > 
> > > Thoughts ? Preferences ?
> > 
> > how about making status stage always explicit?
> 
> If we implement a proof of concept, could you help us converting drivers over 
> to the new API ? I'll assume we'll have to address all UDCs first, and then 
> the function drivers.

I'll certainly help for the drivers I'm familiar with.

Alan Stern

