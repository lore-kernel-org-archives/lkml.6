Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5752083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5752083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeHaNJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:09:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33028 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbeHaNJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:09:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA8B320877; Fri, 31 Aug 2018 11:03:08 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3309207EB;
        Fri, 31 Aug 2018 11:03:08 +0200 (CEST)
Date:   Fri, 31 Aug 2018 11:03:07 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 17/30] iio: adc: sun4i-gpadc-iio: rework: support
 clocks and reset
Message-ID: <20180831090307.v3bp445sgugquh6f@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-18-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o4ox2v23labjh637"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-18-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o4ox2v23labjh637
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:05PM +0200, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
>=20
> The SoCs after H3 has newer thermal sensor ADCs, which have two clock
> inputs (bus clock and sampling clock) and a reset. The registers are
> also re-arranged.
>=20
> This commit reworks the code, adds the process of the clocks and resets.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 72 +++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index c278e165e161..c12de48c4e86 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -22,6 +22,7 @@
>   * shutdown for not being used.
>   */
> =20
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -31,6 +32,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/thermal.h>
>  #include <linux/delay.h>
> =20
> @@ -63,6 +65,9 @@ struct gpadc_data {
>  	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
>  	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
>  	bool		support_irq;
> +	bool		has_bus_clk;
> +	bool		has_bus_rst;
> +	bool		has_mod_clk;
>  	u32		temp_data_base;
>  };
> =20
> @@ -127,6 +132,9 @@ struct sun4i_gpadc_iio {
>  	struct mutex			mutex;
>  	struct thermal_zone_device	*tzd;
>  	struct device			*sensor_device;
> +	struct clk			*bus_clk;
> +	struct clk			*mod_clk;
> +	struct reset_control		*reset;
>  };
> =20
>  static const struct iio_chan_spec sun4i_gpadc_channels[] =3D {
> @@ -472,8 +480,13 @@ static int sun4i_gpadc_probe_dt(struct platform_devi=
ce *pdev,
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> =20
> -	info->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> -					     &sun4i_gpadc_regmap_config);
> +	if (info->data->has_bus_clk)
> +		info->regmap =3D devm_regmap_init_mmio_clk(&pdev->dev, "bus",
> +				base, &sun4i_gpadc_regmap_config);
> +	else
> +		info->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> +				&sun4i_gpadc_regmap_config);
> +
>  	if (IS_ERR(info->regmap)) {
>  		ret =3D PTR_ERR(info->regmap);
>  		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
> @@ -498,9 +511,58 @@ static int sun4i_gpadc_probe_dt(struct platform_devi=
ce *pdev,
>  		}
>  	}
> =20
> +	if (info->data->has_bus_rst) {
> +		info->reset =3D devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(info->reset)) {
> +			ret =3D PTR_ERR(info->reset);
> +			return ret;
> +		}
> +
> +		ret =3D reset_control_deassert(info->reset);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (info->data->has_bus_clk) {
> +		info->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
> +		if (IS_ERR(info->bus_clk)) {
> +			ret =3D PTR_ERR(info->bus_clk);
> +			goto assert_reset;
> +		}
> +
> +		ret =3D clk_prepare_enable(info->bus_clk);
> +		if (ret)
> +			goto assert_reset;

That should be done in the runtime_resume hook

> +	}
> +
> +	if (info->data->has_mod_clk) {
> +		info->mod_clk =3D devm_clk_get(&pdev->dev, "mod");
> +		if (IS_ERR(info->mod_clk)) {
> +			ret =3D PTR_ERR(info->mod_clk);
> +			goto disable_bus_clk;
> +		}
> +
> +		/* Running at 4MHz */
> +		ret =3D clk_set_rate(info->mod_clk, 4000000);
> +		if (ret)
> +			goto disable_bus_clk;

Why?

> +		ret =3D clk_prepare_enable(info->mod_clk);
> +		if (ret)
> +			goto disable_bus_clk;
> +	}
> +
>  	info->sensor_device =3D &pdev->dev;
> =20
>  	return 0;
> +
> +disable_bus_clk:
> +	clk_disable_unprepare(info->bus_clk);
> +
> +assert_reset:
> +	reset_control_assert(info->reset);

You should check for the variables here before calling those
functions, if you end up here with your variable not set, you'll have
improper refcounting.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o4ox2v23labjh637
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJBEsACgkQ0rTAlCFN
r3Sy0w//QZInrgKvIlcZrtJ5CgqUW1VCq32Wo8LuWKyy2oRDMcfmc2HdSaIPKDpJ
OTfzIh/l8yx9DLkFZu/UHpZbeqhZSi9471uFzbyZv8GubpDP+IPP9lhWlr8YnxPh
3ZlQy+x/jQ5CG0FTGMI+WfmgTAUezTh+XyjFoEsNsd6n0Kf4htzPQgu1yXHeu1+G
6XemmN+1chO9AqKOBZwyyOnrDfxYSmuxybCHSwlqv2sN5kldgklnV1FL1N/VGSQg
NrKidawvuTriY42xFI6hvc48T5uSDNUCOeyn5oss80EVpsXtb4zkrL+jYWLqMOCm
iw9VHioVZA/UekDnwyuPWb3NyOCgE3gnSTvl97ftplUxyrmx7UYuHvP7gX0TVnUH
cpDBeQSJhbPrBTqwG7QJzNgaBCdu/frNFTtP6YN4CBX1X/RsLtYFr257l88DopsC
uupPPulQCcBMOjAuve63PqaEhI1SiG4qdQA9syYL2Kb+oWp9AOq5WTmaB6Nm78Uk
7BkFjJegYIy3AC0/Qap/joOH/qM+CC7LE+Q4c6624CMJK4ZWOfs9KJ87ty3zXGTG
zceMZ8xmyKs2OvRh7a4paEam4Wpgjws5tyo0zWyG4pm+BPnxQBR41q17HmnRgLvB
bu9/DZXjjpO0H8walsuoRT07gESiwaxz7FxFIc9xdQJKY7a5W1c=
=30Zm
-----END PGP SIGNATURE-----

--o4ox2v23labjh637--
