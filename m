Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D568FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37E220833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37E220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeINTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:11:50 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43535 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeINTLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:11:49 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A62C4E0013;
        Fri, 14 Sep 2018 13:57:08 +0000 (UTC)
Date:   Fri, 14 Sep 2018 15:56:56 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH 1/3] drm: rcar-du: Rework clock configuration based on
 hardware limits
Message-ID: <20180914135656.GA16851@w540>
References: <1532971214-17962-1-git-send-email-jacopo@jmondi.org>
 <1532971214-17962-2-git-send-email-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1532971214-17962-2-git-send-email-jacopo@jmondi.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Mon, Jul 30, 2018 at 07:20:12PM +0200, Jacopo Mondi wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> The DU channels that have a display PLL (DPLL) can only use external
> clock sources, and don't have an internal clock divider (with the
> exception of H3 ES1.x where the post-divider is present and needs to be
> used as a workaround for a DPLL silicon issue).
>
> Rework the clock configuration to take this into account, avoiding
> selection of non-existing clock sources or usage of a missing
> post-divider.
>

I have based my work on non-DPLL channel selection on this patch, but
always forgot to add my:
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
   j

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 122 ++++++++++++++++++---------------
>  1 file changed, 67 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> index b52b3e8..6d55cec 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -208,78 +208,90 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
>  	struct rcar_du_device *rcdu = rcrtc->group->dev;
>  	unsigned long mode_clock = mode->clock * 1000;
> -	unsigned long clk;
>  	u32 value;
>  	u32 escr;
> -	u32 div;
>
> -	/*
> -	 * Compute the clock divisor and select the internal or external dot
> -	 * clock based on the requested frequency.
> -	 */
> -	clk = clk_get_rate(rcrtc->clock);
> -	div = DIV_ROUND_CLOSEST(clk, mode_clock);
> -	div = clamp(div, 1U, 64U) - 1;
> -	escr = div | ESCR_DCLKSEL_CLKS;
> -
> -	if (rcrtc->extclock) {
> +	if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
> +		unsigned long target = mode_clock;
>  		struct dpll_info dpll = { 0 };
>  		unsigned long extclk;
> -		unsigned long extrate;
> -		unsigned long rate;
> -		u32 extdiv;
> +		u32 dpllcr;
> +		u32 div = 0;
>
> -		extclk = clk_get_rate(rcrtc->extclock);
> -		if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
> -			unsigned long target = mode_clock;
> +		/*
> +		 * DU channels that have a display PLL can't use the internal
> +		 * system clock, and have no internal clock divider.
> +		 */
>
> -			/*
> -			 * The H3 ES1.x exhibits dot clock duty cycle stability
> -			 * issues. We can work around them by configuring the
> -			 * DPLL to twice the desired frequency, coupled with a
> -			 * /2 post-divider. This isn't needed on other SoCs and
> -			 * breaks HDMI output on M3-W for a currently unknown
> -			 * reason, so restrict the workaround to H3 ES1.x.
> -			 */
> -			if (soc_device_match(rcar_du_r8a7795_es1))
> -				target *= 2;
> +		if (WARN_ON(!rcrtc->extclock))
> +			return;
>
> -			rcar_du_dpll_divider(rcrtc, &dpll, extclk, target);
> -			extclk = dpll.output;
> +		/*
> +		 * The H3 ES1.x exhibits dot clock duty cycle stability issues.
> +		 * We can work around them by configuring the DPLL to twice the
> +		 * desired frequency, coupled with a /2 post-divider. Restrict
> +		 * the workaround to H3 ES1.x as ES2.0 and all other SoCs have
> +		 * no post-divider when a display PLL is present (as shown by
> +		 * the workaround breaking HDMI output on M3-W during testing).
> +		 */
> +		if (soc_device_match(rcar_du_r8a7795_es1)) {
> +			target *= 2;
> +			div = 1;
>  		}
>
> -		extdiv = DIV_ROUND_CLOSEST(extclk, mode_clock);
> -		extdiv = clamp(extdiv, 1U, 64U) - 1;
> +		extclk = clk_get_rate(rcrtc->extclock);
> +		rcar_du_dpll_divider(rcrtc, &dpll, extclk, target);
>
> -		rate = clk / (div + 1);
> -		extrate = extclk / (extdiv + 1);
> +		dpllcr = DPLLCR_CODE | DPLLCR_CLKE
> +		       | DPLLCR_FDPLL(dpll.fdpll)
> +		       | DPLLCR_N(dpll.n) | DPLLCR_M(dpll.m)
> +		       | DPLLCR_STBY;
>
> -		if (abs((long)extrate - (long)mode_clock) <
> -		    abs((long)rate - (long)mode_clock)) {
> +		if (rcrtc->index == 1)
> +			dpllcr |= DPLLCR_PLCS1
> +			       |  DPLLCR_INCS_DOTCLKIN1;
> +		else
> +			dpllcr |= DPLLCR_PLCS0
> +			       |  DPLLCR_INCS_DOTCLKIN0;
>
> -			if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
> -				u32 dpllcr = DPLLCR_CODE | DPLLCR_CLKE
> -					   | DPLLCR_FDPLL(dpll.fdpll)
> -					   | DPLLCR_N(dpll.n) | DPLLCR_M(dpll.m)
> -					   | DPLLCR_STBY;
> +		rcar_du_group_write(rcrtc->group, DPLLCR, dpllcr);
>
> -				if (rcrtc->index == 1)
> -					dpllcr |= DPLLCR_PLCS1
> -					       |  DPLLCR_INCS_DOTCLKIN1;
> -				else
> -					dpllcr |= DPLLCR_PLCS0
> -					       |  DPLLCR_INCS_DOTCLKIN0;
> +		escr = ESCR_DCLKSEL_DCLKIN | div;
> +	} else {
> +		unsigned long clk;
> +		u32 div;
>
> -				rcar_du_group_write(rcrtc->group, DPLLCR,
> -						    dpllcr);
> -			}
> +		/*
> +		 * Compute the clock divisor and select the internal or external
> +		 * dot clock based on the requested frequency.
> +		 */
> +		clk = clk_get_rate(rcrtc->clock);
> +		div = DIV_ROUND_CLOSEST(clk, mode_clock);
> +		div = clamp(div, 1U, 64U) - 1;
>
> -			escr = ESCR_DCLKSEL_DCLKIN | extdiv;
> -		}
> +		escr = ESCR_DCLKSEL_CLKS | div;
>
> -		dev_dbg(rcrtc->group->dev->dev,
> -			"mode clock %lu extrate %lu rate %lu ESCR 0x%08x\n",
> -			mode_clock, extrate, rate, escr);
> +		if (rcrtc->extclock) {
> +			unsigned long extclk;
> +			unsigned long extrate;
> +			unsigned long rate;
> +			u32 extdiv;
> +
> +			extclk = clk_get_rate(rcrtc->extclock);
> +			extdiv = DIV_ROUND_CLOSEST(extclk, mode_clock);
> +			extdiv = clamp(extdiv, 1U, 64U) - 1;
> +
> +			extrate = extclk / (extdiv + 1);
> +			rate = clk / (div + 1);
> +
> +			if (abs((long)extrate - (long)mode_clock) <
> +			    abs((long)rate - (long)mode_clock))
> +				escr = ESCR_DCLKSEL_DCLKIN | extdiv;
> +
> +			dev_dbg(rcrtc->group->dev->dev,
> +				"mode clock %lu extrate %lu rate %lu ESCR 0x%08x\n",
> +				mode_clock, extrate, rate, escr);
> +		}
>  	}
>
>  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? ESCR2 : ESCR,
> --
> 2.7.4
>

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbm74oAAoJEHI0Bo8WoVY8AtMP/j9fNx3Qojpi5p7MYoAGc9oO
npHdPWeJTXytR0RZZgA5jX/3F8hNNQJnrGnYXjEumDXXROETElWWpKcvN+OpFFpE
fq9LlCyWL/rLtvlLH4/a2kKqmyQveKJTS+zrCmV0MEtCdBEaLkJqdtLheqYmj2C7
pxDqOAVRO2UopEU17/zhjARMFCqr/75zFIj7VK342l+2I7FRrVecxIj0tB04koVH
lgy1sM8VfAeO1xoKG7ztfMK+IpkeVFZKl0Yd3e5lvnVPt9UDLHIurizVUAnj6o6Z
8LKVxEPPV82W0m+MgFyajKwrG+mGS0iT7ad6cIPetIKhEeudAbG6dMuiUR45HEh+
mGpEFooyIKEpluXZdQgMQr4xzIlB6UNIs/8N1AuJ1MrqrIVH6nRUM8kNAugVF55v
YGcN/GKXr1nu7RlIO7QoLSORHVbs0A+8TIE926MEJo38O95mzkb5GkjKp7ehpDIB
7Bsvar9o0E1axNaZiUpb0hmTRk2Q767OXtOxlSw6ySLTp1Za3Nwx1GsF44BobySa
a1ELlUI3gYYiHB2EPJFs2BEE/QyfYU6YtPag2DW6OAPizpukl6AmLAqj3/EzdV/d
kI/iTJX6K5SoLO/DAwpzlr08Esey9foR9blMs9Cpzy1PgQns7Kn9MMHgR7wAehqZ
ZertYauJ3BAf2NXy/b1C
=rDoR
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
