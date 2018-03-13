Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeCMIUK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:20:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36642 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752084AbeCMIUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:20:09 -0400
Date: Tue, 13 Mar 2018 09:20:07 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: codekipper@gmail.com
Cc: wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v2 3/6] ASoC: sun4i-i2s: Correct divider calculations
Message-ID: <20180313082007.bwqanceskmm2dq6f@flea>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-4-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aa4nylbkd5u3rkam"
Content-Disposition: inline
In-Reply-To: <20180312155753.9478-4-codekipper@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aa4nylbkd5u3rkam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:57:50PM +0100, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> The clock division circuitry is different on the H3 and later SoCs.
> The division of bclk is now based on pll2.

You're doing too many things here.

> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 76 +++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 52 insertions(+), 24 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 396b11346361..2bd0befa02a8 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -129,10 +129,10 @@
>   * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
> - * @mclk_offset: Value by which mclkdiv needs to be adjusted.
> - * @bclk_offset: Value by which bclkdiv needs to be adjusted.
>   * @fmt_offset: Value by which wss and sr needs to be adjusted.
>   * @field_clkdiv_mclk_en: regmap field to enable mclk output.
> + * @field_clkdiv_mclk: regmap field for mclkdiv.
> + * @field_clkdiv_bclk: regmap field for bclkdiv.
>   * @field_fmt_wss: regmap field to set word select size.
>   * @field_fmt_sr: regmap field to set sample resolution.
>   * @field_fmt_bclk: regmap field to set clk polarity.
> @@ -153,8 +153,6 @@ struct sun4i_i2s_quirks {
>  	bool				has_chsel_offset;
>  	unsigned int			reg_offset_txdata;	/* TX FIFO */
>  	const struct regmap_config	*sun4i_i2s_regmap;
> -	unsigned int			mclk_offset;
> -	unsigned int			bclk_offset;
>  	unsigned int			fmt_offset;
> =20
>  	/* Register fields for i2s */
> @@ -212,7 +210,25 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk=
_div[] =3D {
>  	{ .div =3D 8, .val =3D 3 },
>  	{ .div =3D 12, .val =3D 4 },
>  	{ .div =3D 16, .val =3D 5 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
> +};
> +
> +static const struct sun4i_i2s_clk_div sun8i_i2s_clk_div[] =3D {
> +	{ .div =3D 0, .val =3D 0 },
> +	{ .div =3D 1, .val =3D 1 },
> +	{ .div =3D 2, .val =3D 2 },
> +	{ .div =3D 4, .val =3D 3 },
> +	{ .div =3D 6, .val =3D 4 },
> +	{ .div =3D 8, .val =3D 5 },
> +	{ .div =3D 12, .val =3D 6 },
> +	{ .div =3D 16, .val =3D 7 },
> +	{ .div =3D 24, .val =3D 8 },
> +	{ .div =3D 32, .val =3D 9 },
> +	{ .div =3D 48, .val =3D 10 },
> +	{ .div =3D 64, .val =3D 11 },
> +	{ .div =3D 96, .val =3D 12 },
> +	{ .div =3D 128, .val =3D 13 },
> +	{ .div =3D 176, .val =3D 14 },
> +	{ .div =3D 192, .val =3D 15 },
>  };
> =20
>  static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] =3D {
> @@ -224,21 +240,21 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mcl=
k_div[] =3D {
>  	{ .div =3D 12, .val =3D 5 },
>  	{ .div =3D 16, .val =3D 6 },
>  	{ .div =3D 24, .val =3D 7 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
>  };
> =20
>  static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
>  				  unsigned int oversample_rate,
> -				  unsigned int word_size)
> +				  unsigned int word_size,
> +				  const struct sun4i_i2s_clk_div *bdiv,
> +				  unsigned int size)
>  {
>  	int div =3D oversample_rate / word_size / 2;
>  	int i;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(sun4i_i2s_bclk_div); i++) {
> -		const struct sun4i_i2s_clk_div *bdiv =3D &sun4i_i2s_bclk_div[i];
> -
> +	for (i =3D 0; i < size; i++) {
>  		if (bdiv->div =3D=3D div)
>  			return bdiv->val;
> +		bdiv++;
>  	}
> =20
>  	return -EINVAL;
> @@ -247,16 +263,17 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s =
*i2s,
>  static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
>  				  unsigned int oversample_rate,
>  				  unsigned int module_rate,
> -				  unsigned int sampling_rate)
> +				  unsigned int sampling_rate,
> +				  const struct sun4i_i2s_clk_div *mdiv,
> +				  unsigned int size)
>  {
>  	int div =3D module_rate / sampling_rate / oversample_rate;
>  	int i;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(sun4i_i2s_mclk_div); i++) {
> -		const struct sun4i_i2s_clk_div *mdiv =3D &sun4i_i2s_mclk_div[i];
> -
> +	for (i =3D 0; i < size; i++) {
>  		if (mdiv->div =3D=3D div)
>  			return mdiv->val;
> +		mdiv++;
>  	}
> =20
>  	return -EINVAL;
> @@ -321,24 +338,37 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_da=
i *dai,
>  		return -EINVAL;
>  	}
> =20
> -	bclk_div =3D sun4i_i2s_get_bclk_div(i2s, oversample_rate,
> -					  word_size);
> +	if (i2s->variant->has_fmt_set_lrck_period)
> +		bclk_div =3D sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
> +						  word_size,
> +						  sun8i_i2s_clk_div,
> +						  ARRAY_SIZE(sun8i_i2s_clk_div));

