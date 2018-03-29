Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeC2Vu0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:50:26 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44718 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2VuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:50:24 -0400
X-Google-Smtp-Source: AIpwx4+jEfQROiH70zLbPGj12JC+dQTZXEVtKRbjFR52IwQb8XCL8Th78X1SItdMSD/xLVOnX2vzog==
MIME-Version: 1.0
References: <1522304274-18989-1-git-send-email-tdas@codeaurora.org> <1522304274-18989-2-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1522304274-18989-2-git-send-email-tdas@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 29 Mar 2018 21:49:45 +0000
X-Gmail-Original-Message-ID: <CAE=gft6-FggNjP0nj6XrLN1rQqnep_PHHWg2fiRUrM8ZBf36Sg@mail.gmail.com>
Message-ID: <CAE=gft6-FggNjP0nj6XrLN1rQqnep_PHHWg2fiRUrM8ZBf36Sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: tdas@codeaurora.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, okukatla@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, collinsd@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

On Wed, Mar 28, 2018 at 11:19 PM Taniya Das <tdas@codeaurora.org> wrote:

> From: Amit Nischal <anischal@codeaurora.org>

> Add the RPMh clock driver to control the RPMh managed clock resources on
> some of the Qualcomm Technologies, Inc. SoCs.

> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>   drivers/clk/qcom/Kconfig              |   9 +
>   drivers/clk/qcom/Makefile             |   1 +
>   drivers/clk/qcom/clk-rpmh.c           | 397
++++++++++++++++++++++++++++++++++
>   include/dt-bindings/clock/qcom,rpmh.h |  25 +++
>   4 files changed, 432 insertions(+)
>   create mode 100644 drivers/clk/qcom/clk-rpmh.c
>   create mode 100644 include/dt-bindings/clock/qcom,rpmh.h

> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
...
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> new file mode 100644
> index 0000000..536d102
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__

Stanimir recently commented on a different patch asking for using dev_*
instead of this. Seems like an applicable comment here, too.

> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>

Alphabetize includes?

> +
> +#include "common.h"
> +#include "clk-regmap.h"
> +
> +#define CLK_RPMH_ARC_EN_OFFSET 0
> +#define CLK_RPMH_VRM_EN_OFFSET 4
> +#define CLK_RPMH_VRM_OFF_VAL 0
> +#define CLK_RPMH_VRM_ON_VAL 1
> +#define CLK_RPMH_APPS_RSC_AO_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
> +                                        BIT(RPMH_ACTIVE_ONLY_STATE))
> +#define CLK_RPMH_APPS_RSC_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
> +                                     BIT(RPMH_ACTIVE_ONLY_STATE) | \
> +                                     BIT(RPMH_SLEEP_STATE))
> +struct clk_rpmh {
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
> +       unsigned long rate;
> +       struct clk_rpmh *peer;
> +       struct clk_hw hw;

I believe this member should go at the beginning of the structure. At least
that's what everyone else seems to do, and that's what the clk.txt
documentation seems to ask for.

> +};
> +
> +struct rpmh_cc {
> +       struct clk_onecell_data data;
> +       struct clk *clks[];
> +};
> +
> +struct clk_rpmh_desc {
> +       struct clk_hw **clks;
> +       size_t num_clks;
> +};
> +
> +static DEFINE_MUTEX(rpmh_clk_lock);
> +
> +#define __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name, \
> +                         _res_en_offset, _res_on, _res_off, _rate, \
> +                         _state_mask, _state_on_mask)
      \
> +       static struct clk_rpmh _platform##_##_name_active;
      \
> +       static struct clk_rpmh _platform##_##_name = {
      \
> +               .res_name = _res_name,
      \
> +               .res_en_offset = _res_en_offset,
      \
> +               .res_on_val = _res_on,
      \
> +               .res_off_val = _res_off,
      \
> +               .rate = _rate,
      \
> +               .peer = &_platform##_##_name_active,
      \
> +               .valid_state_mask = _state_mask,
      \
> +               .hw.init = &(struct clk_init_data){
     \
> +                       .ops = &clk_rpmh_ops,
     \
> +                       .name = #_name,
     \
> +               },
      \
> +       };
      \
> +       static struct clk_rpmh _platform##_##_name_active = {
     \
> +               .res_name = _res_name,
      \
> +               .res_en_offset = _res_en_offset,
      \
> +               .res_on_val = _res_on,
      \
> +               .res_off_val = _res_off,
      \
> +               .rate = _rate,
      \
> +               .peer = &_platform##_##_name,
     \
> +               .valid_state_mask = _state_on_mask,
     \
> +               .hw.init = &(struct clk_init_data){
     \
> +                       .ops = &clk_rpmh_ops,
     \
> +                       .name = #_name_active,
      \
> +               },
      \
