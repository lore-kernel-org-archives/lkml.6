Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbeEHB35 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753510AbeEHB3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:29:55 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525320752-15091-1-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1525320752-15091-1-git-send-email-tdas@codeaurora.org>
Message-ID: <152574299379.138124.17545715298285645263@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Add support for RCG to register for DFS
Date: Mon, 07 May 2018 18:29:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w481U2Z3003078

Quoting Taniya Das (2018-05-02 21:12:32)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e63db10..7c35bca 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -122,6 +131,10 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
>         int ret;
>         u32 cfg = rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
> 
> +       /* In DFS mode skip updating the RCG CFG */
> +       if (rcg->flags & DFS_ENABLE_RCG)
> +               return 0;
> +
>         ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
>                                  CFG_SRC_SEL_MASK, cfg);
>         if (ret)
> @@ -296,6 +309,9 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>         struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>         const struct freq_tbl *f;
> 
> +       if (rcg->flags & DFS_ENABLE_RCG)
> +               return -EPERM;
> +

Please no.

>         switch (policy) {
>         case FLOOR:
>                 f = qcom_find_freq_floor(rcg->freq_tbl, rate);
> @@ -790,3 +806,159 @@ static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
>         .determine_rate = clk_gfx3d_determine_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_gfx3d_ops);
> +
> +/* Common APIs to be used for DFS based RCGR */
> +static u8 clk_parent_index_pre_div_and_mode(struct clk_hw *hw, u32 offset,

Fix return type please.

> +               u32 *mode, u32 *pre_div)
> +{
> +       struct clk_rcg2 *rcg;
> +       int num_parents;
> +       u32 cfg, mask;
> +       int i, ret;
> +
> +       if (!hw)
> +               return -EINVAL;

Why?

> +
> +       num_parents = clk_hw_get_num_parents(hw);
> +
> +       rcg = to_clk_rcg2(hw);
> +
> +       ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cfg);

We may need to pass the regmap into here so this can be done before the
clk is registered so that we can switch out the clk_ops at runtime. But
that may not be the case if my other comment makes sense further down.

> +       if (ret)
> +               goto err;
> +
> +       mask = BIT(rcg->hid_width) - 1;
> +       *pre_div = cfg & mask ? (cfg & mask) : 1;
> +
> +       *mode = cfg & CFG_MODE_MASK;
> +       *mode >>= CFG_MODE_SHIFT;
> +
> +       cfg &= CFG_SRC_SEL_MASK;
> +       cfg >>= CFG_SRC_SEL_SHIFT;
> +
> +       for (i = 0; i < num_parents; i++)
> +               if (cfg == rcg->parent_map[i].cfg)
> +                       return i;
> +err:
> +       return 0;
> +}
> +
> +static int calculate_m_and_n(struct clk_hw *hw, u32 m_offset, u32 n_offset,
> +               u32 mode, u32 *m, u32 *n)

Instead of returning pointers, please have these functions update a
frequency table entry structure.

