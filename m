Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C33C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ED62082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NnXqRetM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ED62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeKCCSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:18:39 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48778 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCCSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:18:39 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A5A81263;
        Fri,  2 Nov 2018 18:10:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541178645;
        bh=N2Vtu/m22G3w60MPHjNcl8TEMOraOVx3sOXRq4nJZb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnXqRetMJ02sTQ1NPbVUmlqksf18I1dWfzjhpbq6deUU7VsoUQ7xo+GKvqe8r0R41
         LAS3ZPwaBlj089B/y4ior/KlhiM6AKnj9WJqhguniu2yUQ08fgiNQf4bupjoEip9NO
         1J9Cdu+QaCQgY9edP+5vfYOA4IqLr4MKywvE41Gk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, kieran.bingham@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
Date:   Fri, 02 Nov 2018 19:10:53 +0200
Message-ID: <3595344.euAgJ7Kpbg@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <Pine.LNX.4.44L0.1811021050190.1469-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1811021050190.1469-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Friday, 2 November 2018 18:18:45 EET Alan Stern wrote:
> On Fri, 2 Nov 2018, Laurent Pinchart wrote:
> > On Friday, 2 November 2018 15:17:20 EET Felipe Balbi wrote:
> >> Laurent Pinchart writes:
> >>>>>>> +void usb_ep_delay_status(struct usb_ep *ep)
> >>>>>>> 
> >>>>>>> +{
> >>>>>>> +	ep->delayed_status = true;
> >>>>>>> +}
> >>>>>>> +EXPORT_SYMBOL_GPL(usb_ep_delay_status);
> >>>>>> 
> >>>>>> Is usb_ep_set_delay_status() better? I thought it implies
> >>>>>> get/return action if a verb is missing in the function name.
> >>>>> 
> >>>>> For what it's worth, I understand the function name as "delay the
> >>>>> status stage", with "delay" being a verb. Maybe the short
> >>>>> description could be updated accordingly.
> >>>>> 
> >>>>> Is there a reason for adding a new function for this?  This is
> >>>>> exactly what the USB_GADGET_DELAYED_STATUS return value from the setup
> >>>>> callback is meant for (and it is already used by some gadget drivers).
> >>>> 
> >>>> In theory, we might be able to use USB_GADGET_DELAYED_STATUS for
> >>>> this. However, there are a few ambiguities that prevent us from doing
> >>>> so.
> >>>> 
> >>>> First of all, we want to delay only the status stage for control OUT
> >>>> requests; according to composite.h, USB_GADGET_DELAYED_STATUS is for
> >>>> delaying the "data/status stages". Does this mean that it delays the
> >>>> status stage only or does it delay both stages? If the slash means
> >>>> "and", then we cannot use USB_GADGET_DELAYED_STATUS.
> 
> The comment in composite.h is wrong; it should refer only to the status
> stage.  In fact, it should refer only to the status stage for
> control-OUT transfers; there's no reason ever to delay the status stage
> of a control-IN transfer (the driver should instead delay the data
> stage if it needs to).

Agreed.

> >>>> Furthermore, we have found that USB_GADGET_DELAYED_STATUS is racey,
> >>>> which has already been observed in the UVC gadget driver previously
> >>>> [0]. The raceiness stems from the fact that things can happen in
> >>>> between returning USB_GADGET_DELAYED_STATUS and the composite layer
> >>>> reacting to it - especially if usb_composite_setup_continue is called
> >>>> within that window it causes a WARN. In any case, the fact that the
> >>>> mechanism itself is racey suggests that it needs improvement, and using
> >>>> it wouldn't be a good solution in this case.
> 
> I don't understand this at all.  The composite layer reacts to
> USB_GADGET_DELAYED_STATUS as soon as it receives the return value.  Can
> Paul or Laurent give a more explicit example of this race?

The composite layer only handles USB_GADGET_DELAYED_STATUS for 
USB_REQ_SET_CONFIGURATION (in set_config()) and for USB_REQ_SET_INTERFACE (in 
composite_setup()). It increments cdev->delayed_status immediately. Then, in 
usb_composite_setup_continue(), if cdev->delayed_status is not zero, it queues 
a ZLP, and warns otherwise.

This mechanism delays the data stage, not the status stage (or, to be precise, 
it delays the status stage insofar as the status stage comes after the data 
stage), and only supports control OUT requests with 0 bytes of data (which is 
the case of both USB_REQ_SET_INTERFACE and USB_REQ_SET_CONFIGURATION). For all 
other requests, the composite layer passes USB_GADGET_DELAYED_STATUS to the 
UDC.

The three UDCs that implement USB_GADGET_DELAYED_STATUS support set a 
delayed_status flag in an internal structure. I haven't inspected in details 
what they do next as I'm not familiar with all of them, but the dwc3 driver 
just skips the handling of the status phase in dwc3_ep0_xfernotready() and 
delays it to __dwc3_gadget_ep0_queue(). This only works for 0-length requests, 
with no data phase.

