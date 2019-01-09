Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEACE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b1B2zM/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAIVyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:54:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43105 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAIVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:54:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so8529935eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2xNmWGDTtA13ISLbqJjQtIyRmhvQ0COSnMujOZODd60=;
        b=b1B2zM/HPp31xsdxb3WwLt1CggIl9moMkVPNeLqZoD0Ag47yjVUHWonJRkcF7yNZFt
         EmURguEAQC3JYLa0wZhZXTFAqmShysUJvQ2k6feIEAmYmbW9Vl6mb/H4b+c4v6S/atXC
         4nXdAk6HbXiB/3TK2u4+gIp+cpL3Rm2X/QEiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2xNmWGDTtA13ISLbqJjQtIyRmhvQ0COSnMujOZODd60=;
        b=taG6DIEsSCtSMFfcbl+aRmORFTmEEaf41XBAdAf04REvEZMIu5T4kf4lGxkfXQcfDv
         gbcGiretO5Ti52BJFO/uC1L/w0g/nLqmV0DOT21WKdlmGKCzaPivV9YHbH4cn+ojeCvs
         M94F4QUCvu5fHU1bDa+BTfcpAHrsnd65a+bpZjs7Ja7PWYH/s8cab/jaxWOZ68soCtOJ
         taWhnoghcwpeCozQYEJr7UBMAz+M6bXEGx6uNKSaB9lWsofCjMgAYb9RbzTB0Kd0+8r1
         dG0lyitJ66qOwHVKQuGFUtXP3XhNTUdFxRsK7weQo0NwutiienOLUGOxGbjF9R3OrF8s
         HiKQ==
X-Gm-Message-State: AJcUukdKmns48OCZXoS2ZRXZocojEB4OIyBXPhbyEcmo/gkWsm5yMvIH
        2lIKmB7VF5SD2epv1UkChzomSg==
X-Google-Smtp-Source: ALg8bN4qsUvQRmSlAriYoeDt+vEOMXySguESPxH3pA9/tL9p/zH40ruYiBDvipWRQnQdWXqMIUCVMA==
X-Received: by 2002:a50:b559:: with SMTP id z25mr7337229edd.239.1547070837684;
        Wed, 09 Jan 2019 13:53:57 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n22-v6sm858289ejk.75.2019.01.09.13.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 13:53:56 -0800 (PST)
Date:   Wed, 9 Jan 2019 22:53:54 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: Re: [PATCH v3 08/12] drm: remove include of drmP.h from
 drm_modeset_helper.h
Message-ID: <20190109215354.GZ21184@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
References: <20190108192939.15255-1-sam@ravnborg.org>
 <20190108192939.15255-9-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108192939.15255-9-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:29:35PM +0100, Sam Ravnborg wrote:
> drmP.h is an relic from the days when there was a single header file.
> To enable the removal of drmP.h from all users drop include
> of drmP.h from drm_modeset_helper.h.
> 
> A few files relied on the file included in drmP.h - add explicit
> include statements to these files.
> Build tested with arm and x86.
> 
> v2:
> - Add forward declarations to drm_modeset_helper.h (Laurent Pinchart)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

This one here breaks tinydrm without the tinydrm patch first. I reorderd
while applying. It also breaks kirin (and maybe more, I didn't check), so
I've left this one out for now.
-Daniel

> ---
>  drivers/gpu/drm/arc/arcpgu_sim.c     | 1 +
>  drivers/gpu/drm/bridge/cdns-dsi.c    | 2 ++
>  drivers/gpu/drm/drm_modeset_helper.c | 2 ++
>  drivers/gpu/drm/rcar-du/rcar_lvds.c  | 1 +
>  include/drm/drm_modeset_helper.h     | 6 +++++-
>  5 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arc/arcpgu_sim.c b/drivers/gpu/drm/arc/arcpgu_sim.c
> index 68629e614990..3b7556f62230 100644
> --- a/drivers/gpu/drm/arc/arcpgu_sim.c
> +++ b/drivers/gpu/drm/arc/arcpgu_sim.c
> @@ -14,6 +14,7 @@
>   *
>   */
>  
> +#include <drm/drm_device.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_atomic_helper.h>
>  
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index ce9496d13986..4b73d0969468 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -8,11 +8,13 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_panel.h>
>  #include <video/mipi_display.h>
>  
>  #include <linux/clk.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
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
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> index 534a128a869d..8010ed702509 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
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
