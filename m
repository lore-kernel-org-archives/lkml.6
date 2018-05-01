Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeEAV1y convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeEAV1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:27:52 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525164093-16645-3-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
 <1525164093-16645-3-git-send-email-tdas@codeaurora.org>
Message-ID: <152521007133.138124.1057969694939363822@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [v5 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Tue, 01 May 2018 14:27:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-05-01 01:41:33)
> Add the RPMh clock driver to control the RPMh managed clock resources on
> some of the Qualcomm Technologies, Inc. SoCs.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>

Drop Amit's signoff, or make it "Co-authored-by" please. First signoff
should be the author and there should be a "From:" line either from the
email header of the sender or explicitly here before the commit text
body to indicate the authorship.

Overall this is looking close. Maybe one more round.

> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> new file mode 100644
> index 0000000..9cb7aa4
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -0,0 +1,387 @@
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
> + * @div:               clock divider to compute the clock rate
> + * @res_addr:          base address of the rpmh resource within the RPMh
> + * @res_on_val:                rpmh clock enable value
> + * @res_off_val:       rpmh clock disable value

It's still unused.

> + * @state:             rpmh clock requested state
> + * @aggr_state:                rpmh clock aggregated state
> + * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
> + * @valid_state_mask:  mask to determine the state of the rpmh clock
> + * @rpmh_client:       handle used for rpmh communications
> + * @dev:               device to which it is attached
> + * @peer:              pointer to the clock rpmh sibling
> + */
> +struct clk_rpmh {
> +       struct clk_hw hw;
> +       const char *res_name;
> +       u8  div;

Weird space here.

> +       u32 res_addr;
> +       u32 res_on_val;
> +       u32 res_off_val;
> +       u32 state;
> +       u32 aggr_state;
> +       u32 last_sent_aggr_state;
> +       u32 valid_state_mask;
> +       struct rpmh_client *rpmh_client;
> +       struct device *dev;
> +       struct clk_rpmh *peer;
> +};
> +
> +struct clk_rpmh_desc {
> +       struct clk_hw **clks;
> +       size_t num_clks;
> +};
> +
> +static DEFINE_MUTEX(rpmh_clk_lock);
> +
> +#define __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,   \
> +                         _res_en_offset, _res_on, _res_off)            \
> +       static struct clk_rpmh _platform##_##_name_active;              \
> +       static struct clk_rpmh _platform##_##_name = {                  \
> +               .res_name = _res_name,                                  \
> +               .res_addr = _res_en_offset,                             \
> +               .res_on_val = _res_on,                                  \
> +               .res_off_val = _res_off,                                \
> +               .peer = &_platform##_##_name_active,                    \
> +               .valid_state_mask = (BIT(RPMH_WAKE_ONLY_STATE) |        \
> +                                     BIT(RPMH_ACTIVE_ONLY_STATE) |     \
> +                                     BIT(RPMH_SLEEP_STATE)),           \
> +               .hw.init = &(struct clk_init_data){                     \
> +                       .ops = &clk_rpmh_ops,                           \
> +                       .name = #_name,                                 \
> +                       .parent_names = (const char *[]){ "xo_board" }, \

This would be different for the xo_board and the xo_board / 2 clk names.

> +                       .num_parents = 1,                               \
> +               },                                                      \
> +       };                                                              \
> +       static struct clk_rpmh _platform##_##_name_active = {           \
> +               .res_name = _res_name,                                  \
> +               .res_addr = _res_en_offset,                             \
> +               .res_on_val = _res_on,                                  \
> +               .res_off_val = _res_off,                                \
> +               .peer = &_platform##_##_name,                           \
> +               .valid_state_mask = (BIT(RPMH_WAKE_ONLY_STATE) |        \
> +                                       BIT(RPMH_ACTIVE_ONLY_STATE)),   \
> +               .hw.init = &(struct clk_init_data){                     \
> +                       .ops = &clk_rpmh_ops,                           \
> +                       .name = #_name_active,                          \
> +                       .parent_names = (const char *[]){ "xo_board" }, \
> +                       .num_parents = 1,                               \
> +               },                                                      \
> +       }
> +
> +#define DEFINE_CLK_RPMH_ARC(_platform, _name, _name_active, _res_name, \
> +                           _res_on, _res_off)                          \
> +       __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,    \
> +                         CLK_RPMH_ARC_EN_OFFSET, _res_on, _res_off)
> +
> +#define DEFINE_CLK_RPMH_VRM(_platform, _name, _name_active, _res_name) \
> +       __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,    \
> +                         CLK_RPMH_VRM_EN_OFFSET, true, false)

s/true, false/1, 0/ ?