Even when limited to 0-length control OUT requests, this mechanism is racy. 
The setup handler, when it wants to delay the status phase, will queue 
asynchronous work that will, when it completes, call 
usb_composite_setup_continue() to proceed with the status phase. Queuing the 
work has to be done before the setup handler returns, and the cdev-
>delayed_status is only incremented after the setup handler returns, in 
composite_setup(). There is thus a time window during which the asynchronous 
work can call usb_composite_setup_continue() before cdev->delayed_status has 
been incremented. We have managed to hit this in practice, with a surprisingly 
high rate seeing how small the window is.

Now that I've written all this, I realize that cdev->delayed_status is guarded 
by cdev->lock. I thus wonder whether our analysis was correct, or if we were 
hitting a different bug :-S Paul, could you test this again ? Please note, 
however, that the race described here is not related to this patch series, 
except in how it influences the API design to avoid race conditions.

> Assuming you are correct, wouldn't it make sense to fix or eliminate
> the race by changing composite.c?

I was about to write that we would need to lock access to cdev-
>delayed_status, and found out that we already use cdev->lock to do so. More 
investigations are needed.

Please note, however, that USB_GADGET_DELAYED_STATUS is limited to 0-length 
control OUT requests, so the problem that led to this patch series still 
exists, even if the race condition I thought was there doesn't exist.

> >>>>> Is it a question of when the gadget driver learns that it will need
> >>>>> to delay the status stage?  If that's the case,
> >>>> 
> >>>> Not really.
> >>>> 
> >>>>> why not always return
> >>>>> USB_GADGET_DELAYED_STATUS from the setup callback?  Then instead of
> >>>> calling usb_ep_delay_status() when a delay is needed, you could
> >>>>> queue the status request when a delay isn't needed.
> >>>> 
> >>>> Theoretically this might work, but see the problems mentioned above.
> >>>> 
> >>>>> As a more general solution, Felipe has said that a UDC driver should
> >>>>> _never_ carry out the status stage transaction until the gadget
> >>>>> driver has told it to do so.  Then there would be no need for any sort
> >>>>> of delay indicator.
> >>>> 
> >>>> Yeah, but,
> >>>> 
> >>>>> (But implementing this would require significant
> >>>>> changes to a bunch of different drivers...)
> >>>> 
> >>>> exactly :/
> >> 
> >> add a flag to gadget structure. Something like
> >> "supports_explicit_status_stage" and add a new return value
> >> USB_EXPLICIT_STATUS_STAGE.
> >> 
> >> Then, take uvc for example, implement the new setup:
> >> 
> >> if (supports_explicit_status_stage)
> >> 
> >> 	return USB_EXPLICIT_STATUS_STAGE;
> >> 
> >> then on dwc3 you would:
> >> 
> >> switch (ret) {
> >> case USB_EXPLICIT_STATUS_STAGE:
> >> 
> >> case USB_GADGET_DELAYED_STATUS:
> >> 	wait_for_status_request_queue();
> >> 	
> >>         break;
> >> 
> >> default:
> >> 	start_status_stage();
> >> 
> >> }
> >> 
> >> If this works with dwc3 + uvc, then we have a good recipe on how to
> >> implement for the other drivers.
> > 
> > Given that we need to delay the status stage and not the data stage, we
> > can't explicitly request the status stage through a usb request queue.
> 
> Why not?  The status stage for a control-OUT transfer is simply a
> zero-length IN transaction.  It's easy to queue a request for such a
> transaction.  Is the issue that there's no way to specify the direction
> of the request (hence no direct way to tell whether a zero-length
> request is for the data stage or the status stage)?

OK, I suppose we could queue a request for this, in which case we would have 
to queue two requests for control OUT transfers (one for the data stage and 
one for the status stage). I'm however not convinced that would be the best 
API to handle the status stage, as the function driver would need to queue a 
request and the UDC would then need to check whether that request corresponds 
to a status stage and process it accordingly. A new operation specific to this 
would be easier for both the function driver and the UDC in my opinion. 
There's also the fact that requests can specify a completion handler, but only 
the data stage request would see its completion handler called (unless we 
require UDCs to call completion requests at the completion of the status 
stage, but I'm not sure that all UDCs can report the event to the driver, and 
that would likely be useless as nobody needs that feature).

> Admittedly, it might be nice to provide a library routine in the UDC
> core to queue such requests, since it involves a bunch of uninteresting
> boilerplate operations.
> 
> > Would a new explicit function call work for you for that purpose ?
> 
> It would be okay, but I question whether one is really needed.

I think the API would be cleaner, but it might just be a matter of taste.

