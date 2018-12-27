Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03631C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00EA2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iPo3/OG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbeL0MAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 07:00:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37288 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeL0MAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 07:00:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so15072321edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 04:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Z2nXOoo7zeGL4WRSy4tjBwawT3RfT2QrVNWCGl1Dlk=;
        b=iPo3/OG6tDnSx+6U2AbZqJbbq4PGlupSBuS3VGxZYAHDeGANaaUFmSNuyNpKushAlj
         snrmoMpxEhUyV/nTJ3vuQx64Gu7PAQUTC7QX9ZZk56stjSSJwl35W6aMjCNRJ4Qy1UQ1
         CnAd+mEv88F7NpPYcDZVWR8eiduYoHOYRfWL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6Z2nXOoo7zeGL4WRSy4tjBwawT3RfT2QrVNWCGl1Dlk=;
        b=drkCdB5Wdvz/THpJ3c9Ij5K/Xv8Zen/TIhVWbK+pZRxieYRCTKPFrC/vdXkeLNW6F/
         RGkS3D5Q7ba1GdVrYz8Us0+/6PXbC4i2892JjOTVhJYieIi3lxdlGf3iIVtFczquc9hC
         eTP4L6mQ8eP427afzE/g52nS/a3bhNiQIPjqie0b3SJaYeAzlpiCLebufRfycqtnlAAM
         LpmamP4lHxUUr3YkzItkwuYmj6sBQKAttWhfamCpokmdhbaWHpywXG5POJmUNXLfbRoh
         BiB9FGs8488DKbWCZOo1xtyjrmegCflGbucl+eQIlR0IlnBgxlGh6MQ1JlBIU/gyy+c4
         wKEA==
X-Gm-Message-State: AA+aEWY//oeIuAq/QFNwcMcpFczM4dtEFqEIY61qVgU3rV5r1dv90Mi5
        Vg8MEhXooxli4yWLQdvXC1VwmA==
X-Google-Smtp-Source: AFSGD/WhhY3670W95s+FmaFUG12WOBBofzCIsIVZvYsTb6xGjsGA7dB4q4pjYZ5/eVMs2JZ5nc3HuQ==
X-Received: by 2002:aa7:d749:: with SMTP id a9mr17878838eds.223.1545912050516;
        Thu, 27 Dec 2018 04:00:50 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id z6-v6sm5627752ejq.63.2018.12.27.04.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 04:00:49 -0800 (PST)
Date:   Thu, 27 Dec 2018 13:00:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [RFC PATCH 1/2] drm/fb-helper: Bring back workaround for bugs of
 SDL 1.2
Message-ID: <20181227120046.GC9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Ivan Mironov <mironov.ivan@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
References: <20181226121124.1632-1-mironov.ivan@gmail.com>
 <20181226121124.1632-2-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226121124.1632-2-mironov.ivan@gmail.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 05:11:23PM +0500, Ivan Mironov wrote:
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
> [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
>     FB_SetVideoMode()
> 
> Reported-by: saahriktu <mail@saahriktu.org>
> Suggested-by: saahriktu <mail@saahriktu.org>
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

The guesswork here looks fishy. We should still have the drm-side format,
and should use that. Otherwise the patches look good I think, but they
need a Fixes: tag and cc: stable so backporters know what to do with
these.
-Daniel

> +
> +		drm_fb_helper_fill_pixel_fmt(var, depth);
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
