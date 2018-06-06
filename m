Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJTarXqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41DBC601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932643AbeFFIeb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:34:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39850 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbeFFIe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:34:27 -0400
X-Google-Smtp-Source: ADUXVKJVw3dp3VUBkGGl5You9POwacb/M8QSEgxryhBn3ICJwrNYDNeTLGwI3n7MRyWK4P9PIb7d6w==
Date: Wed, 6 Jun 2018 10:34:23 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: shenwei.wang@nxp.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block
 on i.MX8x
Message-ID: <20180606083423.GE11810@ulmo>
References: <20180524180848.61844-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <20180524180848.61844-1-shenwei.wang@nxp.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 01:08:48PM -0500, shenwei.wang@nxp.com wrote:
> On the new i.MX8x SoC family, the following changes were made on the FTM
> block:
>=20
> 1. Need to enable the IPG clock before accessing any FTM registers. Becau=
se
> the IPG clock is not an option for FTM counter clock source, it can't be
> used as the ftm_sys clock.
>=20
> 2. An additional PWM enable bit was added for each PWM channel in register
> FTM_SC[16:23]. It supports 8 channels. Bit16 is for channel 0, and bit23
> for channel 7.

Generally if you need to itemize changes in your commit message it is a
good indication that you should be splitting up the patch into multiple
logical changes. In this case, one possibility would be to turn this
into three patches:

	1. Introduce the concept on an "interface" clock which is by
	   default the same as the ftm_sys clock.

	2. Add support for enable bits, based on some per-compatible
	   data structure (see for example pwm-tegra.c for an example of
	   how to do this).

	3. Enable support for the new SoC family by adding an instance
	   of the per-compatible structure for that compatible string.

> As the IP version information can not be obtained in any of the FTM
> registers, a property of "fsl,has-pwmen-bits" is added in the ftm pwm
> device node. If it has the property, the driver set the PWM enable bit
> when a PWM channel is requested.

I don't see a corresponding device tree bindings update for this change.
Also, I don't think doing this via a separate property is the right way,
you can just derive this from the new compatible string which you need
to add anyway.

So to the above patches, add:

	0. Add DT bindings for new SoC family with a mention that they
	   need to provide the new IPG clock.

>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> index 557b4ea..0426458f 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -86,7 +86,9 @@ struct fsl_pwm_chip {
>  	struct regmap *regmap;
> =20
>  	int period_ns;
> +	bool has_pwmen;
> =20
> +	struct clk *ipg_clk;
>  	struct clk *clk[FSL_PWM_CLK_MAX];
>  };
> =20
> @@ -97,16 +99,31 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct=
 pwm_chip *chip)
> =20
>  static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> +	int ret;
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> =20
> -	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
> +	ret =3D clk_prepare_enable(fpc->ipg_clk);

This is confusing because it looks as if you're breaking existing
drivers, until you realize that...

> +
> +	if ((!ret) && (fpc->has_pwmen)) {
> +		mutex_lock(&fpc->lock);
> +		regmap_update_bits(fpc->regmap, FTM_SC,
> +				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
> +		mutex_unlock(&fpc->lock);
> +	}
> +
> +	return ret;
>  }
> =20
>  static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> =20
> -	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
> +	if (fpc->has_pwmen) {
> +		mutex_lock(&fpc->lock);
> +		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
> +		mutex_unlock(&fpc->lock);
> +	}
> +	clk_disable_unprepare(fpc->ipg_clk);
>  }
> =20
>  static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> @@ -363,7 +380,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
>  {
>  	int ret;
> =20
> -	ret =3D clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
> +	ret =3D clk_prepare_enable(fpc->ipg_clk);
>  	if (ret)
>  		return ret;
> =20
> @@ -371,7 +388,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
>  	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
>  	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
> =20
> -	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
> +	clk_disable_unprepare(fpc->ipg_clk);
> =20
>  	return 0;
>  }
> @@ -428,6 +445,10 @@ static int fsl_pwm_probe(struct platform_device *pde=
v)
>  		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
>  	}
> =20
> +	fpc->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(fpc->ipg_clk))
> +		fpc->ipg_clk =3D fpc->clk[FSL_PWM_CLK_SYS];

=2E.. fpc->ipg_clk is actually the same as fpc->clk[FSL_PWM_CLK_SYS] for
older chips. I think this could be made more obvious by splitting this
patch into several smaller ones as suggested above.

> +
>  	fpc->clk[FSL_PWM_CLK_FIX] =3D devm_clk_get(fpc->chip.dev, "ftm_fix");
>  	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
>  		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
> @@ -446,6 +467,8 @@ static int fsl_pwm_probe(struct platform_device *pdev)
>  	fpc->chip.of_pwm_n_cells =3D 3;
>  	fpc->chip.base =3D -1;
>  	fpc->chip.npwm =3D 8;
> +	fpc->has_pwmen =3D of_property_read_bool(pdev->dev.of_node,
> +						"fsl,ftm-has-pwmen-bits");

As I said earlier, I think this should be derived from the compatible
string. That is, you could have a data structure such as:

	struct fsl_pwm_soc {
		bool has_enable_bits;
	};

	static const struct fsl_pwm_soc vf610_ftm_pwm =3D {
		.has_enable_bits =3D false,
	};

	/* up to here would be part of patch 2 */

	/* and this is part of patch 3, along with an entry in the OF
	 * match table */
	static const struct fsl_pwm_soc imx8x_ftm_pwm =3D {
		.has_enable_bits =3D true,
	};

Thierry

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXnIwACgkQ3SOs138+
s6GZMw/9Fpn2QrvI7aIOf1dAZDhR5JDtMV28XOGGLCJ/eRvyol+ApUp+AE1R0mUb
CswVojEYCx+lWRewD96ESw6vvyQ0gt/6JWwsW5+0dAxr5+tis1dAdh5nqATU/nNV
b7o2au+wKceweqghxfmdhPLdnKXfii7D54vMvait+PNl+pZWp55jwZil3x4ivDMz
xfgmNH0IUwulQ10Mz/oPDYe/4QS5CIyIzfVRrtNNtiBo9Clez21Kna+qVWEGQvO0
iJhV9uFXx99yfBFmZkKoYHTNi5Ycz6o3RuEy+HJv8B5WXnnQ5Rh2SJPkmGXT31Fw
4HaOfQayB4n9JxEyh2NARiTxIL+ma1MZLjGJTuXxdJz+Q11shMALoopPA1xf2DKm
XXLKl8qX+33KVE3Ez9ywVJCQFNw0ZtJPfq2yRXXaSuZyT5UZfS4igzcYFPau1U4r
MCXIe7Ix94tCQkBUI5HVJsxKEM8y48MuIeP9VdPvJ08PPjHsgwvTG0matNHdFa1M
t9cr30finADbgjd2h4dn/FGgCFDqHHoWS7/Euhl0ab1LNWQU6/797BV822rMar9B
6c+lc4cZLlr7u25suU/XZydp/Xg91FPCZUpVhMGfhJDNSBiT02kevUoGUTFH+vZX
ELXKZRHAPSg08PoLHEU4Zj+4tCFD1RNiUm3A1Ub1hJI+v0HeSYg=
=qFyJ
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
