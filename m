Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA12B2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VGZ25KET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA12B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeK3UoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:44:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39105 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeK3UoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:44:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so4286237edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yC0+1puIkJteSCXc7iPJGS6CqG6Z+8FNYCwGrxTzTTY=;
        b=VGZ25KETL/rb9625pHxDfaiTUikfua7ZjClAcXTG1H45m9HPeERb0qUqadDF0Muedw
         NIo3+3DMc9SzQG74KygWHAvQnR99J1zsKw+W9ZGTSUbNQHa89aSy4PAcQAWUeD4/j1s0
         fysTJMR2w93NIeLJOJxdy2H2uva5qgLRJ58nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yC0+1puIkJteSCXc7iPJGS6CqG6Z+8FNYCwGrxTzTTY=;
        b=IJZKXi+MGXHRpExKFto/84vILJ2LI3OlyyzcSqNck6T9RoN3tMR+KqwR4MBVgyh98V
         UQamsfVbheehb81FWnkKtO061l4zPHIFo2gxTfgA4rgXN7Zv+pENIfkMsVkOP0Uo9ype
         WUvtQX0/ilEgVYL5MXKRlnlNfFFteFIm9ZIJufVEy+ayMVjQbSdd2doZmB67tGIcaCMb
         wafLH6aCT2KoOH3DBFP0RXENsqngoBzAMlxajRZWElxp6n2f+6B93ah4ZokSB6esQyTc
         G07edPcdl1HoyllBOcW9aPAoHtNHn/7c98v2j/bxjBlnIjmahrm8RC5q2i5BnYVr+20f
         PDrA==
X-Gm-Message-State: AA+aEWYHv24LCvgSiCQkNR4zkOUJ94lPpKf8nVyN+CkWuTZnMui7p+Ou
        STAcAdUbtD2///YxX7izH+2QZg==
X-Google-Smtp-Source: AFSGD/UsZEIB4a/KF6oUsPJBKuvLyVMrH1I7hXYgrNxyYLBd47v8i64Ntlv1ZGWmwuIFrvV3+Sti1A==
X-Received: by 2002:a50:b68a:: with SMTP id d10mr4714410ede.16.1543570530607;
        Fri, 30 Nov 2018 01:35:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p22-v6sm709764ejf.48.2018.11.30.01.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 01:35:29 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:35:27 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
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
Message-ID: <20181130093527.GR21184@phenom.ffwll.local>
Mail-Followup-To: Tomasz Figa <tfiga@chromium.org>,
        Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de>
 <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
 <20181129155758.GC26537@lst.de>
 <20181129162807.GL21184@phenom.ffwll.local>
 <20181129165715.GA27786@lst.de>
 <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
 <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:24:17AM -0800, Tomasz Figa wrote:
> [CC Marek]
> 
> On Thu, Nov 29, 2018 at 9:09 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Nov 29, 2018 at 5:57 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Thu, Nov 29, 2018 at 05:28:07PM +0100, Daniel Vetter wrote:
> > > > Just spend a bit of time reading through the implementations already
> > > > merged. Is the struct device *dev parameter actually needed anywhere?
> > > > dma-api definitely needs it, because we need that to pick the right iommu.
> > > > But for cache management from what I've seen the target device doesn't
> > > > matter, all the target specific stuff will be handled by the iommu.
> > >
> > > It looks like only mips every uses the dev argument, and even there
> > > the function it passes dev to ignores it.  So it could probably be removed.
> > >
> 
> Whether the cache maintenance operation needs to actually do anything
> or not is a function of `dev`. We can have some devices that are
> coherent with CPU caches, and some that are not, on the same system.

So the thing is that the gpu driver knows this too. It fairly often can
even decide at runtime (through surface state bits or gpu pte bits)
whether to use coherent or non-coherent transactions. dma-api assuming
that a given device is always coherent or non-coherent is one of the
fundamental mismatches we have.

