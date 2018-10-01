Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B232D2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="g/KQ1cHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B232D2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJAOdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:33:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36668 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:33:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so13302322edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EOCEfWM1hghz/pIrzuHE/X1qiT0VXb8KGWngxiycJc=;
        b=g/KQ1cHxNivR5ZWPM7I6JUa1qxxJUIGSrnv4hPlK1pBaBnzFnYlURpecX5dBble4Lx
         aqcxA660OdNOB+x1drsT/vdmObsARxbY1Lx+QnVgLax4yoRH6E1K5dAQN76uRto21OnY
         aPbiosddnklUgeOF6jCcW3myuL12YXKmEPEmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0EOCEfWM1hghz/pIrzuHE/X1qiT0VXb8KGWngxiycJc=;
        b=BdBnQcaGN0nKP2DXcmgDWwbcsb2FN8EhhC3noKM0QlL7ux6+hDUazShavMwFRphgRB
         98tOC3o//8fVx7N5Olhzq2oynlte5aX+CHHlJH44Np7w4zLjrzdo/rEhP0ReMzsovFTd
         wHMUhh9f7vmYdy0I8r1PJ5I0TDm7wpAmvnI44ajVk8kCeOQ9JcyHmu+Z7MDszkxNiB0m
         QkqnQL/lu+RHjxHdNPtiOBJ/OkQoNITyIyl5C+IaSTGskEFXQ79/tjsHF/PPrXZzkBCK
         yDaMiLx0xIfnmKZVqUS6WboC/qHsAf6SvMQOPNsiqLR3tStx88olnyw+sCx4sbrIbdkc
         ctwQ==
X-Gm-Message-State: ABuFfoicfkGizZCOT7IBeI2ETNReOUXicZWn8HMYKvW5jB/l05UUd6cM
        qPnOtfacTbUS1skOnck+x+8MJ+FnIxe/AQ==
X-Google-Smtp-Source: ACcGV60IurSusARTjO9Lez908WbukkBCLTndh1sPVC14SQUZArpQRAuFLz6WzwLk0+bXkchfsiaoEw==
X-Received: by 2002:aa7:d707:: with SMTP id t7-v6mr16791955edq.250.1538380625231;
        Mon, 01 Oct 2018 00:57:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d13-v6sm1753208eda.51.2018.10.01.00.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 00:57:04 -0700 (PDT)
Date:   Mon, 1 Oct 2018 09:57:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stefan Agner <stefan@agner.ch>
Cc:     alison.wang@nxp.com, airlied@linux.ie,
        Madhur Verma <madhur.verma@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hemanshu Srivastava <hemanshu.s@samsung.com>,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: Re: [PATCH 2/2] drm/fsl-dcu: use drm_display_mode_to_videomode to
 calculate timing parameters
Message-ID: <20181001075702.GS11082@phenom.ffwll.local>
Mail-Followup-To: Stefan Agner <stefan@agner.ch>, alison.wang@nxp.com,
        airlied@linux.ie, Madhur Verma <madhur.verma@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hemanshu Srivastava <hemanshu.s@samsung.com>,
        Satendra Singh Thakur <satendra.t@samsung.com>
References: <20180926204150.29829-1-stefan@agner.ch>
 <20180926204150.29829-2-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926204150.29829-2-stefan@agner.ch>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:41:50PM +0200, Stefan Agner wrote:
> From: Satendra Singh Thakur <satendra.t@samsung.com>
> 
> Use the drm_display_mode_to_videomode function to calculate front/
> back porches and sync length.
> 
> Cc: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I think if lots of people want this (iirc yours not the only driver that
wants front/back-porch) we should extend the computed crtc_* fields with
this. Kinda silly we force people to go through v4l videomode in drm
drivers. But then, this gets the job done, so maybe an idea for todo.rst?

On both patches:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 32 ++++++++++------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> index 05d1c9977395..18afc94e4dff 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <video/videomode.h>
>  
>  #include "fsl_dcu_drm_crtc.h"
>  #include "fsl_dcu_drm_drv.h"
> @@ -85,39 +86,34 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
>  	struct drm_connector *con = &fsl_dev->connector.base;
>  	struct drm_display_mode *mode = &crtc->state->mode;
> -	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, pol = 0;
> +	unsigned int pol = 0;
> +	struct videomode vm;
>  
>  	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
>  
> -	/* Configure timings: */
> -	hbp = mode->htotal - mode->hsync_end;
> -	hfp = mode->hsync_start - mode->hdisplay;
> -	hsw = mode->hsync_end - mode->hsync_start;
> -	vbp = mode->vtotal - mode->vsync_end;
> -	vfp = mode->vsync_start - mode->vdisplay;
> -	vsw = mode->vsync_end - mode->vsync_start;
> +	drm_display_mode_to_videomode(mode, &vm);
>  
>  	/* INV_PXCK as default (most display sample data on rising edge) */
>  	if (!(con->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE))
>  		pol |= DCU_SYN_POL_INV_PXCK;
>  
> -	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +	if (vm.flags & DISPLAY_FLAGS_HSYNC_LOW)
>  		pol |= DCU_SYN_POL_INV_HS_LOW;
>  
> -	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +	if (vm.flags & DISPLAY_FLAGS_VSYNC_LOW)
>  		pol |= DCU_SYN_POL_INV_VS_LOW;
>  
>  	regmap_write(fsl_dev->regmap, DCU_HSYN_PARA,
> -		     DCU_HSYN_PARA_BP(hbp) |
> -		     DCU_HSYN_PARA_PW(hsw) |
> -		     DCU_HSYN_PARA_FP(hfp));
> +		     DCU_HSYN_PARA_BP(vm.hback_porch) |
> +		     DCU_HSYN_PARA_PW(vm.hsync_len) |
> +		     DCU_HSYN_PARA_FP(vm.hfront_porch));
>  	regmap_write(fsl_dev->regmap, DCU_VSYN_PARA,
> -		     DCU_VSYN_PARA_BP(vbp) |
> -		     DCU_VSYN_PARA_PW(vsw) |
> -		     DCU_VSYN_PARA_FP(vfp));
> +		     DCU_VSYN_PARA_BP(vm.vback_porch) |
> +		     DCU_VSYN_PARA_PW(vm.vsync_len) |
> +		     DCU_VSYN_PARA_FP(vm.vfront_porch));
>  	regmap_write(fsl_dev->regmap, DCU_DISP_SIZE,
> -		     DCU_DISP_SIZE_DELTA_Y(mode->vdisplay) |
> -		     DCU_DISP_SIZE_DELTA_X(mode->hdisplay));
> +		     DCU_DISP_SIZE_DELTA_Y(vm.vactive) |
> +		     DCU_DISP_SIZE_DELTA_X(vm.hactive));
>  	regmap_write(fsl_dev->regmap, DCU_SYN_POL, pol);
>  	regmap_write(fsl_dev->regmap, DCU_BGND, DCU_BGND_R(0) |
>  		     DCU_BGND_G(0) | DCU_BGND_B(0));
> -- 
> 2.19.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
