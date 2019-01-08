Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A959FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806192171F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfAHPcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:32:05 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53454 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727906AbfAHPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:32:05 -0500
Received: (qmail 1507 invoked by uid 2102); 8 Jan 2019 10:32:04 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2019 10:32:04 -0500
Date:   Tue, 8 Jan 2019 10:32:04 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] usb: musb: gadget: implement optional explicit
 status stage
In-Reply-To: <20190108054918.GB31873@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1901081028560.1355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Paul Elder wrote:

> On Sun, Jan 06, 2019 at 03:03:09PM -0500, Alan Stern wrote:
> > On Sun, 6 Jan 2019, Paul Elder wrote:
> > 
> > > Implement the mechanism for optional explicit status stage for the MUSB
> > > driver. This allows a function driver to specify what to reply for the
> > > status stage. The functionality for an implicit status stage is
> > > retained.
> > > 
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > v1 Acked-by: Bin Liu <b-liu@ti.com>
> > > ---
> > > No change from v3
> > > 
> > > Changes from v2:
> > > - update call to usb_gadget_control_complete to include status
> > > - since sending STALL from the function driver is now done with
> > >   usb_ep_set_halt, there is no need for the internal ep0_send_response to
> > >   take a stall/ack parameter; remove the parameter and make the function
> > >   only send ack, and remove checking for the status reply in the
> > >   usb_request for the status stage
> > > 
> > > Changes from v1:
> > > - obvious change to implement v2 mechanism laid out by 4/6 of this
> > >   series (send_response, and musb_g_ep0_send_response function has
> > >   been removed, call to usb_gadget_control_complete has been added)
> > > - ep0_send_response's ack argument has been changed from stall
> > > - last_packet flag in ep0_rxstate has been removed, since it is equal to
> > >   req != NULL
> > > 
> > >  drivers/usb/musb/musb_gadget.c     |  2 ++
> > >  drivers/usb/musb/musb_gadget_ep0.c | 23 +++++++++++++++++++++++
> > >  2 files changed, 25 insertions(+)
> > > 
> > > diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> > > index d3f33f449445..a7a992ab0c9d 100644
> > > --- a/drivers/usb/musb/musb_gadget.c
> > > +++ b/drivers/usb/musb/musb_gadget.c
> > > @@ -145,6 +145,8 @@ __acquires(ep->musb->lock)
> > >  
> > >  	trace_musb_req_gb(req);
> > >  	usb_gadget_giveback_request(&req->ep->end_point, &req->request);
> > > +	usb_gadget_control_complete(&musb->g, request->explicit_status,
> > > +			request->status);
> > 
> > I haven't paid much attention to this part of the patch series, not 
> > knowing much about musb.  Still, it's clear that 
> > usb_gadget_control_complete should be called only for transfers on 
> > ep0.  You need to test the endpoint value.
> 
> Oh oops, yeah, you're right.
> 
> > Another problem: the completion handler may deallocate the request.  
> > Dereferencing request->expicit_status and request->status would then 
> > cause errors.  Would it be preferable to call 
> > usb_gadget_control_complete before usb_gadget_giveback_request?  If 
> > it gets done that way then the arguments could be simplified: we could 
> > pass a pointer to the request instead of the separate explicit_status 
> > and status values.
> 
> I thought that usb_gadget_control_complete needs to check the status of
> the request that was given back. Doesn't that mean that
> usb_gadget_giveback_request must be called first?

You misunderstand.  req->status has already been determined by the time 
usb_gadget_giveback_request is called.  It does not get set by that 
call.

> I was thinking that maybe we could save explicit_status before calling
> usb_gadget_giveback_request, and if request is still valid then we can
> pull status from it otherwise use 0, but then would that be considered
> adding complexity to UDCs that want to implement optional status stage
> delay? Or add a wrapper function?
> 
> On the other hand, if we do put usb_gadget_control_complete before
> usb_gadget_giveback_request, then the control transfer would complete
> before the function driver has a chance to complete, but if the function
> driver wanted to intervene/determine the status stage then it would have
> gone through the new mechanism that we're making here. So it could be
> fine to switch the order. My tests for it work too, so I guess we'll go
> with usb_gadget_control_complete before usb_gadget_giveback_request
> then. In that case usb_gadget_control_complete doesn't need to check the
> status of the request, since there isn't any, right?

Wrong -- the status has already been set by that time.

Alan Stern

