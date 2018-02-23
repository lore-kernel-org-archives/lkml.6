Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeBWXbm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 18:31:42 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:42336 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeBWXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 18:31:40 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [v2,03/10] drm/sun4i: Protect the TCON pixel clocks
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
References: <d5224d2e81ecf73dc09f234e580ada52c00eaee3.1519204731.git-series.maxime.ripard@bootlin.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <7ed0fad9-6b3d-aafc-08a6-fb18761897aa@micronovasrl.com>
Date: Sat, 24 Feb 2018 00:31:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d5224d2e81ecf73dc09f234e580ada52c00eaee3.1519204731.git-series.maxime.ripard@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/02/2018 10:20, Maxime Ripard ha scritto:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Both TCON clocks are very sensitive to clock changes, since any change
> might lead to improper timings.
> 
> Make sure our rate is never changed.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Tested on A20-LiNova1-4_3i-ctp with Mali r6p2 installed.
Before Mali changed dotclock, now it doesn't anymore.

> ---
>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index b73acab74867..cbe87cee13d1 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -261,7 +261,7 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
>   					const struct drm_display_mode *mode)
>   {
>   	/* Configure the dot clock */
> -	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
> +	clk_set_rate_exclusive(tcon->dclk, mode->crtc_clock * 1000);
>   
>   	/* Set the resolution */
>   	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> @@ -419,7 +419,7 @@ static void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
>   	WARN_ON(!tcon->quirks->has_channel_1);
>   
>   	/* Configure the dot clock */
> -	clk_set_rate(tcon->sclk1, mode->crtc_clock * 1000);
> +	clk_set_rate_exclusive(tcon->sclk1, mode->crtc_clock * 1000);
>   
>   	/* Adjust clock delay */
>   	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
> 
