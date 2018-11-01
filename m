Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF6C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F582251D
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F582251D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeKBIqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:46:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54120 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeKBIqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:46:20 -0400
Received: from garnet.amanokami.net (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 813211A4A;
        Fri,  2 Nov 2018 00:41:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541115673;
        bh=c7Xl9cAuWIBbVuqkkxCabtuFhwmP221sT7XlHdAm59Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8QvzOKmY6ST+Jf7Ha3YbEMhGe7i1OiFSG+DE5vbb3Tl7OOIPqSXOmAsaJfnZLh9Q
         K4bTbfOtkaK4cMfgeC6JW1H0Xz3Ayc/bxGm6wXPkyNo3as7weF/l55Vtp7QXH1n+VJ
         SheOw6zsSX7brJbzj+XprFfTDHTtmq2ZOwoGL+Eg=
Date:   Thu, 1 Nov 2018 19:40:59 -0400
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, kieran.bingham@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org, rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
Message-ID: <20181101234059.GA28068@garnet.amanokami.net>
References: <3055233.Lvy0NcWSZ5@avalon>
 <Pine.LNX.4.44L0.1810180956590.1521-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1810180956590.1521-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Thu, Oct 18, 2018 at 10:07:36AM -0400, Alan Stern wrote:
> On Thu, 18 Oct 2018, Laurent Pinchart wrote:
> 
> > Hi Bin,
> > 
> > On Thursday, 11 October 2018 19:10:21 EEST Bin Liu wrote:
> > > On Tue, Oct 09, 2018 at 10:49:01PM -0400, Paul Elder wrote:
> > > > A usb gadget function driver may or may not want to delay the status
> > > > stage of a control OUT request. An instance it might want to is to
> > > > asynchronously validate the data of a class-specific request.
> > > > 
> > > > Add a function usb_ep_delay_status to allow function drivers to choose
> > > > to delay the status stage in the request completion handler. The UDC
> > > > should then check the usb_ep->delayed_status flag and act accordingly to
> > > > delay the status stage.
> > > > 
> > > > Also add a function usb_ep_send_response as a wrapper for
> > > > usb_ep->ops->send_response, whose prototype is added as well. This
> > > > function should be called by function drivers to tell the UDC what to
> > > > reply in the status stage that it has requested to be delayed.
> > > > 
> > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > ---
> > > > 
> > > >  drivers/usb/gadget/udc/core.c | 35 +++++++++++++++++++++++++++++++++++
> > > >  include/linux/usb/gadget.h    | 11 +++++++++++
> > > >  2 files changed, 46 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > > > index af88b48c1cea..1ec5ce6b43cd 100644
> > > > --- a/drivers/usb/gadget/udc/core.c
> > > > +++ b/drivers/usb/gadget/udc/core.c
> > > > @@ -443,6 +443,41 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
> > > > 
> > > > +/**
> > > > + * usb_ep_ep_delay_status - set delay_status flag
> > > > + * @ep: the endpoint whose delay_status flag is being set
> > > > + *
> > > > + * This function instructs the UDC to delay the status stage of a control
> > > > + * request. It can only be called from the request completion handler of
> > > > a
> > > > + * control request.
> > > > + */
> > > > +void usb_ep_delay_status(struct usb_ep *ep)
> > > > +{
> > > > +	ep->delayed_status = true;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(usb_ep_delay_status);
> > > 
> > > Is usb_ep_set_delay_status() better? I thought it implies get/return
> > > action if a verb is missing in the function name.
> > 
> > For what it's worth, I understand the function name as "delay the status 
> > stage", with "delay" being a verb. Maybe the short description could be 
> > updated accordingly.
> 
> Is there a reason for adding a new function for this?  This is exactly
> what the USB_GADGET_DELAYED_STATUS return value from the setup callback
> is meant for (and it is already used by some gadget drivers).

In theory, we might be able to use USB_GADGET_DELAYED_STATUS for this.
However, there are a few ambiguities that prevent us from doing so.

First of all, we want to delay only the status stage for control OUT
requests; according to composite.h, USB_GADGET_DELAYED_STATUS is for
delaying the "data/status stages". Does this mean that it delays the
status stage only or does it delay both stages? If the slash means
"and", then we cannot use USB_GADGET_DELAYED_STATUS.

Furthermore, we have found that USB_GADGET_DELAYED_STATUS is racey,
which has already been observed in the UVC gadget driver previously [0].
The raceiness stems from the fact that things can happen in between
returning USB_GADGET_DELAYED_STATUS and the composite layer reacting to
it - especially if usb_composite_setup_continue is called within that
window it causes a WARN. In any case, the fact that the mechanism itself
is racey suggests that it needs improvement, and using it wouldn't be a
good solution in this case.

> Is it a question of when the gadget driver learns that it will need to
> delay the status stage?  If that's the case,

Not really.

> why not always return
> USB_GADGET_DELAYED_STATUS from the setup callback?  Then instead of
> calling usb_ep_delay_status() when a delay is needed, you could queue
> the status request when a delay isn't needed.

Theoretically this might work, but see the problems mentioned above.

> As a more general solution, Felipe has said that a UDC driver should 
> _never_ carry out the status stage transaction until the gadget driver 
> has told it to do so.  Then there would be no need for any sort of 
> delay indicator.

Yeah, but,

> (But implementing this would require significant 
> changes to a bunch of different drivers...)

exactly :/

[0] https://www.spinics.net/lists/linux-usb/msg169208.html


Paul
