Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD317C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A80221580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ZbhhdYJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A80221580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeI0OyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:54:15 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43672 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeI0OyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:54:15 -0400
Received: by mail-yb1-f195.google.com with SMTP id w80-v6so744664ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r89dv2VaQ2xq+l8NJxHRLaj/Bx4zYbhSMmsQ/J+//SU=;
        b=ZbhhdYJqveTaRGja3MEUatrp2CgaItbidI6I+Mm8UdIEibtfqCs/d1yzKFFhb2PXEM
         Swr60zIISCQnce/naCaOX5FaXf5ASHiNB5n7w/lBgej6nylwD4Sz5HXc9phluyoBH21M
         iaq7KCmVZEzWHsMPfU4ZZJV643wqBB/LaaPuooM/SkMxPfnD0bKzf7NBNQNsd0gGVGCd
         CaHGCBFqjzbSr6o585v4+hhDGJakCdznKa0QmBA8lG8oK4eHCloljkYPfz8ClPmQChFF
         dGdjMWvGM8BS5Fe9qqQYUlMVxlVkahHUWPDAyQl9Aiq59RRd9KucmPu3x5QqJcH4k4e+
         qJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r89dv2VaQ2xq+l8NJxHRLaj/Bx4zYbhSMmsQ/J+//SU=;
        b=ddhzj5K5Z9rMkH3KDx/ojR95IIx7ZyCnpa7H2EBXvhUECXCvKLxS2rLj9mTvAUdbxq
         E4BC0B7CLUM3dpsf5VTNIRMuPHlYU55QxKFkUeQhkM9VnGwvgk+rg+Nhk9C8q7zszSye
         YgXkAPXgiuyhJ+ttXaaSWUyY3IO1TY0GUA00JZdUtZf7v8DwXr5/zFH17UpHcdIPGKyK
         G+kMioz8T1cAVQEOb3wiq+eoj3w/D7ExrjKr5H9lWOObZ2rslHL+eQEEjGZyQsidjllL
         e55O29jRQdGGIGPuG55E5juca4T05j/4KGDKPgtZ6bLtt4abWFdU71zw9Xa7qdx/PguF
         JuLw==
X-Gm-Message-State: ABuFfoicUttwqAGR3jwcLQITO20+vXFKwB0+teTUX06tum71F5cmdmMK
        paSnALH20YRC5BC1B7xd36feKQ==
X-Google-Smtp-Source: ACcGV61XuvmtqeBihQjCJWGXovHjNeEWwRTOdoAe7t8Zxo6494Hl4tev/xg1Bal4E9uQ3Y/NucJ/lQ==
X-Received: by 2002:a25:6892:: with SMTP id d140-v6mr4984455ybc.308.1538037428971;
        Thu, 27 Sep 2018 01:37:08 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id l145-v6sm537473ywe.105.2018.09.27.01.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 01:37:08 -0700 (PDT)
Date:   Thu, 27 Sep 2018 04:37:08 -0400
From:   Sean Paul <sean@poorly.run>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/sun4i: Remove R40 display pipeline
 compatibles"
Message-ID: <20180927083707.GT72545@art_vandelay>
References: <20180921142743.8711-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921142743.8711-1-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:27:43PM +0800, Chen-Yu Tsai wrote:
> This reverts commit 3510e7a7f91088159bfc67e8abdc9f9e77d28870.
> 
> During the 4.19 merge window for drm-misc, two patches critical to
> supporting the display pipeline on the Allwinner R40 SoC were missed.
> They were applied later but missed the merge window deadline. As a
> result 4.19-rc1 kernel would crash on the R40 when it couldn't parse
> the new device tree structure. We ended up removing support for the
> R40 display pipeline for 4.19.
> 
> Since the missing patches are already merged for 4.20, we can now
> revert the commit that removed support.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> drm-misc-fixes, which contains the patch to be reverted, should be
> merged into drm-misc-next before tihs patch is applied.
> 
> Also, checkpatch.pl is complaining that the R40 mixer compatibles are
> missing from the device tree bindings. It seems the patch adding them
> never made it in. Please apply if possible:
> 
>     https://patchwork.kernel.org/patch/10485815/

Applied both of these to drm-misc-next after backmerging rc5 to pick up the fix.

Sean

> 
> Thanks
> 
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c      |  1 +
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 9027ddde4262..1e41c3f5fd6d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -402,6 +402,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
>  	{ .compatible = "allwinner,sun8i-a33-display-engine" },
>  	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
>  	{ .compatible = "allwinner,sun8i-h3-display-engine" },
> +	{ .compatible = "allwinner,sun8i-r40-display-engine" },
>  	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
>  	{ .compatible = "allwinner,sun9i-a80-display-engine" },
>  	{ .compatible = "allwinner,sun50i-a64-display-engine" },
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 091f6cf40353..8b3d02b146b7 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -545,6 +545,22 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
>  	.vi_num		= 1,
>  };
>  
> +static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
> +	.ccsc		= 0,
> +	.mod_rate	= 297000000,
> +	.scaler_mask	= 0xf,
> +	.ui_num		= 3,
> +	.vi_num		= 1,
> +};
> +
> +static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
> +	.ccsc		= 1,
> +	.mod_rate	= 297000000,
> +	.scaler_mask	= 0x3,
> +	.ui_num		= 1,
> +	.vi_num		= 1,
> +};
> +
>  static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
>  	.vi_num = 2,
>  	.ui_num = 1,
> @@ -582,6 +598,14 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
>  		.compatible = "allwinner,sun8i-h3-de2-mixer-0",
>  		.data = &sun8i_h3_mixer0_cfg,
>  	},
> +	{
> +		.compatible = "allwinner,sun8i-r40-de2-mixer-0",
> +		.data = &sun8i_r40_mixer0_cfg,
> +	},
> +	{
> +		.compatible = "allwinner,sun8i-r40-de2-mixer-1",
> +		.data = &sun8i_r40_mixer1_cfg,
> +	},
>  	{
>  		.compatible = "allwinner,sun8i-v3s-de2-mixer",
>  		.data = &sun8i_v3s_mixer_cfg,
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> index 9831a9fe2cf4..3040a79f298f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -252,6 +252,7 @@ static int sun8i_tcon_top_remove(struct platform_device *pdev)
>  
>  /* sun4i_drv uses this list to check if a device node is a TCON TOP */
>  const struct of_device_id sun8i_tcon_top_of_table[] = {
> +	{ .compatible = "allwinner,sun8i-r40-tcon-top" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
> -- 
> 2.19.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
