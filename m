Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2E5213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfAJUj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:39:27 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43862 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729743AbfAJUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:39:26 -0500
Received: (qmail 3142 invoked by uid 2102); 10 Jan 2019 15:39:25 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jan 2019 15:39:25 -0500
Date:   Thu, 10 Jan 2019 15:39:25 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] usb: gadget: add mechanism to asynchronously
 validate data stage of ctrl out request
In-Reply-To: <20190109070856.27460-1-paul.elder@ideasonboard.com>
Message-ID: <Pine.LNX.4.44L0.1901101520090.1206-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Paul Elder wrote:

> This patch series adds a mechanism to allow asynchronously validating
> the data stage of a control OUT request, and for stalling or suceeding
> the request accordingly.

One thing we haven't mentioned explicitly: What should happen when the 
time for the status stage rolls around if the gadget driver queues a 
non-zero length request?

This can happen in a few different ways.  One obvious possibility is
that the gadget driver sets the explicit_status flag and then submits a
non-zero length request.  Another is that the gadget driver submits
_two_ requests during the data stage (the second would be interpreted
as the status-stage request).  A third is that the gadget driver
submits a data-stage request that is too long and the excess portion is
used for the status stage.

My feeling is that the behavior in these cases should officially be
undefined.  Almost anything could happen: the status stage could STALL,
it could succeed, it could NAK, or it could send a non-zero packet to
the host.  The request could return with 0 status or an error status,
and req->actual could take on any reasonable value.

Alternatively, the UDC driver could detect these errors and report them 
somehow.  Maybe STALL the status stage and complete the request with 
-EPIPE status or some such thing.

Any preferences or other ideas?

One other thing: Some UDC drivers may assume that the data stage of a 
control transfer never spans more than a single usb_request.  Should 
this become an official requirement?

Alan Stern

