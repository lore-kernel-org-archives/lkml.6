Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C378BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1192145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1192145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeJRWIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:08:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45852 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727062AbeJRWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:08:48 -0400
Received: (qmail 1612 invoked by uid 2102); 18 Oct 2018 10:07:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Oct 2018 10:07:36 -0400
Date:   Thu, 18 Oct 2018 10:07:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
cc:     Bin Liu <b-liu@ti.com>, Paul Elder <paul.elder@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <rogerq@ti.com>
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
In-Reply-To: <3055233.Lvy0NcWSZ5@avalon>
Message-ID: <Pine.LNX.4.44L0.1810180956590.1521-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Laurent Pinchart wrote:

> Hi Bin,
> 
> On Thursday, 11 October 2018 19:10:21 EEST Bin Liu wrote:
> > On Tue, Oct 09, 2018 at 10:49:01PM -0400, Paul Elder wrote:
> > > A usb gadget function driver may or may not want to delay the status
> > > stage of a control OUT request. An instance it might want to is to
> > > asynchronously validate the data of a class-specific request.
> > > 
> > > Add a function usb_ep_delay_status to allow function drivers to choose
> > > to delay the status stage in the request completion handler. The UDC
> > > should then check the usb_ep->delayed_status flag and act accordingly to
> > > delay the status stage.
> > > 
> > > Also add a function usb_ep_send_response as a wrapper for
> > > usb_ep->ops->send_response, whose prototype is added as well. This
> > > function should be called by function drivers to tell the UDC what to
> > > reply in the status stage that it has requested to be delayed.
> > > 
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/usb/gadget/udc/core.c | 35 +++++++++++++++++++++++++++++++++++
> > >  include/linux/usb/gadget.h    | 11 +++++++++++
> > >  2 files changed, 46 insertions(+)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > > index af88b48c1cea..1ec5ce6b43cd 100644
> > > --- a/drivers/usb/gadget/udc/core.c
> > > +++ b/drivers/usb/gadget/udc/core.c
> > > @@ -443,6 +443,41 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
> > >  }
> > >  EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
> > > 
> > > +/**
> > > + * usb_ep_ep_delay_status - set delay_status flag
> > > + * @ep: the endpoint whose delay_status flag is being set
> > > + *
> > > + * This function instructs the UDC to delay the status stage of a control
> > > + * request. It can only be called from the request completion handler of
> > > a
> > > + * control request.
> > > + */
> > > +void usb_ep_delay_status(struct usb_ep *ep)
> > > +{
> > > +	ep->delayed_status = true;
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_ep_delay_status);
> > 
> > Is usb_ep_set_delay_status() better? I thought it implies get/return
> > action if a verb is missing in the function name.
> 
> For what it's worth, I understand the function name as "delay the status 
> stage", with "delay" being a verb. Maybe the short description could be 
> updated accordingly.

Is there a reason for adding a new function for this?  This is exactly
what the USB_GADGET_DELAYED_STATUS return value from the setup callback
is meant for (and it is already used by some gadget drivers).

Is it a question of when the gadget driver learns that it will need to
delay the status stage?  If that's the case, why not always return
USB_GADGET_DELAYED_STATUS from the setup callback?  Then instead of
calling usb_ep_delay_status() when a delay is needed, you could queue
the status request when a delay isn't needed.

As a more general solution, Felipe has said that a UDC driver should 
_never_ carry out the status stage transaction until the gadget driver 
has told it to do so.  Then there would be no need for any sort of 
delay indicator.  (But implementing this would require significant 
changes to a bunch of different drivers...)

Alan Stern

