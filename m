Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeDCMYp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:24:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:24:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Apr 2018 17:54:41 +0530
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH v2 4/4] clk: qcom: Add Global Clock controller (GCC)
 driver for SDM845
In-Reply-To: <152150657982.254778.14132033041219278756@swboyd.mtv.corp.google.com>
References: <1520493495-3084-1-git-send-email-anischal@codeaurora.org>
 <1520493495-3084-5-git-send-email-anischal@codeaurora.org>
 <152150657982.254778.14132033041219278756@swboyd.mtv.corp.google.com>
Message-ID: <624665d7af39686d331c863ba7b9af4d@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 06:12, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-03-07 23:18:15)
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index fbf4532..54d0545 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -218,6 +218,16 @@ config MSM_MMCC_8996
>>           Say Y if you want to support multimedia devices such as 
>> display,
>>           graphics, video encode/decode, camera, etc.
>> 
>> +config SDM_GCC_845
>> +       tristate "SDM845 Global Clock Controller"
>> +       depends on COMMON_CLK_QCOM
>> +       help
>> +         Support for the global clock controller on Qualcomm 
>> Technologies, Inc
>> +         sdm845 devices.
>> +         Say Y if you want to use peripheral devices such as UART, 
>> SPI,
>> +         i2c, USB, UFS, SD/eMMC, PCIe, etc.
>> +
>> +
> 
> Drop the double newline here please.

Thanks for the review. We will fix this in next patch series.

> 
>>  config SPMI_PMIC_CLKDIV
>>         tristate "SPMI PMIC clkdiv Support"
>>         depends on (COMMON_CLK_QCOM && SPMI) || COMPILE_TEST
>> @@ -226,3 +236,4 @@ config SPMI_PMIC_CLKDIV
>>           Technologies, Inc. SPMI PMIC. It configures the frequency of
>>           clkdiv outputs of the PMIC. These clocks are typically wired
>>           through alternate functions on GPIO pins.
>> +
> 
> Noise?

We will fix this in next patch series.

> 
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c 
>> b/drivers/clk/qcom/gcc-sdm845.c
>> new file mode 100644
>> index 0000000..3ffa098
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -0,0 +1,3619 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/bitops.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> +
>> +#include "common.h"
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "clk-rcg.h"
>> +#include "clk-branch.h"
>> +#include "clk-alpha-pll.h"
>> +#include "gdsc.h"
>> +#include "reset.h"
>> +
>> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
>> +
>> +static struct freq_tbl cxo_safe_src_f = {
>> +       .pre_div = 1,
>> +};
> 
> Still hoping this goes away.

With new implementation of rcg2 shared ops, there is no need to
pass safe source frequency table from the driver so we will address
this in V3 patch series.

> 
>> +
>> +enum {
>> +       P_BI_TCXO,
>> +       P_AUD_REF_CLK,
>> +       P_CORE_BI_PLL_TEST_SE,
>> +       P_GPLL0_OUT_EVEN,
>> +       P_GPLL0_OUT_MAIN,
>> +       P_GPLL4_OUT_MAIN,
>> +       P_SLEEP_CLK,
>> +};
> [...]
>> +       F(400000, P_BI_TCXO, 12, 1, 4),
>> +       F(9600000, P_BI_TCXO, 2, 0, 0),
>> +       F(19200000, P_BI_TCXO, 1, 0, 0),
>> +       F(25000000, P_GPLL0_OUT_MAIN, 12, 1, 2),
>> +       F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
>> +       F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
>> +       { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
>> +       .cmd_rcgr = 0x1600c,
>> +       .mnd_width = 8,
>> +       .hid_width = 5,
>> +       .parent_map = gcc_parent_map_0,
>> +       .freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
>> +       .safe_src_freq_tbl = &cxo_safe_src_f,
> 
> Why does sdcc have safe src stuff? Is something turning on the sdcc clk
> outside of our control?

I will get more details on this and will get back.

> 
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "gcc_sdcc4_apps_clk_src",
>> +               .parent_names = gcc_parent_names_0,
>> +               .num_parents = 4,
>> +               .flags = CLK_SET_RATE_PARENT,
>> +               .ops = &clk_rcg2_shared_ops,
>> +       },
>> +};
>> +
> [...]
>> +
>> +static struct clk_branch gcc_video_xo_clk = {
>> +       .halt_reg = 0xb028,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xb028,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_video_xo_clk",
>> +                       .flags = CLK_IS_CRITICAL,
>> +                       .ops = &clk_branch2_ops,
>> +
> 
> These things have no parents and we mark them critical. Why are we
> even exposing them to the kernel? Are they not on by default? Are we
> going to change these to non-critical at some point in the future?

These clocks are not enabled by default and going to video or other
multimedia cores so we are marking them as critical and need to expose
to the kernel. As of now, there is no plan to change these to 
non-critical.

> 
>> +static const struct regmap_config gcc_sdm845_regmap_config = {
>> +       .reg_bits       = 32,
>> +       .reg_stride     = 4,
>> +       .val_bits       = 32,
>> +       .max_register   = 0x182090,
> 
> Huge! :P
> 
>> +       .fast_io        = true,
>> +};
>> +
>> +static const struct qcom_cc_desc gcc_sdm845_desc = {
>> +       .config = &gcc_sdm845_regmap_config,
>> +       .clks = gcc_sdm845_clocks,
>> +       .num_clks = ARRAY_SIZE(gcc_sdm845_clocks),
>> +       .resets = gcc_sdm845_resets,
>> +       .num_resets = ARRAY_SIZE(gcc_sdm845_resets),
>> +       .gdscs = gcc_sdm845_gdscs,
>> +       .num_gdscs = ARRAY_SIZE(gcc_sdm845_gdscs),
>> +};
>> +
>> +static const struct of_device_id gcc_sdm845_match_table[] = {
>> +       { .compatible = "qcom,gcc-sdm845" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
>> +
>> +static int gcc_sdm845_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct regmap *regmap;
>> +       int i, ret;
>> +
>> +       regmap = qcom_cc_map(pdev, &gcc_sdm845_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       for (i = 0; i < ARRAY_SIZE(gcc_sdm845_hws); i++) {
>> +               ret = devm_clk_hw_register(dev, gcc_sdm845_hws[i]);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       /* Get the rate for safe source */
>> +       cxo_safe_src_f.freq = clk_get_rate(bi_tcxo.hw.clk);
> 
> Hopefully this can be dropped too.

Yes, we will fix this in next patch series.

> 
>> +
>> +       /* Disable the GPLL0 active input to MMSS and GPU via MISC 
>> registers */
>> +       regmap_update_bits(regmap, 0x09FFC, 0x3, 0x3);
>> +       regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> 
> Lowercase hex please.

We will fix this in next patch series.

> 
>> +
>> +       return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>> +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
