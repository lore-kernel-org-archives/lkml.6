Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754664AbeBATW1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:22:27 -0500
Received: from vern.gendns.com ([206.190.152.46]:53960 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753129AbeBATWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:22:17 -0500
Subject: Re: [PATCH v6 04/41] clk: davinci: Add platform information for TI
 DA850 PLL
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-5-git-send-email-david@lechnology.com>
From: David Lechner <david@lechnology.com>
Message-ID: <7d7e0522-30d5-6232-853e-7ab32fadfe48@lechnology.com>
Date: Thu, 1 Feb 2018 13:22:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516468460-4908-5-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/20/2018 11:13 AM, David Lechner wrote:
> This adds platform-specific declarations for the PLL clocks on TI DA850/
> OMAP-L138/AM18XX SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v6 changes:
> - Added da850_pll{0,1}_info with controller-specific information
> - Added OBSCLK data
> - Add empty lines between function calls
> 
>   drivers/clk/davinci/Makefile    |   1 +
>   drivers/clk/davinci/pll-da850.c | 163 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/clk/davinci.h     |   1 +
>   3 files changed, 165 insertions(+)
>   create mode 100644 drivers/clk/davinci/pll-da850.c
> 
> diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
> index 9061e19..13049d4 100644
> --- a/drivers/clk/davinci/Makefile
> +++ b/drivers/clk/davinci/Makefile
> @@ -3,4 +3,5 @@
>   ifeq ($(CONFIG_COMMON_CLK), y)
>   obj-y += pll.o
>   obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
> +obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
>   endif
> diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
> new file mode 100644
> index 0000000..a94e1a6
> --- /dev/null
> +++ b/drivers/clk/davinci/pll-da850.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PLL clock descriptions for TI DA850/OMAP-L138/AM18XX
> + *
> + * Copyright (C) 2018 David Lechner <david@lechnology.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/da8xx-cfgchip.h>
> +#include <linux/of.h>
> +#include <linux/types.h>
> +
> +#include "pll.h"
> +
> +#define OCSEL_OCSRC_OSCIN		0x14
> +#define OCSEL_OCSRC_PLL0_SYSCLK(n)	(0x16 + (n))
> +#define OCSEL_OCSRC_PLL1_OBSCLK		0x1e
> +#define OCSEL_OCSRC_PLL1_SYSCLK(n)	(0x16 + (n))
> +
> +static const struct davinci_pll_clk_info da850_pll0_info __initconst = {
> +	.name = "pll0",
> +	.unlock_reg = CFGCHIP(0),
> +	.unlock_mask = CFGCHIP0_PLL_MASTER_LOCK,
> +	.pllm_mask = GENMASK(4, 0),
> +	.pllm_min = 4,
> +	.pllm_max = 32,
> +	.pllout_min_rate = 300000000,
> +	.pllout_max_rate = 600000000,
> +	.flags = PLL_HAS_OSCIN | PLL_HAS_PREDIV | PLL_HAS_POSTDIV |
> +		 PLL_HAS_EXTCLKSRC,
> +};
> +
> +/*
> + * NB: Technically, the clocks flagged as SYSCLK_FIXED_DIV are "fixed ratio",
> + * meaning that we could change the divider as long as we keep the correct
> + * ratio between all of the clocks, but we don't support that because there is
> + * currently not a need for it.
> + */
> +
> +static const struct davinci_pll_sysclk_info da850_pll0_sysclk_info[] __initconst = {
> +	SYSCLK(1, pll0_sysclk1, pll0_pllen, 5, SYSCLK_FIXED_DIV),
> +	SYSCLK(2, pll0_sysclk2, pll0_pllen, 5, SYSCLK_FIXED_DIV),
> +	SYSCLK(3, pll0_sysclk3, pll0_pllen, 5, 0),
> +	SYSCLK(4, pll0_sysclk4, pll0_pllen, 5, SYSCLK_FIXED_DIV),
> +	SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0),
> +	SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_ARM_RATE | SYSCLK_FIXED_DIV),
> +	SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0),
> +	{ }
> +};
> +
> +static const char * const da850_pll0_obsclk_parent_names[] __initconst = {
> +	"oscin",
> +	"pll0_sysclk1",
> +	"pll0_sysclk2",
> +	"pll0_sysclk3",
> +	"pll0_sysclk4",
> +	"pll0_sysclk5",
> +	"pll0_sysclk6",
> +	"pll0_sysclk7",
> +	"pll1_obsclk",
> +};
> +
> +static u32 da850_pll0_obsclk_table[] = {
> +	OCSEL_OCSRC_OSCIN,
> +	OCSEL_OCSRC_PLL0_SYSCLK(1),
> +	OCSEL_OCSRC_PLL0_SYSCLK(2),
> +	OCSEL_OCSRC_PLL0_SYSCLK(3),
> +	OCSEL_OCSRC_PLL0_SYSCLK(4),
> +	OCSEL_OCSRC_PLL0_SYSCLK(5),
> +	OCSEL_OCSRC_PLL0_SYSCLK(6),
> +	OCSEL_OCSRC_PLL0_SYSCLK(7),
> +	OCSEL_OCSRC_PLL1_OBSCLK,
> +};
> +
> +static const struct davinci_pll_obsclk_info da850_pll0_obsclk_info __initconst = {
> +	.name = "pll0_obsclk",
> +	.parent_names = da850_pll0_obsclk_parent_names,
> +	.num_parents = ARRAY_SIZE(da850_pll0_obsclk_parent_names),
> +	.table = da850_pll0_obsclk_table,
> +	.ocsrc_mask = GENMASK(4, 0),
> +};
> +
> +static const struct davinci_pll_clk_info da850_pll1_info __initconst = {
> +	.name = "pll1",
> +	.unlock_reg = CFGCHIP(3),
> +	.unlock_mask = CFGCHIP3_PLL1_MASTER_LOCK,
> +	.pllm_mask = GENMASK(4, 0),
> +	.pllm_min = 4,
> +	.pllm_max = 32,
> +	.pllout_min_rate = 300000000,
> +	.pllout_max_rate = 600000000,
> +	.flags = PLL_HAS_POSTDIV,
> +};
> +
> +static const struct davinci_pll_sysclk_info da850_pll1_sysclk_info[] __initconst = {
> +	SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
> +	SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, 0),
> +	SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, 0),
> +	{ }
> +};
> +
> +static const char * const da850_pll1_obsclk_parent_names[] __initconst = {
> +	"oscin",

Re: the issue of "ref_clk" vs. "oscin"...

This is one of the places where having the otherwise unnecessary "oscin" clock
really helps out. The PLL driver doesn't control "ref_clk" - it comes from somewhere
else. And in the case of DT, it may not even be named "ref_clk", so we really
don't want to hard-code the name "ref_clk" here.

If we have to allow a variable name here, it just makes more work in the driver
shuffling names around.

And the name "oscin" totally makes sense here because the TRM lists this input to the
mux as "OSCIN".

> +	"pll1_sysclk1",
> +	"pll1_sysclk2",
> +	"pll1_sysclk3",
> +};
> +
> +static u32 da850_pll1_obsclk_table[] = {
> +	OCSEL_OCSRC_OSCIN,
> +	OCSEL_OCSRC_PLL1_SYSCLK(1),
> +	OCSEL_OCSRC_PLL1_SYSCLK(2),
> +	OCSEL_OCSRC_PLL1_SYSCLK(3),
> +};
> +
> +static const struct davinci_pll_obsclk_info da850_pll1_obsclk_info __initconst = {
> +	.name = "pll1_obsclk",
> +	.parent_names = da850_pll1_obsclk_parent_names,
> +	.num_parents = ARRAY_SIZE(da850_pll1_obsclk_parent_names),
> +	.table = da850_pll1_obsclk_table,
> +	.ocsrc_mask = GENMASK(4, 0),
> +};
> +
> +void __init da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1)
> +{
> +	const struct davinci_pll_sysclk_info *info;
> +
> +	davinci_pll_clk_register(&da850_pll0_info, "ref_clk", pll0);

And really, we probably shouldn't be hard-coding "ref_clk" here either.
Basically, we are making the assumption that the board file has registered
a clock named "ref_clk". It would probably be better to pass the name
as a parameter.

> +
> +	davinci_pll_auxclk_register("pll0_auxclk", pll0);
> +
> +	for (info = da850_pll0_sysclk_info; info->name; info++)
> +		davinci_pll_sysclk_register(info, pll0);
> +
> +	davinci_pll_obsclk_register(&da850_pll0_obsclk_info, pll0);
> +
> +	davinci_pll_clk_register(&da850_pll1_info, "oscin", pll1);
> +
> +	for (info = da850_pll1_sysclk_info; info->name; info++)
> +		davinci_pll_sysclk_register(info, pll1);
> +
> +	davinci_pll_obsclk_register(&da850_pll1_obsclk_info, pll1);
> +}
> +
> +#ifdef CONFIG_OF
> +static void __init of_da850_pll0_auxclk_init(struct device_node *node)
> +{
> +	of_davinci_pll_init(node, &da850_pll0_info, &da850_pll0_obsclk_info,
> +			    da850_pll0_sysclk_info, 7);
> +}
> +CLK_OF_DECLARE(da850_pll0_auxclk, "ti,da850-pll0", of_da850_pll0_auxclk_init);
> +
> +static void __init of_da850_pll1_auxclk_init(struct device_node *node)
> +{
> +	of_davinci_pll_init(node, &da850_pll1_info, &da850_pll1_obsclk_info,
> +			    da850_pll1_sysclk_info, 3);
> +}
> +CLK_OF_DECLARE(da850_pll1_auxclk, "ti,da850-pll1", of_da850_pll1_auxclk_init);
> +#endif
> diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
> index 4f4d60d..7b08fe0 100644
> --- a/include/linux/clk/davinci.h
> +++ b/include/linux/clk/davinci.h
> @@ -10,5 +10,6 @@
>   #include <linux/types.h>
>   
>   void da830_pll_clk_init(void __iomem *pll);
> +void da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1);
>   
>   #endif /* __LINUX_CLK_DAVINCI_H__ */
> 
