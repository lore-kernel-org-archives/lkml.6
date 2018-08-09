Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37444C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0EC21D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0EC21D68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeHIQhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:37:23 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48784 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730813AbeHIQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:37:23 -0400
Received: (qmail 1880 invoked by uid 2102); 9 Aug 2018 10:12:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2018 10:12:18 -0400
Date:   Thu, 9 Aug 2018 10:12:18 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
cc:     Keiichi Watanabe <keiichiw@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        <kieran.bingham@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        <ezequiel@collabora.com>, <matwey@sai.msu.ru>
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before
 processing
In-Reply-To: <14751117.J1GmkhZxMo@avalon>
Message-ID: <Pine.LNX.4.44L0.1808091005210.1549-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2018, Laurent Pinchart wrote:

> > >> There is no need to wonder.  "Frequent DMA mapping/Cached memory" is
> > >> always faster than "No DMA mapping/Uncached memory".
> > > 
> > > Is it really, doesn't it depend on the CPU access pattern ?
> > 
> > Well, if your access pattern involves transferring data in from the
> > device and then throwing it away without reading it, you might get a
> > different result.  :-)  But assuming you plan to read the data after
> > transferring it, using uncached memory slows things down so much that
> > the overhead of DMA mapping/unmapping is negligible by comparison.
> 
> :-) I suppose it would also depend on the access pattern, if I only need to 
> access part of the buffer, performance figures may vary. In this case however 
> the whole buffer needs to be copied.
> 
> > The only exception might be if you were talking about very small
> > amounts of data.  I don't know exactly where the crossover occurs, but
> > bear in mind that Matwey's tests required ~50 us for mapping/unmapping
> > and 3000 us for accessing uncached memory.  He didn't say how large the
> > transfers were, but that's still a pretty big difference.
> 
> For UVC devices using bulk endpoints data buffers are typically tens of kBs. 
> For devices using isochronous endpoints, that goes down to possibly hundreds 
> of bytes for some buffers. Devices can send less data than the maximum packet 
> size, and mapping/unmapping would still invalidate the cache for the whole 
> buffer. If we keep the mappings around and use the DMA sync API, we could 
> possibly restrict the cache invalidation to the portion of the buffer actually 
> written to.

Furthermore, invalidating a cache is likely to require less overhead
than using non-cacheable memory.  After the cache has been invalidated,
it can be repopulated relatively quickly (an entire cache line at a
time), whereas reading uncached memory requires a slow transaction for
each individual read operation.

I think adding support to the USB core for 
dma_sync_single_for_{cpu|device} would be a good approach.  In fact, I 
wonder whether using coherent mappings provides any benefit at all.

Alan Stern

