Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1020835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PD6VGsRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF1020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJCSYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:24:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39340 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:24:12 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so8283726itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCtsNBqlFCtOCynnTHy7XnGpqUdbKfVPRfEtIdgE9Xs=;
        b=PD6VGsRu8Adj7+8swQQDg0neBFGntX37EVUY7AmdKKROGO/ZM4trkaMUiMhpKlIh3c
         l8B3tXktW2EY9jpSXw66N2vkwcjYaPml3FA1yTMuCn3nz9Gyv+fXxodH8pkc4MA4eBBQ
         dWXrbzwIhtVR4zMlgE1AZE7QZsz0WpIwtPwM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCtsNBqlFCtOCynnTHy7XnGpqUdbKfVPRfEtIdgE9Xs=;
        b=q9NIAYBUFsWN8lhELFy6U8fX3N3eZU0FFzc/j1bzzyWP5ndObVNnPfDPLe2jZtn3g8
         S9kZAkrJij7AVjbdc3U3wjXIHD7UdM3AvWJ6qWY6KtFaP/3P9LD6RtyAE4JEaUkQPSj1
         GrmFNaAQGoelCYWrrJD+cV85oiGXCvgCKruv7I6LVnAFShpU5tEviQojQ5+gNflzmwc/
         hJCBp0sa5UaeGwceK4Ab6uKhEYHqj7FIvFbjQEif5A++MP2kBbL9GyRvqwcqRv+ph+YX
         /LuwgmUMI86zNuVXGjcH2GUdALY1dw94adwb4IIqlgVnCi4T+y7y5hPlA3fP1I+BRudh
         49jg==
X-Gm-Message-State: ABuFfoh8GyoudB2EWtsJBUBnfMXLaZdVJzkzUo//lBJl+qjm/sg++CiG
        tkzO1VzKTyR/+ftn2CQxqG1PrtpcjiPNxv0HcyPCrg==
X-Google-Smtp-Source: ACcGV63/ykds09ZwA3n0z1jzYrBOGP2bR2Tqin1q7h0T0ufVOd0MizqQgmySyKTqYW08B8bJlc7+V4YN9ywvNkM00uU=
X-Received: by 2002:a24:d857:: with SMTP id b84-v6mr985264itg.77.1538566571601;
 Wed, 03 Oct 2018 04:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181003110457.9318-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20181003110457.9318-1-Eugeniy.Paltsev@synopsys.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 3 Oct 2018 13:36:00 +0200
Message-ID: <CAKMK7uFP3bMcNSY2L9ZmvFPz6KB51_gMnZ-b7FPCz3NEOafi=w@mail.gmail.com>
Subject: Re: [PATCH] drm: fb-helper: Validate requested pixel format against bpp
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 1:05 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
>
> Validate requested pixel format against bits_per_pixel to reject
> invalid formats with subcomponents length sum is greater than requested
> bits_per_pixel.
>
> weston 5.0.0 with fbdev backend tries to set up an ARGB x8r8g8b8 pixel
> format without bits_per_pixel updating. So it can request
> x8r8g8b8 with 16 bpp which is obviously incorrect and should be
> rejected.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

drm fbdev emulation doesn't support changing the pixel format at all.
I think we should reject all such request, not just the invalid ones.
Can you pls respin?

Thanks, Daniel

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 16ec93b75dbf..4f39da07f053 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1610,6 +1610,13 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>                 return -EINVAL;
>         }
>
> +       if ((var->green.length + var->blue.length + var->red.length +
> +           var->transp.length) > var->bits_per_pixel) {
> +               DRM_DEBUG("fb requested pixel format can't fit in %d bpp\n",
> +                         var->bits_per_pixel);
> +               return -EINVAL;
> +       }
> +
>         switch (var->bits_per_pixel) {
>         case 16:
>                 depth = (var->green.length == 6) ? 16 : 15;
> --
> 2.14.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
