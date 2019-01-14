Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D255C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABF420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="u9Dz3Tie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfANFLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:11:23 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35994 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfANFLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:11:23 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74FA7505;
        Mon, 14 Jan 2019 06:11:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547442680;
        bh=esYPm4b0uDdBX5f/Z8E07u3/w+FPQbC3SDb9m+cNhaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9Dz3TieCLdVPwgi1YF+nMtdIJB/H+aPWNsxMgeRi4bBGMUGPvtWSd8odlNSBhwyh
         bVUg/3KH9sEyaUXFgH96bF1y9EXHJ3DAiIEhW1CGG8xqD5xHLpYi4hut6aVzTE+5SD
         obuB35ZGRPK5XnNRNp6gRRr0vMg+NN0vM2aif+9A=
Date:   Mon, 14 Jan 2019 00:11:13 -0500
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        b-liu@ti.com, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
Message-ID: <20190114051113.GD32268@localhost.localdomain>
References: <20190111082340.GB32268@localhost.localdomain>
 <Pine.LNX.4.44L0.1901111044290.1501-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901111044290.1501-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:50:11AM -0500, Alan Stern wrote:
> On Fri, 11 Jan 2019, Paul Elder wrote:
> 
> > On Wed, Jan 09, 2019 at 02:06:31PM -0500, Alan Stern wrote:
> > > On Wed, 9 Jan 2019, Paul Elder wrote:
> > > 
> > > > A usb gadget function driver may or may not want to delay the status
> > > > stage of a control OUT request. An instance where it might want to is to
> > > > asynchronously validate the data of a class-specific request.
> > > > 
> > > > A function driver that wants an explicit status stage should set the
> > > > newly added explicit_status flag of the usb_request corresponding to the
> > > > data stage. Later on, the function driver can explicitly complete the
> > > > status stage by enqueueing a usb_request for ACK, or calling
> > > > usb_ep_set_halt() for STALL.
> > > > 
> > > > To support both explicit and implicit status stages, a UDC driver must
> > > > call the newly added usb_gadget_control_complete function right before
> > > > calling usb_gadget_giveback_request. To support the explicit status
> > > > stage, it might then check what stage the usb_request was queued in, and
> > > > for control IN ACK the host's zero-length data packet, or for control
> > > > OUT send a zero-length DATA1 ACK packet.
> > > > 
> > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > v4 Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > > v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > This looks good and has passed my tests so far.
> > 
> > Good! Thank you :)
> > 
> > > Can you check your uvc
> > > changes using dummy_hcd with the patch below?
> > 
> > I'm not sure what to make of the test results. I get the same results
> > with or without the patch. Which I guess makes sense... in dummy_queue,
> > this is getting hit when the uvc function driver tries to complete the
> > delayed status:
> > 
> > 	req = usb_request_to_dummy_request(_req);
> > 	if (!_req || !list_empty(&req->queue) || !_req->complete)
> > 		return -EINVAL;
> > 
> > So the delayed/explicit status stage is never completed, afaict.
> 
> I presume you are hitting the !list_empty(&req->queue) test, yes?  The 
> other two tests are trivial.

Yes, that is what's happening.

> Triggering the !list_empty() test means the request has already been
> submitted and not yet completed.  This probably indicates there is a
> bug in the uvc function driver code.

The uvc function driver works with musb, though :/

I compared the sequence of calls to the uvc setup, completion handler,
and status stage sending, and for some reason dummy_hcd, after an OUT
setup-completion-status sequence, calls a completion-status-completion
sequence, and then goes on the the next request. musb simply goes on to
the next request after the setup-completion-status sequence.

I commented out the paranoia block in dummy_timer, and dummy_hcd still
does the extra completion, but it doesn't error out anymore. I doubt
that's the/a solution though, especially since I get:

[   22.616577] uvcvideo: Failed to query (129) UVC probe control : -75 (exp. 26).
[   22.624481] uvcvideo: Failed to initialize the device (-5).

Not sure if that's a result of dummy_hcd not supporting isochronous
transfers or not.

I'm not sure where to continue investigating :/


Thanks,

Paul
