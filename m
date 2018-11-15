Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30D7C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD322086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD322086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbeKQDC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:02:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55764 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeKQDC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:02:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9CDD120791; Fri, 16 Nov 2018 17:49:15 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6745E207A8;
        Fri, 16 Nov 2018 17:49:05 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 3/6] clk: mvebu: add CPU clock driver for Armada 7K/8K
Date:   Fri, 16 Nov 2018 00:22:59 +0100
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
        <20180922181709.13007-4-gregory.clement@bootlin.com>
        <153980089252.5275.819540708953283855@swboyd.mtv.corp.google.com>
Message-ID: <87y39tufwe.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On mer., oct. 17 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2018-09-22 11:17:06)
>> diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
>> new file mode 100644
>> index 000000000000..1b498cfe9191
>> --- /dev/null
>> +++ b/drivers/clk/mvebu/ap-cpu-clk.c
>> @@ -0,0 +1,265 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Marvell Armada AP CPU Clock Controller
>> + *
>> + * Copyright (C) 2018 Marvell
>> + *
>> + * Omri Itach <omrii@marvell.com>
>> + * Gregory Clement <gregory.clement@bootlin.com>
>> + */
>> +
>> +#define pr_fmt(fmt) "ap-cpu-clk: " fmt
>> +
>> +#include "armada_ap_cp_helper.h"
>
> Does this include need to come first? Preferably local includes come
> after any <linux> ones.

OK

>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk.h>
>> +#include <linux/init.h>
>
> Is this used?

During development but no more now, I remove it.

>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#define AP806_CPU_CLUSTER0             0
>> +#define AP806_CPU_CLUSTER1             1
>> +#define AP806_CPUS_PER_CLUSTER         2
>> +#define APN806_CPU1_MASK               0x1
>> +
>> +#define APN806_CLUSTER_NUM_OFFSET      8
>> +#define APN806_CLUSTER_NUM_MASK                (1 << APN806_CLUSTER_NUM_OFFSET)
>> +
>> +#define APN806_MAX_DIVIDER             32
>> +
>> +/* AP806 CPU DFS register mapping*/
>> +#define AP806_CA72MP2_0_PLL_CR_0_REG_OFFSET            0x278
>> +#define AP806_CA72MP2_0_PLL_CR_1_REG_OFFSET            0x280
>> +#define AP806_CA72MP2_0_PLL_CR_2_REG_OFFSET            0x284
>> +#define AP806_CA72MP2_0_PLL_SR_REG_OFFSET              0xC94
>> +
>> +#define AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET          0x14
>> +#define AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_OFFSET                0
>> +#define AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_MASK \
>> +                       (0x3f << AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_OFFSET)
>> +#define AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_OFFSET     24
>> +#define AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_MASK \
>> +                       (0x1 << AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_OFFSET)
>> +#define AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET     16
>> +#define AP806_CA72MP2_0_PLL_RATIO_STATE                        11
>> +
>> +#define to_clk(hw) container_of(hw, struct ap_cpu_clk, hw)
>> +
>> +/*
>> + * struct ap806_clk: CPU cluster clock controller instance
>> + * @cluster: Cluster clock controller index
>> + * @clk_name: Cluster clock controller name
>> + * @dev : Cluster clock device
>> + * @hw: HW specific structure of Cluster clock controller
>> + * @pll_cr_base: CA72MP2 Register base (Device Sample at Reset register)
>> + */
>> +struct ap_cpu_clk {
>> +       int cluster;
>
> unsigned?

I don't expect to have so many clusters that a signed int would be too
short :)

Actually I used int to let the compiler choose what ever he wants.

But if you really want I can use a unsigned int

>
>> +       const char *clk_name;
>> +       struct device *dev;
>> +       struct clk_hw hw;
>> +       struct regmap *pll_cr_base;
>> +};
>> +
>> +static struct clk **cluster_clks;
>> +static struct clk_onecell_data clk_data;
>
> Can you give these some better names that are ap_cpu specific? Grepping
> for clk_data will make lots of hits otherwise because they're so
> generic.

OK I will try to be more creative ;)

>
>> +
>> +static unsigned long ap_cpu_clk_recalc_rate(struct clk_hw *hw,
>> +                                           unsigned long parent_rate)
>> +{
>> +       struct ap_cpu_clk *clk = to_clk(hw);
>> +       unsigned int cpu_clkdiv_reg = AP806_CA72MP2_0_PLL_CR_0_REG_OFFSET +
>> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);
>
> Nitpick: This is pretty unreadable. Can you just declare the variables
> up here and then do the assignment later on in the function and avoid
> splitting across many lines?

