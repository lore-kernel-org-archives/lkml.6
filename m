Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52449ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0245C21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj63CbNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0245C21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJQXe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbeJQXe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:34:58 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A71E2150F;
        Wed, 17 Oct 2018 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539790721;
        bh=0FCOWpxMGzqK2VcdSp/uehHBCxlxOrZMzG5CHs994LY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=nj63CbNc0wZYChOd/Tf+wEyTBCz/gYGMer1SmEXpsNMvfcfXUTTU2KQSJIVsbURMh
         q2a2hyjf35uKpuqx9BPqgCO7UBoraufBbZBcoHhWIextiGheVLHC3pN51kEiZ7XqNh
         73r0JQdhW+NOTZqGpkyZ1hAbeTmEB7VPD/8d+Xrs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     ilia.lin@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180614215358.11264-5-ilia.lin@gmail.com>
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-5-ilia.lin@gmail.com>
Message-ID: <153979072095.5275.10118894326299332053@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 4/8] clk: qcom: Add CPU clock driver for msm8996
Date:   Wed, 17 Oct 2018 08:38:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ilia.lin@gmail.com (2018-06-14 14:53:51)
>  drivers/clk/qcom/Kconfig         |  10 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/clk-alpha-pll.h |   6 +
>  drivers/clk/qcom/clk-cpu-8996.c  | 403 +++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 420 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
> =

> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 9c3480dcc38a..fe01df59f923 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -33,6 +33,16 @@ config QCOM_CLK_APCS_MSM8916
>           Say Y if you want to support CPU frequency scaling on devices
>           such as msm8916.
>  =

> +config QCOM_CLK_APCC_MSM8996
> +       tristate "MSM8996 CPU Clock Controller"
> +       depends on ARM64
> +       depends on COMMON_CLK_QCOM
> +       select QCOM_KRYO_L2_ACCESSORS
> +       help
> +         Support for the CPU clock controller on msm8996 devices.
> +         Say Y if you want to support CPU clock scaling using CPUfreq
> +         drivers for dyanmic power management.

APCC comes before APCS alphabetically, so move this up above the other
config please.

> +
>  config QCOM_CLK_RPM
>         tristate "RPM based Clock Controller"
>         depends on COMMON_CLK_QCOM && MFD_QCOM_RPM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 762c01137c2f..d142778f6e92 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_MSM_MMCC_8974) +=3D mmcc-msm8974.o
>  obj-$(CONFIG_MSM_MMCC_8996) +=3D mmcc-msm8996.o
>  obj-$(CONFIG_QCOM_A53PLL) +=3D a53-pll.o
>  obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) +=3D apcs-msm8916.o
> +obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) +=3D clk-cpu-8996.o
>  obj-$(CONFIG_QCOM_CLK_RPM) +=3D clk-rpm.o
>  obj-$(CONFIG_QCOM_CLK_SMD_RPM) +=3D clk-smd-rpm.o
>  obj-$(CONFIG_SDM_GCC_845) +=3D gcc-sdm845.o
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alph=
a-pll.h
> index f981b486c468..9ce2a32f30ab 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -50,6 +50,12 @@ struct pll_vco {
>         u32 val;
>  };
>  =

