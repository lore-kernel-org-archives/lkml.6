Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92662C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554B320665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Su8wtMPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfAHIRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:17:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34605 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfAHIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:17:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so3323602ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 00:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrTW/cgwRnEbkyp/pqxFAbGGTh1Sm6QSGMBFEXr65Cg=;
        b=Su8wtMPIWvxgtxOo9gxmM3ofvr8iuzaPUyfoOWqAPPUIw5WWy/joL0BffjT7rFPBQ4
         HYL+e+UqWfOditGIMTzbHWgl+XK2wAzlJpRXRkN6hrRtDD2ENnCozaHNj8qxzWRWbUTT
         O+KdcP+T6bq2cqh3CwVFSd4jiCTXBvXbLNt8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zrTW/cgwRnEbkyp/pqxFAbGGTh1Sm6QSGMBFEXr65Cg=;
        b=A9X2RgFHv+D2D9jaWnw7l2fPn5ckW+yE8/08PQykGhdJTkFVN/kRoJa/vn7DMpSWrP
         I4XJp0we/bC/WA7Mx0QdddCisOwqLkwy0HyEbAu032MTKxhYPQGmYcse0uwAPYY0Jx5V
         dEfzaY53b6ltSEoqNiJjhzSlJvfPLPs99Lri2BuFLrcrwSWWwrUY+zgiPoZv99cOYDH0
         yH4AJykuZJjMQfVlAviGtcOUwUD6C6PJUs4uPvwrPqOK+iUq5mq1sXFPXbNUEVXNK3Yl
         wcfKEdXgJ584qsFqqagHwsGHUdlKcaIxQQ6Q+RCoOP4ovMlFIo0hWHxotMTPzZkDVfEJ
         Em3A==
X-Gm-Message-State: AJcUuketPoeThSJvxUB3oGmp86LF6Ix7cRHQyBZ3qpf4T0Mbi3Cy2HSe
        pMf6TARKza5Yxp2jcgABId3fiQfzAwQ=
X-Google-Smtp-Source: ALg8bN4YniGTXIjqKl2v3UTUfRYxJFEsiu/kNR7YXrDFjEPHwJFmWBCLwpGseN+iDvYZ8imCHmLBrg==
X-Received: by 2002:a50:aa9b:: with SMTP id q27mr1119828edc.93.1546935472536;
        Tue, 08 Jan 2019 00:17:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n11sm32655002edn.14.2019.01.08.00.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 00:17:51 -0800 (PST)
Date:   Tue, 8 Jan 2019 09:17:49 +0100
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
Subject: Re: [PATCH v2 1/2] drm/fb-helper: Partially bring back workaround
 for bugs of SDL 1.2
Message-ID: <20190108081749.GP21184@phenom.ffwll.local>
Mail-Followup-To: Ivan Mironov <mironov.ivan@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        stable@vger.kernel.org
References: <20190108072353.28078-1-mironov.ivan@gmail.com>
 <20190108072353.28078-2-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108072353.28078-2-mironov.ivan@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:23:52PM +0500, Ivan Mironov wrote:
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
>  drivers/gpu/drm/drm_fb_helper.c | 142 ++++++++++++++++++++------------
>  1 file changed, 89 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index d3af098b0922..ed7e91423258 100644
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
> @@ -1654,6 +1712,36 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
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
> +		/*
> +		 * There is no way to guess the right value for depth when
> +		 * bits_per_pixel is 16 or 32. Instead of restoring the
> +		 * behaviour previously introduced here by commit 785b93ef8c309,
> +		 * we decided to just use the current depth and do not perform
> +		 * any guessing.
> +		 *
> +		 * Also, if requested bits_per_pixel differs from current,
> +		 * the next call to drm_fb_pixel_format_equal() will fail
> +		 * resulting in EINVAL error from ioctl().
> +		 *
> +		 * However, this still leaves the theoretical possibility of
> +		 * situation when userspace app requests different pixel format
> +		 * and ioctl() call silently succeeds. Garbage will be displayed
> +		 * in this case.
> +		 */

I deleted this comment since I think it's misleading: We only need depth
to decided for the pixel format when userspace hasn't filled it out. We
could also change the function to instead pass fb->format, and use that as
the key to fill out the fbdev format information. That's why I requested
you keep Ville's change here, it was a bugfix.

So ther's no guessing going on here at all, and nothing else fancy: All we
do is fill out the fbdev pixel format information if userspace failed to
supply it. That's imo clear enough without a comment.

Applied both comments for 5.0 drm-misc-fixes, thanks a lot for your
patches and debug work.

Cheers, Daniel

> +		drm_fb_helper_fill_pixel_fmt(var, fb->format->depth);
> +	}
> +
>  	/*
>  	 * drm fbdev emulation doesn't support changing the pixel format at all,
>  	 * so reject all pixel format changing requests.
> @@ -1967,59 +2055,7 @@ void drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe
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
