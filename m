Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427129AbeCBLVP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:21:15 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42363 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423201AbeCBLVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:21:05 -0500
X-Google-Smtp-Source: AG47ELv8s5ga429tiLQOSAVfVxz0taXDNWl7QsTRSYoKmCejP1EBAFm1hmBP4mV5YNpYnWknk09udA==
Date: Fri, 2 Mar 2018 12:20:59 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 2/2] watchdog: Add Nuvoton NPCM watchdog driver
Message-ID: <20180302112059.GA27322@gmail.com>
References: <20180302063746.10993-1-joel@jms.id.au>
 <20180302063746.10993-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20180302063746.10993-3-joel@jms.id.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Joel!

On Fri, Mar 02, 2018 at 05:07:46PM +1030, Joel Stanley wrote:
> The Nuvoton NPCM750 has a watchdog implemented as a single register
> inside the timer peripheral.
>=20
> This driver exposes that watchdog as a standard watchdog device with
> coarse timeout intervals, limited by the combination of prescaler and
> counter that is provided by the hardware. The calculation is taken from
> the Nuvoton vendor tree.
>=20
> There is a pre-timeout IRQ that is wired up. This timeout always occurs
> 1024 clocks before the timeout.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/watchdog/Kconfig    |  11 +++
>  drivers/watchdog/Makefile   |   1 +
>  drivers/watchdog/npcm_wdt.c | 223 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/watchdog/npcm_wdt.c
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index aff773bcebdb..0c1cc68894e6 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -513,6 +513,17 @@ config COH901327_WATCHDOG
>  	  This watchdog is used to reset the system and thus cannot be
>  	  compiled as a module.
> =20
> +config NPCM7XX_WATCHDOG
> +	bool "NPCM750 watchdog"

Just asking, we do not want to make it possible to build this as a module?

> +	depends on ARCH_NPCM || COMPILE_TEST
> +	default y if ARCH_NPCM750
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include Watchdog timer support for the
> +	  watchdog embedded into the NPCM7xx.
> +	  This watchdog is used to reset the system and thus cannot be
> +	  compiled as a module.
> +
>  config TWL4030_WATCHDOG
>  	tristate "TWL4030 Watchdog"
>  	depends on TWL4030_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0474d38aa854..97a5afb5cad2 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_ORION_WATCHDOG) +=3D orion_wdt.o
>  obj-$(CONFIG_SUNXI_WATCHDOG) +=3D sunxi_wdt.o
>  obj-$(CONFIG_RN5T618_WATCHDOG) +=3D rn5t618_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) +=3D coh901327_wdt.o
> +obj-$(CONFIG_NPCM7XX_WATCHDOG) +=3D npcm_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) +=3D stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
>  obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> new file mode 100644
> index 000000000000..71e3d4916514
> --- /dev/null
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0

The SPDX identifier `GPL-2.0` is GPLv2 *only*, your MODULE_LICENSE is
"GPLv2 or later". Please make the license info match.


> +// Copyright (c) 2018 Nuvoton Technology corporation.
> +// Copyright (c) 2018 IBM Corp.
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/watchdog.h>
> +#include <asm/fiq.h>
> +#include <linux/of_irq.h>

#include <linux/bitopts.h>

Since you are using BIT()

See Documentation/process/submit-checklist.rst:
1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.


