Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22465C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7DF20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LtaEkGAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfATR7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:59:40 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:37794 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfATR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:59:39 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2020441;
        Sun, 20 Jan 2019 18:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548007177;
        bh=NZKxA8iCufbOY9AOA0y8QkiK/5zr7vkaHb9+RHxdPcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtaEkGAdqnxL3/0JDRwQeU7L5qo64QEb+JqqgKOsLqJEILbEgShsNRLr8G4FW6oga
         sD4kn+0qxwhfLJvnRpMoBGZV5ol6pKdxu7mCdCJTPSurKSrNOABTXNXlBFjmVekXaZ
         EG//VxTU+Ws6WWQdFnlzr6p7VISQVi3ShPAeJYDA=
Date:   Sun, 20 Jan 2019 12:59:29 -0500
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        b-liu@ti.com, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
Message-ID: <20190120175929.GF7331@localhost.localdomain>
References: <20190118163106.GC7331@localhost.localdomain>
 <Pine.LNX.4.44L0.1901181148100.1425-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901181148100.1425-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:52:57AM -0500, Alan Stern wrote:
> On Fri, 18 Jan 2019, Paul Elder wrote:
> 
> > > > I meant the functions (procedures) in the function driver, so the setup
> > > > handler (uvc_function_setup), the completion handler
> > > > (uvc_function_ep0_complete), and the status sender (uvc_send_response),
> > > > although the last one actually sends the data stage for control IN.
> > > > So after the status is sent on the uvc gadget driver's end, its
> > > > completion handler is called again without the setup handler being
> > > > called beforehand and I cant figure out why.
> > > 
> > > Isn't this what you should expect?  Every usb_request, if it is queued
> > > successfully, eventually gets a completion callback.  That promise is
> > > made by every UDC driver; it's part of the gadget API.  So for a
> > > control transfer with a data stage, you expect to have:
> > > 
> > > 	Setup handler called
> > > 	Data-stage request submitted
> > > 	Data-stage request completion callback
> > > 	Status-stage request submitted
> > > 	Status-stage request completion callback
> > > 
> > > Thus, two completion callbacks but only one setup callback.
> > 
> > omg how did I not notice this :/
> > 
> > I guess I have to fix the uvc function driver so it works with that.
> > musb doesn't call the status stage completion callback though; not that
> > it does anything so it seems fine to me, but indeed the function driver
> > has to be ready for it if it is called.
> 
> musb _has_ to call the status-stage completion callback.  As just one
> reason, if the explicit_status flag isn't set then that callback is
> responsible for deallocating the status request.  Without it, the
> status request will leak.

Ah, I see what you mean. I forgot about that because we reuse the
request in uvc gadget. I'll have to add the status stage completion
callback to musb too, then.


Thanks,

Paul
