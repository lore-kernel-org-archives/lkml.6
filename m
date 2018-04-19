Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDSNe1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:34:27 -0400
Received: from vps.xff.cz ([195.181.215.36]:60314 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753557AbeDSNeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:34:24 -0400
Date: Thu, 19 Apr 2018 15:34:21 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <doudahwezomiechahtah@xff.cz>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2] drm/sun4i: add lvds mode_valid function
Message-ID: <20180419133421.6fx3whge7h364vd3@core>
Mail-Followup-To: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
References: <1520940019-68977-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520940019-68977-1-git-send-email-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Giulio,

this patch breaks LVDS output on A83T. Without it, modesetting works,
with it there's no output.

Some more info below...

On Tue, Mar 13, 2018 at 12:20:19PM +0100, Giulio Benetti wrote:
> mode_valid function is missing for lvds.
> 
> Add it making it pointed by encoder helper functions.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_lvds.c | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> index be3f14d..bffff4c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> @@ -94,9 +94,64 @@ static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
>  	}
>  }
>  
> +static enum drm_mode_status sun4i_lvds_encoder_mode_valid(struct drm_encoder *crtc,
> +							  const struct drm_display_mode *mode)
> +{
> +	struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(crtc);
> +	struct sun4i_tcon *tcon = lvds->tcon;
> +	u32 hsync = mode->hsync_end - mode->hsync_start;
> +	u32 vsync = mode->vsync_end - mode->vsync_start;
> +	unsigned long rate = mode->clock * 1000;
> +	long rounded_rate;
> +
> +	DRM_DEBUG_DRIVER("Validating modes...\n");
> +
> +	if (hsync < 1)
> +		return MODE_HSYNC_NARROW;
> +
> +	if (hsync > 0x3ff)
> +		return MODE_HSYNC_WIDE;
> +
> +	if ((mode->hdisplay < 1) || (mode->htotal < 1))
> +		return MODE_H_ILLEGAL;
> +
> +	if ((mode->hdisplay > 0x7ff) || (mode->htotal > 0xfff))
> +		return MODE_BAD_HVALUE;
> +
> +	DRM_DEBUG_DRIVER("Horizontal parameters OK\n");
> +
> +	if (vsync < 1)
> +		return MODE_VSYNC_NARROW;
> +
> +	if (vsync > 0x3ff)
> +		return MODE_VSYNC_WIDE;
> +
> +	if ((mode->vdisplay < 1) || (mode->vtotal < 1))
> +		return MODE_V_ILLEGAL;
> +
> +	if ((mode->vdisplay > 0x7ff) || (mode->vtotal > 0xfff))
> +		return MODE_BAD_VVALUE;
> +
> +	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
> +
> +	tcon->dclk_min_div = 7;
> +	tcon->dclk_max_div = 7;

Why would validation function change any state anywhere?

> +	rounded_rate = clk_round_rate(tcon->dclk, rate);

The issue is here, on A83T TBS A711 tablet, I get...

sun4i-tcon 1c0c000.lcd-controller: XXX: hsync=20 hdisplay=1024 htotal=1384
  vsync=5 vdisplay=600 vtotal=640 rate=52000000 rounded_rate=51857142

> +	if (rounded_rate < rate)
> +		return MODE_CLOCK_LOW;
> +
> +	if (rounded_rate > rate)
> +		return MODE_CLOCK_HIGH;

... while the previous conditions require an exact match for some reason.

But HW works fine without an exact rate match. Why is exact match required here?

thank you,
  Ondrej

> +	DRM_DEBUG_DRIVER("Clock rate OK\n");
> +
> +	return MODE_OK;
> +}
> +
>  static const struct drm_encoder_helper_funcs sun4i_lvds_enc_helper_funcs = {
>  	.disable	= sun4i_lvds_encoder_disable,
>  	.enable		= sun4i_lvds_encoder_enable,
> +	.mode_valid	= sun4i_lvds_encoder_mode_valid,
>  };
>  
>  static const struct drm_encoder_funcs sun4i_lvds_enc_funcs = {
