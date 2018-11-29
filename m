Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE09C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2D321104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2D321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeK3Fjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:39:54 -0500
Received: from verein.lst.de ([213.95.11.211]:45492 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeK3Fjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:39:54 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8723468BDF; Thu, 29 Nov 2018 19:33:34 +0100 (CET)
Date:   Thu, 29 Nov 2018 19:33:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christoph Hellwig <hch@lst.de>, "Clark, Rob" <robdclark@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, vivek.gautam@codeaurora.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181129183334.GB30281@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local> <20181129165715.GA27786@lst.de> <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:09:05PM +0100, Daniel Vetter wrote:
> What kind of abuse do you expect? It could very well be that gpu folks
> call that "standard use case" ... At least on x86 with the i915 driver
> we pretty much rely on architectural guarantees for how cache flushes
> work very much. Down to userspace doing the cache flushing for
> mappings the kernel has set up.

Mostly the usual bypasses of the DMA API because people know better
(and with that I don't mean low-level IOMMU API users, but "creative"
direct mappings).

> > As for the buffer sharing: at least for the DMA API side I want to
> > move the current buffer sharing users away from dma_alloc_coherent
> > (and coherent dma_alloc_attrs users) and the remapping done in there
> > required for non-coherent architectures.  Instead I'd like to allocate
> > plain old pages, and then just dma map them for each device separately,
> > with DMA_ATTR_SKIP_CPU_SYNC passed for all but the first user to map
> > or last user to unmap.  On the iommu side it could probably work
> > similar.
> 
> I think this is what's often done. Except then there's also the issue
> of how to get at the cma allocator if your device needs something
> contiguous. There's a lot of that still going on in graphics/media.

Being able to dip into CMA and mayb iommu coalescing if we want to
get fancy is indeed the only reason for this API.  If we just wanted
to map pages we could already do that now with just a little bit
of boilerplate code (and quite a few drivers do - just adding this
new API will remove tons of code).
