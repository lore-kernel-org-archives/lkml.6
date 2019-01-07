Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6BC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750EF20854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JwKl19Wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfAGKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:08:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33050 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:08:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so333779eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDnt6qLaS59xIovYIhHYFf5cjY9EzLWq8SNUgTs+I9g=;
        b=JwKl19Wgb38EI75Ec3DBXJSwWDU+z7lmFrG/qP8DIZ4LumRna4M7aE5D1qOJlQpG4e
         VYIqECc1pZs1swKMhk6LODKuvBncxzwcEmACtyQK//EgnnrPKduw2wvuSAme41lbPtTm
         jU2hYWhdFCayxLL0sthdavc3G/hmKMlrA7Xl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RDnt6qLaS59xIovYIhHYFf5cjY9EzLWq8SNUgTs+I9g=;
        b=s4qoSvm2CkFoRKR8mvoIMAGMGfJmGD7hKDczzZZIHtq/SvJB51sNTRsMyLk5UBfd3y
         hMnxHdavKvZVHpQA1ewNF7lAEEA7SCdiKUOlQnfkFb1G8Slm57zDQTrDockTkcYofI9z
         d4rCTlagMuaZw9paKRJsWp7037X8onNrQ93X4jJdim6TqzzC8Q8UVC354gc2SasI37gN
         fGO3MjhS6PzL2431yK+qVrhFOMYRT61dwG4Vh2LMhpX+tl23ZDCCyKpraJNTgol2RhO3
         mdiS6gIUZU2McBDLksRVXuwL7mmRyMLSH4LW9TGvB5rt/OGJuUvYP3rlKP9xWfbGnxdt
         F6Ew==
X-Gm-Message-State: AJcUukejIIjFWF5WUYCuIbXoWrwsduf4z1SCK7N0uuz/BzG/yv04nTKd
        89zdrt0fREMmxoSMMo/3usyXwA==
X-Google-Smtp-Source: ALg8bN4mfE0GESZWFR+w0oW7lDQiFRMHeGsiOVGH2xH+XtL/XckNpKt0eNce0UKV9YwjgnJOPJacOw==
X-Received: by 2002:a17:906:f108:: with SMTP id gv8-v6mr29428457ejb.173.1546855725514;
        Mon, 07 Jan 2019 02:08:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d56sm30981734ede.76.2019.01.07.02.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 02:08:44 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:08:42 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/fb-helper: Bring back workaround for bugs of
 SDL 1.2
Message-ID: <20190107100842.GZ21184@phenom.ffwll.local>
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
 <20181228121549.GU9058@dvetter-linux.ger.corp.intel.com>
 <e4754c8dab11b1f8b61a7fb2aae690b979cc7209.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4754c8dab11b1f8b61a7fb2aae690b979cc7209.camel@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 09:11:53PM +0500, Ivan Mironov wrote:
