Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C91FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9F32077B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZKOft2rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9F32077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHTNo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:44:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38662 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHTNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:44:25 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD5E1CD;
        Mon, 20 Aug 2018 12:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534760960;
        bh=hSKXUzyCRQOx5ODy0RmLc2YpCZFGPWEizr6UyMuavy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKOft2rsA2MySI3xIlSJZaQ9XCVtvL6i1NNbLjE91WCsZhYVxl2r/u01eHEanEznV
         SrltENlPJgylCGaoNydZNenmkUbsTRJ+kSCXClRarL4W6EG7q795Yz+doPlcYm4PhH
         vgK44V9mQt8EJrM9iM+3D1dxl/+DMfikh78dWkC8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm: rcar-du: Improve non-DPLL clock selection
Date:   Mon, 20 Aug 2018 13:30:15 +0300
Message-ID: <9138336.Hrcea1LzHI@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1532971214-17962-4-git-send-email-jacopo@jmondi.org>
References: <1532971214-17962-1-git-send-email-jacopo@jmondi.org> <1532971214-17962-4-git-send-email-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Monday, 30 July 2018 20:20:14 EEST Jacopo Mondi wrote:
> DU channels not equipped with a DPLL use an internal (aka SoC provided) or
> external clock source combined with an internal divider to generate the
> desired output dot clock frequency.
> 
> The current clock selection procedure does not fully exploit the ability
> of external clock sources to generate the exact dot clock frequency by
> themselves, but relies instead on tuning the internal DU clock divider
> only, resulting in a less precise clock generation process.
> 
> When possible, and desirable, ask the external clock source for the exact
> output dot clock frequency, and test all available clock sources (internally
> generated clock, externally generated clock rounded to the closest possible
> frequency, and not rounded externally generated clock) to better
> approximate the desired output dot clock.

I don't think you need to care about the "not rounded externally generated 
clock" (which incidentally isn't really about rounding, but about requesting a 
specific rate), for two reasons.

The first one is that I don't think using whatever rate is currently 
programmed for the external clock will lead to a better result. There's no 
real reason why the current external rate would be better, other than possibly 
just chance, and I don't think we should rely on chance.

The second reason is that it would lead to a non-deterministic behaviour. The 
system will boot with a default clock rate for the external source, but as 
soon as you set a mode, that rate could change, and will never revert back to 
the default. The second mode you will set will thus depend for its clock 
selection on the modes previously set, generating all kind of bugs difficult 
to reproduce.

