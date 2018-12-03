Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2135D2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a+VydDo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2135D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLCAMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:12:36 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40413 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeLCAMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:12:35 -0500
Received: by mail-yw1-f67.google.com with SMTP id r130so4703287ywg.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 16:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wQlO2xDy+CwEhyGREVmB297Z8Zc+aVNLGTeB72WWkY=;
        b=a+VydDo1yLrVrSnqDqRCnbFCKFMOvZRRIRFC29iDJS9Dex7WcN8vWY3MDr3mhtbe9c
         ZM4IWSBOwQly1knaEdzDxzK6Xj6KyvN1XHKd8ClpF9qiPQPLm91e6oL0sS2cBU+0aWfq
         PNbySr7gYfrItfYdZyHExUQ/YuUGj3gc+3LBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wQlO2xDy+CwEhyGREVmB297Z8Zc+aVNLGTeB72WWkY=;
        b=Uf+a00+BaBRYzbiZM6A4LaZfTCj/JT8DB7o06487aSrrzHyXHc95QQsY/TwP6pivYa
         LJX6GqcoPijkz4sOJM5/47nES8kAvYwNMno5XR+IU56ldQD2IIqi5xbfXYjBNW0GYdZA
         RIoNAGfJQQV7Sj3Zu6rl70xm3pWK2M7a/c/AsYuR8OhyyEFSryCJVUJwTszjyNZZasSi
         y67NjU2NkvorZ/U2nocRGLaDS+FclQBz9f6TLu6pVR3GISr4kaSoWp6Kk5t7eiXLpGO+
         pTo8DtPPbhLFpAK5m3S0mRaqN+LqCrVGSDCcPuZ2xFOrnI5CxqKo0hLqf4T+YMhGM8PO
         6HGg==
X-Gm-Message-State: AA+aEWY7MDIuHaksPHWoAF8pfQb9zqRfq1Pyq99N4lEICv3iwqS+Zub7
        nNX5NONl8XxuUZBVC5YW228k3O/1nq8=
X-Google-Smtp-Source: AFSGD/WyRX7LxxASoJpT2nz0YNZk9AL6xA1TXctJqlN4jSEu86ZNPUercbDdmM2U4SYUeIljspUIVw==
X-Received: by 2002:a81:3753:: with SMTP id e80mr14017125ywa.505.1543795952549;
        Sun, 02 Dec 2018 16:12:32 -0800 (PST)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 137sm1923260ywv.108.2018.12.02.16.12.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 16:12:31 -0800 (PST)
Received: by mail-yw1-f52.google.com with SMTP id f65so4705039ywc.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 16:12:31 -0800 (PST)
X-Received: by 2002:a81:8103:: with SMTP id r3-v6mr13758602ywf.403.1543795950703;
 Sun, 02 Dec 2018 16:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
 <20181129155418.GB26537@lst.de> <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
 <20181129194029.GE17663@jcrouse-lnx.qualcomm.com> <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
 <06747338-b0fb-eef6-634a-0641e81ed3c1@arm.com> <CAAFQd5CEXZU5x+Fi5kRHZFfBwPkUbpo=-UBTARiaAoLqV-tMww@mail.gmail.com>
 <CAAFQd5DMgGDPcK=4DktfC7T9O0MrU1VBqJqR+6VYpOh_DdEXUg@mail.gmail.com> <CAF6AEGujyP78PjOMwTmdHcJKpsrgmRGage=pFniad98peMBrDw@mail.gmail.com>