> +{
> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +       u32 val, mask;
> +       int ret = 0;
> +
> +       if (!hw)
> +               return -EINVAL;
> +
> +       *m = *n = 0;
> +
> +       if (mode) {
> +               /* Calculate M & N values */
> +               mask = BIT(rcg->mnd_width) - 1;
> +               ret =  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_offset,
> +                                       &val);
> +               if (ret) {
> +                       pr_err("Failed to read M offset register\n");
> +                       goto err;
> +               }
> +
> +               val &= mask;
> +               *m  = val;
> +
> +               ret =  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_offset,
> +                                       &val);
> +               if (ret) {
> +                       pr_err("Failed to read N offset register\n");
> +                       goto err;
> +               }
> +
> +               /* val ~(N-M) */
> +               val = ~val;
> +               val &= mask;
> +               val += *m;
> +               *n = val;
> +       }
> +err:
> +       return ret;
> +}
> +
> +int clk_rcg2_get_dfs_clock_rate(struct clk_rcg2 *clk, struct device *dev)
> +{
> +       int i, j, index, ret = 0;
> +       unsigned long calc_freq, prate;
> +       u32 val, pre_div = 0, mode = 0, m = 0, n = 0;
> +       struct freq_tbl *dfs_freq_tbl;
> +       struct clk_hw *phw;
> +
> +       if (!clk)
> +               return -EINVAL;

Never happens?

> +
> +       /* Check for DFS_EN */
> +       ret = regmap_read(clk->clkr.regmap, clk->cmd_rcgr + SE_CMD_DFSR_OFFSET,
> +                                               &val);
> +       if (ret) {
> +               dev_err(dev, "Failed to read DFS enable register\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!(val & SE_CMD_DFS_EN))
> +               return ret;
> +
> +       dfs_freq_tbl = devm_kzalloc(dev, MAX_PERF_LEVEL *
> +                               sizeof(struct freq_tbl), GFP_KERNEL);

Use devm_kcalloc() for numbers of elements in an array.

> +       if (!dfs_freq_tbl)
> +               return -ENOMEM;
> +
> +       /* Populate the Perf Level */
> +       for (i = 0; i < MAX_PERF_LEVEL; i++) {
> +               /* Get parent index and mode */
> +               index = clk_parent_index_pre_div_and_mode(&clk->clkr.hw,
> +                                                       SE_PERF_DFSR(i), &mode,
> +                                                       &pre_div);
> +               if (index < 0) {
> +                       pr_err("Failed to get parent index & mode %d\n", index);
> +                       return index;
> +               }
> +
> +               /* clock pre_div */
> +               dfs_freq_tbl[i].pre_div = pre_div;
> +
> +               /* Fill the parent src */
> +               dfs_freq_tbl[i].src = clk->parent_map[index].src;
> +
> +               /* Get the parent clock and parent rate */
> +               phw = clk_hw_get_parent_by_index(&clk->clkr.hw, index);
> +               prate = clk_hw_get_rate(phw);

Urgh this is sort of annoying. We'll need the parents to be registered
when the frequency table is created, just so we can parse the parent
rate out and calculate the final frequency? What do we do if the parent
isn't registered yet? We may need to push this logic into the determine
rate path, and calculate the frequency table lazily at that point and
hope that the parent is registered with some frequency. Otherwise fail
the determine rate call.

> +
> +               ret = calculate_m_and_n(&clk->clkr.hw, SE_PERF_M_DFSR(i),
> +                                       SE_PERF_N_DFSR(i), mode, &m, &n);
> +               if (ret)
> +                       goto err;
> +
> +               dfs_freq_tbl[i].m = m;
> +               dfs_freq_tbl[i].n = n;
> +
> +               /* calculate the final frequency */
> +               calc_freq = calc_rate(prate, dfs_freq_tbl[i].m,
> +                                               dfs_freq_tbl[i].n, mode,
> +                                               dfs_freq_tbl[i].pre_div);
> +
> +               /* Check for duplicate frequencies */
> +               for (j = 0; j  < i; j++) {
> +                       if (dfs_freq_tbl[j].freq == calc_freq)
> +                               goto done;
> +               }
> +
> +               dfs_freq_tbl[i].freq = calc_freq;
> +       }
> +done:
> +       j = i;

Why do we care about j = i? It isn't used now.

> +
> +       clk->flags |= DFS_ENABLE_RCG;

I'd rather the ops are replaced with different clk_ops for DFS
explicitly. The flag is not very nice.

> +       clk->freq_tbl = dfs_freq_tbl;
> +err:
> +       return ret;
> +}
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index b8064a3..b27699b 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and

SPDX update?

> @@ -288,4 +288,25 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_probe);
> 
> +int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
> +                        const struct qcom_cc_dfs_desc *desc)
> +{
> +       struct clk_dfs *clks = desc->clks;
> +       size_t num_clks = desc->num_clks;
> +       int i, ret = 0;
> +
> +       for (i = 0; i < num_clks; i++) {
> +               ret = clk_rcg2_get_dfs_clock_rate(clks[i].rcg, &pdev->dev);
> +               if (ret) {
> +                       dev_err(&pdev->dev,
> +                               "Failed calculating DFS frequencies for %s\n",
> +                               clk_hw_get_name(&(clks[i].rcg)->clkr.hw));

That is a long line. Preferably iterate a local variable 'rcg' that is
set to the start of the array and ++ through this loop.

> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(qcom_cc_register_rcg_dfs);
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 00196ee..6627aec 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014, 2018, The Linux Foundation. All rights reserved.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -48,6 +48,15 @@ struct parent_map {
>         u8 cfg;
>  };
> 
> +struct clk_dfs {
> +       struct clk_rcg2 *rcg;
> +};

Just have an array of clk_rcg2's instead of this struct? I'd add it to
the common descriptor structure too, because I'm going to guess this is
common going forward.
