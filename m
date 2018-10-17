Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B552ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ABC2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ABC2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJQWdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:33:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43203 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJQWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:33:42 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gCmxB-0003F7-Qs; Wed, 17 Oct 2018 16:37:41 +0200
Message-ID: <1539787061.4729.11.camel@pengutronix.de>
Subject: Re: [PATCHv2] reset: socfpga: add an early reset driver for SoCFPGA
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, marex@denx.de
Date:   Wed, 17 Oct 2018 16:37:41 +0200
In-Reply-To: <20181011135241.13614-1-dinguyen@kernel.org>
References: <20181011135241.13614-1-dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

On Thu, 2018-10-11 at 08:52 -0500, Dinh Nguyen wrote:
> Create a separate reset driver that uses the reset operations in
> reset-simple. The reset driver for the SoCFPGA platform needs to
> register early in order to be able bring online timers that needed
> early in the kernel bootup.
> 
> We do not need this early reset driver for Stratix10, because on
> arm64, Linux does not need the timers are that in reset. Linux is
> able to run just fine with the internal armv8 timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: Do not build separate reset driver for STRATIX10
>     fix warning: symbol 'socfpga_reset_init' was not declared. Should
>     it be static?
> ---
>  arch/arm/mach-socfpga/socfpga.c |  4 ++
>  drivers/reset/Kconfig           |  9 +++-
>  drivers/reset/Makefile          |  1 +
>  drivers/reset/reset-socfpga.c   | 88 +++++++++++++++++++++++++++++++++
>  4 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/reset/reset-socfpga.c
> 
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index dde14f7bf2c3..cc64576c102b 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -32,6 +32,8 @@ void __iomem *rst_manager_base_addr;
>  void __iomem *sdr_ctl_base_addr;
>  unsigned long socfpga_cpu1start_addr;
>  
> +extern void __init socfpga_reset_init(void);
> +
>  void __init socfpga_sysmgr_init(void)
>  {
>  	struct device_node *np;
> @@ -64,6 +66,7 @@ static void __init socfpga_init_irq(void)
>  
>  	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
>  		socfpga_init_ocram_ecc();
> +	socfpga_reset_init();
>  }
>  
>  static void __init socfpga_arria10_init_irq(void)
> @@ -74,6 +77,7 @@ static void __init socfpga_arria10_init_irq(void)
>  		socfpga_init_arria10_l2_ecc();
>  	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
>  		socfpga_init_arria10_ocram_ecc();
> +	socfpga_reset_init();
>  }
>  
>  static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 13d28fdbdbb5..f10de5ce4753 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -100,7 +100,7 @@ config RESET_QCOM_AOSS
>  
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
> -	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> +	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>  	help
>  	  This enables a simple reset controller driver for reset lines that
>  	  that can be asserted and deasserted by toggling bits in a contiguous,
> @@ -119,6 +119,13 @@ config RESET_STM32MP157
>  	help
>  	  This enables the RCC reset controller driver for STM32 MPUs.
>  
> +config RESET_SOCFPGA
> +	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
> +	default ARCH_SOCFPGA && !ARCH_STRATIX10
> +	select RESET_SIMPLE
> +	help
> +	  This enables the reset driver for SoCFPGA.
> +
>  config RESET_SUNXI
>  	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
>  	default ARCH_SUNXI
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4243c38228e2..d09bb41273f6 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>  obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>  obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
> +obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
> diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
> new file mode 100644
> index 000000000000..b92769861d2b
> --- /dev/null
> +++ b/drivers/reset/reset-socfpga.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier:	GPL-2.0
> +/*
> + * Copyright (C) 2018, Intel Corporation
> + * Copied from reset-sunxi.c
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "reset-simple.h"
> +
> +#define SOCFPGA_NR_BANKS	8
> +void __init socfpga_reset_init(void);
> +
> +static int a10_reset_init(struct device_node *np)
> +{
> +	struct reset_simple_data *data;
> +	struct resource res;
> +	resource_size_t size;
> +	int ret;
> +	u32 reg_offset = 0x10;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret)
> +		goto err_alloc;
> +
> +	size = resource_size(&res);
> +	if (!request_mem_region(res.start, size, np->name)) {
> +		ret = -EBUSY;
> +		goto err_alloc;
> +	}
> +
> +	data->membase = ioremap(res.start, size);
> +	if (!data->membase) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	if (of_property_read_u32(np, "altr,modrst-offset", &reg_offset))
> +		pr_warn("missing altr,modrst-offset property, assuming 0x10\n");
> +	data->membase += reg_offset;
> +
> +	spin_lock_init(&data->lock);
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = SOCFPGA_NR_BANKS * 32;
> +	data->rcdev.ops = &reset_simple_ops;
> +	data->rcdev.of_node = np;
> +	data->status_active_low = true;
> +
> +	return reset_controller_register(&data->rcdev);
> +
> +err_alloc:
> +	kfree(data);
> +	return ret;
> +};
> +
> +/*
> + * These are the reset controller we need to initialize early on in
> + * our system, before we can even think of using a regular device
> + * driver for it.
> + * The controllers that we can register through the regular device
> + * model are handled by the simple reset driver directly.
> + */
> +static const struct of_device_id socfpga_early_reset_dt_ids[] __initconst = {
> +	{ .compatible = "altr,rst-mgr", },

That doesn't seem right. If you don't remove the altr,rst-mgr compatible
from reset-simple.c anymore, we suddenly have two device drivers for the
same compatible.

(Also I liked removing altr,modrst-offset from reset-simple.c)

Would there be any issue with calling socfpga_reset_init() on Stratix10
as well?

regards
Philipp
