Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754166AbeDZXkK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbeDZXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:40:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B048214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524572599-5425-3-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1524572599-5425-1-git-send-email-tdas@codeaurora.org>
 <1524572599-5425-3-git-send-email-tdas@codeaurora.org>
Message-ID: <152478600630.46528.279344846112571167@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [v4 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Thu, 26 Apr 2018 16:40:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-24 05:23:19)
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> new file mode 100644
> index 0000000..907a73f
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +
> +#define CLK_RPMH_ARC_EN_OFFSET         0
> +#define CLK_RPMH_VRM_EN_OFFSET         4
> +
> +/**
> + * struct clk_rpmh - individual rpmh clock data structure
> + * @hw:                        handle between common and hardware-specific interfaces
> + * @res_name:          resource name for the rpmh clock
> + * @res_addr:          base address of the rpmh resource within the RPMh
> + * @res_en_offset:     clock resource enable offset corresponding to ARC or
> + *                     VRM type clock

Can these be combined still? Just do a += on res_addr after we get the
base of it?

> + * @res_on_val:                rpmh clock enable value
> + * @res_off_val:       rpmh clock disable value
> + * @state:             rpmh clock requested state
> + * @aggr_state:                rpmh clock aggregated state
> + * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
> + * @valid_state_mask:  mask to determine the state of the rpmh clock
> + * @rpmh_client:       handle used for rpmh communications
> + * @dev:               device to which it is attached
> + * @peer:              pointer to the clock rpmh sibling
> + * @rate:              rate of the rpmh clock
> + */
> +struct clk_rpmh {
> +       struct clk_hw hw;
> +       const char *res_name;
> +       u32 res_addr;
> +       u32 res_en_offset;
> +       u32 res_on_val;
> +       u32 res_off_val;
> +       u32 state;
> +       u32 aggr_state;
> +       u32 last_sent_aggr_state;
> +       u32 valid_state_mask;
> +       struct rpmh_client *rpmh_client;
> +       struct device *dev;
> +       struct clk_rpmh *peer;
> +       unsigned long rate;
> +};
[...]
> +
> +static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
> +{
> +       return (c->last_sent_aggr_state & BIT(state))
> +               != (c->aggr_state & BIT(state));

Please drop useless parenthesis.

> +}
> +
> +static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
> +{
> +       struct tcs_cmd cmd = { 0 };
> +       u32 cmd_state, on_val;
> +       enum rpmh_state state = RPMH_SLEEP_STATE;
> +       int ret;
> +
> +       cmd.addr = c->res_addr + c->res_en_offset;
> +       cmd_state = c->aggr_state;
> +       on_val = c->res_on_val;
> +
> +       for (; state <= RPMH_ACTIVE_ONLY_STATE; state++) {
> +               if (has_state_changed(c, state)) {
> +                       cmd.data = (cmd_state & BIT(state)) ? on_val : 0;
> +                       ret = rpmh_write_async(c->rpmh_client, state,
> +                                               &cmd, 1);
> +                       if (ret) {
> +                               dev_err(c->dev, "set %s state of %s failed: (%d)\n",
> +                                       (!state) ? "sleep" :

Drop parenthesis please.

> +                                       (state == RPMH_WAKE_ONLY_STATE) ?

Drop parenthesis please.

> +                                       "wake" : "active", c->res_name, ret);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       c->last_sent_aggr_state = c->aggr_state;
> +       c->peer->last_sent_aggr_state =  c->last_sent_aggr_state;
> +
> +       return 0;
> +}
[...]
> +
> +static const struct clk_ops clk_rpmh_ops = {
> +       .prepare        = clk_rpmh_prepare,
> +       .unprepare      = clk_rpmh_unprepare,
> +       .recalc_rate    = clk_rpmh_recalc_rate,
> +};
> +
> +/* Resource name must match resource id present in cmd-db. */
> +DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 0x0, 19200000);
> +DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 19200000);
> +DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk3, ln_bb_clk3_ao, "lnbclka3", 19200000);
> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 38400000);
> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 38400000);
> +DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 38400000);

These rates should come from DT and parents of these clks.
