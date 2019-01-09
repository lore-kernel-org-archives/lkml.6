Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6901DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D4E206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cv1UjoSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAIVKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:10:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40574 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfAIVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:10:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so8457037edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dARqHTZsgJ5RoC0O4IfHVSsxM1Z+zwlLU7ttTPnQVAw=;
        b=cv1UjoSHl8J2LbxdCqn80dPUceiLAG5ZdWospuqw4WQLGU9dKkDxyE+6OzevPWn0Pk
         WMJ/XyRx4yhM58+KmuUzk0RreMCxnCwtdUsfAI7JbsxE8Qg6ZxHcew+utXaLk+rh6Grb
         SeeKldYoUvNvrjE2StB0PK505BgJe5iWmJVEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=dARqHTZsgJ5RoC0O4IfHVSsxM1Z+zwlLU7ttTPnQVAw=;
        b=XQVwkddZPnTG/mTlreC/lyrIdeCh8Vf453TMRT89vx4FKK4JuF9HvYnESflwKpwwnu
         nUk8+js//d7endp9CMz826r3w6uqdDQxyKKCUGc0kJ+r9xVOj0P6ZhG9CWnOfaVUBDDz
         h/l4G2wNNH4en2kY+HvmobmlmcKoruMMWavM6fFYHw1HnTSpaLtd9cik7mFINVYqfD8R
         ifFFMQ/gxnkL6MwLvYUyKxSw4T6Dm4y+2hdt6S0TGtQgdw9/2maBSent9AK2N79DNMA4
         hyz2Q07SbY1sq6NIBx90O6KU+mZuaaswWWWJZzFUehPmc2Z9D8BUmJdyGTQkEqKkAufH
         J0kw==
X-Gm-Message-State: AJcUukdhM1m/acreFhrBH6jNDnnDtNunuLomz+j128E2KsjAIf/WZBrz
        Z8JtuC052SSzSjwV2OoOmziJug==
X-Google-Smtp-Source: ALg8bN6/8JBRTO1pOAHLRJSLYnyV1ocItZegsi6Kta3/Yzjtqtw7P7DZQjwiWSYN0vjgjb+vExX+uQ==
X-Received: by 2002:a17:906:44d:: with SMTP id e13-v6mr6573897eja.197.1547068217153;
        Wed, 09 Jan 2019 13:10:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n29sm1430178edd.40.2019.01.09.13.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 13:10:16 -0800 (PST)
Date:   Wed, 9 Jan 2019 22:10:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/7] drm: Remove drm_mode_object dependency from
 drm_display_mode
Message-ID: <20190109211014.GX21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <cover.1545308167.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545308167.git.shayenneluzmoura@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:24:27AM -0200, Shayenne Moura wrote:
> This patch serie removes drm_mode_object dependency from
> drm_display_mode struct. This is part of KMS cleanup.
> 
> Shayenne Moura (7):
>   drm: msm: Cleanup drm_display_mode print str
>   drm: omapdrm: Cleanup drm_display_mode print str
>   drm: meson: Cleanup on drm_display_mode print str
>   drm: sti: Cleanup drm_display_mode print str
>   drm: i915: Cleanup drm_display_mode print str
>   drm: Remove use of drm_mode_object
>   drm: Complete remove drm_mode_object dependency

Ok, merged patches 2-5 to drm-misc-next. Sorry for the delay, caught a
cold and was out of service past few days :-/

Can you pls fix the compile issue in the msm patch? Looks like that wasn't
properly compile-tested. For a howto, see:

https://blog.ffwll.ch/2016/02/arm-kernel-cross-compiling.html

and make sure MSM is enabled in the .config. You can configure the
cross-compiled kernel with e.g.

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig

Thanks, Daniel
> 
>  drivers/gpu/drm/drm_crtc_helper.c             |  5 ++---
>  drivers/gpu/drm/drm_modes.c                   |  9 --------
>  drivers/gpu/drm/i915/i915_debugfs.c           |  9 +-------
>  drivers/gpu/drm/meson/meson_dw_hdmi.c         | 12 +++--------
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     | 10 ++-------
>  .../gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  9 +-------
>  .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  9 +-------
>  .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  9 +-------
>  .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  9 +-------
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  9 +-------
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  |  9 +-------
>  drivers/gpu/drm/msm/dsi/dsi_manager.c         |  9 +-------
>  drivers/gpu/drm/msm/edp/edp_bridge.c          |  9 +-------
>  drivers/gpu/drm/omapdrm/omap_connector.c      |  9 ++------
>  drivers/gpu/drm/omapdrm/omap_crtc.c           |  8 ++-----
>  drivers/gpu/drm/sti/sti_crtc.c                | 16 ++++----------
>  include/drm/drm_modes.h                       | 21 +++----------------
>  17 files changed, 27 insertions(+), 144 deletions(-)
> 
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
