Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77554C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218722082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AYbENIea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218722082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKBVvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:51:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41400 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeKBVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:51:55 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E0E21263;
        Fri,  2 Nov 2018 13:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541162689;
        bh=ioT0gc0zgmXjaCLgmsvz2MdRFpVVTX4Uk7SaK+uIXAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYbENIeaIMWtbZJyZIUMrGv9uGwF3ynZPF3ASW+DiCE/UGcdVRC1+ZVQt0IKwn45I
         meHEfx7Mpew0GQrPZImZ+fJWi58H81Wlz97pGSA3NddpDcBwqgilsZI3utyxq8wmWc
         kbQqVbcl8ikRgaJhuTmQDt3iq1MKE5El/t6OnXn8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, Bin Liu <b-liu@ti.com>,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
Date:   Fri, 02 Nov 2018 14:44:55 +0200
Message-ID: <2683135.rrYvd4LdR5@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181101234059.GA28068@garnet.amanokami.net>
References: <3055233.Lvy0NcWSZ5@avalon> <Pine.LNX.4.44L0.1810180956590.1521-100000@iolanthe.rowland.org> <20181101234059.GA28068@garnet.amanokami.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Friday, 2 November 2018 01:40:59 EET Paul Elder wrote:
> On Thu, Oct 18, 2018 at 10:07:36AM -0400, Alan Stern wrote:
> > On Thu, 18 Oct 2018, Laurent Pinchart wrote:
> >> On Thursday, 11 October 2018 19:10:21 EEST Bin Liu wrote:
> >>> On Tue, Oct 09, 2018 at 10:49:01PM -0400, Paul Elder wrote:
> >>>> A usb gadget function driver may or may not want to delay the status
> >>>> stage of a control OUT request. An instance it might want to is to
> >>>> asynchronously validate the data of a class-specific request.
> >>>> 
> >>>> Add a function usb_ep_delay_status to allow function drivers to
> >>>> choose to delay the status stage in the request completion handler.
> >>>> The UDC should then check the usb_ep->delayed_status flag and act
> >>>> accordingly to delay the status stage.
> >>>> 
> >>>> Also add a function usb_ep_send_response as a wrapper for
> >>>> usb_ep->ops->send_response, whose prototype is added as well. This
> >>>> function should be called by function drivers to tell the UDC what
> >>>> to reply in the status stage that it has requested to be delayed.
> >>>> 
> >>>> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> >>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>> ---
> >>>> 
> >>>>  drivers/usb/gadget/udc/core.c | 35 ++++++++++++++++++++++++++++++++
> >>>>  include/linux/usb/gadget.h    | 11 +++++++++++
> >>>>  2 files changed, 46 insertions(+)
> >>>> 
> >>>> diff --git a/drivers/usb/gadget/udc/core.c
> >>>> b/drivers/usb/gadget/udc/core.c
> >>>> index af88b48c1cea..1ec5ce6b43cd 100644
> >>>> --- a/drivers/usb/gadget/udc/core.c
> >>>> +++ b/drivers/usb/gadget/udc/core.c
> >>>> @@ -443,6 +443,41 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
> >>>> 
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
> >>>> 
> >>>> +/**
> >>>> + * usb_ep_ep_delay_status - set delay_status flag
> >>>> + * @ep: the endpoint whose delay_status flag is being set
> >>>> + *
> >>>> + * This function instructs the UDC to delay the status stage of a
> >>>> control
> >>>> + * request. It can only be called from the request completion
> >>>> handler of a
> >>>> + * control request.
> >>>> + */
> >>>> +void usb_ep_delay_status(struct usb_ep *ep)
> >>>> +{
> >>>> +	ep->delayed_status = true;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(usb_ep_delay_status);
> >>> 
> >>> Is usb_ep_set_delay_status() better? I thought it implies get/return
> >>> action if a verb is missing in the function name.
> >> 
> >> For what it's worth, I understand the function name as "delay the status
> >> stage", with "delay" being a verb. Maybe the short description could be
> >> updated accordingly.
> > 
> > Is there a reason for adding a new function for this?  This is exactly
> > what the USB_GADGET_DELAYED_STATUS return value from the setup callback
> > is meant for (and it is already used by some gadget drivers).
> 
> In theory, we might be able to use USB_GADGET_DELAYED_STATUS for this.
> However, there are a few ambiguities that prevent us from doing so.
> 
> First of all, we want to delay only the status stage for control OUT
> requests; according to composite.h, USB_GADGET_DELAYED_STATUS is for
> delaying the "data/status stages". Does this mean that it delays the
> status stage only or does it delay both stages? If the slash means
> "and", then we cannot use USB_GADGET_DELAYED_STATUS.
> 
> Furthermore, we have found that USB_GADGET_DELAYED_STATUS is racey,
> which has already been observed in the UVC gadget driver previously [0].
> The raceiness stems from the fact that things can happen in between
> returning USB_GADGET_DELAYED_STATUS and the composite layer reacting to
> it - especially if usb_composite_setup_continue is called within that
> window it causes a WARN. In any case, the fact that the mechanism itself
> is racey suggests that it needs improvement, and using it wouldn't be a
> good solution in this case.
> 
> > Is it a question of when the gadget driver learns that it will need to
> > delay the status stage?  If that's the case,
> 
> Not really.
> 
> > why not always return
> > USB_GADGET_DELAYED_STATUS from the setup callback?  Then instead of
> > calling usb_ep_delay_status() when a delay is needed, you could queue
> > the status request when a delay isn't needed.
> 
> Theoretically this might work, but see the problems mentioned above.
> 
> > As a more general solution, Felipe has said that a UDC driver should
> > _never_ carry out the status stage transaction until the gadget driver
> > has told it to do so.  Then there would be no need for any sort of
> > delay indicator.
> 
> Yeah, but,
> 
> > (But implementing this would require significant
> > changes to a bunch of different drivers...)
> 
> exactly :/
> 
> [0] https://www.spinics.net/lists/linux-usb/msg169208.html

Alan, Felipe, how do we move forward with this ? There are several issues with 
the existing control request handling mechanism in the USB gadget stack, and 
while Paul could work on improving the mechanism, we need to provide clear 
guidance regarding the direction we want to take.

For reference, the issues I know about for the USB_GADGET_DELAYED_STATUS 
mechanism are

- The mechanism is inherently racy. It relies on signaling the delay at the 
very end of the processing in the setup handler, which by definition occurs 
after the work to process the control request is queued (in the generic sense, 
regardless of whether this involves a kernel workqueue or passing the work to 
userspace). There is thus a race window after queuing the work and before 
signaling the delay during which the work handler could signal completion.

- The mechanism is poorly documented. As Paul mentioned, comments in the code 
state that USB_GADGET_DELAYED_STATUS delay the "data/status stages". This is 
very unclear, and the only three UDCs that implement the mechanism seem to do 
so in different ways:

  - The mtu driver states in a comment that it will "handle the delay STATUS 
phase till receive ep_queue on ep0".

  - The bdc driver states in a comment that "The ep0 state will remain 
WAIT_FOR_DATA_START till we received ep_queue on ep0".

  - The dwc3 driver seems to handle USB_GADGET_DELAYED_STATUS for the 
SET_CONFIG request only.

- The mechanism relies on queueing a request to the UDC to signal that it 
should continue with the status stage. That request can be queued either by 
the USB gadget function driver directly, or by the composite layer in 
usb_composite_setup_continue() (the latter is restricted to requests that 
carry no data as it sets the request length to 0). This is problematic if we 
want to delay the status phase after completing the data phase, in order to 
validate the setup phase data and the data phase data (for a control OUT 
request) together.


For those reasons I think a new mechanism is needed. It should either signal 
the status phase delay through an explicit function call instead of a return 
value (to solve the race mentioned above), or by requiring all requests to be 
explicitly completed (but that will require changing all USB function 
drivers). Furthermore, the mechanism need to support delaying the status phase 
after queuing the request for the data phase, so we need an explicit way to 
signal that the UDC should proceed with the status phase, other than queueing 
the request.

Thoughts ? Preferences ?

-- 
Regards,

Laurent Pinchart



