Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC27AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBFF2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBFF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJJWUV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:20:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55933 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeJJWUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:20:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7D48A207B4; Wed, 10 Oct 2018 16:57:45 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4D4E920618;
        Wed, 10 Oct 2018 16:57:35 +0200 (CEST)
Date:   Wed, 10 Oct 2018 16:57:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH 1/4] drm/sun4i: tcon: Support an active-low DE signal
 with RGB interface
Message-ID: <20181010145736.l6zpohvvd4b5qngr@flea>
References: <20181010114134.8211-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181010114134.8211-1-contact@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:41:31PM +0200, Paul Kocialkowski wrote:
> Some panels need an active-low data enable (DE) signal for the RGB
> interface. This requires flipping a bit in the TCON0 polarity register
> when setting up the mode for the RGB interface.
> 
> Add a new helper function to match specific bus flags and use it to set
> the polarity inversion bit for the DE signal when required.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 3fb084f802e2..d249a462ec09 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -78,6 +78,24 @@ static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
>  	return -EINVAL;
>  }
>  
> +static bool sun4i_tcon_match_bus_flags(const struct drm_encoder *encoder,
> +				       u32 bus_flags)
> +{
> +	struct drm_connector *connector;
> +	struct drm_display_info *info;
> +
> +	connector = sun4i_tcon_get_connector(encoder);
> +	if (!connector)
> +		return false;
> +
> +	info = &connector->display_info;
> +
> +	if ((info->bus_flags & bus_flags) == bus_flags)
> +		return true;
> +
> +	return false;
> +}
> +
>  static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
>  					  bool enabled)
>  {
> @@ -415,6 +433,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>  }
>  
>  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> +				     const struct drm_encoder *encoder,
>  				     const struct drm_display_mode *mode)
>  {
>  	unsigned int bp, hsync, vsync;
> @@ -474,8 +493,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>  		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>  
> +	if (sun4i_tcon_match_bus_flags(encoder, DRM_BUS_FLAG_DE_LOW))
> +		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
> +

There's other flags in use in that function, you should also migrate
them (ideally by splitting that new function into a separate patch).

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
