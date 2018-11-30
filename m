Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AF1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27072145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27072145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeK3UxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:53:09 -0500
Received: from verein.lst.de ([213.95.11.211]:49229 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeK3UxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:53:09 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 10C1168BDF; Fri, 30 Nov 2018 10:44:25 +0100 (CET)
Date:   Fri, 30 Nov 2018 10:44:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tomasz Figa <tfiga@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181130094425.GA21729@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local> <20181129165715.GA27786@lst.de> <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com> <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com> <20181130093527.GR21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130093527.GR21184@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:35:27AM +0100, Daniel Vetter wrote:
> > Whether the cache maintenance operation needs to actually do anything
> > or not is a function of `dev`. We can have some devices that are
> > coherent with CPU caches, and some that are not, on the same system.
> 
> So the thing is that the gpu driver knows this too. It fairly often can
> even decide at runtime (through surface state bits or gpu pte bits)
> whether to use coherent or non-coherent transactions. dma-api assuming
> that a given device is always coherent or non-coherent is one of the
> fundamental mismatches we have.
> 
> If you otoh need dev because there's some strange bridge caches you need
> to flush (I've never seen that, but who knows), that would be a diffeernt
> thing. All the bridge flushing I've seen is attached to the iommu though,
> so would be really a surprise if the cache management needs that too.

Strange bridge caches aren't the problem.  Outside of magic components
like SOCs integrated GPUs the issue is that a platform can wire up a
PCIe/AXI/etc bus either so that it is cache coherent, or not cache
coherent (does not snooping).  Drivers need to use the full DMA API
include dma_sync_* to cater for the non-coherent case, which will turn
into no-ops if DMA is coherent.

Now PCIe now has unsnooped transactions, which can be non-coherent even
if the bus would otherwise be coherent.  We have so far very much
ignored those in Linux (at least Linux in general, I know you guys have
some driver-local hacks), but if that use case, or similar ones for GPUs
on SOCs become common we need to find a solution.

One of the major issues here is that architectures that always are
DMA coherent might not even have the cache flushing instructions, or even
if they do we have not wired them up in the DMA code as we didn't need
them.

So what we'd need to support this properly is to do something like:

 - add new arch hook that allows an architecture to say it supports
   optional non-coherent at the arch level, and for a given device
 - wire up arch_sync_dma_for_{device,cpu} for those architectures that
   define it if they don't currently have it (e.g. x86)
 - add a new DMA_ATTR_* flag to opt into cache flushing even if the
   device declares it is otherwise coherent

And I'd really like to see that work driven by an actual user.
