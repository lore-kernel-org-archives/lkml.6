Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF5EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB542081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB542081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeKCEyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:54:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37898 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726060AbeKCEyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:54:38 -0400
Received: (qmail 4289 invoked by uid 2102); 2 Nov 2018 15:46:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Nov 2018 15:46:09 -0400
Date:   Fri, 2 Nov 2018 15:46:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
cc:     Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, <kieran.bingham@ideasonboard.com>,
        <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
In-Reply-To: <3595344.euAgJ7Kpbg@avalon>
Message-ID: <Pine.LNX.4.44L0.1811021437410.1469-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018, Laurent Pinchart wrote:

> Hi Alan,

Hi, Laurent.

> The composite layer only handles USB_GADGET_DELAYED_STATUS for 
> USB_REQ_SET_CONFIGURATION (in set_config()) and for USB_REQ_SET_INTERFACE (in 
> composite_setup()). It increments cdev->delayed_status immediately. Then, in 
> usb_composite_setup_continue(), if cdev->delayed_status is not zero, it queues 
> a ZLP, and warns otherwise.
> 
> This mechanism delays the data stage, not the status stage (or, to be precise, 
> it delays the status stage insofar as the status stage comes after the data 
> stage), and only supports control OUT requests with 0 bytes of data (which is 
> the case of both USB_REQ_SET_INTERFACE and USB_REQ_SET_CONFIGURATION). For all 
> other requests, the composite layer passes USB_GADGET_DELAYED_STATUS to the 
> UDC.
> 
> The three UDCs that implement USB_GADGET_DELAYED_STATUS support set a 
> delayed_status flag in an internal structure. I haven't inspected in details 
> what they do next as I'm not familiar with all of them, but the dwc3 driver 
> just skips the handling of the status phase in dwc3_ep0_xfernotready() and 
> delays it to __dwc3_gadget_ep0_queue(). This only works for 0-length requests, 
> with no data phase.
> 
> Even when limited to 0-length control OUT requests, this mechanism is racy. 
> The setup handler, when it wants to delay the status phase, will queue 
> asynchronous work that will, when it completes, call 
> usb_composite_setup_continue() to proceed with the status phase. Queuing the 
> work has to be done before the setup handler returns, and the cdev-
> >delayed_status is only incremented after the setup handler returns, in 
> composite_setup(). There is thus a time window during which the asynchronous 
> work can call usb_composite_setup_continue() before cdev->delayed_status has 
> been incremented. We have managed to hit this in practice, with a surprisingly 
> high rate seeing how small the window is.

I see.  Thanks for the detailed explanation.

> Now that I've written all this, I realize that cdev->delayed_status is guarded 
> by cdev->lock. I thus wonder whether our analysis was correct, or if we were 
> hitting a different bug :-S Paul, could you test this again ? Please note, 
> however, that the race described here is not related to this patch series, 
> except in how it influences the API design to avoid race conditions.

Perhaps the async work routine doesn't acquire cdev->lock.

> > Assuming you are correct, wouldn't it make sense to fix or eliminate
> > the race by changing composite.c?
> 
> I was about to write that we would need to lock access to cdev-
> >delayed_status, and found out that we already use cdev->lock to do so. More 
> investigations are needed.
> 
> Please note, however, that USB_GADGET_DELAYED_STATUS is limited to 0-length 
> control OUT requests, so the problem that led to this patch series still 
> exists, even if the race condition I thought was there doesn't exist.

Yes, it is too limited.


