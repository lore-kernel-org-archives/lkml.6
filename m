Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1FB20873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZAOtaTxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeL1MG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:06:59 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37591 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeL1MG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:06:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so17389982edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQzZl3teCsnULOMDzfToWa1ZpsYJloOsq0xqC1iX5mI=;
        b=ZAOtaTxEIUxC7Lhs/BOODrGJw5bcyVBDRe/AgD/HBcsHlPNI3D37GwXeLBXWooz4oH
         JAdqhsM2hnHDQZmeFse/Hq8+Mn6yN2GdircRR5g2ZJsVoF/JRh90JYWCj33L9qFg0/cz
         BJQMNy+BJvPakZwH7/MNncPlK5061WGsHQllM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hQzZl3teCsnULOMDzfToWa1ZpsYJloOsq0xqC1iX5mI=;
        b=YQlETpM15fYXrV0ahuj8LNljR+AL0bUVGFfPwQdSwXrN8ZLnYrCriwee0QxUKd6mX8
         0MCDGMR9LNS+z6uwwSwYee5Vt1aUcpTXxEr99BCk9RihbMyMr36kqR6KqlmtJHtcqFgb
         Pe6ywwMg6glOkoLCD0cdqGRwKclreTsSmdWVUFpBOItSimiZTc7MFoRk2Y+6S+ZwbJvq
         JDXtk7fBLEdjFBsIQZ/C9BAJAxYAZneItm1IaFb0/SgjvTMIDevV4VNj+63HAQw3cfBC
         /gUjiTVjm/Dklrgq/BVQMi8ZdT4wzEmGqukhtNKdBpv/CB2xJv14GsZmPYcDxtvMKxVK
         KjrA==
X-Gm-Message-State: AJcUukeGlJ7Q7mddf7skK4jEoIQC0SWlc8V70cgIG8l7YjYyBS9muP+s
        E4FmGGZuDB81yTD3U4CQO4ooZQ==
X-Google-Smtp-Source: ALg8bN7X+OPf7tzKIw/YjbnWmKzsHqfDZrbLDsmL2zcNM5UVVRg3dOID5RP57UioBPngKB4HeEXbdg==
X-Received: by 2002:a17:906:d0c6:: with SMTP id bq6-v6mr13598531ejb.99.1545998816589;
        Fri, 28 Dec 2018 04:06:56 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id j31sm12995044eda.46.2018.12.28.04.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:06:55 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:06:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH v1 2/2] drm/fb-helper: Ignore the value of
 fb_var_screeninfo.pixclock
Message-ID: <20181228120652.GR9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Ivan Mironov <mironov.ivan@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
 <20181227231308.16904-3-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227231308.16904-3-mironov.ivan@gmail.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:13:08AM +0500, Ivan Mironov wrote:
> Strict requirement of pixclock to be zero breaks support of SDL 1.2
> which contains hardcoded table of supported video modes with non-zero
> pixclock values[1].
> 
> To better understand which pixclock values are considered valid and how
> driver should handle these values, I briefly examined few existing fbdev
> drivers and documentation in Documentation/fb/. And it looks like there
> are no strict rules on that and actual behaviour varies:
> 
> 	* some drivers treat (pixclock == 0) as "use defaults" (uvesafb.c);
> 	* some treat (pixclock == 0) as invalid value which leads to
> 	  -EINVAL (clps711x-fb.c);
> 	* some pass converted pixclock value to hardware (uvesafb.c);
> 	* some are trying to find nearest value from predefined table
>           (vga16fb.c, video_gx.c).
> 
> Given this, I believe that it should be safe to just ignore this value if
> changing is not supported. It seems that any portable fbdev application
> which was not written only for one specific device working under one
> specific kernel version should not rely on any particular behaviour of
> pixclock anyway.
> 
> However, while enabling SDL1 applications to work out of the box when
> there is no /etc/fb.modes with valid settings, this change affects the
> video mode choosing logic in SDL. Depending on current screen
> resolution, contents of /etc/fb.modes and resolution requested by
> application, this may lead to user-visible difference (not always):
> image will be displayed in a right way, but it will be aligned to the
> left instead of center. There is no "right behaviour" here as well, as
> emulated fbdev, opposing to old fbdev drivers, simply ignores any
> requsts of video mode changes with resolutions smaller than current.
> 
> Feel free to NAK this patch if you think that it causes breakage of
> user-space =).

It's a regression, we don't nack regression fixes :-)

> The easiest way to reproduce this problem is to install sdl-sopwith[2],
> remove /etc/fb.modes file if it exists, and then try to run sopwith
> from console without X. At least in Fedora 29, sopwith may be simply
> installed from standard repositories.
> 
> [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
> [2] http://sdl-sopwith.sourceforge.net/
> 
> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>

I thought this is also a regression fix, so also needs Fixes: and cc:
stable?
-Daniel

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index aff576c3c4fb..b95a0c23c7c8 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1690,9 +1690,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  	struct drm_fb_helper *fb_helper = info->par;
>  	struct drm_framebuffer *fb = fb_helper->fb;
>  
> -	if (var->pixclock != 0 || in_dbg_master())
> +	if (in_dbg_master())
>  		return -EINVAL;
>  
> +	if (var->pixclock != 0) {
> +		DRM_DEBUG("fbdev emulation doesn't support changing the pixel clock, value of pixclock is ignored\n");
> +		var->pixclock = 0;
> +	}
> +
>  	if ((drm_format_info_block_width(fb->format, 0) > 1) ||
>  	    (drm_format_info_block_height(fb->format, 0) > 1))
>  		return -EINVAL;
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