For example, you mention nowhere why here you would need clk_rate /
rate, instead of the previous oversample_rate.

> +	else
> +		bclk_div =3D sun4i_i2s_get_bclk_div(i2s, oversample_rate,
> +						  word_size,
> +						  sun4i_i2s_bclk_div,
> +						  ARRAY_SIZE(sun4i_i2s_bclk_div));


>  	if (bclk_div < 0) {
>  		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
>  		return -EINVAL;
>  	}
> =20
> -	mclk_div =3D sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> -					  clk_rate, rate);
> +
> +	if (i2s->variant->has_fmt_set_lrck_period)
> +		mclk_div =3D sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> +						  clk_rate, rate,
> +						  sun8i_i2s_clk_div,
> +						  ARRAY_SIZE(sun8i_i2s_clk_div));
> +	else
> +		mclk_div =3D sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> +						  clk_rate, rate,
> +						  sun4i_i2s_mclk_div,
> +						  ARRAY_SIZE(sun4i_i2s_mclk_div));

While here it's ok to use oversample_rate.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--aa4nylbkd5u3rkam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqnibYACgkQ0rTAlCFN
r3TjPBAAl6qJVkUL6MdxIYHcZjFLCX+784AZKcD/s5jtYdRcT4ZcptIlxBmrEBnd
M56A9UyDhQhjaxoatOCbcTAwrll6LtZ84C70gHu6Gw3/QjJedVJd8LVLOm89qyzX
0jZm3lwy2JWZdGcuuiIFgLEONeNnpValukt4CiTxPL5dQmfls+1Hbatm/k+D74jM
+FAz0PwENzeoqpB/6BT/2n8neHr98znEQxcGJPyOwPNJPQxanfk2WGHJoLYpXSqe
4tcLgkOi+yx3fkVbTM0cwm8769q7+cYVR9Mr2qtfJUo60keO0mrkAU5dxf/V2k4A
58Uwlkw4Pr71Wze9+A4u8q4EzCf8rvSYP9JddA64FsrSLO9aHExewcBV85fmBFcI
7uEY1qpGLau125pckwPqduryShqIWbCF66X8N8u+zWkfCHKY0AKCyuVxaS1Cs2d1
jZ9Uuu+j/FmIk8CfV6AnTLU3XvBovYnSZlyz4K881fON3KElyk3cDhCaC6Md3oPq
FKHOvGyzZBMzxF3ppb3xbQz4xZWdTxwjL89RQLDa4V/hdlPHDIszu02ppgLD1VFy
Ntdn4/ga8OCifWn46aLVYB4hcxZvCVl1T4s1pCYk5MiaUXEVB9GDrBDfGYLH66fB
oKrQnTOJszSMPXcBA5EgkOwfWSY7p6aBoXgDTgv/D8akNHKHY1w=
=A+wp
-----END PGP SIGNATURE-----

--aa4nylbkd5u3rkam--
