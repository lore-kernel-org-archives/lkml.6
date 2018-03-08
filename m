Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754963AbeCHDnM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 22:43:12 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45547 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754577AbeCHDnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 22:43:10 -0500
X-Google-Smtp-Source: AG47ELsDsjcQTLMhuwzKfleZUt/88Li/6d0tnsmjNgv/GRy9jdzf8HLlwVvPZ3NYdjSVLiVHVBV8sbE7jE/hUY4PllQ=
MIME-Version: 1.0
In-Reply-To: <1520440570-25280-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520440570-25280-1-git-send-email-eajames@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 8 Mar 2018 14:12:48 +1030
X-Google-Sender-Auth: Nu_Mnb4ZIm444V3iJ9g-iLaz54w
Message-ID: <CACPK8Xe5rVtB6hUo4xW9qSz-T+kehvXSRv5g1_6KOO=BYr8Qwg@mail.gmail.com>
Subject: Re: [PATCH] clk: aspeed: Prevent reset if clock is enabled
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
        sboyd@kernel.org, Lei YU <mine260309@gmail.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

On Thu, Mar 8, 2018 at 3:06 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
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
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/clk/clk-aspeed.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 9f7f931..a13054d 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -212,6 +212,12 @@ static int aspeed_clk_enable(struct clk_hw *hw)
>         u32 clk = BIT(gate->clock_idx);
>         u32 rst = BIT(gate->reset_idx);
>         u32 enval;
> +       u32 reg;
> +
> +       /* Only reset/enable/unreset if clock is stopped */
> +       regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
> +       if (!(reg & clk))
> +               return 0;

This doesn't generalise to all of the clocks, as some clocks use set
to disable. Perhaps we could do something like this:

       /* Only reset/enable/unreset if clock is stopped. The LPC clock
on ast2500 has issues otherwise */
       enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
       regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
       if ((reg & clk) == enval) {
               spin_unlock_irqrestore(gate->lock, flags);
               return 0;
       }

I think we should also do this operation under the lock.

Please cc Ryan Chen <ryan_chen@aspeedtech.com> so he can confirm that
this workaround is valid, and credit Lei who spent a lot of time
investigating this issue. Perhaps "Root-caused-by".

Cheers,

Joel
