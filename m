Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D8AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B835F206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeLNPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:35:59 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59568 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726494AbeLNPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:35:59 -0500
Received: (qmail 3050 invoked by uid 2102); 14 Dec 2018 10:35:58 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Dec 2018 10:35:58 -0500
Date:   Fri, 14 Dec 2018 10:35:58 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, <kieran.bingham@ideasonboard.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rogerq@ti.com>
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
In-Reply-To: <20181214034754.GB7477@garnet.amanokami.net>
Message-ID: <Pine.LNX.4.44L0.1812141034280.1570-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018, Paul Elder wrote:

> > Suppose we have a core library routine like this:
> > 
> > void usb_gadget_control_complete(struct usb_gadget *gadget,
> > 		unsigned int no_implicit_status, int status)
> > {
> > 	struct usb_request *req;
> > 
> > 	if (no_implicit_status || status != 0)
> > 		return;
> > 
> > 	/* Send an implicit status-stage request for ep0 */
> > 	req = usb_ep_alloc_request(gadget->ep0, GFP_ATOMIC);
> > 	if (req) {
> > 		req->length = 0;
> > 		req->no_implicit_status = 1;
> > 		req->complete = /* req's deallocation routine */
> > 		usb_ep_queue(gadget->ep0, req, GFP_ATOMIC);
> > 	}
> > }
> > 
> > Then all a UDC driver would need to do is call 
> > usb_gadget_control_complete() after invoking a control request's 
> > completion handler.  The no_implicit_status and status arguments would 
> > be taken from the request that was just completed.
> > 
> > With this one call added to each UDC, all the existing function drivers
> > would work correctly.  Even though they don't explicitly queue
> > status-stage requests, the new routine will do so for them,
> > transparently.  Function drivers that want to handle their own
> > status-stage requests explicitly will merely have to set the
> > req->no_implicit_status bit.
> 
> I think this is a good idea. We still get the benefits of explicit
> status stage without being overly intrusive in the conversion, and we
> maintain the queue-based API.
> 
> Would it be fine for me to proceed in this direction for a v2?

It is as far as I'm concerned (Felipe might not agree).  Knock yourself
out.  :-)

Alan Stern

> > (We might or might not need to watch out for 0-length control-OUT 
> > transfers.  Function drivers _do_ queue status-stage requests for 
> > those.)
> 
> Thanks,
> 
> Paul Elder

