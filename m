Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4723C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6BC20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="KQ/NiBdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6BC20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJZXSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:18:33 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45930 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZXSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:18:33 -0400
Received: by mail-yb1-f193.google.com with SMTP id 131-v6so544152ybe.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4rWocgZUZH13alrf4EYBNLvZ2MHFKWSIWjZQCH2V3n4=;
        b=KQ/NiBdCk9OiBO+oXy5jpCPo9jJK7y7MTMsjJDZscX/qvIjIBm3ZtEnD21WMz5fksw
         7i3Z4MV4kM+BVW5xfSYWjNN3vKGkJpeWVKqz1pbBXscKgnzCJcy37bLQ7soEfdmzziyv
         okDjvui8Z4SrPxGLJDCT+D/mcQyfN76rftx/wM25B9eDX+LZy5ILWhYk/DHpsgk7Xih0
         +L69enI2U4Tc1/1AacAMiVsRFAUO6Fo+UsoluG7TqgJklixAnFuZDAd7QApDjDgGk21+
         VlrXpncf9/Bi3wT2dZ9EeVPPp8QmW80FD5PSdho+qZzc+8tA1CesJTDWBan52ufEBnof
         ehog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4rWocgZUZH13alrf4EYBNLvZ2MHFKWSIWjZQCH2V3n4=;
        b=O6+wzakwlo9FDQt95uK1d5qqYhnE00FPRtSzBAYd3NyEzVleSdVebuo/D4jWokkuzG
         G62Otx0yYyWX3c7xVhnQ3iUV9XC35bsUWGhWk+IhVEgst6d+Iqr1cSfCN9mq1VVvfUnR
         cW3NXWuHue+KYNvUdSeT/WFEatbxIQoD0RFHYdMSfOf19bmZAli33swLwtZJ3ZNM6R34
         ZE2l+ZLP6Y2AM3La3+KetgIpadlX4+Dwo9N9AB1P9Y97wKumA3ZFxoaFJfgBTHWl0XLa
         sufHBdwpQiTX7LCLfdHj6v6zYuPoGf5AMw1LYi7Hk0jb9Gcpuo3Xs9zAuL0pUhtlMwLe
         ASVA==
X-Gm-Message-State: AGRZ1gIfKmVepUs9p39N+D31tay/z1sAMnu/wXSQxtMzyrAllv329Wo6
        cQ5oqTHjATSot7WfNXJsuVb0/g==
X-Google-Smtp-Source: AJdET5fxUVlNqFUDIvaAxYG7qEVSmwe/xH1TZP8jKt2EtzO0m4W8V1CSiYbbaN4tgLPNO+GTPX07sA==
X-Received: by 2002:a25:bb09:: with SMTP id z9-v6mr3639853ybg.87.1540564873335;
        Fri, 26 Oct 2018 07:41:13 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id t81-v6sm3085017ywb.90.2018.10.26.07.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 07:41:12 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:41:11 -0400
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
Subject: Re: [PATCH v2 2/6] drm/panel: simple: Support panels with HPD where
 HPD isn't connected
Message-ID: <20181026144111.GQ154160@art_vandelay>
References: <20181025222134.174583-1-dianders@chromium.org>
 <20181025222134.174583-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025222134.174583-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:21:30PM -0700, Douglas Anderson wrote:
> Some eDP panels that are designed to be always connected to a board
> use their HPD signal to signal that they've finished powering on and
> they're ready to be talked to.
> 
> However, for various reasons it's possible that the HPD signal from
> the panel isn't actually hooked up.  In the case where the HPD isn't
> hooked up you can look at the timing diagram on the panel datasheet
> and insert a delay for the maximum amount of time that the HPD might
> take to come up.
> 
> Let's add support in simple-panel for this concept.
> 
> At the moment we will co-opt the existing "prepare" delay to keep
> track of the delay and we'll use a boolean to specify that a given
> panel should only apply the delay if the "no-hpd" property was
> specified.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
> Changes in v2:
> - Use "hpd_absent_delay" property instead of a bool + prepare delay
> 
>  drivers/gpu/drm/panel/panel-simple.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 97964f7f2ace..687fd087b9fc 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -56,6 +56,8 @@ struct panel_desc {
>  	/**
>  	 * @prepare: the time (in milliseconds) that it takes for the panel to
>  	 *           become ready and start receiving video data
> +	 * @hpd_absent_delay: Add this to the prepare delay if we know Hot
> +	 *                    Plug Detect isn't used.
>  	 * @enable: the time (in milliseconds) that it takes for the panel to
>  	 *          display the first valid frame after starting to receive
>  	 *          video data
> @@ -66,6 +68,7 @@ struct panel_desc {
>  	 */
>  	struct {
>  		unsigned int prepare;
> +		unsigned int hpd_absent_delay;
>  		unsigned int enable;
>  		unsigned int disable;
>  		unsigned int unprepare;
> @@ -79,6 +82,7 @@ struct panel_simple {
>  	struct drm_panel base;
>  	bool prepared;
>  	bool enabled;
> +	bool no_hpd;
>  
>  	const struct panel_desc *desc;
>  
> @@ -202,6 +206,7 @@ static int panel_simple_unprepare(struct drm_panel *panel)
>  static int panel_simple_prepare(struct drm_panel *panel)
>  {
>  	struct panel_simple *p = to_panel_simple(panel);
> +	unsigned int delay;
>  	int err;
>  
>  	if (p->prepared)
> @@ -215,8 +220,11 @@ static int panel_simple_prepare(struct drm_panel *panel)
>  
>  	gpiod_set_value_cansleep(p->enable_gpio, 1);
>  
> -	if (p->desc->delay.prepare)
> -		msleep(p->desc->delay.prepare);
> +	delay = p->desc->delay.prepare;
> +	if (p->no_hpd)
> +		delay += p->desc->delay.hpd_absent_delay;
> +	if (delay)
> +		msleep(delay);
>  
>  	p->prepared = true;
>  
> @@ -305,6 +313,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  	panel->prepared = false;
>  	panel->desc = desc;
>  
> +	panel->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
> +
>  	panel->supply = devm_regulator_get(dev, "power");
>  	if (IS_ERR(panel->supply))
>  		return PTR_ERR(panel->supply);
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
