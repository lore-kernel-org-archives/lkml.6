Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA172084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K3kuAKrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA172084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeJEBEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:04:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55769 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJEBEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:04:41 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so14412683itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+X12a/p9uuRdq86HNHCAJ0cLXKgvTm6Go9i50fozqA=;
        b=K3kuAKrnurtQrEBS2EOp0IOsuUGZyymKs4kgZ2v5UESq3hbE0ni2JUlwWFXHedfEVH
         uzptsykkMej1OBV1OjqHzrH9utbHMd5BfF8xmrnIRjxcbfHreBXp5ruTDWvOHryBs6eE
         CjM3/cXXCPJSUmHRABCXFrv1r52NPVl7mO+Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+X12a/p9uuRdq86HNHCAJ0cLXKgvTm6Go9i50fozqA=;
        b=p03ow7boba5uplhY22oh4Pk0Hz80i7OnC1PbA/2BluGcNY+/8Orv9PNYOESpogrcLq
         TzEs6UzdNJidTKEM3svQqyZqmSHu3XHOSRiuMxtCoPw321Zrz4yWMXlViX5gYqm/QY6X
         3WU9T7orz5lpz/MEL0V1AJZZgkfa7Xuqi6q3ldlPmZnqNJgKlqF2Mv64Wc8bAlP7SPcn
         WUBqtiaDPXbsOY4iMgau1Xq3u6JAHlOo2f4o4O9AXJXTrpSLM8jleJ17SvpeOOuC7whd
         NlKXRt2MK9Fhaco4vXk8Wt45ji6S9/PG0EeQZ6Br0d8TBIbt92y5VPVaOu5YAK04X0Ul
         grNQ==
X-Gm-Message-State: ABuFfoi+NgAf9ntQUov16p4bVQaC63mRzgBxJslsGHRx5Knbocc91JM5
        6LFWnjgsAr6VnKRFAdeMCkqrrxyeYo83+MT2ezqk1g==
X-Google-Smtp-Source: ACcGV62Z7SrHsRgeWwb5ryaxhzQOpCFM7KvgKWPF/5ASGs0FrGu0CqtP0YM7d10M4EQgRADtFAylvFw7nAjeL6Gyo60=
X-Received: by 2002:a24:d857:: with SMTP id b84-v6mr6441797itg.77.1538676616511;
 Thu, 04 Oct 2018 11:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local> <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
In-Reply-To: <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 4 Oct 2018 20:10:04 +0200
Message-ID: <CAKMK7uHxiDF3z19cMBb0o2o4Ev0DFJkhMR7Ny6U2776Ry4oc=A@mail.gmail.com>
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

On Thu, Oct 4, 2018 at 5:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 04/10/2018 12:09, Daniel Vetter wrote:
> > On Thu, Oct 04, 2018 at 10:42:43AM +0200, Neil Armstrong wrote:
> >> The mode_config max_width/max_height determines the maximum framebuffer
> >> size the pixel reader can handle. But the values were set thinking they
> >> were determining the maximum screen dimensions.
> >>
> >> This patch changes the values to the maximum height/width the CANVAS block
> >> can handle rounded to some coherent values.
> >>
> >> Fixes: a41e82e6c457 ("drm/meson: Add support for components")
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >
> > It's both. Grep for all the callers of ->fill_modes and you'll see that
> > this limit is also used to filter max screen sizes.
> >
> > If you want to change this, then I think we need a new
> > mode_config.fb_max_width/height, which if non-zero, would extend the limit
> > for fbs.
> >
> > There's also the problem that if you extend this for fbs, then there's no
> > check anymore in the atomic_commit paths (or legacy modeset), so that
> > needs to be addressed somehow too.
>
> What about adding optionals mode_config.fb_max_width/height and update
> drm_internal_framebuffer_create() to use these if non-0 or fallback
> to the mode_config max_width/max_height.

That's what I meant. Except you also need to then fix the gap you've
opened in atomic_check, and validate the mode size against
mode_config.max_width/height.
-Daniel

>
> Neil
>
> >
> > Bunch of igt to make sure we're not missing anything would be sweet on
> > top, e.g. e.g. trying to set a mode over the limit and making sure it
> > fails.
> >
> > Cheers, Daniel
> >
> >> ---
> >>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> >> index d344312..2e29968 100644
> >> --- a/drivers/gpu/drm/meson/meson_drv.c
> >> +++ b/drivers/gpu/drm/meson/meson_drv.c
> >> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
> >>              goto free_drm;
> >>
> >>      drm_mode_config_init(drm);
> >> -    drm->mode_config.max_width = 3840;
> >> -    drm->mode_config.max_height = 2160;
> >> +    drm->mode_config.max_width = 16384;
> >> +    drm->mode_config.max_height = 8192;
> >>      drm->mode_config.funcs = &meson_mode_config_funcs;
> >>
> >>      /* Hardware Initialization */
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
