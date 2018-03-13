Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeCMFkZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:40:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:47071 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeCMFkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:40:23 -0400
X-Google-Smtp-Source: AG47ELvl11Ph1PNxhtIonn2q0MrzelcxKU1d08eVrVzwMtoAilqCGX3L1E1QL67F/QSa3uzBWudAD6GBU1vpePiura0=
MIME-Version: 1.0
In-Reply-To: <1520542640-9185-2-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com> <1520542640-9185-2-git-send-email-eajames@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 13 Mar 2018 16:10:01 +1030
X-Google-Sender-Auth: nCBf53ll4e-4NqFnxoijq0bLJrk
Message-ID: <CACPK8Xcx4P2kF8ryg=-WgZjjkVo3uzv+G2JGPiZiU3UGWV+4yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: aspeed: Fix is_enabled for certain clocks
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
> Some of the Aspeed clocks are disabled by setting the relevant bit in
> the "clock stop control" register to one, while others are disabled by
> setting their bit to zero. The driver already uses a flag per gate  to
> identify this behavior, but doesn't apply it in the clock is_enabled
> function.
>
> Use the existing gate flag to correctly return whether or not a clock
> is enabled in the aspeed_clk_is_enabled function.
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Fixes: 6671507f0fbd ("clk: aspeed: Handle inverse polarity of USB port
1 clock gate")

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

> ---
>  drivers/clk/clk-aspeed.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 9f7f931..1687771 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -259,11 +259,12 @@ static int aspeed_clk_is_enabled(struct clk_hw *hw)
>  {
>         struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
>         u32 clk = BIT(gate->clock_idx);
> +       u32 enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
>         u32 reg;
>
>         regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
>
> -       return (reg & clk) ? 0 : 1;
> +       return ((reg & clk) == enval) ? 1 : 0;
>  }
>
>  static const struct clk_ops aspeed_clk_gate_ops = {
> --
> 1.8.3.1
>