OK

>
>> +       int cpu_clkdiv_ratio;
>> +
>> +       regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &cpu_clkdiv_ratio);
>> +       cpu_clkdiv_ratio &= AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_MASK;
>> +       cpu_clkdiv_ratio >>= AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_OFFSET;
>> +
>> +       return parent_rate / cpu_clkdiv_ratio;
>> +}
>> +
>> +static int ap_cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                             unsigned long parent_rate)
>> +{
>> +       struct ap_cpu_clk *clk = to_clk(hw);
>> +       int reg, divider = parent_rate / rate;
>> +       unsigned int cpu_clkdiv_reg, cpu_force_reg, cpu_ratio_reg;
>> +
>> +       cpu_clkdiv_reg = AP806_CA72MP2_0_PLL_CR_0_REG_OFFSET +
>> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);
>> +       cpu_force_reg = AP806_CA72MP2_0_PLL_CR_1_REG_OFFSET +
>> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);
>> +       cpu_ratio_reg = AP806_CA72MP2_0_PLL_CR_2_REG_OFFSET +
>> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);
>> +
>> +       /* 1. Set CPU divider */
>> +       regmap_update_bits(clk->pll_cr_base, cpu_clkdiv_reg,
>> +                          AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_MASK, divider);
>> +
>> +       /* 2. Set Reload force */
>> +       regmap_update_bits(clk->pll_cr_base, cpu_force_reg,
>> +                          AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_MASK,
>> +                          AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_MASK);
>> +
>> +       /* 3. Set Reload ratio */
>> +       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
>> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET),
>> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET));
>> +
>> +
>> +       /* 4. Wait for stabilizing CPU Clock */
>> +       do {
>> +               regmap_read(clk->pll_cr_base,
>> +                           AP806_CA72MP2_0_PLL_SR_REG_OFFSET,
>> +                           &reg);
>> +       } while (!(reg & BIT(clk->cluster * AP806_CA72MP2_0_PLL_RATIO_STATE)));
>
> Use regmap_read_poll_timeout() API here and give some large timeout
> value so that we don't get stuck waiting here forever?

Indeed regmap_read_poll_timeout() seems a nice improvement

>
>> +
>> +       /* 5. Clear Reload ratio */
>
> I'm not sure we really need these comments. They're just saying what the
> code is doing, so they don't add much value.

Actually, these 5 steps directly come from the datasheet.

