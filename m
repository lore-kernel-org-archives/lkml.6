Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbeCIQNj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCIQNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:13:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A33020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 9 Mar 2018 17:13:35 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] power: reset: Add Spreadtrum SC27xx PMIC power off
 support
Message-ID: <20180309161335.5bbcht4kryfnuelf@earth.universe>
References: <e3284d38862fe26f2414850734c0985f07c4b970.1519611418.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gudylc6r46erilaj"
Content-Disposition: inline
In-Reply-To: <e3284d38862fe26f2414850734c0985f07c4b970.1519611418.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gudylc6r46erilaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2018 at 10:23:14AM +0800, Baolin Wang wrote:
> On Spreadtrum platform, we need power off system through external SC27xx
> series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 chip=
s.
> Thus this patch adds SC27xx series PMICs power-off support.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, queued.

-- Sebastian

> Changes since v3:
>  - Add CONFIG_PM_SLEEP_SMP macro to avoid building error.
>=20
> Changes since v2:
>  - Change to build-in this driver.
>=20
> Changes since v1:
>  - Add remove interface.
>  - Add regmap checking when probing the driver.
>  - Add MODULE_ALIAS()
> ---
>  drivers/power/reset/Kconfig           |    9 +++++
>  drivers/power/reset/Makefile          |    1 +
>  drivers/power/reset/sc27xx-poweroff.c |   66 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 drivers/power/reset/sc27xx-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index ca0de1a..01543f5 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -227,5 +227,14 @@ config SYSCON_REBOOT_MODE
>  	  register, then the bootloader can read it to take different
>  	  action according to the mode.
> =20
> +config POWER_RESET_SC27XX
> +	bool "Spreadtrum SC27xx PMIC power-off driver"
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
> index 0000000..65c477e
> --- /dev/null
> +++ b/drivers/power/reset/sc27xx-poweroff.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Spreadtrum Communications Inc.
> + * Copyright (C) 2018 Linaro Ltd.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/kernel.h>
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
> +#ifdef CONFIG_PM_SLEEP_SMP
> +	int cpu =3D smp_processor_id();
> +
> +	freeze_secondary_cpus(cpu);
> +#endif
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
> +static struct platform_driver sc27xx_poweroff_driver =3D {
> +	.probe =3D sc27xx_poweroff_probe,
> +	.driver =3D {
> +		.name =3D "sc27xx-poweroff",
> +	},
> +};
> +builtin_platform_driver(sc27xx_poweroff_driver);
> --=20
> 1.7.9.5
>=20

--gudylc6r46erilaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqisq4ACgkQ2O7X88g7
+poP1Q//Ri6QL/gs9WYwMs9/uva9cyxEmpWL5JdofNVyRBVu0TIK2m0cY+FJhbqM
OL3csv6ZIZLBljXbyM7nrW2wnjIvQ7H4PMZUATN09BWttY8rmNJC/g7+BNrR0vkc
QJvSAnKK36OE6edf/jHO0FiY2nKSxa9Oeh2tpkCwwT+uURvIdIRGaEP53Xjuym6H
VP7b6I7M3cAbeRIwgov4cXBLCQtbVaI4rKiChZKuYLxjZ8iRqBW2TAGpXVWkX9Hv
Aw3E7SNKhp8hmlj5GHhUw82qdKOJlCgckoAyCQg0+xmwb/A9lJJh6APYoLm0FXeu
V+PabeTt95uJRHVGJ0KrXaNTl2MnCMVV2eBSvdWbuRPFovNqKidl3oUZXrPDcAqG
9AQH0UO9cVT/HNmlBZ+/2uWjIYx3pwDbGy5Do0tAAdWMZzNw3ki4Yk0ej+P/fKYZ
OBnlbcAITnr4ZMvU1n9iavw4c8bDHciBMcbLfHREWKhYNCNvq1pQOIi/yCEmkYM8
P9jy6qUpou0n38ltnLBvvQvfadyYR3lnAk7roPv9fWXdg13391U64q3FDQqjdCAB
bUgRbVl5CGPblgFWQ/xXZjmK65XQJUr4oIJITW3yfU7vO+bv+IrEjPyqMa/2Z026
sxOFRJkwf02SDM92YPG6qGknJzB5oPVFxgD3Hcrlxavo7kg0KJA=
=lzCS
-----END PGP SIGNATURE-----

--gudylc6r46erilaj--
