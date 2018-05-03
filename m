Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeECJQB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:16:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40886 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:15:59 -0400
Date: Thu, 3 May 2018 11:15:55 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCHv2] Input: atmel_mxt_ts - fix reset-gpio for level based
 irqs
Message-ID: <20180503091555.wqxlhp7hjnjmzqnj@earth.universe>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
 <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmussu533gbjwhdm"
Content-Disposition: inline
In-Reply-To: <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gmussu533gbjwhdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 23, 2018 at 01:58:44PM +0200, Sebastian Reichel wrote:
> The current reset-gpio support triggers an interrupt storm on platforms
> using the maxtouch with level based interrupt. The Motorola Droid 4,
> which I used for some of the tests is not affected, since it uses a edge
> based interrupt.
>=20
> This change avoids the interrupt storm by enabling the device while its
> interrupt is disabled. Afterwards we wait 100ms. This is important for
> two reasons: The device is unresponsive for some time (~22ms for
> mxt224E) and the CHG (interrupt) line is not working properly for 100ms.
> We don't need to wait for any following interrupts, since the following
> mxt_initialize() checks for bootloader mode anyways.
>=20
> This fixes a boot issue on GE PPD (watchdog kills device due to
> interrupt storm) and does not cause regression on Motorola Droid 4.
>=20
> Fixes: f657b00df22e ("Input: atmel_mxt_ts - add support for reset line")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> Changes since PATCHv2:
>  * fix patch description
>  * use same timeout value for soft and gpio-reset
> ---

ping.

-- Sebastian

>  drivers/input/touchscreen/atmel_mxt_ts.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index 5d9699fe1b55..f97fbb0af020 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -194,6 +194,8 @@ enum t100_type {
> =20
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
> +#define MXT_RESET_GPIO_TIME	20	/* msec */
> +#define MXT_RESET_INVALID_CHG	100	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
> @@ -1206,7 +1208,7 @@ static int mxt_soft_reset(struct mxt_data *data)
>  		return ret;
> =20
>  	/* Ignore CHG line for 100ms after reset */
> -	msleep(100);
> +	msleep(MXT_RESET_INVALID_CHG);
> =20
>  	mxt_acquire_irq(data);
> =20
> @@ -3167,20 +3169,14 @@ static int mxt_probe(struct i2c_client *client, c=
onst struct i2c_device_id *id)
>  		return error;
>  	}
> =20
> +	disable_irq(client->irq);
> +
>  	if (data->reset_gpio) {
> -		data->in_bootloader =3D true;
> -		msleep(MXT_RESET_TIME);
> -		reinit_completion(&data->bl_completion);
> +		msleep(MXT_RESET_GPIO_TIME);
>  		gpiod_set_value(data->reset_gpio, 1);
> -		error =3D mxt_wait_for_completion(data, &data->bl_completion,
> -						MXT_RESET_TIMEOUT);
> -		if (error)
> -			return error;
> -		data->in_bootloader =3D false;
> +		msleep(MXT_RESET_INVALID_CHG);
>  	}
> =20
> -	disable_irq(client->irq);
> -
>  	error =3D mxt_initialize(data);
>  	if (error)
>  		return error;
> --=20
> 2.17.0
>=20

--gmussu533gbjwhdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrq00gACgkQ2O7X88g7
+prp6A//V7922DFL4pcW34WU1oxe4cnnl1vPdWXyW5rh0nOHbrzqwIpiSzRnCtGi
xkp296Rt5Kx80bC+LLhiNwwvtTTvuzwv5ChlRXV05TRscHlN3zRHLQmV9LzePzrw
Zh6+MLmgzmb6eIdOPYrSte/2bgkJe2XJRpC1V3E4p45OLhXMhVnkwCqfPWS0Id4H
Vx/8xLUwSSM4v0HTX/rdQBWKrzwNMxUW1dmS4JYLGtKyqsInPLwT/sB0BtD1StHY
6kR86WXDZQGr65ikGSAvJshur/tqcBya3LXa7FBzbhvAHvdR0mYZiHOZ4fGrEI5D
TH8Roeni01i9PCuGkhseLGZ/BSQZVAWBdpG9jGeB1a2DV9PftkJSMudaV4N8B78Q
qKqVra2OjN3yHpVRt+tMs9RL0DStPxBNE2Bu4I0Ur0nBOsIymMMPrGlnXsgRcjbu
ZbLiAYE07T4xNp7skexFEmA0A+g1qYbRh2ONs538EKKBFPyJATuj+4G8178RvzKv
OiG6UFJsqEPz9+4q+Dq8OQNcEaOeTSTrNdOwFq53gXZST8O37eeQtsQbyciZjpWL
jOAH9q16M/2wCdaM23Kw6HJipRFEgRY3Z7c+sw0gdh7ENJhE/gJWEZACQGOEfHhm
347Ns6tdyPXUKNM2U9AWlG7HD7e9P/fLQuIt16MTD6rUdxuezc8=
=twGv
-----END PGP SIGNATURE-----

--gmussu533gbjwhdm--
