Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27388C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F200521738
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfARQw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:52:58 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44498 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727481AbfARQw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:52:58 -0500
Received: (qmail 4237 invoked by uid 2102); 18 Jan 2019 11:52:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jan 2019 11:52:57 -0500
Date:   Fri, 18 Jan 2019 11:52:57 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
In-Reply-To: <20190118163106.GC7331@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1901181148100.1425-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Paul Elder wrote:

> > > I meant the functions (procedures) in the function driver, so the setup
> > > handler (uvc_function_setup), the completion handler
> > > (uvc_function_ep0_complete), and the status sender (uvc_send_response),
> > > although the last one actually sends the data stage for control IN.
> > > So after the status is sent on the uvc gadget driver's end, its
> > > completion handler is called again without the setup handler being
> > > called beforehand and I cant figure out why.
> > 
> > Isn't this what you should expect?  Every usb_request, if it is queued
> > successfully, eventually gets a completion callback.  That promise is
> > made by every UDC driver; it's part of the gadget API.  So for a
> > control transfer with a data stage, you expect to have:
> > 
> > 	Setup handler called
> > 	Data-stage request submitted
> > 	Data-stage request completion callback
> > 	Status-stage request submitted
> > 	Status-stage request completion callback
> > 
> > Thus, two completion callbacks but only one setup callback.
> 
> omg how did I not notice this :/
> 
> I guess I have to fix the uvc function driver so it works with that.
> musb doesn't call the status stage completion callback though; not that
> it does anything so it seems fine to me, but indeed the function driver
> has to be ready for it if it is called.

musb _has_ to call the status-stage completion callback.  As just one
reason, if the explicit_status flag isn't set then that callback is
responsible for deallocating the status request.  Without it, the
status request will leak.

Alan Stern

