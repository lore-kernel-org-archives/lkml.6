Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEFB20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEFB20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeHaMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:51:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59945 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeHaMvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:51:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E30EA207AD; Fri, 31 Aug 2018 10:44:38 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id A86DF203EC;
        Fri, 31 Aug 2018 10:44:38 +0200 (CEST)
Date:   Fri, 31 Aug 2018 10:44:37 +0200
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
Subject: Re: [PATCH v3 10/30] iio: adc: rework irq and adc_channel handling
Message-ID: <20180831084437.mxcwf4wbrxbpoa5e@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-11-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mfxoqxfqrc5ofsun"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-11-embed3d@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfxoqxfqrc5ofsun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 30, 2018 at 05:44:58PM +0200, Philipp Rossak wrote:
> We rework the irq handling and the adc_channel handling.
> This is requiered since we merge the mfd driver into the adc driver.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

This patch is actually the opposite of the previous ones, it has too
many things in it, and sohuld be split :)

> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 157 ++++++++++++++++++++++++--------=
------
>  include/linux/mfd/sun4i-gpadc.h   |   7 --
>  2 files changed, 98 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 658a7e3e3370..a2027614ee0c 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -49,6 +49,8 @@ static unsigned int sun6i_gpadc_chan_select(unsigned in=
t chan)
>  	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>  }
> =20
> +struct sun4i_gpadc_iio;
> +
>  struct gpadc_data {
>  	int		temp_offset;
>  	int		temp_scale;
> @@ -56,8 +58,15 @@ struct gpadc_data {
>  	unsigned int	tp_adc_select;
>  	unsigned int	(*adc_chan_select)(unsigned int chan);
>  	unsigned int	adc_chan_mask;
> +	bool		adc_channel;
> +	irqreturn_t	(*ths_irq_thread)(int irq, void *dev_id);
> +	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
> +	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
> +	bool		support_irq;
>  };
> =20
> +static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
> +
>  static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.temp_offset =3D -1932,
>  	.temp_scale =3D 133,
> @@ -65,6 +74,9 @@ static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.tp_adc_select =3D SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select =3D &sun4i_gpadc_chan_select,
>  	.adc_chan_mask =3D SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
> +	.adc_channel =3D true,
> +	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
> +	.support_irq =3D true,
>  };
> =20
>  static const struct gpadc_data sun5i_gpadc_data =3D {
> @@ -74,6 +86,9 @@ static const struct gpadc_data sun5i_gpadc_data =3D {
>  	.tp_adc_select =3D SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select =3D &sun4i_gpadc_chan_select,
>  	.adc_chan_mask =3D SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
> +	.adc_channel =3D true,
> +	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
> +	.support_irq =3D true,
>  };
> =20
>  static const struct gpadc_data sun6i_gpadc_data =3D {
> @@ -83,6 +98,9 @@ static const struct gpadc_data sun6i_gpadc_data =3D {
>  	.tp_adc_select =3D SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select =3D &sun6i_gpadc_chan_select,
>  	.adc_chan_mask =3D SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
> +	.adc_channel =3D true,
> +	.ths_irq_thread =3D sun4i_gpadc_data_irq_handler,
> +	.support_irq =3D true,

So this seems to enable the support for the interrupts without going
through the MFD regmap that was removed in the previous patches.

>  };
> =20
>  static const struct gpadc_data sun8i_a33_gpadc_data =3D {
> @@ -96,13 +114,10 @@ struct sun4i_gpadc_iio {
>  	struct completion		completion;
>  	int				temp_data;
>  	u32				adc_data;
> +	unsigned int			irq_data_type;
>  	struct regmap			*regmap;
> -	unsigned int			fifo_data_irq;
> -	atomic_t			ignore_fifo_data_irq;
> -	unsigned int			temp_data_irq;
> -	atomic_t			ignore_temp_data_irq;
> +	unsigned int			irq;
>  	const struct gpadc_data		*data;
> -	bool				no_irq;

But at the same time, you remove some fields of that structure, and
rename some other without any explanation.

>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
>  	struct thermal_zone_device	*tzd;
> @@ -130,6 +145,20 @@ static const struct regmap_config sun4i_gpadc_regmap=
_config =3D {
>  	.fast_io =3D true,
>  };
> =20
> +static int sun4i_gpadc_irq_init(struct sun4i_gpadc_iio *info)
> +{
> +	u32 reg;
> +
> +	if (info->irq_data_type =3D=3D SUN4I_GPADC_IRQ_FIFO_DATA)
> +		reg =3D SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN;
> +	else
> +		reg =3D SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN;
> +
> +	regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC, reg);
> +
> +	return 0;
> +}
> +
>  static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
>  				 unsigned int irq)
>  {
> @@ -151,7 +180,7 @@ static int sun4i_prepare_for_irq(struct iio_dev *indi=
o_dev, int channel,
>  	if (ret)
>  		return ret;
> =20
> -	if (irq =3D=3D info->fifo_data_irq) {
> +	if (irq =3D=3D SUN4I_GPADC_IRQ_FIFO_DATA) {
>  		ret =3D regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
>  				   info->data->tp_mode_en |
>  				   info->data->tp_adc_select |
> @@ -172,6 +201,8 @@ static int sun4i_prepare_for_irq(struct iio_dev *indi=
o_dev, int channel,
>  		ret =3D regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
>  				   info->data->tp_mode_en);
>  	}
> +	if (info->data->support_irq)
> +		sun4i_gpadc_irq_init(info);
> =20
>  	if (ret)
>  		return ret;
> @@ -194,11 +225,12 @@ static int sun4i_gpadc_read(struct iio_dev *indio_d=
ev, int channel, int *val,
> =20
>  	mutex_lock(&info->mutex);
> =20
> +	info->irq_data_type =3D irq;

This would need to be explained too

>  	ret =3D sun4i_prepare_for_irq(indio_dev, channel, irq);
>  	if (ret)
>  		goto err;
> =20
> -	enable_irq(irq);
> +	enable_irq(info->irq);
> =20
>  	/*
>  	 * The temperature sensor throws an interruption periodically (currently
> @@ -212,7 +244,7 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev=
, int channel, int *val,
>  		goto err;
>  	}
> =20
> -	if (irq =3D=3D info->fifo_data_irq)
> +	if (irq =3D=3D SUN4I_GPADC_IRQ_FIFO_DATA)
>  		*val =3D info->adc_data;
>  	else
>  		*val =3D info->temp_data;
> @@ -222,7 +254,7 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev=
, int channel, int *val,
> =20
>  err:
>  	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> -	disable_irq(irq);
> +	disable_irq(info->irq);
>  	mutex_unlock(&info->mutex);
> =20
>  	return ret;
> @@ -231,16 +263,15 @@ static int sun4i_gpadc_read(struct iio_dev *indio_d=
ev, int channel, int *val,
>  static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>  				int *val)
>  {
> -	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
> -
> -	return sun4i_gpadc_read(indio_dev, channel, val, info->fifo_data_irq);
> +	return sun4i_gpadc_read(indio_dev, channel, val,
> +			SUN4I_GPADC_IRQ_FIFO_DATA);
>  }
> =20
>  static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
> =20
> -	if (info->no_irq) {
> +	if (!info->data->support_irq) {
>  		pm_runtime_get_sync(indio_dev->dev.parent);
> =20
>  		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
> @@ -251,7 +282,7 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indi=
o_dev, int *val)
>  		return 0;
>  	}
> =20
> -	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
> +	return sun4i_gpadc_read(indio_dev, 0, val, SUN4I_GPADC_IRQ_TEMP_DATA);
>  }
> =20
>  static int sun4i_gpadc_temp_offset(struct iio_dev *indio_dev, int *val)
> @@ -320,31 +351,21 @@ static const struct iio_info sun4i_gpadc_iio_info =
=3D {
>  	.read_raw =3D sun4i_gpadc_read_raw,
>  };
> =20
> -static irqreturn_t sun4i_gpadc_temp_data_irq_handler(int irq, void *dev_=
id)
> +static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
>  {
>  	struct sun4i_gpadc_iio *info =3D dev_id;
> =20
> -	if (atomic_read(&info->ignore_temp_data_irq))
> -		goto out;
> -
> -	if (!regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, &info->temp_data))
> -		complete(&info->completion);
> -
> -out:
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_=
id)
> -{
> -	struct sun4i_gpadc_iio *info =3D dev_id;
> -
> -	if (atomic_read(&info->ignore_fifo_data_irq))
> -		goto out;
> -
> -	if (!regmap_read(info->regmap, SUN4I_GPADC_DATA, &info->adc_data))
> -		complete(&info->completion);
> -
> -out:
> +	if (info->irq_data_type =3D=3D SUN4I_GPADC_IRQ_FIFO_DATA) {
> +		/* read fifo data */
> +		if (!regmap_read(info->regmap, SUN4I_GPADC_DATA,
> +					&info->adc_data))
> +			complete(&info->completion);
> +	} else {
> +		/* read temp data */
> +		if (!regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA,
> +					&info->temp_data))
> +			complete(&info->completion);
> +	}
>  	return IRQ_HANDLED;
>  }
> =20
> @@ -356,6 +377,8 @@ static int sun4i_gpadc_runtime_suspend(struct device =
*dev)
>  	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
>  	/* Disable temperature sensor on IP */
>  	regmap_write(info->regmap, SUN4I_GPADC_TPR, 0);
> +	/* Disable irq*/
> +	regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC, 0);
> =20
>  	return 0;
>  }
> @@ -378,6 +401,7 @@ static int sun4i_gpadc_runtime_resume(struct device *=
dev)
>  		     SUN4I_GPADC_TPR_TEMP_ENABLE |
>  		     SUN4I_GPADC_TPR_TEMP_PERIOD(800));
> =20
> +
>  	return 0;
>  }
> =20
> @@ -426,8 +450,6 @@ static int sun4i_gpadc_probe_dt(struct platform_devic=
e *pdev,
>  	if (!info->data)
>  		return -ENODEV;
> =20
> -	info->no_irq =3D true;
> -
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base =3D devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(base))
> @@ -441,8 +463,25 @@ static int sun4i_gpadc_probe_dt(struct platform_devi=
ce *pdev,
>  		return ret;
>  	}
> =20
> -	if (IS_ENABLED(CONFIG_THERMAL_OF))
> -		info->sensor_device =3D &pdev->dev;

