Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5796521473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TYhxUl0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5796521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJDRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:02:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41978 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:02:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so8012775edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrRfwHd2XEk+J9Pc5pppRSs6dgkBz6W9RXEh1coAO7E=;
        b=TYhxUl0+8/8Y3KMEb35yQTaEcL+CZ2VenqL/Ey4XL3vnfAwutp452ffWpoO8b9fZdO
         sUNARRZlWlpCgTDuMRor565LQZ8Z5u2m7YdI1SRb++6ftzjEMxFbOLWpd/wn9muFA4ky
         nfiSRn9iZJ418+PCfFI3Jdm9fb7BN5eNPUN/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qrRfwHd2XEk+J9Pc5pppRSs6dgkBz6W9RXEh1coAO7E=;
        b=QMaF6bQ7/UeJqVzYNPjNrNVIdqdqNXgv7eG+mSD2fy4qorbC1Z2D8my82e4GGnLVmN
         qXveVsxEIWgZfbZBVWprM9jHyiqnNnm+Q8f9n7Wk2qnjuXvN2Qfiog8cPA3EJ1T2KGI8
         I5VK4RkxSVcTHXUxlqqvLR2pmtgt+OA9RmUvsED/AaboTIa1Kdzb+TtwQb6QfgFGAwQI
         KRGEApxkdxR+4jDG3bRYdyBEVl3cNOLU2LrkTvOvfo454t39llyZBSb711/4+3YeJHSV
         wOc4cmIHqQ0A3fs0UjQd6KuQA5wvnrgjZugD31GDAcRE8ocuLyg56Oqll1o5pqccZMbT
         FIrQ==
X-Gm-Message-State: ABuFfoh6U0oL/BU2ciUyHKyki/2cWeGmrkgrDV9m1EJ6S0WjJ9hmvlHf
        iGSXrJx9Uy1cEyvTS9+f0lceVQ==
X-Google-Smtp-Source: ACcGV630+nugQA54oaCb1641c/CtxBo4WWiiy2+vog9aVjHAwGOPzSdtUp5txxMgPZChjI2iwS9h5A==
X-Received: by 2002:aa7:d352:: with SMTP id m18-v6mr7331958edr.266.1538647802292;
        Thu, 04 Oct 2018 03:10:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gi7-v6sm779608ejb.55.2018.10.04.03.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 03:10:00 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:09:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/meson: fix max mode_config height/width
Message-ID: <20181004100958.GI31561@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:42:43AM +0200, Neil Armstrong wrote:
> The mode_config max_width/max_height determines the maximum framebuffer
> size the pixel reader can handle. But the values were set thinking they
> were determining the maximum screen dimensions.
> 
> This patch changes the values to the maximum height/width the CANVAS block
> can handle rounded to some coherent values.
> 
> Fixes: a41e82e6c457 ("drm/meson: Add support for components")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

It's both. Grep for all the callers of ->fill_modes and you'll see that
this limit is also used to filter max screen sizes.

If you want to change this, then I think we need a new
mode_config.fb_max_width/height, which if non-zero, would extend the limit
for fbs.

There's also the problem that if you extend this for fbs, then there's no
check anymore in the atomic_commit paths (or legacy modeset), so that
needs to be addressed somehow too.

Bunch of igt to make sure we're not missing anything would be sweet on
top, e.g. e.g. trying to set a mode over the limit and making sure it
fails.

Cheers, Daniel

> ---
>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index d344312..2e29968 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  		goto free_drm;
>  
>  	drm_mode_config_init(drm);
> -	drm->mode_config.max_width = 3840;
> -	drm->mode_config.max_height = 2160;
> +	drm->mode_config.max_width = 16384;
> +	drm->mode_config.max_height = 8192;
>  	drm->mode_config.funcs = &meson_mode_config_funcs;
>  
>  	/* Hardware Initialization */
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
