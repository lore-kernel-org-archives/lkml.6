Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967041AbeCAJjZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:39:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34974 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966675AbeCAJjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:39:22 -0500
Date: Thu, 1 Mar 2018 10:39:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
Message-ID: <20180301093909.ph6nuvxuqtwyfssd@flea>
References: <1519834492-30559-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rvhq4e4gay73qp4b"
Content-Disposition: inline
In-Reply-To: <1519834492-30559-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rvhq4e4gay73qp4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 05:14:52PM +0100, Giulio Benetti wrote:
> Handle both positive and negative dclk polarity,
> according to bus_flags.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index aaf911a..534e5ee 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> =20
>  #include <uapi/drm/drm_mode.h>
> =20
> @@ -340,6 +341,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tc=
on *tcon,
>  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>  				     const struct drm_display_mode *mode)
>  {
> +	struct drm_panel *panel =3D tcon->panel;
> +	struct drm_connector *connector =3D panel->connector;
> +	struct drm_display_info display_info =3D connector->display_info;
>  	unsigned int bp, hsync, vsync;
>  	u8 clk_delay;
>  	u32 val =3D 0;
> @@ -395,8 +399,15 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tc=
on *tcon,
>  	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>  		val |=3D SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> =20
> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
> +		clk_set_phase(tcon->dclk, 240);
> +
> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
> +		clk_set_phase(tcon->dclk, 0);
> +

This needs to have a whole bunch of comments here. We want to have
basically the whole discussion we had by mail previously about this in
there.

And the same goes for your commit log.

>  	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
> -			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSIT=
IVE,
> +			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
> +			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>  			   val);

This has nothing to do with your patch.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rvhq4e4gay73qp4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXyjwACgkQ0rTAlCFN
r3Qqng/+NJRke8sq+795RZCyYCj8ln3Tzpojn9Rr+dxH5E1EsQAmVLrzxfRoMmws
EI3VY0TM1XApOFqxRekmGMYc8KlFMEBF48WCvRXVzAXcMmMTXfETmQArxM919ETt
TqOgTIodv7HejUqofIUlxv/tABWZ2LGKXjN/vgBVqa2ChIU4dFAxeApXxdCB8Akm
T6Ry3RPJ7g2rPIVyTUQxhh8GF9wSYYDZBJpDa28DIMrms6fulnanRpMKR0yloHkJ
B3vEr2h66BToztDRkvcc8UkxlRrPQnZU010jnikOQBJr7akTNDAjzzTBIJM//gMN
/0wmLZwwVO9aTh8t7+xrVtEAPCfORYO4zoUqEOwSqLE0EmBbshfWzf0umnr4Um38
5z8u0hlgR2+chgB3WiK/U1CoG8GsulXiCWjeQUs5fyBdcnQVadl98ouHD7ixLa/9
Isxf+V5G6L7YPd9TrN4IidCBM/0WeZzDAax8mO3zRhQ7M9hRbS7EF+8ZYH2kuXFG
Y6S7avtT4cQ7MPHsRdpLrbldvJjPuPUct9qmKnXWdF7OiZBSpgIgzO7Yt8Vi+R2k
vhhsKdk84c2o4ZyotNBQlMiSmC0uos0dXtfjKIVBYnCp9R4mLvqSmBtB6K1Lursv
gdex8GMrmpfrX9de6YyMAHXvwfQJHDEctP+jiI7qUTJWt6M/rsY=
=gcH5
-----END PGP SIGNATURE-----

--rvhq4e4gay73qp4b--
