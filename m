Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbeEBHXd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbeEBHXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:23:30 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525105210-8689-4-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
 <1525105210-8689-4-git-send-email-anischal@codeaurora.org>
Message-ID: <152524580953.138124.2159165461856101134@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 3/3] clk: qcom: Add Global Clock controller (GCC) driver for
 SDM845
Date: Wed, 02 May 2018 00:23:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w427NcTQ026086

Quoting Amit Nischal (2018-04-30 09:20:10)
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
>  drivers/clk/qcom/Kconfig                           |   10 +-
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/gcc-sdm845.c                      | 3480 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sdm845.h        |  239 ++

Do the split that Rob suggests please, given that you're resending. And
also include his reviewed-by tag.

>  5 files changed, 3727 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clk/qcom/gcc-sdm845.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm845.h
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index e42e1af..3298beb 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -218,13 +218,15 @@ config MSM_MMCC_8996
>           Say Y if you want to support multimedia devices such as display,
>           graphics, video encode/decode, camera, etc.
> 
> -config MSM_GCC_8998
> -       tristate "MSM8998 Global Clock Controller"
> +config SDM_GCC_845
> +       tristate "SDM845 Global Clock Controller"
> +       select QCOM_GDSC
>         depends on COMMON_CLK_QCOM
>         help
> -         Support for the global clock controller on msm8998 devices.
> +         Support for the global clock controller on Qualcomm Technologies, Inc
> +         sdm845 devices.
>           Say Y if you want to use peripheral devices such as UART, SPI,
> -         i2c, USB, UFS, SD/eMMC, PCIe, etc.
> +         I2C, USB, UFS, SDDC, PCIe, etc.

This is all wrong.

> 
>  config SPMI_PMIC_CLKDIV
>         tristate "SPMI PMIC clkdiv Support"
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> new file mode 100644
> index 0000000..6484cba
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -0,0 +1,3480 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
[...]
> +                       .name = "gcc_disp_axi_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_disp_gpll0_clk_src = {
> +       .halt_reg = 0x52004,
> +       .halt_check = BRANCH_HALT_DELAY,

What about this one? It's not a phy so I'm confused again why we're
unable to check the halt bit. To be clear(er), I don't see why we ever
want to have HALT_DELAY used. Hopefully we can remove that flag.

>From what I recall, the flag is there for clks that don't toggle their
status bit at all, but that we know take a few cycles to ungate the
upstream clk. So we threw a delay into the code to make sure that when
clk_enable() returned, a driver wouldn't try to use hardware before the
clk was actually on. But these cases should pretty much never happen,
hence all the pushback against this flag.

> +       .clkr = {
> +               .enable_reg = 0x52004,
> +               .enable_mask = BIT(18),
> +               .hw.init = &(struct clk_init_data){
> +                       .name = "gcc_disp_gpll0_clk_src",
> +                       .parent_names = (const char *[]){
> +                               "gpll0",
> +                       },
> +                       .num_parents = 1,
[...]
> +               .enable_reg = 0x7508c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(struct clk_init_data){
> +                       .name = "gcc_ufs_card_phy_aux_clk",
> +                       .parent_names = (const char *[]){
> +                               "gcc_ufs_card_phy_aux_clk_src",
> +                       },
> +                       .num_parents = 1,
> +                       .flags = CLK_SET_RATE_PARENT,
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_ufs_card_rx_symbol_0_clk = {
> +       .halt_reg = 0x75018,
> +       .halt_check = BRANCH_HALT_DELAY,

There are still HALT_DELAY flags for UFS though? Why?

Also, are you going to send DFS support for the QUP clks? I would like
to see that code merged soon.
