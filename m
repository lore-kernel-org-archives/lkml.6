Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE8C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7C52081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="JdUJHtxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7C52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbeKEDND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:13:03 -0500
Received: from plaes.org ([188.166.43.21]:39106 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbeKEDND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:13:03 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id 2535840630;
        Sun,  4 Nov 2018 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1541354234; bh=57VWZroUirfWO17qSDi9H0Und6LxnnnCLm8RSsDLGjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdUJHtxvgwvWkMvyjF5rUAXJIISA7PhDHMJ7VmwTjrXNR6r1m9ZPcnfe8rVzrMKEw
         3uQzCqkhC0Q1ZKCk9XTlLjni74BLYfRffRodFhlokL4fAJt5glAO6nOH1gvEwIQ1pM
         Tnvt82JNkWHNe0hYZcRfxsyhGSnkEzc+B2HpUUuDl587kxvnj4nsYdCZNQs61l9UXI
         tUu+DXX5twuZ7olDRVF+fSrSJTzyPTVmo9+9s+nxkOpA3qj4OaRNCPbiyL+ABthhJv
         C/79g/8vmUYOsNBrGUaPnidAi4kE/wYqx8Gf4pDNAh5Dw2YkaJGhz7iehaT4Tk/iWj
         tqhhLJzWkn1YA==
Date:   Sun, 4 Nov 2018 17:57:13 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 01/10] drm/sun4i: sun6i_mipi_dsi: Compute
 burst mode loop N1 instruction delay
Message-ID: <20181104175713.cpiygzkq2tw2ygwk@plaes.org>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103100900.30313-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 03:38:51PM +0530, Jagan Teki wrote:
> Loop N1 instruction delay for burst mode lcd panel are
> computed as per BSP code.
> 
> Reference code is available in BSP
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> => (((mode->htotal - mode->hdisplay) * 150) / ((mode->clock / 1000) * 8)) - 50;
> 
> So use the similar computation for loop N1 delay.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 86430efd9054..da152c21ec62 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -394,7 +394,14 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>  static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
>  				      struct drm_display_mode *mode)
>  {
> -	u16 delay = 50 - 1;
> +	struct mipi_dsi_device *device = dsi->device;
> +	u16 delay;
> +
> +	if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST)

This looks fishy, as mode_flags is supposedly bitfield.

I guess you actually want mode_flags & MIPI_DSI_MODE_VIDEO_BURST. Other
patches are also affected by this.


> +		delay = (((mode->htotal - mode->hdisplay) * 150) /
> +			((mode->clock / 1000) * 8)) - 50;
> +	else
> +		delay = 50 - 1;
>  
>  	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
>  		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
> -- 
> 2.18.0.321.gffc6fa0e3
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
