Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79589C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F8B20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbfAKPuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:50:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44136 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730850AbfAKPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:50:12 -0500
Received: (qmail 3848 invoked by uid 2102); 11 Jan 2019 10:50:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2019 10:50:11 -0500
Date:   Fri, 11 Jan 2019 10:50:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
In-Reply-To: <20190111082340.GB32268@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1901111044290.1501-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, Paul Elder wrote:

> On Wed, Jan 09, 2019 at 02:06:31PM -0500, Alan Stern wrote:
> > On Wed, 9 Jan 2019, Paul Elder wrote:
> > 
> > > A usb gadget function driver may or may not want to delay the status
> > > stage of a control OUT request. An instance where it might want to is to
> > > asynchronously validate the data of a class-specific request.
> > > 
> > > A function driver that wants an explicit status stage should set the
> > > newly added explicit_status flag of the usb_request corresponding to the
> > > data stage. Later on, the function driver can explicitly complete the
> > > status stage by enqueueing a usb_request for ACK, or calling
> > > usb_ep_set_halt() for STALL.
> > > 
> > > To support both explicit and implicit status stages, a UDC driver must
> > > call the newly added usb_gadget_control_complete function right before
> > > calling usb_gadget_giveback_request. To support the explicit status
> > > stage, it might then check what stage the usb_request was queued in, and
> > > for control IN ACK the host's zero-length data packet, or for control
> > > OUT send a zero-length DATA1 ACK packet.
> > > 
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > v4 Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > This looks good and has passed my tests so far.
> 
> Good! Thank you :)
> 
> > Can you check your uvc
> > changes using dummy_hcd with the patch below?
> 
> I'm not sure what to make of the test results. I get the same results
> with or without the patch. Which I guess makes sense... in dummy_queue,
> this is getting hit when the uvc function driver tries to complete the
> delayed status:
> 
> 	req = usb_request_to_dummy_request(_req);
> 	if (!_req || !list_empty(&req->queue) || !_req->complete)
> 		return -EINVAL;
> 
> So the delayed/explicit status stage is never completed, afaict.

I presume you are hitting the !list_empty(&req->queue) test, yes?  The 
other two tests are trivial.

Triggering the !list_empty() test means the request has already been
submitted and not yet completed.  This probably indicates there is a
bug in the uvc function driver code.

Alan Stern

