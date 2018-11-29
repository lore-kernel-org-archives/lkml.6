Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE013C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5812145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5812145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbeK3EDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:03:19 -0500
Received: from verein.lst.de ([213.95.11.211]:44682 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbeK3EDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:03:18 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3133B68B02; Thu, 29 Nov 2018 17:57:15 +0100 (CET)
Date:   Thu, 29 Nov 2018 17:57:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, "Clark, Rob" <robdclark@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, vivek.gautam@codeaurora.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181129165715.GA27786@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129162807.GL21184@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 05:28:07PM +0100, Daniel Vetter wrote:
> Just spend a bit of time reading through the implementations already
> merged. Is the struct device *dev parameter actually needed anywhere?
> dma-api definitely needs it, because we need that to pick the right iommu.
> But for cache management from what I've seen the target device doesn't
> matter, all the target specific stuff will be handled by the iommu.

It looks like only mips every uses the dev argument, and even there
the function it passes dev to ignores it.  So it could probably be removed.

> 
> Dropping the dev parameter would make this a perfect fit for coherency
> management of buffers used by multiple devices. Right now there's all
> kinds of nasty tricks for that use cases needed to avoid redundant
> flushes.

Note that one thing I'd like to avoid is exposing these funtions directly
to drivers, as that will get us into all kinds of abuses.

So I'd much prefer if we could have iommu APIs wrapping these that are
specific to actual uses cases that we understand well.

As for the buffer sharing: at least for the DMA API side I want to
move the current buffer sharing users away from dma_alloc_coherent
(and coherent dma_alloc_attrs users) and the remapping done in there
required for non-coherent architectures.  Instead I'd like to allocate
plain old pages, and then just dma map them for each device separately,
with DMA_ATTR_SKIP_CPU_SYNC passed for all but the first user to map
or last user to unmap.  On the iommu side it could probably work
similar.

I have done some preliminary work on this, and want to get it into this
merge window, but there is a few other bits I need to sort out first.

> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
---end quoted text---
