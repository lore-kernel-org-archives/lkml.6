Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeBIMas (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeBIMar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:30:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5110F2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 9 Feb 2018 13:30:44 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: arnd@arndb.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] power: reset: Add Spreadtrum SC27xx PMIC power off
 support
Message-ID: <20180209123044.vjvkb3yfmk4gqfiv@earth.universe>
References: <7655f39d44e804c9ed3209db475567abc250f642.1518169282.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnqw4amogy25fqmo"
Content-Disposition: inline
In-Reply-To: <7655f39d44e804c9ed3209db475567abc250f642.1518169282.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vnqw4amogy25fqmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 09, 2018 at 05:43:38PM +0800, Baolin Wang wrote:
> On Spreadtrum platform, we need power off system through external SC27xx
> series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 chip=
s.
> Thus this patch adds SC27xx series PMICs power-off support.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, queued. My public -next branch is waiting for 4.16-rc1,
though.

-- Sebastian

> Changes since v1:
>  - Add remove interface.
>  - Add regmap checking when probing the driver.
>  - Add MODULE_ALIAS()
> ---
>  drivers/power/reset/Kconfig           |    9 ++++
>  drivers/power/reset/Makefile          |    1 +
>  drivers/power/reset/sc27xx-poweroff.c |   79 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 89 insertions(+)
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
> index 0000000..73d9816
> --- /dev/null
> +++ b/drivers/power/reset/sc27xx-poweroff.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Spreadtrum Communications Inc.
> + * Copyright (C) 2018 Linaro Ltd.
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
> +	if (regmap)
> +		return -EINVAL;
> +
> +	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	pm_power_off =3D sc27xx_poweroff_do_poweroff;
> +	register_syscore_ops(&poweroff_syscore_ops);
> +	return 0;
> +}
> +
> +static int sc27xx_poweroff_remove(struct platform_device *pdev)
> +{
> +	if (pm_power_off =3D=3D sc27xx_poweroff_do_poweroff)
> +		pm_power_off =3D NULL;
> +
> +	regmap =3D NULL;
> +	return 0;
> +}
> +
> +static struct platform_driver sc27xx_poweroff_driver =3D {
> +	.probe =3D sc27xx_poweroff_probe,
> +	.remove =3D sc27xx_poweroff_remove,
> +	.driver =3D {
> +		.name =3D "sc27xx-poweroff",
> +	},
> +};
> +module_platform_driver(sc27xx_poweroff_driver);
> +
> +MODULE_ALIAS("platform:sc27xx-poweroff");
> +MODULE_DESCRIPTION("Spreadtrum SC27xx PMIC Poweroff Driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.7.9.5
>=20

--vnqw4amogy25fqmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9lHQACgkQ2O7X88g7
+prVnA/8DKWrABybJ9RZf2yWNf6uy2tJIaPrPXsFqa7ZF1KvtV+KMLD8dI20N3HI
wtRLzktYrUP6XhrhgptyI4a8gD4zbfHexPU0EvEG5r79EWwdGh4ofYAs9YWPXyMX
hlD0joJTIRTuwOKtjQJ9dOT0aOucqH6D/dxf7U4XqEe6WVtKJFinRWJbkxhc5IxX
3d5gHcAFZNgQlrWW4HQwJKICkiKwV3DNPrzwbkzRw8j3J7oCOMc0Fg4RvNAd9ebR
nKFuQ9snRav0i/BFjbDQkeBeXpYQAQ7mRTd09L48qiSYzNQUlhqXFlcc7MbGuMH2
2DLYYHhJ0RIY5uazZce1q9QGK++HRRN9kCz1UntAgXYs/ST8Se9YdF0D6nNpHokG
e+s49IL+baLzYZ53jdiH51F+CjfxDQzc+sTU34rNqetfQUEOHhJ1a5uDl0CdsqT3
dMUWGeyO5xB7tyBxtVgusrl+m32V0viP4/Ue/5SEgY4FnZ2bwe8yfxc+Ko6uQlxS
bE2ijf7NKjp6vbHFcCf766v8CrfBvCMBdvKZNN2FoNtf39UnQV9v4ZGuj73n5Iaa
/KN2YtnuD3fvOHUEBGF8d9H86podQCWDQoEnt5dfCZ5gkQL+7sBfnHm4ZTwHpA2j
g43TWR4o+Djz+ZqRBx/q5iRro4S+WbAB4+ZL9VLJZ8bTqU1Uqac=
=MCrC
-----END PGP SIGNATURE-----

--vnqw4amogy25fqmo--