>
>> +       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
>> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET), 0);
>> +
>> +       return 0;
>> +}
>> +
>> +
>> +static long ap_cpu_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                unsigned long *parent_rate)
>> +{
>> +       int divider = *parent_rate / rate;
>> +
>> +       if (divider > APN806_MAX_DIVIDER)
>> +               divider = APN806_MAX_DIVIDER;
>
> 	divider = min(divider, APN806_MAX_DIVIDER);

OK
>
>> +
>> +       return *parent_rate / divider;
>> +}
>> +
>> +static const struct clk_ops ap_cpu_clk_ops = {
>> +       .recalc_rate    = ap_cpu_clk_recalc_rate,
>> +       .round_rate     = ap_cpu_clk_round_rate,
>> +       .set_rate       = ap_cpu_clk_set_rate,
>> +};
>> +
>> +static int ap_cpu_clock_probe(struct platform_device *pdev)
>> +{
>> +       int ret, nclusters = 0, cluster_index = 0;
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *dn, *np = dev->of_node;
>> +       struct ap_cpu_clk *ap_cpu_clk;
>> +       struct regmap *regmap;
>> +
>> +       regmap = syscon_node_to_regmap(np->parent);
>
> Can we just call dev_get_remap() on pdev->dev.parent?

we could do regmap = dev_get_regmap(pdev->dev.parent, NULL); instead of
this line. But is it really better?

>
>> +       if (IS_ERR(regmap)) {
>> +               pr_err("cannot get pll_cr_base regmap\n");
>> +               return PTR_ERR(regmap);
>> +       }
>> +
>> +       /*
>> +        * AP806 has 4 cpus and DFS for AP806 is controlled per
>> +        * cluster (2 CPUs per cluster), cpu0 and cpu1 are fixed to
>> +        * cluster0 while cpu2 and cpu3 are fixed to cluster1 whether
>> +        * they are enabled or not.  Since cpu0 is the boot cpu, then
>> +        * cluster0 must exist.  If cpu2 or cpu3 is enabled, cluster1
>> +        * will exist and the cluster number is 2; otherwise the
>> +        * cluster number is 1.
>> +        */
>> +       nclusters = 1;
>> +       for_each_node_by_type(dn, "cpu") {
>
> Isn't there some sort of for_each_cpu_node() API that can be used
> here?

Not when I wrote the code but since v4.20-rc1 we have
for_each_of_cpu_node(). So I am going to use it now.

>
>> +               int cpu, err;
>> +
>> +               err = of_property_read_u32(dn, "reg", &cpu);
>> +               if (WARN_ON(err))
>> +                       return err;
>> +
>> +               /* If cpu2 or cpu3 is enabled */
>> +               if ((cpu & APN806_CLUSTER_NUM_MASK)) {
>> +                       nclusters = 2;
>> +                       break;
>> +               }
>> +       }
>> +       /*
>> +        * DFS for AP806 is controlled per cluster (2 CPUs per cluster),
>> +        * so allocate structs per cluster
>> +        */
>> +       ap_cpu_clk = devm_kcalloc(dev, nclusters, sizeof(*ap_cpu_clk),
>> +                                 GFP_KERNEL);
>> +       if (WARN_ON(!ap_cpu_clk))
>> +               return -ENOMEM;
>> +
>> +       cluster_clks = devm_kcalloc(dev, nclusters, sizeof(*cluster_clks),
>> +                                   GFP_KERNEL);
>> +       if (WARN_ON(!cluster_clks))
>
> Drop the WARN_ON please. If allocation fails we'll already get a large
> stack trace and messages.

OK

>
>> +               return -ENOMEM;
>> +
>> +       for_each_node_by_type(dn, "cpu") {
>> +               char *clk_name = "cpu-cluster-0";
>> +               struct clk_init_data init;
>> +               const char *parent_name;
>> +               struct clk *clk, *parent;
>> +               int cpu, err;
>> +
>> +               err = of_property_read_u32(dn, "reg", &cpu);
>> +               if (WARN_ON(err))
>> +                       return err;
>> +
>> +               cluster_index = (cpu & APN806_CLUSTER_NUM_MASK);
>
> Nitpick: Drop useless parenthesis please.

OK
>
>> +               cluster_index >>= APN806_CLUSTER_NUM_OFFSET;
>> +
>> +               /* Initialize once for one cluster */
>> +               if (cluster_clks[cluster_index])
>> +                       continue;
>> +
>> +               parent = of_clk_get(np, cluster_index);
>> +               if (IS_ERR(parent)) {
>> +                       dev_err(dev, "Could not get the clock parent\n");
>> +                       return -EINVAL;
>> +               }
>> +               parent_name =  __clk_get_name(parent);
>> +               clk_name[12] += cluster_index;
>> +               ap_cpu_clk[cluster_index].clk_name =
>> +                       ap_cp_unique_name(dev, np->parent, clk_name);
>> +               ap_cpu_clk[cluster_index].cluster = cluster_index;
>> +               ap_cpu_clk[cluster_index].pll_cr_base = regmap;
>> +               ap_cpu_clk[cluster_index].hw.init = &init;
>> +               ap_cpu_clk[cluster_index].dev = dev;
>> +
>> +               init.name = ap_cpu_clk[cluster_index].clk_name;
>> +               init.ops = &ap_cpu_clk_ops;
>> +               init.num_parents = 1;
>> +               init.parent_names = &parent_name;
>> +               init.flags = CLK_GET_RATE_NOCACHE;
>
> Can you add a comment why we need NOCACHE here? It isn't clear why this
> is important.

I think there was the idea that the clock rate could be modified by
something else that the clk driver, but now I am not sure it is the
case. I will check it and either add a comment or just remove it.

>
>> +
>> +               clk = devm_clk_register(dev, &ap_cpu_clk[cluster_index].hw);
>
> Please use the clk_hw based registration APIs.

OK

>
>> +               if (IS_ERR(clk))
>> +                       return PTR_ERR(clk);
>> +
>> +               cluster_clks[cluster_index] = clk;
>> +       }
>> +
>> +       clk_data.clk_num = cluster_index + 1;
>> +       clk_data.clks = cluster_clks;
>> +
>> +       ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>
> And the clk_hw based provider APIs.

OK
>
>> +       if (ret)
>> +               dev_err(dev, "failed to register OF clock provider\n");
>> +
>> +       return ret;
>> +}
>> +

Thanks,

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
