Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeCTCOs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:14:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39285 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeCTCOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:14:41 -0400
X-Google-Smtp-Source: AG47ELvDSkQZL+ZZ9ktxlddZ27PV/dGRHAEJXINn5FMrM94MM1R4Yegx0geCo4Bk82ua9ZhsjwgHpA==
Subject: Re: [PATCH 07/14] platform/chrome: chromeos_laptop - factor out
 getting IRQ from DMI
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-8-dmitry.torokhov@gmail.com>
From: Benson Leung <bleung@google.com>
Organization: Google
Message-ID: <b0457b4a-2e0d-41e1-66fe-6fdb7a00f2db@google.com>
Date: Mon, 19 Mar 2018 19:14:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312190907.174301-8-dmitry.torokhov@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dlYvHaRRrc5YvWWytugZMlflSDdlVTHnF"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dlYvHaRRrc5YvWWytugZMlflSDdlVTHnF
Content-Type: multipart/mixed; boundary="LuTV1qYJ0OIWxQXsPAp0Q2i2uV9IXLSGd";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
 linux-kernel@vger.kernel.org
Message-ID: <b0457b4a-2e0d-41e1-66fe-6fdb7a00f2db@google.com>
Subject: Re: [PATCH 07/14] platform/chrome: chromeos_laptop - factor out
 getting IRQ from DMI
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-8-dmitry.torokhov@gmail.com>
In-Reply-To: <20180312190907.174301-8-dmitry.torokhov@gmail.com>

--LuTV1qYJ0OIWxQXsPAp0Q2i2uV9IXLSGd
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable



On 03/12/2018 12:09 PM, Dmitry Torokhov wrote:
> This will make code instantiating I2C device a bit clearer.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to my working branch for atmel_mxt_ts + chromeos_laptop.c for
v4.17. Thanks!

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 35 +++++++++++++++--------=

>  1 file changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platfo=
rm/chrome/chromeos_laptop.c
> index 08ce7a105e768..96e962ff38e87 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -120,36 +120,47 @@ static struct i2c_board_info atmel_1664s_device =3D=
 {
>  	.flags		=3D I2C_CLIENT_WAKE,
>  };
> =20
> +static int chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
> +{
> +	const struct dmi_device *dmi_dev;
> +	const struct dmi_dev_onboard *dev_data;
> +
> +	dmi_dev =3D dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, dmi_name, NULL)=
;
> +	if (!dmi_dev) {
> +		pr_err("failed to find DMI device '%s'\n", dmi_name);
> +		return -ENOENT;
> +	}
> +
> +	dev_data =3D dmi_dev->device_data;
> +	if (!dev_data) {
> +		pr_err("failed to get data from DMI for '%s'\n", dmi_name);
> +		return -EINVAL;
> +	}
> +
> +	return dev_data->instance;
> +}
> +
>  static struct i2c_client *__add_probed_i2c_device(
>  		const char *name,
>  		int bus,
>  		struct i2c_board_info *info,
>  		const unsigned short *alt_addr_list)
>  {
> -	const struct dmi_device *dmi_dev;
> -	const struct dmi_dev_onboard *dev_data;
>  	struct i2c_adapter *adapter;
>  	struct i2c_client *client =3D NULL;
>  	const unsigned short addr_list[] =3D { info->addr, I2C_CLIENT_END };
> =20
>  	if (bus < 0)
>  		return NULL;
> +
>  	/*
>  	 * If a name is specified, look for irq platform information stashed
>  	 * in DMI_DEV_TYPE_DEV_ONBOARD by the Chrome OS custom system firmwar=
e.
>  	 */
>  	if (name) {
> -		dmi_dev =3D dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, name, NULL);
> -		if (!dmi_dev) {
> -			pr_err("failed to dmi find device %s\n", name);
> -			return NULL;
> -		}
> -		dev_data =3D (struct dmi_dev_onboard *)dmi_dev->device_data;
> -		if (!dev_data) {
> -			pr_err("failed to get data from dmi for %s\n", name);
> +		info->irq =3D chromeos_laptop_get_irq_from_dmi(name);
> +		if (info->irq < 0)
>  			return NULL;
> -		}
> -		info->irq =3D dev_data->instance;
>  	}
> =20
>  	adapter =3D i2c_get_adapter(bus);
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org


--LuTV1qYJ0OIWxQXsPAp0Q2i2uV9IXLSGd--

--dlYvHaRRrc5YvWWytugZMlflSDdlVTHnF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwbo4ACgkQHwn1ewov
5liAJxAAhK9G+ughWguu1MaoJd81d1qH8MkSyswBd/HwauytNMWhvuFPyT5Pwi3y
45yzmbiaEX6cD/aaVWbrRb0o+bCIzaZpUlNmGAu48jCOgUipqgNXtS0MJxZrebVr
qRfitl9d6lzA/2ZTStsLxVsJHRVxzLkP2Y6yanIabQI3HQnaYpBZWDvCe3lr71t+
93s3cKsuzSFnC7sbL+61nMkKh515oYI1LWTCJuic4iy//j2R/s5dKepqT5PaZmJN
CaEVJlIRMBEg0YFLci3TCnlyDqdHEJIe5lhNtUISB13cxT8STaKxZyOZ9gmF7zGs
eGUkroKLEghEDz2K98gF+JVidCkirT2YZB0QK8OYZ7p3RDX26CRnn+HuKTCh8Rk3
AK7zZ6Vjosyw3qFugosmwb9hRLeM7JX+0qPpCPVgm/5MC40JxYVzmCOx+CkWRSAI
kID8FO5qjtuvcgw2bd4k6hpaMn5IuENnDy4s+04B1GhFsQxplSxVERuhRs09DX34
QRPd6h9/1gLGxcvq0jp0HTUCojG9L+kRsSabf95iLPsAtUEiBeYMY6ubiPhHl4Tm
BVIwTyY7t93+skg2BpUwmCHEcqUr10pyTXU3b20d0AN7Q4Kv7FzN+0Az8Mfrpx1r
qhQrvGEPA4S3sT8K9Bkb2tJhIwnv0JZW8ngDuk7Nn5ZPBqOHfjw=
=hfra
-----END PGP SIGNATURE-----

--dlYvHaRRrc5YvWWytugZMlflSDdlVTHnF--