> This patch specifically targets platforms (like Salvator-X[S] and ULCBs)
> where the DU's input dotclock.in is generated by the versaclock VC5 clock
> source, which is capable of generating the exact rate the DU needs as pixel
> clock output.
> 
> This patch fixes higher resolution modes wich requires an high pixel clock
> output currently not working on non-HDMI DU channel (as VGA 1920x1080@60Hz).
> 
> Fixes: 1b30dbde8 "drm: rcar-du: Add support for external pixel clock"
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 96 ++++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c index 4d7907c..0dfb28ff 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -207,12 +207,12 @@ static void rcar_du_crtc_set_display_timing(struct
> rcar_du_crtc *rcrtc) {
>  	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
>  	struct rcar_du_device *rcdu = rcrtc->group->dev;
> -	unsigned long mode_clock = mode->clock * 1000;
> +	unsigned long mode_pixelclock = mode->clock * 1000;
>  	u32 dsmr;
>  	u32 escr;
> 
>  	if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
> -		unsigned long target = mode_clock;
> +		unsigned long target = mode_pixelclock;
>  		struct dpll_info dpll = { 0 };
>  		unsigned long extclk;
>  		u32 dpllcr;
> @@ -258,42 +258,92 @@ static void rcar_du_crtc_set_display_timing(struct
> rcar_du_crtc *rcrtc)
> 
>  		escr = ESCR_DCLKSEL_DCLKIN | div;
>  	} else {
> -		unsigned long clk;
> +		struct du_clkin_desc {
> +			unsigned long dist;
> +			unsigned long rate;
> +			struct clk *clk;
> +			u32 escr;
> +		} du_clkins[3];
> +		struct du_clkin_desc *du_clkin = du_clkins;
> +		struct du_clkin_desc *clkin_best;
> +		unsigned long best = -1UL;
> +		unsigned long pixelclock;
> +		unsigned long cpgrate;
>  		u32 div;
> 
>  		/*
>  		 * Compute the clock divisor and select the internal or external
>  		 * dot clock based on the requested frequency.
>  		 */
> -		clk = clk_get_rate(rcrtc->clock);
> -		div = DIV_ROUND_CLOSEST(clk, mode_clock);
> -		div = clamp(div, 1U, 64U) - 1;
> +		cpgrate = clk_get_rate(rcrtc->clock);
> +		div = clamp(DIV_ROUND_CLOSEST(cpgrate, mode_pixelclock),
> +			    1UL, 64UL) - 1;
> +		pixelclock = cpgrate / (div + 1);
> 
> -		escr = ESCR_DCLKSEL_CLKS | div;
> +		du_clkin->dist = abs(pixelclock - mode_pixelclock);
> +		du_clkin->escr = ESCR_DCLKSEL_CLKS | div;
> +		du_clkin->clk = rcrtc->clock;
> +		du_clkin->rate = cpgrate;
> +		clkin_best = du_clkin;
> 
>  		if (rcrtc->extclock) {
> -			unsigned long extclk;
> +			unsigned long roundrate;
>  			unsigned long extrate;
> -			unsigned long rate;
> -			u32 extdiv;
> -
> -			extclk = clk_get_rate(rcrtc->extclock);
> -			extdiv = DIV_ROUND_CLOSEST(extclk, mode_clock);
> -			extdiv = clamp(extdiv, 1U, 64U) - 1;
> 
> -			extrate = extclk / (extdiv + 1);
> -			rate = clk / (div + 1);
> -
> -			if (abs((long)extrate - (long)mode_clock) <
> -			    abs((long)rate - (long)mode_clock))
> -				escr = ESCR_DCLKSEL_DCLKIN | extdiv;
> +			/*
> +			 * If an external clock source is present ask it
> +			 * for the exact dot clock rate, and test all possible
> +			 * combinations (internal, external rounded, external
> +			 * not rounded) to achieve the best possible clock
> +			 * accuracy.
> +			 */
> +			extrate = clk_get_rate(rcrtc->extclock);
> +			roundrate = clk_round_rate(rcrtc->extclock,
> +						   mode_pixelclock);
> +
> +			if (roundrate == mode_pixelclock) {
> +				/* We can't do better than this... */
> +				clk_set_rate(rcrtc->extclock, roundrate);
> +				escr = ESCR_DCLKSEL_DCLKIN;
> +				goto set_escr;
> +			}
> 
> -			dev_dbg(rcrtc->group->dev->dev,
> -				"mode clock %lu extrate %lu rate %lu ESCR 0x%08x\n",
> -				mode_clock, extrate, rate, escr);
> +			/* Test the external clock 'plain' rate. */
> +			du_clkin++;
> +			div = clamp(DIV_ROUND_CLOSEST(extrate, mode_pixelclock),
> +				    1UL, 64UL) - 1;
> +			pixelclock = extrate / (div + 1);
> +			du_clkin->dist = abs(pixelclock - mode_pixelclock);
> +			du_clkin->escr = ESCR_DCLKSEL_DCLKIN | div;
> +			du_clkin->clk = rcrtc->extclock;
> +			du_clkin->rate = extrate;

If we remove this option, there will only be two options to compare, and I 
think it would then be possible to keep the current code structure to simplify 
this patch.

> +			/* Test the external clock 'rounded' rate. */
> +			du_clkin++;
> +			div = clamp(DIV_ROUND_CLOSEST(roundrate, mode_pixelclock),
> +				    1UL, 64UL) - 1;
> +			pixelclock = roundrate / (div + 1);
> +			du_clkin->dist = abs(pixelclock - mode_pixelclock);
> +			du_clkin->escr = ESCR_DCLKSEL_DCLKIN | div;
> +			du_clkin->clk = rcrtc->extclock;
> +			du_clkin->rate = roundrate;
> +
> +			/* Find out the best approximation we got. */
> +			for (; du_clkin >= du_clkins; --du_clkin) {
> +				if (du_clkin->dist < best) {
> +					best = du_clkin->dist;
> +					clkin_best = du_clkin;
> +				}
> +			}
> +			clk_set_rate(clkin_best->clk, clkin_best->rate);
>  		}
> +
> +		escr = clkin_best->escr;
>  	}
> 
> +set_escr:
> +	dev_err(rcrtc->group->dev->dev, "%s: ESCR 0x%08x\n", __func__, escr);
> +
>  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? ESCR2 : ESCR,
>  			    escr);
>  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? OTAR2 : OTAR, 0);

-- 
Regards,

Laurent Pinchart