In-Reply-To: <CAF6AEGujyP78PjOMwTmdHcJKpsrgmRGage=pFniad98peMBrDw@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sun, 2 Dec 2018 16:12:19 -0800
X-Gmail-Original-Message-ID: <CAAFQd5AdGafW0h1r6bZ84T5WCxkynCYjTe82uJDTna=W=FpLPg@mail.gmail.com>
Message-ID: <CAAFQd5AdGafW0h1r6bZ84T5WCxkynCYjTe82uJDTna=W=FpLPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Rob Clark <robdclark@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 3:47 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Nov 30, 2018 at 9:05 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Thu, Nov 29, 2018 at 4:23 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > >
> > > On Thu, Nov 29, 2018 at 12:03 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > On 29/11/2018 19:57, Tomasz Figa wrote:
> > > > > On Thu, Nov 29, 2018 at 11:40 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > > > >>
> > > > >> On Thu, Nov 29, 2018 at 01:48:15PM -0500, Rob Clark wrote:
> > > > >>> On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > >>>>
> > > > >>>> On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
> > > > >>>>> Maybe the thing we need to do is just implement a blacklist of
> > > > >>>>> compatible strings for devices which should skip the automatic
> > > > >>>>> iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
> > > > >>>>> preventing us from enabling per-process pagetables for a5xx (where we
> > > > >>>>> need to control the domain/context-bank that is allocated by the dma
> > > > >>>>> api).
> > > > >>>>
> > > > >>>> You can detach from the dma map attachment using arm_iommu_detach_device,
> > > > >>>> which a few drm drivers do, but I don't think this is the problem.
> > > > >>>
> > > > >>> I think even with detach, we wouldn't end up with the context-bank
> > > > >>> that the gpu firmware was hard-coded to expect, and so it would
> > > > >>> overwrite the incorrect page table address register.  (I could be
> > > > >>> mis-remembering that, Jordan spent more time looking at that.  But it
> > > > >>> was something along those lines.)
> > > > >>
> > > > >> Right - basically the DMA domain steals context bank 0 and the GPU is hard coded
> > > > >> to use that context bank for pagetable switching.
> > > > >>
> > > > >> I believe the Tegra guys also had a similar problem with a hard coded context
> > > > >> bank.
> > > >
> > > > AIUI, they don't need a specific hardware context, they just need to
> > > > know which one they're actually using, which the domain abstraction hides.
> > > >
> > > > > Wait, if we detach the GPU/display struct device from the default
> > > > > domain and attach it to a newly allocated domain, wouldn't the newly
> > > > > allocated domain use the context bank we need? Note that we're already
> > > >
> > > > The arm-smmu driver doesn't, but there's no fundamental reason it
> > > > couldn't. That should just need code to refcount domain users and
> > > > release hardware contexts for domains with no devices currently attached.
> > > >
> > > > Robin.
> > > >
> > > > > doing that, except that we're doing it behind the back of the DMA
> > > > > mapping subsystem, so that it keeps using the IOMMU version of the DMA
> > > > > ops for the device and doing any mapping operations on the default
> > > > > domain. If we ask the DMA mapping to detach, wouldn't it essentially
> > > > > solve the problem?
> > >
> > > Thanks Robin.
> > >
> > > Still, my point is that the MSM DRM driver attaches the GPU struct
> > > device to a new domain it allocates using iommu_domain_alloc() and it
> > > seems to work fine, so I believe it's not the problem we're looking
> > > into with this patch.
> >
> > Could we just make the MSM DRM call arch_teardown_dma_ops() and then
> > arch_setup_dma_ops() with the `iommu` argument set to NULL and be done
> > with it?
>
> I don't think those are exported to modules?
>

Indeed, if we compile MSM DRM as modules, it wouldn't work...

> I have actually a simpler patch, that adds a small blacklist to check
> in of_dma_configure() before calling arch_setup_dma_ops(), which can
> replace this patch.  It also solves the problem of dma api allocating
> the context bank that he gpu wants to use for context-switching, and
> should be a simple thing to backport to stable branches.
>
> I was just spending some time trying to figure out what changed
> recently to start causing dma_map_sg() to opps on boot for us, so I
> could write a more detailed commit msg.

Yeah, that sounds much better, thanks. Reviewed that patch.

Best regards,
Tomasz
