Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C4C21477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="COZmMJ3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C4C21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJEOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:55:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36252 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeJEOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:55:45 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so1567966itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sr2OqXWaIEdKx0yssianahuki0f82fZgdzSpIMK7NxM=;
        b=COZmMJ3j0jr9xPEad6Y+IxQd0S1aVKN0hT1DGZhmVXfi2frQUk0SRx6UdXFeEF5scf
         D4gaGaQBRcP08pQV/ozReh0Ad7RK1rFQwXnjSwWC6MsYLfyi2OzAPtKCWkIP11oLNy3/
         uOYtnRo3AIGJYrgshRXR/NVaLF1krivsqqerg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sr2OqXWaIEdKx0yssianahuki0f82fZgdzSpIMK7NxM=;
        b=e2XHbxADqUAiQFOIwdRfxV74qzDNKvx9oJTGcuTWSTSslI0wHAq0vB1y9Bh+TrfS2m
         863+dWd5IA7XG8x54Pd1zu+Ep69ocT2hWDcPydVP8BrzmWVLRz3lty46vMPIfcdqw02K
         e5Yt8HUZis1HDhWbbsw0ZvWUvlswqWhG65BNyTNYMfBHzIKqe162qYUwOzF0Fapa214d
         JQRH5a7shQZVkviZHpIyGJg80Ekw9MDcJ+LUwf2Lb3tyfUKpjS0cLcxrPANALVuIX5Mw
         0RMBaiQzvhqtqL6ENILFbQzSKC92UN1f2p42A59woum7Yp+Xc0qKK3AzbotNta3S3fOl
         Y9mw==
X-Gm-Message-State: ABuFfogc6x21dwnJZaeVqDzDwtfhUtQ2Kvkg65VEqyE5NMIttUbXyjq6
        4kS0FY6OuuF0WAVqkd5zlG61B0oxaTdLFkb+dsUnIQ==
X-Google-Smtp-Source: ACcGV63QDxK/UsqYR9uqv7g4Kw1b+Aoqoq9pQDWwpkDS559NZnJgFkZ55DAUIIX0uGIIKhQ95mTpOQzP05UBFvfX0KQ=
X-Received: by 2002:a02:590:: with SMTP id 16-v6mr8067384jal.70.1538726292258;
 Fri, 05 Oct 2018 00:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local> <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
 <CAKMK7uHxiDF3z19cMBb0o2o4Ev0DFJkhMR7Ny6U2776Ry4oc=A@mail.gmail.com> <8e980de4-5a52-8f3d-fba2-734617e40d1b@baylibre.com>
