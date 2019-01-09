Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00EEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC91F20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JlOkbYHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfAIKMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:12:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40652 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfAIKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:12:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so6803709edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oj+JtWeU8zvsVuS3Om8StAQI7g0mMGfBcOrF313LwcI=;
        b=JlOkbYHqRaibeoV/Q2SHzwQpAyFqKFNAjlptIr9ZSuRBcKb3IovdrhDIdbLXT+Bzur
         YgIj+eKnqstpYFBqW+UAvzviFpjiYtWBq4o55fbsxP1jvS6hSEUfT6uRA52+eZ6PYx9w
         xooQYPD53sNOYI1AVPZQtCfegl99opDfLZHpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oj+JtWeU8zvsVuS3Om8StAQI7g0mMGfBcOrF313LwcI=;
        b=Q8X3tzhkdCA/CLldx8VzpaUlgGsMmRQbTzK6iTeibv+mYmN5fDUnrNmLUMTbuOylif
         aZ4EVpBXXwMGJwLoQDsrbO52BIkASTwtTJm40gxbtKWJOrKAycUxD0Scdq1EJL7M8tCT
         yYQa+rFHnbigpzWpyQb/81cB4IFfk7V09Qjw9+eKcUt+8osMS9CyIh3dx79WNF2DPzqj
         QW5VkC6bafAeWhr11xmtgRa1AYz8snBTRei0ioAAiZd3CWWG7kf139G6Sykr4lN1TRIz
         Vt3B6yfU8xoOccISevqxWQx0VzWxzARrfO+KdYGHHZnaOkmYGvqEHp/KIK9fohX/r9Wz
         hPVA==
X-Gm-Message-State: AJcUukeJNDDyUVW9NUBpIy5R+iz2ibZVk6S4va54wtgL9vIwsLQaKUIA
        GsmERuGPukOaOOTSZeYfSnf0Ag==
X-Google-Smtp-Source: ALg8bN4XvgTTDiBxSG8f9miuV/7n4uRxfO/5fLLJnOztcGvuLSNuNMWYdpnIcxVbVbqxKMP+qUnOZw==
X-Received: by 2002:a50:a55c:: with SMTP id z28mr5414490edb.124.1547028747626;
        Wed, 09 Jan 2019 02:12:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v11sm839438edy.49.2019.01.09.02.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 02:12:26 -0800 (PST)
Date:   Wed, 9 Jan 2019 11:12:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Message-ID: <20190109101224.GT21184@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20190108123129.20031-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108123129.20031-1-peda@axentia.se>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:31:36PM +0000, Peter Rosin wrote:
> While trying to temporarily hide a plane, one thing that was attempted
> was to call (from libdrm)
> 
> 	drmModeSetPlane(fd, plane_id, crtc_id, fb_id, 0,
> 			0, 0, 0, 0, 0, 0, 0, 0);
> 
> This call causes a pair of "Division by zero in kernel." messages. Kill
> those messages, but preserve the current behaviour that also happen to
> make the plane disappear with the above call.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> Side note, when comparing with drm_atomic_helper_check_plane_state(), I get
> the feeling that the src rect should be clipped together with the crtc rect
> if/when clipping is needed. That function calls drm_rect_clip_scaled(), and
> the equivalent does not seem to happen here. Should clipping be performed
> on the src rect?

Any reasons atmel can't switch over to that helper? Would compute a nice
->visible state variable for you ...
-Daniel

> 
> Cheers,
> Peter
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 3cc489b870fe..1bdb30dc218c 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -675,10 +675,16 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  		state->crtc_y = 0;
>  	}
>  
> -	patched_src_w = DIV_ROUND_CLOSEST(patched_crtc_w * state->src_w,
> -					  state->crtc_w);
> -	patched_src_h = DIV_ROUND_CLOSEST(patched_crtc_h * state->src_h,
> -					  state->crtc_h);
> +	if (state->crtc_w)
> +		patched_src_w = DIV_ROUND_CLOSEST(patched_crtc_w * state->src_w,
> +						  state->crtc_w);
> +	else
> +		patched_src_w = 0;
> +	if (state->crtc_h)
> +		patched_src_h = DIV_ROUND_CLOSEST(patched_crtc_h * state->src_h,
> +						  state->crtc_h);
> +	else
> +		patched_src_h = 0;
>  
>  	hsub = drm_format_horz_chroma_subsampling(fb->format->format);
>  	vsub = drm_format_vert_chroma_subsampling(fb->format->format);
> -- 
> 2.11.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