> +
> +static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
> +{
> +       return container_of(_hw, struct clk_rpmh, hw);
> +}
> +
> +static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
> +{
> +       return (c->last_sent_aggr_state & BIT(state))
> +               != (c->aggr_state & BIT(state));
> +}
> +
> +static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
> +{
> +       struct tcs_cmd cmd = { 0 };
> +       u32 cmd_state, on_val;
> +       enum rpmh_state state = RPMH_SLEEP_STATE;
> +       int ret;
> +
> +       cmd.addr = c->res_addr;
> +       cmd_state = c->aggr_state;
> +       on_val = c->res_on_val;
> +
> +       for (; state <= RPMH_ACTIVE_ONLY_STATE; state++) {
> +               if (has_state_changed(c, state)) {
> +                       cmd.data = (cmd_state & BIT(state)) ? on_val : 0;

Make this into an "if" please. Default is already 0 so just set bit if
cmd_state & BIT(state).

> +                       ret = rpmh_write_async(c->rpmh_client, state,
> +                                               &cmd, 1);
> +                       if (ret) {
> +                               dev_err(c->dev, "set %s state of %s failed: (%d)\n",
> +                                       !state ? "sleep" :
> +                                       state == RPMH_WAKE_ONLY_STATE   ?
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
> +
> +/*
> + * Update state and aggregate state values based on enable value.
> + */
> +static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
> +                                               bool enable)
> +{
> +       int ret;
> +
> +       c->state = enable ? c->valid_state_mask : 0;
> +       c->aggr_state = c->state | c->peer->state;
> +       c->peer->aggr_state = c->aggr_state;
> +
> +       ret = clk_rpmh_send_aggregate_command(c);
> +       if (ret && enable) {
> +               c->state = 0;

Why don't we print a WARN if it fails to enable?

> +       } else if (ret) {
> +               c->state = c->valid_state_mask;
> +               WARN(1, "clk: %s failed to disable\n", c->res_name);
> +       }
> +
> +       return ret;
> +}
> +
> +static int clk_rpmh_prepare(struct clk_hw *hw)
> +{
> +       struct clk_rpmh *c = to_clk_rpmh(hw);
> +       int ret = 0;
> +
> +       mutex_lock(&rpmh_clk_lock);
> +
> +       if (!c->state)

Can we push this into clk_rpmh_aggregate_state_send_command()? Something
like:

	/* Nothing to do if already off or on */
	if (enable == c->state)
		return 0;

> +               ret = clk_rpmh_aggregate_state_send_command(c, true);
> +
> +       mutex_unlock(&rpmh_clk_lock);
> +       return ret;
> +};
> +
> +static void clk_rpmh_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_rpmh *c = to_clk_rpmh(hw);
> +
> +       mutex_lock(&rpmh_clk_lock);
> +
> +       if (c->state)
> +               clk_rpmh_aggregate_state_send_command(c, false);
> +
> +       mutex_unlock(&rpmh_clk_lock);
> +};
> +
> +static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long prate)
> +{
> +       struct clk_rpmh *r = to_clk_rpmh(hw);
> +       unsigned long rate;
> +
> +       /*
> +        * RPMh clocks have a fixed rate.
> +        */
> +       rate =  prate;
> +       do_div(rate, r->div);
> +
> +       return rate;
> +}

You shouldn't need any recalc rate in this driver.

> +
> +static int clk_rpmh_probe(struct platform_device *pdev)
> +{
> +       struct clk *clk;
> +       struct clk_hw_onecell_data *hw_data;
> +       struct clk_hw **hw_clks;
> +       struct clk_rpmh *rpmh_clk;
> +       const struct clk_rpmh_desc *desc;
> +       struct rpmh_client *rpmh_client;
> +       struct device *dev;
> +       size_t num_clks, i;
> +       int ret;
> +
> +       dev = &pdev->dev;

Just do this when dev is defined please.

> +
> +       ret = cmd_db_ready();
> +       if (ret) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "Command DB not available (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       rpmh_client = rpmh_get_client(pdev);
> +       if (IS_ERR(rpmh_client)) {
> +               ret = PTR_ERR(rpmh_client);
> +               dev_err(dev, "Failed to request RPMh client, ret=%d\n", ret);
> +               return ret;
> +       }
> +
> +       desc = of_device_get_match_data(&pdev->dev);
> +       hw_clks = desc->clks;
> +       num_clks = desc->num_clks;
> +
> +       hw_data = devm_kzalloc(dev,
> +                       sizeof(*hw_data) + num_clks * sizeof(struct clk_hw *),
> +                       GFP_KERNEL);
> +       if (!hw_data)
> +               return -ENOMEM;
> +
> +       hw_data->num = num_clks;
> +
> +       for (i = 0; i < num_clks; i++) {
> +               const char *clk_name;
> +               struct property *prop;
> +               const __be32 *p;
> +               u32 res_addr;
> +               int div, j = 0;
> +
> +               rpmh_clk = to_clk_rpmh(hw_clks[i]);
> +               res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> +               if (!res_addr) {
> +                       dev_err(dev, "missing RPMh resource address for %s\n",
> +                                       rpmh_clk->res_name);
> +                       ret = -ENODEV;
> +                       goto err;
> +               }
> +               rpmh_clk->res_addr += res_addr;

Thanks!

> +
> +               rpmh_clk->rpmh_client = rpmh_client;
> +
> +               /* default div for all clocks */
> +               if (!rpmh_clk->div)
> +                       rpmh_clk->div = 1;
> +
> +               of_property_for_each_u32(pdev->dev.of_node, "assigned-clk-divs",
> +                                               prop, p, div) {
> +                       of_property_read_string_index(pdev->dev.of_node,
> +                                       "clk-output-names", j, &clk_name);
> +                       if (!strcmp(clk_name, hw_clks[i]->init->name)) {
> +                               rpmh_clk->div = div;
> +                               rpmh_clk->peer->div = div;
> +                       }
> +                       j++;
> +               }
> +
> +               clk = devm_clk_register(&pdev->dev, hw_clks[i]);
> +               if (IS_ERR(clk)) {
> +                       ret = PTR_ERR(clk);
> +                       dev_err(dev, "failed to register %s\n",
> +                                       hw_clks[i]->init->name);
> +                       goto err;
> +               }
> +
> +               rpmh_clk->dev = &pdev->dev;
> +       }
> +
> +       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,

Why not roll your own "getter" function and then just index directly
into your array of rpmh clks for sdm845? Then we don't have to copy
things from one place to another.

> +                                     hw_data);
> +       if (ret) {
> +               dev_err(dev, "Failed to add clock provider\n");
> +               goto err;
> +       }
> +
> +       dev_dbg(dev, "Registered RPMh clocks\n");
> +
> +       return 0;
> +err:
> +       if (rpmh_client)
> +               rpmh_release(rpmh_client);
> +
> +       return ret;
> +}
> +
