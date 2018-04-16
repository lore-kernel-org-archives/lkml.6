Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDPRil convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeDPRij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:38:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F82321789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1523673401-21611-3-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>
References: <1523673401-21611-1-git-send-email-tdas@codeaurora.org>
 <1523673401-21611-3-git-send-email-tdas@codeaurora.org>
Message-ID: <152390031768.51482.12790579493617671456@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Mon, 16 Apr 2018 10:38:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-13 19:36:41)
> Add the RPMh clock driver to control the RPMh managed clock resources on
> some of the Qualcomm Technologies, Inc. SoCs.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>

Your signoff chain is very confused. The first signoff should match the
"From:" header but that doesn't seem to be the case here. And the sender
should be the last in the chain.

> ---
>  drivers/clk/qcom/Kconfig    |   9 ++
>  drivers/clk/qcom/Makefile   |   1 +
>  drivers/clk/qcom/clk-rpmh.c | 367 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 377 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-rpmh.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index fbf4532..63c3372 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -112,6 +112,15 @@ config IPQ_GCC_8074
>           i2c, USB, SD/eMMC, etc. Select this for the root clock
>           of ipq8074.
> 
> +config QCOM_CLK_RPMH
> +       tristate "RPMh Clock Driver"
> +       depends on COMMON_CLK_QCOM && QCOM_RPMH
> +       help
> +        RPMh manages shared resources on some Qualcomm Technologies, Inc.
> +        SoCs. It accepts requests from other hardware subsystems via RSC.
> +        Say Y if you want to support the clocks exposed by RPMh on
> +        platforms such as sdm845.

Capitalize sdm?

> +

Can this Kconfig be put into alphabetical order in this file?

>  config MSM_GCC_8660
>         tristate "MSM8660 Global Clock Controller"
>         depends on COMMON_CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 230332c..b2b5babf 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -36,5 +36,6 @@ obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
>  obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
>  obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
>  obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
> +obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
>  obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> new file mode 100644
> index 0000000..fa61284
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>

Is this include used?

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
> +#define CLK_RPMH_ARC_EN_OFFSET 0
> +#define CLK_RPMH_VRM_EN_OFFSET 4
> +#define CLK_RPMH_APPS_RSC_AO_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
> +                                        BIT(RPMH_ACTIVE_ONLY_STATE))
> +#define CLK_RPMH_APPS_RSC_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
> +                                     BIT(RPMH_ACTIVE_ONLY_STATE) | \
> +                                     BIT(RPMH_SLEEP_STATE))

Is there a reason these aren't inlined into the one place they're used?

> +struct clk_rpmh {
> +       struct clk_hw hw;
> +       const char *res_name;
> +       u32 res_addr;
> +       u32 res_en_offset;

Why do we store both res_addr and res_en_offset? Can't we just store
res_en_offset and then use that all the time? I don't see a user of
res_addr anywhere.

> +       u32 res_on_val;
> +       u32 res_off_val;

Is this used?

> +       u32 state;
> +       u32 aggr_state;
> +       u32 last_sent_aggr_state;
> +       u32 valid_state_mask;
> +       struct rpmh_client *rpmh_client;
> +       struct device *dev;
> +       struct clk_rpmh *peer;
> +       unsigned long rate;
> +};

Can you add some kernel-doc on these structure members?

> +
> +struct rpmh_cc {
> +       struct clk_onecell_data data;
> +       struct clk *clks[];
> +};

Hopefully this structure isn't needed.

