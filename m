Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F6DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C2A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lArhwKKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfAKIXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:23:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60412 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfAKIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:23:51 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 947B8547;
        Fri, 11 Jan 2019 09:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547195028;
        bh=bEB1oYi+scrgN1ZJyJRgkEbLbXQItSsxMVr+gMQfUgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lArhwKKSHe6KwBEednGNsaGZQxO7fnoZFjj2RS8eTd8zzHwKhAwr+/weF/33OD8Co
         Rqc0wbQ2QcAt5wRHvpD7u8wdm1T9g0bvYYejiP+YEQSvUM7y5trdEHGgksX24N2edK
         idMWT8wj1DAb4TtdQjDJT855wk+2RZXNuSxRN8Eg=
Date:   Fri, 11 Jan 2019 03:23:40 -0500
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        b-liu@ti.com, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
Message-ID: <20190111082340.GB32268@localhost.localdomain>
References: <20190109070856.27460-5-paul.elder@ideasonboard.com>
 <Pine.LNX.4.44L0.1901091359020.1205-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901091359020.1205-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 02:06:31PM -0500, Alan Stern wrote:
> On Wed, 9 Jan 2019, Paul Elder wrote:
> 
> > A usb gadget function driver may or may not want to delay the status
> > stage of a control OUT request. An instance where it might want to is to
> > asynchronously validate the data of a class-specific request.
> > 
> > A function driver that wants an explicit status stage should set the
> > newly added explicit_status flag of the usb_request corresponding to the
> > data stage. Later on, the function driver can explicitly complete the
> > status stage by enqueueing a usb_request for ACK, or calling
> > usb_ep_set_halt() for STALL.
> > 
> > To support both explicit and implicit status stages, a UDC driver must
> > call the newly added usb_gadget_control_complete function right before
> > calling usb_gadget_giveback_request. To support the explicit status
> > stage, it might then check what stage the usb_request was queued in, and
> > for control IN ACK the host's zero-length data packet, or for control
> > OUT send a zero-length DATA1 ACK packet.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > v4 Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> This looks good and has passed my tests so far.

Good! Thank you :)

> Can you check your uvc
> changes using dummy_hcd with the patch below?

I'm not sure what to make of the test results. I get the same results
with or without the patch. Which I guess makes sense... in dummy_queue,
this is getting hit when the uvc function driver tries to complete the
delayed status:

	req = usb_request_to_dummy_request(_req);
	if (!_req || !list_empty(&req->queue) || !_req->complete)
		return -EINVAL;

So the delayed/explicit status stage is never completed, afaict.

Paul
