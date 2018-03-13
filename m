Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbeCMQsp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:48:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43692 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeCMQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:48:41 -0400
X-Google-Smtp-Source: AG47ELsC5Y5U8rGeVyvgEczW1vRqIv7EAII3yvGu5wyQcT0ISvIBT3pSe3AotvNG4wjWZam2n/0pKQ==
Date: Tue, 13 Mar 2018 09:48:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 2/2] watchdog: Add Nuvoton NPCM watchdog driver
Message-ID: <20180313164839.GB13835@roeck-us.net>
References: <20180313061726.21601-1-joel@jms.id.au>
 <20180313061726.21601-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313061726.21601-3-joel@jms.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 04:47:26PM +1030, Joel Stanley wrote:
> The Nuvoton NPCM750 has a watchdog implemented as a single register
> inside the timer peripheral.
> 
> This driver exposes that watchdog as a standard watchdog device with
> coarse timeout intervals, limited by the combination of prescaler and
> counter that is provided by the hardware. The calculation is taken from
> the Nuvoton vendor tree.
> 
> The watchdog is left running if a bootloader had it going. The rate is
> the one specified in the device tree, or the default value (obtained
> from the datasheet).
> 
> There is a pre-timeout IRQ that is wired up. This timeout always occurs
> 1024 clocks before the timeout.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>  - Make MODULE_LICENCE gpl v2 to match SPDX
>  - Remove unused struct device pointer
>  - Remove unused setting of drvdata
>  - Add linux/bitops.h
>  - Sort includes
>  - Remove unused fiq include
>  - Update timeout with achieved value
> v3:
>  - Calculate the time and register value separately
>  - Pass device tree value through set_timeout to ensure it can
>    be represented by hardware
> v4:
>  - Propagate return code from platform_get_irq
> ---
>  drivers/watchdog/Kconfig    |  11 ++
>  drivers/watchdog/Makefile   |   1 +
>  drivers/watchdog/npcm_wdt.c | 254 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 266 insertions(+)
>  create mode 100644 drivers/watchdog/npcm_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index aff773bcebdb..0c1cc68894e6 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -513,6 +513,17 @@ config COH901327_WATCHDOG
>  	  This watchdog is used to reset the system and thus cannot be
>  	  compiled as a module.
>  
> +config NPCM7XX_WATCHDOG
> +	bool "Nuvoton NPCM750 watchdog"
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
> @@ -61,6 +61,7 @@ obj-$(CONFIG_ORION_WATCHDOG) += orion_wdt.o
>  obj-$(CONFIG_SUNXI_WATCHDOG) += sunxi_wdt.o
>  obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
> +obj-$(CONFIG_NPCM7XX_WATCHDOG) += npcm_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
>  obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> new file mode 100644
> index 000000000000..0d4213652ecc
> --- /dev/null
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Nuvoton Technology corporation.
> +// Copyright (c) 2018 IBM Corp.
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/watchdog.h>
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
> + * 170     msec:    WTCLK=01 WTIS=00     VAL= 0x400
> + * 670     msec:    WTCLK=01 WTIS=01     VAL= 0x410
> + * 1360    msec:    WTCLK=10 WTIS=00     VAL= 0x800
> + * 2700    msec:    WTCLK=01 WTIS=10     VAL= 0x420
> + * 5360    msec:    WTCLK=10 WTIS=01     VAL= 0x810
> + * 10700   msec:    WTCLK=01 WTIS=11     VAL= 0x430
> + * 21600   msec:    WTCLK=10 WTIS=10     VAL= 0x820
> + * 43000   msec:    WTCLK=11 WTIS=00     VAL= 0xC00
> + * 85600   msec:    WTCLK=10 WTIS=11     VAL= 0x830
> + * 172000  msec:    WTCLK=11 WTIS=01     VAL= 0xC10
> + * 687000  msec:    WTCLK=11 WTIS=10     VAL= 0xC20
> + * 2750000 msec:    WTCLK=11 WTIS=11     VAL= 0xC30
> + */
> +
> +struct npcm_wdt {
> +	struct watchdog_device  wdd;
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
> +	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> +	u32 val;
> +
> +	val = readl(wdt->reg);
> +	writel(val | NPCM_WTR, wdt->reg);
> +
> +	return 0;
> +}
> +
> +static int npcm_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> +	u32 val;
> +
> +	if (wdd->timeout < 2)
> +		val = 0x800;
> +	else if (wdd->timeout < 3)
> +		val = 0x420;
> +	else if (wdd->timeout < 6)
> +		val = 0x810;
> +	else if (wdd->timeout < 11)
> +		val = 0x430;
> +	else if (wdd->timeout < 22)
> +		val = 0x820;
> +	else if (wdd->timeout < 44)
> +		val = 0xC00;
> +	else if (wdd->timeout < 87)
> +		val = 0x830;
> +	else if (wdd->timeout < 173)
> +		val = 0xC10;
> +	else if (wdd->timeout < 688)
> +		val = 0xC20;
> +	else
> +		val = 0xC30;
> +
> +	val |= NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
> +
> +	writel(val, wdt->reg);
> +
> +	return 0;
> +}
> +
> +static int npcm_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
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
> +	if (timeout < 2)
> +		wdd->timeout = 1;
> +	else if (timeout < 3)
> +	      wdd->timeout = 2;
> +	else if (timeout < 6)
> +	      wdd->timeout = 5;
> +	else if (timeout < 11)
> +	      wdd->timeout = 10;
> +	else if (timeout < 22)
> +	      wdd->timeout = 21;
> +	else if (timeout < 44)
> +	      wdd->timeout = 43;
> +	else if (timeout < 87)
> +	      wdd->timeout = 86;
> +	else if (timeout < 173)
> +	      wdd->timeout = 172;
> +	else if (timeout < 688)
> +	      wdd->timeout = 687;
> +	else
> +	      wdd->timeout = 2750;
> +
> +	if (watchdog_active(wdd))
> +		npcm_wdt_start(wdd);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t npcm_wdt_interrupt(int irq, void *data)
> +{
> +	struct npcm_wdt *wdt = data;
> +
> +	watchdog_notify_pretimeout(&wdt->wdd);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int npcm_wdt_restart(struct watchdog_device *wdd,
> +			    unsigned long action, void *data)
> +{
> +	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> +
> +	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
> +	udelay(1000);
> +
> +	return 0;
> +}
> +
> +static bool npcm_is_running(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> +
> +	return readl(wdt->reg) & NPCM_WTE;
> +}
> +
> +static const struct watchdog_info npcm_wdt_info = {
> +	.identity	= KBUILD_MODNAME,
> +	.options	= WDIOF_SETTIMEOUT
> +			| WDIOF_KEEPALIVEPING
> +			| WDIOF_MAGICCLOSE,
> +};
> +
> +static const struct watchdog_ops npcm_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = npcm_wdt_start,
> +	.stop = npcm_wdt_stop,
> +	.ping = npcm_wdt_ping,
> +	.set_timeout = npcm_wdt_set_timeout,
> +	.restart = npcm_wdt_restart,
> +};
> +
> +static int npcm_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct npcm_wdt *wdt;
> +	struct resource *res;
> +	int irq;
> +	int ret;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	wdt->reg = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(wdt->reg))
> +		return PTR_ERR(wdt->reg);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	wdt->wdd.info = &npcm_wdt_info;
> +	wdt->wdd.ops = &npcm_wdt_ops;
> +	wdt->wdd.min_timeout = 1;
> +	wdt->wdd.max_timeout = 2750;
> +	wdt->wdd.parent = dev;
> +
> +	wdt->wdd.timeout = 86;
> +	watchdog_init_timeout(&wdt->wdd, 0, dev);
> +
> +	/* Ensure timeout is able to be represented by the hardware */
> +	npcm_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
> +
> +	if (npcm_is_running(&wdt->wdd)) {
> +		/* Restart with the default or device-tree specified timeout */
> +		npcm_wdt_start(&wdt->wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +
> +	ret = devm_request_irq(dev, irq, npcm_wdt_interrupt, 0,
> +			       "watchdog", wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_watchdog_register_device(dev, &wdt->wdd);
> +	if (ret) {
> +		dev_err(dev, "failed to register watchdog\n");
> +		return ret;
> +	}
> +
> +	dev_info(dev, "NPCM watchdog driver enabled\n");
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id npcm_wdt_match[] = {
> +	{.compatible = "nuvoton,npcm750-wdt"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, npcm_wdt_match);
> +#endif
> +
> +static struct platform_driver npcm_wdt_driver = {
> +	.probe		= npcm_wdt_probe,
> +	.driver		= {
> +		.name	= "npcm-wdt",
> +		.of_match_table = of_match_ptr(npcm_wdt_match),
> +	},
> +};
> +module_platform_driver(npcm_wdt_driver);
> +
> +MODULE_AUTHOR("Joel Stanley");
> +MODULE_DESCRIPTION("Watchdog driver for NPCM");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.15.1
> 
