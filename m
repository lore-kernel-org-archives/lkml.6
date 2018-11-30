Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F632081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JShNOGll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F632081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeK3Ust (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:48:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46280 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeK3Ust (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:48:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so4271840edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2UWq/+BJQp+SVVD7pE8Qx+DbSE4NP0zXLFTmEw1Q4c=;
        b=JShNOGllDqQiEh3HZq2/4YemkstaKAbtwl/3WfXZq9yz2yj46KkgjSeDlVoXKaxaJ+
         pkR7bjs4+omch14oaBhwflTvZ7OfFi0q3ahc41a+XEq5VWhyO0LZceikKS95YQ2r2a37
         x2EsJyV3x42OUOtEBeZShSUaGLskgM4q2C1dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=q2UWq/+BJQp+SVVD7pE8Qx+DbSE4NP0zXLFTmEw1Q4c=;
        b=MOxoQz7uw32wXXWLHqkxvsOKRyNe2o1J4x5iwODS+yVV4oVIPjrWUhGjKAcdGDvvmp
         03K1BlyQe/ylZed/GsnNsSXb7Et8qBHjowxl8tuxv5MqtTVPlluzRNz+keGexl9s9fyQ
         1ykquM3XkB7CPj+FmfwzZzwBCOYmARbzzd5r048LEqtHL7VUA98PeQj8TuRBbScwLTDw
         l3hqwk9FVIEHBjAxnQtt0BxihrGWGlIMRj1D0cklbTHwkQMlESJ964c7TFSyD5jfAVMe
         65EsNUWkvEZUhX4AiLPlr+biOcTIcAozYhMNHgHQtcBWprCMhP52eVuG4bIZCexJBGIC
         yvFw==
X-Gm-Message-State: AA+aEWa3IhlcU6KnYCSmMojxfBtHGup7Gjs9VxYFkCz/Ftl6KC62vV1f
        8Olp+i8PcUwKh9YnMCikPtMKmQ==
X-Google-Smtp-Source: AFSGD/UI8a2tWLTJ3pgoLO2E0cFxvWMGo0cQqWuJBVDU0M57wGWKNxe8WNu5WmtTYsKk6WYFyPETvQ==
X-Received: by 2002:a50:924e:: with SMTP id j14mr4728421eda.142.1543570805774;
        Fri, 30 Nov 2018 01:40:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p36sm1276769edc.78.2018.11.30.01.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 01:40:05 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:40:02 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        hch@lst.de, David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181130094002.GS21184@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>, hch@lst.de,
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
 <CAF6AEGsT9RO2RmgBTa0HQRjRUiRKy9N3vQxvD7RVWp4HpnWn+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGsT9RO2RmgBTa0HQRjRUiRKy9N3vQxvD7RVWp4HpnWn+w@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:57:38PM -0500, Rob Clark wrote:
> On Thu, Nov 29, 2018 at 12:24 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > [CC Marek]
> >
> > On Thu, Nov 29, 2018 at 9:09 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Thu, Nov 29, 2018 at 5:57 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > Note that one thing I'd like to avoid is exposing these funtions directly
> > > > to drivers, as that will get us into all kinds of abuses.
> > >
> > > What kind of abuse do you expect? It could very well be that gpu folks
> > > call that "standard use case" ... At least on x86 with the i915 driver
> > > we pretty much rely on architectural guarantees for how cache flushes
> > > work very much. Down to userspace doing the cache flushing for
> > > mappings the kernel has set up.
> >
> > i915 is a very specific case of a fully contained,
> > architecture-specific hardware subsystem, where you can just hardcode
> > all integration details inside the driver, because nobody else would
> > care.
> >
> > In ARM world, you can have the same IP blocks licensed by multiple SoC
> > vendors with different integration details and that often includes the
> > option of coherency.
> 
> fwiw, I believe all the GPU IP blocks that are used across multiple
> SoCs have their own GPU MMU (potentially in addition to an iommu?).
> So the dma-api is a much better fit for them..  drm/msm is a lot
> closer to drm/i915 scenario, so I don't so much care if the solution
> to our unique problem isn't something that would work for other
> drivers ;-)

Right now maybe, but I fully except the entire coherent vs. non-coherent
transactions hilarity that we have on the bigger intel socs since a few
years already to trickle down into smaller (arm based socs) eventually. I
think Apple is already there since a few generations.

So maybe we won't have to fight the iommu side of the dma-api anymore
on these, but we'll still have to fight the cache maintenance side of
dma-api. You can tell the dma-api to not flush, but then you don't have
any other way to actually flush that's acceptable for arch/arm (on x86 we
just run clflush in userspace and call it a day).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
