Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D9AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D1521019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D1521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeK3FlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:41:25 -0500
Received: from verein.lst.de ([213.95.11.211]:45508 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeK3FlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:41:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5FE3368BDF; Thu, 29 Nov 2018 19:35:06 +0100 (CET)
Date:   Thu, 29 Nov 2018 19:35:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20181129183506.GC30281@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local> <20181129165715.GA27786@lst.de> <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com> <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:24:17AM -0800, Tomasz Figa wrote:
> Whether the cache maintenance operation needs to actually do anything
> or not is a function of `dev`. We can have some devices that are
> coherent with CPU caches, and some that are not, on the same system.

Yes, but that part is not decided by these low-level helpers but their
callers in the DMA code (or maybe IOMMU code as well in the future).

> There is also the use case of using CMA with device-specific pools of
> memory reusable by the system when not used by the device and those
> would have to somehow get the pool to allocate from, but I wonder if
> struct device is the right way to pass such information. I'd see the
> pool given explicitly like cma_alloc(struct cma_pool *, size, flags)
> and perhaps a wrapper cma_alloc_default(size, flags) that is just a
> simple macro calling cma_alloc(&cma_pool_default, size, flags).

Yes, the cma APIs have quite a few warts that need addressing.
I have a few of those things on my todo list, but help is always
welcome.