> > > Given that we need to delay the status stage and not the data stage, we
> > > can't explicitly request the status stage through a usb request queue.
> > 
> > Why not?  The status stage for a control-OUT transfer is simply a
> > zero-length IN transaction.  It's easy to queue a request for such a
> > transaction.  Is the issue that there's no way to specify the direction
> > of the request (hence no direct way to tell whether a zero-length
> > request is for the data stage or the status stage)?
> 
> OK, I suppose we could queue a request for this, in which case we would have 
> to queue two requests for control OUT transfers (one for the data stage and 
> one for the status stage). I'm however not convinced that would be the best 
> API to handle the status stage, as the function driver would need to queue a 
> request and the UDC would then need to check whether that request corresponds 
> to a status stage and process it accordingly. A new operation specific to this 
> would be easier for both the function driver and the UDC in my opinion. 
> There's also the fact that requests can specify a completion handler, but only 
> the data stage request would see its completion handler called (unless we 
> require UDCs to call completion requests at the completion of the status 
> stage, but I'm not sure that all UDCs can report the event to the driver, and 
> that would likely be useless as nobody needs that feature).
> 
> > Admittedly, it might be nice to provide a library routine in the UDC
> > core to queue such requests, since it involves a bunch of uninteresting
> > boilerplate operations.
> > 
> > > Would a new explicit function call work for you for that purpose ?
> > 
> > It would be okay, but I question whether one is really needed.
> 
> I think the API would be cleaner, but it might just be a matter of taste.

I have to agree that a separate function would be cleaner.  Whether
this function should be part of the gadget API or just a core library
routine is something we need to decide.


> > (But it does involve a
> > race in cases where the host gets tired of waiting and issues another
> > SETUP packet before the processing of the first transfer is finished.)
> 
> I wonder how many UDCs handle that race correctly today :-)

Probably none of them.  I can think of two ways of doing it:

	Have the UDC driver associate a new integer tag with each
	SETUP packet, and have function drivers include the
	corresponding tag when they queue a request on ep0.  Then the
	UDC driver could refuse requests whose tag was out of date.

	Create an new API routine for function drivers to call in
	their setup handler.  This routine would acknowledge receipt
	of the new SETUP packet, assuring the UDC driver that no more
	requests would be queued in response to earlier SETUPs.  Until
	the routine was called, the UDC would refuse all requests for
	ep0.  Function drivers would be responsible for their own
	internal synchronization.

Both of these would involve nontrivial API changes, although the first
could be relatively uninvasive.  I doubt either of them is worthwhile
at this point.

There's a similar race at the hardware level.  What happens if the
controller receives a new SETUP packet and concurrently the driver is
setting up the controller registers for a response to an earlier
SETUP?  I don't know how real controllers handle this.


> > > I wonder if there's really a use case for delaying the data stage of
> > > control OUT requests, as it seems to me that we can perform the
> > > asynchronous validation of the setup and data stages together, in which
> > > case we would always proceed to the data stage, and only potentially
> > > delay the status stage. However, if we switch to an explicit API where
> > > the transition from the setup to the data stage is triggered by queueing
> > > a request, and given that such a transition may need to be delayed for
> > > the control IN case, delaying the data stage for control OUT would
> > > essentially come for free.
> 
> What do you think about this ? Should we allow function drivers to delay the 
> data stage of control OUT requests ?

You mean, should we allow function drivers to queue the data-stage
request after the setup handler has returned?  I don't see any reason
why not.  After all, some drivers may require this.  Likewise for the 
data stage of a control-IN.

Another thing we should do is give function drivers a way to send a
STALL response for the status stage.  Currently there's no way to do
it, if a data stage is present.


> From an API point of view, towards function drivers, I really want an explicit 
> function to proceed with the status stage. That could internally queue a ZLP 
> request or call another API, but in any case I don't want the status stage ZLP 
> request to be visible to the function drivers. Do you agree with this ?

It's okay with me.

> To simplify function drivers, do you think the above proposal of adding a flag 
> to the (data stage) request to request an automatic transition to the status 
> stage is a good idea ? We could even possibly invert the logic and transition 
> to the status stage when the flag is not set. Essentially this would call the 
> status stage request function right after the data stage request completion 
> handler returns, instead of forcing all function drivers to do so explicitly 
> at the end of the completion handler.

That makes sense.  Function drivers then wouldn't have to be aware of
the new API.  We'd only need to convert the UDC drivers (plus the users
of USB_GADGET_DELAYED_STATUS).

Should control-IN transfers use the flag also?  I can't imagine why
anyone would want to delay or otherwise alter a control-IN status
stage.

Alan Stern

