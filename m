Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039B9205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbfAKSc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:32:57 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44562 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1733084AbfAKSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:32:56 -0500
Received: (qmail 5483 invoked by uid 2102); 11 Jan 2019 13:32:56 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2019 13:32:56 -0500
Date:   Fri, 11 Jan 2019 13:32:55 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] usb: gadget: add mechanism to asynchronously
 validate data stage of ctrl out request
In-Reply-To: <20190111084346.GC32268@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1901111328390.1501-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, Paul Elder wrote:

> On Thu, Jan 10, 2019 at 03:39:25PM -0500, Alan Stern wrote:
> > On Wed, 9 Jan 2019, Paul Elder wrote:
> > 
> > > This patch series adds a mechanism to allow asynchronously validating
> > > the data stage of a control OUT request, and for stalling or suceeding
> > > the request accordingly.
> > 
> > One thing we haven't mentioned explicitly: What should happen when the 
> > time for the status stage rolls around if the gadget driver queues a 
> > non-zero length request?
> 
> Ah, yeah, I missed that.
> 
> > This can happen in a few different ways.  One obvious possibility is
> > that the gadget driver sets the explicit_status flag and then submits a
> > non-zero length request.  Another is that the gadget driver submits
> > _two_ requests during the data stage (the second would be interpreted
> > as the status-stage request).  A third is that the gadget driver
> > submits a data-stage request that is too long and the excess portion is
> > used for the status stage.
> > 
> > My feeling is that the behavior in these cases should officially be
> > undefined.  Almost anything could happen: the status stage could STALL,
> > it could succeed, it could NAK, or it could send a non-zero packet to
> > the host.  The request could return with 0 status or an error status,
> > and req->actual could take on any reasonable value.
> > 
> > Alternatively, the UDC driver could detect these errors and report them 
> > somehow.  Maybe STALL the status stage and complete the request with 
> > -EPIPE status or some such thing.
> > 
> > Any preferences or other ideas?
> 
> I think error detection and reporting would be useful. The question is
> what action to take after that; either leave it undefined or STALL. I
> think STALL would be fine, since if a non-zero length request is
> submitted for a status stage, intentionally or not, it isn't part of
> proper behavior and should count as an error.

Okay; I will have to change the code in dummy-hcd to do this.  You
might need to update musb as well.

> > One other thing: Some UDC drivers may assume that the data stage of a 
> > control transfer never spans more than a single usb_request.  Should 
> > this become an official requirement?
> 
> Would the data stage of a control transfer ever need more space than a
> single usb_request can contain? I know UVC doesn't; that's why we pack
> it together with the setup stage data in 3/6. If so, I would think we
> can make it a requirement.

The data stage of a control transfer cannot be larger than 64 KB.  
Certainly a single usb_request can handle that; the question concerns
whether a function driver might want to split the data up among several
different requests just for convenience.

Felipe, any thoughts?

Alan Stern

