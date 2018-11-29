Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A15C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680A220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ABvWVVo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680A220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeK3DeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:34:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43247 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeK3DeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:34:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id f4so2386671edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bvzhpyhJZGhyADQPnL4NT9gATkwkC7r1TJNnXGIPBWI=;
        b=ABvWVVo7bltJxlYVf0lIuqhkRbeulCJmOFjAESGC4Sy54odH0oFveR5R4bbkxCTEd/
         1j+iy/QD3JEfjdZK3WRVgTaRGtUJ9O6qpOSXrbwtBAUprPaNEE26GxDZ5pkMxz+B65ec
         sC9UUOcw1Ic0NsWmmoyonQTaPxb7lWMoqD3sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bvzhpyhJZGhyADQPnL4NT9gATkwkC7r1TJNnXGIPBWI=;
        b=H4oy7Tv595m0RWvs6U5f/MJySwYH6MxY7JXbf9e39RaWSOdn9IZajnDLGOyvu+vyx3
         MrgD5bxfwtjpJykdZpw8GwKucyygsrs1AOVjJfwKg7Z3runXgQu6ZhsXbkmehB3ly+gQ
         538Y1t4aWR8Rzlf45w/RCl8vSrL/5OpUTa0qWoRNaZ4ve0YJNUZVgasAf2lHH2gjxs5R
         /dAw5MikRAuQ7HVxpIbM/XcqhcNrU7Orp/9PVUwRPX16ixzX8tGSZm/SEQSIJYrVXU/n
         iqmi4Na9fOvdanQpSRMxMPaysUyl9ytPscJUcQFkgqDNa7o8G9wsTXKs3O/Tq5rJcbY5
         +buA==
X-Gm-Message-State: AA+aEWYRXFlqSWB6hLPLsaRdNcqcJei1VlixkWcvx+u35WEXFCBUslnb
        CpjwCn08qD+25elf7E6qtaE4TQ==
X-Google-Smtp-Source: AFSGD/Vf5lJhr8hogmhsjTNFX0L4TIgKWBi5XGU+zJaFGNDXAS5f0QL9ATqzAEuoJZ9romCcdqtVRg==
X-Received: by 2002:a50:c182:: with SMTP id m2mr2266775edf.139.1543508890289;
        Thu, 29 Nov 2018 08:28:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r18-v6sm406751eja.19.2018.11.29.08.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:28:09 -0800 (PST)
Date:   Thu, 29 Nov 2018 17:28:07 +0100
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
Message-ID: <20181129162807.GL21184@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129155758.GC26537@lst.de>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:57:58PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 03:43:50PM +0100, Daniel Vetter wrote:
> > Yeah we had patches to add manual cache management code to drm, so we
> > don't have to abuse the dma streaming api anymore. Got shouted down.
> > Abusing the dma streaming api also gets shouted down. It's a gpu, any
> > idea of these drivers actually being platform independent is out of
> > the window from the start anyway, so we're ok with tying this to
> > platforms.
> 
> Manual or not the iommu API is missing APIs for cache management,
> which makes it kinda surprising it actually ever worked for non-coherent
> devices.
> 
> And fortunately while some people spent the last year ot two bickering
> about the situation others actually did work, and we now have a
> generic arch_sync_dma_for_device/arch_sync_dma_for_cpu kernel-internal
> API.  This is only used for DMA API internals so far, and explicitly
> not intended for direct driver use, but it would be perfect as the
> backend for iommu API cache maintainance functions.  It exists on all
> but two architectures on mainline.  Out of those powerpc is in the works,
> only arm32 will need some major help.

Oh, this sounds neat. At least some massive progress.

Just spend a bit of time reading through the implementations already
merged. Is the struct device *dev parameter actually needed anywhere?
dma-api definitely needs it, because we need that to pick the right iommu.
But for cache management from what I've seen the target device doesn't
matter, all the target specific stuff will be handled by the iommu.

Dropping the dev parameter would make this a perfect fit for coherency
management of buffers used by multiple devices. Right now there's all
kinds of nasty tricks for that use cases needed to avoid redundant
flushes.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
