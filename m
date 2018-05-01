Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753735AbeEAIlM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:41:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbeEAIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:41:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 224AD607F5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [v4 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1524572599-5425-1-git-send-email-tdas@codeaurora.org>
 <1524572599-5425-3-git-send-email-tdas@codeaurora.org>
 <152478600630.46528.279344846112571167@swboyd.mtv.corp.google.com>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <a00ef872-56a1-df5d-86d1-b103b83961b8@codeaurora.org>
Date: Tue, 1 May 2018 14:10:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152478600630.46528.279344846112571167@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the review comments.

On 4/27/2018 5:10 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-04-24 05:23:19)
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> new file mode 100644
>> index 0000000..907a73f
>> --- /dev/null
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -0,0 +1,364 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <soc/qcom/cmd-db.h>
>> +#include <soc/qcom/rpmh.h>
>> +
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +
>> +#define CLK_RPMH_ARC_EN_OFFSET         0
>> +#define CLK_RPMH_VRM_EN_OFFSET         4
>> +
>> +/**
>> + * struct clk_rpmh - individual rpmh clock data structure
>> + * @hw:                        handle between common and hardware-specific interfaces
>> + * @res_name:          resource name for the rpmh clock
>> + * @res_addr:          base address of the rpmh resource within the RPMh
>> + * @res_en_offset:     clock resource enable offset corresponding to ARC or
>> + *                     VRM type clock
> 
> Can these be combined still? Just do a += on res_addr after we get the
> base of it?
> 
I have taken care in the next patch.

>> + * @res_on_val:                rpmh clock enable value
>> + * @res_off_val:       rpmh clock disable value
>> + * @state:             rpmh clock requested state
>> + * @aggr_state:                rpmh clock aggregated state
>> + * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
>> + * @valid_state_mask:  mask to determine the state of the rpmh clock
>> + * @rpmh_client:       handle used for rpmh communications
>> + * @dev:               device to which it is attached
>> + * @peer:              pointer to the clock rpmh sibling
>> + * @rate:              rate of the rpmh clock
>> + */
>> +struct clk_rpmh {
>> +       struct clk_hw hw;
>> +       const char *res_name;
>> +       u32 res_addr;
>> +       u32 res_en_offset;
>> +       u32 res_on_val;
>> +       u32 res_off_val;
>> +       u32 state;
>> +       u32 aggr_state;
>> +       u32 last_sent_aggr_state;
>> +       u32 valid_state_mask;
>> +       struct rpmh_client *rpmh_client;
>> +       struct device *dev;
>> +       struct clk_rpmh *peer;
>> +       unsigned long rate;
>> +};
> [...]
>> +
>> +static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
>> +{
>> +       return (c->last_sent_aggr_state & BIT(state))
>> +               != (c->aggr_state & BIT(state));
> 
> Please drop useless parenthesis.
> 

I see a warning in case I remove the parenthesis.

warning: suggest parentheses around comparison in operand of ‘&’ 
[-Wparentheses]
    != c->aggr_state & BIT(state));

>> +}
>> +
>> +static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
>> +{
>> +       struct tcs_cmd cmd = { 0 };
>> +       u32 cmd_state, on_val;
>> +       enum rpmh_state state = RPMH_SLEEP_STATE;
>> +       int ret;
>> +
>> +       cmd.addr = c->res_addr + c->res_en_offset;
>> +       cmd_state = c->aggr_state;
>> +       on_val = c->res_on_val;
>> +
>> +       for (; state <= RPMH_ACTIVE_ONLY_STATE; state++) {
>> +               if (has_state_changed(c, state)) {
>> +                       cmd.data = (cmd_state & BIT(state)) ? on_val : 0;
>> +                       ret = rpmh_write_async(c->rpmh_client, state,
>> +                                               &cmd, 1);
>> +                       if (ret) {
>> +                               dev_err(c->dev, "set %s state of %s failed: (%d)\n",
>> +                                       (!state) ? "sleep" :
> 
> Drop parenthesis please.
> 

Dropped.

>> +                                       (state == RPMH_WAKE_ONLY_STATE) ?
> 
> Drop parenthesis please.
> 

Dropped.

>> +                                       "wake" : "active", c->res_name, ret);
>> +                               return ret;
>> +                       }
>> +               }
>> +       }
>> +
>> +       c->last_sent_aggr_state = c->aggr_state;
>> +       c->peer->last_sent_aggr_state =  c->last_sent_aggr_state;
>> +
>> +       return 0;
>> +}
> [...]
>> +
>> +static const struct clk_ops clk_rpmh_ops = {
>> +       .prepare        = clk_rpmh_prepare,
>> +       .unprepare      = clk_rpmh_unprepare,
>> +       .recalc_rate    = clk_rpmh_recalc_rate,
>> +};
>> +
>> +/* Resource name must match resource id present in cmd-db. */
>> +DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 0x0, 19200000);
>> +DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 19200000);
>> +DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk3, ln_bb_clk3_ao, "lnbclka3", 19200000);
>> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 38400000);
>> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 38400000);
>> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 38400000);
> 
> These rates should come from DT and parents of these clks.
> 

Removed the rates from the above and instead I would take the clk-div 
values from the DT for the clocks and compute the rates and parents are 
fixed to "xo_board".

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
