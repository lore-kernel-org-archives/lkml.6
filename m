Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F2476C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9432720693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2KwqQaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9432720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeFLHzp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933362AbeFLHzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:55:43 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A75620693;
        Tue, 12 Jun 2018 07:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528790142;
        bh=2rr30pY2eC0Pst2JIPC0JH1I8mglIOAp2cbun6tWXR0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=s2KwqQaA0oETcOaEigIGQuGBbvXFSiaAvQn7nsyn5U2lKtDqIaBlwCKbvKfhBAvSu
         k+5a8Be9U+Zk7vtVCIXkKyjEX5nMlvqNjnO9oYttWGiE5+sJuEtICi1bzo0HxYbRcK
         93PgjIxWJ3Y3eX1igQgp7MzjMA4CyVz6pUku9rJs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, robh@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528098985-3676-3-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
 <1528098985-3676-3-git-send-email-tdas@codeaurora.org>
Message-ID: <152879014163.16708.9093599796057889104@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: Add display clock controller driver for SDM845
Date:   Tue, 12 Jun 2018 00:55:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-06-04 00:56:25)
> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-s=
dm845.c
> new file mode 100644
> index 0000000..317ab33
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> @@ -0,0 +1,679 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/qcom,dispcc-sdm845.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"

Used?

> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }

We really need to move this into the header file.

$ git grep '#define F(' -- drivers/clk/qcom/ | wc -l
13

> +
[...]
> +static const char * const disp_cc_parent_names_4[] =3D {
> +       "bi_tcxo",
> +       "dsi0_phy_pll_out_dsiclk",
> +       "dsi1_phy_pll_out_dsiclk",
> +       "core_bi_pll_test_se",
> +};
> +
> +static const struct alpha_pll_config disp_cc_pll0_config =3D {
> +       .l =3D 0x2c,
> +       .alpha =3D 0xcaaa,
> +};

Any reason this can't be put on the stack in the probe function?

> +
> +static struct clk_alpha_pll disp_cc_pll0 =3D {
> +       .offset =3D 0x0,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "disp_cc_pll0",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
[...]
> +
> +static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src =3D {
> +       .cmd_rcgr =3D 0x2058,
> +       .mnd_width =3D 8,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_4,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_pclk0_clk_src",
> +               .parent_names =3D disp_cc_parent_names_4,
> +               .num_parents =3D 4,
> +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,

Why is the nocache flag needed? Applies to all clks in this file.

> +               .ops =3D &clk_pixel_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src =3D {
> +       .cmd_rcgr =3D 0x2070,
> +       .mnd_width =3D 8,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_4,
> +       .clkr.hw.init =3D &(struct clk_init_data){
[...]
> +
> +static const struct regmap_config disp_cc_sdm845_regmap_config =3D {
> +       .reg_bits       =3D 32,
> +       .reg_stride     =3D 4,
> +       .val_bits       =3D 32,
> +       .max_register   =3D 0x10000,

This seems arbitrarily large. List the actual end?

> +       .fast_io        =3D true,
> +};
> +
> +static const struct qcom_cc_desc disp_cc_sdm845_desc =3D {
> +       .config =3D &disp_cc_sdm845_regmap_config,
> +       .clks =3D disp_cc_sdm845_clocks,
> +       .num_clks =3D ARRAY_SIZE(disp_cc_sdm845_clocks),
> +       .resets =3D disp_cc_sdm845_resets,
> +       .num_resets =3D ARRAY_SIZE(disp_cc_sdm845_resets),
> +       .gdscs =3D disp_cc_sdm845_gdscs,
> +       .num_gdscs =3D ARRAY_SIZE(disp_cc_sdm845_gdscs),
> +};
> +
> +static const struct of_device_id disp_cc_sdm845_match_table[] =3D {
> +       { .compatible =3D "qcom,sdm845-dispcc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, disp_cc_sdm845_match_table);
> +
> +static int disp_cc_sdm845_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +
> +       regmap =3D qcom_cc_map(pdev, &disp_cc_sdm845_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_fabia_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_conf=
ig);
> +
> +       /* Enable clock gating for DSI and MDP clocks */

Hardware clock gating? What does this mean.

> +       regmap_update_bits(regmap, 0x8000, 0x7f0, 0x7f0);
> +
> +       return qcom_cc_really_probe(pdev, &disp_cc_sdm845_desc, regmap);
> +}
