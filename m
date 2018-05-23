Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934791AbeEWUDl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:03:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43239 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934458AbeEWUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:03:37 -0400
X-Google-Smtp-Source: AB8JxZqieB7gihmrTGatqyvEicAYItJO2FzZjekAtfdqlYcc1NvzRUQ1HCyWG64I3qRItlP9+lN8VQ==
Date: Wed, 23 May 2018 13:03:33 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Nick Dyer <nick@shmanahar.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: atmel_mxt_ts - require device properties
 present when probing
Message-ID: <20180523200333.GA94820@decatoncale.mtv.corp.google.com>
References: <20180504004135.67554-1-dmitry.torokhov@gmail.com>
 <20180504004135.67554-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20180504004135.67554-2-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 05:41:35PM -0700, Dmitry Torokhov wrote:
> The driver needs help determining whether it is dealing with a touchscreen
> or a touchpad, and with button mapping. Previously we supported passing
> this data via device properties, and also had DMI lists for Chromebooks
> that specified Atmel devices in ACPI, but did not provide enough data
> there. Now that chromeos_laptop driver is adjusted to supply necessary
> device properties even for ACPI devices, we can drop the DMI tables and
> refuse to probe if device properties are not attached to the device.
>=20
> We use presence of "compatible" property to determine if device properties
> are attached to the device or not and rely on chromeos_laptop to re-probe
> the device after attaching missing device properties to it.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good with the chromeos_laptop patch that preceeds this.
Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 152 ++---------------------
>  1 file changed, 12 insertions(+), 140 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index 09194721aed2d..4ac49c6c00060 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2999,142 +2999,6 @@ static int mxt_parse_device_properties(struct mxt=
_data *data)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_ACPI
> -
> -struct mxt_acpi_platform_data {
> -	const char *hid;
> -	const struct property_entry *props;
> -};
> -
> -static unsigned int samus_touchpad_buttons[] =3D {
> -	KEY_RESERVED,
> -	KEY_RESERVED,
> -	KEY_RESERVED,
> -	BTN_LEFT
> -};
> -
> -static const struct property_entry samus_touchpad_props[] =3D {
> -	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", samus_touchpad_buttons),
> -	{ }
> -};
> -
> -static struct mxt_acpi_platform_data samus_platform_data[] =3D {
> -	{
> -		/* Touchpad */
> -		.hid	=3D "ATML0000",
> -		.props	=3D samus_touchpad_props,
> -	},
> -	{
> -		/* Touchscreen */
> -		.hid	=3D "ATML0001",
> -	},
> -	{ }
> -};
> -
> -static unsigned int chromebook_tp_buttons[] =3D {
> -	KEY_RESERVED,
> -	KEY_RESERVED,
> -	KEY_RESERVED,
> -	KEY_RESERVED,
> -	KEY_RESERVED,
> -	BTN_LEFT
> -};
> -
> -static const struct property_entry chromebook_tp_props[] =3D {
> -	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", chromebook_tp_buttons),
> -	{ }
> -};
> -
> -static struct mxt_acpi_platform_data chromebook_platform_data[] =3D {
> -	{
> -		/* Touchpad */
> -		.hid	=3D "ATML0000",
> -		.props	=3D chromebook_tp_props,
> -	},
> -	{
> -		/* Touchscreen */
> -		.hid	=3D "ATML0001",
> -	},
> -	{ }
> -};
> -
> -static const struct dmi_system_id mxt_dmi_table[] =3D {
> -	{
> -		/* 2015 Google Pixel */
> -		.ident =3D "Chromebook Pixel 2",
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Samus"),
> -		},
> -		.driver_data =3D samus_platform_data,
> -	},
> -	{
> -		/* Samsung Chromebook Pro */
> -		.ident =3D "Samsung Chromebook Pro",
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
> -		},
> -		.driver_data =3D samus_platform_data,
> -	},
> -	{
> -		/* Other Google Chromebooks */
> -		.ident =3D "Chromebook",
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> -		},
> -		.driver_data =3D chromebook_platform_data,
> -	},
> -	{ }
> -};
> -
> -static int mxt_prepare_acpi_properties(struct i2c_client *client)
> -{
> -	struct acpi_device *adev;
> -	const struct dmi_system_id *system_id;
> -	const struct mxt_acpi_platform_data *acpi_pdata;
> -
> -	adev =3D ACPI_COMPANION(&client->dev);
> -	if (!adev)
> -		return -ENOENT;
> -
> -	system_id =3D dmi_first_match(mxt_dmi_table);
> -	if (!system_id)
> -		return -ENOENT;
> -
> -	acpi_pdata =3D system_id->driver_data;
> -	if (!acpi_pdata)
> -		return -ENOENT;
> -
> -	while (acpi_pdata->hid) {
> -		if (!strcmp(acpi_device_hid(adev), acpi_pdata->hid)) {
> -			/*
> -			 * Remove previously installed properties if we
> -			 * are probing this device not for the very first
> -			 * time.
> -			 */
> -			device_remove_properties(&client->dev);
> -
> -			/*
> -			 * Now install the platform-specific properties
> -			 * that are missing from ACPI.
> -			 */
> -			device_add_properties(&client->dev, acpi_pdata->props);
> -			break;
> -		}
> -
> -		acpi_pdata++;
> -	}
> -
> -	return 0;
> -}
> -#else
> -static int mxt_prepare_acpi_properties(struct i2c_client *client)
> -{
> -	return -ENOENT;
> -}
> -#endif
> -
>  static const struct dmi_system_id chromebook_T9_suspend_dmi[] =3D {
>  	{
>  		.matches =3D {
> @@ -3155,6 +3019,18 @@ static int mxt_probe(struct i2c_client *client, co=
nst struct i2c_device_id *id)
>  	struct mxt_data *data;
>  	int error;
> =20
> +	/*
> +	 * Ignore devices that do not have device properties attached to
> +	 * them, as we need help determining whether we are dealing with
> +	 * touch screen or touchpad.
> +	 *
> +	 * So far on x86 the only users of Atmel touch controllers are
> +	 * Chromebooks, and chromeos_laptop driver will ensure that
> +	 * necessary properties are provided (if firmware does not do that).
> +	 */
> +	if (!device_property_present(&client->dev, "compatible"))
> +		return -ENXIO;
> +
>  	/*
>  	 * Ignore ACPI devices representing bootloader mode.
>  	 *
> @@ -3186,10 +3062,6 @@ static int mxt_probe(struct i2c_client *client, co=
nst struct i2c_device_id *id)
>  	data->suspend_mode =3D dmi_check_system(chromebook_T9_suspend_dmi) ?
>  		MXT_SUSPEND_T9_CTRL : MXT_SUSPEND_DEEP_SLEEP;
> =20
> -	error =3D mxt_prepare_acpi_properties(client);
> -	if (error && error !=3D -ENOENT)
> -		return error;
> -
>  	error =3D mxt_parse_device_properties(data);
>  	if (error)
>  		return error;
> --=20
> 2.17.0.441.gb46fe60e1d-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsFyRUACgkQHwn1ewov
5ljC8Q/9F97+PS4ap/UdwJuRl/pWbkVJNplRlakxOjsvRcJSckiUxNap4siZ0ULx
+DBZ9saNctLuEtUlfg9pNjojt6+b9xA/wO03MGaHc2UdxB5t/ye2mlxVH8TUf0si
S4mxzhqvLI5HFW17vZ3v3wCvmKj9L4nTuS6Lreng0rLox7Ge8wyCpUIM3AeeCFOw
K4KBAPp0BGW8BLfED2dCLFTe4i4JNHG4ulxb/cyrdvMqTv5MSxSf2gMKzFTXKkVu
R57ZM8mWkGIBKFaXCjpyo/ypmJc7ttUzbl0NXo1o6laH5sDnzTY7mAD1OiXen+Kf
i/wiAHDSZWx1cMuMLyv3lObWKmScv1mdNBQ55FBV7PlGUTZbeolR3qJv1U8gEwO8
X6lINz37RLyQamH8hFOrZigDkbKV+5kh5evwHk8HF7TH1y9ZdGwXKq1rjejdF6VF
CsUHn5F+2v2Ma3QwudYOuipUvFje0a+AtmwyiYqba2BeKwDL4SkYaGpFItOFz3Vv
ny6HpsTg85McQ8yO3maUhA0nt44mMOuh+CCaFExV2qjy2fMuCmB3Yjx8t/V63VOX
LO+0GrPuGo8rOCvt7U1Zr8QgpEOVuT+GsTXg7mf7x1HNKk1f8Z5FC54Z39Fy+Plc
wVPAuIE5Uh85YOG9y2TpzGNhtWWFEQv19eQOGI2IEvClGwVwt2E=
=yAfi
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
