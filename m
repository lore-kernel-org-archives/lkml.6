Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D2E217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TI1hBpTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeLSNNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:13:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34049 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:13:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so16939385ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EKc3SlJtlmBilgvFzYgz6I5TP69+W6dP+cywKRV+b8s=;
        b=TI1hBpTVkRn1thuWl5oEOWPaXzVr0LlxC9QYSrSG3dupaMFsOO0Y+ntL9O/dFZeJbv
         oqIf1Hsm8SuxCHFeek7b7P9R5ZueZD+AT9BVcgZI2M4D3OX2inx1Gm1iq5/03mK5xpCJ
         +zvc1NuoR69Pcgz+wtAqPo87mNMpISlbUOQzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EKc3SlJtlmBilgvFzYgz6I5TP69+W6dP+cywKRV+b8s=;
        b=FdC8VZIUsSmqg5dowVyYd5hCm8jPZ9ItaLtfgnf0035Jn9PcGD5N+l99YzXY5QnzSz
         81i9EK85xVhFlJplHG/urQhJm9cARtFI8BAlE8Nw9eiLGE+S3VpjpkwANyFOb1btKp/G
         S9inDRlPLxMbpeXknDsVHDdkRZy2ONVu1Yo082k/1PHMc3pekgyb41nXzJuhnCYwX2xg
         dnexWdtMKYQ8px/3P/kLQ89rgOlfZ+VFft7zVeC0nWCrP/Bs3rle2m5SPBECgZgP7Rds
         ISm0FPRrHU6jdaY21w5oUUmZ9VCQuV0uVo7xePN68ptLHI16LnoCfc0wQEJ7DZC37ymb
         Wdaw==
X-Gm-Message-State: AA+aEWYwDyJw/SfeK8UJh1p3XhwrYXOYbV03tttbHTg8acDRQUW4LpUA
        BHOEtV7OIfh+PdVISegVL+g1kw==
X-Google-Smtp-Source: AFSGD/XhYnRk9rR84xV4J2m+IW23aQsnfYp+7tEC5Czv62GllNYmblpb6XjXuw0EnQULVtaVtPF0Yw==
X-Received: by 2002:a17:906:d054:: with SMTP id bo20-v6mr8735778ejb.239.1545225219472;
        Wed, 19 Dec 2018 05:13:39 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j23sm5156416edr.89.2018.12.19.05.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:13:38 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:13:36 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6/7] drm: meson: Delete base.id prints
Message-ID: <20181219131336.GT21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181218133830.tlm4ndyrefwvvdyt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218133830.tlm4ndyrefwvvdyt@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:38:30AM -0200, Shayenne Moura wrote:
> This patch removes base.id prints from drm_display_mode                         
> objects in meson files. It removes dependency from drm_mode_object.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index d8c5cc34e22e..b203560f666d 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -365,7 +365,7 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>  	unsigned int wr_clk =
>  		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
>  
> -	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
> +	DRM_DEBUG_DRIVER("\"%s\"\n", mode->name);
>  
>  	/* Enable clocks */
>  	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
> @@ -555,8 +555,8 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>  	int vic = drm_match_cea_mode(mode);
>  	enum drm_mode_status status;
>  
> -	DRM_DEBUG_DRIVER("Modeline %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
> -		mode->base.id, mode->name, mode->vrefresh, mode->clock,
> +	DRM_DEBUG_DRIVER("Modeline \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",

Here we could use DRM_MODE_FMT/ARG, other 2 changes lgtm.
-Daniel

> +		mode->name, mode->vrefresh, mode->clock,
>  		mode->hdisplay, mode->hsync_start,
>  		mode->hsync_end, mode->htotal,
>  		mode->vdisplay, mode->vsync_start,
> @@ -650,8 +650,7 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
>  	struct meson_drm *priv = dw_hdmi->priv;
>  	int vic = drm_match_cea_mode(mode);
>  
> -	DRM_DEBUG_DRIVER("%d:\"%s\" vic %d\n",
> -			 mode->base.id, mode->name, vic);
> +	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
>  
>  	/* VENC + VENC-DVI Mode setup */
>  	meson_venc_hdmi_mode_set(priv, vic, mode);
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
