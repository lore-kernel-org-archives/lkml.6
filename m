Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABE5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3704218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AJjZIyVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeLUJEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:04:48 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:49382 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLUJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:04:48 -0500
Received: from emerald.amanokami.net (173-16-160-11.client.mchsi.com [173.16.160.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33152558;
        Fri, 21 Dec 2018 10:04:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545383085;
        bh=mt96DXKMKuCa2+i0ih/l/ZXWPLKmvzgn1HY2xQqr+vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJjZIyVkqxpaZFkEp1WSzhrdHEXWi/ZV8zJviZAz6NDS6RF5M36x8YocNYLOtrPuD
         NcIUc5sonH/H6a+Ix7crP53KTm+rgr9NAWBD/shxcHjQoo0t7lBSxbsmpQoFO7n1mQ
         C23ouRGwIpmkC9/zm9dl3slqeDiv1BAlX4jWjT34=
Date:   Fri, 21 Dec 2018 03:04:38 -0600
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        b-liu@ti.com, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
Message-ID: <20181221090438.GA2140@emerald.amanokami.net>
References: <20181219092647.12397-5-paul.elder@ideasonboard.com>
 <Pine.LNX.4.44L0.1812191048580.1260-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812191048580.1260-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:01:52AM -0500, Alan Stern wrote:
> On Wed, 19 Dec 2018, Paul Elder wrote:
> 
> > A usb gadget function driver may or may not want to delay the status
> > stage of a control OUT request. An instance it might want to is to
> ---------------------------------------------^
> Typo: missing "where"

ack

> 
> > asynchronously validate the data of a class-specific request.
> > 
> > A function driver that wants an explicit status stage should set the
> > newly added explicit_status flag of the usb_request corresponding to the
> > data stage. Later on the function driver can explicitly complete the
> > status stage by enqueueing a usb_request for ACK, or calling
> > usb_ep_set_halt() for STALL.
> > 
> > To support both explicit and implicit status stages, a UDC driver must
> > call the newly added usb_gadget_control_complete function right after
> > calling usb_gadget_giveback_request. The status of the request that was
> > just given back must be fed into usb_gadget_control_complete. To support
> > the explicit status stage, it might then check what stage the
> > usb_request was queued in, and send an ACK.
> 
> I don't really understand that last sentence.  Perhaps what you mean is
> that depending on the direction of the control transfer, the driver
> should either ACK the host's 0-length data packet (control-IN) or send
> a 0-length DATA1 packet (control-OUT)?

Yes, that is what I meant, though for MUSB I've only implemented and
tested the control OUT case.

> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Changes from v2:
> > 
> > Add status parameter to usb_gadget_control_complete, so that a
> > usb_request is not queued if the status of the just given back request
> > is nonzero.
> > 
> > Changes from v1:
> > 
> > Complete change of API. Now we use a flag that should be set in the
> > usb_request that is queued for the data stage to signal to the UDC that
> > we want to delay the status stage (as opposed to setting a flag in the
> > UDC itself, that persists across all requests). We now also provide a
> > function for UDC drivers to very easily allow implicit status stages, to
> > mitigate the need to convert all function drivers to this new API at
> > once, and to make it easier for UDC drivers to convert.
> > 
> >  drivers/usb/gadget/udc/core.c | 34 ++++++++++++++++++++++++++++++++++
> >  include/linux/usb/gadget.h    | 10 ++++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index af88b48c1cea..0a0ccd2b7639 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -894,6 +894,40 @@ EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
> >  
> >  /* ------------------------------------------------------------------------- */
> >  
> > +/**
> > + * usb_gadget_control_complete - complete the status stage of a control
> > + *	request, or delay it
> > + * Context: in_interrupt()
> > + *
> > + * @gadget: gadget whose control request's status stage should be completed
> > + * @explicit_status: true to delay status stage, false to complete here
> > + * @status: completion code of previously completed request
> > + *
> > + * This is called by device controller drivers after returning the completed
> > + * request back to the gadget layer, to either complete or delay the status
> > + * stage.
> > + */
> > +void usb_gadget_control_complete(struct usb_gadget *gadget,
> > +		unsigned int explicit_status, int status)
> > +{
> > +	struct usb_request *req;
> > +
> > +	if (explicit_status || status)
> > +		return;
> > +
> > +	/* Send an implicit status-stage request for ep0 */
> > +	req = usb_ep_alloc_request(gadget->ep0, GFP_ATOMIC);
> > +	if (req) {
> > +		req->length = 0;
> > +		req->explicit_status = 0;
> 
> Oops!  I should have spotted this in the previous version, sorry. The
> implicit status-stage request should have its ->explicit_status set, so
> that we don't try to submit another status request when this one
> completes.

No, it's fine; the previous version had it set to 1 :)

I didn't think it mattered, but the way you describe it makes it seem
like it would matter depending on the UDC driver implementation, so I'll
put it back in.

> Also, would it look better if the type of explicit_status was bool 
> instead of unsigned int (both here and in the structure)?

Yes, it would; I'll make the change.

> Either way, once this change is made:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thank you :)

> > +		req->complete = usb_ep_free_request;
> > +		usb_ep_queue(gadget->ep0, req, GFP_ATOMIC);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(usb_gadget_control_complete);
> > +
> > +/* ------------------------------------------------------------------------- */
> > +
> >  /**
> >   * gadget_find_ep_by_name - returns ep whose name is the same as sting passed
> >   *	in second parameter or NULL if searched endpoint not found
> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> > index e5cd84a0f84a..1e3a23637468 100644
> > --- a/include/linux/usb/gadget.h
> > +++ b/include/linux/usb/gadget.h
> > @@ -73,6 +73,7 @@ struct usb_ep;
> >   *	Note that for writes (IN transfers) some data bytes may still
> >   *	reside in a device-side FIFO when the request is reported as
> >   *	complete.
> > + * @explicit_status: If true, delays the status stage
> >   *
> >   * These are allocated/freed through the endpoint they're used with.  The
> >   * hardware's driver can add extra per-request data to the memory it returns,
> > @@ -114,6 +115,8 @@ struct usb_request {
> >  
> >  	int			status;
> >  	unsigned		actual;
> > +
> > +	unsigned		explicit_status:1;
> >  };
> >  
> >  /*-------------------------------------------------------------------------*/
> > @@ -850,6 +853,13 @@ extern void usb_gadget_giveback_request(struct usb_ep *ep,
> >  
> >  /*-------------------------------------------------------------------------*/
> >  
> > +/* utility to complete or delay status stage */
> > +
> > +void usb_gadget_control_complete(struct usb_gadget *gadget,
> > +		unsigned int explicit_status, int status);
> > +
> > +/*-------------------------------------------------------------------------*/
> > +
> >  /* utility to find endpoint by name */
> >  
> >  extern struct usb_ep *gadget_find_ep_by_name(struct usb_gadget *g,
> > 
> 

Paul Elder
