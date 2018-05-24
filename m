Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935198AbeEXABA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:01:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42720 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeEXAA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:00:57 -0400
X-Google-Smtp-Source: AB8JxZraiP4VHVdBbJ6OSj2FaYyA7Slf8XbUxi9ANMMQ7HlIWDTNntknixrjYZl8ZoEWe1jNUbOG0Q==
Date: Wed, 23 May 2018 17:00:52 -0700
From: Benson Leung <bleung@google.com>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform: chrome: Add Tablet Switch ACPI driver
Message-ID: <20180524000052.GA143189@decatoncale.mtv.corp.google.com>
References: <e18c9fba-393e-b075-c518-c88b9e57dc18@google.com>
 <20170130234722.9692-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20170130234722.9692-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

On Mon, Jan 30, 2017 at 03:47:22PM -0800, Gwendal Grignou wrote:
> Add a kernel driver for GOOG0006, an ACPI driver reporting an event when
> the tablet switch status changes.
>=20
> On an ACPI based convertible chromebook check evtest display tablet mode
> switch changes:
> Available devices:
> ..
> /dev/input/event3:      Tablet Mode Switch
> ..
> Testing ... (interrupt to exit)
> Event: time 1484879712.604360, type 5 (EV_SW), code 1 (SW_TABLET_MODE),
> value 1
> Event: time 1484879712.604360, -------------- SYN_REPORT ------------
> Event: time 1484879715.132228, type 5 (EV_SW), code 1 (SW_TABLET_MODE),
> value 0
> Event: time 1484879715.132228, -------------- SYN_REPORT ------------
> ...
> Check state is updated at resume time when different from suspend time.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Sorry for the long delay. This is applied for my working branch for
v4.18.

