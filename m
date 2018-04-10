Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDJFoQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:44:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37679 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeDJFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:44:14 -0400
X-Google-Smtp-Source: AIpwx495qq+CFp92hJNFxdlHRUAW6HRGzX/Jd2GjU2L48brstUoHbpsHgdqg75EhSF/aEyn4Sr3wTw==
Date: Mon, 9 Apr 2018 22:44:10 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] Input: atmel_mxt_ts - do not pass suspend mode
 in platform data
Message-ID: <20180410054410.GA22032@decatoncale.mtv.corp.google.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
 <20180320223138.234724-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20180320223138.234724-2-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 03:31:25PM -0700, Dmitry Torokhov wrote:
> The way we are supposed to put controller to sleep and wake it up does not
> depend on the platform, but rather on controller itself, so we want to get
> rid of suspend mode in platform data (and eventually get rid of platform
> data completely). Unfortunately some early chromebooks (the original Pixe=
l,
> Acer C720) were shipped with config that requires manually re-enabling
> touch reporting in T9. We will sort it out, but in the meantime let's
> switch to a simple DMI quirk.
>=20
> We'll keep pdata->suspend_mode for now and remove it when we rework
> chromeos-laptop driver.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thanks.

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 27 +++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index 7659bc48f1db8..20e1224d1a6db 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -324,6 +324,8 @@ struct mxt_data {
> =20
>  	/* for config update handling */
>  	struct completion crc_completion;
> +
> +	enum mxt_suspend_mode suspend_mode;
>  };
> =20
>  struct mxt_vb2_buffer {
> @@ -2868,7 +2870,7 @@ static const struct attribute_group mxt_attr_group =
=3D {
> =20
>  static void mxt_start(struct mxt_data *data)
>  {
> -	switch (data->pdata->suspend_mode) {
> +	switch (data->suspend_mode) {
>  	case MXT_SUSPEND_T9_CTRL:
>  		mxt_soft_reset(data);
> =20
> @@ -2886,12 +2888,11 @@ static void mxt_start(struct mxt_data *data)
>  		mxt_t6_command(data, MXT_COMMAND_CALIBRATE, 1, false);
>  		break;
>  	}
> -
>  }
> =20
>  static void mxt_stop(struct mxt_data *data)
>  {
> -	switch (data->pdata->suspend_mode) {
> +	switch (data->suspend_mode) {
>  	case MXT_SUSPEND_T9_CTRL:
>  		/* Touch disable */
>  		mxt_write_object(data,
> @@ -2954,8 +2955,6 @@ static const struct mxt_platform_data *mxt_parse_dt=
(struct i2c_client *client)
>  		pdata->t19_keymap =3D keymap;
>  	}
> =20
> -	pdata->suspend_mode =3D MXT_SUSPEND_DEEP_SLEEP;
> -
>  	return pdata;
>  }
>  #else
> @@ -3109,6 +3108,21 @@ mxt_get_platform_data(struct i2c_client *client)
>  	return ERR_PTR(-EINVAL);
>  }
> =20
> +static const struct dmi_system_id chromebook_T9_suspend_dmi[] =3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Link"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Peppy"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static int mxt_probe(struct i2c_client *client, const struct i2c_device_=
id *id)
>  {
>  	struct mxt_data *data;
> @@ -3135,6 +3149,9 @@ static int mxt_probe(struct i2c_client *client, con=
st struct i2c_device_id *id)
>  	init_completion(&data->reset_completion);
>  	init_completion(&data->crc_completion);
> =20
> +	data->suspend_mode =3D dmi_check_system(chromebook_T9_suspend_dmi) ?
> +		MXT_SUSPEND_T9_CTRL : MXT_SUSPEND_DEEP_SLEEP;
> +
>  	data->reset_gpio =3D devm_gpiod_get_optional(&client->dev,
>  						   "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(data->reset_gpio)) {
> --=20
> 2.16.2.804.g6dcf76e118-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlrMTyoACgkQHwn1ewov
5lhXbw/9G7OUulc7ZrGcBq+qmQuqMCcCeQ2j6IqdUnlQaHjt7FBiRy6DNeiaGD9u
MtiwMNswYgaAr1Ql4Yut8XNLfO/LZ60DKXKo3oREQtWDYytRBRE8IVV73X9Gtfdz
TfNYj7Oyj4r0BulYjjhy0ctDlz/wK5bP/AeD6lCK4vIoRixHu/Mt+WKHMbWyx60M
uq5oFplVW30AIp+d1YOE55ed7c8zp9EB8V0C68TLIEwEI3XffpYYC8LWaW90EgYx
x6njkOK8Iu5ZZrRlUYj6cW0ODVlSKJPom68OwJmWyZDGChYQzcbunLRg5vG4pBAO
QrMCo1sgK+h3ZVxcwFnUlFBz0za8zcQtggmaOkx7ji3TK3MhnnsysBgnF9pNXgHQ
q/UZmNi8sJVAluElA0EGxv7g4EYa6fRNqQz8vv0nrDZ+pUe+0joo4IOw2OdWULZl
nLBy04JLlR87ZG4LU1mGd7XrE+RZYhWThsbbVhwjaErcobDdT/4729BLZ4d3zw2f
ijBtwqzu8WD/6YHarJUSgdRd7JMEEXGzowAnh/nhYPWl2fbJwp/c3JMIEY7/9KNo
al/K2ywX87UWBjnRbKsUsDubsNUDPNcvUDeu0S6enKn4HRaWKMdzegcY4gX850vi
7et5O8uD2GUeHU0sWzL9ngbkFijVSNLY0ieL7PKN74cg53LxKJE=
=P3be
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
