Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C71ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6B820C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6B820C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbeGQORS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:17:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:38824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731554AbeGQORS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:17:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B1C5ADAB;
        Tue, 17 Jul 2018 13:44:31 +0000 (UTC)
Date:   Tue, 17 Jul 2018 15:45:27 +0200
From:   Michael Moese <mmoese@suse.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: add driver for the MEN 16z069 IP-Core
Message-ID: <20180717134527.mokciutlsuyrqhsf@linux-d8ym>
References: <20180716072510.6939-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716072510.6939-1-jthumshirn@suse.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:25:10AM +0200, Johannes Thumshirn wrote:
> Add a driver for the MEN 16z069 Watchdog and Reset Controller IP-Core.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Michael Moese <mmoese@suse.de>

> 
> ---
> Changes to v1:
> * Sorted includes alphabetically
> * Indented defines with tabs
> * Removed unnecessary timeout validation
> * Removed unnecessary masking of values
> * Fixed error return in .probe
> * Directly accessed drv->wdt
> * Removed leftover timeout resetting
> ---
>  MAINTAINERS                   |   6 ++
>  drivers/watchdog/Kconfig      |  10 +++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/menz69_wdt.c | 170 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 187 insertions(+)
>  create mode 100644 drivers/watchdog/menz69_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07d1576fc766..67a76f740294 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9298,6 +9298,12 @@ F:	drivers/leds/leds-menf21bmc.c
>  F:	drivers/hwmon/menf21bmc_hwmon.c
>  F:	Documentation/hwmon/menf21bmc
>  
> +MEN Z069 WATCHDOG DRIVER
> +M:	Johannes Thumshirn <jth@kernel.org>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	drivers/watchdog/menz069_wdt.c
> +
>  MESON AO CEC DRIVER FOR AMLOGIC SOCS
>  M:	Neil Armstrong <narmstrong@baylibre.com>
>  L:	linux-media@lists.freedesktop.org
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd92763..df55d65bbb1c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -161,6 +161,16 @@ config MENF21BMC_WATCHDOG
>  	  This driver can also be built as a module. If so the module
>  	  will be called menf21bmc_wdt.
>  
> +config MENZ069_WATCHDOG
> +	tristate "MEN 16Z069 Watchdog"
> +	depends on MCB || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the MEN 16Z069 Watchdog.
> +
> +	  This driver can also be built as a module. If so the module
> +	  will be called menz069_wdt.
> +
>  config TANGOX_WATCHDOG
>  	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>  	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 1d3c6b094fe5..bf92e7bf9ce0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -215,4 +215,5 @@ obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
>  obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
>  obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>  obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
> +obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
> diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
> new file mode 100644
> index 000000000000..ed18238c5407
> --- /dev/null
> +++ b/drivers/watchdog/menz69_wdt.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Watchdog driver for the MEN z069 IP-Core
> + *
> + * Copyright (C) 2018 Johannes Thumshirn <jth@kernel.org>
> + */
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mcb.h>
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +
> +struct men_z069_drv {
> +	struct watchdog_device wdt;
> +	void __iomem *base;
> +	struct resource *mem;
> +};
> +
> +#define MEN_Z069_WTR			0x10
> +#define MEN_Z069_WTR_WDEN		BIT(15)
> +#define MEN_Z069_WTR_WDET_MASK		0x7fff
> +#define MEN_Z069_WVR			0x14
> +
> +#define MEN_Z069_TIMER_FREQ		500 /* 500 Hz */
> +#define MEN_Z069_WDT_COUNTER_MIN	1
> +#define MEN_Z069_WDT_COUNTER_MAX	0x7fff
> +#define MEN_Z069_DEFAULT_TIMEOUT	30
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			    __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int men_z069_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 val;
> +
> +	val = readw(drv->base + MEN_Z069_WTR);
> +	val |= MEN_Z069_WTR_WDEN;
> +	writew(val, drv->base + MEN_Z069_WTR);
> +
> +	return 0;
> +}
> +
> +static int men_z069_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 val;
> +
> +	val = readw(drv->base + MEN_Z069_WTR);
> +	val &= ~MEN_Z069_WTR_WDEN;
> +	writew(val, drv->base + MEN_Z069_WTR);
> +
> +	return 0;
> +}
> +
> +static int men_z069_wdt_ping(struct watchdog_device *wdt)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 val;
> +
> +	/* The watchdog trigger value toggles between 0x5555 and 0xaaaa */
> +	val = readw(drv->base + MEN_Z069_WVR);
> +	val ^= 0xffff;
> +	writew(val, drv->base + MEN_Z069_WVR);
> +
> +	return 0;
> +}
> +
> +static int men_z069_wdt_set_timeout(struct watchdog_device *wdt,
> +				    unsigned int timeout)
> +{
> +	struct men_z069_drv *drv = watchdog_get_drvdata(wdt);
> +	u16 reg, val, ena;
> +
> +	wdt->timeout = timeout;
> +	val = timeout * MEN_Z069_TIMER_FREQ;
> +
> +	reg = readw(drv->base + MEN_Z069_WVR);
> +	ena = reg & MEN_Z069_WTR_WDEN;
> +	reg = ena | val;
> +	writew(reg, drv->base + MEN_Z069_WTR);
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info men_z069_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "MEN z069 Watchdog",
> +};
> +
> +static const struct watchdog_ops men_z069_ops = {
> +	.owner = THIS_MODULE,
> +	.start = men_z069_wdt_start,
> +	.stop = men_z069_wdt_stop,
> +	.ping = men_z069_wdt_ping,
> +	.set_timeout = men_z069_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device men_z069_wdt = {
> +	.info = &men_z069_info,
> +	.ops = &men_z069_ops,
> +	.timeout = MEN_Z069_DEFAULT_TIMEOUT,
> +	.min_timeout = 1,
> +	.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ,
> +};
> +
> +static int men_z069_probe(struct mcb_device *dev,
> +			  const struct mcb_device_id *id)
> +{
> +	struct men_z069_drv *drv;
> +	struct resource *mem;
> +
> +	drv = devm_kzalloc(&dev->dev, sizeof(struct men_z069_drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	mem = mcb_request_mem(dev, "z069-wdt");
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
> +
> +	drv->base = devm_ioremap(&dev->dev, mem->start, resource_size(mem));
> +	if (drv->base == NULL)
> +		goto release_mem;
> +
> +	drv->mem = mem;
> +
> +	drv->wdt = men_z069_wdt;
> +	watchdog_init_timeout(&drv->wdt, 0, &dev->dev);
> +	watchdog_set_nowayout(&drv->wdt, nowayout);
> +	watchdog_set_drvdata(&drv->wdt, drv);
> +	drv->wdt.parent = &dev->dev;
> +	mcb_set_drvdata(dev, drv);
> +
> +	return watchdog_register_device(&men_z069_wdt);
> +
> +release_mem:
> +	mcb_release_mem(mem);
> +	return -ENOMEM;
> +}
> +
> +static void men_z069_remove(struct mcb_device *dev)
> +{
> +	struct men_z069_drv *drv = mcb_get_drvdata(dev);
> +
> +	watchdog_unregister_device(&drv->wdt);
> +	mcb_release_mem(drv->mem);
> +}
> +
> +static const struct mcb_device_id men_z069_ids[] = {
> +	{ .device = 0x45 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(mcb, men_z069_ids);
> +
> +static struct mcb_driver men_z069_driver = {
> +	.driver = {
> +		.name = "z069-wdt",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = men_z069_probe,
> +	.remove = men_z069_remove,
> +	.id_table = men_z069_ids,
> +};
> +module_mcb_driver(men_z069_driver);
> +
> +MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("mcb:16z069");
> -- 
> 2.16.4
> 

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
