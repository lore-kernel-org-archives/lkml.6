Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DA3ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4218A214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="md85NIFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4218A214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeJRCZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRCZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:25:09 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5A621476;
        Wed, 17 Oct 2018 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539800893;
        bh=K2pOno0f/K+kPLJA+5kirAewh2HGPggHCqA2pElvfrk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=md85NIFPAAg35ogFBQZ1SolZ1/4y5a2BjRcpz9naMqkf4KV5utSu/ZMpH4cZ0fez2
         zGFFR/Zrq2XmT3pchbWR+LlBt9ogWzXbJzSasa/HYT6+iqsUG7oYC4Bu1ak/8xAxtA
         R9HVEfC5h4BLmvaAXzk7cOW9kWkpOPgdBWAIC+Rg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180922181709.13007-4-gregory.clement@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-4-gregory.clement@bootlin.com>
Message-ID: <153980089252.5275.819540708953283855@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/6] clk: mvebu: add CPU clock driver for Armada 7K/8K
Date:   Wed, 17 Oct 2018 11:28:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-09-22 11:17:06)
> diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-cl=
k.c
> new file mode 100644
> index 000000000000..1b498cfe9191
> --- /dev/null
> +++ b/drivers/clk/mvebu/ap-cpu-clk.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Marvell Armada AP CPU Clock Controller
> + *
> + * Copyright (C) 2018 Marvell
> + *
> + * Omri Itach <omrii@marvell.com>
> + * Gregory Clement <gregory.clement@bootlin.com>
> + */
> +
> +#define pr_fmt(fmt) "ap-cpu-clk: " fmt
> +
> +#include "armada_ap_cp_helper.h"

Does this include need to come first? Preferably local includes come
after any <linux> ones.

> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/init.h>

Is this used?

> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define AP806_CPU_CLUSTER0             0
> +#define AP806_CPU_CLUSTER1             1
> +#define AP806_CPUS_PER_CLUSTER         2
> +#define APN806_CPU1_MASK               0x1
> +
> +#define APN806_CLUSTER_NUM_OFFSET      8
> +#define APN806_CLUSTER_NUM_MASK                (1 << APN806_CLUSTER_NUM_=
OFFSET)
> +
> +#define APN806_MAX_DIVIDER             32
> +
> +/* AP806 CPU DFS register mapping*/
> +#define AP806_CA72MP2_0_PLL_CR_0_REG_OFFSET            0x278
> +#define AP806_CA72MP2_0_PLL_CR_1_REG_OFFSET            0x280
> +#define AP806_CA72MP2_0_PLL_CR_2_REG_OFFSET            0x284
> +#define AP806_CA72MP2_0_PLL_SR_REG_OFFSET              0xC94
> +
> +#define AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET          0x14
> +#define AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_OFFSET                0
> +#define AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_MASK \
> +                       (0x3f << AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_OFFSET)
> +#define AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_OFFSET     24
> +#define AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_MASK \
> +                       (0x1 << AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_OFFSE=
T)
> +#define AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET     16
> +#define AP806_CA72MP2_0_PLL_RATIO_STATE                        11
> +
> +#define to_clk(hw) container_of(hw, struct ap_cpu_clk, hw)
> +
> +/*
> + * struct ap806_clk: CPU cluster clock controller instance
> + * @cluster: Cluster clock controller index
> + * @clk_name: Cluster clock controller name
> + * @dev : Cluster clock device
> + * @hw: HW specific structure of Cluster clock controller
> + * @pll_cr_base: CA72MP2 Register base (Device Sample at Reset register)
> + */
> +struct ap_cpu_clk {
> +       int cluster;

unsigned?

> +       const char *clk_name;
> +       struct device *dev;
> +       struct clk_hw hw;
> +       struct regmap *pll_cr_base;
> +};
> +
> +static struct clk **cluster_clks;
> +static struct clk_onecell_data clk_data;

Can you give these some better names that are ap_cpu specific? Grepping
for clk_data will make lots of hits otherwise because they're so
generic.

> +
> +static unsigned long ap_cpu_clk_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct ap_cpu_clk *clk =3D to_clk(hw);
> +       unsigned int cpu_clkdiv_reg =3D AP806_CA72MP2_0_PLL_CR_0_REG_OFFS=
ET +
> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);

