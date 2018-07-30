Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE17160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D4F20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D0cuvei0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D4F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeG3Qs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:48:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40620 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeG3Qs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:48:27 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C344E1AC2;
        Mon, 30 Jul 2018 17:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532963578;
        bh=Lz1jDy6QEChL/c182Ed3yFpknCudxiEymd1TRQtdtLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0cuvei0Dzh2KyAQXP9sKqQc3TQY6/4ycwwo4IzeA9HCw/7OuZ7xTsZW1E4ZURWhA
         f1q7ml0gkejfwOeG63Vg2fzvfkeLnDoCwQzOnSJecFS2jGPApLcaOHJeaapeIq+iKK
         DxlKgQ4RJzkQk/1MEVcN6Nv57OFF3hyPCV/dm44w=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>, hdegoede@redhat.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        rostedt@goodmis.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Mon, 30 Jul 2018 18:13:36 +0300
Message-ID: <1574162.OdDEHZcMxN@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAAFQd5Bwokm4GH5qXTDFCyH=cN2T-r5bR4F036-TGA+CK77MCA@mail.gmail.com>
References: <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com> <CAJs94EY4x7GWuT1tF4cPquLRDFR060CuZAxS75nhOf0deYbG2w@mail.gmail.com> <CAAFQd5Bwokm4GH5qXTDFCyH=cN2T-r5bR4F036-TGA+CK77MCA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Friday, 20 July 2018 14:33:33 EEST Tomasz Figa wrote:
> On Fri, Jul 20, 2018 at 8:23 PM Matwey V. Kornilov wrote:
> > 2018-07-20 13:55 GMT+03:00 Tomasz Figa:
> >> On Wed, Jul 18, 2018 at 5:51 AM Alan Stern wrote:
> >>> On Tue, 17 Jul 2018, Ezequiel Garcia wrote:
> >>>> Hi Matwey,
> >>>> 
> >>>> First of all, sorry for the delay.
> >>>> 
> >>>> Adding Alan and Hans. Guys, do you have any feedback here?
> >>> 
> >>> ...
> >>> 
> >>>>>> So, what is the benefit of using consistent
> >>>>>> for these URBs, as opposed to streaming?
> >>>>> 
> >>>>> I don't know, I think there is no real benefit and all we see is a
> >>>>> consequence of copy-pasta when some webcam drivers were inspired by
> >>>>> others and development priparily was going at x86 platforms.
> >>>> 
> >>>> You are probably right about the copy-pasta.
> >>>> 
> >>>>> It would be great if somebody corrected me here. DMA Coherence is
> >>>>> quite strong property and I cannot figure out how can it help when
> >>>>> streaming video. The CPU host always reads from the buffer and never
> >>>>> writes to. Hardware perepherial always writes to and never reads from.
> >>>>> Moreover, buffer access is mutually exclusive and separated in time by
> >>>>> Interrupt fireing and URB starting (when we reuse existing URB for new
> >>>>> request). Only single one memory barrier is really required here.
> >>>> 
> >>>> Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
> >>>> create DMA mappings and use the streaming API. Which makes more
> >>>> sense in hardware without hardware coherency.
> >>> 
> >>> As far as I know, the _only_ advantage to using coherent DMA in this
> >>> situation is that you then do not have to pay the overhead of
> >>> constantly setting up and tearing down the streaming mappings.  So it
> >>> depends very much on the platform: If coherent buffers are cached then
> >>> it's a slight win and otherwise it's a big lose.
> >> 
> >> Isn't it about usb_alloc_coherent() being backed by DMA coherent API
> >> (dma_alloc_coherent/attrs()) and ending up allocating uncached (or
> >> write-combine) memory for devices with non-coherent DMAs? I'm not sure
> > 
> > Yes, this is what exactly happens at armv7l platforms.
> 
> Okay, thanks. So this seems to be exactly the same thing that is
> happening in the UVC driver. There is quite a bit of random accesses
> to extract some header fields and then a big memcpy into VB2 buffer to
> assemble final frame.
> 
> If we don't want to pay the cost of creating and destroying the
> streaming mapping, we could map (dma_map_single()) once, set
> transfer_dma of URB and URB_NO_TRANSFER_DMA_MAP and then just
> synchronize the caches (dma_sync_single()) before submitting/after
> completing the URB.

The problem is that the dma_sync_single() calls can end up being quite costly, 
depending on the platform, its cache architecture, and the buffer size. For a 
given system and use case we should always be able to decide which option is 
best, but finding that dynamically at runtime isn't an easy task. I remember 
that when developing the OMAP3 ISP driver at Nokia we had a heuristics that 
forced a full D-cache clean above a certain picture resolution as that was 
faster than selectively cleaning cache lines.

Furthermore, the DMA mapping API doesn't help us here, as it doesn't allow a 
platform to optimize operations based on the buffer mappings. An easy example 
is that there's no way for the DMA mapping implementation on ARM to find out 
in the dma_sync_single() operation that the buffer isn't mapped to the CPU and 
that the CPU cache clean can be skipped. This doesn't affect USB drivers as a 
CPU mapping always exists, but there could be some limitations there too when 
we'll try to optimize the implementation.

-- 
Regards,

Laurent Pinchart



