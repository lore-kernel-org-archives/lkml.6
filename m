Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AF0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2056D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TPDmlZ4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfAKIn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:43:57 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51540 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAKIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:43:57 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2959547;
        Fri, 11 Jan 2019 09:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547196234;
        bh=xnsY6Qa5b4FsbIRZrB5tyRpiIjdtn3sW2YqJ4YCbtXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPDmlZ4blXNj5eSpH3ktUW6hH+ZphFYUXAds+x1taQYCgjJPbUtc6zJBkp7CUbuf5
         FyBQRSWwFg7F7KqwvnVTElFTbK9SU8J5Rfip6qIesX/B0Ybe7bkCmb1ifp0ZFlR0ia
         BaqAxbTTdTsYZrH0lZIGkKZ36+4JtHEdktcA0Wmo=
Date:   Fri, 11 Jan 2019 03:43:46 -0500
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        b-liu@ti.com, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] usb: gadget: add mechanism to asynchronously
 validate data stage of ctrl out request
Message-ID: <20190111084346.GC32268@localhost.localdomain>
References: <20190109070856.27460-1-paul.elder@ideasonboard.com>
 <Pine.LNX.4.44L0.1901101520090.1206-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901101520090.1206-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:39:25PM -0500, Alan Stern wrote:
> On Wed, 9 Jan 2019, Paul Elder wrote:
> 
> > This patch series adds a mechanism to allow asynchronously validating
> > the data stage of a control OUT request, and for stalling or suceeding
> > the request accordingly.
> 
> One thing we haven't mentioned explicitly: What should happen when the 
> time for the status stage rolls around if the gadget driver queues a 
> non-zero length request?

Ah, yeah, I missed that.

> This can happen in a few different ways.  One obvious possibility is
> that the gadget driver sets the explicit_status flag and then submits a
> non-zero length request.  Another is that the gadget driver submits
> _two_ requests during the data stage (the second would be interpreted
> as the status-stage request).  A third is that the gadget driver
> submits a data-stage request that is too long and the excess portion is
> used for the status stage.
> 
> My feeling is that the behavior in these cases should officially be
> undefined.  Almost anything could happen: the status stage could STALL,
> it could succeed, it could NAK, or it could send a non-zero packet to
> the host.  The request could return with 0 status or an error status,
> and req->actual could take on any reasonable value.
> 
> Alternatively, the UDC driver could detect these errors and report them 
> somehow.  Maybe STALL the status stage and complete the request with 
> -EPIPE status or some such thing.
> 
> Any preferences or other ideas?

I think error detection and reporting would be useful. The question is
what action to take after that; either leave it undefined or STALL. I
think STALL would be fine, since if a non-zero length request is
submitted for a status stage, intentionally or not, it isn't part of
proper behavior and should count as an error.

> One other thing: Some UDC drivers may assume that the data stage of a 
> control transfer never spans more than a single usb_request.  Should 
> this become an official requirement?

Would the data stage of a control transfer ever need more space than a
single usb_request can contain? I know UVC doesn't; that's why we pack
it together with the setup stage data in 3/6. If so, I would think we
can make it a requirement.


Paul
