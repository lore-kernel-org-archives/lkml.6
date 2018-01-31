Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeAaKcd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:32:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeAaKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:32:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA88860251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
Subject: Re: [PATCH v2] clk: qcom: Add Global Clock controller (GCC) driver
 for SDM845
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1516610736-17088-1-git-send-email-anischal@codeaurora.org>
 <20180126235649.GF28313@codeaurora.org>
From: "Nischal, Amit" <anischal@codeaurora.org>
Message-ID: <998eeaf4-f680-3dc2-3132-708f4675d4df@codeaurora.org>
Date: Wed, 31 Jan 2018 16:02:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180126235649.GF28313@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2018 5:26 AM, Stephen Boyd wrote:
> On 01/22, Amit Nischal wrote:
>> Add support for the global clock controller found on SDM845
>> based devices. This should allow most non-multimedia device
>> drivers to probe and control their clocks.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Is Taniya the author? Should be a From: line then.
Thanks for the review. I will change the author name.
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> ---
>>
>> This patch is dependent on below changes:
>> 1. https://patchwork.kernel.org/patch/10139991/
>> 2. https://patchwork.kernel.org/patch/10139987/
>> 3. https://patchwork.kernel.org/patch/10144621/
> Ok. Next time you can send them all again in a series to make it
> easier for me.
Yes, I will post all the patches in a series after fixing review findings.
>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index fbf4532..91e4557 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -226,3 +226,12 @@ config SPMI_PMIC_CLKDIV
>>   	  Technologies, Inc. SPMI PMIC. It configures the frequency of
>>   	  clkdiv outputs of the PMIC. These clocks are typically wired
>>   	  through alternate functions on GPIO pins.
>> +
>> +config SDM_GCC_845
>> +	tristate "SDM845 Global Clock Controller"
>> +	depends on COMMON_CLK_QCOM
>> +	help
>> +	  Support for the global clock controller on Qualcomm Technologies, Inc
>> +	  sdm845 devices.
>> +	  Say Y if you want to use peripheral devices such as UART, SPI,
>> +	  i2c, USB, UFS, SD/eMMC, PCIe, etc.
> Put this in sorted order in the Kconfig? Or at least try to.  I
> should go back and sort the rest later.
ok sure. I will do that.
>
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 230332c..1aa23b3 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_MSM_GCC_8960) += gcc-msm8960.o
>>   obj-$(CONFIG_MSM_GCC_8974) += gcc-msm8974.o
>>   obj-$(CONFIG_MSM_GCC_8994) += gcc-msm8994.o
>>   obj-$(CONFIG_MSM_GCC_8996) += gcc-msm8996.o
>> +obj-$(CONFIG_SDM_GCC_845)  += gcc-sdm845.o
> This should be sorted too.
Done.
>
>>   obj-$(CONFIG_MSM_LCC_8960) += lcc-msm8960.o
>>   obj-$(CONFIG_MSM_MMCC_8960) += mmcc-msm8960.o
>>   obj-$(CONFIG_MSM_MMCC_8974) += mmcc-msm8974.o
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>> new file mode 100644
>> index 0000000..fe62d87
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -0,0 +1,3633 @@
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
>> +#define GCC_MMSS_MISC				0x09FFC
> Please drop the onetime defines.
ok. Will fix this in the next series.
>
>> +#define GCC_GPU_MISC				0x71028
>> +
>> +#define CXO_FREQUENCY				19200000
>> +
>> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
>> +
>> +static struct freq_tbl cxo_safe_src_f = {
> const?
>
>> +	.freq = CXO_FREQUENCY,
>> +	.src = 0,
>> +	.pre_div = 1,
>> +	.m = 0,
>> +	.n = 0,
>> +};
> All those = 0 are useless. But CXO may not always be 19.2 MHz so
> that's a non-starter. Try and figure out how to get rid of this?
Thanks for this finding. Will read the safe source's frequency inside 
the probe
of each CC driver and assign the rate to the 'freq' member variable of
'cxo_safe_src_f' structure as we have 'bi_tcxo' fixed clock and its rate 
is defined
in SDM845's main device tree file.
>
>> +
>> +enum {
>> +	P_BI_TCXO,
>> +	P_AUD_REF_CLK,
>> +	P_CORE_BI_PLL_TEST_SE,
>> +	P_GPLL0_OUT_EVEN,
>> +	P_GPLL0_OUT_MAIN,
>> +	P_GPLL4_OUT_MAIN,
>> +	P_SLEEP_CLK,
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_0[] = {
>> +	{ P_BI_TCXO, 0 },
>> +	{ P_GPLL0_OUT_MAIN, 1 },
>> +	{ P_GPLL0_OUT_EVEN, 6 },
>> +	{ P_CORE_BI_PLL_TEST_SE, 7 },
> [...]
>> +
>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>> +	F(400000, P_BI_TCXO, 12, 1, 4),
>> +	F(9600000, P_BI_TCXO, 2, 0, 0),
>> +	F(19200000, P_BI_TCXO, 1, 0, 0),
>> +	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
>> +	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
>> +	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
>> +	F(201500000, P_GPLL4_OUT_MAIN, 4, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>> +	.cmd_rcgr = 0x1400c,
>> +	.mnd_width = 8,
>> +	.hid_width = 5,
>> +	.parent_map = gcc_parent_map_10,
>> +	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
>> +	.safe_src_freq_tbl = &cxo_safe_src_f,
>> +	.clkr.hw.init = &(struct clk_init_data){
>> +		.name = "gcc_sdcc2_apps_clk_src",
>> +		.parent_names = gcc_parent_names_10,
>> +		.num_parents = 5,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +		.ops = &clk_rcg2_shared_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
>> +	F(400000, P_BI_TCXO, 12, 1, 4),
>> +	F(9600000, P_BI_TCXO, 2, 0, 0),
>> +	F(19200000, P_BI_TCXO, 1, 0, 0),
>> +	F(25000000, P_GPLL0_OUT_MAIN, 12, 1, 2),
>> +	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
>> +	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
>> +	.cmd_rcgr = 0x1600c,
>> +	.mnd_width = 8,
>> +	.hid_width = 5,
>> +	.parent_map = gcc_parent_map_0,
>> +	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
>> +	.safe_src_freq_tbl = &cxo_safe_src_f,
> Honestly, why do we need this other structure? Can't we point to
> the entry in the frequency table for this clk and use that? Or
> know that these are an RCG, and 99% of the time the "safe
> frequency" is going to be source 0 and div 1?
Actually for some of the clocks like 'gcc_usb30_prim_master_clk_src' , 
there is
no frequency table entry corresponding to CXO in the final frequency plan
and that’s the reason, I have added the safe source 'freq_tbl' structure 
at the
top of file and this will help to make the "Configure the RCGs to a safe 
source"
logic as generic. https://patchwork.kernel.org/patch/10139985/
>
>> +	.clkr.hw.init = &(struct clk_init_data){
>> +		.name = "gcc_sdcc4_apps_clk_src",
>> +		.parent_names = gcc_parent_names_0,
>> +		.num_parents = 4,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +		.ops = &clk_rcg2_shared_ops,
> [...]
>> +
>> +static const struct regmap_config gcc_sdm845_regmap_config = {
>> +	.reg_bits	= 32,
>> +	.reg_stride	= 4,
>> +	.val_bits	= 32,
>> +	.max_register	= 0x182090,
>> +	.fast_io	= true,
>> +};
>> +
>> +static const struct qcom_cc_desc gcc_sdm845_desc = {
>> +	.config = &gcc_sdm845_regmap_config,
>> +	.clks = gcc_sdm845_clocks,
>> +	.num_clks = ARRAY_SIZE(gcc_sdm845_clocks),
>> +	.resets = gcc_sdm845_resets,
>> +	.num_resets = ARRAY_SIZE(gcc_sdm845_resets),
>> +	.gdscs = gcc_sdm845_gdscs,
>> +	.num_gdscs = ARRAY_SIZE(gcc_sdm845_gdscs),
>> +};
>> +
>> +static const struct of_device_id gcc_sdm845_match_table[] = {
>> +	{ .compatible = "qcom,gcc-sdm845" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
>> +
>> +static int gcc_sdm845_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct regmap *regmap;
>> +	int i, ret = 0;
> Don't assign things and then reassign them without testing it
> first.
Thanks. Will fix this in next patch series.
>
>> +
>> +	regmap = qcom_cc_map(pdev, &gcc_sdm845_desc);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(gcc_sdm845_hws); i++) {
>> +		ret = devm_clk_hw_register(dev, gcc_sdm845_hws[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to register GCC clocks\n");
> Drop this error message.
Thanks. Will fix this in next patch series.
>
>> +		return ret;
>> +	}
>> +
>> +	/* Disable the GPLL0 active input to MMSS and GPU via MISC registers */
>> +	regmap_update_bits(regmap, GCC_MMSS_MISC, 0x3, 0x3);
>> +	regmap_update_bits(regmap, GCC_GPU_MISC, 0x3, 0x3);
> Can bootloaders do this? Or this can be a branch clk that we
> expose in the tree as the "gpll0" source entry for the multimedia
> clock controls? Do we ever turn these back on?
We never enable the GPLL0 active input to MMSS and GPU via MISC 
registers after this place
and this is for one time only. So I think, we can do this inside the 
probe for one time.
>> +
>> +	dev_info(&pdev->dev, "Registered GCC clocks\n");
> Drop.
Thanks. Will fix this in next patch series.
>
>> +
>> +	return ret;
>> +}
>> +
