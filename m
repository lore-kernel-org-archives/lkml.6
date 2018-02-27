Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeB0GvE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:51:04 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:33618 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB0GvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:51:02 -0500
X-Google-Smtp-Source: AG47ELti4no3rCcfrwTHBAO15Xc/BWb4+J2pzyK+64ENCLhtWWEEIC6TRWvsbO0hMTOhPM0798590A==
Date: Mon, 26 Feb 2018 22:50:58 -0800
From: Benson Leung <bleung@google.com>
To: Wenkai Du <wenkai.du@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, Archana Patni <archana.patni@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] Revert "mfd: cros_ec: Add ACPI GPE handler for LID0
 devices"
Message-ID: <20180227065058.GC171936@decatoncale.mtv.corp.google.com>
References: <20180222213052.126692-1-wenkai.du@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20180222213052.126692-1-wenkai.du@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 01:30:52PM -0800, Wenkai Du wrote:
> This reverts commit e04653a9dcf4d98defe2149c885382e5cc72082f.
>=20
> It is no longer needed to install Chrome EC GPE handler to have
> GPE enabled in suspend to idle path. It is found that with this
> handler installed, EC wake up doesn't work because default EC
> event handler that can wake up system is not getting called.
>=20
> Signed-off-by: Wenkai Du <wenkai.du@intel.com>

