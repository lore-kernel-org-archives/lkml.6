Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F027C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F238A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U3bMpzTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfARQbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:31:18 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53804 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfARQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:31:18 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E642153E;
        Fri, 18 Jan 2019 17:31:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547829075;
        bh=8hr+puCZKU3CkrjGCLHvQPZ4wsY5ygkfShhzYrcLtgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3bMpzTXF2MmTDhR/baQlxW7nGIo2hBsH4DFYjZ5dOBjLHZCnrq9vzD3TRDi44E7b
         q5VhRRI3eqcc84O7OUXtLQ4xoFVUsukzjOlPdHjx82u9qdIOgH2vifv5oSQOsX8aPa
         MNRLM45UrIycGtY/B+aHggs+RfHEdrAneQ5Wxpxs=
Date:   Fri, 18 Jan 2019 11:31:06 -0500
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        b-liu@ti.com, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
Message-ID: <20190118163106.GC7331@localhost.localdomain>
References: <20190116050029.GA13084@localhost.localdomain>
 <Pine.LNX.4.44L0.1901160959290.1610-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901160959290.1610-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:06:53AM -0500, Alan Stern wrote:
> On Wed, 16 Jan 2019, Paul Elder wrote:
> 
> > On Mon, Jan 14, 2019 at 10:24:44AM -0500, Alan Stern wrote:
> > > On Mon, 14 Jan 2019, Paul Elder wrote:
> > > 
> > > > > > > Can you check your uvc
> > > > > > > changes using dummy_hcd with the patch below?
> > > > > > 
> > > > > > I'm not sure what to make of the test results. I get the same results
> > > > > > with or without the patch. Which I guess makes sense... in dummy_queue,
> > > > > > this is getting hit when the uvc function driver tries to complete the
> > > > > > delayed status:
> > > > > > 
> > > > > > 	req = usb_request_to_dummy_request(_req);
> > > > > > 	if (!_req || !list_empty(&req->queue) || !_req->complete)
> > > > > > 		return -EINVAL;
> > > > > > 
> > > > > > So the delayed/explicit status stage is never completed, afaict.
> > > > > 
> > > > > I presume you are hitting the !list_empty(&req->queue) test, yes?  The 
> > > > > other two tests are trivial.
> > > > 
> > > > Yes, that is what's happening.
> > > > 
> > > > > Triggering the !list_empty() test means the request has already been
> > > > > submitted and not yet completed.  This probably indicates there is a
> > > > > bug in the uvc function driver code.
> > > > 
> > > > The uvc function driver works with musb, though :/
> > > > 
> > > > I compared the sequence of calls to the uvc setup, completion handler,
> > > > and status stage sending, and for some reason dummy_hcd, after an OUT
> > > > setup-completion-status sequence, calls a completion-status-completion
> > > > sequence, and then goes on the the next request. musb simply goes on to
> > > > the next request after the setup-completion-status sequence.
> > > 
> > > I don't quite understand.  There's a control-OUT transfer, the setup, 
> > > data, and status transactions all complete normally, and then what 
> > > happens?  What do you mean by "a completion-status-completion 
> > > sequence"?  A more detailed description would help.
> > > 
> > 
> > I meant the functions (procedures) in the function driver, so the setup
> > handler (uvc_function_setup), the completion handler
> > (uvc_function_ep0_complete), and the status sender (uvc_send_response),
> > although the last one actually sends the data stage for control IN.
> > So after the status is sent on the uvc gadget driver's end, its
> > completion handler is called again without the setup handler being
> > called beforehand and I cant figure out why.
> 
> Isn't this what you should expect?  Every usb_request, if it is queued
> successfully, eventually gets a completion callback.  That promise is
> made by every UDC driver; it's part of the gadget API.  So for a
> control transfer with a data stage, you expect to have:
> 
> 	Setup handler called
> 	Data-stage request submitted
> 	Data-stage request completion callback
> 	Status-stage request submitted
> 	Status-stage request completion callback
> 
> Thus, two completion callbacks but only one setup callback.

omg how did I not notice this :/

I guess I have to fix the uvc function driver so it works with that.
musb doesn't call the status stage completion callback though; not that
it does anything so it seems fine to me, but indeed the function driver
has to be ready for it if it is called.

> > > > I commented out the paranoia block in dummy_timer, and dummy_hcd still
> > > > does the extra completion, but it doesn't error out anymore. I doubt
> > > > that's the/a solution though, especially since I get:
> > > > 
> > > > [   22.616577] uvcvideo: Failed to query (129) UVC probe control : -75 (exp. 26).
> > > > [   22.624481] uvcvideo: Failed to initialize the device (-5).
> > > > 
> > > > Not sure if that's a result of dummy_hcd not supporting isochronous
> > > > transfers or not.
> > > > 
> > > > I'm not sure where to continue investigating :/
> > > 
> > > Perhaps removing the "#if 0" protecting the dev_dbg line in 
> > > dummy_queue() would provide some helpful output.
> > 
> > It did, but didn't get me much farther :/
> > 
> > > Another thing to check would be if the "implement an emulated 
> > > single-request FIFO" in dummy_queue() is causing trouble.  There's no 
> > > harm in replacing the long "if" condition with "if (0)".
> > 
> > That didn't change anything.
> > 
> > Although I did notice that the dummy_queue that calls the completion
> > handler without the preceeding setup handler says that it's in the
> > status stage (ep->status_stage == 1).
> 
> That is consistent with the events outlined above.


Thanks,

Paul
