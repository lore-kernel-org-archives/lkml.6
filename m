Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB09EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916E82083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="It5lgbbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916E82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbeGZSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388905AbeGZSkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:40:18 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B0B20647;
        Thu, 26 Jul 2018 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532625751;
        bh=0Dr8EM/CFippevPcpSzy3EQA4ri5NkQOet9zF1GlGHY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=It5lgbbCjdIGOyr1xEprHmIVC1LklRKWgJLap0cWh4KYm7zbCpBPSjl0pi8qLMkcB
         f53xvcfl/mFFrZoXTL3iKzo7/YYmvpFE405cssWZnhPgH/gv8bBA4BkQEd+5lrlm4o
         vro2B5yBGir6Z5WIfS6qDIg3M6Ep2YwSnoslwtPM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532345193-18108-3-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1532345193-18108-1-git-send-email-anischal@codeaurora.org>
 <1532345193-18108-3-git-send-email-anischal@codeaurora.org>
Message-ID: <153262575082.48062.16264904338225269915@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: Add camera clock controller driver for SDM845
Date:   Thu, 26 Jul 2018 10:22:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-07-23 04:26:33)
> diff --git a/drivers/clk/qcom/camcc-sdm845.c b/drivers/clk/qcom/camcc-sdm=
845.c
> new file mode 100644
> index 0000000..61e5ec2
> --- /dev/null
> +++ b/drivers/clk/qcom/camcc-sdm845.c
> @@ -0,0 +1,1736 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,camcc-sdm845.h>
> +
> +#include "common.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "gdsc.h"
> +
> +enum {
> +       P_BI_TCXO,
> +       P_CAM_CC_PLL0_OUT_EVEN,
> +       P_CAM_CC_PLL1_OUT_EVEN,
> +       P_CAM_CC_PLL2_OUT_EVEN,
> +       P_CAM_CC_PLL3_OUT_EVEN,
> +       P_CORE_BI_PLL_TEST_SE,
> +};
> +
> +static const struct parent_map cam_cc_parent_map_0[] =3D {
> +       { P_BI_TCXO, 0 },
> +       { P_CAM_CC_PLL2_OUT_EVEN, 1 },
> +       { P_CAM_CC_PLL1_OUT_EVEN, 2 },
> +       { P_CAM_CC_PLL3_OUT_EVEN, 5 },
> +       { P_CAM_CC_PLL0_OUT_EVEN, 6 },
> +       { P_CORE_BI_PLL_TEST_SE, 7 },
> +};
> +
> +static const char * const cam_cc_parent_names_0[] =3D {
> +       "bi_tcxo",
> +       "cam_cc_pll2_out_even",
> +       "cam_cc_pll1_out_even",
> +       "cam_cc_pll3_out_even",
> +       "cam_cc_pll0_out_even",
> +       "core_bi_pll_test_se",
> +};
> +
> +static struct clk_alpha_pll cam_cc_pll0 =3D {
> +       .offset =3D 0x0,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "cam_cc_pll0",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
> +
> +static const struct clk_div_table post_div_table_fabia_even[] =3D {
> +       { 0x0, 1 },
> +       { 0x1, 2 },
> +       { }
> +};
> +
> +static struct clk_alpha_pll_postdiv cam_cc_pll0_out_even =3D {
> +       .offset =3D 0x0,
> +       .post_div_shift =3D 8,
> +       .post_div_table =3D post_div_table_fabia_even,
> +       .num_post_div =3D ARRAY_SIZE(post_div_table_fabia_even),
> +       .width =3D 4,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_pll0_out_even",
> +               .parent_names =3D (const char *[]){ "cam_cc_pll0" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_postdiv_fabia_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll cam_cc_pll1 =3D {
> +       .offset =3D 0x1000,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "cam_cc_pll1",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_alpha_pll_postdiv cam_cc_pll1_out_even =3D {
> +       .offset =3D 0x1000,
> +       .post_div_shift =3D 8,
> +       .post_div_table =3D post_div_table_fabia_even,
> +       .num_post_div =3D ARRAY_SIZE(post_div_table_fabia_even),
> +       .width =3D 4,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_pll1_out_even",
> +               .parent_names =3D (const char *[]){ "cam_cc_pll1" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_postdiv_fabia_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll cam_cc_pll2 =3D {
> +       .offset =3D 0x2000,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "cam_cc_pll2",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_alpha_pll_postdiv cam_cc_pll2_out_even =3D {
> +       .offset =3D 0x2000,
> +       .post_div_shift =3D 8,
> +       .post_div_table =3D post_div_table_fabia_even,
> +       .num_post_div =3D ARRAY_SIZE(post_div_table_fabia_even),
> +       .width =3D 4,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_pll2_out_even",
> +               .parent_names =3D (const char *[]){ "cam_cc_pll2" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_postdiv_fabia_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll cam_cc_pll3 =3D {
> +       .offset =3D 0x3000,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "cam_cc_pll3",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_alpha_pll_postdiv cam_cc_pll3_out_even =3D {
> +       .offset =3D 0x3000,
> +       .post_div_shift =3D 8,
> +       .post_div_table =3D post_div_table_fabia_even,
> +       .num_post_div =3D ARRAY_SIZE(post_div_table_fabia_even),
> +       .width =3D 4,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_pll3_out_even",
> +               .parent_names =3D (const char *[]){ "cam_cc_pll3" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_postdiv_fabia_ops,
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] =3D {
> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> +       F(100000000, P_CAM_CC_PLL0_OUT_EVEN, 6, 0, 0),
> +       F(200000000, P_CAM_CC_PLL0_OUT_EVEN, 3, 0, 0),
> +       F(404000000, P_CAM_CC_PLL1_OUT_EVEN, 2, 0, 0),
> +       F(480000000, P_CAM_CC_PLL2_OUT_EVEN, 1, 0, 0),
> +       F(600000000, P_CAM_CC_PLL0_OUT_EVEN, 1, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 cam_cc_bps_clk_src =3D {
> +       .cmd_rcgr =3D 0x600c,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D cam_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_cam_cc_bps_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_bps_clk_src",
> +               .parent_names =3D cam_cc_parent_names_0,
> +               .num_parents =3D 6,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_shared_ops,

Why are shared ops used in this driver?

> +       },
> +};
> +
> +static const struct freq_tbl ftbl_cam_cc_cci_clk_src[] =3D {
> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> +       F(37500000, P_CAM_CC_PLL0_OUT_EVEN, 16, 0, 0),
> +       F(50000000, P_CAM_CC_PLL0_OUT_EVEN, 12, 0, 0),
> +       F(100000000, P_CAM_CC_PLL0_OUT_EVEN, 6, 0, 0),
> +       { }
> +};
> +
[...]
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_mclk0_clk_src",
> +               .parent_names =3D cam_cc_parent_names_0,
> +               .num_parents =3D 6,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 cam_cc_mclk1_clk_src =3D {
> +       .cmd_rcgr =3D 0x4024,
> +       .mnd_width =3D 8,
> +       .hid_width =3D 5,
> +       .parent_map =3D cam_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_cam_cc_mclk0_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_mclk1_clk_src",
> +               .parent_names =3D cam_cc_parent_names_0,
> +               .num_parents =3D 6,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 cam_cc_mclk2_clk_src =3D {
> +       .cmd_rcgr =3D 0x4044,
> +       .mnd_width =3D 8,
> +       .hid_width =3D 5,
> +       .parent_map =3D cam_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_cam_cc_mclk0_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_mclk2_clk_src",
> +               .parent_names =3D cam_cc_parent_names_0,
> +               .num_parents =3D 6,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 cam_cc_mclk3_clk_src =3D {
> +       .cmd_rcgr =3D 0x4064,
> +       .mnd_width =3D 8,
> +       .hid_width =3D 5,
> +       .parent_map =3D cam_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_cam_cc_mclk0_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_mclk3_clk_src",
> +               .parent_names =3D cam_cc_parent_names_0,
> +               .num_parents =3D 6,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_cam_cc_slow_ahb_clk_src[] =3D {
> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> +       F(60000000, P_CAM_CC_PLL0_OUT_EVEN, 10, 0, 0),
> +       F(66666667, P_CAM_CC_PLL0_OUT_EVEN, 9, 0, 0),
> +       F(73846154, P_CAM_CC_PLL2_OUT_EVEN, 6.5, 0, 0),
> +       F(80000000, P_CAM_CC_PLL2_OUT_EVEN, 6, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 cam_cc_slow_ahb_clk_src =3D {
> +       .cmd_rcgr =3D 0x6054,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D cam_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_cam_cc_slow_ahb_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "cam_cc_slow_ahb_clk_src",
> +               .parent_names =3D cam_cc_parent_names_0,
> +               .num_parents =3D 6,
> +               .flags =3D CLK_SET_RATE_PARENT,

Is CLK_SET_RATE_PARENT intentionally set on these RCGs so that they can
reconfigure the PLL frequency? Wouldn't that be a fixed rate PLL
frequency?

> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
[...]
> +
> +static int cam_cc_sdm845_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       struct alpha_pll_config cam_cc_pll_config =3D { };
> +
> +       regmap =3D qcom_cc_map(pdev, &cam_cc_sdm845_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       cam_cc_pll_config.l =3D 0x1f,
> +       cam_cc_pll_config.alpha =3D 0x4000,

Replace these commas with semicolons.

> +       clk_fabia_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll_config);
> +
> +       cam_cc_pll_config.l =3D 0x2a,
> +       cam_cc_pll_config.alpha =3D 0x1556,
> +       clk_fabia_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll_config);

All over this function.

Can you also add comments in the commit text and code describing why
oddities like CLK_SET_RATE_PARENT on RCGs and shared rcg ops is used?