> >>> Alan, Felipe, how do we move forward with this ? There are several
> >>> issues with the existing control request handling mechanism in the USB
> >>> gadget stack, and while Paul could work on improving the mechanism, we
> >>> need to provide clear guidance regarding the direction we want to
> >>> take.
> >>> 
> >>> For reference, the issues I know about for the USB_GADGET_DELAYED_STATUS
> >>> mechanism are
> >>> 
> >>> - The mechanism is inherently racy. It relies on signaling the delay
> >>> at the very end of the processing in the setup handler, which by
> >>> definition occurs after the work to process the control request is
> >>> queued (in the generic sense, regardless of whether this involves a
> >>> kernel workqueue or passing the work to userspace). There is thus a race
> >>> window after queuing the work and before signaling the delay during
> >>> which the work handler could signal completion.
> 
> I'm not at all sure what you're talking about here.  Do you mean this
> code near the end of composite_setup()?
> 
> check_value:
> 	/* respond with data transfer before status phase? */
> 	if (value >= 0 && value != USB_GADGET_DELAYED_STATUS) {
> 		req->length = value;
> 		req->context = cdev;
> 		req->zero = value < w_length;
> 		value = composite_ep0_queue(cdev, req, GFP_ATOMIC);
> 
> Plainly the code checks for USB_GADGET_DELAYED_STATUS _before_ queuing
> req, not after.  So where's the race?

Please see above.

> >> We won't fix this until all functions and UDCs are converted over, but
> >> it's doable.
> > 
> > It could be fixed by signaling the delay through an explicit function call
> > before queueing the work instead of through a return value though, but I
> > agree that long term requesting the status stage explicitly would likely
> > be cleaner.
> 
> Yes, I agree that relying on an implicit status stage is not a good
> idea for the long term.
> 
> >>> - The mechanism is poorly documented. As Paul mentioned, comments in
> >>> the code state that USB_GADGET_DELAYED_STATUS delay the "data/status
> >>> stages". This is very unclear, and the only three UDCs that implement
> >>> the mechanism seem to do so in different ways:
> 
> We can fix comments and documentation pretty easily.  :-)

It's harder to fix them if different implementations interpret them in 
different ways :-) That might not be the case though, as mentioned above I 
haven't studied the three UDCs that implement this in details, I only had a 
look at the dwc3.

> >>>   - The mtu driver states in a comment that it will "handle the delay
> >>>   STATUS phase till receive ep_queue on ep0".
> >>>   
> >>>   - The bdc driver states in a comment that "The ep0 state will remain
> >>>   WAIT_FOR_DATA_START till we received ep_queue on ep0".
> >>>   
> >>>   - The dwc3 driver seems to handle USB_GADGET_DELAYED_STATUS for the
> >>>   SET_CONFIG request only.
> >> 
> >> that's the only one that has needed it so far. I'm all for making status
> >> stage ALWAYS explicit, that will, in the long run, simplify UDC
> >> drivers and make the API easier to understand.
> >> 
> >>> - The mechanism relies on queueing a request to the UDC to signal that
> >>> it should continue with the status stage. That request can be queued
> >>> either by the USB gadget function driver directly, or by the composite
> >>> layer in usb_composite_setup_continue() (the latter is restricted to
> >>> requests that carry no data as it sets the request length to 0). This is
> >>> problematic if we want to delay the status phase after completing the
> >>> data phase, in order to validate the setup phase data and the data phase
> >>> data (for a control OUT request) together.
> >> 
> >> It shouldn't cause problems, actually. Most of the issues come from the
> >> fact that sometimes gadget driver just returns a success and expects UDC
> >> to initiate status stage and sometimes gadget driver wants to handle
> >> status stage explicitly.
> > 
> > Requesting the status stage explicitly requires an API to do so (quite
> > obviously). Your proposal is to use the usb request queue as a signal to
> > continue to the next stage. My point is that this can't work for control
> > OUT requests, where we may want to delay the status stage after the data
> > is received by the UDC, and thus after the request is queued. We need a
> > different API for that.
> 
> Why so?  Consider the following logic for ep0 in the UDC:
> 
> 	A SETUP packet is received, for an OUT transfer.
> 
> 	If setup.wLength > 0 then the next request queued for ep0 is
> 	the data stage, so it is an OUT request.
> 
> 	Otherwise (i.e., if setup.wLength == 0 or for the second
> 	request queued after the SETUP is received), the next request
> 	is the status stage, so it must be a 0-length IN request.

As explained above, yes, I agree that we could use the request queue operation 
both to queue a request for the data stage, and to request processing the 
status stage. I still think a separate function would be best to request 
processing the status stage (at the very least as a helper that would queue 
the request), but I could be convinced otherwise.

> This requires the UDC to specifically keep track of the direction of
> the current transfer and whether or not a data-stage transfer has
> already been queued.  That shouldn't be hard.