> +       }
> +
> +#define DEFINE_CLK_RPMH_ARC(_platform, _name, _name_active, _res_name, \
> +                           _res_on, _res_off, _rate, _state_mask, \
> +                           _state_on_mask)                             \
> +       __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,    \
> +                         CLK_RPMH_ARC_EN_OFFSET, _res_on, _res_off, \
> +                         _rate, _state_mask, _state_on_mask)
> +
> +#define DEFINE_CLK_RPMH_VRM(_platform, _name, _name_active, _res_name, \
> +                           _rate, _state_mask, _state_on_mask) \
> +       __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,    \
> +                         CLK_RPMH_VRM_EN_OFFSET, CLK_RPMH_VRM_ON_VAL,  \
> +                         CLK_RPMH_VRM_OFF_VAL, _rate, _state_mask, \
> +                         _state_on_mask)
> +
> +static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
> +{
> +       return container_of(_hw, struct clk_rpmh, hw);
> +}
> +
> +static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
> +{
> +       return ((c->last_sent_aggr_state & BIT(state))
> +               != (c->aggr_state & BIT(state)));
> +}
> +
> +static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
> +{
> +       struct tcs_cmd cmd = { 0 };
> +       int ret = 0;
> +
> +       cmd.addr = c->res_addr + c->res_en_offset;
> +
> +       if (has_state_changed(c, RPMH_SLEEP_STATE)) {
> +               cmd.data = (c->aggr_state >> RPMH_SLEEP_STATE) & 1
> +                       ? c->res_on_val : c->res_off_val;

I found it quite confusing that you're shifting in the opposite direction
than in has_state_changed. How about this:

cmd.data = (c->aggr_state & BIT(RPMH_SLEEP_STATE)) ? c->res_on_val :
c->res_off_val;

> +               ret = rpmh_write_async(c->rpmh_client, RPMH_SLEEP_STATE,
> +                                      &cmd, 1);
> +               if (ret) {
> +                       pr_err("rpmh_write_async(%s, state=%d) failed
(%d)\n",
> +                              c->res_name, RPMH_SLEEP_STATE, ret);
> +                       return ret;
> +               }
> +       }
> +
> +       if (has_state_changed(c, RPMH_WAKE_ONLY_STATE)) {
> +               cmd.data = (c->aggr_state >> RPMH_WAKE_ONLY_STATE) & 1
> +                       ? c->res_on_val : c->res_off_val;
> +               ret = rpmh_write_async(c->rpmh_client,
> +                                      RPMH_WAKE_ONLY_STATE, &cmd, 1);
> +               if (ret) {
> +                       pr_err("rpmh_write_async(%s, state=%d) failed
(%d)\n",
> +                              c->res_name, RPMH_WAKE_ONLY_STATE, ret);
> +                       return ret;
> +               }
> +       }
> +
> +       if (has_state_changed(c, RPMH_ACTIVE_ONLY_STATE)) {
> +               cmd.data = (c->aggr_state >> RPMH_ACTIVE_ONLY_STATE) & 1
> +                       ? c->res_on_val : c->res_off_val;
> +               ret = rpmh_write(c->rpmh_client, RPMH_ACTIVE_ONLY_STATE,
> +                                &cmd, 1);
> +               if (ret) {
> +                       pr_err("rpmh_write(%s, state=%d) failed (%d)\n",
> +                              c->res_name, RPMH_ACTIVE_ONLY_STATE, ret);
> +                       return ret;
> +               }
> +       }
> +
> +       c->last_sent_aggr_state = c->aggr_state;
> +       c->peer->last_sent_aggr_state =  c->last_sent_aggr_state;
> +
> +       return 0;
> +}
> +
> +static void clk_rpmh_aggregate_state(struct clk_rpmh *c, bool enable)
> +{
> +       /* Update state and aggregate state values based on enable value.
*/
> +       c->state = enable ? c->valid_state_mask : 0;
> +       c->aggr_state = c->state | c->peer->state;
> +       c->peer->aggr_state = c->aggr_state;
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
> +       clk_rpmh_aggregate_state(c, true);
> +
> +       ret = clk_rpmh_send_aggregate_command(c);
> +
> +       if (ret)
> +               c->state = 0;
> +
> +out:
> +       mutex_unlock(&rpmh_clk_lock);
> +       return ret;
> +};
> +
> +static void clk_rpmh_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_rpmh *c = to_clk_rpmh(hw);
> +       int ret = 0;
> +
> +       mutex_lock(&rpmh_clk_lock);
> +
> +       if (!c->state)
> +               goto out;
> +
> +       clk_rpmh_aggregate_state(c, false);
> +
> +       ret = clk_rpmh_send_aggregate_command(c);
> +
> +       if (ret) {
> +               c->state = c->valid_state_mask;
> +               WARN(1, "clk: %s failed to disable\n", c->res_name);
> +       }
> +
> +out:
> +       mutex_unlock(&rpmh_clk_lock);
> +       return;
> +};

The guts of these two functions (clk_rpmh_{un,}prepare) look like they
would collapse pretty well into a single helper function that takes an
extra enable parameter. The if would change to !!c->state == enable,
clk_rpmh_aggregate_state would take the enable parameter, and the failure
case could restore a previously saved value. And you could just ditch the
WARN entirely (probably should do that anyway). Not critical though, up to
you.

...

> +
> +static int clk_rpmh_probe(struct platform_device *pdev)
> +{
> +       struct clk **clks;
> +       struct clk *clk;
> +       struct rpmh_cc *rcc;
> +       struct clk_onecell_data *data;
> +       int ret;
> +       size_t num_clks, i;
> +       struct clk_hw **hw_clks;
> +       struct clk_rpmh *rpmh_clk;
> +       const struct clk_rpmh_desc *desc;
> +       struct property *prop;

Remove this unused variable. It generates a warning (or an error for some
of us).
...
> diff --git a/include/dt-bindings/clock/qcom,rpmh.h
b/include/dt-bindings/clock/qcom,rpmh.h
> new file mode 100644
> index 0000000..34fbf3c
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,rpmh.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_MSM_RPMH_H
> +#define _DT_BINDINGS_CLK_MSM_RPMH_H

Maybe _DT_BINDINGS_CLK_QCOM_RPMH_H instead?

-Evan
