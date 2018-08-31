Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DB420837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DB420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeHaNM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:12:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33321 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeHaNM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:12:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB3E9207EB; Fri, 31 Aug 2018 11:05:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 96CAB203EC;
        Fri, 31 Aug 2018 11:05:57 +0200 (CEST)
Date:   Fri, 31 Aug 2018 11:05:56 +0200
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
Subject: Re: [PATCH v3 18/30] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
Message-ID: <20180831090556.amfyixpv2shdrrlp@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-19-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3uun7s5qxvxjzocd"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-19-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uun7s5qxvxjzocd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:45:06PM +0200, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
>=20
> This patch reworks the driver to be able to handle more than one
> thermal sensor. Newer SoC like the A80 have 4 thermal sensors.
> Because of this the maximal sensor count value was set to 4.
>=20
> The sensor_id value is set during sensor registration and is for each
> registered sensor indiviual. This makes it able to differntiate the
> sensors when the value is read from the register.
>=20
> In function sun4i_gpadc_read_raw(), the sensor number of the ths sensor
> was directly set to 0 (sun4i_gpadc_temp_read(x,x,0)). This selects
> in the temp_read function automatically sensor 0. A check for the
> sensor_id is here not required since the old sensors only have one
> thermal sensor. In addition to that is the sun4i_gpadc_read_raw()
> function only used by the "older" sensors (before A33) where the
> thermal sensor was a cobination of an adc and a thermal sensor.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c   | 63 +++++++++++++++++++++++++------=
------
>  include/linux/iio/adc/sun4i-gpadc.h |  3 ++
>  2 files changed, 46 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index c12de48c4e86..18ab72e52d78 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -69,6 +69,7 @@ struct gpadc_data {
>  	bool		has_bus_rst;
>  	bool		has_mod_clk;
>  	u32		temp_data_base;
> +	int		sensor_count;
>  };
> =20
>  static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> @@ -84,6 +85,7 @@ static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count =3D 1,
>  };
> =20
>  static const struct gpadc_data sun5i_gpadc_data =3D {
> @@ -97,6 +99,7 @@ static const struct gpadc_data sun5i_gpadc_data =3D {
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count =3D 1,
>  };
> =20
>  static const struct gpadc_data sun6i_gpadc_data =3D {
> @@ -110,6 +113,7 @@ static const struct gpadc_data sun6i_gpadc_data =3D {
>  	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
>  	.support_irq =3D true,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count =3D 1,
>  };
> =20
>  static const struct gpadc_data sun8i_a33_gpadc_data =3D {
> @@ -117,6 +121,13 @@ static const struct gpadc_data sun8i_a33_gpadc_data =
=3D {
>  	.temp_scale =3D 162,
>  	.tp_mode_en =3D SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
>  	.temp_data_base =3D SUN4I_GPADC_TEMP_DATA,
> +	.sensor_count =3D 1,
> +};
> +
> +struct sun4i_sensor_tzd {
> +	struct sun4i_gpadc_iio		*info;
> +	struct thermal_zone_device	*tzd;
> +	unsigned int			sensor_id;
>  };
> =20
>  struct sun4i_gpadc_iio {
> @@ -130,7 +141,7 @@ struct sun4i_gpadc_iio {
>  	const struct gpadc_data		*data;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
> -	struct thermal_zone_device	*tzd;
> +	struct sun4i_sensor_tzd		tzds[MAX_SENSOR_COUNT];
>  	struct device			*sensor_device;
>  	struct clk			*bus_clk;
>  	struct clk			*mod_clk;
> @@ -280,7 +291,8 @@ static int sun4i_gpadc_adc_read(struct iio_dev *indio=
_dev, int channel,
>  			SUN4I_GPADC_IRQ_FIFO_DATA);
>  }
> =20
> -static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> +static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
> +				int sensor)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
> =20
> @@ -290,7 +302,8 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indi=
o_dev, int *val)
> =20
>  	pm_runtime_get_sync(indio_dev->dev.parent);
> =20
> -	regmap_read(info->regmap, info->data->temp_data_base, val);
> +	regmap_read(info->regmap, info->data->temp_data_base + 0x4 * sensor,
> +			val);
> =20
>  	pm_runtime_mark_last_busy(indio_dev->dev.parent);
>  	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> @@ -334,7 +347,7 @@ static int sun4i_gpadc_read_raw(struct iio_dev *indio=
_dev,
>  			ret =3D sun4i_gpadc_adc_read(indio_dev, chan->channel,
>  						   val);
>  		else
> -			ret =3D sun4i_gpadc_temp_read(indio_dev, val);
> +			ret =3D sun4i_gpadc_temp_read(indio_dev, val, 0);
> =20
>  		if (ret)
>  			return ret;
> @@ -420,10 +433,11 @@ static int sun4i_gpadc_runtime_resume(struct device=
 *dev)
> =20
>  static int sun4i_gpadc_get_temp(void *data, int *temp)
>  {
> -	struct sun4i_gpadc_iio *info =3D data;
> +	struct sun4i_sensor_tzd *tzd =3D data;
> +	struct sun4i_gpadc_iio *info =3D tzd->info;
>  	int val, scale, offset;
> =20
> -	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
> +	if (sun4i_gpadc_temp_read(info->indio_dev, &val, tzd->sensor_id))
>  		return -ETIMEDOUT;
> =20
>  	sun4i_gpadc_temp_scale(info->indio_dev, &scale);
> @@ -569,7 +583,7 @@ static int sun4i_gpadc_probe(struct platform_device *=
pdev)
>  {
>  	struct sun4i_gpadc_iio *info;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	int ret, i;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>  	if (!indio_dev)
> @@ -603,18 +617,24 @@ static int sun4i_gpadc_probe(struct platform_device=
 *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> =20
> -	info->tzd =3D thermal_zone_of_sensor_register(info->sensor_device,
> -						    0, info,
> -						    &sun4i_ts_tz_ops);
> -	/*
> -	 * Do not fail driver probing when failing to register in
> -	 * thermal because no thermal DT node is found.
> -	 */
> -	if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) !=3D -ENODEV) {
> -		dev_err(&pdev->dev,
> -			"could not register thermal sensor: %ld\n",
> -			PTR_ERR(info->tzd));
> -		return PTR_ERR(info->tzd);
> +	for (i =3D 0; i < info->data->sensor_count; i++) {
> +		info->tzds[i].info =3D info;
> +		info->tzds[i].sensor_id =3D i;
> +
> +		info->tzds[i].tzd =3D thermal_zone_of_sensor_register(

This isn't where should wrap your line.

> +				info->sensor_device,
> +				i, &info->tzds[i], &sun4i_ts_tz_ops);
> +		/*
> +		 * Do not fail driver probing when failing to register in
> +		 * thermal because no thermal DT node is found.
> +		 */
> +		if (IS_ERR(info->tzds[i].tzd) && \

And you don't need the \ here.

> +				PTR_ERR(info->tzds[i].tzd) !=3D -ENODEV) {
> +			dev_err(&pdev->dev,
> +				"could not register thermal sensor: %ld\n",
> +				PTR_ERR(info->tzds[i].tzd));
> +			return PTR_ERR(info->tzds[i].tzd);
> +		}

If you're failing half way through the registration, you won't free
the first sensors registered.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3uun7s5qxvxjzocd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJBPMACgkQ0rTAlCFN
r3RETA//aWFuEp0ik2/0L5S8hJVRICc+qWKTMSBv1zqlQBSRgMpXJo+UWvRKw7Mg
CspO0wBd+si6hhkVuYfawIrUDoLIR6xtOngheSlH91GsBM9UKNUHthnHsaPPceww
VkdPQrCCY7B9SkCzbHkZc2tGHW6S0oPl+zsOJ9wI28FAISScSkOeUtFmZkKB9MbO
TWrf3leE7PcSR0cRhD3lqbh98Op2L84r3thsJbUihFU6+VrVzxHYzAPrdxyts1LO
xX29xA3O04qLEkvcHyYpwgxqEymSDtiOPBCLw29UhzO1JdAkddnkWS3tzXTx1FUz
5iLCXNGjil8FxuqnDKyGTLJlAxMhTk0qNBhc2QYve2NEt6RBVlyoOKiVDWPgvl5n
pmGibary9M5OOVasf2z51D6p6CmLip1zgel2RMIUttnicdsVvso1IQCfM5eHK4fi
uwaMFoOlfJqVlB8uhYUyosGSsGxqqoaCqK8pS13Ar7voXBZZun3Fztr7FuGcLNlL
O1SRcUFMTSGwJk/2nwo8Ma7kvl1CrvdADHmb7GWIjV+K0jNK5IY1D5TMHtDUX3/T
jat+zbSvj7xgtHhAREWGAvagP9Vniwj5uVM3nZskV/YGH0e8qgiF2wxfAIDcfod6
kyGIxJkj3EjIHGI0LPtCiG0bzJumo8AzlR3JCEubEChOlnZ9oTQ=
=/KrB
-----END PGP SIGNATURE-----

--3uun7s5qxvxjzocd--
