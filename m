Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B367C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F3F2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N0fxvX/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeL1MQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44155 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732555AbeL1MPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so17358412edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZl86Ng8RRRyTx252mtZZjArORtBEtxc7ZsfLHhg5k0=;
        b=N0fxvX/U2tnKev8PyNCbd9UDYW9h2a9Qd04d9Gy6kVnEfy4sfmscTJO1D/8adSko5X
         AQ5qCQcfH7z8aNSCs1afkQgty1cWGfumpMFOqRml91jc8/ACYmtwHEZpnG86YboGvGTm
         6ezjpe+cgcNVycJvxnQ4KJoQlJLyngs3qDkGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hZl86Ng8RRRyTx252mtZZjArORtBEtxc7ZsfLHhg5k0=;
        b=tAfpUnZsqEyQNie00WyBolROd8+eQK0X7rU+qwirGSdEpFD5q+edQwvAAwm0vC+XVU
         0OyRdrfFWb9bbcimh7lub3k72Aw5AHcF9j1uBERonrVHYe0ocsylLenUkGVcyCixLsP5
         ihED+tmfO3DLk3E7KHaTDE0iRBF1hQc5gLmA8l4eZMpSMLmXW5S+Bfd6091Xa/Qa92sG
         3/Uix1hxpcFAnnTbdm27NnRhH4qY4+M07sUtxqMQwax55bxKSJWWOjXCzVTaEfWWyn5V
         mpaRJD9fey8LoXp/RB79tFmbVZiZTvFVKPFj3XFMH8GUTJM9wGKAAZ1xJmDVxVHo9iyw
         EQwA==
X-Gm-Message-State: AA+aEWbKyiyz9j/e7c8q0jHU2PRTKr6uOpj/JeHYDzfwRf6hypj4ssul
        QcnncPEM3UQxkrukz9SH2saYjA==
X-Google-Smtp-Source: AFSGD/U21RizcuAk+JOBPmVOu4uMk5/oAMmn54WiCpTfHwgS9QjIy77ipco1CkAwXepwi4cNrlKp0Q==
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr21787248eds.91.1545999353378;
        Fri, 28 Dec 2018 04:15:53 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id by5-v6sm6662181ejb.7.2018.12.28.04.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:15:52 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:15:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/fb-helper: Bring back workaround for bugs of
 SDL 1.2
Message-ID: <20181228121549.GU9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Ivan Mironov <mironov.ivan@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        stable@vger.kernel.org
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
 <20181227231308.16904-2-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227231308.16904-2-mironov.ivan@gmail.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:13:07AM +0500, Ivan Mironov wrote:
