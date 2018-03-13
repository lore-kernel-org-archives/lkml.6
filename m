Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeCMFmt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:42:49 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36046 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeCMFmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:42:47 -0400
X-Google-Smtp-Source: AG47ELt/F1dYe538y84ycAMoPJHt1vI3eIH6QKaj6GGSKhw55l6XoIXGLrOQWJ+vkmK4Pk3AfzVG6BYAoETmWWoHDDE=
MIME-Version: 1.0
In-Reply-To: <1520542640-9185-3-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com> <1520542640-9185-3-git-send-email-eajames@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 13 Mar 2018 16:12:26 +1030
X-Google-Sender-Auth: QZlbXfyQMtre_edPLvN_sV9ZAoE
Message-ID: <CACPK8XerwPD7Fzb_1k6wgwmd4NjM7KZcj9Wz7CZk_9nKKgNy1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Prevent reset if clock is enabled
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
        sboyd@kernel.org, Lei YU <mine260309@gmail.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 7:27 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> According to the Aspeed specification, the reset and enable sequence
> should be done when the clock is stopped. The specification doesn't
> define behavior if the reset is done while the clock is enabled.
>
> From testing on the AST2500, the LPC Controller has problems if the
> clock is reset while enabled.
>
> Therefore, check whether the clock is enabled or not before performing
> the reset and enable sequence in the Aspeed clock driver.
>
> Root-caused-by: Lei Yu <mine260309@gmail.com>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel


> ---
>  drivers/clk/clk-aspeed.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 1687771..5eb50c3 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -205,6 +205,18 @@ struct aspeed_clk_soc_data {
>         .calc_pll = aspeed_ast2400_calc_pll,
>  };
>
> +static int aspeed_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> +       u32 clk = BIT(gate->clock_idx);
> +       u32 enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
> +       u32 reg;
> +
> +       regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
> +
> +       return ((reg & clk) == enval) ? 1 : 0;
> +}
> +
>  static int aspeed_clk_enable(struct clk_hw *hw)
>  {
>         struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> @@ -215,6 +227,11 @@ static int aspeed_clk_enable(struct clk_hw *hw)
>
>         spin_lock_irqsave(gate->lock, flags);
>
> +       if (aspeed_clk_is_enabled(hw)) {
> +               spin_unlock_irqrestore(gate->lock, flags);
> +               return 0;
> +       }
> +
>         if (gate->reset_idx >= 0) {
>                 /* Put IP in reset */
>                 regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, rst);
> @@ -255,18 +272,6 @@ static void aspeed_clk_disable(struct clk_hw *hw)
>         spin_unlock_irqrestore(gate->lock, flags);
>  }
>
> -static int aspeed_clk_is_enabled(struct clk_hw *hw)
> -{
> -       struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
> -       u32 clk = BIT(gate->clock_idx);
> -       u32 enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
> -       u32 reg;
> -
> -       regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
> -
> -       return ((reg & clk) == enval) ? 1 : 0;
> -}
> -
>  static const struct clk_ops aspeed_clk_gate_ops = {
>         .enable = aspeed_clk_enable,
>         .disable = aspeed_clk_disable,
> --
> 1.8.3.1
>
