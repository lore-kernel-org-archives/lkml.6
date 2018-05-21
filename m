Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeEUIIO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:08:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37995 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeEUIIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:08:11 -0400
Date: Mon, 21 May 2018 10:07:59 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Message-ID: <20180521080759.rgviuva65ijcfm2e@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-7-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hpqwgjovcbtgqx7h"
Content-Disposition: inline
In-Reply-To: <20180519183127.2718-7-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hpqwgjovcbtgqx7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2018 at 08:31:18PM +0200, Jernej Skrabec wrote:
> If SoC has TCON TOP unit, it has to be configured from TCON, since it
> has all information needed. Additionally, if it is TCON TV, it must also
> enable bus gate inside TCON TOP unit.

Why?

> Add support for such TCONs.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  8 ++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index 08747fc3ee71..e0c562ce1c22 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>  		dev_err(dev, "Couldn't get the TCON bus clock\n");
>  		return PTR_ERR(tcon->clk);
>  	}
> +
> +	if (tcon->quirks->needs_tcon_top && tcon->quirks->has_channel_1) {
> +		tcon->top_clk =3D devm_clk_get(dev, "tcon-top");
> +		if (IS_ERR(tcon->top_clk)) {
> +			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
> +			return PTR_ERR(tcon->top_clk);
> +		}
> +		clk_prepare_enable(tcon->top_clk);
> +	}
> +
>  	clk_prepare_enable(tcon->clk);
> =20
>  	if (tcon->quirks->has_channel_0) {
> @@ -712,6 +722,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
>  static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
>  {
>  	clk_disable_unprepare(tcon->clk);
> +	clk_disable_unprepare(tcon->top_clk);
>  }
> =20
>  static int sun4i_tcon_init_irq(struct device *dev,
> @@ -980,6 +991,23 @@ static int sun4i_tcon_bind(struct device *dev, struc=
t device *master,
>  	tcon->id =3D engine->id;
>  	tcon->quirks =3D of_device_get_match_data(dev);
> =20
> +	if (tcon->quirks->needs_tcon_top) {
> +		struct device_node *np;
> +
> +		np =3D of_parse_phandle(dev->of_node, "allwinner,tcon-top", 0);
> +		if (np) {
> +			struct platform_device *pdev;
> +
> +			pdev =3D of_find_device_by_node(np);
> +			if (pdev)
> +				tcon->tcon_top =3D platform_get_drvdata(pdev);
> +			of_node_put(np);
> +
> +			if (!tcon->tcon_top)
> +				return -EPROBE_DEFER;
> +		}
> +	}
> +

I might have missed it, but I've not seen the bindings additions for
that property. This shouldn't really be done that way anyway, instead
of using a direct phandle, you should be using the of-graph, with the
TCON-top sitting where it belongs in the flow of data.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hpqwgjovcbtgqx7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsCfl4ACgkQ0rTAlCFN
r3S9AQ/+JPfhJ0iDva/Y/hg0a1JulJ5HlTQ5T5gFfD51q6wf0NGh1WCp6QEPOrea
RgvO5QSwkZn2849ygj+ISHr2PbUmbaDqe2qEJntJFPRUhdwvho3/3oCRq68n+/E1
P/SJvCvribHnQBILNbrBwP9SovDva0icOICJcCAboac4vrRhNhSr4CwNWOGJEtC3
g7Rthf9Lk5axhgFQX2/u1M9Q1ocfD0uTCfednvlVGIjWx2By0HL4wkV3C81iWUoT
NqnTIPVHo3ZwxWViOiFEp0zdvx3eDQ9v79y9aEKnd1A1GNT84izMACjngez0rkVz
l4gY+rVfvka9W1Nw4EGrQhix4smH5p/Vb9y/5lc3fOS5AHTPuBUPLRuPfZZRUKjj
T17XrusCGCYeSgk+nuXqS7AaSHKdHYLiYFlkOGcBsU4fRTrZXeYTFoYmKtE1zkqA
Kj/YpP856mnHSRmNBXZLe1mrbP8SDAvuFXRS4Y+um69ACaZxInq0OEuNKGJZH7BM
S8fwMnnbOr1XrFiDvjkklRf+mmAgo+m8xRO8YCX1qoN1lxEeyRBcatqj2S0HNaIY
pvqIAcEhBedQAycsbRrGjwaq6Ewnsy/8v8PUkS/E9u3uYswQBh56z6wS6L46CLuk
5HQL9CZmo8xMWtMzM5MkCqsiMTGd7diWx/e0yuUFhn4rA5iQkz8=
=WmZF
-----END PGP SIGNATURE-----

--hpqwgjovcbtgqx7h--