> SDL 1.2 sets all fields related to the pixel format to zero in some
> cases[1]. Prior to commit db05c48197759 ("drm: fb-helper: Reject all
> pixel format changing requests"), there was an unintentional workaround
> for this that existed for more than a decade. First in device-specific DRM
> drivers, then here in drm_fb_helper.c.
> 
> Previous code containing this workaround just ignores pixel format fields
> from userspace code. Not a good thing either, as this way, driver may
> silently use pixel format different from what client actually requested,
> and this in turn will lead to displaying garbage on the screen. I think
> that returning EINVAL to userspace in this particular case is the right
> option, so I decided to left code from problematic commit untouched
> instead of just reverting it entirely.
> 
> Here is the steps required to reproduce this problem exactly:
> 	1) Compile fceux[2] with SDL 1.2.15 and without GTK or OpenGL
> 	   support. SDL should be compiled with fbdev support (which is
> 	   on by default).
> 	2) Create /etc/fb.modes with following contents (values seems
> 	   not used, and just required to trigger problematic code in
> 	   SDL):
> 
> 		mode "test"
> 		    geometry 1 1 1 1 1
> 		    timings 1 1 1 1 1 1 1
> 		endmode
> 
> 	3) Create ~/.fceux/fceux.cfg with following contents:
> 
> 		SDL.Hotkeys.Quit = 27
> 		SDL.DoubleBuffering = 1
> 
> 	4) Ensure that screen resolution is at least 1280x960 (e.g.
> 	   append "video=Virtual-1:1280x960-32" to the kernel cmdline
> 	   for qemu/QXL).
> 
> 	5) Try to run fceux on VT with some ROM file[3]:
> 
> 		# ./fceux color_test.nes
> 
> [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
>     FB_SetVideoMode()
> [2] http://www.fceux.com
> [3] Example ROM: https://github.com/bokuweb/rustynes/blob/master/roms/color_test.nes
> 
> Reported-by: saahriktu <mail@saahriktu.org>
> Suggested-by: saahriktu <mail@saahriktu.org>
> Cc: stable@vger.kernel.org
> Fixes: db05c48197759 ("drm: fb-helper: Reject all pixel format changing requests")
> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 146 ++++++++++++++++++++------------
>  1 file changed, 93 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index d3af098b0922..aff576c3c4fb 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1621,6 +1621,64 @@ static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
>  	       var_1->transp.msb_right == var_2->transp.msb_right;
>  }
>  
> +static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
> +					 u8 depth)
> +{
> +	switch (depth) {
> +	case 8:
> +		var->red.offset = 0;
> +		var->green.offset = 0;
> +		var->blue.offset = 0;
> +		var->red.length = 8; /* 8bit DAC */
> +		var->green.length = 8;
> +		var->blue.length = 8;
> +		var->transp.offset = 0;
> +		var->transp.length = 0;
> +		break;
> +	case 15:
> +		var->red.offset = 10;
> +		var->green.offset = 5;
> +		var->blue.offset = 0;
> +		var->red.length = 5;
> +		var->green.length = 5;
> +		var->blue.length = 5;
> +		var->transp.offset = 15;
> +		var->transp.length = 1;
> +		break;
> +	case 16:
> +		var->red.offset = 11;
> +		var->green.offset = 5;
> +		var->blue.offset = 0;
> +		var->red.length = 5;
> +		var->green.length = 6;
> +		var->blue.length = 5;
> +		var->transp.offset = 0;
> +		break;
> +	case 24:
> +		var->red.offset = 16;
> +		var->green.offset = 8;
> +		var->blue.offset = 0;
> +		var->red.length = 8;
> +		var->green.length = 8;
> +		var->blue.length = 8;
> +		var->transp.offset = 0;
> +		var->transp.length = 0;
> +		break;
> +	case 32:
> +		var->red.offset = 16;
> +		var->green.offset = 8;
> +		var->blue.offset = 0;
> +		var->red.length = 8;
> +		var->green.length = 8;
> +		var->blue.length = 8;
> +		var->transp.offset = 24;
> +		var->transp.length = 8;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  /**
>   * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
>   * @var: screeninfo to check
> @@ -1654,6 +1712,40 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Workaround for SDL 1.2, which is known to be setting all pixel format
> +	 * fields values to zero in some cases. We treat this situation as a
> +	 * kind of "use some reasonable autodetected values".
> +	 */
> +	if (!var->red.offset     && !var->green.offset    &&
> +	    !var->blue.offset    && !var->transp.offset   &&
> +	    !var->red.length     && !var->green.length    &&
> +	    !var->blue.length    && !var->transp.length   &&
> +	    !var->red.msb_right  && !var->green.msb_right &&
> +	    !var->blue.msb_right && !var->transp.msb_right) {
> +		u8 depth;
> +
> +		/*
> +		 * There is no way to guess the right value for depth when
> +		 * bpp is 16 or 32. So we just restore the behaviour previously
> +		 * introduced here by commit 785b93ef8c309. In fact, this was
> +		 * implemented even earlier in various device drivers.
> +		 */
> +		switch (var->bits_per_pixel) {
> +		case 16:
> +			depth = 15;
> +			break;
> +		case 32:
> +			depth = 24;
> +			break;
> +		default:
> +			depth = var->bits_per_pixel;
> +			break;
> +		}
> +
> +		drm_fb_helper_fill_pixel_fmt(var, depth);

Please use fb->format->depth here instead of guessing.
-Daniel
> +	}
> +
>  	/*
>  	 * drm fbdev emulation doesn't support changing the pixel format at all,
>  	 * so reject all pixel format changing requests.
> @@ -1967,59 +2059,7 @@ void drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe
>  	info->var.yoffset = 0;
>  	info->var.activate = FB_ACTIVATE_NOW;
>  
> -	switch (fb->format->depth) {
> -	case 8:
> -		info->var.red.offset = 0;
> -		info->var.green.offset = 0;
> -		info->var.blue.offset = 0;
> -		info->var.red.length = 8; /* 8bit DAC */
> -		info->var.green.length = 8;
> -		info->var.blue.length = 8;
> -		info->var.transp.offset = 0;
> -		info->var.transp.length = 0;
> -		break;
> -	case 15:
> -		info->var.red.offset = 10;
> -		info->var.green.offset = 5;
> -		info->var.blue.offset = 0;
> -		info->var.red.length = 5;
> -		info->var.green.length = 5;
> -		info->var.blue.length = 5;
> -		info->var.transp.offset = 15;
> -		info->var.transp.length = 1;
> -		break;
> -	case 16:
> -		info->var.red.offset = 11;
> -		info->var.green.offset = 5;
> -		info->var.blue.offset = 0;
> -		info->var.red.length = 5;
> -		info->var.green.length = 6;
> -		info->var.blue.length = 5;
> -		info->var.transp.offset = 0;
> -		break;
> -	case 24:
> -		info->var.red.offset = 16;
> -		info->var.green.offset = 8;
> -		info->var.blue.offset = 0;
> -		info->var.red.length = 8;
> -		info->var.green.length = 8;
> -		info->var.blue.length = 8;
> -		info->var.transp.offset = 0;
> -		info->var.transp.length = 0;
> -		break;
> -	case 32:
> -		info->var.red.offset = 16;
> -		info->var.green.offset = 8;
> -		info->var.blue.offset = 0;
> -		info->var.red.length = 8;
> -		info->var.green.length = 8;
> -		info->var.blue.length = 8;
> -		info->var.transp.offset = 24;
> -		info->var.transp.length = 8;
> -		break;
> -	default:
> -		break;
> -	}
> +	drm_fb_helper_fill_pixel_fmt(&info->var, fb->format->depth);
>  
>  	info->var.xres = fb_width;
>  	info->var.yres = fb_height;
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
