Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934782AbeEWTvB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:51:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35741 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbeEWTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:50:55 -0400
X-Google-Smtp-Source: AB8JxZqlmU0X+SDj64E102EuRQ32kn42aVs8jsK/b9X3iBi/lddNvps2ABAymHogwIV0uEJqi53ODg==
Date: Wed, 23 May 2018 12:50:51 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Nick Dyer <nick@shmanahar.org>, linux-kernel@vger.kernel.org,
        bleung@google.com
Subject: Re: [PATCH 1/2] platform/chrome: chromeos_laptop - supply properties
 for ACPI devices
Message-ID: <20180523195051.GA91004@decatoncale.mtv.corp.google.com>
References: <20180504004135.67554-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180504004135.67554-1-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Thu, May 03, 2018 at 05:41:34PM -0700, Dmitry Torokhov wrote:
> BayTrail-based and newer Chromebooks describe their peripherals in ACPI;
> unfortunately their description is not complete, and peripherals
> drivers, such as driver for Atmel Touch controllers, has to resort to
> DMI-matching to configure the peripherals properly. To avoid polluting
> peripheral driver code, let's teach chromeos_laptop driver to supply
> missing data via generic device properties.
>=20
> Note we supply "compatible" string for Atmel peripherals not because it is
> needed for matching devices and driver (matching is still done on ACPI HID
> entries), but because peripherals driver will be using presence of
> "compatible" property to determine if device properties have been attached
> to the device, and fail to bind if they are absent.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good to me. I'll send you an IB with this patch, and you can add
the second.

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 307 ++++++++++++++++++++--
>  1 file changed, 278 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform=
/chrome/chromeos_laptop.c
> index 5c47f451e43b1..3cecf7933f751 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -6,6 +6,7 @@
> =20
>  #define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
> =20
> +#include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
> @@ -54,6 +55,11 @@ struct i2c_peripheral {
>  	struct i2c_client *client;
>  };
> =20
> +struct acpi_peripheral {
> +	char hid[ACPI_ID_LEN];
> +	const struct property_entry *properties;
> +};
> +
>  struct chromeos_laptop {
>  	/*
>  	 * Note that we can't mark this pointer as const because
> @@ -61,6 +67,9 @@ struct chromeos_laptop {
>  	 */
>  	struct i2c_peripheral *i2c_peripherals;
>  	unsigned int num_i2c_peripherals;
> +
> +	const struct acpi_peripheral *acpi_peripherals;
> +	unsigned int num_acpi_peripherals;
>  };
> =20
>  static const struct chromeos_laptop *cros_laptop;
> @@ -148,6 +157,38 @@ static void chromeos_laptop_check_adapter(struct i2c=
_adapter *adapter)
>  	}
>  }
> =20
> +static bool chromeos_laptop_adjust_client(struct i2c_client *client)
> +{
> +	const struct acpi_peripheral *acpi_dev;
> +	struct acpi_device_id acpi_ids[2] =3D { };
> +	int i;
> +	int error;
> +
> +	if (!has_acpi_companion(&client->dev))
> +		return false;
> +
> +	for (i =3D 0; i < cros_laptop->num_acpi_peripherals; i++) {
> +		acpi_dev =3D &cros_laptop->acpi_peripherals[i];
> +
> +		memcpy(acpi_ids[0].id, acpi_dev->hid, ACPI_ID_LEN);
> +
> +		if (acpi_match_device(acpi_ids, &client->dev)) {
> +			error =3D device_add_properties(&client->dev,
> +						      acpi_dev->properties);
> +			if (error) {
> +				dev_err(&client->dev,
> +					"failed to add properties: %d\n",
> +					error);
> +				break;
> +			}
> +
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static void chromeos_laptop_detach_i2c_client(struct i2c_client *client)
>  {
>  	struct i2c_peripheral *i2c_dev;
> @@ -170,6 +211,8 @@ static int chromeos_laptop_i2c_notifier_call(struct n=
otifier_block *nb,
>  	case BUS_NOTIFY_ADD_DEVICE:
>  		if (dev->type =3D=3D &i2c_adapter_type)
>  			chromeos_laptop_check_adapter(to_i2c_adapter(dev));
> +		else if (dev->type =3D=3D &i2c_client_type)
> +			chromeos_laptop_adjust_client(to_i2c_client(dev));
>  		break;
> =20
>  	case BUS_NOTIFY_REMOVED_DEVICE:
> @@ -191,6 +234,12 @@ static const struct chromeos_laptop _name __initcons=
t =3D {		\
>  	.num_i2c_peripherals	=3D ARRAY_SIZE(_name##_peripherals),	\
>  }
> =20
> +#define DECLARE_ACPI_CROS_LAPTOP(_name)					\
> +static const struct chromeos_laptop _name __initconst =3D {		\
> +	.acpi_peripherals	=3D _name##_peripherals,			\
> +	.num_acpi_peripherals	=3D ARRAY_SIZE(_name##_peripherals),	\
> +}
> +
>  static struct i2c_peripheral samsung_series_5_550_peripherals[] __initda=
ta =3D {
>  	/* Touchpad. */
>  	{
> @@ -234,16 +283,25 @@ static const int chromebook_pixel_tp_keys[] __initc=
onst =3D {
> =20
>  static const struct property_entry
>  chromebook_pixel_trackpad_props[] __initconst =3D {
> +	PROPERTY_ENTRY_STRING("compatible", "atmel,maxtouch"),
>  	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", chromebook_pixel_tp_keys),
>  	{ }
>  };
> =20
> +static const struct property_entry
> +chromebook_atmel_touchscreen_props[] __initconst =3D {
> +	PROPERTY_ENTRY_STRING("compatible", "atmel,maxtouch"),
> +	{ }
> +};
> +
>  static struct i2c_peripheral chromebook_pixel_peripherals[] __initdata =
=3D {
>  	/* Touch Screen. */
>  	{
>  		.board_info	=3D {
>  			I2C_BOARD_INFO("atmel_mxt_ts",
>  					ATMEL_TS_I2C_ADDR),
> +			.properties	=3D
> +				chromebook_atmel_touchscreen_props,
>  			.flags		=3D I2C_CLIENT_WAKE,
>  		},
>  		.dmi_name	=3D "touchscreen",
> @@ -354,6 +412,8 @@ static struct i2c_peripheral acer_c720_peripherals[] =
__initdata =3D {
>  		.board_info	=3D {
>  			I2C_BOARD_INFO("atmel_mxt_ts",
>  					ATMEL_TS_I2C_ADDR),
> +			.properties	=3D
> +				chromebook_atmel_touchscreen_props,
>  			.flags		=3D I2C_CLIENT_WAKE,
>  		},
>  		.dmi_name	=3D "touchscreen",
> @@ -419,6 +479,47 @@ static struct i2c_peripheral cr48_peripherals[] __in=
itdata =3D {
>  };
>  DECLARE_CROS_LAPTOP(cr48);
> =20
> +static const u32 samus_touchpad_buttons[] __initconst =3D {
> +	KEY_RESERVED,
> +	KEY_RESERVED,
> +	KEY_RESERVED,
> +	BTN_LEFT
> +};
> +
> +static const struct property_entry samus_trackpad_props[] __initconst =
=3D {
> +	PROPERTY_ENTRY_STRING("compatible", "atmel,maxtouch"),
> +	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", samus_touchpad_buttons),
> +	{ }
> +};
> +
> +static struct acpi_peripheral samus_peripherals[] __initdata =3D {
> +	/* Touchpad */
> +	{
> +		.hid		=3D "ATML0000",
> +		.properties	=3D samus_trackpad_props,
> +	},
> +	/* Touchsceen */
> +	{
> +		.hid		=3D "ATML0001",
> +		.properties	=3D chromebook_atmel_touchscreen_props,
> +	},
> +};
> +DECLARE_ACPI_CROS_LAPTOP(samus);
> +
> +static struct acpi_peripheral generic_atmel_peripherals[] __initdata =3D=
 {
> +	/* Touchpad */
> +	{
> +		.hid		=3D "ATML0000",
> +		.properties	=3D chromebook_pixel_trackpad_props,
> +	},
> +	/* Touchsceen */
> +	{
> +		.hid		=3D "ATML0001",
> +		.properties	=3D chromebook_atmel_touchscreen_props,
> +	},
> +};
> +DECLARE_ACPI_CROS_LAPTOP(generic_atmel);
> +
>  static const struct dmi_system_id chromeos_laptop_dmi_table[] __initcons=
t =3D {
>  	{
>  		.ident =3D "Samsung Series 5 550",
> @@ -502,17 +603,64 @@ static const struct dmi_system_id chromeos_laptop_d=
mi_table[] __initconst =3D {
>  		},
>  		.driver_data =3D (void *)&cr48,
>  	},
> +	/* Devices with peripherals incompletely described in ACPI */
> +	{
> +		.ident =3D "Chromebook Pro",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
> +		},
> +		.driver_data =3D (void *)&samus,
> +	},
> +	{
> +		.ident =3D "Google Pixel 2 (2015)",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Samus"),
> +		},
> +		.driver_data =3D (void *)&samus,
> +	},
> +	{
> +		/*
> +		 * Other Chromebooks with Atmel touch controllers:
> +		 * - Celes, Winky (touchpad)
> +		 * - Clapper, Expresso, Rambi, Glimmer (touchscreen)
> +		 */
> +		.ident =3D "Other Chromebook",
> +		.matches =3D {
> +			/*
> +			 * This will match all Google devices, not only devices
> +			 * with Atmel, but we will validate that the device
> +			 * actually has matching peripherals.
> +			 */
> +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> +		},
> +		.driver_data =3D (void *)&generic_atmel,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dmi, chromeos_laptop_dmi_table);
> =20
> -static int __init chromeos_laptop_scan_adapter(struct device *dev, void =
*data)
> +static int __init chromeos_laptop_scan_peripherals(struct device *dev, v=
oid *data)
>  {
> -	struct i2c_adapter *adapter;
> +	int error;
> =20
> -	adapter =3D i2c_verify_adapter(dev);
> -	if (adapter)
> -		chromeos_laptop_check_adapter(adapter);
> +	if (dev->type =3D=3D &i2c_adapter_type) {
> +		chromeos_laptop_check_adapter(to_i2c_adapter(dev));
> +	} else if (dev->type =3D=3D &i2c_client_type) {
> +		if (chromeos_laptop_adjust_client(to_i2c_client(dev))) {
> +			/*
> +			 * Now that we have needed properties re-trigger
> +			 * driver probe in case driver was initialized
> +			 * earlier and probe failed.
> +			 */
> +			error =3D device_attach(dev);
> +			if (error < 0)
> +				dev_warn(dev,
> +					 "%s: device_attach() failed: %d\n",
> +					 __func__, error);
> +		}
> +	}
> =20
>  	return 0;
>  }
> @@ -556,27 +704,24 @@ static int __init chromeos_laptop_setup_irq(struct =
i2c_peripheral *i2c_dev)
>  	return 0;
>  }
> =20
> -static struct chromeos_laptop * __init
> -chromeos_laptop_prepare(const struct chromeos_laptop *src)
> +static int __init
> +chromeos_laptop_prepare_i2c_peripherals(struct chromeos_laptop *cros_lap=
top,
> +					const struct chromeos_laptop *src)
>  {
> -	struct chromeos_laptop *cros_laptop;
>  	struct i2c_peripheral *i2c_dev;
>  	struct i2c_board_info *info;
> -	int error;
>  	int i;
> +	int error;
> =20
> -	cros_laptop =3D kzalloc(sizeof(*cros_laptop), GFP_KERNEL);
> -	if (!cros_laptop)
> -		return ERR_PTR(-ENOMEM);
> +	if (!src->num_i2c_peripherals)
> +		return 0;
> =20
>  	cros_laptop->i2c_peripherals =3D kmemdup(src->i2c_peripherals,
>  					       src->num_i2c_peripherals *
>  						sizeof(*src->i2c_peripherals),
>  					       GFP_KERNEL);
> -	if (!cros_laptop->i2c_peripherals) {
> -		error =3D -ENOMEM;
> -		goto err_free_cros_laptop;
> -	}
> +	if (!cros_laptop->i2c_peripherals)
> +		return -ENOMEM;
> =20
>  	cros_laptop->num_i2c_peripherals =3D src->num_i2c_peripherals;
> =20
> @@ -586,7 +731,7 @@ chromeos_laptop_prepare(const struct chromeos_laptop =
*src)
> =20
>  		error =3D chromeos_laptop_setup_irq(i2c_dev);
>  		if (error)
> -			goto err_destroy_cros_peripherals;
> +			goto err_out;
> =20
>  		/* We need to deep-copy properties */
>  		if (info->properties) {
> @@ -594,14 +739,14 @@ chromeos_laptop_prepare(const struct chromeos_lapto=
p *src)
>  				property_entries_dup(info->properties);
>  			if (IS_ERR(info->properties)) {
>  				error =3D PTR_ERR(info->properties);
> -				goto err_destroy_cros_peripherals;
> +				goto err_out;
>  			}
>  		}
>  	}
> =20
> -	return cros_laptop;
> +	return 0;
> =20
> -err_destroy_cros_peripherals:
> +err_out:
>  	while (--i >=3D 0) {
>  		i2c_dev =3D &cros_laptop->i2c_peripherals[i];
>  		info =3D &i2c_dev->board_info;
> @@ -609,13 +754,74 @@ chromeos_laptop_prepare(const struct chromeos_lapto=
p *src)
>  			property_entries_free(info->properties);
>  	}
>  	kfree(cros_laptop->i2c_peripherals);
> -err_free_cros_laptop:
> -	kfree(cros_laptop);
> -	return ERR_PTR(error);
> +	return error;
> +}
> +
> +static int __init
> +chromeos_laptop_prepare_acpi_peripherals(struct chromeos_laptop *cros_la=
ptop,
> +					const struct chromeos_laptop *src)
> +{
> +	struct acpi_peripheral *acpi_peripherals;
> +	struct acpi_peripheral *acpi_dev;
> +	const struct acpi_peripheral *src_dev;
> +	int n_peripherals =3D 0;
> +	int i;
> +	int error;
> +
> +	for (i =3D 0; i < src->num_acpi_peripherals; i++) {
> +		if (acpi_dev_present(src->acpi_peripherals[i].hid, NULL, -1))
> +			n_peripherals++;
> +	}
> +
> +	if (!n_peripherals)
> +		return 0;
> +
> +	acpi_peripherals =3D kcalloc(n_peripherals,
> +				   sizeof(*src->acpi_peripherals),
> +				   GFP_KERNEL);
> +	if (!acpi_peripherals)
> +		return -ENOMEM;
> +
> +	acpi_dev =3D acpi_peripherals;
> +	for (i =3D 0; i < src->num_acpi_peripherals; i++) {
> +		src_dev =3D &src->acpi_peripherals[i];
> +		if (!acpi_dev_present(src_dev->hid, NULL, -1))
> +			continue;
> +
> +		*acpi_dev =3D *src_dev;
> +
> +		/* We need to deep-copy properties */
> +		if (src_dev->properties) {
> +			acpi_dev->properties =3D
> +				property_entries_dup(src_dev->properties);
> +			if (IS_ERR(acpi_dev->properties)) {
> +				error =3D PTR_ERR(acpi_dev->properties);
> +				goto err_out;
> +			}
> +		}
> +
> +		acpi_dev++;
> +	}
> +
> +	cros_laptop->acpi_peripherals =3D acpi_peripherals;
> +	cros_laptop->num_acpi_peripherals =3D n_peripherals;
> +
> +	return 0;
> +
> +err_out:
> +	while (--i >=3D 0) {
> +		acpi_dev =3D &acpi_peripherals[i];
> +		if (acpi_dev->properties)
> +			property_entries_free(acpi_dev->properties);
> +	}
> +
> +	kfree(acpi_peripherals);
> +	return error;
>  }
> =20
>  static void chromeos_laptop_destroy(const struct chromeos_laptop *cros_l=
aptop)
>  {
> +	const struct acpi_peripheral *acpi_dev;
>  	struct i2c_peripheral *i2c_dev;
>  	struct i2c_board_info *info;
>  	int i;
> @@ -631,10 +837,41 @@ static void chromeos_laptop_destroy(const struct ch=
romeos_laptop *cros_laptop)
>  			property_entries_free(info->properties);
>  	}
> =20
> +	for (i =3D 0; i < cros_laptop->num_acpi_peripherals; i++) {
> +		acpi_dev =3D &cros_laptop->acpi_peripherals[i];
> +
> +		if (acpi_dev->properties)
> +			property_entries_free(acpi_dev->properties);
> +	}
> +
>  	kfree(cros_laptop->i2c_peripherals);
> +	kfree(cros_laptop->acpi_peripherals);
>  	kfree(cros_laptop);
>  }
> =20
> +static struct chromeos_laptop * __init
> +chromeos_laptop_prepare(const struct chromeos_laptop *src)
> +{
> +	struct chromeos_laptop *cros_laptop;
> +	int error;
> +
> +	cros_laptop =3D kzalloc(sizeof(*cros_laptop), GFP_KERNEL);
> +	if (!cros_laptop)
> +		return ERR_PTR(-ENOMEM);
> +
> +	error =3D chromeos_laptop_prepare_i2c_peripherals(cros_laptop, src);
> +	if (!error)
> +		error =3D chromeos_laptop_prepare_acpi_peripherals(cros_laptop,
> +								 src);
> +
> +	if (error) {
> +		chromeos_laptop_destroy(cros_laptop);
> +		return ERR_PTR(error);
> +	}
> +
> +	return cros_laptop;
> +}
> +
>  static int __init chromeos_laptop_init(void)
>  {
>  	const struct dmi_system_id *dmi_id;
> @@ -652,21 +889,33 @@ static int __init chromeos_laptop_init(void)
>  	if (IS_ERR(cros_laptop))
>  		return PTR_ERR(cros_laptop);
> =20
> +	if (!cros_laptop->num_i2c_peripherals &&
> +	    !cros_laptop->num_acpi_peripherals) {
> +		pr_debug("no relevant devices detected\n");
> +		error =3D -ENODEV;
> +		goto err_destroy_cros_laptop;
> +	}
> +
>  	error =3D bus_register_notifier(&i2c_bus_type,
>  				      &chromeos_laptop_i2c_notifier);
>  	if (error) {
> -		pr_err("failed to register i2c bus notifier: %d\n", error);
> -		chromeos_laptop_destroy(cros_laptop);
> -		return error;
> +		pr_err("failed to register i2c bus notifier: %d\n",
> +		       error);
> +		goto err_destroy_cros_laptop;
>  	}
> =20
>  	/*
> -	 * Scan adapters that have been registered before we installed
> -	 * the notifier to make sure we do not miss any devices.
> +	 * Scan adapters that have been registered and clients that have
> +	 * been created before we installed the notifier to make sure
> +	 * we do not miss any devices.
>  	 */
> -	i2c_for_each_dev(NULL, chromeos_laptop_scan_adapter);
> +	i2c_for_each_dev(NULL, chromeos_laptop_scan_peripherals);
> =20
>  	return 0;
> +
> +err_destroy_cros_laptop:
> +	chromeos_laptop_destroy(cros_laptop);
> +	return error;
>  }
> =20
>  static void __exit chromeos_laptop_exit(void)
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

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsFxhsACgkQHwn1ewov
5ljeOw//fV13AuqMUIUTueaFnRGb5n/bei2haCEPb/cvv/dZXkrbqBeMCEzDWTms
MYVrjDL2Ii+2zp9oCAsUpJmViaHMWvgaAQvSn6zbBEd8yEaZnpizKyOvc7s2/ieE
lZfGfO83e8H2Rg1BdsPx0QOdr63dna4JJ8hRg5C42NYrGS4ThtGvesMSaMGnA/km
344j/fx2ehDgyc+f3UAwtVZVheyrHFOsTnQfwL4rmEsBlfTnntzMSkNdPU3MbOcI
2v9ZpEpiwgMQYvBfWalbyziSQ2c/dLOjP/ihtGpmrwfDTx9e6i6Ut/QnXlCHfFyM
CPHBufkMM3cQ7fpWI8gBhinhldBV5sXWQ2kwbt6RSKfmShfds7aBuTlm1ppWXo4y
wYPZtaam0YjHQBZziaLtfVb9PfrpycE2fkCttmREK8wJfzZ2ZUVvy40bT+7x2mK0
HwG+3jYo8N/GQF4XwvD6TnYQhMsEGfMu5njwA0Y3uDhf7RZ1xSWAtaqJjaEaEd9x
kdYKR+MHYzgTyjxaGXetq4RELF/h8UI6gVnlrg8++yZEPdmijmumypxX2uIWk2le
Y/cSW/yzHE0gkLRBI+VHeJidd5NS4B0QW83SdHIevw+b9nxajfdV8vnE1I8XKh9H
KJ6+baOAZm3wuJ3Q9WQ/lMPbsVe/OG2B8Y4obUPlljrSD+enfJ0=
=PQH/
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
