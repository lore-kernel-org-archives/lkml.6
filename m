Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEDQvV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeEDQvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:51:19 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525428158-29147-2-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1525428158-29147-1-git-send-email-tdas@codeaurora.org>
 <1525428158-29147-2-git-send-email-tdas@codeaurora.org>
Message-ID: <152545267793.138124.15345698220033125655@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [v8] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Fri, 04 May 2018 09:51:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44GpPAH013414

Quoting Taniya Das (2018-05-04 03:02:38)
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> new file mode 100644
> index 0000000..944fe04
> --- /dev/null
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +};
> +
> +struct clk_rpmh_desc {
> +       struct clk_hw **clks;
> +       size_t num_clks;
> +};

This could be replaced with the clk_hw_onecell_data struct and then the
only problem becomes the const part which seems pretty impossible to fix
at this point. One "workaround" is to memdup the structure. Ugh.

> +
> +static DEFINE_MUTEX(rpmh_clk_lock);
> +
> +#define __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,   \
> +                         _res_en_offset, _res_on, _div)                \
> +       static struct clk_rpmh _platform##_##_name_active;              \
> +       static struct clk_rpmh _platform##_##_name = {                  \
[..]
> +
> +static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long prate)
> +{
> +       struct clk_rpmh *r = to_clk_rpmh(hw);
> +       unsigned long rate = prate;
> +
> +       /*
> +        * RPMh clocks have a fixed rate. Return static rate.
> +        */
> +       do_div(rate, r->div);

Integer division won't suffice?

> +       return rate;
> +}
[...]
> +
> +static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
> +                                            void *data)
> +{
> +       struct clk_hw *hw_clks = data;
> +       unsigned int idx = clkspec->args[0];
> +
> +       if (idx < 0) {

It can't be less than 0 though because it's unsigned.

> +               pr_err("%s: invalid index %u\n", __func__, idx);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return &hw_clks[idx];
> +}
