Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755557AbeBCSua (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 13:50:30 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:39165 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeBCSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 13:46:42 -0500
X-Google-Smtp-Source: AH8x224gBqGKRBbeBHel8nuvio8S4hdw21w4vhba30CcveL1pGPTzw0x9kq/2NIJCuMh9XqL2zUw4nXK9ATV5J3TDc0=
MIME-Version: 1.0
In-Reply-To: <20180131180945.18025-18-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com> <20180131180945.18025-18-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 3 Feb 2018 19:46:20 +0100
Message-ID: <CAFBinCCpfpJQVkKvuBgS5T_AB+LNC3xXMCAUVYy38h=0Ge39Sg@mail.gmail.com>
Subject: Re: [PATCH 17/19] clk: meson: rework meson8b cpu clock
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, Jan 31, 2018 at 7:09 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> Instead of migrating meson cpu_clk to clk_regmap, like the other meson
> clock drivers, we take advantage of the massive rework to get rid of it
> completely, and solve (the first part) of the related FIXME notice.
>
> As pointed out in the code comments, the cpu_clk should be modeled with
> dividers and muxes it is made of, instead of one big composite clock.
>
> The other issue pointed out in the FIXME note, around cpu notifier,
> remains unsolved, until CCR comes up.
>
> AFAIK, the cpu_clk was not working correctly to enable dvfs on meson8b.
> This change being just a re-implementation, hopefully cleaner, of the
> cpu_clk, the problem remains unsolved as well.
I can confirm that I have seen system lock-ups when using the cpu_clk
implementation
your patch doesn't fully solve this (I still get some lock-ups), but I
still think it's a step forward!

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I have some minor comments below, with these addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  drivers/clk/meson/meson8b.c | 203 ++++++++++++++++++++++++++++++++++----------
>  drivers/clk/meson/meson8b.h |   7 +-
>  2 files changed, 163 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 625d953511be..e6a6b7c9cfa9 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -99,20 +99,6 @@ static const struct pll_rate_table sys_pll_rate_table[] = {
>         { /* sentinel */ },
>  };
>
> -static const struct clk_div_table cpu_div_table[] = {
> -       { .val = 1, .div = 1 },
> -       { .val = 2, .div = 2 },
> -       { .val = 3, .div = 3 },
> -       { .val = 2, .div = 4 },
> -       { .val = 3, .div = 6 },
> -       { .val = 4, .div = 8 },
> -       { .val = 5, .div = 10 },
> -       { .val = 6, .div = 12 },
> -       { .val = 7, .div = 14 },
> -       { .val = 8, .div = 16 },
> -       { /* sentinel */ },
> -};
> -
>  static struct clk_fixed_rate meson8b_xtal = {
>         .fixed_rate = 24000000,
>         .hw.init = &(struct clk_init_data){
> @@ -417,23 +403,6 @@ static struct clk_regmap meson8b_mpll2 = {
>         },
>  };
>
> -/*
> - * FIXME cpu clocks and the legacy composite clocks (e.g. clk81) are both PLL
> - * post-dividers and should be modeled with their respective PLLs via the
> - * forthcoming coordinated clock rates feature
> - */
> -static struct meson_clk_cpu meson8b_cpu_clk = {
> -       .reg_off = HHI_SYS_CPU_CLK_CNTL1,
> -       .div_table = cpu_div_table,
> -       .clk_nb.notifier_call = meson_clk_cpu_notifier_cb,
> -       .hw.init = &(struct clk_init_data){
> -               .name = "cpu_clk",
> -               .ops = &meson_clk_cpu_ops,
> -               .parent_names = (const char *[]){ "sys_pll" },
> -               .num_parents = 1,
> -       },
> -};
> -
>  static u32 mux_table_clk81[]   = { 6, 5, 7 };
>  static struct clk_regmap meson8b_mpeg_clk_sel = {
>         .data = &(struct clk_regmap_mux_data){
> @@ -486,6 +455,106 @@ struct clk_regmap meson8b_clk81 = {
>         },
>  };
>
> +struct clk_regmap meson8b_cpu_in_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x1,
> +               .shift = 0,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_in_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_names = (const char *[]){ "xtal", "sys_pll" },
> +               .num_parents = 2,
> +               .flags = (CLK_SET_RATE_PARENT |
> +                         CLK_SET_RATE_NO_REPARENT),
> +       },
> +};
> +
> +static struct clk_fixed_factor meson8b_cpu_div2 = {
> +       .mult = 1,
> +       .div = 2,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_div2",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "cpu_in_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_fixed_factor meson8b_cpu_div3 = {
> +       .mult = 1,
> +       .div = 3,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_div3",
> +               .ops = &clk_fixed_factor_ops,
> +               .parent_names = (const char *[]){ "cpu_in_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static const struct clk_div_table cpu_div_table[] = {
> +       { .val = 2, .div = 4 },
> +       { .val = 3, .div = 6 },
> +       { .val = 4, .div = 8 },
> +       { .val = 5, .div = 10 },
> +       { .val = 6, .div = 12 },
> +       { .val = 7, .div = 14 },
> +       { .val = 8, .div = 16 },
> +       { /* sentinel */ },
> +};
> +
> +struct clk_regmap meson8b_cpu_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset =  HHI_SYS_CPU_CLK_CNTL1,
> +               .shift = 20,
> +               .width = 9,
> +               .table = cpu_div_table,
> +               .flags = CLK_DIVIDER_ALLOW_ZERO,
looking at the Amlogic GPL kernel sources: [0]
they allow programming this divider with 0, however it seems that it's
not allowed to select this in the mux below
during my tests this seems to have worked fine because the first
parent of the mux below is cpu_in - which has the same rate as this
divider with register value 0. in this scenario the common clock
framework chooses the parent it finds first (cpu_in in this case -
which is fine)

> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_div",
I suggest to call this "cpu_scale_div", so it matches the value we
find in the public S805 datasheet on page 31: [1] (the same goes for
the variable name above and the CLKID #define)

> +               .ops = &clk_regmap_divider_ops,
> +               .parent_names = (const char *[]){ "cpu_in_sel" },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +struct clk_regmap meson8b_cpu_out_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x3,
> +               .shift = 2,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_out_sel",
I suggest to call this "cpu_scale_out_sel", so it matches the value we
find in the public S805 datasheet on page 34: [1] (the same goes for
the variable name above and the CLKID #define)

> +               .ops = &clk_regmap_mux_ops,
> +               .parent_names = (const char *[]) { "cpu_in_sel", "cpu_div2",
> +                                                  "cpu_div3", "cpu_div" },
> +               .num_parents = 4,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +struct clk_regmap meson8b_cpu_clk = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> +               .mask = 0x1,
> +               .shift = 7,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cpu_clk",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_names = (const char *[]){ "xtal", "cpu_out_sel" },
> +               .num_parents = 2,
> +               .flags = (CLK_SET_RATE_PARENT |
> +                         CLK_SET_RATE_NO_REPARENT),
> +       },
> +};
> +
>  /* Everything Else (EE) domain gates */
>
>  static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
> @@ -670,6 +739,11 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
>                 [CLKID_MPLL0_DIV]           = &meson8b_mpll0_div.hw,
>                 [CLKID_MPLL1_DIV]           = &meson8b_mpll1_div.hw,
>                 [CLKID_MPLL2_DIV]           = &meson8b_mpll2_div.hw,
> +               [CLKID_CPU_IN_SEL]          = &meson8b_cpu_in_sel.hw,
> +               [CLKID_CPU_DIV2]            = &meson8b_cpu_div2.hw,
> +               [CLKID_CPU_DIV3]            = &meson8b_cpu_div3.hw,
> +               [CLKID_CPU_DIV]             = &meson8b_cpu_div.hw,
> +               [CLKID_CPU_OUT_SEL]         = &meson8b_cpu_out_sel.hw,
>                 [CLK_NR_CLKS]               = NULL,
>         },
>         .num = CLK_NR_CLKS,
> @@ -765,6 +839,49 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
>         &meson8b_fixed_pll,
>         &meson8b_vid_pll,
>         &meson8b_sys_pll,
> +       &meson8b_cpu_in_sel,
> +       &meson8b_cpu_div,
> +       &meson8b_cpu_out_sel,
> +       &meson8b_cpu_clk,
> +};
> +
> +struct meson8b_nb_data {
> +       struct notifier_block nb;
> +       struct clk_hw_onecell_data *onecell_data;
> +};
> +
> +int meson8b_clk_cpu_notifier_cb(struct notifier_block *nb,
> +                               unsigned long event, void *data)
> +{
> +       struct meson8b_nb_data *nb_data =
> +               container_of(nb, struct meson8b_nb_data, nb);
> +       struct clk_hw **hws = nb_data->onecell_data->hws;
> +
> +       switch (event) {
> +       case PRE_RATE_CHANGE:
> +               clk_hw_reparent(hws[CLKID_CPUCLK],
> +                               hws[CLKID_XTAL]);
> +               udelay(100);
> +               clk_hw_reparent(hws[CLKID_CPU_IN_SEL],
> +                               hws[CLKID_PLL_SYS]);
> +               break;
> +
> +       case POST_RATE_CHANGE:
> +               clk_hw_reparent(hws[CLKID_CPUCLK],
> +                               hws[CLKID_CPU_OUT_SEL]);
> +               udelay(100);
> +               break;
> +
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct meson8b_nb_data cpu_nb_data = {
> +       .nb.notifier_call = meson8b_clk_cpu_notifier_cb,
> +       .onecell_data = &meson8b_hw_onecell_data,
>  };
>
>  static const struct meson8b_clk_reset_line {
> @@ -875,8 +992,7 @@ static const struct regmap_config clkc_regmap_config = {
>  static int meson8b_clkc_probe(struct platform_device *pdev)
>  {
>         int ret, i;
> -       struct clk_hw *parent_hw;
> -       struct clk *parent_clk;
> +       struct clk *clk;
>         struct device *dev = &pdev->dev;
>         struct regmap *map;
>
> @@ -887,9 +1003,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
>         if (IS_ERR(map))
>                 return PTR_ERR(map);
>
> -       /* Populate the base address for CPU clk */
> -       meson8b_cpu_clk.base = clk_base;
> -
>         /* Populate regmap for the regmap backed clocks */
>         for (i = 0; i < ARRAY_SIZE(meson8b_clk_regmaps); i++)
>                 meson8b_clk_regmaps[i]->map = map;
> @@ -909,25 +1022,23 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
>         }
>
>         /*
> -        * Register CPU clk notifier
> +        * Register sys clk notifier
>          *
> -        * FIXME this is wrong for a lot of reasons. First, the muxes should be
> -        * struct clk_hw objects. Second, we shouldn't program the muxes in
> -        * notifier handlers. The tricky programming sequence will be handled
> +        * FIXME this is wrong, we shouldn't program the muxes in notifier
> +        * handlers. The tricky programming sequence will be handled
>          * by the forthcoming coordinated clock rates mechanism once that
>          * feature is released.
>          *
> -        * Furthermore, looking up the parent this way is terrible. At some
> +        * Furthermore, looking up the clk this way is terrible. At some
>          * point we will stop allocating a default struct clk when registering
>          * a new clk_hw, and this hack will no longer work. Releasing the ccr
>          * feature before that time solves the problem :-)
>          */
> -       parent_hw = clk_hw_get_parent(&meson8b_cpu_clk.hw);
> -       parent_clk = parent_hw->clk;
> -       ret = clk_notifier_register(parent_clk, &meson8b_cpu_clk.clk_nb);
> +       clk = meson8b_hw_onecell_data.hws[CLKID_PLL_SYS]->clk;
> +       ret = clk_notifier_register(clk, &cpu_nb_data.nb);
>         if (ret) {
> -               pr_err("%s: failed to register clock notifier for cpu_clk\n",
> -                               __func__);
> +               dev_err(dev,
> +                       "failed to register clock notifier for cpu clock\n");
>                 return ret;
>         }
>
> diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
> index f2780508edec..0a764187f8f3 100644
> --- a/drivers/clk/meson/meson8b.h
> +++ b/drivers/clk/meson/meson8b.h
> @@ -72,8 +72,13 @@
>  #define CLKID_MPLL0_DIV                96
>  #define CLKID_MPLL1_DIV                97
>  #define CLKID_MPLL2_DIV                98
> +#define CLKID_CPU_IN_SEL       99
> +#define CLKID_CPU_DIV2         100
> +#define CLKID_CPU_DIV3         101
> +#define CLKID_CPU_DIV          102
> +#define CLKID_CPU_OUT_SEL      103
>
> -#define CLK_NR_CLKS            99
> +#define CLK_NR_CLKS            104
>
>  /*
>   * include the CLKID and RESETID that have
> --
> 2.14.3
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic


[0] https://github.com/endlessm/linux-meson/blob/03393bb8e8478626e03ee93b0a2a225d6de242b5/arch/arm/mach-meson8b/clock.c#L1349
[1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
