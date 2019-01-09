Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FBCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97460214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K9DN6ySS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfAIVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:54:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36397 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAIVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:54:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so8569139edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MecIDjhs82B475A7qUpHLLXPJNaeibAw5BCi6dBHbwg=;
        b=K9DN6ySSicUqnBKFsLk617JSCp+N0t3D+GiYtUVOpIMIO2LxWSSHU0+BUOVdIfQvjU
         AbzoyhB7v8xxgPcjEzciHpcctkZQ26kfpJVK1RjDaSlGlGK5D+d9gZeJOzqs5LeKBfPa
         H5hsctYUO8/qc3iCoZlxhz4CYrH+wUz8MjAUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=MecIDjhs82B475A7qUpHLLXPJNaeibAw5BCi6dBHbwg=;
        b=m/t9oC1kxEIso2IX8EZ0h6WtRE9pl5IQ4Bx99HCV+RLtbo+OYndTORcp5vIt+u6PiO
         y7yNEvi5OoDRmF0ojbyCjsEZQRIgufE+8eo2YvEWBJUGjBE2GrUhIyJqiTcNlgJBBzP+
         P2F6FqERgS45k2/mOcFWY+vETspIyGcSs/cOlrQ00oQWKXvVd3d/ifLklpNUViTsI1Lk
         v4Rd3QJIquxoSFmtPC0bagH2kd9POLTd2b6TZ6qkkPM8LGxLcvce72ZvnVqbDe54dDyg
         hNRy8M/lFRsgTzdplKg9sy4yvkdKm/6IlaCVIF0bUjO2a7swyUerbFCnHFUDBxm1jBwa
         /f6Q==
X-Gm-Message-State: AJcUukc4bf3iNIY1Dv0gqny3Rv2w/nrP0Z/2IXmFt26UbE5UfRvyvHhs
        O4TBpB8MuRPpGwQzalXqVMgpSsaMgAE=
X-Google-Smtp-Source: ALg8bN7DS0HYQU94P7KwrAJUDk+8k/OuKQgbUS55DO3CY21H7Qm2ADsTphJuMYoU4Rqm/oP0D/Y5zQ==
X-Received: by 2002:a50:ca86:: with SMTP id x6mr7164503edh.287.1547070886148;
        Wed, 09 Jan 2019 13:54:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v11sm1248169edy.49.2019.01.09.13.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 13:54:45 -0800 (PST)
Date:   Wed, 9 Jan 2019 22:54:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 05/12] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to
 drm_util.h
Message-ID: <20190109215443.GA21184@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190108192939.15255-1-sam@ravnborg.org>
 <20190108192939.15255-6-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108192939.15255-6-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:29:32PM +0100, Sam Ravnborg wrote:
> In the quest to get rid of drmP.h move the newly
> added EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h.
> Fix the single user.
> 
> Add a note to drmP.h to avoid further use of it.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Skipping this one for now, since it doesn't apply cleanly without patch 4.
Seems like none of the later patches requires it.
-Daniel

> ---
>  drivers/gpu/drm/drm_framebuffer.c |  1 +
>  include/drm/drmP.h                | 11 ++++++-----
>  include/drm/drm_util.h            | 10 ++++++++++
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index fcaea8f50513..7abcb265a108 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_print.h>
> +#include <drm/drm_util.h>
>  
>  #include "drm_internal.h"
>  #include "drm_crtc_internal.h"
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index bc4cb3732407..3f5c577c9dbd 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -94,10 +94,11 @@ struct dma_buf_attachment;
>  struct pci_dev;
>  struct pci_controller;
>  
> -#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
> -#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
> -#else
> -#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
> -#endif
> +/*
> + * NOTE: drmP.h is obsolete - do NOT add anything to this file
> + *
> + * Do not include drmP.h in new files.
> + * Work is ongoing to remove drmP.h includes from existing files
> + */
>  
>  #endif
> diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
> index 8fda5777471c..cd1e4be1dfb3 100644
> --- a/include/drm/drm_util.h
> +++ b/include/drm/drm_util.h
> @@ -37,6 +37,16 @@
>  #include <linux/kgdb.h>
>  #include <linux/smp.h>
>  
> +/*
> + * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
> + * only be visible for drmselftests.
> + */
> +#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
> +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
> +#else
> +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
> +#endif
> +
>  /**
>   * for_each_if - helper for handling conditionals in various for_each macros
>   * @condition The condition to check
> -- 
> 2.12.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
