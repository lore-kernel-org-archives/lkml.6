Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCWR67 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeCWR65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:58:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3601A2177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: avifishman70@gmail.com, brendanhiggins@google.com,
        linux@armlinux.org.uk, mark.rutland@arm.com, mturquette@baylibre.com,
        raltherr@google.com, robh+dt@kernel.org, sboyd@codeaurora.org,
        tali.perry1@gmail.com, tmaimon77@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521553249-6971-3-git-send-email-tali.perry1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
References: <1521553249-6971-1-git-send-email-tali.perry1@gmail.com>
 <1521553249-6971-3-git-send-email-tali.perry1@gmail.com>
Message-ID: <152182793651.178046.13824776927497999970@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 2/2] clk: npcm7xx: Nuvoton NPCM7XX Clock Controller driver
Date: Fri, 23 Mar 2018 10:58:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting tali.perry1@gmail.com (2018-03-20 06:40:49)
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 71ec41e6364f..353e94f2c25a 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -21,6 +21,7 @@ endif
>  obj-$(CONFIG_MACH_ASM9260)             += clk-asm9260.o
>  obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)    += clk-axi-clkgen.o
>  obj-$(CONFIG_ARCH_AXXIA)               += clk-axm5516.o
> +obj-$(CONFIG_ARCH_NPCM7XX)             += clk-npcm7xx.o

Please sort this by filename, not config name.

>  obj-$(CONFIG_COMMON_CLK_CDCE706)       += clk-cdce706.o
>  obj-$(CONFIG_COMMON_CLK_CDCE925)       += clk-cdce925.o
>  obj-$(CONFIG_ARCH_CLPS711X)            += clk-clps711x.o
> diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
> new file mode 100644
> index 000000000000..0d373f8f114b
> --- /dev/null
> +++ b/drivers/clk/clk-npcm7xx.c
> @@ -0,0 +1,757 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM7xx Clock Generator
[..]
> +
> +
> +static struct clk_hw_onecell_data *npcm7xx_clk_data;
> +static void __iomem *clk_base;

Please remove static singletons and allocate them during init.

> +static DEFINE_SPINLOCK(lock);

Please give 'lock' a better name so that lockdep reports are
meaningful.

