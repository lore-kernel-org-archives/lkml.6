Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD19C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B41820869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B41820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbeKGA0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:26:52 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36650 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729642AbeKGA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:26:52 -0500
Received: (qmail 2409 invoked by uid 2102); 6 Nov 2018 10:01:14 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Nov 2018 10:01:14 -0500
Date:   Tue, 6 Nov 2018 10:01:14 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Felipe Balbi <balbi@kernel.org>
cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, <kieran.bingham@ideasonboard.com>,
        <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
In-Reply-To: <87a7mmv46v.fsf@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.1811060951100.1450-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018, Felipe Balbi wrote:

> 
> Hi,
> 
> Alan Stern <stern@rowland.harvard.edu> writes:
> > There's a similar race at the hardware level.  What happens if the
> > controller receives a new SETUP packet and concurrently the driver is
> > setting up the controller registers for a response to an earlier
> > SETUP?  I don't know how real controllers handle this.
> 
> That's HW implementation detail. DWC3, for instance, will ignore the
> TRBs and return me the status "setup packet pending". Then I just start
> a new SETUP TRB.

You mean the UDC hardware sets a "setup pending" flag in some register,
and then ignores any attempts to do anything with ep0 until the driver
clears this flag?

We could do something similar at the software level.  In fact, that
would be one of the two proposals I outlined in an earlier email.

> > You mean, should we allow function drivers to queue the data-stage
> > request after the setup handler has returned?  I don't see any reason
> 
> that's already done:
> 
> static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
> 			const struct dwc3_event_depevt *event)
> {
> 	struct dwc3_ep		*dep = dwc->eps[event->endpoint_number];
> 
> 	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> 	dep->resource_index = 0;
> 	dwc->setup_packet_pending = false;
> 
> 	switch (dwc->ep0state) {
> 	case EP0_SETUP_PHASE:
> 		dwc3_ep0_inspect_setup(dwc, event);
> 		break;
> [...]
> }

...

You mean, it's already done in DWC3.  What about other UDC drivers?

> > why not.  After all, some drivers may require this.  Likewise for the 
> > data stage of a control-IN.
> >
> > Another thing we should do is give function drivers a way to send a
> > STALL response for the status stage.  Currently there's no way to do
> > it, if a data stage is present.
> 
> Status stage can only be stalled if host tries to move data on the wrong
> direction.

The USB-2 spec disagrees.  See Table 8-7 in section 8.5.3.1 and the
following paragraphs.  (Although, I can't see why a function would ever
fail to complete the command sequence for a control-IN transfer after
the data had already been sent.)

Alan Stern

