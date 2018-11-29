Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D15C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5563520863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C92ppuI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5563520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbeK3Eaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:30:39 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46128 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeK3Eaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:30:39 -0500
Received: by mail-yb1-f193.google.com with SMTP id x130-v6so935315ybg.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1kTN0xPpa0dHpBzR+etnzT5kRP0c1bGsENFkscyud8=;
        b=C92ppuI/IE0NSRJIWvnsxkef2HdmlQPtNXQ8SDdWo05qleVI8mnAuWyHB/FarFpAnd
         AQN9ugzmaSJbrIq//1tbUYMtHi0RtI7QKpWTem9+1xrPD2NXBo5HFhh/jPT3cIdBCB+g
         szww464xzkQJW0SRMve9DS0+sUc2aRAxsS0Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1kTN0xPpa0dHpBzR+etnzT5kRP0c1bGsENFkscyud8=;
        b=uXZqxA7L47x9drL1cYtzzIWFtEN59hPT+9djysVKjbRzCk9Y/DDr9Iv1M46hd3kZh3
         1Y7wCRkcFc7ATQ694jiPpzRH4fESdAo4Hui1dTputQVEU9jLo5KAiYfUwLSXexoki1Ir
         dxpJOby/VnmkqQDblv+CiU195hspeCocKgFDBr3KFgQ68IJ/903Ytf5cxEz3WaUbPioE
         ZQJj2RP1GaP/sF3qodzl6SR1jiMBMTAXUIb4QCTaEOTr+4CDPTef8qL0qC/dYeQNIDHO
         CyGnY1fwOshYkyRr+2z9x0SSxm0s12n3JZkGY1TahvI/6TaXDLZaSSq9TxIIiFo6mNBk
         F0Og==
X-Gm-Message-State: AA+aEWYyRhno58e9dgu/indlZXxWwlIwjmv3Zx3jGtAq+O340kqQc7O3
        iPsq4+8lgNDpblk9yVOqiLYyrbggjDc=
X-Google-Smtp-Source: AFSGD/XawJjzw3rjlVMbDNIU3iTDfZd2vL3cOKk531abrfQCYO6bWBMXxIqulCTT3xYOOEThod4I1w==
X-Received: by 2002:a25:5c88:: with SMTP id q130-v6mr2243317ybb.236.1543512272085;
        Thu, 29 Nov 2018 09:24:32 -0800 (PST)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id b144sm906813ywa.33.2018.11.29.09.24.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:24:30 -0800 (PST)
Received: by mail-yw1-f41.google.com with SMTP id q11so1097761ywa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:24:30 -0800 (PST)
X-Received: by 2002:a0d:eb06:: with SMTP id u6mr2232112ywe.443.1543512269914;
 Thu, 29 Nov 2018 09:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
 <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local>
 <20181129165715.GA27786@lst.de> <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
In-Reply-To: <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 29 Nov 2018 09:24:17 -0800
X-Gmail-Original-Message-ID: <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
Message-ID: <CAAFQd5A-Bh711VaNWhRJqcrofkBVCMFcNgqfztoyWJcUdhSu0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC Marek]

On Thu, Nov 29, 2018 at 9:09 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Nov 29, 2018 at 5:57 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Thu, Nov 29, 2018 at 05:28:07PM +0100, Daniel Vetter wrote:
> > > Just spend a bit of time reading through the implementations already
> > > merged. Is the struct device *dev parameter actually needed anywhere?
> > > dma-api definitely needs it, because we need that to pick the right iommu.
> > > But for cache management from what I've seen the target device doesn't
> > > matter, all the target specific stuff will be handled by the iommu.
> >
> > It looks like only mips every uses the dev argument, and even there
> > the function it passes dev to ignores it.  So it could probably be removed.
> >

Whether the cache maintenance operation needs to actually do anything
or not is a function of `dev`. We can have some devices that are
coherent with CPU caches, and some that are not, on the same system.

> > >
> > > Dropping the dev parameter would make this a perfect fit for coherency
> > > management of buffers used by multiple devices. Right now there's all
> > > kinds of nasty tricks for that use cases needed to avoid redundant
> > > flushes.
> >
> > Note that one thing I'd like to avoid is exposing these funtions directly
> > to drivers, as that will get us into all kinds of abuses.
>
> What kind of abuse do you expect? It could very well be that gpu folks
> call that "standard use case" ... At least on x86 with the i915 driver
> we pretty much rely on architectural guarantees for how cache flushes
> work very much. Down to userspace doing the cache flushing for
> mappings the kernel has set up.

i915 is a very specific case of a fully contained,
architecture-specific hardware subsystem, where you can just hardcode
all integration details inside the driver, because nobody else would
care.

In ARM world, you can have the same IP blocks licensed by multiple SoC
vendors with different integration details and that often includes the
option of coherency.

>
> > So I'd much prefer if we could have iommu APIs wrapping these that are
> > specific to actual uses cases that we understand well.
> >
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

I suppose one could just expose CMA with the default pool directly.
It's just an allocator, so not sure why it would need any
device-specific information.

There is also the use case of using CMA with device-specific pools of
memory reusable by the system when not used by the device and those
would have to somehow get the pool to allocate from, but I wonder if
struct device is the right way to pass such information. I'd see the
pool given explicitly like cma_alloc(struct cma_pool *, size, flags)
and perhaps a wrapper cma_alloc_default(size, flags) that is just a
simple macro calling cma_alloc(&cma_pool_default, size, flags).

Best regards,
Tomasz
