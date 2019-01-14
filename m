Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33C52086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MOlTDAXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfANKD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:03:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38907 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfANKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:03:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so18148887ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DEFF4eVaPrhpHLYfI/gU5IPcjjob7Hxij1oi4Hfp58Y=;
        b=MOlTDAXDlldj1POnYQsDcJ1ScYatOlv7VbtSXbpsFqGAmBNa3wZwgYB8bv6B3IoDWu
         jFCGlqLpKmqbcq3hJ5GB5NDBF1O1B5jz3qvXWKKm09xy9fUz1m09d90Guk9VxNIgyGo1
         Aq/qbEFM7iXnH+Cp8jgd61qWbB94x7CVEpRHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DEFF4eVaPrhpHLYfI/gU5IPcjjob7Hxij1oi4Hfp58Y=;
        b=bLVQZ58DMEIBtJPtvdtJvs3g7vjLH1x4+0WKGmSDrknSA601eybOI2KAmzMCBwxQII
         B+szdwZJ5OTskpv/82MGss7sQxi5tvtHwxiNK7jejgZYxylEILOgDRRfUtl2Vtz5efHj
         1QQ4K5gqPn3ykpNznhi9PIumCBlUk6j0flLHrLQ2Zc9PnIaajdl1MwdSmTyscmZammo3
         QYG/D+Wx7D6du5oSqiKesEGq1qKmFCUV5tMOkzCTzS9dlg8fJbqguDtZ55WffcPvEg9B
         tXfruIIbyFMwxKj5zSGNs+r9mk+LBJt0406SLcvi3rQr4UT/10Kn96Ep4mkjNMNBrYFS
         RI/w==
X-Gm-Message-State: AJcUukdf0s9/eNTWSIElS6GytyLUDKBsK0Bnv5S0V3d52DyX9a71NeSZ
        zgXDnKdp6iN3n3nEJM/N2O7mAA==
X-Google-Smtp-Source: ALg8bN6EkNbhw0DK+UvGJ65rx5u6EFozDY56acHruHvZF13CuQYU4bDuCDyBUPbjnFpDW5xtFev1Bg==
X-Received: by 2002:a17:906:d507:: with SMTP id ge7-v6mr19803551ejb.78.1547460235015;
        Mon, 14 Jan 2019 02:03:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id by5-v6sm2496380ejb.7.2019.01.14.02.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:03:54 -0800 (PST)
Date:   Mon, 14 Jan 2019 11:03:51 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 8/8] drm: remove drmP.h from drm_modeset_helper.h
Message-ID: <20190114100351.GB10517@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>, Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190112193251.20450-1-sam@ravnborg.org>
 <20190112193251.20450-9-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112193251.20450-9-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 08:32:51PM +0100, Sam Ravnborg wrote:
> With the removal of drmP.h from drm_modeset_helper.h
> the drmP.h are no longer included by any include files
> in include/drm.
> The drmP.h file is thus only included explicit
> either in .c files or in local .h files.
> This makes the process of deleting the drmP.h includes easier
> as we have a more local dependency chain.
> 
> Include build failures fixes in drm files after the drmP.h removal.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Note that as soon as drm-intel-next lands in drm-misc-next this won't be
enough. I have a patch which I think toghether with yours here should take
care of things though.

I merged the first 2 patches, I'll wait with the driver ones for a few
more acks first.

Thanks for respinning.
-Daniel

> ---
>  drivers/gpu/drm/drm_damage_helper.c  | 1 +
>  drivers/gpu/drm/drm_modeset_helper.c | 2 ++
>  include/drm/drm_modeset_helper.h     | 6 +++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index 31032407254d..b575a768f51c 100644
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
