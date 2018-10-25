Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DC1ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BA620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Xpau0iAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BA620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJZCrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:47:42 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36990 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbeJZCrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:47:42 -0400
Received: by mail-yb1-f194.google.com with SMTP id d18-v6so4080637yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x6pg4/s2+sEQTUvLHibRi2LVBl8g5s3Awm8Kd9svFoA=;
        b=Xpau0iAPIqe9mUuHt2f4t+mAf8PXBlAA2qBxeEQ40Tw2n6iHiREb4M40PumvrgbDpR
         lWHoT9yTBhXM6ZFH1AaQxpd559ajmCoEPAfHIxlK+AdhBlSloFq08ryJQfXSSfMLUxPI
         sVWrzyCPC5h3/7TtNcSjygUGDxlaOxpmKscD6mdoNaYIhk3tffUYI2XKmD2Q7/IVkB1a
         HqdY2RX9ynlrZjkN067SWazQk+7Ku1j9oDnCmWoRMFV3aU5SscG9rwCigzOhYcHKoiLM
         leoAwsCUMes4998MEuT4mI5bmy6M0XrSfdw4CKCJkbzcHf9C2EGMpDLmBeiZLs6sFIE1
         wH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x6pg4/s2+sEQTUvLHibRi2LVBl8g5s3Awm8Kd9svFoA=;
        b=mhoI6UdRk54X+rts/DMmJiTlug55677itay0OIjjRA5fPT96usEuh5DD4EX4/Ze8Dv
         j0vW5MaIobCysf3F7b+EANvCSv6zMnA51s9H8J/nQaCI/tV/nrLIKN/wIuS1IsLIFBx9
         olVOIwz73JZrhJsVATtI/RglXhqyfYZUrIl1arubNmMHbSXQL1lguoe3UN07VfxjuOSy
         52c28itRXm8nn1BwuAlVwq/v7SzlAvVVQGQ6KPAYaEn+O5ily+6bpx+IElcoOMerGAv0
         Ye5NdzionR6PaLZtKu4mK6pFcWvmOzgXhG64T5FhHO7oD2HrVjXfKy9dRf/4UbPamI0V
         1wJg==
X-Gm-Message-State: AGRZ1gJlSnCXB06V4/J0GWhWH+3/FqQ4KWyJ74sLjTmMWyV2wRHsTE55
        f8k8NzUlKQvY5WbyK9JBjGCU1A==
X-Google-Smtp-Source: AJdET5fDbpXprn+Uyc+cdSAYhbC/zGh1sq8NbMxJtodUyRIYSCO+xnOAAinptRNIte0xlzV8DrII6Q==
X-Received: by 2002:a25:be4f:: with SMTP id d15-v6mr367284ybm.156.1540491230955;
        Thu, 25 Oct 2018 11:13:50 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id v34-v6sm4493919ywh.45.2018.10.25.11.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:13:50 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:13:49 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/panel: simple: Innolux TV123WAM is actually
 P120ZDG-BF1
Message-ID: <20181025181349.GM154160@art_vandelay>
References: <20181022204639.8558-1-dianders@chromium.org>
 <20181022204639.8558-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022204639.8558-5-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:46:38PM -0700, Douglas Anderson wrote:
> As far as I can tell the panel that was added in commit da50bd4258db
> ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> wasn't actually an Innolux TV123WAM but was actually an Innolux
> P120ZDG-BF1.
> 
> As far as I can tell the Innolux TV123WAM isn't a real panel and but
> it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> Let's unmosh.
> 
> Here's my evidence:
> 
> * Searching for TV123WAM on the Internet turns up a TI panel.  While
>   it's possible that an Innolux panel has the same model number as the
>   TI Panel, it seems a little doubtful.  Looking up the datasheet from
>   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
> 
> * As far as I know, the patch adding the Innolux Panel was supposed to
>   be for the board that's sitting in front of me as I type this
>   (support for that board is not yet upstream).  On the back of that
>   panel I see Innolux P120ZDZ-EZ1 rev B1.
> 
> * Someone pointed me at a datasheet that's supposed to be for the
>   panel in front of me (sorry, I can't share the datasheet).  That
>   datasheet has the string "p120zdg-bf1"
> 
> * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
>   that are 2160x1440.  They don't have datasheets, but the fact that
>   the resolution matches is a good sign.
> 
> In any case, let's update the name and also the physical size to match
> the correct panel.
> 
> Fixes: da50bd4258db ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Sandeep Panda <spanda@codeaurora.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 937e97490c30..7ee1abc5d81b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1370,7 +1370,7 @@ static const struct panel_desc innolux_n156bge_l21 = {
>  	},
>  };
>  
> -static const struct drm_display_mode innolux_tv123wam_mode = {
> +static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
>  	.clock = 206016,
>  	.hdisplay = 2160,
>  	.hsync_start = 2160 + 48,
> @@ -1384,13 +1384,13 @@ static const struct drm_display_mode innolux_tv123wam_mode = {
>  	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
>  };
>  
> -static const struct panel_desc innolux_tv123wam = {
> -	.modes = &innolux_tv123wam_mode,
> +static const struct panel_desc innolux_p120zdg_bf1 = {
> +	.modes = &innolux_p120zdg_bf1_mode,
>  	.num_modes = 1,
>  	.bpc = 8,
>  	.size = {
> -		.width = 259,
> -		.height = 173,
> +		.width = 254,
> +		.height = 169,
>  	},
>  	.delay = {
>  		.prepare = 200,
> @@ -2454,8 +2454,8 @@ static const struct of_device_id platform_of_match[] = {
>  		.compatible = "innolux,n156bge-l21",
>  		.data = &innolux_n156bge_l21,
>  	}, {
> -		.compatible = "innolux,tv123wam",

I think we should update the struct, but we might want to keep this around.
Given the tv123wam panel is TI, we're likely not going to have a collision on
innolux,...

That said, I'll defer to robh on this one, I'm not sure if changing names is
cool once the bindings have hit mainline.

> -		.data = &innolux_tv123wam,
> +		.compatible = "innolux,p120zdg-bf1",
> +		.data = &innolux_p120zdg_bf1,
>  	}, {
>  		.compatible = "innolux,zj070na-01p",
>  		.data = &innolux_zj070na_01p,
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
