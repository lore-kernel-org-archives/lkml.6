Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeAaTYK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:24:10 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:57278 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeAaTYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:24:08 -0500
Date: Wed, 31 Jan 2018 20:23:54 +0100
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, icenowy@aosc.io, edu.molinas@gmail.com,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 09/16] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Message-ID: <20180131192354.sb7zmcwc6c3eisqj@qschulz>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-10-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wbbx6ysk7ybivvth"
Content-Disposition: inline
In-Reply-To: <20180128232919.12639-10-embed3d@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wbbx6ysk7ybivvth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Jan 29, 2018 at 12:29:12AM +0100, Philipp Rossak wrote:
> This patch adds support for the H3 ths sensor.
>=20
> The H3 supports interrupts. The interrupt is configured to update the
> the sensor values every second. The calibration data is writen at the
> begin of the init process.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 86 +++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/sun4i-gpadc.h   | 22 ++++++++++
>  2 files changed, 108 insertions(+)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index b7b5451226b0..8196203d65fe 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -61,6 +61,9 @@ struct sun4i_gpadc_iio;
>  static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
>  static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
> =20
> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info);
> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info);
> +

We try to avoid using the generic sunxi prefix.

>  struct gpadc_data {
>  	int		temp_offset;
>  	int		temp_scale;
> @@ -71,6 +74,10 @@ struct gpadc_data {
>  	unsigned int	temp_data[MAX_SENSOR_COUNT];
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
> +	u32		ctrl0_map;
> +	u32		ctrl2_map;
> +	u32		sensor_en_map;
> +	u32		filter_map;
>  	u32		irq_clear_map;
>  	u32		irq_control_map;
>  	bool		has_bus_clk;
> @@ -138,6 +145,31 @@ static const struct gpadc_data sun8i_a33_gpadc_data =
=3D {
>  	.support_irq =3D false,
>  };
> =20
> +static const struct gpadc_data sun8i_h3_ths_data =3D {
> +	.temp_offset =3D -1791,
> +	.temp_scale =3D -121,
> +	.temp_data =3D {SUN8I_H3_THS_TDATA0, 0, 0, 0},
> +	.sample_start =3D sunxi_ths_sample_start,
> +	.sample_end =3D sunxi_ths_sample_end,
> +	.has_bus_clk =3D true,
> +	.has_bus_rst =3D true,
> +	.has_mod_clk =3D true,
> +	.sensor_count =3D 1,
> +	.supports_nvmem =3D true,
> +	.support_irq =3D true,
> +	.ctrl0_map =3D SUN4I_GPADC_CTRL0_T_ACQ(0xff),
> +	.ctrl2_map =3D SUN8I_H3_THS_ACQ1(0x3f),
> +	.sensor_en_map =3D SUN8I_H3_THS_TEMP_SENSE_EN0,
> +	.filter_map =3D SUN4I_GPADC_CTRL3_FILTER_EN |
> +		SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2),
> +	.irq_clear_map =3D SUN8I_H3_THS_INTS_ALARM_INT_0 |
> +			SUN8I_H3_THS_INTS_SHUT_INT_0   |
> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0  |
> +			SUN8I_H3_THS_INTS_ALARM_OFF_0,
> +	.irq_control_map =3D SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
> +		SUN8I_H3_THS_TEMP_PERIOD(0x7),

=46rom what I've understood, ACQ regs are basically clock dividers. We
should make a better job at explaining it :)

> +};
> +
>  struct sun4i_gpadc_iio {
>  	struct iio_dev			*indio_dev;
>  	struct completion		completion;
> @@ -462,6 +494,16 @@ static int sun4i_gpadc_sample_end(struct sun4i_gpadc=
_iio *info)
>  	return 0;
>  }
> =20
> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info)
> +{
> +	/* Disable ths interrupt */
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC, 0x0);
> +	/* Disable temperature sensor */
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2, 0x0);
> +
> +	return 0;
> +}
> +
>  static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> @@ -473,6 +515,17 @@ static int sun4i_gpadc_runtime_suspend(struct device=
 *dev)
>  	return info->data->sample_end(info);
>  }
> =20
> +static void sunxi_calibrate(struct sun4i_gpadc_iio *info)
> +{
> +	if (info->has_calibration_data[0])
> +		regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
> +			info->calibration_data[0]);
> +
> +	if (info->has_calibration_data[1])
> +		regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
> +			info->calibration_data[1]);
> +}
> +
>  static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>  {
>  	/* clkin =3D 6MHz */
> @@ -492,6 +545,35 @@ static int sun4i_gpadc_sample_start(struct sun4i_gpa=
dc_iio *info)
>  	return 0;
>  }
> =20
> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info)
> +{
> +	u32 value;
> +	sunxi_calibrate(info);
> +
> +	if (info->data->ctrl0_map)
> +		regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
> +			info->data->ctrl0_map);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> +		info->data->ctrl2_map);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
> +			info->data->irq_clear_map);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
> +		info->data->filter_map);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
> +		info->data->irq_control_map);
> +
> +	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
> +
> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
> +		info->data->sensor_en_map | value);
> +
> +	return 0;
> +}
> +

