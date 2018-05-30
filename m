Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932181AbeE3Tta (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:49:30 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42900 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbeE3Tt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:27 -0400
X-Google-Smtp-Source: ADUXVKIrUVwoYaLterF9sI2xZqTRZlcaZOJYUXh7uJ+l9s9fDyYedjTkz+LOlCdK06e/1HV0ix6x2MxyzZNnVW34LfE=
MIME-Version: 1.0
In-Reply-To: <1527154169-32380-6-git-send-email-michel.pollet@bp.renesas.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com> <1527154169-32380-6-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 May 2018 21:49:25 +0200
X-Google-Sender-Auth: buKUUg6mU14XJGSumNKiRWKdtD8
Message-ID: <CAMuHMdW9fSKZv2qA2oz9NCL+MdASAMnxf1UZomJv3_Zts44ygw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] clk: renesas: Renesas R9A06G032 clock driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This provides a clock driver for the Renesas R09A06G032.
> This uses a structure derived from both the RCAR gen2 driver as well as
> the renesas-cpg-mssr driver.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c

> +/* register/bit pairs are encoded as an uint16_t */
> +static void clk_rdesc_set(
> +       struct r9a06g032_priv *clocks,
> +       uint16_t one, unsigned int on)
> +{
> +       u32 __iomem *reg = ((u32 __iomem *)clocks->reg) + (one >> 5);

Do you need the cast? Gcc does support void pointer arithmetic, and treats
that like byte pointers.

> +       u32 val = clk_readl(reg);
> +
> +       val = (val & ~(1U << (one & 0x1f))) | ((!!on) << (one & 0x1f));
> +       clk_writel(val, reg);

Hence

        clk_writel(val, clocks->reg + 4 * (one >> 5));

Actually clk_{read,write}l() are deprecated, please use {read,write}l() instead.

> +static void r9a06g032_clk_gate_disable(struct clk_hw *hw)
> +{
> +       struct r9a06g032_clk_gate *g = to_r9a06g032_gate(hw);
> +
> +       if (!g->read_only)
> +               r9a06g032_clk_gate_set(g->clocks, &g->gate, 0);
> +       else
> +               pr_debug("%s %s: disallowed\n", __func__,
> +                       __clk_get_name(hw->clk));

You can print the name of a clock using %pC:

    pr_debug("%s %pC: disallowed\n", __func__, hw->clk);

But I don't think you need the check, cfr. below.

> +static struct clk *r9a06g032_register_gate(
> +       struct r9a06g032_priv *clocks,
> +       const char *parent_name,
> +       const struct r9a06g032_clkdesc *desc)
> +{
> +       struct clk *clk;
> +       struct r9a06g032_clk_gate *g;
> +       struct clk_init_data init;
> +
> +       g = kzalloc(sizeof(struct r9a06g032_clk_gate), GFP_KERNEL);
> +       if (!g)
> +               return NULL;
> +
> +       init.name = desc->name;
> +       init.ops = &r9a06g032_clk_gate_ops;
> +       init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
> +       init.parent_names = parent_name ? &parent_name : NULL;
> +       init.num_parents = parent_name ? 1 : 0;
> +
> +       g->clocks = clocks;
> +       g->index = desc->index;
> +       g->gate = desc->gate;
> +       g->hw.init = &init;
> +       g->read_only = 0;
> +
> +       clk = clk_register(NULL, &g->hw);
> +       if (IS_ERR(clk)) {
> +               kfree(g);
> +               return NULL;
> +       }
> +       /*
> +        * important here, some clocks are already in use by the CM3, we
> +        * have to assume they are not Linux's to play with and try to disable
> +        * at the end of the boot!
> +        * Therefore we increase the clock usage count by arbitrarily enabling
> +        * the clock, allowing it to stay untouched at the end of the boot.
> +        */
> +       g->read_only = r9a06g032_clk_gate_is_enabled(&g->hw);

Is checking if the clock is enabled the recommended way to find out if a
clock is used by the Cortex M3? No need for a table?

> +       if (g->read_only)
> +               pr_debug("%s was enabled, making read-only\n", desc->name);

You can set init.flags |= CLK_IS_CRITICAL instead of using your own flag.

> +static unsigned long r9a06g032_divider_recalc_rate(
> +       struct clk_hw *hw,
> +       unsigned long parent_rate)
> +{
> +       struct r9a06g032_clk_div *clk = to_r9a06g032_divider(hw);
> +       u32 *reg = ((u32 *)clk->clocks->reg) + clk->reg;

Fishy operations on __iomem pointers

> +       long div = clk_readl(reg);

u32 div?

> +
> +       if (div < clk->min)
> +               div = clk->min;
> +       else if (div > clk->max)
> +               div = clk->max;
> +       return DIV_ROUND_UP(parent_rate, div);
> +}
> +
> +/*
> + * Attempts to find a value that is in range of min,max,
> + * and if a table of set dividers was specified for this
> + * register, try to find the fixed divider that is the closest
> + * to the target frequency
> + */
> +static long r9a06g032_divider_clamp_div(
> +       struct r9a06g032_clk_div *clk,
> +       unsigned long rate, unsigned long prate)
> +{
> +       /* + 1 to cope with rates that have the remainder dropped */
> +       long div = DIV_ROUND_UP(prate, rate + 1);
> +       int i;

unsigned int i

> +
> +       if (div <= clk->min)
> +               return clk->min;
> +       if (div >= clk->max)
> +               return clk->max;
> +
> +       for (i = 0; clk->table_size && i < clk->table_size - 1; i++) {

> +static long r9a06g032_divider_round_rate(
> +       struct clk_hw *hw, unsigned long rate,
> +       unsigned long *prate)
> +{
> +       struct r9a06g032_clk_div *clk = to_r9a06g032_divider(hw);
> +       long div = DIV_ROUND_UP(*prate, rate);
> +
> +       pr_devel("%s %pC %ld (prate %ld) (wanted div %ld)\n", __func__,

Ah, you do know about %pC ;-)

> +               hw->clk, rate, *prate, div);
> +       pr_devel("   min %d (%ld) max %d (%ld)\n",
> +               clk->min, DIV_ROUND_UP(*prate, clk->min),
> +               clk->max, DIV_ROUND_UP(*prate, clk->max));
> +
> +       div = r9a06g032_divider_clamp_div(clk, rate, *prate);
> +       /*
> +        * this is a hack. Currently the serial driver asks for a clock rate
> +        * that is 16 times the baud rate -- and that is wildly outside the
> +        * range of the UART divider, somehow there is no provision for that
> +        * case of 'let the divider as is if outside range'.
> +        * The serial driver *shouldn't* play with these clocks anyway, there's
> +        * several uarts attached to this divider, and changing this impacts
> +        * everyone.

Huh?

> +        */
> +       if (clk->index == R9A06G032_DIV_UART) {
> +               pr_devel("%s div uart hack!\n", __func__);
> +               return clk_get_rate(hw->clk);
> +       }
> +       pr_devel("%s %pC %ld / %ld = %ld\n", __func__, hw->clk,
> +               *prate, div, DIV_ROUND_UP(*prate, div));
> +       return DIV_ROUND_UP(*prate, div);
> +}
> +
> +static int r9a06g032_divider_set_rate(
> +       struct clk_hw *hw, unsigned long rate,
> +       unsigned long parent_rate)
> +{
> +       struct r9a06g032_clk_div *clk = to_r9a06g032_divider(hw);
> +       /* + 1 to cope with rates that have the remainder dropped */
> +       u32 div = DIV_ROUND_UP(parent_rate, rate + 1);
> +       u32 *reg = ((u32 *)clk->clocks->reg) + clk->reg;
> +
> +       pr_devel("%s %pC rate %ld parent %ld div %d\n", __func__, hw->clk,
> +               rate, parent_rate, div);
> +
> +       /*
> +        * Need to write the bit 31 with the divider value to
> +        * latch it. Technically we should wait until it has been
> +        * cleared too.
> +        * TODO: Find whether this callback is sleepable, in case
> +        * the hardware /does/ require some sort of spinloop here.
> +        */
> +       clk_writel(div | (1U << 31), reg);

BIT(31)?

> +
> +       return 0;
> +}

> +static struct clk *r9a06g032_register_divider(
> +       struct r9a06g032_priv *clocks,
> +       const char *parent_name,
> +       const struct r9a06g032_clkdesc *desc)
> +{
> +       struct r9a06g032_clk_div *div;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +       int i;

unsigned int i;


> +static void __init r9a06g032_clocks_init(struct device_node *np)
> +{
> +       struct r9a06g032_priv *clocks;
> +       struct clk **clks;
> +       unsigned int i;
> +       uint16_t uart_group_sel[2];
> +
> +       clocks = kzalloc(sizeof(*clocks), GFP_KERNEL);
> +       clks = kzalloc(R9A06G032_CLOCK_COUNT * sizeof(struct clk *),
> +                       GFP_KERNEL);

kcalloc()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
