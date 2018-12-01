Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2798DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE59320834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CcNKhgan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE59320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLANQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:16:48 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35810 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLANQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:16:48 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so3130065ywk.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3x8S3yC1yslH6TBAB26mUQf3aiheiLPm8MrLJeLAhY=;
        b=CcNKhganF4G2np3CWuR5bcbnVDl9fCM8iDXOpB+eGZKN7ofpMB3S8m5yvq6fBDxc3a
         JwJCHNksayTP+7CvyE02Mgsj8jWj9ne85c9OLceTiAikgLvSubwIzeSOkUHbNrYctYt7
         +DHlDagr6ReBt/RhM0WvFijP4jK/6rkdNHMPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3x8S3yC1yslH6TBAB26mUQf3aiheiLPm8MrLJeLAhY=;
        b=FaRT9GEvvAT+Om0J1uRkW9r4eMtWHjjp0Hz3r/PT46tjZ8VYbodpZ5nlR/YCFyCbs5
         m9yeFsyRMGb0C/w12ULhGqF+SG0ev2eTcGPpzAvYgQfVrMyoyrrHf+fNK4jf+ACrrDo/
         yaUjva9RPVo7LN0lenvjwMIRCUkPzPeFmmF9IqdvzuLUSStbjH//jPedyNS2BJmLMWw3
         5rmYztH4cGYwD4vKJjuoAmFp1a9dNhM93jKQIit9y/2xUtokcZkmS3A/3QILA2wf8pll
         0HlJ8N7X5AVYt9H6Hx5aVfn57d2JXMEq1Uu27oIy4tVgg14TeZuGN4hB5yx6d4jcJR3E
         otQw==
X-Gm-Message-State: AA+aEWZwXSvubNdsTDvd344Wp8uFusmDYL93+lwQAYrYJAwZ1Isc1O0y
        obxI59gAOTcCAHikAibJF5NVxCi+m2A=
X-Google-Smtp-Source: AFSGD/XnSur7rnJfHn2IVuFHwnDQsnRFi92JeWmCRSLrxR4sRrUlAXROzyGptzG1UNJm7FQgrSkTXQ==
X-Received: by 2002:a81:1b09:: with SMTP id b9-v6mr8070705ywb.248.1543629926773;
        Fri, 30 Nov 2018 18:05:26 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id v191sm2114310ywc.102.2018.11.30.18.05.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 18:05:25 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id j6so3119227ywj.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:05:24 -0800 (PST)
X-Received: by 2002:a0d:e0c5:: with SMTP id j188mr8528170ywe.164.1543629924251;
 Fri, 30 Nov 2018 18:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
 <20181129155418.GB26537@lst.de> <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
 <20181129194029.GE17663@jcrouse-lnx.qualcomm.com> <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
 <06747338-b0fb-eef6-634a-0641e81ed3c1@arm.com> <CAAFQd5CEXZU5x+Fi5kRHZFfBwPkUbpo=-UBTARiaAoLqV-tMww@mail.gmail.com>
In-Reply-To: <CAAFQd5CEXZU5x+Fi5kRHZFfBwPkUbpo=-UBTARiaAoLqV-tMww@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 30 Nov 2018 18:05:12 -0800
X-Gmail-Original-Message-ID: <CAAFQd5DMgGDPcK=4DktfC7T9O0MrU1VBqJqR+6VYpOh_DdEXUg@mail.gmail.com>
Message-ID: <CAAFQd5DMgGDPcK=4DktfC7T9O0MrU1VBqJqR+6VYpOh_DdEXUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Rob Clark <robdclark@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     David Airlie <airlied@linux.ie>,
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

On Thu, Nov 29, 2018 at 4:23 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Thu, Nov 29, 2018 at 12:03 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 29/11/2018 19:57, Tomasz Figa wrote:
> > > On Thu, Nov 29, 2018 at 11:40 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >>
> > >> On Thu, Nov 29, 2018 at 01:48:15PM -0500, Rob Clark wrote:
> > >>> On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
> > >>>>
> > >>>> On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
> > >>>>> Maybe the thing we need to do is just implement a blacklist of
> > >>>>> compatible strings for devices which should skip the automatic
> > >>>>> iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
> > >>>>> preventing us from enabling per-process pagetables for a5xx (where we
> > >>>>> need to control the domain/context-bank that is allocated by the dma
> > >>>>> api).
> > >>>>
> > >>>> You can detach from the dma map attachment using arm_iommu_detach_device,
> > >>>> which a few drm drivers do, but I don't think this is the problem.
> > >>>
> > >>> I think even with detach, we wouldn't end up with the context-bank
> > >>> that the gpu firmware was hard-coded to expect, and so it would
> > >>> overwrite the incorrect page table address register.  (I could be
> > >>> mis-remembering that, Jordan spent more time looking at that.  But it
> > >>> was something along those lines.)
> > >>
> > >> Right - basically the DMA domain steals context bank 0 and the GPU is hard coded
> > >> to use that context bank for pagetable switching.
> > >>
> > >> I believe the Tegra guys also had a similar problem with a hard coded context
> > >> bank.
> >
> > AIUI, they don't need a specific hardware context, they just need to
> > know which one they're actually using, which the domain abstraction hides.
> >
> > > Wait, if we detach the GPU/display struct device from the default
> > > domain and attach it to a newly allocated domain, wouldn't the newly
> > > allocated domain use the context bank we need? Note that we're already
> >
> > The arm-smmu driver doesn't, but there's no fundamental reason it
> > couldn't. That should just need code to refcount domain users and
> > release hardware contexts for domains with no devices currently attached.
> >
> > Robin.
> >
> > > doing that, except that we're doing it behind the back of the DMA
> > > mapping subsystem, so that it keeps using the IOMMU version of the DMA
> > > ops for the device and doing any mapping operations on the default
> > > domain. If we ask the DMA mapping to detach, wouldn't it essentially
> > > solve the problem?
>
> Thanks Robin.
>
> Still, my point is that the MSM DRM driver attaches the GPU struct
> device to a new domain it allocates using iommu_domain_alloc() and it
> seems to work fine, so I believe it's not the problem we're looking
> into with this patch.

Could we just make the MSM DRM call arch_teardown_dma_ops() and then
arch_setup_dma_ops() with the `iommu` argument set to NULL and be done
with it?

Best regards,
Tomasz
