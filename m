Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68165C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9AF21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iQKwpcyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfAXOD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:03:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40411 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfAXOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:03:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so4651585edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aEFmD1sR6+HHmWznfSzslUAIygTBKMH1VY2djKP/2S0=;
        b=iQKwpcyUT0Ts3bb+rPGGpWv8Do5TKiTS/Fo0v0+jusNF6ahtQLPjagTy7/1WBn8rJp
         isMcFocKGBZ3/k1DlIVKY/y1kjBa6/OSnW9NjKm8OlnPq7GQRH2rjaQzTiK2eCajM/gn
         4x0EX2HeT5eElMgrqDTkIW3uVm3H1z9fbJnQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aEFmD1sR6+HHmWznfSzslUAIygTBKMH1VY2djKP/2S0=;
        b=IkaJzm4PqtSQXJICCykODmsC/LV8gfOwp/T1Lll63N+QFQaqKW4vtizGMl3MfWKQA9
         qPvvDSgginJ+tjPAHDEgtjWvHTr63x35LI0Bc7yddGuBMdy63XbmoYWTJxidafwvRoE7
         jcZIZqQVIDEG8rYHMoPbaYFmItXawLVWT0XcFK0QQnQ8C3OAuIReL2lPuX/Y7IgVfxdD
         JvvjCyibHWI07nUY+vy4OJdZs/2qGyoHMHkqCk9dDby2I3at6XZ2BQZXzEmOGGD0ANPQ
         2tt9pTyorKW+s7VGXkTNELIRwe/4cP6r9DdPHVGyc93rEOOLYpZ+bUiENuiHZ3gQn/hV
         9zig==
X-Gm-Message-State: AJcUukeT0MzcjiPZlNEa/Hn14ub1aEACA98o9+br9+L78gnB2gmpj2z+
        /rp7BTo77GqL3o7PZac7wlerIA==
X-Google-Smtp-Source: ALg8bN5WEJbCHWp048kJXiE8hK3ez6m5ipoupMjzZGUctBqbYkw3jLmuo6IBVcK1KoVabyD5ZGn2QQ==
X-Received: by 2002:a05:6402:3d1:: with SMTP id t17mr6968985edw.21.1548338604424;
        Thu, 24 Jan 2019 06:03:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t18-v6sm5945342ejz.9.2019.01.24.06.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 06:03:23 -0800 (PST)
Date:   Thu, 24 Jan 2019 15:03:20 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] drm: remove drmP.h from drm_modeset_helper.h
Message-ID: <20190124140320.GY3271@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>, Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
References: <20190119084014.5355-1-sam@ravnborg.org>
 <20190119084014.5355-7-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119084014.5355-7-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 09:40:14AM +0100, Sam Ravnborg wrote:
> With the removal of drmP.h from drm_modeset_helper.h
> the drmP.h are no longer included by any include files
> in include/drm.
> The drmP.h file is thus only included explicit
> either in .c files or in local .h files.
> This makes the process of deleting the drmP.h includes easier
> as we have a more local dependency chain.
> 
> Include build failure fixes in drm files after the drmP.h removal.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Merge the previous 5 patches from this series, but this now goes boom on
vbox in staging. Needs another prep patch I think.
-Daniel

> ---
>  drivers/gpu/drm/drm_damage_helper.c  | 1 +
>  drivers/gpu/drm/drm_modeset_helper.c | 2 ++
>  include/drm/drm_modeset_helper.h     | 6 +++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index e16aa5ae00b4..ee67c96841fa 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -32,6 +32,7 @@
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_damage_helper.h>
> +#include <drm/drm_device.h>
>  
>  /**
>   * DOC: overview
> diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
> index 9150fa385bba..9bc1ef788c77 100644
> --- a/drivers/gpu/drm/drm_modeset_helper.c
> +++ b/drivers/gpu/drm/drm_modeset_helper.c
> @@ -23,8 +23,10 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_modeset_helper.h>
>  #include <drm/drm_plane_helper.h>
> +#include <drm/drm_print.h>
>  
>  /**
>   * DOC: aux kms helpers
> diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
> index efa337f03129..995fd981cab0 100644
> --- a/include/drm/drm_modeset_helper.h
> +++ b/include/drm/drm_modeset_helper.h
> @@ -23,7 +23,11 @@
>  #ifndef __DRM_KMS_HELPER_H__
>  #define __DRM_KMS_HELPER_H__
>  
> -#include <drm/drmP.h>
> +struct drm_crtc;
> +struct drm_crtc_funcs;
> +struct drm_device;
> +struct drm_framebuffer;
> +struct drm_mode_fb_cmd2;
>  
>  void drm_helper_move_panel_connectors_to_head(struct drm_device *);
>  
> -- 
> 2.12.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