You're also dropping the THERMAL_OF conditions

> +	if (info->data->support_irq) {
> +
> +		/* ths interrupt */
> +		info->irq =3D platform_get_irq(pdev, 0);
> +
> +		ret =3D devm_request_threaded_irq(&pdev->dev, info->irq,
> +				NULL, info->data->ths_irq_thread,
> +				IRQF_ONESHOT, dev_name(&pdev->dev), info);

Why do you need a threaded interrupt?

> +		if (info->data->adc_channel)
> +			disable_irq(info->irq);

Does it still needs to be disabled? Why?

> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to add ths irq: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	info->sensor_device =3D &pdev->dev;
> =20
>  	return 0;
>  }
> @@ -469,6 +508,11 @@ static int sun4i_gpadc_probe(struct platform_device =
*pdev)
>  	indio_dev->info =3D &sun4i_gpadc_iio_info;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> +	if (&info->data->adc_channel) {
> +		indio_dev->num_channels =3D ARRAY_SIZE(sun4i_gpadc_channels);
> +		indio_dev->channels =3D sun4i_gpadc_channels;
> +	}
> +
>  	ret =3D sun4i_gpadc_probe_dt(pdev, indio_dev);
> =20
>  	if (ret)
> @@ -480,20 +524,18 @@ static int sun4i_gpadc_probe(struct platform_device=
 *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> =20
> -	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> -		info->tzd =3D thermal_zone_of_sensor_register(info->sensor_device,
> -							    0, info,
> -							    &sun4i_ts_tz_ops);
> -		/*
> -		 * Do not fail driver probing when failing to register in
> -		 * thermal because no thermal DT node is found.
> -		 */
> -		if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) !=3D -ENODEV) {
> -			dev_err(&pdev->dev,
> -				"could not register thermal sensor: %ld\n",
> -				PTR_ERR(info->tzd));
> -			return PTR_ERR(info->tzd);
> -		}
> +	info->tzd =3D thermal_zone_of_sensor_register(info->sensor_device,
> +						    0, info,
> +						    &sun4i_ts_tz_ops);
> +	/*
> +	 * Do not fail driver probing when failing to register in
> +	 * thermal because no thermal DT node is found.
> +	 */
> +	if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) !=3D -ENODEV) {
> +		dev_err(&pdev->dev,
> +			"could not register thermal sensor: %ld\n",
> +			PTR_ERR(info->tzd));
> +		return PTR_ERR(info->tzd);
>  	}
> =20
>  	ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> @@ -505,7 +547,7 @@ static int sun4i_gpadc_probe(struct platform_device *=
pdev)
>  	return 0;
> =20
>  err_map:
> -	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
> +	if (!info->data->support_irq)
>  		iio_map_array_unregister(indio_dev);
> =20
>  	pm_runtime_put(&pdev->dev);
> @@ -522,12 +564,9 @@ static int sun4i_gpadc_remove(struct platform_device=
 *pdev)
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> =20
> -	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> -		return 0;
> -
>  	thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
> =20
> -	if (!info->no_irq)
> +	if (!info->data->support_irq)
>  		iio_map_array_unregister(indio_dev);
> =20
>  	return 0;
> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gp=
adc.h
> index 54c7c9375c1b..ca59336f246b 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -99,11 +99,4 @@
>  	.datasheet_name =3D _name,				\
>  }
> =20
> -struct sun4i_gpadc_dev {
> -	struct device			*dev;
> -	struct regmap			*regmap;
> -	struct regmap_irq_chip_data	*regmap_irqc;
> -	void __iomem			*base;
> -};

