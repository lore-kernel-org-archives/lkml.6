Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A6B20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DZct6zBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfAGKLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:11:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34668 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfAGKK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so334639ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qUkbCEmsntdfIG+umww963vUUwTtYgwvxVwPjf2SD/8=;
        b=DZct6zBL6cO8bvOVvbgRzCoic5h4bzwzfjIDjukSlHsl9iCEC/r7y+qPl0mZkDmJaw
         pUhf5jZ1bSGT2eP1G+ROOHv4+96/8QuuJ0O1EjTVw42j/f4S3aYsLLkZkngcFVu807Lh
         aGWpsa+ltf8mm4tN7ZXhQluGA/cM56qbyFPIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qUkbCEmsntdfIG+umww963vUUwTtYgwvxVwPjf2SD/8=;
        b=SAzmZnWoaJ9tcRxc4fX8OZGzTZqhEeM9Ca0MSoTmXuH310b0upDXkea7jQy1xzbk/x
         RW4ycHyAD6G6A/gNj2EZzjzelcVNniW1SWRtvf+yNWp73xTlYDJjgFjxpNMkRvIc8Kan
         lcqnRqY2RYP68sUaw1IGRQJ7NRhSNW6tOtpQNFyq4Efry5INIoKELXyDL6WiacfHIdD/
         S7TRk+FN3/BO0UmJOZgvWmzo6iMyml++r/ysCgu9vTWlgN9P53GepkwFr7b0uggTX/UV
         8lK3kXv6kjxbbR5/JCyxeKCPaLRKKmwK8Py79Ema4UB/3igOsLG1TKjvtN8DINA+Xe8U
         hsTQ==
X-Gm-Message-State: AA+aEWa58TDI0UVm0n/7VlCiGir/Qnh2bphy2VQhjxaolBghrHkhbinQ
        ov3MgP31b+pySt/lZtIJGtpaVg==
X-Google-Smtp-Source: AFSGD/VqFIUBl/04MXobmMi8biGDuv7a5G4jej4blWUGGAxq4r16hsTLTmab7RbPAdfRZXkfdKr96g==
X-Received: by 2002:a17:906:6a9b:: with SMTP id p27-v6mr47172326ejr.235.1546855825787;
        Mon, 07 Jan 2019 02:10:25 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gk8-v6sm19867143ejb.42.2019.01.07.02.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 02:10:25 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:10:22 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH v1 2/2] drm/fb-helper: Ignore the value of
 fb_var_screeninfo.pixclock
Message-ID: <20190107101022.GA21184@phenom.ffwll.local>
Mail-Followup-To: Ivan Mironov <mironov.ivan@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
 <20181227231308.16904-3-mironov.ivan@gmail.com>
 <20181228120652.GR9058@dvetter-linux.ger.corp.intel.com>
 <b9f21efe2fe2d0a71ad6672fbe9155df52ac5e02.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f21efe2fe2d0a71ad6672fbe9155df52ac5e02.camel@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 09:21:21PM +0500, Ivan Mironov wrote:
> On Fri, 2018-12-28 at 13:06 +0100, Daniel Vetter wrote:
> > On Fri, Dec 28, 2018 at 04:13:08AM +0500, Ivan Mironov wrote:
> > > Strict requirement of pixclock to be zero breaks support of SDL 1.2
> > > which contains hardcoded table of supported video modes with non-zero
> > > pixclock values[1].
> > > 
> > > To better understand which pixclock values are considered valid and how
> > > driver should handle these values, I briefly examined few existing fbdev
> > > drivers and documentation in Documentation/fb/. And it looks like there
> > > are no strict rules on that and actual behaviour varies:
> > > 
> > > 	* some drivers treat (pixclock == 0) as "use defaults" (uvesafb.c);
> > > 	* some treat (pixclock == 0) as invalid value which leads to
> > > 	  -EINVAL (clps711x-fb.c);
> > > 	* some pass converted pixclock value to hardware (uvesafb.c);
> > > 	* some are trying to find nearest value from predefined table
> > >           (vga16fb.c, video_gx.c).
> > > 
> > > Given this, I believe that it should be safe to just ignore this value if
> > > changing is not supported. It seems that any portable fbdev application
> > > which was not written only for one specific device working under one
> > > specific kernel version should not rely on any particular behaviour of
> > > pixclock anyway.
> > > 
> > > However, while enabling SDL1 applications to work out of the box when
> > > there is no /etc/fb.modes with valid settings, this change affects the
> > > video mode choosing logic in SDL. Depending on current screen
> > > resolution, contents of /etc/fb.modes and resolution requested by
> > > application, this may lead to user-visible difference (not always):
> > > image will be displayed in a right way, but it will be aligned to the
> > > left instead of center. There is no "right behaviour" here as well, as
> > > emulated fbdev, opposing to old fbdev drivers, simply ignores any
> > > requsts of video mode changes with resolutions smaller than current.
> > > 
> > > Feel free to NAK this patch if you think that it causes breakage of
> > > user-space =).
> > 
> > It's a regression, we don't nack regression fixes :-)
> > 
> > > The easiest way to reproduce this problem is to install sdl-sopwith[2],
> > > remove /etc/fb.modes file if it exists, and then try to run sopwith
> > > from console without X. At least in Fedora 29, sopwith may be simply
> > > installed from standard repositories.
> > > 
> > > [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
> > > [2] http://sdl-sopwith.sourceforge.net/
> > > 
> > > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> > 
> > I thought this is also a regression fix, so also needs Fixes: and cc:
> > stable?
> > -Daniel
> 
> This particular patch fixes a bug that existed for 10 years unnoticed.
> Are "Fixes:" and "Cc: stable" really required?
> 
> "pixclock != 0" check was introduced in this file by 785b93ef8c309
> ("drm/kms: move driver specific fb common code to helper functions
> (v2)"). But actually similar code existed in the device-specific
> drivers even earlier.

Afaui 785b93ef8c309 broke existing userspace. Broken userspace, but
existing userspace, and hence we need to fix this regression. That's the
rules with linux upstream, existing userspace is never allowed to break,
even if it does really stupid things. Hence Cc: stable.
-Daniel

> 
> > 
> > > ---
> > >  drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > > index aff576c3c4fb..b95a0c23c7c8 100644
> > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > @@ -1690,9 +1690,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> > >  	struct drm_fb_helper *fb_helper = info->par;
> > >  	struct drm_framebuffer *fb = fb_helper->fb;
> > >  
> > > -	if (var->pixclock != 0 || in_dbg_master())
> > > +	if (in_dbg_master())
> > >  		return -EINVAL;
> > >  
> > > +	if (var->pixclock != 0) {
> > > +		DRM_DEBUG("fbdev emulation doesn't support changing the pixel clock, value of pixclock is ignored\n");
> > > +		var->pixclock = 0;
> > > +	}
> > > +
> > >  	if ((drm_format_info_block_width(fb->format, 0) > 1) ||
> > >  	    (drm_format_info_block_height(fb->format, 0) > 1))
> > >  		return -EINVAL;
> > > -- 
> > > 2.20.1
> > > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