> +
> +struct clk_rpmh_desc {
> +       struct clk_hw **clks;
> +       size_t num_clks;
> +};
> +
[...]
> +
> +static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
> +{
> +       return ((c->last_sent_aggr_state & BIT(state))
> +               != (c->aggr_state & BIT(state)));

Too many parenthesis here.

> +}
> +
> +static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
> +{
> +       struct tcs_cmd cmd = { 0 };
> +       u32 cmd_state, on_val;
> +       enum rpmh_state state = RPMH_SLEEP_STATE;
> +       int ret = 0;
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
> +                                       (state == RPMH_WAKE_ONLY_STATE) ?
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
> +static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
> +                                               bool enable)
> +{
> +       int ret;
> +
> +       /* Update state and aggregate state values based on enable value. */

Maybe this comment can go above the function itself.

> +       c->state = enable ? c->valid_state_mask : 0;
> +       c->aggr_state = c->state | c->peer->state;
> +       c->peer->aggr_state = c->aggr_state;
> +
> +       ret = clk_rpmh_send_aggregate_command(c);
> +       if (ret && enable) {
> +               c->state = 0;
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
> +       if (c->state)
> +               goto out;
> +
> +       ret = clk_rpmh_aggregate_state_send_command(c, true);

Rewrite this as:

	if (!c->state)
		ret = clk_rpmh_aggregate_state_send_command(c, true);
	
and drop the goto.

> +out:
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
> +       if (!c->state)
> +               goto out;
> +
> +       clk_rpmh_aggregate_state_send_command(c, false);
> +out:

Same comment.

> +       mutex_unlock(&rpmh_clk_lock);
> +       return;
> +};
> +
> +static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
> +                                         unsigned long parent_rate)
> +{
> +       struct clk_rpmh *r = to_clk_rpmh(hw);
> +
> +       /*
> +        * RPMh clocks have a fixed rate. Return static rate set
> +        * at init time.
> +        */
> +       return r->rate;

The rate should come from the parent. In the case of tcxo it would be
board_xo clk rate (or maybe some fixed div-2 on the board XO that's also
defined in DT because the board_xo seems to be two times 19.2 MHz?).

> +}
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
> +
> +static struct clk_hw *sdm845_rpmh_clocks[] = {
> +       [RPMH_CXO_CLK]          = &sdm845_bi_tcxo.hw,
> +       [RPMH_CXO_CLK_A]        = &sdm845_bi_tcxo_ao.hw,
> +       [RPMH_LN_BB_CLK2]       = &sdm845_ln_bb_clk2.hw,
> +       [RPMH_LN_BB_CLK2_A]     = &sdm845_ln_bb_clk2_ao.hw,
> +       [RPMH_LN_BB_CLK3]       = &sdm845_ln_bb_clk3.hw,
> +       [RPMH_LN_BB_CLK3_A]     = &sdm845_ln_bb_clk3_ao.hw,
> +       [RPMH_RF_CLK1]          = &sdm845_rf_clk1.hw,
> +       [RPMH_RF_CLK1_A]        = &sdm845_rf_clk1_ao.hw,
> +       [RPMH_RF_CLK2]          = &sdm845_rf_clk2.hw,
> +       [RPMH_RF_CLK2_A]        = &sdm845_rf_clk2_ao.hw,
> +       [RPMH_RF_CLK3]          = &sdm845_rf_clk3.hw,
> +       [RPMH_RF_CLK3_A]        = &sdm845_rf_clk3_ao.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
> +       .clks = sdm845_rpmh_clocks,
> +       .num_clks = ARRAY_SIZE(sdm845_rpmh_clocks),
> +};
> +
> +static int clk_rpmh_probe(struct platform_device *pdev)
> +{
> +       struct clk **clks;
> +       struct clk *clk;
> +       struct rpmh_cc *rcc;
> +       struct clk_onecell_data *data;
> +       struct clk_hw **hw_clks;
> +       struct clk_rpmh *rpmh_clk;
> +       const struct clk_rpmh_desc *desc;
> +       struct rpmh_client *rpmh_client;
> +       struct device *dev;
> +       size_t num_clks, i;
> +       int ret;
> +
> +       dev = &pdev->dev;
> +
> +       ret = cmd_db_ready();
> +       if (ret) {
> +               if (ret != -EPROBE_DEFER) {
> +                       dev_err(dev, "Command DB not available (%d)\n", ret);
> +                       goto fail;

Please just return error here instead of goto.

> +               }
> +               return ret;
> +       }
> +
> +       rpmh_client = rpmh_get_client(pdev);
> +       if (IS_ERR(rpmh_client)) {
> +               ret = PTR_ERR(rpmh_client);
> +               dev_err(dev, "Failed to request RPMh client, ret=%d\n", ret);
> +               return ret;
> +       }

I hope we get rid of rpmh_get_client() still.

> +
> +       desc = of_device_get_match_data(&pdev->dev);
> +       hw_clks = desc->clks;
> +       num_clks = desc->num_clks;
> +
> +       rcc = devm_kzalloc(&pdev->dev, sizeof(*rcc) + sizeof(*clks) * num_clks,
> +                          GFP_KERNEL);
> +       if (!rcc) {
> +               ret = -ENOMEM;
> +               goto err;
> +       }
> +
> +       clks = rcc->clks;
> +       data = &rcc->data;
> +       data->clks = clks;
> +       data->clk_num = num_clks;
> +
> +       for (i = 0; i < num_clks; i++) {
> +               rpmh_clk = to_clk_rpmh(hw_clks[i]);
> +               rpmh_clk->res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> +               if (!rpmh_clk->res_addr) {
> +                       dev_err(dev, "missing RPMh resource address for %s\n",
> +                                       rpmh_clk->res_name);
> +                       ret = -ENODEV;
> +                       goto err;
> +               }
> +
> +               rpmh_clk->rpmh_client = rpmh_client;
> +
> +               clk = devm_clk_register(&pdev->dev, hw_clks[i]);
> +               if (IS_ERR(clk)) {
> +                       ret = PTR_ERR(clk);
> +                       dev_err(dev, "failed to register %s\n",
> +                                       hw_clks[i]->init->name);

This isn't a useful error message either.

> +                       goto err;
> +               }
> +
> +               clks[i] = clk;
> +               rpmh_clk->dev = &pdev->dev;
> +       }
> +
> +       ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,

Use devm please and register clk_hw pointers instead of clk pointers.

> +                                 data);
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
> +fail:
> +       dev_err(dev, "Error registering RPMh Clock driver (%d)\n", ret);

Please remove this error message.

> +       return ret;
> +}
> +
> +static int clk_rpmh_remove(struct platform_device *pdev)
> +{
> +       const struct clk_rpmh_desc *desc =
> +                       of_device_get_match_data(&pdev->dev);
> +       struct clk_hw **hw_clks = desc->clks;
> +       struct clk_rpmh *rpmh_clk = to_clk_rpmh(hw_clks[0]);
> +
> +       rpmh_release(rpmh_clk->rpmh_client);
> +       of_clk_del_provider(pdev->dev.of_node);
> +
> +       return 0;
> +}

Hopefully this whole remove function goes away.
