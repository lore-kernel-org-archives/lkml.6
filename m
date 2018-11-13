Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E94C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A906D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A906D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbeKNAAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59955 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbeKNAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:52 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gMZGw-0007Hu-7q; Tue, 13 Nov 2018 15:02:30 +0100
Message-ID: <1542117748.4774.9.camel@pengutronix.de>
Subject: Re: [PATCHv3 2/3] reset: socfpga: add an early reset driver for
 SoCFPGA
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>
Date:   Tue, 13 Nov 2018 15:02:28 +0100
In-Reply-To: <20181105200549.17159-2-dinguyen@kernel.org>
References: <20181105200549.17159-1-dinguyen@kernel.org>
         <20181105200549.17159-2-dinguyen@kernel.org>
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

On Mon, 2018-11-05 at 14:05 -0600, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinh.nguyen@intel.com>
> 
> Create a separate reset driver that uses the reset operations in
> reset-simple. The reset driver for the SoCFPGA platform needs to
> register early in order to be able bring online timers that needed
> early in the kernel bootup.
> 
> We do not need this early reset driver for Stratix10, because on
> arm64, Linux does not need the timers are that in reset. Linux is
> able to run just fine with the internal armv8 timer. Thus, we use
> a new binding "altr,stratix10-rst-mgr" for the Stratix10 platform.
> The Stratix10 platform will continue to use the reset-simple platform
> driver, while the 32-bit platforms(Cyclone5/Arria5/Arria10) will use
> the early reset driver.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: use "altr,stratix10-rst-mgr" for Stratix10
>     remove "altr,modrst-offset" from reset-simple
> v2: Do not build separate reset driver for STRATIX10
>     fix warning: symbol 'socfpga_reset_init' was not declared. Should it be
>     static?
> ---
>  arch/arm/mach-socfpga/socfpga.c |  4 ++
>  drivers/reset/Kconfig           |  9 +++-
>  drivers/reset/Makefile          |  1 +
>  drivers/reset/reset-simple.c    | 12 +----
>  drivers/reset/reset-socfpga.c   | 88 +++++++++++++++++++++++++++++++++
>  5 files changed, 103 insertions(+), 11 deletions(-)
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
> index c21da9fe51ec..5d7a3ba445aa 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -109,7 +109,7 @@ config RESET_QCOM_PDC
>  
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
> -	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> +	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>  	help
>  	  This enables a simple reset controller driver for reset lines that
>  	  that can be asserted and deasserted by toggling bits in a contiguous,
> @@ -128,6 +128,13 @@ config RESET_STM32MP157
>  	help
>  	  This enables the RCC reset controller driver for STM32 MPUs.
>  
> +config RESET_SOCFPGA
> +	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
> +	default ARCH_SOCFPGA && !ARCH_STRATIX10

I don't understand the "&& !ARCH_STRATIX10" part.
Isn't ARCH_SOCFPGA disabled anyway when ARCH_STRATIX10 is enabled?

> +	select RESET_SIMPLE
> +	help
> +	  This enables the reset driver for SoCFPGA.
> +
>  config RESET_SUNXI
>  	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
>  	default ARCH_SUNXI
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index d08e8b90046a..b14de32eb610 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
>  obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>  obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
> +obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index a91107fc9e27..f2e7a8c1be65 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -109,7 +109,7 @@ struct reset_simple_devdata {
>  #define SOCFPGA_NR_BANKS	8
>  
>  static const struct reset_simple_devdata reset_simple_socfpga = {
> -	.reg_offset = 0x10,
> +	.reg_offset = 0x20,
>  	.nr_resets = SOCFPGA_NR_BANKS * 32,
>  	.status_active_low = true,
>  };
> @@ -120,7 +120,7 @@ static const struct reset_simple_devdata reset_simple_active_low = {
>  };
>  
>  static const struct of_device_id reset_simple_dt_ids[] = {
> -	{ .compatible = "altr,rst-mgr", .data = &reset_simple_socfpga },
> +	{ .compatible = "altr,stratix10-rst-mgr","altr,rst-mgr", .data = &reset_simple_socfpga },

checkpatch.pl complains about missing whitespace and a long line here.

>  	{ .compatible = "st,stm32-rcc", },
>  	{ .compatible = "allwinner,sun6i-a31-clock-reset",
>  		.data = &reset_simple_active_low },
> @@ -166,14 +166,6 @@ static int reset_simple_probe(struct platform_device *pdev)
>  		data->status_active_low = devdata->status_active_low;
>  	}
>  
> -	if (of_device_is_compatible(dev->of_node, "altr,rst-mgr") &&
> -	    of_property_read_u32(dev->of_node, "altr,modrst-offset",
> -				 &reg_offset)) {
> -		dev_warn(dev,
> -			 "missing altr,modrst-offset property, assuming 0x%x!\n",
> -			 reg_offset);
> -	}
> -
>  	data->membase += reg_offset;
>  
>  	return devm_reset_controller_register(dev, &data->rcdev);
> diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
> new file mode 100644
> index 000000000000..b92769861d2b
> --- /dev/null
> +++ b/drivers/reset/reset-socfpga.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier:	GPL-2.0

I think checkpatch.pl complains about the tab here.

regards
Philipp
