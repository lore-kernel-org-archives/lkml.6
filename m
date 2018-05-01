Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbeEAMjN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755044AbeEAMjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:39:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75FD23677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Tue, 1 May 2018 14:39:08 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
Subject: Re: [PATCH] power: supply: ltc2941-battery-gauge: Release
 device_node in ltc294x_i2c_probe()
Message-ID: <20180501123908.z3kuokp2b6umnnda@earth.universe>
References: <1524954955-22107-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kuhuojlpjaaa5a35"
Content-Disposition: inline
In-Reply-To: <1524954955-22107-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kuhuojlpjaaa5a35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 29, 2018 at 01:35:55AM +0300, Alexey Khoroshilov wrote:
> There is of_node_get(client->dev.of_node) in ltc294x_i2c_probe(),
> but these is no of_node_put() somethere in the driver.
>=20
> The patch adds one on error and normal paths.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

That is ugly. Let's replace of_property_read_u32(np, ...) with
device_property_read_u32(dev, ...) and get rid of np instead.

-- Sebastian

> ---
>  drivers/power/supply/ltc2941-battery-gauge.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 4f129bb4c972..7854a89b3332 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -481,7 +481,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,
>  	if (ret < 0) {
>  		dev_err(&client->dev,
>  			"Could not find lltc,resistor-sense in devicetree\n");
> -		return ret;
> +		goto err_node_put;
>  	}
>  	info->r_sense =3D r_sense;
> =20
> @@ -511,7 +511,7 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,
>  		if (ret < 0) {
>  			dev_err(&client->dev,
>  				"Could not read status register\n");
> -			return ret;
> +			goto err_node_put;
>  		}
>  		if (status & LTC2941_REG_STATUS_CHIP_ID)
>  			info->id =3D LTC2941_ID;
> @@ -550,19 +550,25 @@ static int ltc294x_i2c_probe(struct i2c_client *cli=
ent,
>  	ret =3D ltc294x_reset(info, prescaler_exp);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Communication with chip failed\n");
> -		return ret;
> +		goto err_node_put;
>  	}
> =20
>  	info->supply =3D power_supply_register(&client->dev, &info->supply_desc,
>  					     &psy_cfg);
>  	if (IS_ERR(info->supply)) {
>  		dev_err(&client->dev, "failed to register ltc2941\n");
> -		return PTR_ERR(info->supply);
> +		ret =3D PTR_ERR(info->supply);
> +		goto err_node_put;
>  	} else {
>  		schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
>  	}
> =20
> +	of_node_put(np);
>  	return 0;
> +
> +err_node_put:
> +	of_node_put(np);
> +	return ret;
>  }
> =20
>  static void ltc294x_i2c_shutdown(struct i2c_client *client)
> --=20
> 2.7.4
>=20

--kuhuojlpjaaa5a35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlroX+kACgkQ2O7X88g7
+poV0BAAi4dAjSWDCcaOjeHgbegF/18j70Houp2ZYV1VzG9IFEuvuBrbqRI+iT0a
kaXa1OntGJnXmG9zTAMMfUSn+qo5kKYmEPOiAe1U5MSUX+a6M99yr6VMdMPDIz+q
U1+680CkB0h9lWYc25n5Gya2UX34ahDSUMiFGqXrO6ka64tcAv64c+UzIxvCdDxs
dZmt1OiFxZPi3rmChi/3mHYjUPIqJmtD9j37Jgg/rKwK7mYMECISIB9c2oohw4uD
UUVK6zD8UYOquzC63N28knZtL+oQ3MSNoKrg62xp6BMeiZLiQASBLR3BMjhAF3TK
s58mlqsi4v7FfpXsX+RCLH7ucdt8fIAC4XFMtHEMTARsoChLU1AtgMKSxo5YsQ04
H1lFQMbohnAXIq5aKQZAneoq4jskGU47a/fc6dTrefPFRgD3ZruaduU6d5h849q9
VJcwCNG4VlyXtUqZ3PDlDctxb4PCdHse1YXlkr+mhK3HC0BJYtwlE40cH5qDALzq
9EKvGwVTTnSuid0IKPR5fMrKITcqyJBcbTdsL+0k6NHIY5LftD9/2eHIQygIkWv6
Em+XHwxJPPrt/jbxd3rRwjfQFrnjZeSG44z8NoZsOqNqJUesOyqQF4Pca8lj2oTC
nnFghNNNgOgjXI6f2VCCCCUAcqopsmcm+HYS0zN1uZl2rYVt9Ak=
=HVD9
-----END PGP SIGNATURE-----

--kuhuojlpjaaa5a35--