If you otoh need dev because there's some strange bridge caches you need
to flush (I've never seen that, but who knows), that would be a diffeernt
thing. All the bridge flushing I've seen is attached to the iommu though,
so would be really a surprise if the cache management needs that too.
 
> > > >
> > > > Dropping the dev parameter would make this a perfect fit for coherency
> > > > management of buffers used by multiple devices. Right now there's all
> > > > kinds of nasty tricks for that use cases needed to avoid redundant
> > > > flushes.
> > >
> > > Note that one thing I'd like to avoid is exposing these funtions directly
> > > to drivers, as that will get us into all kinds of abuses.
> >
> > What kind of abuse do you expect? It could very well be that gpu folks
> > call that "standard use case" ... At least on x86 with the i915 driver
> > we pretty much rely on architectural guarantees for how cache flushes
> > work very much. Down to userspace doing the cache flushing for
> > mappings the kernel has set up.
> 
> i915 is a very specific case of a fully contained,
> architecture-specific hardware subsystem, where you can just hardcode
> all integration details inside the driver, because nobody else would
> care.

Nah, it's not fully contained, it's just with your arm eyewear on you
can't see how badly it leaks all over the place. The problem is that GPUs
(in many cases at least) want to decide whether and when to do cache
maintenance. We need a combo of iommu and cache maintenance apis that
allows this, across multiple devices, because the dma-api doesn't cut it.

Aside: The cache maintenance api _must_ do the flush when asked to, even
if it believes no cache maintenance is necessary. Even if the default mode
is coherent for a platform/dev combo, the gpu driver might want to do a
non-coherent transaction.

> In ARM world, you can have the same IP blocks licensed by multiple SoC
> vendors with different integration details and that often includes the
> option of coherency.

My experience is that for soc gpus, you need to retune up/download code
for every soc. Or at least every family of socs.

This is painful. I guess thus far the arm soc gpu drivers we have merged
aren't the ones that needed widely different tuning on different soc
families/ranges. What's worse, it's userspace who will decide whether to
use the coherent or non-coherent paths in many cases (that's at least how
it worked since decades on the big gpus, small gpus just lag a few years
usually). The kerenl only provides the tools for the userspace
opengl/vulkan driver to do all the things.

Trying to hide coherent vs. non-coherent like it's done for everyone else
is probably not going to work for gpus. In fact, hasn't ever worked for
gpus thus far, and unlikely to change I think.
-Daniel

> > > So I'd much prefer if we could have iommu APIs wrapping these that are
> > > specific to actual uses cases that we understand well.
> > >
> > > As for the buffer sharing: at least for the DMA API side I want to
> > > move the current buffer sharing users away from dma_alloc_coherent
> > > (and coherent dma_alloc_attrs users) and the remapping done in there
> > > required for non-coherent architectures.  Instead I'd like to allocate
> > > plain old pages, and then just dma map them for each device separately,
> > > with DMA_ATTR_SKIP_CPU_SYNC passed for all but the first user to map
> > > or last user to unmap.  On the iommu side it could probably work
> > > similar.
> >
> > I think this is what's often done. Except then there's also the issue
> > of how to get at the cma allocator if your device needs something
> > contiguous. There's a lot of that still going on in graphics/media.
> 
> I suppose one could just expose CMA with the default pool directly.
> It's just an allocator, so not sure why it would need any
> device-specific information.
> 
> There is also the use case of using CMA with device-specific pools of
> memory reusable by the system when not used by the device and those
> would have to somehow get the pool to allocate from, but I wonder if
> struct device is the right way to pass such information. I'd see the
> pool given explicitly like cma_alloc(struct cma_pool *, size, flags)
> and perhaps a wrapper cma_alloc_default(size, flags) that is just a
> simple macro calling cma_alloc(&cma_pool_default, size, flags).
> 
> Best regards,
> Tomasz

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