Acked-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/mfd/Makefile           |   1 -
>  drivers/mfd/cros_ec.c          |  15 ++----
>  drivers/mfd/cros_ec_acpi_gpe.c | 103 -----------------------------------=
------
>  include/linux/mfd/cros_ec.h    |  18 -------
>  4 files changed, 3 insertions(+), 134 deletions(-)
>  delete mode 100644 drivers/mfd/cros_ec_acpi_gpe.c
>=20
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index d9d2cf0d32ef..e9fd20dba18d 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_MFD_ASIC3)		+=3D asic3.o tmio_core.o
>  obj-$(CONFIG_MFD_BCM590XX)	+=3D bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+=3D bd9571mwv.o
>  cros_ec_core-objs		:=3D cros_ec.o
> -cros_ec_core-$(CONFIG_ACPI)	+=3D cros_ec_acpi_gpe.o
>  obj-$(CONFIG_MFD_CROS_EC)	+=3D cros_ec_core.o
>  obj-$(CONFIG_MFD_CROS_EC_I2C)	+=3D cros_ec_i2c.o
>  obj-$(CONFIG_MFD_CROS_EC_SPI)	+=3D cros_ec_spi.o
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index d61024141e2b..c221163d5b9e 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -173,8 +173,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> =20
>  	dev_info(dev, "Chrome EC device registered\n");
> =20
> -	cros_ec_acpi_install_gpe_handler(dev);
> -
>  	return 0;
> =20
>  fail_mfd:
> @@ -188,8 +186,6 @@ int cros_ec_remove(struct cros_ec_device *ec_dev)
>  {
>  	mfd_remove_devices(ec_dev->dev);
> =20
> -	cros_ec_acpi_remove_gpe_handler();
> -
>  	if (ec_dev->irq)
>  		free_irq(ec_dev->irq, ec_dev);
> =20
> @@ -204,14 +200,9 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  	int ret;
>  	u8 sleep_event;
> =20
> -	if (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) {
> -		sleep_event =3D HOST_SLEEP_EVENT_S3_SUSPEND;
> -	} else {
> -		sleep_event =3D HOST_SLEEP_EVENT_S0IX_SUSPEND;
> -
> -		/* Clearing the GPE status for any pending event */
> -		cros_ec_acpi_clear_gpe();
> -	}
> +	sleep_event =3D (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware())=
 ?
> +		      HOST_SLEEP_EVENT_S3_SUSPEND :
> +		      HOST_SLEEP_EVENT_S0IX_SUSPEND;
> =20
>  	ret =3D cros_ec_sleep_event(ec_dev, sleep_event);
>  	if (ret < 0)
> diff --git a/drivers/mfd/cros_ec_acpi_gpe.c b/drivers/mfd/cros_ec_acpi_gp=
e.c
> deleted file mode 100644
> index 56d305dab2d4..000000000000
> --- a/drivers/mfd/cros_ec_acpi_gpe.c
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -/*
> - * ChromeOS EC multi-function device
> - *
> - * Copyright (C) 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * The ChromeOS EC multi function device is used to mux all the requests
> - * to the EC device for its multiple features: keyboard controller,
> - * battery charging and regulator control, firmware update.
> - */
> -#include <linux/acpi.h>
> -
> -#define ACPI_LID_DEVICE      "LID0"
> -
> -static int ec_wake_gpe =3D -EINVAL;
> -
> -/*
> - * This handler indicates to ACPI core that this GPE should stay enabled=
 for
> - * lid to work in suspend to idle path.
> - */
> -static u32 cros_ec_gpe_handler(acpi_handle gpe_device, u32 gpe_number,
> -			       void *data)
> -{
> -	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
> -}
> -
> -/*
> - * Get ACPI GPE for LID0 device.
> - */
> -static int cros_ec_get_ec_wake_gpe(struct device *dev)
> -{
> -	struct acpi_device *cros_acpi_dev;
> -	struct acpi_device *adev;
> -	acpi_handle handle;
> -	acpi_status status;
> -	int ret;
> -
> -	cros_acpi_dev =3D ACPI_COMPANION(dev);
> -
> -	if (!cros_acpi_dev || !cros_acpi_dev->parent ||
> -	   !cros_acpi_dev->parent->handle)
> -		return -EINVAL;
> -
> -	status =3D acpi_get_handle(cros_acpi_dev->parent->handle, ACPI_LID_DEVI=
CE,
> -				 &handle);
> -	if (ACPI_FAILURE(status))
> -		return -EINVAL;
> -
> -	ret =3D acpi_bus_get_device(handle, &adev);
> -	if (ret)
> -		return ret;
> -
> -	return adev->wakeup.gpe_number;
> -}
> -
> -int cros_ec_acpi_install_gpe_handler(struct device *dev)
> -{
> -	acpi_status status;
> -
> -	ec_wake_gpe =3D cros_ec_get_ec_wake_gpe(dev);
> -
> -	if (ec_wake_gpe < 0)
> -		return ec_wake_gpe;
> -
> -	status =3D acpi_install_gpe_handler(NULL, ec_wake_gpe,
> -					  ACPI_GPE_EDGE_TRIGGERED,
> -					  &cros_ec_gpe_handler, NULL);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> -
> -	dev_info(dev, "Initialized, GPE =3D 0x%x\n", ec_wake_gpe);
> -
> -	return 0;
> -}
> -
> -void cros_ec_acpi_remove_gpe_handler(void)
> -{
> -	acpi_status status;
> -
> -	if (ec_wake_gpe < 0)
> -		return;
> -
> -	status =3D acpi_remove_gpe_handler(NULL, ec_wake_gpe,
> -						 &cros_ec_gpe_handler);
> -	if (ACPI_FAILURE(status))
> -		pr_err("failed to remove gpe handler\n");
> -}
> -
> -void cros_ec_acpi_clear_gpe(void)
> -{
> -	if (ec_wake_gpe < 0)
> -		return;
> -
> -	acpi_clear_gpe(NULL, ec_wake_gpe);
> -}
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index c61535979b8f..23af6806bc07 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -326,22 +326,4 @@ extern struct attribute_group cros_ec_vbc_attr_group;
>  int cros_ec_debugfs_init(struct cros_ec_dev *ec);
>  void cros_ec_debugfs_remove(struct cros_ec_dev *ec);
> =20
> -/* ACPI GPE handler */
> -#ifdef CONFIG_ACPI
> -
> -int cros_ec_acpi_install_gpe_handler(struct device *dev);
> -void cros_ec_acpi_remove_gpe_handler(void);
> -void cros_ec_acpi_clear_gpe(void);
> -
> -#else /* CONFIG_ACPI */
> -
> -static inline int cros_ec_acpi_install_gpe_handler(struct device *dev)
> -{
> -	return -ENODEV;
> -}
> -static inline void cros_ec_acpi_remove_gpe_handler(void) {}
> -static inline void cros_ec_acpi_clear_gpe(void) {}
> -
> -#endif /* CONFIG_ACPI */
> -
>  #endif /* __LINUX_MFD_CROS_EC_H */
> --=20
> 2.16.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqU/9EACgkQHwn1ewov
5lhi1w/+OY4lRytvhCv6KYjjgEmIEFHgZJIWRspTL5pmF7AsitvJF9mFZD+XI4xC
kIMt8lEKcuaOmCyVBahNgglIwRBpUqJChqEnJhWyYPVb3yov9RW7ZXsy0o83cvCa
bNSLdbFk7ZzepqguugpAAD0U0AhUJRdkaKPFNjtYXeFnK8RufokgGGyk/hJJOoPe
0ULbZDPucnUdvwB+5qhqtncKxh6JyFOMSwx14jSz6QBchCVXM9j3ttqW2E++4UU3
YYKwnqqz+pkkvizh9CZHYglowMInrwBdzqss63UOHUeIgkw86dQhF1AR8MHwAATm
abYVuOGyP1PDtmo9tK4VesMJicVFWP0v/CdnQpL/m0rgqorSCfZwIBI1pjIqFlDH
XyXeQH5o7Sfcr959eUA3h0V9dbff1a8WFLNe/6xTaT4LHckQ4mZgsXRM+qLkBrE/
WT7wQyE9ZIdLD2Ir9oBj/a7KQzJDP626Ywr+giSdGqjK3Oxaz81lNgOyoI+fMbGq
4nd1kSEJp+oa/69CgNQyL3gc6T5n5aPGZqTbrJhg+EbHBBVCZ7qhnRckQlizaC4n
YDHr7bISn+Rxnv8/zye0t+ZTdcggzKR+QEOht+cJV+umly2SYnEWG9IGiE+EWP3a
p+sYrIUKSl3BFHdHGznj7u6yG23NKtQdDLF0q2OAzbgSrFDhbXk=
=PwcG
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