> +#define VCO(a, b, c) { \
> +       .val =3D a,\
> +       .min_freq =3D b,\
> +       .max_freq =3D c,\
> +}
> +
>  /**
>   * struct clk_alpha_pll - phase locked loop (PLL)
>   * @offset: base address of registers
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8=
996.c
> new file mode 100644
> index 000000000000..d92cad93af20
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +/*
> + * Each of the CPU clusters (Power and Perf) on msm8996 are
> + * clocked via 2 PLLs, a primary and alternate. There are also
> + * 2 Mux'es, a primary and secondary all connected together
> + * as shown below
> + *
> + *                              +-------+
> + *               XO             |       |
> + *           +------------------>0      |
> + *                              |       |
> + *                    PLL/2     | SMUX  +----+
> + *                      +------->1      |    |
> + *                      |       |       |    |
> + *                      |       +-------+    |    +-------+
> + *                      |                    +---->0      |
> + *                      |                         |       |
> + * +---------------+    |             +----------->1      | CPU clk
> + * |Primary PLL    +----+ PLL_EARLY   |           |       +------>
> + * |               +------+-----------+    +------>2 PMUX |
> + * +---------------+      |                |      |       |
> + *                        |   +------+     |   +-->3      |
> + *                        +--^+  ACD +-----+   |  +-------+
> + * +---------------+          +------+         |
> + * |Alt PLL        |                           |
> + * |               +---------------------------+
> + * +---------------+         PLL_EARLY
> + *
> + * The primary PLL is what drives the CPU clk, except for times
> + * when we are reprogramming the PLL itself (for rate changes) when
> + * we temporarily switch to an alternate PLL. A subsequent patch adds
> + * support to switch between primary and alternate PLL during rate
> + * changes.
> + *
> + * The primary PLL operates on a single VCO range, between 600MHz
> + * and 3GHz. However the CPUs do support OPPs with frequencies
> + * between 300MHz and 600MHz. In order to support running the CPUs
> + * at those frequencies we end up having to lock the PLL at twice
> + * the rate and drive the CPU clk via the PLL/2 output and SMUX.
> + *
> + * So for frequencies above 600MHz we follow the following path
> + *  Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
> + * and for frequencies between 300MHz and 600MHz we follow
> + *  Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk
> + * Support for this is added in a subsequent patch as well.
> + *
> + * ACD stands for Adaptive Clock Distribution and is used to
> + * detect voltage droops.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

include clk-provider.h?

> +
> +#include "clk-alpha-pll.h"
> +#include "clk-regmap.h"
> +
> +enum _pmux_input {

Is this enum used?

> +       DIV_2_INDEX =3D 0,
> +       PLL_INDEX,
> +       ACD_INDEX,
> +       ALT_INDEX,
> +       NUM_OF_PMUX_INPUTS
> +};
> +
> +static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] =3D {
> +       [PLL_OFF_L_VAL] =3D 0x04,
> +       [PLL_OFF_ALPHA_VAL] =3D 0x08,
> +       [PLL_OFF_USER_CTL] =3D 0x10,
> +       [PLL_OFF_CONFIG_CTL] =3D 0x18,
> +       [PLL_OFF_CONFIG_CTL_U] =3D 0x1c,
> +       [PLL_OFF_TEST_CTL] =3D 0x20,
> +       [PLL_OFF_TEST_CTL_U] =3D 0x24,
> +       [PLL_OFF_STATUS] =3D 0x28,
> +};
> +
> +static const u8 alt_pll_regs[PLL_OFF_MAX_REGS] =3D {
> +       [PLL_OFF_L_VAL] =3D 0x04,
> +       [PLL_OFF_ALPHA_VAL] =3D 0x08,
> +       [PLL_OFF_ALPHA_VAL_U] =3D 0x0c,
> +       [PLL_OFF_USER_CTL] =3D 0x10,
> +       [PLL_OFF_USER_CTL_U] =3D 0x14,
> +       [PLL_OFF_CONFIG_CTL] =3D 0x18,
> +       [PLL_OFF_TEST_CTL] =3D 0x20,
> +       [PLL_OFF_TEST_CTL_U] =3D 0x24,
> +       [PLL_OFF_STATUS] =3D 0x28,
> +};
> +
> +/* PLLs */
> +
> +static const struct alpha_pll_config hfpll_config =3D {
> +       .l =3D 60,
> +       .config_ctl_val =3D 0x200d4828,
> +       .config_ctl_hi_val =3D 0x006,
> +       .pre_div_mask =3D BIT(12),
> +       .post_div_mask =3D 0x3 << 8,
> +       .main_output_mask =3D BIT(0),
> +       .early_output_mask =3D BIT(3),
> +};
> +
> +static struct clk_alpha_pll perfcl_pll =3D {
> +       .offset =3D 0x80000,
> +       .regs =3D prim_pll_regs,
> +       .flags =3D SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "perfcl_pll",
> +               .parent_names =3D (const char *[]){ "xo" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_huayra_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll pwrcl_pll =3D {
> +       .offset =3D 0x0,
> +       .regs =3D prim_pll_regs,
> +       .flags =3D SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "pwrcl_pll",
> +               .parent_names =3D (const char *[]){ "xo" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_huayra_ops,
> +       },
> +};
> +
> +static const struct pll_vco alt_pll_vco_modes[] =3D {
> +       VCO(3,  250000000,  500000000),
> +       VCO(2,  500000000,  750000000),
> +       VCO(1,  750000000, 1000000000),
> +       VCO(0, 1000000000, 2150400000),
> +};
> +
> +static const struct alpha_pll_config altpll_config =3D {
> +       .l =3D 16,
> +       .vco_val =3D 0x3 << 20,
> +       .vco_mask =3D 0x3 << 20,
> +       .config_ctl_val =3D 0x4001051b,
> +       .post_div_mask =3D 0x3 << 8,
> +       .post_div_val =3D 0x1,
> +       .main_output_mask =3D BIT(0),
> +       .early_output_mask =3D BIT(3),
> +};
> +
> +static struct clk_alpha_pll perfcl_alt_pll =3D {
> +       .offset =3D 0x80100,
> +       .regs =3D alt_pll_regs,
> +       .vco_table =3D alt_pll_vco_modes,
> +       .num_vco =3D ARRAY_SIZE(alt_pll_vco_modes),
> +       .flags =3D SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init =3D &(struct clk_init_data) {
> +               .name =3D "perfcl_alt_pll",
> +               .parent_names =3D (const char *[]){ "xo" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_hwfsm_ops,
> +       },
> +};
> +
> +static struct clk_alpha_pll pwrcl_alt_pll =3D {
> +       .offset =3D 0x100,
> +       .regs =3D alt_pll_regs,
> +       .vco_table =3D alt_pll_vco_modes,
> +       .num_vco =3D ARRAY_SIZE(alt_pll_vco_modes),
> +       .flags =3D SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
> +       .clkr.hw.init =3D &(struct clk_init_data) {
> +               .name =3D "pwrcl_alt_pll",
> +               .parent_names =3D (const char *[]){ "xo" },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_hwfsm_ops,
> +       },
> +};
> +
> +/* Mux'es */

Nitpick: I have no idea why muxes is written as mux'es. Please drop the
apostrophe.

> +
> +struct clk_cpu_8996_mux {
> +       u32     reg;
> +       u8      shift;
> +       u8      width;
> +       struct clk_hw   *pll;
> +       struct clk_regmap clkr;
> +};
> +
> +static inline
> +struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
> +{
> +       return container_of(to_clk_regmap(hw), struct clk_cpu_8996_mux, c=
lkr);
> +}
> +
> +static u8 clk_cpu_8996_mux_get_parent(struct clk_hw *hw)
> +{
> +       u32 val;
> +       struct clk_regmap *clkr =3D to_clk_regmap(hw);
> +       struct clk_cpu_8996_mux *cpuclk =3D to_clk_cpu_8996_mux_hw(hw);
> +       u32 mask =3D (u32)GENMASK(cpuclk->width - 1, 0);
> +
> +       regmap_read(clkr->regmap, cpuclk->reg, &val);
> +       val >>=3D (u32)(cpuclk->shift);
> +
> +       return (u8)(val & mask);

Nitpick: What's with all the casts in here? Can they be removed?

> +}
> +
> +static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       u32 val;
> +       struct clk_regmap *clkr =3D to_clk_regmap(hw);
> +       struct clk_cpu_8996_mux *cpuclk =3D to_clk_cpu_8996_mux_hw(hw);
> +       unsigned int mask =3D GENMASK(cpuclk->width + cpuclk->shift - 1,
> +                                   cpuclk->shift);

Maybe this can be a u32 so it fits on one line?

> +
> +       val =3D (u32)index;
> +       val <<=3D (u32)(cpuclk->shift);
> +
> +       return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);

Same comment about casting.

> +}
> +
> +static int
> +clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_reque=
st *req)
> +{
> +       struct clk_cpu_8996_mux *cpuclk =3D to_clk_cpu_8996_mux_hw(hw);
> +       struct clk_hw *parent =3D cpuclk->pll;
> +
> +       req->best_parent_rate =3D clk_hw_round_rate(parent, req->rate);
> +       req->best_parent_hw =3D parent;
> +
> +       return 0;

What's the necessity of this function? Is the parent not always
cpuclk->pll?

> +}
> +
> +const struct clk_ops clk_cpu_8996_mux_ops =3D {

static?

> +       .set_parent =3D clk_cpu_8996_mux_set_parent,
> +       .get_parent =3D clk_cpu_8996_mux_get_parent,
> +       .determine_rate =3D clk_cpu_8996_mux_determine_rate,
> +};
> +
> +static struct clk_cpu_8996_mux pwrcl_smux =3D {
> +       .reg =3D 0x40,
> +       .shift =3D 2,
> +       .width =3D 2,
> +       .clkr.hw.init =3D &(struct clk_init_data) {
> +               .name =3D "pwrcl_smux",
> +               .parent_names =3D (const char *[]){
> +                       "xo",
> +                       "pwrcl_pll_main",
> +               },
> +               .num_parents =3D 2,
> +               .ops =3D &clk_cpu_8996_mux_ops,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_cpu_8996_mux perfcl_smux =3D {
> +       .reg =3D 0x80040,
> +       .shift =3D 2,
> +       .width =3D 2,
> +       .clkr.hw.init =3D &(struct clk_init_data) {
> +               .name =3D "perfcl_smux",
> +               .parent_names =3D (const char *[]){
> +                       "xo",
> +                       "perfcl_pll_main",
> +               },
> +               .num_parents =3D 2,
> +               .ops =3D &clk_cpu_8996_mux_ops,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_cpu_8996_mux pwrcl_pmux =3D {
> +       .reg =3D 0x40,
> +       .shift =3D 0,
> +       .width =3D 2,
> +       .pll =3D &pwrcl_pll.clkr.hw,
> +       .clkr.hw.init =3D &(struct clk_init_data) {
> +               .name =3D "pwrcl_pmux",
> +               .parent_names =3D (const char *[]){
> +                       "pwrcl_smux",
> +                       "pwrcl_pll",
> +                       "pwrcl_pll_acd",
> +                       "pwrcl_alt_pll",
> +               },
> +               .num_parents =3D 4,
> +               .ops =3D &clk_cpu_8996_mux_ops,
> +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,

Please comment why CLK_IGNORE_UNUSED is used here.

> +       },
> +};
> +
> +static struct clk_cpu_8996_mux perfcl_pmux =3D {
> +       .reg =3D 0x80040,
> +       .shift =3D 0,
> +       .width =3D 2,
> +       .pll =3D &perfcl_pll.clkr.hw,
> +       .clkr.hw.init =3D &(struct clk_init_data) {
> +               .name =3D "perfcl_pmux",
> +               .parent_names =3D (const char *[]){
> +                       "perfcl_smux",
> +                       "perfcl_pll",
> +                       "perfcl_pll_acd",
> +                       "perfcl_alt_pll",
> +               },
> +               .num_parents =3D 4,
> +               .ops =3D &clk_cpu_8996_mux_ops,
> +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,

Same. I guess it's because these clks should never be turned off?

> +       },
> +};
> +
> +static const struct regmap_config cpu_msm8996_regmap_config =3D {
> +       .reg_bits               =3D 32,
> +       .reg_stride             =3D 4,
> +       .val_bits               =3D 32,
> +       .max_register           =3D 0x80210,
> +       .fast_io                =3D true,
> +       .val_format_endian      =3D REGMAP_ENDIAN_LITTLE,

IS the endian thing needed? I don't think that has mattered before.

> +};
> +
> +struct clk_regmap *clks[] =3D {

Please name this something a little more cpu_clk_msm8996 specific.

> +       &perfcl_pll.clkr,
> +       &pwrcl_pll.clkr,
> +       &perfcl_alt_pll.clkr,
> +       &pwrcl_alt_pll.clkr,
> +       &perfcl_smux.clkr,
> +       &pwrcl_smux.clkr,
> +       &perfcl_pmux.clkr,
> +       &pwrcl_pmux.clkr,
> +};
> +
> +static int
> +qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *re=
gmap)
> +{
> +       int i, ret;
> +
> +       perfcl_smux.pll =3D clk_hw_register_fixed_factor(dev, "perfcl_pll=
_main",
> +                                                      "perfcl_pll",
> +                                                  CLK_SET_RATE_PARENT, 1=
, 2);
> +
> +       pwrcl_smux.pll =3D clk_hw_register_fixed_factor(dev, "pwrcl_pll_m=
ain",
> +                                                     "pwrcl_pll",
> +                                                  CLK_SET_RATE_PARENT, 1=
, 2);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(clks); i++) {
> +               ret =3D devm_clk_register_regmap(dev, clks[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
> +       clk_alpha_pll_configure(&pwrcl_pll, regmap, &hfpll_config);
> +       clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
> +       clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
> +
> +       return ret;

Slam this function into probe? I don't see the need to split it out.

> +}
> +
> +static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pde=
v)
> +{
> +       int ret;
> +       void __iomem *base;
> +       struct resource *res;
> +       struct regmap *regmap;
> +       struct clk_hw_onecell_data *data;
> +       struct device *dev =3D &pdev->dev;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data) + 2 * sizeof(struct clk_=
hw *),
> +                           GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap =3D devm_regmap_init_mmio(dev, base, &cpu_msm8996_regmap_c=
onfig);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       ret =3D qcom_cpu_clk_msm8996_register_clks(dev, regmap);
> +       if (ret)
> +               return ret;
> +
> +       data->hws[0] =3D &pwrcl_pmux.clkr.hw;
> +       data->hws[1] =3D &perfcl_pmux.clkr.hw;
> +       data->num =3D 2;
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, da=
ta);
> +}
> +
> +static const struct of_device_id qcom_cpu_clk_msm8996_match_table[] =3D {
> +       { .compatible =3D "qcom,msm8996-apcc" },
> +       {}
> +};

Add a module device table macro?

> +
> +static struct platform_driver qcom_cpu_clk_msm8996_driver =3D {
> +       .probe =3D qcom_cpu_clk_msm8996_driver_probe,
> +       .driver =3D {
> +               .name =3D "qcom-msm8996-apcc",
> +               .of_match_table =3D qcom_cpu_clk_msm8996_match_table,
> +       },
> +};
> +module_platform_driver(qcom_cpu_clk_msm8996_driver);
> +
> +MODULE_ALIAS("platform:msm8996-apcc");
> +MODULE_DESCRIPTION("QCOM MSM8996 CPU Clock Driver");
> +MODULE_LICENSE("GPL v2");
