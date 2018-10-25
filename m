Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4DFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9173B20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ebjoF///"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9173B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJZCmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:42:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37298 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeJZCmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:42:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so11000584qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vEEbeX9NEprbLobi7/ZMT/vaCA2hUGeBMovuRomjiIg=;
        b=ebjoF///WsLO3IeBLxcZg7g0FfZzHZEtaZVMmZ0RHjz0CNGSpbkivhKaMvN41VhysD
         KiONPbdKufshnU+MO+Qm5t0ZycohZGJ36wKmnmfCe3aK+ms2CRlWDkVn29BPNBsn8Fkg
         Vj4QFqgGzEW516hSvjP7bE4dxEdL5WqU1GFw2zXlSAEb7ov9A3E7NuIAur9RhPMajX3U
         Xrueg0BmOhEELS8B6qnm4pqK9KlYeQ9Qm05xEwDaIJhW4idZZxSwfKROTk6PnPBOfPFC
         z42+sSrmWbE2yGOLcMKL4J/QgfVuYZbO7dnsPWUF2twpFmmfUlBPyayxV6H628pz4yK0
         vI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vEEbeX9NEprbLobi7/ZMT/vaCA2hUGeBMovuRomjiIg=;
        b=DgaLnWcdrLLQ6GaX4IPlWWI1NBAXc0VpHqVuSwKrd9MzeTyhtRzZi84dmsgjOReJgx
         F6Up7Cnax+5hJopN+WWtP+0dZ4IvatT3nXMiOo0/ElJCyqxsBLEYUJCmAx5vPLnbWXei
         OPTrZKkf+nSURzm0bLm8D5scrBoT0N4ZORqg0VoMaFVkjf1uYJ4fUXQwym4pB/YPVY5B
         1Nw1hOhCNyX2yXL8b7zS+yuC33+mhe/BuYqnU1c6g2MoiNtQ/kIxTn6WgeXdeHSLZKke
         g0RSVw9Xr3XWeeJgKGbfdzkwaOCa8tU5dj5JiSZECO8fBGxHZEoNQSXagp1AnVLW/e7L
         v+YA==
X-Gm-Message-State: AGRZ1gKe4qDzTP+bXSkm8mAjxXqx9KNmRA3mTZjsiIotBEy4OIZNGrWh
        tnh5O+NLZrETXFKE2KR2+6nphyC6S8gifg==
X-Google-Smtp-Source: AJdET5cCqXPlG6AtbmmK+jOFSp5vhRb5P8YakBWpUaCj8AHZ7TzXpoI5No1DA31xcIycd6guK1XmjA==
X-Received: by 2002:a0c:fa86:: with SMTP id o6mr292511qvn.148.1540490914622;
        Thu, 25 Oct 2018 11:08:34 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id u67-v6sm6131148qkh.12.2018.10.25.11.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:08:34 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:08:33 -0400
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
Subject: Re: [PATCH 2/6] drm/panel: simple: Support panels with HPD where HPD
 isn't connected
Message-ID: <20181025180833.GK154160@art_vandelay>
References: <20181022204639.8558-1-dianders@chromium.org>
 <20181022204639.8558-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022204639.8558-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:46:35PM -0700, Douglas Anderson wrote:
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
> ---
> 
>  drivers/gpu/drm/panel/panel-simple.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 97964f7f2ace..38c646fb55fd 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -63,12 +63,15 @@ struct panel_desc {
>  	 *           turn the display off (no content is visible)
>  	 * @unprepare: the time (in milliseconds) that it takes for the panel
>  	 *             to power itself down completely
> +	 * @prepare_delay_only_if_no_hpd: The prepare delay should only be done
> +	 *                                if we know Hot Plug Detect isn't used.

I think it'd be more clear if we just had a new 'hpd_absent_delay' which is
added to prepare if no_hpd is true.

Sean

>  	 */
>  	struct {
>  		unsigned int prepare;
>  		unsigned int enable;
>  		unsigned int disable;
>  		unsigned int unprepare;
> +		bool prepare_delay_only_if_no_hpd;
>  	} delay;
>  
>  	u32 bus_format;
> @@ -79,6 +82,7 @@ struct panel_simple {
>  	struct drm_panel base;
>  	bool prepared;
>  	bool enabled;
> +	bool no_hpd;
>  
>  	const struct panel_desc *desc;
>  
> @@ -215,7 +219,8 @@ static int panel_simple_prepare(struct drm_panel *panel)
>  
>  	gpiod_set_value_cansleep(p->enable_gpio, 1);
>  
> -	if (p->desc->delay.prepare)
> +	if (p->desc->delay.prepare &&
> +	    (!p->desc->delay.prepare_delay_only_if_no_hpd || p->no_hpd))
>  		msleep(p->desc->delay.prepare);
>  
>  	p->prepared = true;
> @@ -305,6 +310,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
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