Nitpick: This is pretty unreadable. Can you just declare the variables
up here and then do the assignment later on in the function and avoid
splitting across many lines?

> +       int cpu_clkdiv_ratio;
> +
> +       regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &cpu_clkdiv_ratio);
> +       cpu_clkdiv_ratio &=3D AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_MASK;
> +       cpu_clkdiv_ratio >>=3D AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_OFFSET;
> +
> +       return parent_rate / cpu_clkdiv_ratio;
> +}
> +
> +static int ap_cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long parent_rate)
> +{
> +       struct ap_cpu_clk *clk =3D to_clk(hw);
> +       int reg, divider =3D parent_rate / rate;
> +       unsigned int cpu_clkdiv_reg, cpu_force_reg, cpu_ratio_reg;
> +
> +       cpu_clkdiv_reg =3D AP806_CA72MP2_0_PLL_CR_0_REG_OFFSET +
> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);
> +       cpu_force_reg =3D AP806_CA72MP2_0_PLL_CR_1_REG_OFFSET +
> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);
> +       cpu_ratio_reg =3D AP806_CA72MP2_0_PLL_CR_2_REG_OFFSET +
> +               (clk->cluster * AP806_CA72MP2_0_PLL_CR_CLUSTER_OFFSET);
> +
> +       /* 1. Set CPU divider */
> +       regmap_update_bits(clk->pll_cr_base, cpu_clkdiv_reg,
> +                          AP806_PLL_CR_0_CPU_CLK_DIV_RATIO_MASK, divider=
);
> +
> +       /* 2. Set Reload force */
> +       regmap_update_bits(clk->pll_cr_base, cpu_force_reg,
> +                          AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_MASK,
> +                          AP806_PLL_CR_0_CPU_CLK_RELOAD_FORCE_MASK);
> +
> +       /* 3. Set Reload ratio */
> +       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET=
),
> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET=
));
> +
> +
> +       /* 4. Wait for stabilizing CPU Clock */
> +       do {
> +               regmap_read(clk->pll_cr_base,
> +                           AP806_CA72MP2_0_PLL_SR_REG_OFFSET,
> +                           &reg);
> +       } while (!(reg & BIT(clk->cluster * AP806_CA72MP2_0_PLL_RATIO_STA=
TE)));

Use regmap_read_poll_timeout() API here and give some large timeout
value so that we don't get stuck waiting here forever?

> +
> +       /* 5. Clear Reload ratio */

I'm not sure we really need these comments. They're just saying what the
code is doing, so they don't add much value.