I'm a bit worried. Will all the sensors have the same sample start? Or
will we need at some point also entries in info->data for register
addresses, if they have ctrl2 or filter, etc...

Maybe we could define a sample_start for the h3 only and reuse-it if
possible and if not declare another sample start? All depends if the
sample start is most likely to change in the near future or not. If it
is, then we should avoid adding a lot of variables in info->data and
just go for a single sample_start per SoC.

>  static int sun4i_gpadc_runtime_resume(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info =3D iio_priv(dev_get_drvdata(dev));
> @@ -582,6 +664,10 @@ static const struct of_device_id sun4i_gpadc_of_id[]=
 =3D {
>  		.compatible =3D "allwinner,sun8i-a33-ths",
>  		.data =3D &sun8i_a33_gpadc_data,
>  	},
> +	{
> +		.compatible =3D "allwinner,sun8i-h3-ths",
> +		.data =3D &sun8i_h3_ths_data,
> +	},
>  	{ /* sentinel */ }
>  };
> =20
> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gp=
adc.h
> index 458f2159a95a..80b79c31cea3 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -91,7 +91,29 @@
>  #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
> =20
>  /* SUNXI_THS COMMON REGISTERS + DEFINES */
> +#define SUN8I_H3_THS_CTRL0				0x00
> +#define SUN8I_H3_THS_CTRL2				0x40
>  #define SUN8I_H3_THS_INTC				0x44
> +#define SUN8I_H3_THS_STAT				0x48
> +#define SUN8I_H3_THS_FILTER				0x70
> +#define SUNXI_THS_CDATA_0_1				0x74
> +#define SUNXI_THS_CDATA_2_3				0x78
> +#define SUN8I_H3_THS_TDATA0				0x80
> +
> +#define SUN8I_H3_THS_ACQ1(x)				(GENMASK(31, 16) & ((x) << 16))
> +
> +#define SUN8I_H3_THS_TEMP_SENSE_EN0			BIT(0)
> +
> +#define SUN8I_H3_THS_TEMP_PERIOD(x)			(GENMASK(31, 12) & ((x) << 12))
> +
> +#define SUN8I_H3_THS_INTS_ALARM_INT_0			BIT(0)
> +#define SUN8I_H3_THS_INTS_SHUT_INT_0			BIT(4)
> +#define SUN8I_H3_THS_INTS_TDATA_IRQ_0			BIT(8)
> +#define SUN8I_H3_THS_INTS_ALARM_OFF_0			BIT(12)
> +
> +#define SUN8I_H3_THS_INTC_ALARM_INT_EN0			BIT(0)
> +#define SUN8I_H3_THS_INTC_SHUT_INT_EN0			BIT(4)
> +#define SUN8I_H3_THS_INTC_TDATA_IRQ_EN0			BIT(8)
> =20

Personal taste here but I prefer the register bits to be defined just
below the register address define.

i.e.:

#define SUN8I_H3_THS_CTRL2                           0x40
#define SUN8I_H3_THS_ACQ1(x)                         (GENMASK(31, 16) & ((x=
) << 16))
#define SUN8I_H3_THS_TEMP_SENSE_EN0                  BIT(0)

that way we know for which register we should use which constants.

Quentin

--wbbx6ysk7ybivvth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJachfDAAoJEIS4mnU+4PGjAq0P/2PzqJJ1HZqIunUsaLkwXB1U
39Pvx7cgIoUc2wlh55XwevHqpwKNlumbdJ3DGmrf04vv80lbQgtkX1ePc3B+EIIH
foPHUVPET05LefG/gffeJOkCp24N1bmgQmqt0Pbk8fMu8XxPI+9rL3XTGsjuTgSu
JwAhlI7AqI8PjzLT6s4FOpfqX9qcwdUoXWNZ+FZtNnmzTR6mRDOCEMWsRmIoW1q3
TSM5Bn6LLpgNGnN26IzONGLHylammQW1i86NmjH9GwG5LU2Mi9I+7LpYBeAlAlBY
G+xNCfkT15VKxVTvarhbvQQXXqZdFhoaGJ66I/CfSq+21io3QAHGEBx6D2f0W3oa
lc9C0QRlmYa829ceDzV7jn1nQh8uRWH8Elx44MZ9VSBYCInNa9IPNVi7/43bZbtU
R6lyPRt/fZQIFTaiZDQMtGUy80wKug1TFAdXa1sG0cPgk9W5kUEFzSFPzzDGOzlx
+b9LeJUc3A7/0B59YLdHUUEwWyuzHnokOFfGSkN1nCEprid5jORVzM7GZqHKVLn1
l1KmArvjhLcNCNBZGhYJzOlhfT3K4P4ncYbkdD7FbCbSrPdIkpYcDtSiyS80Wk/c
vsb9ajUCkM4ToP0T+RJqG+YhSdOD9fEZDmCnHvfqv9wnW2TwWhHFdKnsoOpfrXrw
fZYm4K1+RQ3rGL4lf0qz
=e73m
-----END PGP SIGNATURE-----

--wbbx6ysk7ybivvth--
