Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C028ECDE47
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB4720882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB4720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeKEUEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:04:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33573 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKEUEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:04:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C3488207B0; Mon,  5 Nov 2018 11:45:02 +0100 (CET)
Received: from localhost (unknown [185.94.189.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 49585208DC;
        Mon,  5 Nov 2018 11:44:36 +0100 (CET)
Date:   Mon, 5 Nov 2018 11:44:36 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: Re: [PATCH 04/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
Message-ID: <20181105104436.mt7r2ln2lay5sfl5@flea>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lojmyyjyfhxs6yu5"
Content-Disposition: inline
In-Reply-To: <20181103100900.30313-5-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lojmyyjyfhxs6yu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 03, 2018 at 03:38:54PM +0530, Jagan Teki wrote:
> Setting up burst mode display would require to compute
> - Horizontal timing edge values to fill burst drq register
> - Line, sync values to fill burst line register
>=20
> Since there is no direct documentation for these computations
> the edge and line formulas are taken from BSP code
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> line_num =3D panel->lcd_ht*dsi_pixel_bits[panel->lcd_dsi_format]/
> 	  (8*panel->lcd_dsi_lane);
> edge1 =3D sync_point+(panel->lcd_x+panel->lcd_hbp+20)*
> 	dsi_pixel_bits[panel->lcd_dsi_format] /(8*panel->lcd_dsi_lane);
> edge1 =3D (edge1>line_num)?line_num:edge1;
> edge0 =3D edge1+(panel->lcd_x+40)*tcon_div/8;
> edge0 =3D (edge0>line_num)?(edge0-line_num):1;
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 48 +++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 4965b2c71e4c..b6c01891df36 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -375,20 +375,52 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi =
*dsi,
>  				  struct drm_display_mode *mode)
>  {
>  	struct mipi_dsi_device *device =3D dsi->device;
> +	unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->format);
> +	u32 line_num, edge0, edge1, hact_sync_bp;
> +	u32 sync_point, tcon_div;
>  	u32 val =3D 0;
> =20
> -	if ((mode->hsync_start - mode->hdisplay) > 20) {
> -		/* Maaaaaagic */
> -		u16 drq =3D (mode->hsync_start - mode->hdisplay) - 20;
> +	if (device->mode_flags !=3D MIPI_DSI_MODE_VIDEO_BURST) {
> +		if ((mode->hsync_start - mode->hdisplay) > 20) {
> +			/* Maaaaaagic */
> +			u16 drq =3D (mode->hsync_start - mode->hdisplay) - 20;
> =20
> -		drq *=3D mipi_dsi_pixel_format_to_bpp(device->format);
> -		drq /=3D 32;
> +			drq *=3D Bpp;
> +			drq /=3D 32;
> =20
> -		val =3D (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> -		       SUN6I_DSI_TCON_DRQ_SET(drq));
> +			val =3D (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> +			       SUN6I_DSI_TCON_DRQ_SET(drq));
> +		}
> +
> +		regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
> +
> +		return;
>  	}

Having functions to compute drq, the line_number and so on would help
the readibility a lot.

> -	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
> +	sync_point =3D 40;
> +	tcon_div =3D 8;	/* FIXME need to retrive the divider from TCON */

Then do it. Especially since you have exactly 0 guarantee of the
divider being 8.

(also, s/retrive/retrieve/)

> +
> +	line_num =3D mode->htotal * Bpp / (8 * device->lanes);
> +	/* Horizental timings duration excluding front porch */

Horizontal

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lojmyyjyfhxs6yu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AfFAAKCRDj7w1vZxhR
xSyYAQDhsuhDv90BqYdcm8sWRykRSClHY4Pn3NZuAd95qwM7AgEAkWBhm0e80GzZ
Q7UBCEBhHsjbPP842JgOu2Z3+/H8/Ao=
=ZGoQ
-----END PGP SIGNATURE-----

--lojmyyjyfhxs6yu5--
