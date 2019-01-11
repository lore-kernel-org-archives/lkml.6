Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6B820660
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547176553;
	bh=GP7Yxy8QOP+6agn6GqxfZavIxV+4koyeXHQsZfKg+P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j6S3l4x58Z4u/roaCyicl2xSS5PfaHX/YY3AZUARMocrSxcLGiYDDEev5c64YUqdx
	 FhkISm6iGiyfd1pTVqbDDBWfMlGocECpwungf/5Os9tFrKqlhVUWuzT7PKwYlO2I6M
	 c9u0MwCMLBz68vruaf0NUbcu6GspE5rOG+0yqZeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfAKDPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfAKDPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:15:48 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363C320660;
        Fri, 11 Jan 2019 03:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547176547;
        bh=GP7Yxy8QOP+6agn6GqxfZavIxV+4koyeXHQsZfKg+P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXLMbhywwpxCi+dQyZwHPOngK0uEDlBVt0lSA6DD9oqAr8TUyhuzb/uZIvvKYD6gc
         J9quu3GFiFVRQO/2HYiqNRnHXYGpmp+sQ5NzmbN4VcDy15zxIqGfGTx1MKd1kOZq0R
         VGocQGboV6Xri88VGLWf2g7WiNp28NqOzLbQ7fhc=
