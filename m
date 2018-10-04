Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA42C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9462098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9462098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJDQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:46:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34883 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDQq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:46:29 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g80KT-0007qY-1p; Thu, 04 Oct 2018 11:53:57 +0200
Message-ID: <1538646836.14153.4.camel@pengutronix.de>
Subject: Re: [PATCH] reset: socfpga: add an early reset driver for SoCFPGA
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     marex@denx.de, linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 11:53:56 +0200
In-Reply-To: <1537195830-25759-1-git-send-email-dinguyen@kernel.org>
References: <1537195830-25759-1-git-send-email-dinguyen@kernel.org>
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

On Mon, 2018-09-17 at 09:50 -0500, Dinh Nguyen wrote:
> Create a separate reset driver that uses the reset operations in reset-simple.
> The reset driver for the SoCFPGA platform needs to register early in order to
> be able bring online timers that needed early in the kernel bootup.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm/mach-socfpga/socfpga.c |  4 ++
>  drivers/reset/Kconfig           |  7 ++++
>  drivers/reset/Makefile          |  1 +
>  drivers/reset/reset-simple.c    | 17 ---------
>  drivers/reset/reset-socfpga.c   | 85 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 97 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/reset/reset-socfpga.c
> 
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index dde14f7..cc64576 100644
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
> index 13d28fd..dcc5f1d 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -119,6 +119,13 @@ config RESET_STM32MP157
>  	help
>  	  This enables the RCC reset controller driver for STM32 MPUs.
>  
> +config RESET_SOCFPGA
> +	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
> +	default ARCH_SOCFPGA
> +	select RESET_SIMPLE
> +	help
> +	  This enables the reset driver for SoCFPGA.
> +
>  config RESET_SUNXI
>  	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
>  	default ARCH_SUNXI
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4243c38..d09bb41 100644
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
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index a91107f..483824f 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -106,21 +106,12 @@ struct reset_simple_devdata {
>  	bool status_active_low;
>  };
>  
> -#define SOCFPGA_NR_BANKS	8
> -
> -static const struct reset_simple_devdata reset_simple_socfpga = {
> -	.reg_offset = 0x10,

Before, the default reg_offset for DTs missing the altr,modrst-offset
property was 0x10 ...

> -	.nr_resets = SOCFPGA_NR_BANKS * 32,
> -	.status_active_low = true,
> -};
> -
[...]
> +static int a10_reset_init(struct device_node *np)
> +{
> +	struct reset_simple_data *data;
> +	struct resource res;
> +	resource_size_t size;
> +	int ret;
> +	u32 reg_offset = 0;

... now it is 0x0.
I think this should be

	u32 reg_offset = 0x10;

to avoid breaking SocFPGA with ancient device trees.

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
> +		pr_warn("missing altr,modrst-offset property, assuming 0x0\n");
> +	data->membase += reg_offset;
> +
> +	spin_lock_init(&data->lock);
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = 32 * 8;

Could we keep the SOCFPGA_NR_BANKS #define to reduce the amount of magic
numbers?

I can make both changes when applying if you want.

regards
Philipp