In-Reply-To: <8e980de4-5a52-8f3d-fba2-734617e40d1b@baylibre.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 5 Oct 2018 09:58:00 +0200
Message-ID: <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: fix max mode_config height/width
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 9:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 04/10/2018 20:10, Daniel Vetter wrote:
> > On Thu, Oct 4, 2018 at 5:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> On 04/10/2018 12:09, Daniel Vetter wrote:
> >>> On Thu, Oct 04, 2018 at 10:42:43AM +0200, Neil Armstrong wrote:
> >>>> The mode_config max_width/max_height determines the maximum framebuffer
> >>>> size the pixel reader can handle. But the values were set thinking they
> >>>> were determining the maximum screen dimensions.
> >>>>
> >>>> This patch changes the values to the maximum height/width the CANVAS block
> >>>> can handle rounded to some coherent values.
> >>>>
> >>>> Fixes: a41e82e6c457 ("drm/meson: Add support for components")
> >>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>
> >>> It's both. Grep for all the callers of ->fill_modes and you'll see that
> >>> this limit is also used to filter max screen sizes.
> >>>
> >>> If you want to change this, then I think we need a new
> >>> mode_config.fb_max_width/height, which if non-zero, would extend the limit
> >>> for fbs.
> >>>
> >>> There's also the problem that if you extend this for fbs, then there's no
> >>> check anymore in the atomic_commit paths (or legacy modeset), so that
> >>> needs to be addressed somehow too.
> >>
> >> What about adding optionals mode_config.fb_max_width/height and update
> >> drm_internal_framebuffer_create() to use these if non-0 or fallback
> >> to the mode_config max_width/max_height.
> >
> > That's what I meant. Except you also need to then fix the gap you've
> > opened in atomic_check, and validate the mode size against
> > mode_config.max_width/height.
>
> OK, won't this be enough ?
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -333,6 +333,8 @@ struct drm_mode_config_funcs {
>   * @min_height: minimum fb pixel height on this device
>   * @max_width: maximum fb pixel width on this device
>   * @max_height: maximum fb pixel height on this device
> + * @max_fb_width: maximum fb buffer width if differs from max_width
> + * @max_fb_height: maximum fb buffer height if differs from max_height
>   * @funcs: core driver provided mode setting functions
>   * @fb_base: base address of the framebuffer
>   * @poll_enabled: track polling support for this device
> @@ -508,6 +510,7 @@ struct drm_mode_config {
>
>         int min_width, min_height;
>         int max_width, max_height;
> +       int max_fb_width, max_fb_height;
>         const struct drm_mode_config_funcs *funcs;
>         resource_size_t fb_base;
>
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -283,14 +283,20 @@ drm_internal_framebuffer_create(struct drm_device *dev,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if ((config->min_width > r->width) || (r->width > config->max_width)) {
> +       if ((config->min_width > r->width) ||
> +           (!config->max_fb_width && r->width > config->max_width) ||
> +           (config->max_fb_width && r->width > config->max_fb_width)) {
>                 DRM_DEBUG_KMS("bad framebuffer width %d, should be >= %d && <= %d\n",
> -                         r->width, config->min_width, config->max_width);
> +                         r->width, config->min_width, config->max_fb_width ?
> +                         config->max_fb_width : config->max_width);
>                 return ERR_PTR(-EINVAL);
>         }
> -       if ((config->min_height > r->height) || (r->height > config->max_height)) {
> +       if ((config->min_height > r->height) ||
> +           (!config->max_fb_height && r->height > config->max_height) ||
> +           (config->max_fb_height && r->height > config->max_fb_height)) {
>                 DRM_DEBUG_KMS("bad framebuffer height %d, should be >= %d && <= %d\n",
> -                         r->height, config->min_height, config->max_height);
> +                         r->height, config->min_height, config->max_fb_height ?
> +                         config->max_fb_height : config->max_height);
>                 return ERR_PTR(-EINVAL);
>         }
>
> and in the driver :
>
> +       drm->mode_config.max_width = 4096;
> +       drm->mode_config.max_height = 3840;
> +       drm->mode_config.max_fb_width = 16384;
> +       drm->mode_config.max_fb_height = 8192;
>
> With this I leave the mode filtering intact.

Not enough. See
https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html#c.drm_connector_helper_funcs
and scroll down to mode_valid. You need to filter modes both in the
detect paths, and the atomic_check paths.

Detect is explicitly filtered out, but atomic_check was only
implicitly filtered, through the max fb size checks. Ok, you could
light up a mode that's bigger than max fb, but in practice, no
userspace ever did that. But with your code we're missing crucial
validation now, and userspace could fall over that. What I think we
need is to add mode filter against mode_config.max_width/height in
drm_atomic_helper_check_modeset(). Probably best to stuff that into
the mode_valid() function.

Cheers, Daniel
>
> Neil
>
>
> > -Daniel
> >
> >>
> >> Neil
> >>
> >>>
> >>> Bunch of igt to make sure we're not missing anything would be sweet on
> >>> top, e.g. e.g. trying to set a mode over the limit and making sure it
> >>> fails.
> >>>
> >>> Cheers, Daniel
> >>>
> >>>> ---
> >>>>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> >>>> index d344312..2e29968 100644
> >>>> --- a/drivers/gpu/drm/meson/meson_drv.c
> >>>> +++ b/drivers/gpu/drm/meson/meson_drv.c
> >>>> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
> >>>>              goto free_drm;
> >>>>
> >>>>      drm_mode_config_init(drm);
> >>>> -    drm->mode_config.max_width = 3840;
> >>>> -    drm->mode_config.max_height = 2160;
> >>>> +    drm->mode_config.max_width = 16384;
> >>>> +    drm->mode_config.max_height = 8192;
> >>>>      drm->mode_config.funcs = &meson_mode_config_funcs;
> >>>>
> >>>>      /* Hardware Initialization */
> >>>> --
> >>>> 2.7.4
> >>>>
> >>>> _______________________________________________
> >>>> dri-devel mailing list
> >>>> dri-devel@lists.freedesktop.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> >
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
