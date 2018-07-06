Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167E6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DDB22B4B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY7MaQY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DDB22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeGFXjk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932774AbeGFXji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:39:38 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AED22B4B;
        Fri,  6 Jul 2018 23:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530920377;
        bh=S4t5YpMwLv6msBUssPlf+39XAbt7iBVWX0Cm3uHrTHg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=eY7MaQY5dWMEIdCyL4yFUFvW4oVUHnIDozQBPd6lPEVje/1urxqgqWjhDfbJZzWEv
         xK2V73sGAMjeTR1pYfywSyLZzx4Xj1VtCYzGbLbWrWZUrkF4tR1Q3Kdt5SrR7aLYb6
         oHAdggQp8Hbp2X180xtn8y1+bw1QfnsiMj67Sjz8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1530773721-14668-3-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org, Taniya Das <tdas@codeaurora.org>
References: <1530773721-14668-1-git-send-email-tdas@codeaurora.org>
 <1530773721-14668-3-git-send-email-tdas@codeaurora.org>
Message-ID: <153092037708.143105.10977459810239534218@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Fri, 06 Jul 2018 16:39:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-04 23:55:21)
> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc=
-sdm845.c
> new file mode 100644
> index 0000000..5285b26
> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,lpass-sdm845.h>
> +
> +#include "clk-regmap.h"
> +#include "clk-branch.h"
> +#include "common.h"
> +
> +static struct clk_branch gcc_lpass_q6_axi_clk =3D {
> +       .halt_reg =3D 0x0,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x0,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_lpass_q6_axi_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_lpass_sway_clk =3D {
> +       .halt_reg =3D 0x8,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x8,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_lpass_sway_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch lpass_audio_wrapper_aon_clk =3D {
> +       .halt_reg =3D 0x098,
> +       .halt_check =3D BRANCH_VOTED,
> +       .clkr =3D {
> +               .enable_reg =3D 0x098,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_audio_wrapper_aon_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch lpass_q6ss_ahbm_aon_clk =3D {
> +       .halt_reg =3D 0x12000,
> +       .halt_check =3D BRANCH_VOTED,

I'll take your word for it.

> +       .clkr =3D {
> +               .enable_reg =3D 0x12000,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_q6ss_ahbm_aon_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch lpass_q6ss_ahbs_aon_clk =3D {
> +       .halt_reg =3D 0x1f000,
> +       .halt_check =3D BRANCH_VOTED,
> +       .clkr =3D {
> +               .enable_reg =3D 0x1f000,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_q6ss_ahbs_aon_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch lpass_qdsp6ss_xo_clk =3D {
> +       .halt_reg =3D 0x18,
> +       .halt_check =3D BRANCH_HALT_SKIP,

Why? Hint, add a comment.

> +       .clkr =3D {
> +               .enable_reg =3D 0x18,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_qdsp6ss_xo_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch lpass_qdsp6ss_sleep_clk =3D {
> +       .halt_reg =3D 0x1c,
> +       .halt_check =3D BRANCH_HALT_SKIP,

Why? Hint, add a comment.

> +       .clkr =3D {
> +               .enable_reg =3D 0x1c,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_qdsp6ss_sleep_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch lpass_qdsp6ss_core_clk =3D {
> +       .halt_reg =3D 0x0,
> +       .halt_check =3D BRANCH_HALT_SKIP,

Again.

> +       .clkr =3D {
> +               .enable_reg =3D 0x0,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_qdsp6ss_core_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct regmap_config lpass_regmap_config =3D {
> +       .reg_bits       =3D 32,
> +       .reg_stride     =3D 4,
> +       .val_bits       =3D 32,
> +       .fast_io        =3D true,
> +};
> +
> +static struct clk_regmap *lpass_gcc_sdm845_clocks[] =3D {
> +       [GCC_LPASS_Q6_AXI_CLK] =3D &gcc_lpass_q6_axi_clk.clkr,
> +       [GCC_LPASS_SWAY_CLK] =3D &gcc_lpass_sway_clk.clkr,
> +};
> +
> +static const struct qcom_cc_desc lpass_gcc_sdm845_desc =3D {
> +       .config =3D &lpass_regmap_config,
> +       .clks =3D lpass_gcc_sdm845_clocks,
> +       .num_clks =3D ARRAY_SIZE(lpass_gcc_sdm845_clocks),
> +};
> +
> +static struct clk_regmap *lpass_cc_sdm845_clocks[] =3D {
> +       [LPASS_AUDIO_WRAPPER_AON_CLK] =3D &lpass_audio_wrapper_aon_clk.cl=
kr,
> +       [LPASS_Q6SS_AHBM_AON_CLK] =3D &lpass_q6ss_ahbm_aon_clk.clkr,
> +       [LPASS_Q6SS_AHBS_AON_CLK] =3D &lpass_q6ss_ahbs_aon_clk.clkr,

So it's kinda sad that these lists have holes in them and we just waste
space forever the more we add. How about using the same linear array,
but indexing into the array with different offsets based on the start of
the numberspace for those clks? It would mean that adding new clks
wouldn't work, so add all the clks now instead of later.

Otherwise, maybe we need to add support for qcom_cc_desc having two
cells and then indicating which first cell to map into? So the binding
would look like:

	<&lpasscc 0 GCC_LPASS_Q6_AXI_CLK>

	<&lpasscc 1 LPASS_Q6SS_AHBM_AON_CLK>

and our lookup function would need to be different for the multi-cell
thing, but otherwise works and avoids the hole and adding numbers later
problem.

> +};
> +
> +static const struct qcom_cc_desc lpass_cc_sdm845_desc =3D {
> +       .config =3D &lpass_regmap_config,
> +       .clks =3D lpass_cc_sdm845_clocks,
> +       .num_clks =3D ARRAY_SIZE(lpass_cc_sdm845_clocks),
> +};
> +
> +static struct clk_regmap *lpass_qdsp6ss_sdm845_clocks[] =3D {
> +       [LPASS_QDSP6SS_XO_CLK] =3D &lpass_qdsp6ss_xo_clk.clkr,
> +       [LPASS_QDSP6SS_SLEEP_CLK] =3D &lpass_qdsp6ss_sleep_clk.clkr,
> +       [LPASS_QDSP6SS_CORE_CLK] =3D &lpass_qdsp6ss_core_clk.clkr,
> +};
> +
> +static const struct qcom_cc_desc lpass_qdsp6ss_sdm845_desc =3D {
> +       .config =3D &lpass_regmap_config,
> +       .clks =3D lpass_qdsp6ss_sdm845_clocks,
> +       .num_clks =3D ARRAY_SIZE(lpass_qdsp6ss_sdm845_clocks),
> +};
> +
> +static int lpass_clocks_sdm845_probe(struct platform_device *pdev, int i=
ndex,
> +                                    const struct qcom_cc_desc *desc)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct regmap *regmap;
> +       struct resource res;
> +       void __iomem *base;
> +
> +       if (of_address_to_resource(np, index, &res))

Just use platform device APIs instead please.

> +               return -ENOMEM;
> +
> +       base =3D devm_ioremap(&pdev->dev, res.start, resource_size(&res));

And devm_ioremap_resource().

> +       if (IS_ERR(base))
> +               return -ENOMEM;
> +
> +       regmap =3D devm_regmap_init_mmio(&pdev->dev, base, desc->config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       return qcom_cc_really_probe(pdev, desc, regmap);
> +}
> +
> +/* LPASS CC clock controller */
> +static const struct of_device_id lpass_cc_sdm845_match_table[] =3D {
> +       { .compatible =3D "qcom,sdm845-lpasscc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);
> +
> +static int lpass_cc_sdm845_probe(struct platform_device *pdev)
> +{
> +       const struct qcom_cc_desc *desc;
> +       struct device_node *np;
> +       int ret, index;
> +
> +       np =3D pdev->dev.of_node;
> +
> +       lpass_regmap_config.name =3D "lpass_gcc";
> +       desc =3D &lpass_gcc_sdm845_desc;
> +       index =3D of_property_match_string(np, "reg-names", "lpass_gcc");
> +
> +       ret =3D lpass_clocks_sdm845_probe(pdev, index, desc);
> +       if (ret)
> +               return ret;
> +
> +       lpass_regmap_config.name =3D "lpass_cc";
> +       desc =3D &lpass_cc_sdm845_desc;
> +       index =3D of_property_match_string(np, "reg-names", "lpass_cc");
> +
> +       ret =3D lpass_clocks_sdm845_probe(pdev, index, desc);
> +       if (ret)
> +               return ret;
> +
> +       lpass_regmap_config.name =3D "lpass_qdsp6ss";
> +       desc =3D &lpass_qdsp6ss_sdm845_desc;
> +       index =3D of_property_match_string(np, "reg-names", "lpass_qdsp6s=
s");

We shouldn't need to do this. Just index them by number and specify that
the order has to be exactly that order. reg-names is supposed to be
optional.

> +
> +       ret =3D lpass_clocks_sdm845_probe(pdev, index, desc);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

Just 'return lpass_clocks_sdm845_probe()'.

