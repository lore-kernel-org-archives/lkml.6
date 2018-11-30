Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E97DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03EC2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E9TgxpN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03EC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeK3Uyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:54:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46788 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK3Uyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:54:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so4285556edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=krpYNKIgyzz5TRFgbe6AV4I5RqquFOb+xLu9kTYm5J4=;
        b=E9TgxpN+PBKwBOYtNMo0jYtYDS0V8ji8j5i4aGCApDNWCZUKRNf/D2C1pTYGDeOP4F
         XehIQguFliEDbSSiWNeE8vYndDFdNziQ+jh1ZVsVro4F0kVVzC3R7R0G6jqnNfPeQqqb
         3+JXJxJj9SdhcoLmmklN8AKIqwWzAvoIZ70yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=krpYNKIgyzz5TRFgbe6AV4I5RqquFOb+xLu9kTYm5J4=;
        b=WdzwiAw62j9wOScDriclqcLMpK4lag0Mre+xCv9C3Nalc8UTH/so5TbJMHlNKoyRX2
         qSACdkxeWNm+TPqj2aKJuaz2wV7zqjEIJ3yx2qBWkE1/i5gVm7YJNmLQcxi0ndGNlnAF
         YXDEoUbwDQFzSJetoameYNjaG7G6+93VmXkE0tIIisSRsF3mDJUlhKnS3kIa3Z9r6pfb
         pX9d3uz2rPUWaWYxUjuCwoH3ON3gtRUiemv5xCPUcbeipgaaKvoPpuXaSq1VK1PcF+Xs
         tZ9I0F6QU9bfo0dm1A3oQi+H1aOMmNadjOEbqt/Ds3KQUoTN0w+8InaCKISuGsljWgAm
         6IiA==
X-Gm-Message-State: AA+aEWZIJ+xjO1jxtdR4kmODzLWCBODhoO4r6SYNmvjYD3xOAwvCcDkl
        Q99YplNxQW5SstCggcEN9a+uEQ==
X-Google-Smtp-Source: AFSGD/XfdTM46yTyIppL7ONot2OjT0bbul1NCz9vBUDn8oQCKdfH7cEiOeahZU2TOjAFwdQ5f7u0hg==
X-Received: by 2002:a17:906:314a:: with SMTP id e10-v6mr4148674eje.227.1543571167239;
        Fri, 30 Nov 2018 01:46:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d7-v6sm719738ejx.68.2018.11.30.01.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 01:46:06 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:46:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Clark, Rob" <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, vivek.gautam@codeaurora.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181130094604.GV21184@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        "Clark, Rob" <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>, Sean Paul <seanpaul@chromium.org>,
        vivek.gautam@codeaurora.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de>
 <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
 <20181129155758.GC26537@lst.de>
 <20181129162807.GL21184@phenom.ffwll.local>
 <20181129165715.GA27786@lst.de>
 <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com>
 <20181129183334.GB30281@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129183334.GB30281@lst.de>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 07:33:34PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 06:09:05PM +0100, Daniel Vetter wrote:
> > What kind of abuse do you expect? It could very well be that gpu folks
> > call that "standard use case" ... At least on x86 with the i915 driver
> > we pretty much rely on architectural guarantees for how cache flushes
> > work very much. Down to userspace doing the cache flushing for
> > mappings the kernel has set up.
> 
> Mostly the usual bypasses of the DMA API because people know better
> (and with that I don't mean low-level IOMMU API users, but "creative"
> direct mappings).

Ah yes. I think that even gpu folks get behind :-) Best if someone
bothered to explicitly cast to dma_addr_t to shut up the tools, but not
fix the bug ...

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
> Being able to dip into CMA and mayb iommu coalescing if we want to
> get fancy is indeed the only reason for this API.  If we just wanted
> to map pages we could already do that now with just a little bit
> of boilerplate code (and quite a few drivers do - just adding this
> new API will remove tons of code).

Sounds like the future is very bright indeed \o/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
