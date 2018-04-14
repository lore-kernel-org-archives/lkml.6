Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDNCDL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 22:03:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeDNCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 22:03:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A23F60310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [[PATCH v2] 1/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
References: <1523183533-23171-1-git-send-email-tdas@codeaurora.org>
 <1523183533-23171-2-git-send-email-tdas@codeaurora.org>
 <20180410173933.GA6727@builder>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <430e2b53-9a81-cf8e-473e-a6ba9ee78514@codeaurora.org>
Date: Sat, 14 Apr 2018 07:32:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410173933.GA6727@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

Thank you for the review comments.

On 4/10/2018 11:09 PM, Bjorn Andersson wrote:
> On Sun 08 Apr 03:32 PDT 2018, Taniya Das wrote:
> 
>> From: Amit Nischal <anischal@codeaurora.org>
>>
>> Add the RPMh clock driver to control the RPMh managed clock resources on
>> some of the Qualcomm Technologies, Inc. SoCs.
>>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/clk/qcom/Kconfig              |   9 +
>>   drivers/clk/qcom/Makefile             |   1 +
>>   drivers/clk/qcom/clk-rpmh.c           | 394 ++++++++++++++++++++++++++++++++++
>>   include/dt-bindings/clock/qcom,rpmh.h |  25 +++
>>   4 files changed, 429 insertions(+)
>>   create mode 100644 drivers/clk/qcom/clk-rpmh.c
>>   create mode 100644 include/dt-bindings/clock/qcom,rpmh.h
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index fbf4532..3697a6a 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -112,6 +112,15 @@ config IPQ_GCC_8074
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq8074.
>>   
>> +config MSM_CLK_RPMH
> 
> QCOM_CLK_RPMH
> 

Would update it to use "QCOM_CLK_RPMH".

>> +	tristate "RPMh Clock Driver"
>> +	depends on COMMON_CLK_QCOM && QCOM_RPMH
>> +	help
>> +	 RPMh manages shared resources on some Qualcomm Technologies, Inc.
>> +	 SoCs. It accepts requests from other hardware subsystems via RSC.
>> +	 Say Y if you want to support the clocks exposed by RPMh on
>> +	 platforms such as sdm845.
>> +
>>   config MSM_GCC_8660
>>   	tristate "MSM8660 Global Clock Controller"
>>   	depends on COMMON_CLK_QCOM
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 230332c..b7da05b 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -23,6 +23,7 @@ obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
>>   obj-$(CONFIG_MDM_LCC_9615) += lcc-mdm9615.o
>> +obj-$(CONFIG_MSM_CLK_RPMH) += clk-rpmh.o
>>   obj-$(CONFIG_MSM_GCC_8660) += gcc-msm8660.o
>>   obj-$(CONFIG_MSM_GCC_8916) += gcc-msm8916.o
>>   obj-$(CONFIG_MSM_GCC_8960) += gcc-msm8960.o
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> new file mode 100644
>> index 0000000..763401f
>> --- /dev/null
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -0,0 +1,394 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
> 
> Unused
> 
>> +#include <soc/qcom/cmd-db.h>
>> +#include <soc/qcom/rpmh.h>
>> +
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +
>> +#include "common.h"
>> +#include "clk-regmap.h"
> 
> Unused
> 

I would remove the unused header includes.

>> +
>> +#define CLK_RPMH_ARC_EN_OFFSET 0
>> +#define CLK_RPMH_VRM_EN_OFFSET 4
>> +#define CLK_RPMH_VRM_OFF_VAL 0
>> +#define CLK_RPMH_VRM_ON_VAL 1
> 
> Use a bool (true/false) rather than lugging around these two defines.

I would remove these in the next patch.

> 
>> +#define CLK_RPMH_APPS_RSC_AO_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
>> +					 BIT(RPMH_ACTIVE_ONLY_STATE))
>> +#define CLK_RPMH_APPS_RSC_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
>> +				      BIT(RPMH_ACTIVE_ONLY_STATE) | \
>> +				      BIT(RPMH_SLEEP_STATE))
>> +struct clk_rpmh {
>> +	struct clk_hw hw;
>> +	const char *res_name;
>> +	u32 res_addr;
>> +	u32 res_en_offset;
>> +	u32 res_on_val;
>> +	u32 res_off_val;
> 
> res_off_val is 0 for all clocks.
> 

They could change if required, so is the reason for keeping it.

>> +	u32 state;
>> +	u32 aggr_state;
>> +	u32 last_sent_aggr_state;
> 
> Through the use of some local variables you shouldn't have to lug around
> aggr_state and last_sent_aggr_state.
> 

We need to check if the last state and the current state requested, 
has_state_changed().

>> +	u32 valid_state_mask;
>> +	struct rpmh_client *rpmh_client;
>> +	unsigned long rate;
>> +	struct clk_rpmh *peer;
>> +};
>> +
>> +struct rpmh_cc {
>> +	struct clk_onecell_data data;
>> +	struct clk *clks[];
>> +};
>> +
>> +struct clk_rpmh_desc {
>> +	struct clk_hw **clks;
>> +	size_t num_clks;
>> +};
>> +
>> +static DEFINE_MUTEX(rpmh_clk_lock);
>> +
>> +#define __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name, \
>> +			  _res_en_offset, _res_on, _res_off, _rate, \
>> +			  _state_mask, _state_on_mask)			      \
>> +	static struct clk_rpmh _platform##_##_name_active;		      \
>> +	static struct clk_rpmh _platform##_##_name = {			      \
>> +		.res_name = _res_name,					      \
>> +		.res_en_offset = _res_en_offset,			      \
>> +		.res_on_val = _res_on,					      \
>> +		.res_off_val = _res_off,				      \
>> +		.rate = _rate,						      \
>> +		.peer = &_platform##_##_name_active,			      \
>> +		.valid_state_mask = _state_mask,			      \
> 
> This is always CLK_RPMH_APPS_RSC_STATE_MASK
> 
>> +		.hw.init = &(struct clk_init_data){			      \
>> +			.ops = &clk_rpmh_ops,			              \
>> +			.name = #_name,					      \
>> +		},							      \
>> +	};								      \
>> +	static struct clk_rpmh _platform##_##_name_active = {		      \
>> +		.res_name = _res_name,					      \
>> +		.res_en_offset = _res_en_offset,			      \
>> +		.res_on_val = _res_on,					      \
>> +		.res_off_val = _res_off,				      \
>> +		.rate = _rate,						      \
>> +		.peer = &_platform##_##_name,				      \
>> +		.valid_state_mask = _state_on_mask,			      \
> 
> and this is always CLK_RPMH_APPS_RSC_AO_STATE_MASK. If you just hard
> code them here (until there's a need for them to be anything else) the
> clock list below becomes tidier.
> 

As of now the state_mask is CLK_RPMH_APPS_RSC_STATE_MASK and 
state_on_mask is CLK_RPMH_APPS_RSC_AO_STATE_MASK. I would update the 
logic if the state masks changes.

>> +		.hw.init = &(struct clk_init_data){			      \
>> +			.ops = &clk_rpmh_ops,				      \
>> +			.name = #_name_active,				      \
>> +		},							      \
>> +	}
>> +
>> +#define DEFINE_CLK_RPMH_ARC(_platform, _name, _name_active, _res_name, \
>> +			    _res_on, _res_off, _rate, _state_mask, \
>> +			    _state_on_mask)				\
>> +	__DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,	\
>> +			  CLK_RPMH_ARC_EN_OFFSET, _res_on, _res_off, \
>> +			  _rate, _state_mask, _state_on_mask)
>> +
>> +#define DEFINE_CLK_RPMH_VRM(_platform, _name, _name_active, _res_name,	\
>> +			    _rate, _state_mask, _state_on_mask) \
>> +	__DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,	\
>> +			  CLK_RPMH_VRM_EN_OFFSET, CLK_RPMH_VRM_ON_VAL,	\
>> +			  CLK_RPMH_VRM_OFF_VAL, _rate, _state_mask, \
>> +			  _state_on_mask)
>> +
>> +static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
>> +{
>> +	return container_of(_hw, struct clk_rpmh, hw);
>> +}
>> +
>> +static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
>> +{
>> +	return ((c->last_sent_aggr_state & BIT(state))
>> +		!= (c->aggr_state & BIT(state)));
>> +}
>> +
>> +static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
>> +{
>> +	struct tcs_cmd cmd = { 0 };
>> +	int ret = 0;
>> +
>> +	cmd.addr = c->res_addr + c->res_en_offset;
>> +
>> +	if (has_state_changed(c, RPMH_SLEEP_STATE)) {
>> +		cmd.data = (c->aggr_state & BIT(RPMH_SLEEP_STATE))
>> +				? c->res_on_val : c->res_off_val;
> 
> As these values are reused several times in this function you could by
> using some local variables get this down to the much more readable:
> 
> 		cmd.data = state & BIT(RPMH_SLEEP_STATE) ? on_val : off_val;
> 
> And as off_val is 0 for all your clocks you can even drop the latter.
> 
>> +		ret = rpmh_write_async(c->rpmh_client, RPMH_SLEEP_STATE,
>> +				       &cmd, 1);
>> +		if (ret) {
>> +			pr_err("%s: rpmh_write_async(%s, state=%d) failed (%d)\n",
>> +			       __func__, c->res_name, RPMH_SLEEP_STATE, ret);
> 
> Please drop the __func__, the error string is unique in this driver; and
> rather than passing a constant to a %d actually write your error message
> in a human readable form, like: "set sleep state of %s failed: %d\n".
> 
> And please do carry the struct device, so that you can use dev_err()
> instead.
> 

Thanks, I would take care of the above comments and also loop thorugh 
the enum to avoid duplication in the next patch.

>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (has_state_changed(c, RPMH_WAKE_ONLY_STATE)) {
>> +		cmd.data = (c->aggr_state & BIT(RPMH_WAKE_ONLY_STATE))
>> +				? c->res_on_val : c->res_off_val;
>> +		ret = rpmh_write_async(c->rpmh_client,
>> +				       RPMH_WAKE_ONLY_STATE, &cmd, 1);
>> +		if (ret) {
>> +			pr_err("%s: rpmh_write_async(%s, state=%d) failed (%d)\n"
> 
> You're missing a , for this to compile.
> 

Thanks, would fix in the next patch.

>> +			       __func__, c->res_name, RPMH_WAKE_ONLY_STATE,
>> +				 ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (has_state_changed(c, RPMH_ACTIVE_ONLY_STATE)) {
>> +		cmd.data = (c->aggr_state & BIT(RPMH_ACTIVE_ONLY_STATE))
>> +				? c->res_on_val : c->res_off_val;
>> +		ret = rpmh_write(c->rpmh_client, RPMH_ACTIVE_ONLY_STATE,
>> +				 &cmd, 1);
>> +		if (ret) {
>> +			pr_err("%s: rpmh_write(%s, state=%d) failed (%d)\n",
>> +			       __func__, c->res_name, RPMH_ACTIVE_ONLY_STATE,
>> +				 ret);
>> +			return ret;
>> +		}
>> +	}
> 
> But, RPMH_SLEEP_STATE, RPMH_WAKE_ONLY_STATE and RPMH_ACTIVE_ONLY_STATE
> are values in an enum, so you could roll these up in a for loop and
> reduce the duplication.
> 
>> +
>> +	c->last_sent_aggr_state = c->aggr_state;
>> +	c->peer->last_sent_aggr_state =  c->last_sent_aggr_state;
>> +
>> +	return 0;
>> +}
>> +
>> +static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
>> +						bool enable)
>> +{
>> +	/* Update state and aggregate state values based on enable value. */
>> +	c->state = enable ? c->valid_state_mask : 0;
>> +	c->aggr_state = c->state | c->peer->state;
>> +	c->peer->aggr_state = c->aggr_state;
>> +
>> +	ret = clk_rpmh_send_aggregate_command(c);
> 
> "ret" doesn't exist.
> 

Thanks, I would add the missing variable.

>> +	if (ret && enable)
>> +		c->state = 0;
>> +	else if (ret) {
> 
> If you have any part of your conditional wrapped in braces do wrap all
> the others too.
> 

Thanks, would take care in the next patch.

>> +		c->state = c->valid_state_mask;
>> +		WARN(1, "clk: %s failed to disable\n", c->res_name);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int clk_rpmh_prepare(struct clk_hw *hw)
>> +{
>> +	struct clk_rpmh *c = to_clk_rpmh(hw);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&rpmh_clk_lock);
>> +
>> +	if (c->state)
>> +		goto out;
>> +
>> +	ret = clk_rpmh_aggregate_state_send_command(c, true);
>> +out:
>> +	mutex_unlock(&rpmh_clk_lock);
>> +	return ret;
>> +};
>> +
>> +static void clk_rpmh_unprepare(struct clk_hw *hw)
>> +{
>> +	struct clk_rpmh *c = to_clk_rpmh(hw);
>> +
>> +	mutex_lock(&rpmh_clk_lock);
>> +
>> +	if (!c->state)
>> +		goto out;
>> +
>> +	clk_rpmh_aggregate_state_send_command(c, false);
>> +out:
>> +	mutex_unlock(&rpmh_clk_lock);
>> +	return;
>> +};
>> +
>> +static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
>> +					  unsigned long parent_rate)
>> +{
>> +	struct clk_rpmh *r = to_clk_rpmh(hw);
>> +
>> +	/*
>> +	 * RPMh clocks have a fixed rate. Return static rate set
>> +	 * at init time.
>> +	 */
>> +	return r->rate;
>> +}
>> +
>> +static const struct clk_ops clk_rpmh_ops = {
>> +	.prepare	= clk_rpmh_prepare,
>> +	.unprepare	= clk_rpmh_unprepare,
>> +	.recalc_rate	= clk_rpmh_recalc_rate,
>> +};
>> +
>> +/* Resource name must match resource id present in cmd-db. */
>> +DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 0x0,
>> +		    19200000, CLK_RPMH_APPS_RSC_STATE_MASK,
>> +		    CLK_RPMH_APPS_RSC_AO_STATE_MASK);
>> +DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2",
>> +		    19200000, CLK_RPMH_APPS_RSC_STATE_MASK,
>> +		    CLK_RPMH_APPS_RSC_AO_STATE_MASK);
>> +DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk3, ln_bb_clk3_ao, "lnbclka3",
>> +		    19200000, CLK_RPMH_APPS_RSC_STATE_MASK,
>> +		    CLK_RPMH_APPS_RSC_AO_STATE_MASK);
>> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1",
>> +		    38400000, CLK_RPMH_APPS_RSC_STATE_MASK,
>> +		    CLK_RPMH_APPS_RSC_AO_STATE_MASK);
>> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2",
>> +		    38400000, CLK_RPMH_APPS_RSC_STATE_MASK,
>> +		    CLK_RPMH_APPS_RSC_AO_STATE_MASK);
>> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3",
>> +		    38400000, CLK_RPMH_APPS_RSC_STATE_MASK,
>> +		    CLK_RPMH_APPS_RSC_AO_STATE_MASK);
>> +
>> +static struct clk_hw *sdm845_rpmh_clocks[] = {
>> +	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
>> +	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
> 
> Registering these fails with EEXIST because the gcc driver also register
> them.
> 

It was added till the time RPMh driver was not ready. We would submit 
removing the change from GCC driver.

>> +	[RPMH_LN_BB_CLK2]	= &sdm845_ln_bb_clk2.hw,
>> +	[RPMH_LN_BB_CLK2_A]	= &sdm845_ln_bb_clk2_ao.hw,
>> +	[RPMH_LN_BB_CLK3]	= &sdm845_ln_bb_clk3.hw,
>> +	[RPMH_LN_BB_CLK3_A]	= &sdm845_ln_bb_clk3_ao.hw,
>> +	[RPMH_RF_CLK1]		= &sdm845_rf_clk1.hw,
>> +	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
>> +	[RPMH_RF_CLK2]		= &sdm845_rf_clk2.hw,
>> +	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
>> +	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
>> +	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
>> +};
>> +
>> +static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
>> +	.clks = sdm845_rpmh_clocks,
>> +	.num_clks = ARRAY_SIZE(sdm845_rpmh_clocks),
>> +};
>> +
>> +static const struct of_device_id clk_rpmh_match_table[] = {
>> +	{ .compatible = "qcom,rpmh-clk-sdm845", .data = &clk_rpmh_sdm845},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
> 
> Please move the match_table just prior to the definition of your
> platform_driver.
> 

Would update this in the next patch.

>> +
>> +static int clk_rpmh_probe(struct platform_device *pdev)
>> +{
>> +	struct clk **clks;
>> +	struct clk *clk;
>> +	struct rpmh_cc *rcc;
>> +	struct clk_onecell_data *data;
>> +	int ret;
>> +	size_t num_clks, i;
>> +	struct clk_hw **hw_clks;
>> +	struct clk_rpmh *rpmh_clk;
>> +	const struct clk_rpmh_desc *desc;
>> +	struct property *prop;
> 
> prop is unused.
> 

Thanks, would remove the unused variable.

>> +	struct rpmh_client *rpmh_client = NULL;
> 
> Don't goto err until you have acquired rpmh_client and you don't need to
> initialize this variable.
> 

Would remove the variable initialization in the next patch.

>> +
>> +	desc = of_device_get_match_data(&pdev->dev);
>> +	if (!desc) {
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
> 
> This won't happen, no need to check for it.
> 

Would remove this check too in the next patch.

>> +
>> +	ret = cmd_db_ready();
>> +	if (ret) {
>> +		if (ret != -EPROBE_DEFER) {
>> +			dev_err(&pdev->dev, "Command DB not available (%d)\n",
>> +				ret);
>> +			goto err;
> 
> goto err? There's nothing to clean up at this point.
> 

I would fix this in the next patch.

>> +		}
>> +		return ret;
>> +	}
>> +
>> +	rpmh_client = rpmh_get_client(pdev);
>> +	if (IS_ERR(rpmh_client)) {
>> +		ret = PTR_ERR(rpmh_client);
>> +		if (ret != -EPROBE_DEFER)
> 
> You're getting a handle to your parent, it's not going to return
> -EPROBE_DEFER.
>

I would fix the error path in the next patch.

>> +			dev_err(&pdev->dev, "failed to request RPMh client, ret=%d\n",
>> +				ret);
>> +		return ret;
>> +	}
>> +
>> +	hw_clks = desc->clks;
>> +	num_clks = desc->num_clks;
>> +
>> +	rcc = devm_kzalloc(&pdev->dev, sizeof(*rcc) + sizeof(*clks) * num_clks,
>> +			   GFP_KERNEL);
>> +	if (!rcc) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	clks = rcc->clks;
>> +	data = &rcc->data;
>> +	data->clks = clks;
>> +	data->clk_num = num_clks;
>> +
>> +	for (i = 0; i < num_clks; i++) {
>> +		rpmh_clk = to_clk_rpmh(hw_clks[i]);
>> +		rpmh_clk->res_addr = cmd_db_read_addr(rpmh_clk->res_name);
>> +		if (!rpmh_clk->res_addr) {
>> +			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
>> +				rpmh_clk->res_name);
>> +			ret = -ENODEV;
>> +			goto err;
>> +		}
>> +
>> +		rpmh_clk->rpmh_client = rpmh_client;
>> +
>> +		clk = devm_clk_register(&pdev->dev, hw_clks[i]);
>> +		if (IS_ERR(clk)) {
> 
> Please add:
> 
> dev_err(&pdev->dev, "failed to register %s\n", hw_clks[i]->init->name);
> 
>> +			ret = PTR_ERR(clk);
>> +			goto err;
>> +		}
>> +
>> +		clks[i] = clk;
>> +	}
>> +
>> +	ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
>> +				  data);
>> +	if (ret)
> 
> Please add:
> 
> dev_err(&pdev->dev, "failed to add clock provider\n");
> 
>> +		goto err;
>> +
>> +	dev_info(&pdev->dev, "Registered RPMh clocks\n");
> 
> Please don't spam the kernel log.
> 
>> +	return ret;
> 
> ret can't be anything but 0 here, so let's make it easer to read by
> writing 0 here.
> 
>> +
>> +err:
>> +	if (rpmh_client)
>> +		rpmh_release(rpmh_client);
> 
> This is annoying (but not your fault).
> 
>> +
>> +	dev_err(&pdev->dev, "Error registering RPMh Clock driver (%d)\n", ret);
> 
> Testing the driver I got this error message, it didn't help! Had to add
> the two dev_err above, just drop this one.
> 

I would take care of the above comments in the next patch.

>> +	return ret;
>> +}
>> +
>> +static struct platform_driver clk_rpmh_driver = {
>> +	.probe		= clk_rpmh_probe,
> 
> Your driver is tristate and works just fine as a kernel module, so you
> need a remove function to call rpmh_release(rpmh_client) - or we need to
> get rid of the need to call that.
> 

Yes, I would add the remove and do the rpmh_client and of_del_provider 
clean ups.

>> +	.driver		= {
>> +		.name	= "clk-rpmh",
>> +		.of_match_table = clk_rpmh_match_table,
>> +	},
>> +};
>> +
>> +static int __init clk_rpmh_init(void)
>> +{
>> +	return platform_driver_register(&clk_rpmh_driver);
>> +}
>> +subsys_initcall(clk_rpmh_init);
>> +
>> +static void __exit clk_rpmh_exit(void)
>> +{
>> +	platform_driver_unregister(&clk_rpmh_driver);
>> +}
>> +module_exit(clk_rpmh_exit);
>> +
>> +MODULE_DESCRIPTION("QTI RPMh Clock Driver");
> 
> We use "Qualcomm" or "QCOM" in all existing driver, can you please use
> that here too?
> 

Would update it to use "QCOM".

>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:clk-rpmh");
> 
> Nothing is going to attempt to autoload a driver based on the alias
> platform:clk-rpmh, so just drop this.
> 

Would drop this in the next patch.

> Regards,
> Bjorn
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