> On Fri, 2018-12-28 at 13:15 +0100, Daniel Vetter wrote:
> > On Fri, Dec 28, 2018 at 04:13:07AM +0500, Ivan Mironov wrote:
> > > SDL 1.2 sets all fields related to the pixel format to zero in some
> > > cases[1]. Prior to commit db05c48197759 ("drm: fb-helper: Reject all
> > > pixel format changing requests"), there was an unintentional workaround
> > > for this that existed for more than a decade. First in device-specific DRM
> > > drivers, then here in drm_fb_helper.c.
> > > 
> > > Previous code containing this workaround just ignores pixel format fields
> > > from userspace code. Not a good thing either, as this way, driver may
> > > silently use pixel format different from what client actually requested,
> > > and this in turn will lead to displaying garbage on the screen. I think
> > > that returning EINVAL to userspace in this particular case is the right
> > > option, so I decided to left code from problematic commit untouched
> > > instead of just reverting it entirely.
> > > 
> > > Here is the steps required to reproduce this problem exactly:
> > > 	1) Compile fceux[2] with SDL 1.2.15 and without GTK or OpenGL
> > > 	   support. SDL should be compiled with fbdev support (which is
> > > 	   on by default).
> > > 	2) Create /etc/fb.modes with following contents (values seems
> > > 	   not used, and just required to trigger problematic code in
> > > 	   SDL):
> > > 
> > > 		mode "test"
> > > 		    geometry 1 1 1 1 1
> > > 		    timings 1 1 1 1 1 1 1
> > > 		endmode
> > > 
> > > 	3) Create ~/.fceux/fceux.cfg with following contents:
> > > 
> > > 		SDL.Hotkeys.Quit = 27
> > > 		SDL.DoubleBuffering = 1
> > > 
> > > 	4) Ensure that screen resolution is at least 1280x960 (e.g.
> > > 	   append "video=Virtual-1:1280x960-32" to the kernel cmdline
> > > 	   for qemu/QXL).
> > > 
> > > 	5) Try to run fceux on VT with some ROM file[3]:
> > > 
> > > 		# ./fceux color_test.nes
> > > 
> > > [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
> > >     FB_SetVideoMode()
> > > [2] http://www.fceux.com
> > > [3] Example ROM: https://github.com/bokuweb/rustynes/blob/master/roms/color_test.nes
> > > 
> > > Reported-by: saahriktu <mail@saahriktu.org>
> > > Suggested-by: saahriktu <mail@saahriktu.org>
> > > Cc: stable@vger.kernel.org
> > > Fixes: db05c48197759 ("drm: fb-helper: Reject all pixel format changing requests")
> > > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_fb_helper.c | 146 ++++++++++++++++++++------------
> > >  1 file changed, 93 insertions(+), 53 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > > index d3af098b0922..aff576c3c4fb 100644
> > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > @@ -1621,6 +1621,64 @@ static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
> > >  	       var_1->transp.msb_right == var_2->transp.msb_right;
> > >  }
> > >  
> > > +static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
> > > +					 u8 depth)
> > > +{
> > > +	switch (depth) {
> > > +	case 8:
> > > +		var->red.offset = 0;
> > > +		var->green.offset = 0;
> > > +		var->blue.offset = 0;
> > > +		var->red.length = 8; /* 8bit DAC */
> > > +		var->green.length = 8;
> > > +		var->blue.length = 8;
> > > +		var->transp.offset = 0;
> > > +		var->transp.length = 0;
> > > +		break;
> > > +	case 15:
> > > +		var->red.offset = 10;
> > > +		var->green.offset = 5;
> > > +		var->blue.offset = 0;
> > > +		var->red.length = 5;
> > > +		var->green.length = 5;
> > > +		var->blue.length = 5;
> > > +		var->transp.offset = 15;
> > > +		var->transp.length = 1;
> > > +		break;
> > > +	case 16:
> > > +		var->red.offset = 11;
> > > +		var->green.offset = 5;
> > > +		var->blue.offset = 0;
> > > +		var->red.length = 5;
> > > +		var->green.length = 6;
> > > +		var->blue.length = 5;
> > > +		var->transp.offset = 0;
> > > +		break;
> > > +	case 24:
> > > +		var->red.offset = 16;
> > > +		var->green.offset = 8;
> > > +		var->blue.offset = 0;
> > > +		var->red.length = 8;
> > > +		var->green.length = 8;
> > > +		var->blue.length = 8;
> > > +		var->transp.offset = 0;
> > > +		var->transp.length = 0;
> > > +		break;
> > > +	case 32:
> > > +		var->red.offset = 16;
> > > +		var->green.offset = 8;
> > > +		var->blue.offset = 0;
> > > +		var->red.length = 8;
> > > +		var->green.length = 8;
> > > +		var->blue.length = 8;
> > > +		var->transp.offset = 24;
> > > +		var->transp.length = 8;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +}
> > > +
> > >  /**
> > >   * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
> > >   * @var: screeninfo to check
> > > @@ -1654,6 +1712,40 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Workaround for SDL 1.2, which is known to be setting all pixel format
> > > +	 * fields values to zero in some cases. We treat this situation as a
> > > +	 * kind of "use some reasonable autodetected values".
> > > +	 */
> > > +	if (!var->red.offset     && !var->green.offset    &&
> > > +	    !var->blue.offset    && !var->transp.offset   &&
> > > +	    !var->red.length     && !var->green.length    &&
> > > +	    !var->blue.length    && !var->transp.length   &&
> > > +	    !var->red.msb_right  && !var->green.msb_right &&
> > > +	    !var->blue.msb_right && !var->transp.msb_right) {
> > > +		u8 depth;
> > > +
> > > +		/*
> > > +		 * There is no way to guess the right value for depth when
> > > +		 * bpp is 16 or 32. So we just restore the behaviour previously
> > > +		 * introduced here by commit . In fact, this was
> > > +		 * implemented even earlier in various device drivers.
> > > +		 */
> > > +		switch (var->bits_per_pixel) {
> > > +		case 16:
> > > +			depth = 15;
> > > +			break;
> > > +		case 32:
> > > +			depth = 24;
> > > +			break;
> > > +		default:
> > > +			depth = var->bits_per_pixel;
> > > +			break;
> > > +		}
> > > +
> > > +		drm_fb_helper_fill_pixel_fmt(var, depth);
> > 
> > Please use fb->format->depth here instead of guessing.
> > -Daniel
> 
> I do not think that this is the right way.
> 
> Without guessing, if SDL1 makes a request with bits_per_pixel == 16
> (for example) and current fb->format->depth == 24, ioctl() will succeed
> while actual pixel format will remain the same. As a result, SDL1 will
> display garbage because of invalid pixel format.
> 
> Or am I missing something here?

This is supposed to be the case where SDL didn't set any of this stuff.
Guess is definitely not what we want to do, we should use the actual
depth, which is stored in fb->format->depth. Older code did guess, but we
fixed that, and shouldn't reintroduce that guess game.
-Daniel

> 
> > > +	}
> > > +
> > >  	/*
> > >  	 * drm fbdev emulation doesn't support changing the pixel format at all,
> > >  	 * so reject all pixel format changing requests.oid drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe 	info->var.yoffset = 0; 	info->var.activate = FB_ACTIVATE_NOW; 
> > > -	switch (fb->format->depth) {
> > > -	case 8:
> > > -		info->var.red.offset = 0;
> > > -		info->var.green.offset = 0;
> > > -		info->var.blue.offset = 0;
> > > -		info->var.red.length = 8; /* 8bit DAC */
> > > -		info->var.green.length = 8;
> > > -		info->var.blue.length = 8;
> > > -		info->var.transp.offset = 0;
> > > -		info->var.transp.length = 0;
> > > -		break;
> > > -	case 15:
> > > -		info->var.red.offset = 10;
> > > -		info->var.green.offset = 5;
> > > -		info->var.blue.offset = 0;
> > > -		info->var.red.length = 5;
> > > -		info->var.green.length = 5;
> > > -		info->var.blue.length = 5;
> > > -		info->var.transp.offset = 15;
> > > -		info->var.transp.length = 1;
> > > -		break;
> > > -	case 16:
> > > -		info->var.red.offset = 11;
> > > -		info->var.green.offset = 5;
> > > -		info->var.blue.offset = 0;
> > > -		info->var.red.length = 5;
> > > -		info->var.green.length = 6;
> > > -		info->var.blue.length = 5;
> > > -		info->var.transp.offset = 0;
> > > -		break;
> > > -	case 24:
> > > -		info->var.red.offset = 16;
> > > -		info->var.green.offset = 8;
> > > -		info->var.blue.offset = 0;
> > > -		info->var.red.length = 8;
> > > -		info->var.green.length = 8;
> > > -		info->var.blue.length = 8;
> > > -		info->var.transp.offset = 0;
> > > -		info->var.transp.length = 0;
> > > -		break;
> > > -	case 32:
> > > -		info->var.red.offset = 16;
> > > -		info->var.green.offset = 8;
> > > -		info->var.blue.offset = 0;
> > > -		info->var.red.length = 8;
> > > -		info->var.green.length = 8;
> > > -		info->var.blue.length = 8;
> > > -		info->var.transp.offset = 24;
> > > -		info->var.transp.length = 8;
> > > -		break;
> > > -	default:
> > > -		break;
> > > -	}
> > > +	drm_fb_helper_fill_pixel_fmt(&info->var, fb->format->depth);
> > >  
> > >  	info->var.xres = fb_width;
> > >  	info->var.yres = fb_height;
> > > -- 
> > > 2.20.1
> > > 
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
