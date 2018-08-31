Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B979C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4942C20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4942C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeHaNSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:18:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33814 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeHaNSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:18:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A976A207AD; Fri, 31 Aug 2018 11:11:38 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7A635206EE;
        Fri, 31 Aug 2018 11:11:38 +0200 (CEST)
Date:   Fri, 31 Aug 2018 11:11:37 +0200
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
Subject: Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Message-ID: <20180831091137.wkbbipssyd6mqfbt@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vuxcukfshrcehy5c"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-22-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vuxcukfshrcehy5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:09PM +0200, Philipp Rossak wrote:
> This patch adds support for the H3 ths sensor.
>=20
> The H3 supports interrupts. The interrupt is configured to update the
> the sensor values every second. The calibration data is writen at the
> begin of the init process.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c   | 91 +++++++++++++++++++++++++++++++=
++++++
>  include/linux/iio/adc/sun4i-gpadc.h | 18 ++++++++
>  2 files changed, 109 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index c7b46c82e3e5..d5c7971b2558 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -72,6 +72,7 @@ struct gpadc_data {
>  	u32		temp_data_base;
>  	int		sensor_count;
>  	bool		supports_nvmem;
> +	u32		ths_irq_clear;
>  };
> =20
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -79,6 +80,10 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int ir=
q, void *dev_id);
>  static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
>  static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
> =20
> +static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info);
> +static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info);
> +static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data);
> +
>  static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.temp_offset =3D -1932,
>  	.temp_scale =3D 133,
> @@ -137,6 +142,22 @@ static const struct gpadc_data sun8i_a33_gpadc_data =
=3D {
>  	.sensor_count =3D 1,
>  };
> =20
> +static const struct gpadc_data sun8i_h3_ths_data =3D {
> +	.temp_offset =3D -1791,
> +	.temp_scale =3D -121,
> +	.temp_data_base =3D SUN8I_H3_THS_TDATA0,
> +	.ths_irq_thread =3D sunx8i_h3_irq_thread,
> +	.support_irq =3D true,
> +	.has_bus_clk =3D true,
> +	.has_bus_rst =3D true,
> +	.has_mod_clk =3D true,
> +	.sensor_count =3D 1,
> +	.supports_nvmem =3D true,
> +	.ths_resume =3D sun8i_h3_ths_resume,
> +	.ths_suspend =3D sun8i_h3_ths_suspend,
> +	.ths_irq_clear =3D SUN8I_H3_THS_INTS_TDATA_IRQ_0,
> +};
> +
>  struct sun4i_sensor_tzd {
>  	struct sun4i_gpadc_iio		*info;
>  	struct thermal_zone_device	*tzd;
> @@ -409,6 +430,31 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int =
irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t sunx8i_h3_irq_thread(int irq, void *data)
> +{
> +	struct sun4i_gpadc_iio *info =3D data;
> +	int i;
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
> +			info->data->ths_irq_clear);
> +
> +	for (i =3D 0; i < info->data->sensor_count; i++)
> +		thermal_zone_device_update(info->tzds[i].tzd,
> +						THERMAL_EVENT_TEMP_SAMPLE);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
> +{
> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
> +//			info->calibration_data[0]);
> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
> +//			info->calibration_data[1]);

Don't put commented code.

> +
> +	return 0;
> +}
> +
>  static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> @@ -428,6 +474,16 @@ static int sun4i_ths_suspend(struct sun4i_gpadc_iio =
*info)
>  	return 0;
>  }
> =20
> +static int sun8i_h3_ths_suspend(struct sun4i_gpadc_iio *info)
> +{
> +	/* Disable ths interrupt */
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
> +	/* Disable temperature sensor */
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
> +
> +	return 0;
> +}
> +
>  static int sun4i_gpadc_runtime_resume(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> @@ -454,6 +510,37 @@ static int sun4i_ths_resume(struct sun4i_gpadc_iio *=
info)
>  	return 0;
>  }
> =20
> +static int sun8i_h3_ths_resume(struct sun4i_gpadc_iio *info)
> +{
> +	u32 value;
> +
> +	sun8i_h3_calibrate(info);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
> +			SUN4I_GPADC_CTRL0_T_ACQ(0xff));
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> +			SUN8I_H3_THS_ACQ1(0x3f));
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
> +			SUN4I_GPADC_CTRL3_FILTER_EN |
> +			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
> +			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
> +			SUN8I_H3_THS_TEMP_PERIOD(0x55));
> +
> +	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> +			SUN8I_H3_THS_TEMP_SENSE_EN0 | value);

Ideally, all these values should have a comment explaining what they
are.

And we really start to have a lot of registers defines. We'd be better
off using regmap_fields.

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vuxcukfshrcehy5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJBkgACgkQ0rTAlCFN
r3RSPg//VOFLzmgFcVUdvT7V/+SWap9ke9O8u8JvzEqq1qWPEGQIXn97VLyk/Mgi
5L2iyuL3Ii4/XIqLZsT119GhL7s85AARVmEsOk/99eaHoJAyp2B76Oh2UTtAUWoR
LgH5jidYkTOmkoMNL5pGr6qCWcs2b59Yk9t37MT/22WCaOF3HtfShNWz2dJjRMoW
RHidpGp67b7mZNuBqDeheAA7N0JQroOonuqUoj6YZp9rkt2wrkr0cNnLL7nBdVrB
NVQHKCIwF0ZAv7sgMpzP8rvJwg+EUTYlJXHuDSxb4u6SlDeUEB/GmUnhBG2ZKKeG
54WBdTpRHpSnvh2SweYV1Zhowx0oHIZDRX9qk6wd5v2rxL8mpNZB4u04Dy4rubi2
pMtMh31QDOugCh62Me++AdWP728LsnOZ4CDgEP+qwbCHP2BkJC1svppnvDdZf6YQ
dFnCHWwWZMSaR6xK0jQG1N4coMyQUB89B/VAfAN1J4qivKc8pAhDcu72fM+bAzaU
HFu2zajdZ9ZEDN+SYeq2aZPPOazGHuPK7U2eWilZyIwJMRonCRWbTV5Y3BUTWUUi
7W1nZEa3GXGtwOwWvFUByFHEsqDIQIJKCP/i9fK8k6wnm2uKSTTWRftVqpyLVBxY
An0mx9pHfBNSveMsrwzec8PNb6XhPaegFFcyhinH0IwUUs+Go44=
=B0Rx
-----END PGP SIGNATURE-----

--vuxcukfshrcehy5c--