> +
> +#define NPCM_WTCR	0x1C
> +
> +#define NPCM_WTCLK	(BIT(10) | BIT(11))	/* Clock divider */
> +#define NPCM_WTE	BIT(7)			/* Enable */
> +#define NPCM_WTIE	BIT(6)			/* Enable irq */
> +#define NPCM_WTIS	(BIT(4) | BIT(5))	/* Interval selection */
> +#define NPCM_WTIF	BIT(3)			/* Interrupt flag*/
> +#define NPCM_WTRF	BIT(2)			/* Reset flag */
> +#define NPCM_WTRE	BIT(1)			/* Reset enable */
> +#define NPCM_WTR	BIT(0)			/* Reset counter */
> +
> +/*
> + * Watchdog timeouts
> + *
> + * 170     msec:    WTCLK=3D01 WTIS=3D00     VAL=3D 0x400
> + * 670     msec:    WTCLK=3D01 WTIS=3D01     VAL=3D 0x410
> + * 1360    msec:    WTCLK=3D10 WTIS=3D00     VAL=3D 0x800
> + * 2700    msec:    WTCLK=3D01 WTIS=3D10     VAL=3D 0x420
> + * 5360    msec:    WTCLK=3D10 WTIS=3D01     VAL=3D 0x810
> + * 10700   msec:    WTCLK=3D01 WTIS=3D11     VAL=3D 0x430
> + * 21600   msec:    WTCLK=3D10 WTIS=3D10     VAL=3D 0x820
> + * 43000   msec:    WTCLK=3D11 WTIS=3D00     VAL=3D 0xC00
> + * 85600   msec:    WTCLK=3D10 WTIS=3D11     VAL=3D 0x830
> + * 172000  msec:    WTCLK=3D11 WTIS=3D01     VAL=3D 0xC10
> + * 687000  msec:    WTCLK=3D11 WTIS=3D10     VAL=3D 0xC20
> + * 2750000 msec:    WTCLK=3D11 WTIS=3D11     VAL=3D 0xC30
> + */
> +
> +struct npcm_wdt {
> +	struct watchdog_device  wdd;
> +	struct device		*dev;
> +	void __iomem		*reg;
> +};
> +
> +static inline struct npcm_wdt *to_npcm_wdt(struct watchdog_device *wdd)
> +{
> +	return container_of(wdd, struct npcm_wdt, wdd);
> +}
> +
> +static int npcm_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
> +	u32 val;
> +
> +	val =3D readl(wdt->reg);
> +	writel(val | NPCM_WTR, wdt->reg);
> +
> +	return 0;
> +}
> +
> +static int npcm_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
> +	u32 val;
> +
> +	val =3D NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
> +
> +	if (wdd->timeout < 2)
> +		val |=3D 0x800;
> +	else if (wdd->timeout < 3)
> +		val |=3D 0x420;
> +	else if (wdd->timeout < 6)
> +		val |=3D 0x810;
> +	else if (wdd->timeout < 11)
> +		val |=3D 0x430;
> +	else if (wdd->timeout < 22)
> +		val |=3D 0x820;
> +	else if (wdd->timeout < 44)
> +		val |=3D 0xC00;
> +	else if (wdd->timeout < 87)
> +		val |=3D 0x830;
> +	else if (wdd->timeout < 173)
> +		val |=3D 0xC10;
> +	else if (wdd->timeout < 688)
> +		val |=3D 0xC20;
> +	else if (wdd->timeout < 2751)
> +		val |=3D 0xC30;
> +	else
> +		val |=3D 0x830;
> +
> +	writel(val, wdt->reg);
> +
> +	return 0;
> +}
> +
> +static int npcm_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
> +
> +	writel(0, wdt->reg);
> +
> +	return 0;
> +}
> +
> +
> +static int npcm_wdt_set_timeout(struct watchdog_device *wdd,
> +				unsigned int timeout)
> +{
> +	wdd->timeout =3D timeout;     /* New timeout */
> +	if (watchdog_active(wdd))
> +		npcm_wdt_start(wdd);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t npcm_wdt_interrupt(int irq, void *data)
> +{
> +	struct npcm_wdt *wdt =3D data;
> +
> +	watchdog_notify_pretimeout(&wdt->wdd);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int npcm_wdt_restart(struct watchdog_device *wdd,
> +			    unsigned long action, void *data)
> +{
> +	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
> +
> +	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
> +	udelay(1000);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info npcm_wdt_info =3D {
> +	.identity	=3D KBUILD_MODNAME,
> +	.options	=3D WDIOF_SETTIMEOUT
> +			| WDIOF_KEEPALIVEPING
> +			| WDIOF_MAGICCLOSE,
> +};
> +
> +static const struct watchdog_ops npcm_wdt_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.start =3D npcm_wdt_start,
> +	.stop =3D npcm_wdt_stop,
> +	.ping =3D npcm_wdt_ping,
> +	.set_timeout =3D npcm_wdt_set_timeout,
> +	.restart =3D npcm_wdt_restart,
> +};
> +
> +static int npcm_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct npcm_wdt *wdt;
> +	struct resource *res;
> +	int irq;
> +	int ret;
> +
> +	wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdt->reg =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(wdt->reg))
> +		return PTR_ERR(wdt->reg);
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (!irq)
> +		return -EINVAL;
> +
> +	wdt->dev =3D dev;
> +	wdt->wdd.info =3D &npcm_wdt_info;
> +	wdt->wdd.ops =3D &npcm_wdt_ops;
> +	wdt->wdd.min_timeout =3D 1;
> +	wdt->wdd.max_timeout =3D 2751;
> +	wdt->wdd.parent =3D dev;
> +
> +	wdt->wdd.timeout =3D 86;
> +	watchdog_init_timeout(&wdt->wdd, 0, dev);

watchdog_init_timeout() will also read the `timeout-sec` property from
the devicetree if present, which could be a good thing.

See drivers/watchdog/watchdog_core.c for implementation.

Just put it as an optional property in the dt-bindings.

> +
> +	ret =3D devm_request_irq(dev, irq, npcm_wdt_interrupt, 0,
> +			"watchdog", wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_watchdog_register_device(dev, &wdt->wdd);
> +	if (ret) {
> +		dev_err(dev, "failed to register watchdog\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);

Do we need to set drvdata? I don't see that we are using it?

> +	dev_info(dev, "NPCM watchdog driver enabled\n");
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id npcm_wdt_match[] =3D {
> +	{.compatible =3D "nuvoton,npcm750-wdt"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, npcm_wdt_match);
> +#endif
> +
> +static struct platform_driver npcm_wdt_driver =3D {
> +	.probe		=3D npcm_wdt_probe,
> +	.driver		=3D {
> +		.name	=3D "npcm-wdt",
> +		.of_match_table =3D of_match_ptr(npcm_wdt_match),
> +	},
> +};
> +module_platform_driver(npcm_wdt_driver);
> +
> +MODULE_AUTHOR("Joel Stanley");
> +MODULE_DESCRIPTION("Watchdog driver for NPCM");
> +MODULE_LICENSE("GPL");
					^^
Either "GPL v2" here or change SPDX identifier.

> --=20
> 2.15.1


Overall I think it looks good.

Thanks,
Marcus Folkesson

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqZM5YACgkQiIBOb1ld
UjLlAw//T4HCB/jchG929LEFt7YLjJa7APnuCt6Qb7Rfspjj/InwKHRgbVit6OII
X4bY2nVsssdnWI+JjgXBJ3XC92fo0VPjAE8tvyOgHOQpbenkgvMhIfAQBq2LQCOK
5QMV1OdkqpfQx3TFnOJnXor37fYUIJFOwuPqgdn9Ywk6TdaFYaY7TgerAwqFtJd3
7/tfWWhq452SNI94+trVdtubr/PuYL15Z0QNjk5P6zTX91bLabhhdV0oJe5fvoLH
kx+ampJPhtfJmsCklPh/U4Kt0e2iODlJ0b6OTP/3pWDZzHr9kWzL1rGA5Fi9r74r
z58cn1vp8HIgdQ7XE0vBGsPQIcZbAPnyXi/Lrrgmf2sxyx9DD1x+UU4GSornvXgD
IcWq334h5HU+twGZsg+V1bAR+z0Nq/iKFs5/SALeEdLOXmHFS5HUgYdOnaNK32Wm
5SJ/leRJ8zeMYRWjy6/rO43PE33d/t2wiX5E110H5Zpwm2P0Lk2ynfa/DhdZYxFD
gRnIYqYBp92jiTdR3qnKihZ+63oYOIG0quFyBSTTtFLTHJ4sUwRnCG/i70EfEo5l
GQrI3/2/VemXr7VzPeaweNIoqA3D6USJy4qQtwAeyPCn05uTs8pGArg1q6U+ox1F
CkG6MNXyhIyFmT7sCq5SSEWHz1OMGrPV1Veghg0n2XZZH6NK6Gw=
=O+K4
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
