Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeEBP1N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbeEBP1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:27:09 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525258277-3478-3-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1525258277-3478-1-git-send-email-tdas@codeaurora.org>
 <1525258277-3478-3-git-send-email-tdas@codeaurora.org>
Message-ID: <152527482828.138124.7114901348273696817@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Wed, 02 May 2018 08:27:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42FRK9F025968

Quoting Taniya Das (2018-05-02 03:51:17)
> +
> +static DEFINE_MUTEX(rpmh_clk_lock);
> +
> +#define __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,   \
> +                         _res_en_offset, _res_on)                      \
> +       static struct clk_rpmh _platform##_##_name_active;              \
> +       static struct clk_rpmh _platform##_##_name = {                  \
> +               .res_name = _res_name,                                  \
> +               .res_addr = _res_en_offset,                             \
> +               .res_on_val = _res_on,                                  \
> +               .peer = &_platform##_##_name_active,                    \
> +               .valid_state_mask = (BIT(RPMH_WAKE_ONLY_STATE) |        \
> +                                     BIT(RPMH_ACTIVE_ONLY_STATE) |     \
> +                                     BIT(RPMH_SLEEP_STATE)),           \
> +               .hw.init = &(struct clk_init_data){                     \
> +                       .ops = &clk_rpmh_ops,                           \
> +                       .name = #_name,                                 \
> +                       .parent_names = (const char *[]){ "xo_board",   \
> +                                               "xo_board_div" },       \

The rpmh clks that do a div 2 can have a recalc_rate function that
returns the xo_board clk rate divided by 2 all the time. That may be
easier to do. Keep xo_board as parent, but then specify if it does div-2
or div-1 in the SoC specific listing. Then DT can only show 38.4 MHz.
The div 2 part is inside the SoC anyway so this seems more accurate too.

> +                       .num_parents = 2,                               \
> +               },                                                      \
> +       };                                                              \