> +       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFFSET=
), 0);
> +
> +       return 0;
> +}
> +
> +
> +static long ap_cpu_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                unsigned long *parent_rate)
> +{
> +       int divider =3D *parent_rate / rate;
> +
> +       if (divider > APN806_MAX_DIVIDER)
> +               divider =3D APN806_MAX_DIVIDER;

	divider =3D min(divider, APN806_MAX_DIVIDER);

> +
> +       return *parent_rate / divider;
> +}
> +
> +static const struct clk_ops ap_cpu_clk_ops =3D {
> +       .recalc_rate    =3D ap_cpu_clk_recalc_rate,
> +       .round_rate     =3D ap_cpu_clk_round_rate,
> +       .set_rate       =3D ap_cpu_clk_set_rate,
> +};
> +
> +static int ap_cpu_clock_probe(struct platform_device *pdev)
> +{
> +       int ret, nclusters =3D 0, cluster_index =3D 0;
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *dn, *np =3D dev->of_node;
> +       struct ap_cpu_clk *ap_cpu_clk;
> +       struct regmap *regmap;
> +
> +       regmap =3D syscon_node_to_regmap(np->parent);

Can we just call dev_get_remap() on pdev->dev.parent?

> +       if (IS_ERR(regmap)) {
> +               pr_err("cannot get pll_cr_base regmap\n");
> +               return PTR_ERR(regmap);
> +       }
> +
> +       /*
> +        * AP806 has 4 cpus and DFS for AP806 is controlled per
> +        * cluster (2 CPUs per cluster), cpu0 and cpu1 are fixed to
> +        * cluster0 while cpu2 and cpu3 are fixed to cluster1 whether
> +        * they are enabled or not.  Since cpu0 is the boot cpu, then
> +        * cluster0 must exist.  If cpu2 or cpu3 is enabled, cluster1
> +        * will exist and the cluster number is 2; otherwise the
> +        * cluster number is 1.
> +        */
> +       nclusters =3D 1;
> +       for_each_node_by_type(dn, "cpu") {

Isn't there some sort of for_each_cpu_node() API that can be used here?

> +               int cpu, err;
> +
> +               err =3D of_property_read_u32(dn, "reg", &cpu);
> +               if (WARN_ON(err))
> +                       return err;
> +
> +               /* If cpu2 or cpu3 is enabled */
> +               if ((cpu & APN806_CLUSTER_NUM_MASK)) {
> +                       nclusters =3D 2;
> +                       break;
> +               }
> +       }
> +       /*
> +        * DFS for AP806 is controlled per cluster (2 CPUs per cluster),
> +        * so allocate structs per cluster
> +        */
> +       ap_cpu_clk =3D devm_kcalloc(dev, nclusters, sizeof(*ap_cpu_clk),
> +                                 GFP_KERNEL);
> +       if (WARN_ON(!ap_cpu_clk))
> +               return -ENOMEM;
> +
> +       cluster_clks =3D devm_kcalloc(dev, nclusters, sizeof(*cluster_clk=
s),
> +                                   GFP_KERNEL);
> +       if (WARN_ON(!cluster_clks))

Drop the WARN_ON please. If allocation fails we'll already get a large
stack trace and messages.

> +               return -ENOMEM;
> +
> +       for_each_node_by_type(dn, "cpu") {
> +               char *clk_name =3D "cpu-cluster-0";
> +               struct clk_init_data init;
> +               const char *parent_name;
> +               struct clk *clk, *parent;
> +               int cpu, err;
> +
> +               err =3D of_property_read_u32(dn, "reg", &cpu);
> +               if (WARN_ON(err))
> +                       return err;
> +
> +               cluster_index =3D (cpu & APN806_CLUSTER_NUM_MASK);

Nitpick: Drop useless parenthesis please.

> +               cluster_index >>=3D APN806_CLUSTER_NUM_OFFSET;
> +
> +               /* Initialize once for one cluster */
> +               if (cluster_clks[cluster_index])
> +                       continue;
> +
> +               parent =3D of_clk_get(np, cluster_index);
> +               if (IS_ERR(parent)) {
> +                       dev_err(dev, "Could not get the clock parent\n");
> +                       return -EINVAL;
> +               }
> +               parent_name =3D  __clk_get_name(parent);
> +               clk_name[12] +=3D cluster_index;
> +               ap_cpu_clk[cluster_index].clk_name =3D
> +                       ap_cp_unique_name(dev, np->parent, clk_name);
> +               ap_cpu_clk[cluster_index].cluster =3D cluster_index;
> +               ap_cpu_clk[cluster_index].pll_cr_base =3D regmap;
> +               ap_cpu_clk[cluster_index].hw.init =3D &init;
> +               ap_cpu_clk[cluster_index].dev =3D dev;
> +
> +               init.name =3D ap_cpu_clk[cluster_index].clk_name;
> +               init.ops =3D &ap_cpu_clk_ops;
> +               init.num_parents =3D 1;
> +               init.parent_names =3D &parent_name;
> +               init.flags =3D CLK_GET_RATE_NOCACHE;

Can you add a comment why we need NOCACHE here? It isn't clear why this
is important.

> +
> +               clk =3D devm_clk_register(dev, &ap_cpu_clk[cluster_index]=
.hw);

Please use the clk_hw based registration APIs.

> +               if (IS_ERR(clk))
> +                       return PTR_ERR(clk);
> +
> +               cluster_clks[cluster_index] =3D clk;
> +       }
> +
> +       clk_data.clk_num =3D cluster_index + 1;
> +       clk_data.clks =3D cluster_clks;
> +
> +       ret =3D of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data=
);

And the clk_hw based provider APIs.

> +       if (ret)
> +               dev_err(dev, "failed to register OF clock provider\n");
> +
> +       return ret;
> +}
> +
