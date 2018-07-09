Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F39C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9C2208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Burr/ng0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9C2208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeGIGHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754544AbeGIGHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:07:32 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEC0208AF;
        Mon,  9 Jul 2018 06:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531116451;
        bh=DN/0HCKmUUVc/K4mFSoTaAwo3rdUym/+SyLGHG6dEUQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Burr/ng0eco8qxS6uqfsCUkxcYIDc94kwCmNROqc1jmG648T2Br6x3CR3PSSQIY0W
         toFfTL0ofVpoAMu9f/oW5XHIVCP/6GldKsK0Qavi6ONCujVf/S/Bb6sMrrppIAisiS
         HuheGLgXxE6tln6zwdKibw9DrsF2vf34ouGEf9xM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528285308-25477-5-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-5-git-send-email-anischal@codeaurora.org>
Message-ID: <153111645061.143105.8885901620675705971@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 4/4] clk: qcom: Add graphics clock controller driver for SDM845
Date:   Sun, 08 Jul 2018 23:07:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-06-06 04:41:48)
> diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm=
845.c
> new file mode 100644
> index 0000000..81f8926
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sdm845.c
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
> +
> +#include "common.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "gdsc.h"
> +
> +#define CX_GMU_CBCR_SLEEP_MASK         0xf
> +#define CX_GMU_CBCR_SLEEP_SHIFT                4
> +#define CX_GMU_CBCR_WAKE_MASK          0xf
> +#define CX_GMU_CBCR_WAKE_SHIFT         8
> +#define CLK_DIS_WAIT_SHIFT             12
> +#define CLK_DIS_WAIT_MASK              (0xf << CLK_DIS_WAIT_SHIFT)
> +
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }

This should be removed and series can depend on Taniya's patch.

> +
> +enum {
> +       P_BI_TCXO,
> +       P_CORE_BI_PLL_TEST_SE,
> +       P_GPLL0_OUT_MAIN,
> +       P_GPLL0_OUT_MAIN_DIV,
[...]
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gpu_cc_pll0",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
> +
> +static const struct clk_div_table post_div_table_fabia_even[] =3D {
> +       { 0x0, 1 },
> +       {},

Drop the trailing comma, it's a sentinel presumably.

> +};
> +
> +static struct clk_alpha_pll_postdiv gpu_cc_pll0_out_even =3D {
> +       .offset =3D 0x0,
> +       .post_div_shift =3D 8,
> +       .post_div_table =3D post_div_table_fabia_even,
> +       .num_post_div =3D ARRAY_SIZE(post_div_table_fabia_even),
> +       .width =3D 4,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "gpu_cc_pll0_out_even",
> +               .parent_names =3D (const char *[]){ "gpu_cc_pll0" },
> +               .num_parents =3D 1,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_alpha_pll_postdiv_fabia_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll1 =3D {
> +       .offset =3D 0x100,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gpu_cc_pll1",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] =3D {
> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> +       F(200000000, P_GPLL0_OUT_MAIN_DIV, 1.5, 0, 0),
> +       F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gmu_clk_src =3D {
> +       .cmd_rcgr =3D 0x1120,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D gpu_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_gpu_cc_gmu_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "gpu_cc_gmu_clk_src",
> +               .parent_names =3D gpu_cc_parent_names_0,
> +               .num_parents =3D 6,
> +               .ops =3D &clk_rcg2_shared_ops,
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gx_gfx3d_clk_src[] =3D {
> +       F(180000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
> +       F(257000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
> +       F(342000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
> +       F(414000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
> +       F(520000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
> +       F(596000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
> +       F(675000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),
> +       F(710000000, P_GPU_CC_PLL0_OUT_EVEN, 2, 0, 0),

Do we really need to encode anything here in this table? Why can't we
have clk_ops that hardcode this clk to be a div-2 that passes the
frequency up to the parent source? Then this frequency table doesn't
need to be here at all, and can live in DT as an OPP table used by the
GPU driver.

> +       { }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gx_gfx3d_clk_src =3D {
> +       .cmd_rcgr =3D 0x101c,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D gpu_cc_parent_map_1,
> +       .freq_tbl =3D ftbl_gpu_cc_gx_gfx3d_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "gpu_cc_gx_gfx3d_clk_src",
> +               .parent_names =3D gpu_cc_parent_names_1,
> +               .num_parents =3D 7,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_gfx3d_ops,
[...]
> +static struct clk_branch gpu_cc_cx_gmu_clk =3D {
> +       .halt_reg =3D 0x1098,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x1098,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gpu_cc_cx_gmu_clk",
> +                       .parent_names =3D (const char *[]){
> +                               "gpu_cc_gmu_clk_src",
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gpu_cc_cx_snoc_dvm_clk =3D {
> +       .halt_reg =3D 0x108c,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x108c,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gpu_cc_cx_snoc_dvm_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gpu_cc_cxo_clk =3D {

This isn't always on and marked critical?

> +       .halt_reg =3D 0x109c,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x109c,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gpu_cc_cxo_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
[...]
> +
> +static struct gdsc gpu_cx_gdsc =3D {
> +       .gdscr =3D 0x106c,
> +       .gds_hw_ctrl =3D 0x1540,
> +       .pd =3D {
> +               .name =3D "gpu_cx_gdsc",
> +       },
> +       .pwrsts =3D PWRSTS_OFF_ON,
> +       .flags =3D VOTABLE,
> +};
> +
> +static struct gdsc gpu_gx_gdsc =3D {
> +       .gdscr =3D 0x100c,
> +       .clamp_io_ctrl =3D 0x1508,
> +       .pd =3D {
> +               .name =3D "gpu_gx_gdsc",
> +       },
> +       .clk_hws =3D {
> +               &gpu_cc_gx_gfx3d_clk_src.clkr.hw,

Hmm alright. So basically the core GPU power domain needs the wrapper
domain (CX) to be powered on and clocking for GX to work? Let's talk
about it in the other patch so I can understand more.

> +       },
> +       .clk_count =3D 1,
> +       .pwrsts =3D PWRSTS_OFF_ON,
> +       .flags =3D CLAMP_IO | AON_RESET | POLL_CFG_GDSCR,
> +};
> +
[...]
> +
> +static int gpu_cc_sdm845_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       unsigned int value, mask;
> +
> +       regmap =3D qcom_cc_map(pdev, &gpu_cc_sdm845_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_fabia_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config=
);
> +       clk_fabia_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config=
);
> +
> +       /* Configure gpu_cc_cx_gmu_clk with recommended wakeup/sleep sett=
ings */
> +       mask =3D CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
> +       mask |=3D CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
> +       value =3D 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEE=
P_SHIFT;
> +       regmap_update_bits(regmap, 0x1098, mask, value);
> +
> +       /* Configure clk_dis_wait for for gpu_cx_gdsc */

s/for //

> +       regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
> +                                               (8 << CLK_DIS_WAIT_SHIFT)=
);

Remove extra parenthesis.

> +
> +       return qcom_cc_really_probe(pdev, &gpu_cc_sdm845_desc, regmap);
> +}
> +
[...]
> +
> +MODULE_LICENSE("GPL v2");

MODULE_DESCRIPTION?

