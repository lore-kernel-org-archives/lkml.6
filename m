Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeBHVuS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbeBHVuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:50:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1C921796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 8 Feb 2018 22:50:12 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: arnd@arndb.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: Add Spreadtrum SC27xx PMIC power off
 support
Message-ID: <20180208215012.nrfhnr56r5jeb7vt@earth.universe>
References: <5822b56a4e65e27183f8bf712d5889b11f90111e.1515118527.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iykarmy3iyawpwbu"
Content-Disposition: inline
In-Reply-To: <5822b56a4e65e27183f8bf712d5889b11f90111e.1515118527.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iykarmy3iyawpwbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Mon, Jan 15, 2018 at 03:58:57PM +0800, Baolin Wang wrote:
> On Spreadtrum platform, we need power off system through external SC27xx
> series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 chip=
s.
> Thus this patch adds SC27xx series PMICs power-off support.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/power/reset/Kconfig           |    9 +++++
>  drivers/power/reset/Makefile          |    1 +
>  drivers/power/reset/sc27xx-poweroff.c |   65 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 drivers/power/reset/sc27xx-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index ca0de1a..611ae56 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -227,5 +227,14 @@ config SYSCON_REBOOT_MODE
>  	  register, then the bootloader can read it to take different
>  	  action according to the mode.
> =20
> +config POWER_RESET_SC27XX
> +	tristate "Spreadtrum SC27xx PMIC power-off driver"
> +	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +	help
> +	  This driver supports powering off a system through
> +	  Spreadtrum SC27xx series PMICs. The SC27xx series
> +	  PMICs includes the SC2720, SC2721, SC2723, SC2730
> +	  and SC2731 chips.
> +
>  endif
> =20
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index aeb65ed..225d645 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_POWER_RESET_RMOBILE) +=3D rmobile-reset.o
>  obj-$(CONFIG_POWER_RESET_ZX) +=3D zx-reboot.o
>  obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
> +obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
> diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/=
sc27xx-poweroff.c
> new file mode 100644
> index 0000000..8e4b6a0
> --- /dev/null
> +++ b/drivers/power/reset/sc27xx-poweroff.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 Spreadtrum Communications Inc.
> + * Copyright (c) 2017 Linaro Ltd.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/syscore_ops.h>
> +
> +#define SC27XX_PWR_PD_HW	0xc2c
> +#define SC27XX_PWR_OFF_EN	BIT(0)
> +
> +static struct regmap *regmap;
> +
> +/*
> + * On Spreadtrum platform, we need power off system through external SC2=
7xx
> + * series PMICs, and it is one similar SPI bus mapped by regmap to acces=
s PMIC,
> + * which is not fast io access.
> + *
> + * So before stopping other cores, we need release other cores' resource=
 by
> + * taking cpus down to avoid racing regmap or spi mutex lock when powero=
ff
> + * system through PMIC.
> + */
> +void sc27xx_poweroff_shutdown(void)
> +{
> +	int cpu =3D smp_processor_id();
> +
> +	freeze_secondary_cpus(cpu);
> +}
> +
> +static struct syscore_ops poweroff_syscore_ops =3D {
> +	.shutdown =3D sc27xx_poweroff_shutdown,
> +};
> +
> +static void sc27xx_poweroff_do_poweroff(void)
> +{
> +	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
> +}
> +
> +static int sc27xx_poweroff_probe(struct platform_device *pdev)
> +{

if (regmap)
    return -EINVAL;

> +	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	pm_power_off =3D sc27xx_poweroff_do_poweroff;
> +	register_syscore_ops(&poweroff_syscore_ops);
> +	return 0;
> +}

static void sc27xx_poweroff_remove(struct platform_device *pdev) {
    if (pm_power_off =3D=3D sc27xx_poweroff_do_poweroff)
        pm_power_off =3D NULL;
    regmap =3D NULL;
}

> +static struct platform_driver sc27xx_poweroff_driver =3D {
> +	.probe =3D sc27xx_poweroff_probe,

=2Eremove =3D sc27xx_poweroff_remove,

> +	.driver =3D {
> +		.name =3D "sc27xx-poweroff",
> +	},
> +};
> +module_platform_driver(sc27xx_poweroff_driver);
> +
> +MODULE_DESCRIPTION("Spreadtrum SC27xx PMIC Poweroff Driver");
> +MODULE_LICENSE("GPL v2");

MODULE_ALIAS("platform:sc27xx-poweroff");

Otherwise looks fine.

-- Sebastian

--iykarmy3iyawpwbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp8xhIACgkQ2O7X88g7
+poEDA//eHC0yoKqB98zYGRNNVfp2R5BLk0DwuV9q9yAM7H+1X21ahYNnFTC3KRT
O6yNJnXrKaScqW1aspPhLBBE+Om+nZETjyKBCyIg8lTmWJ/D7cLGoY9vZnBmku6a
NTT5QUyZ3GjQoITIl1kjCTn0bcNbTql/FMTydu1apA4RKONyhu6cam8NY9SJOWuJ
AELag2P2JhQVqgS9icIgt/Mfawq9t7pUDU6APolGqtjN6qMNLVbF+1yFQ0gavtB/
MEKPz2bjzbEF9vvtuG2xGhQtndF491gc4g/9odYw2cJNoy4a6OQ3MzDiqsIE1EDi
sxX1WpKmSysqrhYvluOs6o96KCrjvt+BB4tOV9vCx0hfvA3YMX9K1aXNz+bW66q/
rSnNIVSKSrpe7BWGmOe2Tm3tAZEg1gh1WgVXRGuq+qsyXZxB5r8cQoje5HBCpXDn
9SIg2vGW86ZzfZxtzkUeiV1YMUeBOEoQwj3ESlWGvgrpiQ1f6Gcs9sSAhegYB6Vw
Ox1jBENtTBlkexkmsinuQDZ2sQ+2lqyLgirge6AFGWz5xYUEeU4JU8mOkjU5OuPw
t1UhV2Ye74jpL3OjXQbu3ccisM+vX757Bjt81Msqk3hcDtWpOgvbAc6luRQ1fbSR
YMO8d0Tdpu2dqAMiNY6mPl20hU833Sz+2rOA1BEHz9YtGDw9k8k=
=reCy
-----END PGP SIGNATURE-----

--iykarmy3iyawpwbu--