> +
> +
> +static const struct of_device_id npcm7xx_clk_match_table[] = {
> +                               { .compatible = "nuvoton,npcm750-clk"},
> +                               {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, npcm7xx_clk_match_table);

Is this used?

> +
> +
> +static void __init npcm7xx_clk_init(struct device_node *clk_np)
> +{
> +
> +       struct resource res;
> +       struct clk_hw *hw;
> +       struct clk *clk;
> +       int ret;
> +       int i;
> +
> +       pr_debug("NPCM750: clock init: ");
> +
> +       clk_base = NULL;
> +
> +       ret = of_address_to_resource(clk_np, 0, &res);
> +       if (ret) {
> +               pr_err("\t%s: failed to get resource, ret %d\n", clk_np->name,
> +                       ret);
> +               return;
> +       }
> +
> +
> +       clk_base = ioremap(res.start, resource_size(&res));
> +       if (IS_ERR(clk_base)) {
> +               pr_err("\tnpcm7xx_clk_init: resource error\n");
> +               goto npcm7xx_init_error;
> +       }
> +
> +
> +       npcm7xx_clk_data = kzalloc(sizeof(*npcm7xx_clk_data->hws) *
> +               NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL);
> +
> +       npcm7xx_clk_data->num = 0;
> +
> +       if (!npcm7xx_clk_data->hws) {
> +               pr_err("Can't alloc npcm7xx_clk_data\n");

We don't need allocation error messages, kmalloc already prints a bunch
of info.

> +               goto npcm7xx_init_np_err;
> +       }
> +
> +       npcm7xx_clk_data->num = NPCM7XX_NUM_CLOCKS;
> +
> +
> +       /*
> +        * This way all clock fetched before the platform device probes,

What platform device?

> +        * except those we assign here for early use, will be deferred.
> +        */
> +       pr_debug("\tclk init hws\n");
> +       for (i = 0; i < NPCM7XX_NUM_CLOCKS; i++)
> +               npcm7xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +       /* Read fixed clocks. These 3 clocks must be defined in DT */
> +       clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_REFCLK);
> +       if (!IS_ERR(clk)) {
> +               pr_err("failed to find external REFCLK: %ld\n",
> +                       PTR_ERR(clk));
> +               clk_put(clk);
> +       }
> +
> +       clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_SYSBYPCK);
> +       if (!IS_ERR(clk)) {
> +               pr_err("failed to find external SYSBYPCK: %ld\n",
> +                       PTR_ERR(clk));
> +               clk_put(clk);
> +       }
> +
> +       clk = of_clk_get_by_name(clk_np, NPCM7XX_CLK_S_MCBYPCK);
> +       if (!IS_ERR(clk)) {
> +               pr_err("failed to find external MCBYPCK: %ld\n",
> +                       PTR_ERR(clk));
> +               clk_put(clk);
> +       }
> +
> +       /* Register plls */
> +       pr_debug("\tclk register pll\n");
> +       for (i = 0; i < ARRAY_SIZE(npcm7xx_plls); i++) {
> +               const struct npcm7xx_clk_pll_data *pll_data = &npcm7xx_plls[i];
> +
> +               pr_debug("\tclk reg pll%d, reg=0x%x, name=%s, p=%s\n", i,
> +               (unsigned int)pll_data->reg, pll_data->name,
> +               pll_data->parent_name);
> +
> +               hw = npcm7xx_clk_register_pll(clk_base + pll_data->reg,
> +                       pll_data->name, pll_data->parent_name, pll_data->flags);
> +               if (IS_ERR(hw)) {
> +                       pr_err("npcm7xx_clk: Can't register pll\n");
> +                       goto npcm7xx_init_fail;
> +               }
> +
> +               if (pll_data->onecell_idx >= 0)
> +                       npcm7xx_clk_data->hws[pll_data->onecell_idx] = hw;
> +       }
> +
> +       /* Register fixed dividers */
> +       pr_debug("\tclk register fixed divs\n");
> +       clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL1_DIV2,
> +                       NPCM7XX_CLK_S_PLL1, 0, 1, 2);
> +       if (IS_ERR(clk)) {
> +               pr_err("npcm7xx_clk: Can't register fixed div\n");
> +               goto npcm7xx_init_fail;
> +       }
> +
> +
> +       clk = clk_register_fixed_factor(NULL, NPCM7XX_CLK_S_PLL2_DIV2,
> +                       NPCM7XX_CLK_S_PLL2, 0, 1, 2);
> +
> +       if (IS_ERR(clk)) {
> +               pr_err("npcm7xx_clk: Can't register div2\n");
> +               goto npcm7xx_init_fail;
> +       }
> +
> +       /* Register muxes */
> +       for (i = 0; i < ARRAY_SIZE(npcm7xx_muxes); i++) {
> +               const struct npcm7xx_clk_mux_data *mux_data = &npcm7xx_muxes[i];
> +
> +               pr_debug("\tadd mux%d reg=0x%x name=%s p=%s num_p=%d\n",
> +                   i, ((u32)clk_base + (u32)NPCM7XX_CLKSEL), mux_data->name,
> +                       mux_data->parent_names[0], mux_data->num_parents);
> +
> +               hw = clk_hw_register_mux_table(NULL,
> +                       mux_data->name,
> +                       mux_data->parent_names, mux_data->num_parents,
> +                       mux_data->flags, clk_base + NPCM7XX_CLKSEL,
> +                       mux_data->shift, mux_data->mask, 0,
> +                       mux_data->table, &lock);
> +
> +               if (IS_ERR(hw)) {
> +                       pr_err("npcm7xx_clk: Can't register mux\n");
> +                       goto npcm7xx_init_fail;
> +               }
> +
> +               if (mux_data->onecell_idx >= 0)
> +                       npcm7xx_clk_data->hws[mux_data->onecell_idx] = hw;
> +       }
> +
> +       /* Register clock dividers specified in npcm7xx_divs. */
> +       pr_debug("\tclk register divs\n");
> +       for (i = 0; i < ARRAY_SIZE(npcm7xx_divs); i++) {
> +               const struct npcm7xx_clk_div_data *div_data = &npcm7xx_divs[i];
> +
> +               pr_debug("\tadd div%d reg=0x%x name=%s, parent=%s\n",
> +                               i, (unsigned int)div_data->reg,
> +                               div_data->name, div_data->parent_name);

Please remove all these debug prints.

> +
> +               hw = clk_hw_register_divider(NULL, div_data->name,
> +                               div_data->parent_name,
> +                               div_data->flags,
> +                               clk_base + div_data->reg,
> +                               div_data->shift, div_data->width,
> +                               div_data->clk_divider_flags, &lock);
> +               if (IS_ERR(hw)) {
> +                       pr_err("npcm7xx_clk: Can't register div table\n");
> +                       goto npcm7xx_init_fail;
> +               }
> +
> +               if (div_data->onecell_idx >= 0)
> +                       npcm7xx_clk_data->hws[div_data->onecell_idx] = hw;
> +       }
> +
> +       ret = of_clk_add_hw_provider(clk_np, of_clk_hw_onecell_get,
> +                                       npcm7xx_clk_data);
> +       if (ret)
> +               pr_err("failed to add DT provider: %d\n", ret);
> +
> +       pr_info("npcm7xx clk: %d dividers, %d muxes and %d plls registered.\n",
> +               ARRAY_SIZE(npcm7xx_divs), ARRAY_SIZE(npcm7xx_muxes),
> +               ARRAY_SIZE(npcm7xx_plls));

Please remove this "I'm alive!" message.

> +
> +       of_node_put(clk_np);
> +
> +       return;
> +
> +npcm7xx_init_fail:
> +       pr_debug("\tclk setup fail\n");

Please don't put tabs at the beginning of printks.

> +       if (npcm7xx_clk_data->num)
> +               kfree(npcm7xx_clk_data->hws);
> +npcm7xx_init_np_err:
> +       if (clk_base != NULL)
> +               iounmap(clk_base);
> +npcm7xx_init_error:
> +       of_node_put(clk_np);
> +}
> +
> +CLK_OF_DECLARE(npcm7xx_clk_init, "nuvoton,npcm750-clk", npcm7xx_clk_init);

Any reason this can't be a platform driver?
