Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B28C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8461820834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GPNtAuUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8461820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeK3Lbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:31:36 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35584 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeK3Lbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:31:36 -0500
Received: by mail-yw1-f66.google.com with SMTP id h32so1577661ywk.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZylQ/hWyEAhNA0KXYWVy47MzdY+50fVwQX7DiLcZOg=;
        b=GPNtAuUYOcY+IqJ5gtP7D4RxuU0ngkxLGcr27qcpk6jz6po1Q6QszXURMkzwoEiakg
         21wNA/F3IYlcCrGGs2tVfww4kJ+jWTX7VqVS5fGFBx/MXbYdURRy1EkX+09CBI2QyE2r
         5nhwOUcnPeTiet+qP/fSAmRYYfUbOx6GpqACY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZylQ/hWyEAhNA0KXYWVy47MzdY+50fVwQX7DiLcZOg=;
        b=GOzYVjSmVENPYOOBa42AxUhZTeaFSK2P2MGNiUe+vAg2DtSZj01mWUSsCy7WH/8exM
         ljozrNR2J6pqDqwYXIcihao27viZkKsluGBl71nB6JctYmhwWbe1GnK3QmztozeBWHd2
         wrXi53iz5F1oVf94Yq71FDf8cIcL6MrruNoc0Ntcr8aTzrIiIjdoqW3B3Ld4hXlgLIJ3
         lYbYvC1DeNiHyvMUpoFfnK2+1SnyVN/ke7qPaujjgLg67DfxZwXRcUgA6ucdWtcemDDU
         yWp1Q8X5MIJr5m4GVDutOBvs0a6WbqVJjovjsRd/lq0cRgTQwH+TCdab5IcaqCyBPdgt
         j6GA==
X-Gm-Message-State: AA+aEWZQ900nqFaWHNbjnzaDi4onu4CdN1Uzqocfvy8JXD0NQcigs/9S
        arD6MWsubaxcm1NDE5+Aes3lZ2+g67Q=
X-Google-Smtp-Source: AFSGD/Xq90Qqj0mYU498uJZGBQS05xiKBNm0FIGyDOHDXOMVW0XpNXa4dxPOvmxyE8qus78MwmS8qw==
X-Received: by 2002:a81:1781:: with SMTP id 123mr3875076ywx.229.1543537453080;
        Thu, 29 Nov 2018 16:24:13 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id i21sm3711749ywg.5.2018.11.29.16.24.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 16:24:12 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id h187-v6so1529423ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 16:24:12 -0800 (PST)
X-Received: by 2002:a25:618a:: with SMTP id v132-v6mr3570547ybb.293.1543537451720;
 Thu, 29 Nov 2018 16:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
 <20181129155418.GB26537@lst.de> <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
 <20181129194029.GE17663@jcrouse-lnx.qualcomm.com> <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
 <06747338-b0fb-eef6-634a-0641e81ed3c1@arm.com>
In-Reply-To: <06747338-b0fb-eef6-634a-0641e81ed3c1@arm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 29 Nov 2018 16:23:59 -0800
X-Gmail-Original-Message-ID: <CAAFQd5CEXZU5x+Fi5kRHZFfBwPkUbpo=-UBTARiaAoLqV-tMww@mail.gmail.com>
Message-ID: <CAAFQd5CEXZU5x+Fi5kRHZFfBwPkUbpo=-UBTARiaAoLqV-tMww@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Clark <robdclark@gmail.com>, Christoph Hellwig <hch@lst.de>,
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

On Thu, Nov 29, 2018 at 12:03 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 29/11/2018 19:57, Tomasz Figa wrote:
> > On Thu, Nov 29, 2018 at 11:40 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >>
> >> On Thu, Nov 29, 2018 at 01:48:15PM -0500, Rob Clark wrote:
> >>> On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
> >>>>
> >>>> On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
> >>>>> Maybe the thing we need to do is just implement a blacklist of
> >>>>> compatible strings for devices which should skip the automatic
> >>>>> iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
> >>>>> preventing us from enabling per-process pagetables for a5xx (where we
> >>>>> need to control the domain/context-bank that is allocated by the dma
> >>>>> api).
> >>>>
> >>>> You can detach from the dma map attachment using arm_iommu_detach_device,
> >>>> which a few drm drivers do, but I don't think this is the problem.
> >>>
> >>> I think even with detach, we wouldn't end up with the context-bank
> >>> that the gpu firmware was hard-coded to expect, and so it would
> >>> overwrite the incorrect page table address register.  (I could be
> >>> mis-remembering that, Jordan spent more time looking at that.  But it
> >>> was something along those lines.)
> >>
> >> Right - basically the DMA domain steals context bank 0 and the GPU is hard coded
> >> to use that context bank for pagetable switching.
> >>
> >> I believe the Tegra guys also had a similar problem with a hard coded context
> >> bank.
>
> AIUI, they don't need a specific hardware context, they just need to
> know which one they're actually using, which the domain abstraction hides.
>
> > Wait, if we detach the GPU/display struct device from the default
> > domain and attach it to a newly allocated domain, wouldn't the newly
> > allocated domain use the context bank we need? Note that we're already
>
> The arm-smmu driver doesn't, but there's no fundamental reason it
> couldn't. That should just need code to refcount domain users and
> release hardware contexts for domains with no devices currently attached.
>
> Robin.
>
> > doing that, except that we're doing it behind the back of the DMA
> > mapping subsystem, so that it keeps using the IOMMU version of the DMA
> > ops for the device and doing any mapping operations on the default
> > domain. If we ask the DMA mapping to detach, wouldn't it essentially
> > solve the problem?

Thanks Robin.

Still, my point is that the MSM DRM driver attaches the GPU struct
device to a new domain it allocates using iommu_domain_alloc() and it
seems to work fine, so I believe it's not the problem we're looking
into with this patch.

Best regards,
Tomasz
