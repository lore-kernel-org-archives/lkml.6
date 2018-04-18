Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeDRNDx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:03:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47690 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeDRNDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:03:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Apr 2018 18:33:49 +0530
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] clk: qcom: Add Global Clock controller (GCC)
 driver for SDM845
In-Reply-To: <152393708031.51482.15076025836699678476@swboyd.mtv.corp.google.com>
References: <1522761761-15262-1-git-send-email-anischal@codeaurora.org>
 <1522761761-15262-4-git-send-email-anischal@codeaurora.org>
 <152393708031.51482.15076025836699678476@swboyd.mtv.corp.google.com>
Message-ID: <f563532b5c43960a61ae12a37a131be8@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-17 09:21, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-04-03 06:22:41)
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index fbf4532..c961e89 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -218,6 +218,15 @@ config MSM_MMCC_8996
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
> 
> Is there eMMC?

Thanks for the review comments. There is no eMMC for SDM845. I will fix 
the
above in next patch series.

> 
>> +
>>  config SPMI_PMIC_CLKDIV
>>         tristate "SPMI PMIC clkdiv Support"
>>         depends on (COMMON_CLK_QCOM && SPMI) || COMPILE_TEST
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c 
>> b/drivers/clk/qcom/gcc-sdm845.c
>> new file mode 100644
>> index 0000000..b1b7a1e
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -0,0 +1,3546 @@
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
> 
> Is this include used?

No, it is not getting used. We will remove this in next patch series.

> 
>> +#include <linux/clk-provider.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
> [...]
>> +
>> +static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
>> +       .cmd_rcgr = 0xf030,
>> +       .mnd_width = 0,
>> +       .hid_width = 5,
>> +       .parent_map = gcc_parent_map_0,
>> +       .freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "gcc_usb30_prim_mock_utmi_clk_src",
>> +               .parent_names = gcc_parent_names_0,
>> +               .num_parents = 4,
>> +               .ops = &clk_rcg2_shared_ops,
> 
> Still shared? Why?

We would require the shared_ops for clocks which are configured by
bootloader.

> 
>> +
>> +static struct clk_branch gcc_video_ahb_clk = {
>> +       .halt_reg = 0xb004,
>> +       .halt_check = BRANCH_HALT,
>> +       .hwcg_reg = 0xb004,
>> +       .hwcg_bit = 1,
>> +       .clkr = {
>> +               .enable_reg = 0xb004,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_video_ahb_clk",
>> +                       .flags = CLK_IS_CRITICAL,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +
> 
> Weird double space here.

We will fix this in next patch series.

> 
>> +static struct clk_branch gcc_video_xo_clk = {
>> +       .halt_reg = 0xb028,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0xb028,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_video_xo_clk",
>> +                       .flags = CLK_IS_CRITICAL,
> 
> For these "critical" clks that don't have parents can you just throw 
> the
> enable part in the gcc driver probe and remove these clks from being
> exposed? They don't seem to provide any value to expose them as clks
> when they don't hook into the final clk tree.
> 

For all of the "critical" clocks which don't have parents, we have
removed the CRITICAL flag and mandate the clients to put their vote
to enable/disable them. Other than this, some of the "critical" clock
instances we have completely removed and enabled them in the probe.
This will be fixed in the next patch series.

>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch gcc_vs_ctrl_ahb_clk = {
>> +       .halt_reg = 0x7a014,
>> +       .halt_check = BRANCH_HALT,
>> +       .hwcg_reg = 0x7a014,
>> +       .hwcg_bit = 1,
>> +       .clkr = {
>> +               .enable_reg = 0x7a014,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_vs_ctrl_ahb_clk",
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static struct clk_branch gcc_vs_ctrl_clk = {
>> +       .halt_reg = 0x7a010,
>> +       .halt_check = BRANCH_HALT,
>> +       .clkr = {
>> +               .enable_reg = 0x7a010,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "gcc_vs_ctrl_clk",
>> +                       .parent_names = (const char *[]){
>> +                               "gcc_vs_ctrl_clk_src",
>> +                       },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT,
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
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
>> +       /* Disable the GPLL0 active input to MMSS and GPU via MISC 
>> registers */
>> +       regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
>> +       regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> 
> I think we'll have to throw in the pipe clk branch stuff in here too?
> And then drop the pipe clks from the driver?

All the USB pipe clocks would be taken care. The PCIE pipe branch
clocks would have to be explicitly disabled so as to retain the
memory logic. Otherwise, it would lead to memory corruption in case
the external source is directly disabled without disabling the branch 
clock.

> 
>> +
>> +       return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>> +}
>> +
>> diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h 
>> b/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> new file mode 100644
>> index 0000000..e27d8e2
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
>> @@ -0,0 +1,242 @@
> [...]
>> +#define GCC_VDDA_VS_CLK                                               
>>  180
>> +#define GCC_VDDCX_VS_CLK                                       181
>> +#define GCC_VDDMX_VS_CLK                                       182
>> +#define GCC_VS_CTRL_AHB_CLK                                    183
>> +#define GCC_VS_CTRL_CLK                                               
>>  184
>> +#define GCC_VS_CTRL_CLK_SRC                                    185
>> +#define GCC_VSENSOR_CLK_SRC                                    186
>> +#define GPLL4                                                  187
> 
> Do you have the define for the quad spi clks? And the implementation 
> for
> it?
> 

In SDM845, Quad SPI clocks are part of gcc_qupv*_wrap*_s* clock group.

>> +
>> +/* GCC reset clocks */
> 
> They're just resets, not reset clks.

Will fix this in next patch series.

> 
>> +#define GCC_MMSS_BCR                                           0
>> +#define GCC_PCIE_0_BCR                                         1
>> +#define GCC_PCIE_1_BCR                                         2
>> +#define GCC_PCIE_PHY_BCR                                       3
>> +#define GCC_PDM_BCR                                            4
>> +#define GCC_PRNG_BCR                                           5
>> +#define GCC_QUPV3_WRAPPER_0_BCR                                       
>>  6
>> +#define GCC_QUPV3_WRAPPER_1_BCR                                       
>>  7
