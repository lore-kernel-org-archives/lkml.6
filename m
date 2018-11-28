Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA28C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE39E2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZtHmVvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE39E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeK1OJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:09:19 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41817 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeK1OJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:09:19 -0500
Received: by mail-yw1-f68.google.com with SMTP id f65so10116886ywc.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 19:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rX3YCYRauTXbohemKf+2i0TtPdpUG5WLNNRme1MxHFI=;
        b=VZtHmVvXbm16SG9AiR3dDfpaM8YQd8YvHUvRqvsfyPaNRgPVSa35h2fd3qqUFyUoeP
         Olfpt4ISgyD5/YS0GDfXOb0Fc1V6rWtlt8wKQARFmttS0w+BCjF49j0zBjvXgf3ODF2H
         s5/j0IRXnsBpp9NX5qhTydvdewwCPnjncfcFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rX3YCYRauTXbohemKf+2i0TtPdpUG5WLNNRme1MxHFI=;
        b=Bp+oxpW5HoZK3bx+T1uZN/szhp//wzyB0Oo+NQ5KWynKoQe2jLOqsQB+UBCQUQUWNn
         xlQVEcMNiTU2vSMQd/oONfoWmRUbRgnbsVXOY4ohwK7jratkqqdO5AZmZSxasWNxwsYC
         jgQpjR4HJNwIQWmHjnbAgaj1S65jaE7EMOoyqKzQpz+NQor3JrcMwB5/vAp/MbDpMfJ2
         rUOfcaaDc/qvosetor/UCbtqTViAFNCvCGbQCS6P3/LH6mLjAiGrWCqZxL29pt/7zhLM
         w0qtxV1dVSc8nxufEXew0i/+W0Wnl7mTDC9D7SYPvF8a07ZuFfeMUU1RZ8dK9EJCllVk
         pA4A==
X-Gm-Message-State: AGRZ1gKVOh0Auts2faD4SkWglohH8pC3DwISQX9FKNbTlw90k2wQjlwt
        h5+FIY2+WPpcyg/dGz/x7rp5hz4AiyVTLQ==
X-Google-Smtp-Source: AJdET5eshRGaZ5P0guBV3fygaruaJ5CFSoqFU4sPaM2lwdv82qgJtk/qHjGkmcnzaHxXAcZ3uwG35g==
X-Received: by 2002:a0d:ea16:: with SMTP id t22mr37176094ywe.341.1543374556766;
        Tue, 27 Nov 2018 19:09:16 -0800 (PST)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id e194sm4476392ywa.85.2018.11.27.19.09.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 19:09:15 -0800 (PST)
Received: by mail-yw1-f54.google.com with SMTP id q11so10140867ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 19:09:15 -0800 (PST)
X-Received: by 2002:a81:3194:: with SMTP id x142mr34808824ywx.92.1543374555271;
 Tue, 27 Nov 2018 19:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20181126213710.3084-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20181126213710.3084-1-vivek.gautam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 28 Nov 2018 12:09:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Agy-hHsPPweMq-EvpgvnUrSFyG-KTm6HfmL=ac738xFw@mail.gmail.com>
Message-ID: <CAAFQd5Agy-hHsPPweMq-EvpgvnUrSFyG-KTm6HfmL=ac738xFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     David Airlie <airlied@linux.ie>, Rob Clark <robdclark@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        jcrouse@codeaurora.org, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Tue, Nov 27, 2018 at 6:37 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> dma_map_sg() expects a DMA domain. However, the drm devices
> have been traditionally using unmanaged iommu domain which
> is non-dma type. Using dma mapping APIs with that domain is bad.
>
> Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> to do the cache maintenance.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> ---
>
> Changes since v1:
>  - Addressed Jordan's and Tomasz's comments for
>    - moving sg dma addresses preparation out of the coditional
>      check to the main path so we do it irrespective of whether
>      the buffer is cached or uncached.
>    - Enhance the comment to explain this dma addresses prepartion.
>

Thanks for the patch. Some comments inline.

>  drivers/gpu/drm/msm/msm_gem.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 00c795ced02c..1811ac23a31c 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -81,6 +81,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
>                 struct drm_device *dev = obj->dev;
>                 struct page **p;
>                 int npages = obj->size >> PAGE_SHIFT;
> +               struct scatterlist *s;
> +               int i;
>
>                 if (use_pages(obj))
>                         p = drm_gem_get_pages(obj);
> @@ -104,12 +106,21 @@ static struct page **get_pages(struct drm_gem_object *obj)
>                         return ptr;
>                 }
>
> -               /* For non-cached buffers, ensure the new pages are clean
> +               /*
> +                * dma_sync_sg_*() flush the physical pages, so point
> +                * sg->dma_address to the physical ones for the right behavior.

The two halves of the sequence don't really relate to each other. An
sglist has the `page` field for the purpose of pointing to physical
pages. The `dma_address` field is for DMA addresses, which are not
equivalent to physical addresses. I'd rewrite it like this;

/*
 * Some implementations of the DMA mapping ops expect
 * physical addresses of the pages to be stored as DMA
 * addresses of the sglist entries. To work around it,
 * set them here explicitly.
 */

> +                */
> +               for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
> +                       sg_dma_address(s) = sg_phys(s);
> +
> +               /*
> +                * For non-cached buffers, ensure the new pages are clean
>                  * because display controller, GPU, etc. are not coherent:
>                  */
> -               if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -                       dma_map_sg(dev->dev, msm_obj->sgt->sgl,
> -                                       msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +               if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED))
> +                       dma_sync_sg_for_device(dev->dev, msm_obj->sgt->sgl,
> +                                              msm_obj->sgt->nents,
> +                                              DMA_TO_DEVICE);

Why changing from DMA_BIDIRECTIONAL?

>         }
>
>         return msm_obj->pages;
> @@ -133,14 +144,16 @@ static void put_pages(struct drm_gem_object *obj)
>
>         if (msm_obj->pages) {
>                 if (msm_obj->sgt) {
> -                       /* For non-cached buffers, ensure the new
> +                       /*
> +                        * For non-cached buffers, ensure the new
>                          * pages are clean because display controller,
>                          * GPU, etc. are not coherent:
>                          */
> -                       if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -                               dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
> -                                            msm_obj->sgt->nents,
> -                                            DMA_BIDIRECTIONAL);
> +                       if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED))
> +                               dma_sync_sg_for_cpu(obj->dev->dev,
> +                                                   msm_obj->sgt->sgl,
> +                                                   msm_obj->sgt->nents,
> +                                                   DMA_FROM_DEVICE);

Ditto.

Best regards,
Tomasz