Date:   Fri, 11 Jan 2019 11:15:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: imx: add i.MX7ULP cpuidle support
Message-ID: <20190111031533.GI25218@dragon>
References: <1544775444-31544-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544775444-31544-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 08:23:25AM +0000, Anson Huang wrote:
> This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> states supported as below:
> 
> 1. WFI, just ARM wfi;
> 2. WAIT mode, mapped to SoC's partial stop mode #3;
> 3. STOP mode, mapped to SoC's partial stop mode #1.
> 
> In WAIT mode, system clock and bus clock will be enabled;
> In STOP mode, system clock and bus clock will be disabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/Makefile          |  1 +
>  arch/arm/mach-imx/common.h          | 10 +++++++
>  arch/arm/mach-imx/cpuidle-imx7ulp.c | 60 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/cpuidle.h         |  5 ++++
>  arch/arm/mach-imx/mach-imx7ulp.c    |  7 +++++
>  arch/arm/mach-imx/pm-imx7ulp.c      | 49 ++++++++++++++++++++++++++----
>  6 files changed, 127 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx7ulp.c
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 8af2f7e..12aa44a 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
> +obj-$(CONFIG_SOC_IMX7ULP) += cpuidle-imx7ulp.o
>  endif
>  
>  ifdef CONFIG_SND_IMX_SOC
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index bc915e5..a87fab1 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -72,6 +72,15 @@ enum mxc_cpu_pwr_mode {
>  	STOP_POWER_OFF,		/* STOP + SRPG */
>  };
>  
> +enum ulp_cpu_pwr_mode {
> +	HSRUN,    /* High speed run mode */
> +	RUN,      /* Run mode */
> +	WAIT,     /* Wait mode */
> +	STOP,     /* Stop mode */
> +	VLPS,     /* Very low power stop mode */
> +	VLLS,     /* very low leakage stop mode */

Can we prefix these enums a little bit, like UPL_PM_XXX?

> +};
> +
>  void imx_enable_cpu(int cpu, bool enable);
>  void imx_set_cpu_jump(int cpu, void *jump_addr);
>  u32 imx_get_cpu_arg(int cpu);
> @@ -98,6 +107,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
>  void imx6_set_int_mem_clk_lpm(bool enable);
>  void imx6sl_set_wait_clk(bool enter);
>  int imx_mmdc_get_ddr_type(void);
> +int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
>  
>  void imx_cpu_die(unsigned int cpu);
>  int imx_cpu_kill(unsigned int cpu);
> diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
> new file mode 100644
> index 0000000..a59df93
> --- /dev/null
> +++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017-2018 NXP
> + *   Anson Huang <Anson.Huang@nxp.com>
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <asm/cpuidle.h>
> +
> +#include "common.h"
> +#include "cpuidle.h"
> +
> +static int imx7ulp_enter_wait(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv, int index)
> +{
> +	if (index == 1)
> +		imx7ulp_set_lpm(WAIT);
> +	else
> +		imx7ulp_set_lpm(STOP);
> +
> +	cpu_do_idle();
> +
> +	imx7ulp_set_lpm(RUN);
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver imx7ulp_cpuidle_driver = {
> +	.name = "imx7ulp_cpuidle",
> +	.owner = THIS_MODULE,
> +	.states = {
> +		/* WFI */
> +		ARM_CPUIDLE_WFI_STATE,
> +		/* WAIT */
> +		{
> +			.exit_latency = 50,
> +			.target_residency = 75,
> +			.enter = imx7ulp_enter_wait,
> +			.name = "WAIT",
> +			.desc = "PSTOP2",
> +		},
> +		/* STOP */
> +		{
> +			.exit_latency = 100,
> +			.target_residency = 150,
> +			.enter = imx7ulp_enter_wait,
> +			.name = "STOP",
> +			.desc = "PSTOP1",
> +		},
> +	},
> +	.state_count = 3,
> +	.safe_state_index = 0,
> +};
> +
> +int __init imx7ulp_cpuidle_init(void)
> +{
> +	return cpuidle_register(&imx7ulp_cpuidle_driver, NULL);
> +}
> diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
> index f914012..7694c8f 100644
> --- a/arch/arm/mach-imx/cpuidle.h
> +++ b/arch/arm/mach-imx/cpuidle.h
> @@ -15,6 +15,7 @@ extern int imx5_cpuidle_init(void);
>  extern int imx6q_cpuidle_init(void);
>  extern int imx6sl_cpuidle_init(void);
>  extern int imx6sx_cpuidle_init(void);
> +extern int imx7ulp_cpuidle_init(void);
>  #else
>  static inline int imx5_cpuidle_init(void)
>  {
> @@ -32,4 +33,8 @@ static inline int imx6sx_cpuidle_init(void)
>  {
>  	return 0;
>  }
> +static inline int imx7ulp_cpuidle_init(void)
> +{
> +	return 0;
> +}
>  #endif
> diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
> index 16b295b..95efb2d 100644
> --- a/arch/arm/mach-imx/mach-imx7ulp.c
> +++ b/arch/arm/mach-imx/mach-imx7ulp.c
> @@ -12,6 +12,7 @@
>  #include <asm/mach/arch.h>
>  
>  #include "common.h"
> +#include "cpuidle.h"
>  #include "hardware.h"
>  
>  #define SIM_JTAG_ID_REG		0x8c
> @@ -64,7 +65,13 @@ static const char *const imx7ulp_dt_compat[] __initconst = {
>  	NULL,
>  };
>  
> +static void __init imx7ulp_init_late(void)
> +{
> +	imx7ulp_cpuidle_init();
> +}
> +
>  DT_MACHINE_START(IMX7ulp, "Freescale i.MX7ULP (Device Tree)")
>  	.init_machine	= imx7ulp_init_machine,
>  	.dt_compat	= imx7ulp_dt_compat,
> +	.init_late      = imx7ulp_init_late,

Please use tab instead of space.

>  MACHINE_END
> diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
> index cf6a380..9551e1f 100644
> --- a/arch/arm/mach-imx/pm-imx7ulp.c
> +++ b/arch/arm/mach-imx/pm-imx7ulp.c
> @@ -9,21 +9,60 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  
> +#include "common.h"
> +
>  #define SMC_PMCTRL		0x10
>  #define BP_PMCTRL_PSTOPO        16
>  #define PSTOPO_PSTOP3		0x3
> +#define PSTOPO_PSTOP2		0x2
> +#define PSTOPO_PSTOP1		0x1
> +#define BP_PMCTRL_RUNM          8
> +#define RUNM_RUN                0
> +#define BP_PMCTRL_STOPM         0
> +#define STOPM_STOP              0

Use tab instead space.

Shawn

> +
> +#define BM_PMCTRL_PSTOPO	(3 << BP_PMCTRL_PSTOPO)
> +#define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
> +#define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
> +
> +static void __iomem *smc1_base;
> +
> +int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
> +{
> +	u32 val = readl_relaxed(smc1_base + SMC_PMCTRL);
> +
> +	/* clear all */
> +	val &= ~(BM_PMCTRL_RUNM | BM_PMCTRL_STOPM | BM_PMCTRL_PSTOPO);
> +
> +	switch (mode) {
> +	case RUN:
> +		/* system/bus clock enabled */
> +		val |= PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO;
> +		break;
> +	case WAIT:
> +		/* system clock disabled, bus clock enabled */
> +		val |= PSTOPO_PSTOP2 << BP_PMCTRL_PSTOPO;
> +		break;
> +	case STOP:
> +		/* system/bus clock disabled */
> +		val |= PSTOPO_PSTOP1 << BP_PMCTRL_PSTOPO;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	writel_relaxed(val, smc1_base + SMC_PMCTRL);
> +
> +	return 0;
> +}
>  
>  void __init imx7ulp_pm_init(void)
>  {
>  	struct device_node *np;
> -	void __iomem *smc1_base;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
>  	smc1_base = of_iomap(np, 0);
>  	WARN_ON(!smc1_base);
>  
> -	/* Partial Stop mode 3 with system/bus clock enabled */
> -	writel_relaxed(PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO,
> -		       smc1_base + SMC_PMCTRL);
> -	iounmap(smc1_base);
> +	imx7ulp_set_lpm(RUN);
>  }
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
