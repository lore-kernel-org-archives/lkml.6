Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B489CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89214206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393884AbfAPPGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:06:54 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57408 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387554AbfAPPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:06:54 -0500
Received: (qmail 2345 invoked by uid 2102); 16 Jan 2019 10:06:53 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2019 10:06:53 -0500
Date:   Wed, 16 Jan 2019 10:06:53 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
In-Reply-To: <20190116050029.GA13084@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.1901160959290.1610-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Paul Elder wrote:

> On Mon, Jan 14, 2019 at 10:24:44AM -0500, Alan Stern wrote:
> > On Mon, 14 Jan 2019, Paul Elder wrote:
> > 
> > > > > > Can you check your uvc
> > > > > > changes using dummy_hcd with the patch below?
> > > > > 
> > > > > I'm not sure what to make of the test results. I get the same results
> > > > > with or without the patch. Which I guess makes sense... in dummy_queue,
> > > > > this is getting hit when the uvc function driver tries to complete the
> > > > > delayed status:
> > > > > 
> > > > > 	req = usb_request_to_dummy_request(_req);
> > > > > 	if (!_req || !list_empty(&req->queue) || !_req->complete)
> > > > > 		return -EINVAL;
> > > > > 
> > > > > So the delayed/explicit status stage is never completed, afaict.
> > > > 
> > > > I presume you are hitting the !list_empty(&req->queue) test, yes?  The 
> > > > other two tests are trivial.
> > > 
> > > Yes, that is what's happening.
> > > 
> > > > Triggering the !list_empty() test means the request has already been
> > > > submitted and not yet completed.  This probably indicates there is a
> > > > bug in the uvc function driver code.
> > > 
> > > The uvc function driver works with musb, though :/
> > > 
> > > I compared the sequence of calls to the uvc setup, completion handler,
> > > and status stage sending, and for some reason dummy_hcd, after an OUT
> > > setup-completion-status sequence, calls a completion-status-completion
> > > sequence, and then goes on the the next request. musb simply goes on to
> > > the next request after the setup-completion-status sequence.
> > 
> > I don't quite understand.  There's a control-OUT transfer, the setup, 
> > data, and status transactions all complete normally, and then what 
> > happens?  What do you mean by "a completion-status-completion 
> > sequence"?  A more detailed description would help.
> > 
> 
> I meant the functions (procedures) in the function driver, so the setup
> handler (uvc_function_setup), the completion handler
> (uvc_function_ep0_complete), and the status sender (uvc_send_response),
> although the last one actually sends the data stage for control IN.
> So after the status is sent on the uvc gadget driver's end, its
> completion handler is called again without the setup handler being
> called beforehand and I cant figure out why.

Isn't this what you should expect?  Every usb_request, if it is queued
successfully, eventually gets a completion callback.  That promise is
made by every UDC driver; it's part of the gadget API.  So for a
control transfer with a data stage, you expect to have:

	Setup handler called
	Data-stage request submitted
	Data-stage request completion callback
	Status-stage request submitted
	Status-stage request completion callback

Thus, two completion callbacks but only one setup callback.

> > > I commented out the paranoia block in dummy_timer, and dummy_hcd still
> > > does the extra completion, but it doesn't error out anymore. I doubt
> > > that's the/a solution though, especially since I get:
> > > 
> > > [   22.616577] uvcvideo: Failed to query (129) UVC probe control : -75 (exp. 26).
> > > [   22.624481] uvcvideo: Failed to initialize the device (-5).
> > > 
> > > Not sure if that's a result of dummy_hcd not supporting isochronous
> > > transfers or not.
> > > 
> > > I'm not sure where to continue investigating :/
> > 
> > Perhaps removing the "#if 0" protecting the dev_dbg line in 
> > dummy_queue() would provide some helpful output.
> 
> It did, but didn't get me much farther :/
> 
> > Another thing to check would be if the "implement an emulated 
> > single-request FIFO" in dummy_queue() is causing trouble.  There's no 
> > harm in replacing the long "if" condition with "if (0)".
> 
> That didn't change anything.
> 
> Although I did notice that the dummy_queue that calls the completion
> handler without the preceeding setup handler says that it's in the
> status stage (ep->status_stage == 1).

That is consistent with the events outlined above.

Alan Stern