> ---
> Changes since v2:
>  Rebase on top of linux/master, remove Change-Id
> Changes since v1:
>  Leave tab/space changes in Kconfig to another CL
>  Add resume entry point.
>=20
>  drivers/platform/chrome/Kconfig         |  10 +++
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/chromeos_tbmc.c | 128 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 drivers/platform/chrome/chromeos_tbmc.c
>=20
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kc=
onfig
> index 76bdae1a93bb..a442828e2093 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -38,6 +38,16 @@ config CHROMEOS_PSTORE
>  	  If you have a supported Chromebook, choose Y or M here.
>  	  The module will be called chromeos_pstore.
> =20
> +config CHROMEOS_TBMC
> +	tristate "ChromeOS Tablet Switch Controller"
> +	depends on ACPI
> +	---help---
> +	  This option adds a driver for the tablet switch on
> +	  select Chrome OS systems.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called chromeos_tbmc.
> +
>  config CROS_EC_CHARDEV
>          tristate "Chrome OS Embedded Controller userspace device interfa=
ce"
>          depends on MFD_CROS_EC
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index 4f3462783a3c..d72a15d66f6b 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -1,6 +1,7 @@
> =20
>  obj-$(CONFIG_CHROMEOS_LAPTOP)		+=3D chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)		+=3D chromeos_pstore.o
> +obj-$(CONFIG_CHROMEOS_TBMC)			+=3D chromeos_tbmc.o
>  cros_ec_devs-objs			:=3D cros_ec_dev.o cros_ec_sysfs.o \
>  					   cros_ec_lightbar.o cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_CHARDEV)		+=3D cros_ec_devs.o
> diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/c=
hrome/chromeos_tbmc.c
> new file mode 100644
> index 000000000000..c87e53319dae
> --- /dev/null
> +++ b/drivers/platform/chrome/chromeos_tbmc.c
> @@ -0,0 +1,128 @@
> +/*
> + * chromeos_tbmc - Driver to detect Tablet Mode for ChromeOS convertible.
> + *
> + * Copyright 2017 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * On Chromebook using ACPI, this device listens for notification
> + * from GOOG0006 and issue method TBMC to retrieve the status.
> + *
> + * GOOG0006 issues the notification when it receives EC_HOST_EVENT_MODE_=
CHANGE
> + * from the EC.
> + * Method TBMC reads EC_ACPI_MEM_DEVICE_ORIENTATION byte from the shared
> + * memory region.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +
> +#define DRV_NAME "chromeos_tbmc"
> +#define ACPI_DRV_NAME "GOOG0006"
> +
> +static int chromeos_tbmc_query_switch(struct acpi_device *adev,
> +				     struct input_dev *idev)
> +{
> +	unsigned long long state;
> +	acpi_status status;
> +
> +	status =3D acpi_evaluate_integer(adev->handle, "TBMC", NULL, &state);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	/* input layer checks if event is redundant */
> +	input_report_switch(idev, SW_TABLET_MODE, state);
> +	input_sync(idev);
> +
> +	return 0;
> +}
> +
> +static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
> +{
> +	struct acpi_device *adev =3D to_acpi_device(dev);
> +
> +	return chromeos_tbmc_query_switch(adev, adev->driver_data);
> +}
> +
> +static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
> +{
> +	switch (event) {
> +	case 0x80:
> +		chromeos_tbmc_query_switch(adev, adev->driver_data);
> +		break;
> +	default:
> +		dev_err(&adev->dev, "Unexpected event: 0x%08X\n", event);
> +	}
> +}
> +
> +static int chromeos_tbmc_open(struct input_dev *idev)
> +{
> +	struct acpi_device *adev =3D input_get_drvdata(idev);
> +
> +	return chromeos_tbmc_query_switch(adev, idev);
> +}
> +
> +static int chromeos_tbmc_add(struct acpi_device *adev)
> +{
> +	struct input_dev *idev;
> +	struct device *dev =3D &adev->dev;
> +	int ret;
> +
> +	idev =3D devm_input_allocate_device(dev);
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	idev->name =3D "Tablet Mode Switch";
> +	idev->phys =3D acpi_device_hid(adev);
> +
> +	idev->id.bustype =3D BUS_HOST;
> +	idev->id.version =3D 1;
> +	idev->id.product =3D 0;
> +	idev->open =3D chromeos_tbmc_open;
> +
> +	input_set_drvdata(idev, adev);
> +	adev->driver_data =3D idev;
> +
> +	input_set_capability(idev, EV_SW, SW_TABLET_MODE);
> +	ret =3D input_register_device(idev);
> +	if (ret) {
> +		dev_err(dev, "cannot register input device\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] =3D {
> +	{ ACPI_DRV_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_tbmc_acpi_device_ids);
> +
> +static const SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
> +		chromeos_tbmc_resume);
> +
> +static struct acpi_driver chromeos_tbmc_driver =3D {
> +	.name =3D DRV_NAME,
> +	.class =3D DRV_NAME,
> +	.ids =3D chromeos_tbmc_acpi_device_ids,
> +	.ops =3D {
> +		.add =3D chromeos_tbmc_add,
> +		.notify =3D chromeos_tbmc_notify,
> +	},
> +	.drv.pm =3D &chromeos_tbmc_pm_ops,
> +};
> +
> +module_acpi_driver(chromeos_tbmc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS ACPI tablet switch driver");
> --=20
> 2.11.0.483.g087da7b7c-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsGALQACgkQHwn1ewov
5lhSoxAAiGF0uMDe77Kp7GiHJ4dQIzoWXC/ST3InFyKjcs0NB/D87DP1ghvkGvxb
pM6I2USUhPmRleij25y12dOss2OwV+2ec9o0BAfCkhbg0nMLHwwU6vG8aJG6Qe0f
V9lR95/XyptCeoPYtYPB+RsLMRVExPjdD8hGHcGgSYggG29VgPXu4dVedJo11mvq
oB/m6d5+NgZFfc0hMaYWKh3pioLZWBwcW2eqXEvld7rYgL8IgTAacDww2oxXx1X4
hbZGrf16b7moK2iq+b+3w0ebKQFrqWL73zpL1cICkCmUJ9RbvPdZOpAwSVdpbRFR
xJDm/vC0lZddHUWyVYFXomNHTsYIj2k7MU8GGwzEAXa9sLy0A7NDMsa/5mwuRLRJ
/gXf+JbpMxbTYKP5odbXa/asv+GBNyNwmKR5JfVSaioeRx2LZOngTFx5u61f4AQQ
buUCCS9LdZMna4k/SSIERxMPifjJzbaBOmfFvtA9UIDfimIFYT+8NMWV9UAlhjs+
/PyjMdY8XbXIvDKk1XPEmKhILY1zMaApShR7++hgpbsVJ7NRhH6aJW7HXu3rhaSy
gKLcBP3/n1AIlrlOB5y5taySRNZFwnMVpBjrKJvM48dJGb4V95t0SVi6uhCZQctW
x1OZVWdDI36fMHNySZVz6NEMBnGqcBf094VUWigdgefu8nO7gHE=
=JRm5
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