It's "just" a state machine so it wouldn't be too hard. What we need to agree 
on is how the state machine operates, and then the API to control it. That's 
what I tried to describe below in my previous e-mail.

> (But it does involve a
> race in cases where the host gets tired of waiting and issues another
> SETUP packet before the processing of the first transfer is finished.)

I wonder how many UDCs handle that race correctly today :-)

> The corresponding logic for IN transfers is simpler, since IN transfers
> are not allowed to have zero length.  The first request following the
> SETUP packet is the data stage and the second is the status stage.
> 
> > For control IN, we may want to delay the data stage if we can't respond
> > directly, or proceed with the data stage immediately. In both cases this
> > can be signaled by a request being queued. There is no need to delay the
> > status stage as it's initiated by the host.
> 
> Yes.
> 
> > For control OUT, we may want to delay the data stage if we need to
> > validate the setup stage data asynchronously. Proceeding to the data stage
> > can be signaled by queueing a request. We may also want to delay the
> > status stage if we need to validate the data stage data asynchronously.
> > This can't be signaled by queueing a request.
> 
> It can be, if we use the logic outlined above.
> 
> > I wonder if there's really a use case for delaying the data stage of
> > control OUT requests, as it seems to me that we can perform the
> > asynchronous validation of the setup and data stages together, in which
> > case we would always proceed to the data stage, and only potentially
> > delay the status stage. However, if we switch to an explicit API where
> > the transition from the setup to the data stage is triggered by queueing
> > a request, and given that such a transition may need to be delayed for
> > the control IN case, delaying the data stage for control OUT would
> > essentially come for free.

What do you think about this ? Should we allow function drivers to delay the 
data stage of control OUT requests ?

> > In any case we need an API to delay the status stage of a control OUT
> > request. There are two options here. We can consider that the status
> > stage shouldn't be delayed by default and add a new function to be called
> > from the data stage completion handler to request a status stage delay
> > (using the return value of the completion handler isn't a good idea as it
> > would be racy as explained above). A second function would be needed to
> > request the status stage (which, as explained above too, can't be done by
> > queueing a request). A second option is to consider that the status stage
> > is delayed by default until explcitly required. In both cases the same
> > new function is needed to request the status stage.
> > 
> > Note that delaying the data stage and delaying the status stage are two
> > different problems, and don't necessarily need to be solved together.
> > However, if I understand things correctly, we currently delay the data
> > stage of a few control OUT requests (they all have a 0 bytes data stage)
> > as a mean to completion of the request. I believe that this use case
> > could be implemented by delaying the status stage instead, so the two are
> > still related in a way.
> > 
> > If we end up moving to explicit state handling, with the data stage being
> > entered by queueing a request, and the status stage being entered by
> > calling a new function, control OUT requests with 0 bytes of data that
> > can be handled synchronously in the setup handler would require function
> > drivers to both queue a zero-length request and call the status function.
> > This would make the function code more complex, and I wonder whether a
> > shortcut would be a good idea, perhaps in the form of a flag in the
> > request that tells the UDC to automatically proceed to the status stage
> > immediately after the data stage. Or we could make that behaviour the
> > default when the request doesn't have a completion handler (as moving
> > explicitly to the status stage should be done at the earliest from the
> > data stage completion handler).

From an API point of view, towards function drivers, I really want an explicit 
function to proceed with the status stage. That could internally queue a ZLP 
request or call another API, but in any case I don't want the status stage ZLP 
request to be visible to the function drivers. Do you agree with this ?

To simplify function drivers, do you think the above proposal of adding a flag 
to the (data stage) request to request an automatic transition to the status 
stage is a good idea ? We could even possibly invert the logic and transition 
to the status stage when the flag is not set. Essentially this would call the 
status stage request function right after the data stage request completion 
handler returns, instead of forcing all function drivers to do so explicitly 
at the end of the completion handler.

> >>> For those reasons I think a new mechanism is needed. It should either
> >>> signal the status phase delay through an explicit function call
> >>> instead of a return value (to solve the race mentioned above), or by
> >>> requiring all requests to be explicitly completed (but that will require
> >>> changing all USB function drivers). Furthermore, the mechanism need to
> >>> support delaying the status phase after queuing the request for the data
> >>> phase, so we need an explicit way to signal that the UDC should proceed
> >>> with the status phase, other than queueing the request.
> >>> 
> >>> Thoughts ? Preferences ?
> >> 
> >> how about making status stage always explicit?
> > 
> > If we implement a proof of concept, could you help us converting drivers
> > over to the new API ? I'll assume we'll have to address all UDCs first,
> > and then the function drivers.
> 
> I'll certainly help for the drivers I'm familiar with.

Thank you.

-- 
Regards,

Laurent Pinchart



