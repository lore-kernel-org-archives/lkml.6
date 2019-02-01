Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09D6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C06A218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lxrQ2upr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfBARh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:37:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34143 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbfBARhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:37:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so6143869ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XN7ztOwBfaWUcyejLCIihaQ4ZgEvWVS3wCWfbNiuJiU=;
        b=lxrQ2upr40t3J3HqQ+JUTfjucGIUC+ttX2+XPkeSk2onlnSkhQwPUW7IMOG5AhgHmb
         TwYkekMlK2HpT7tXXZd93YPIJ2o0AV517RUPMeUOLnMP+TPNkwSEgOVUVflJugzE1ND0
         4Hod5LNnkFWipYNQeKWjqY2+5QM89SSTJ4kHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XN7ztOwBfaWUcyejLCIihaQ4ZgEvWVS3wCWfbNiuJiU=;
        b=EPMg2nc34HF4Mnms4qXkGXftlsQna81XO+jCjVilGPSZ8HT+H4V52+KmvzTBEhGEuu
         bcZCu8ekaHeABIzRwl68b1kMuwLmVYtvIlmFVJZchAUExrExzfZaPa41NrrAOyMzxSX0
         Ng/oN9myOwyxvxUayB7Z9pyjlM3+4EEntBtM9mhqCgdMsk1H6q47ga0fKnCfVQC7r4QN
         JULAx+uAnf4BY3VJvbfdQUbTDvtCRQf5UTk2qUYp31ML8Cikm/P5tFOZEKHVP9QuX7bs
         yuU5QuOZdDdn0gaL52IkebhFj7NZCAPSahaIqqb0xNU8xmaNNpoi4PanuDctD0Iaq+4y
         NuZQ==
X-Gm-Message-State: AJcUukeyQtRqqrKBFgrTVKqeuleh3Gdf1BrFL0Pjjgsybx0ApSX3wLF0
        kTwdRYwAoCeaiLHB/fm3pZlufw==
X-Google-Smtp-Source: ALg8bN63OOGj8KXdturZ5A+mF707f5v06CwnHciypXvgnqWV1t8Bn9Mc9I7pC1E38RH8uVaqO3lt9A==
X-Received: by 2002:a05:6402:694:: with SMTP id f20mr31430374edy.99.1549042672836;
        Fri, 01 Feb 2019 09:37:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o4sm1318522ejr.19.2019.02.01.09.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:37:51 -0800 (PST)
Date:   Fri, 1 Feb 2019 18:37:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v6 1/5] staging/vboxvideo: prepare for drmP.h removal
 from drm_modeset_helper.h
Message-ID: <20190201173749.GF3271@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
        intel-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190126122527.11647-1-sam@ravnborg.org>
 <20190126122527.11647-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126122527.11647-2-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 01:25:23PM +0100, Sam Ravnborg wrote:
> The use of drmP.h is discouraged and removal of it from
> drm_modeset_helper.h caused vboxvideo to fail to build.
> 
> This patch introduce the necessary fixes to prepare for the
> drmP.h removal from drm_modeset_helper.h.
> 
> In the files touched sort the include files
> 
> Build tested on x86 and arm allmodconfig / allyesconfig.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>

Hi Greg,

Ack for merging this through drm-misc? I think we've defacto-maintained
vboxvideo in drm anyway this release ...
-Daniel

> ---
>  drivers/staging/vboxvideo/vbox_drv.c  |  6 +++++-
>  drivers/staging/vboxvideo/vbox_fb.c   | 18 ++++++++++--------
>  drivers/staging/vboxvideo/vbox_mode.c |  5 ++++-
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_drv.c b/drivers/staging/vboxvideo/vbox_drv.c
> index cc6532d8c2fa..d1b0d7b4886a 100644
> --- a/drivers/staging/vboxvideo/vbox_drv.c
> +++ b/drivers/staging/vboxvideo/vbox_drv.c
> @@ -7,11 +7,15 @@
>   *          Michael Thayer <michael.thayer@oracle.com,
>   *          Hans de Goede <hdegoede@redhat.com>
>   */
> -#include <linux/module.h>
>  #include <linux/console.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
>  #include <linux/vt_kern.h>
>  
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_ioctl.h>
>  
>  #include "vbox_drv.h"
>  
> diff --git a/drivers/staging/vboxvideo/vbox_fb.c b/drivers/staging/vboxvideo/vbox_fb.c
> index 397496cf0bdf..83a04afd1766 100644
> --- a/drivers/staging/vboxvideo/vbox_fb.c
> +++ b/drivers/staging/vboxvideo/vbox_fb.c
> @@ -6,20 +6,22 @@
>   * Authors: Dave Airlie <airlied@redhat.com>
>   *          Michael Thayer <michael.thayer@oracle.com,
>   */
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/tty.h>
> -#include <linux/sysrq.h>
>  #include <linux/delay.h>
> +#include <linux/errno.h>
>  #include <linux/fb.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/string.h>
> +#include <linux/sysrq.h>
> +#include <linux/tty.h>
>  
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fourcc.h>
>  
>  #include "vbox_drv.h"
>  #include "vboxvideo.h"
> diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
> index 1aaff02c07ff..213551394495 100644
> --- a/drivers/staging/vboxvideo/vbox_mode.c
> +++ b/drivers/staging/vboxvideo/vbox_mode.c
> @@ -10,14 +10,17 @@
>   *          Hans de Goede <hdegoede@redhat.com>
>   */
>  #include <linux/export.h>
> +
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_vblank.h>
>  
> +#include "hgsmi_channels.h"
>  #include "vbox_drv.h"
>  #include "vboxvideo.h"
> -#include "hgsmi_channels.h"
>  
>  /*
>   * Set a graphics mode.  Poke any required values into registers, do an HGSMI
> -- 
> 2.12.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