And you're dropping that structure.

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mfxoqxfqrc5ofsun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI//QACgkQ0rTAlCFN
r3SH0hAAkv/5DLPyRKRwCH3wI7ScJ7gptzoJHM3LQbe9xAsrmo1yfJjVm9Vp+2dq
EWM/D394F/HG/8+l7iedNHmE68M0wxVupZ6TZ+eaCq8EjiEFobAgZV2xwHEYdl/i
A+tUHZsNlk30sxbYlbEQkWUvB7lkP1eNp5hOr7bAeMxlFHtxojHyrk9FeIVUiHg9
mE++xfxlveOzXMpBB6FM3mf79MQegNiW/762hwqeSG2bdTDg5OqPfqVWwBi0iZfg
v+daoHlrc/gEv4VkCj5BBMt6xb727cvxGZlE+BfnG5GitnXh5NJQ4908GcZBF8Xj
vwXS9q7KmlYLxUObo3Me356U3IuyKojfZ4kcuwuGgpcCSwMVJzR0KcMtXONapeg2
g5WujhPoP+0PjTaND5yglDBqTPdz8jtdKVPtgmlaeARcpQKDBvYGo9fXobhomTg+
oh9l1mNoYnKd1V3awk8FUBCEXqHhSSeGDL07hTOhCfL+HmAN/iHbNfkXS2/JIdn6
PysHHoTj5sQDSrABz/KjiVtxtWuauNC/p4wXD2qkubolgm3ZoyDy35anp7Wi39d1
ORNZnSmPtY6mutDRcbuvJNAUTbWlpgy/WcfhtWSNs3maxramMJNggNtch7yvM9LN
yazal6Ly3zqnN0RngBddlVQKVLcXKpj+5bDRycLw0OvOoSInhrg=
=aRvd
-----END PGP SIGNATURE-----

--mfxoqxfqrc5ofsun--
