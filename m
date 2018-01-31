Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeAaSmm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:42:42 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:56300 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeAaSmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:42:40 -0500
Date: Wed, 31 Jan 2018 19:42:36 +0100
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
Subject: Re: [PATCH v2 06/16] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
Message-ID: <20180131184236.4yhp732l5kenhmp2@qschulz>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-7-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3vbibixtpc5jv4ig"
Content-Disposition: inline
In-Reply-To: <20180128232919.12639-7-embed3d@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3vbibixtpc5jv4ig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Jan 29, 2018 at 12:29:09AM +0100, Philipp Rossak wrote:
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
>  drivers/iio/adc/sun4i-gpadc-iio.c | 36 +++++++++++++++++++++++----------=
---
>  include/linux/mfd/sun4i-gpadc.h   |  3 +++
>  2 files changed, 26 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 51ec0104d678..ac9ad2f8232f 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -67,12 +67,13 @@ struct gpadc_data {
>  	unsigned int	tp_adc_select;
>  	unsigned int	(*adc_chan_select)(unsigned int chan);
>  	unsigned int	adc_chan_mask;
> -	unsigned int	temp_data;
> +	unsigned int	temp_data[MAX_SENSOR_COUNT];
>  	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>  	int		(*sample_end)(struct sun4i_gpadc_iio *info);
>  	bool		has_bus_clk;
>  	bool		has_bus_rst;
>  	bool		has_mod_clk;
> +	int		sensor_count;
>  };
> =20

I've noticed that for H3, A83T, A64 (at least), if DATA reg of sensor 0
is e.g. 0x80, DATA reg of sensor N is at 0x80 + 0x04 * N.

Is that verified for other SoCs? Does anyone have some input on this?

We could then just use temp_data as the DATA reg "base" and increment by
0x4 depending on the sensor id instead of using a fixed-size array.

>  static const struct gpadc_data sun4i_gpadc_data =3D {
> @@ -82,9 +83,10 @@ static const struct gpadc_data sun4i_gpadc_data =3D {
>  	.tp_adc_select =3D SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select =3D &sun4i_gpadc_chan_select,
>  	.adc_chan_mask =3D SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
> -	.temp_data =3D SUN4I_GPADC_TEMP_DATA,
> +	.temp_data =3D {SUN4I_GPADC_TEMP_DATA, 0, 0, 0},
>  	.sample_start =3D sun4i_gpadc_sample_start,
>  	.sample_end =3D sun4i_gpadc_sample_end,
> +	.sensor_count =3D 1,

If the solution above is not desirable/possible, could we use something
like:

unsigned int sun4i_temp_data[] =3D {SUN4I_GPADC_TEMP_DATA,};

static const struct gpadc_data sun4i_gpadc_data =3D {
	.temp_data =3D &sun4i_temp_data,
	.sensor_count =3D ARRAY_SIZE(sun4i_temp_data),
};

That avoids 1) inconsistencies between the array size and the array
itself, 2) does not require to pad the array with zeroes.

[...]

> @@ -745,9 +752,12 @@ static int sun4i_gpadc_probe(struct platform_device =
*pdev)
>  	pm_runtime_enable(&pdev->dev);
> =20
>  	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> -		info->tzd =3D thermal_zone_of_sensor_register(info->sensor_device,
> -							    0, info,
> -							    &sun4i_ts_tz_ops);
> +		for (i =3D 0; i < info->data->sensor_count; i++) {
> +			info->sensor_id =3D i;
> +			info->tzd =3D thermal_zone_of_sensor_register(
> +					info->sensor_device,
> +					i, info, &sun4i_ts_tz_ops);
> +		}

As Maxime said, this does not work.

One way would be to have a new structure being:
struct sun4i_sensor_info {
	struct sun4i_gpadc_iio	*info;
	unsigned int		sensor_id;
};

Or since we only use the iio_dev within the sun4i_gpadc_iio in the
=2Eget_temp function, we may replace info by struct iio_dev *indio_dev
above.

Quentin

--3vbibixtpc5jv4ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJacg4ZAAoJEIS4mnU+4PGjJjUP/3Lr1j+qOZvBLoK0LaINWZyG
yz6ZleSGki6rplLJcYKDNSppRA2jBSQ3pLi1+XqLOZW33BbXr4bypEzt49zqP+Cn
eyiq3Z2xMOHz7S0kdvQgza41CfCmAhb2PkTVnsAZ9jnbx6I3yo3GO9NGpfz0S0iX
8HWZsG9UVnBOSN8D0SQd0RKoamJWPZSgOUeeVC1b1Q/FqUGx0+3TUAKPPP9WLq8s
iu9bFfEbP1ELOFr38dmpanvspcuOzCvTyWlxotBOLrTpMDNgCM6m3PdygJKybFIn
fKWyfauoDQ3GNGwXnqyinMyeVX3CJWbK0+BedKB5FENdSLH6Yk52znO5w5m6SsgW
ShRAsUUVouSNz7jm468q7fffvlvClOfITf8xnMa8HW8+n+jILhWYn/gtsttK9pPR
B6jgpRBKNif4FwOHT94LAqUVOKZcqNuTBGqdG72Osv2Q+DsXDiekR/Glenp5nm2u
vjHVLmVrgVTjUzB3sgbYapYNk9bKIs6JbUy312ONr1XTFp9Srzoxzs3NZGeqByDC
akg/rChlaef4GmxpKFgzpbIN0lqHK4qZ3G83jQ9m+tteKWZM2X4SfpcNkWGCIj+J
abbILaNy6Mt7Fv3BkAL1TGbGTlLe3fbT3yxejI5oF5t8sGA0lOgoDtvwRaNJJC3l
Hhc5imFqaJ5LjtQdsv0Z
=a+sW
-----END PGP SIGNATURE-----

--3vbibixtpc5jv4ig--
