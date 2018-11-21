Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C09C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CEF20821
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tibw84Ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CEF20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeKUOVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:21:36 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45656 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:21:36 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so1693227ywd.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgZIa3VLyO78dIQQgfV5hcgLS7etutcW4niso3pQ+bw=;
        b=Tibw84WwEY9WUaRM6OSonxL6kKwAjddPAxzc9sUuXblgEyhpAFHJXSk2tgRHX7NaDt
         jtV4vd/eV63sYD1PEWnAXT/iWYKkP3hygtvwBC1oQvsoq+Fnul2gQgCcrLkA+9FAj2Ah
         H9Y944hQ7CLdtgVc10CTYc62WRe5M4s3bh1TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgZIa3VLyO78dIQQgfV5hcgLS7etutcW4niso3pQ+bw=;
        b=IoYQLJotxLTckiDT8CeOgfteYg5vLncrXx1K42OI0TlHo5KWTEDvHubYtSQqlg9gqT
         W7/eXZfX2BpGB+h1T2B84yfTqTSdmXpYCMXa2ofGH9lvUc4UBcJNSBhay9YSyPBZZN8A
         TMwO5kHEIbGhRtrIihyG2GMAqKTFWhJd8KzusdwlVApb6GzTevscESGUQ7oePkqqJ19Y
         MAa23csV9I2nGImOD3OqYE8xedoflZVD7R4VRP3FT2VJRS+6Z5GraoF38zXsTXibKw80
         xWQomOj0JLdG5DbHHClTMOOYFs78TEZNfT5fvn7vgQMKL+LIKl3gXQRqHtl/uuHDeYdJ
         0dsg==
X-Gm-Message-State: AGRZ1gI+PjU69kxEkik8N3IXMehRoAfGtwSLCQN4VYzvdYewihKlcAEM
        S6K9UagvIWDJgT50H3SiyL+DFXZ79Mk=
X-Google-Smtp-Source: AJdET5ebuSMEzPkpKbt2xFyh1PrRPr6AFya0FMOTo7Pount3BwtbHS9MBwZHiCH6N4wr4/+CSVI3kA==
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr4814891ywe.496.1542772138902;
        Tue, 20 Nov 2018 19:48:58 -0800 (PST)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id h63-v6sm10594893ywb.110.2018.11.20.19.48.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:48:57 -0800 (PST)
Received: by mail-yw1-f48.google.com with SMTP id g75so1718058ywb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:48:57 -0800 (PST)
X-Received: by 2002:a81:3dc4:: with SMTP id k187-v6mr4900839ywa.415.1542772137363;
 Tue, 20 Nov 2018 19:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20181120095437.29820-1-vivek.gautam@codeaurora.org> <20181120154148.GC31792@jcrouse-lnx.qualcomm.com>
In-Reply-To: <20181120154148.GC31792@jcrouse-lnx.qualcomm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 21 Nov 2018 12:48:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DAa+TmvJCViRHq8YTJh2GRyqBteicOLgohv5v7cNCQPA@mail.gmail.com>
Message-ID: <CAAFQd5DAa+TmvJCViRHq8YTJh2GRyqBteicOLgohv5v7cNCQPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, jcrouse@codeaurora.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan, Vivek,

On Wed, Nov 21, 2018 at 12:41 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Tue, Nov 20, 2018 at 03:24:37PM +0530, Vivek Gautam wrote:
> > dma_map_sg() expects a DMA domain. However, the drm devices
> > have been traditionally using unmanaged iommu domain which
> > is non-dma type. Using dma mapping APIs with that domain is bad.
> >
> > Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> > to do the cache maintenance.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >
> > Tested on an MTP sdm845:
> > https://github.com/vivekgautam1/linux/tree/v4.19/sdm845-mtp-display-working
> >
> >  drivers/gpu/drm/msm/msm_gem.c | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> > index 00c795ced02c..d7a7af610803 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > @@ -81,6 +81,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
> >               struct drm_device *dev = obj->dev;
> >               struct page **p;
> >               int npages = obj->size >> PAGE_SHIFT;
> > +             struct scatterlist *s;
> > +             int i;
> >
> >               if (use_pages(obj))
> >                       p = drm_gem_get_pages(obj);
> > @@ -107,9 +109,19 @@ static struct page **get_pages(struct drm_gem_object *obj)
> >               /* For non-cached buffers, ensure the new pages are clean
> >                * because display controller, GPU, etc. are not coherent:
> >                */
> > -             if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> > -                     dma_map_sg(dev->dev, msm_obj->sgt->sgl,
> > -                                     msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> > +             if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED)) {
> > +                     /*
> > +                      * Fake up the SG table so that dma_sync_sg_*()
> > +                      * can be used to flush the pages associated with it.
> > +                      */
>
> We aren't really faking.  The table is real, we are just slightly abusing the
> sg_dma_address() which makes this comment a bit misleading. Instead I would
> probably say something like:
>
> /* dma_sync_sg_* flushes pages using sg_dma_address() so point it at the
>  * physical page for the right behavior */
>
> Or something like that.
>

It's actually quite complicated, but I agree that the comment isn't
very precise. The cases are as follows:
- arm64 iommu_dma_ops use sg_phys()
https://elixir.bootlin.com/linux/v4.20-rc3/source/arch/arm64/mm/dma-mapping.c#L599
- swiotlb_dma_ops used on arm64 if no IOMMU is available use
sg->dma_address directly:
https://elixir.bootlin.com/linux/v4.20-rc3/source/kernel/dma/swiotlb.c#L832
- arm_dma_ops use sg_dma_address():
https://elixir.bootlin.com/linux/v4.20-rc3/source/arch/arm/mm/dma-mapping.c#L1130
- arm iommu_ops use sg_page():
https://elixir.bootlin.com/linux/v4.20-rc3/source/arch/arm/mm/dma-mapping.c#L1869

Sounds like a mess...

> > +                     for_each_sg(msm_obj->sgt->sgl, s,
> > +                                 msm_obj->sgt->nents, i)
> > +                             sg_dma_address(s) = sg_phys(s);
> > +
>
> I'm wondering - wouldn't we want to do this association for cached buffers to so
> we could sync them correctly in cpu_prep and cpu_fini?  Maybe it wouldn't hurt
> to put this association in the main path (obviously the sync should stay inside
> the conditional for uncached buffers).
>

I guess it wouldn't hurt indeed. Note that cpu_prep/fini seem to be
missing the sync call currently.

P.S. Jordan, not sure if it's my Gmail or your email client, but your
message had all the recipients in a Reply-to header, except you, so
pressing Reply to all in my case led to a message that didn't have you
in recipients anymore...

Best regards,
Tomasz
