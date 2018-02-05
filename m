Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeBEJuJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:50:09 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36632 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbeBEJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:50:00 -0500
X-Google-Smtp-Source: AH8x227w1MMsQyE3EShqO8IFgs3LanSRPFAx/KpmW4AEdyKQX8wPkiJMzMEGXWGXb49o7mftEViIbg==
Message-ID: <1517824196.3153.41.camel@baylibre.com>
Subject: Re: [PATCH 17/19] clk: meson: rework meson8b cpu clock
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Date: Mon, 05 Feb 2018 10:49:56 +0100
In-Reply-To: <CAFBinCCpfpJQVkKvuBgS5T_AB+LNC3xXMCAUVYy38h=0Ge39Sg@mail.gmail.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
         <20180131180945.18025-18-jbrunet@baylibre.com>
         <CAFBinCCpfpJQVkKvuBgS5T_AB+LNC3xXMCAUVYy38h=0Ge39Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-03 at 19:46 +0100, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Wed, Jan 31, 2018 at 7:09 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Instead of migrating meson cpu_clk to clk_regmap, like the other meson
> > clock drivers, we take advantage of the massive rework to get rid of it
> > completely, and solve (the first part) of the related FIXME notice.
> > 
> > As pointed out in the code comments, the cpu_clk should be modeled with
> > dividers and muxes it is made of, instead of one big composite clock.
> > 
> > The other issue pointed out in the FIXME note, around cpu notifier,
> > remains unsolved, until CCR comes up.
> > 
> > AFAIK, the cpu_clk was not working correctly to enable dvfs on meson8b.
> > This change being just a re-implementation, hopefully cleaner, of the
> > cpu_clk, the problem remains unsolved as well.
> 
> I can confirm that I have seen system lock-ups when using the cpu_clk
> implementation
> your patch doesn't fully solve this (I still get some lock-ups), but I
> still think it's a step forward!
> 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> I have some minor comments below, with these addressed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks for reviewing this Martin.
I happy that changing the implementation of the cpu clock improve the situation.
However, thinking about it, I'm not really confortable upstreaming something
that we know is not stable yet, especially when it comes to the cpu clock.

To start, and until when get a stable solution, I would prefer to put the whole
thing in read-only mode, and removing the notifier. The RW WIP is available here
on the ML, so nothing is lost.

As a second step to progress on getting this clock stable, we could try to keep
in the PLL Read-Only, but have the dividers in RW w/o a notifier : The goal
would be to determine if we need to park the clock on xtal while changing the
dividers. If we do, the notifier should probably be on SCALE_OUT_SEL instead of
SYS_PLL.

This should already allow to adjust the clock quite lot, maybe it would be an
interesting first step for a working dvfs on meson8.

Once we get this stable, we'll be able to throw the sys_pll in the mix.

Would you agree with this approach Martin ?

> 

[...]

> > +struct clk_regmap meson8b_cpu_div = {
> > +       .data = &(struct clk_regmap_div_data){
> > +               .offset =  HHI_SYS_CPU_CLK_CNTL1,
> > +               .shift = 20,
> > +               .width = 9,
> > +               .table = cpu_div_table,
> > +               .flags = CLK_DIVIDER_ALLOW_ZERO,
> 
> looking at the Amlogic GPL kernel sources: [0]
> they allow programming this divider with 0, however it seems that it's
> not allowed to select this in the mux below
> during my tests this seems to have worked fine because the first
> parent of the mux below is cpu_in - which has the same rate as this
> divider with register value 0. in this scenario the common clock
> framework chooses the parent it finds first (cpu_in in this case -
> which is fine)

(It was a while ago but I think) I put this flag to avoid warning on boot
because the register value could be 0 by default, when the clock is not used.

When the clock is set by the CCF, it won't ever put 0 because zero is not part
of the divider table provided with this clock. So, as soon as a set_rate() call
reaches this clock, the zero value will go away and won't ever come back.

> 
> > +       },
> > +       .hw.init = &(struct clk_init_data){
> > +               .name = "cpu_div",
> 
> I suggest to call this "cpu_scale_div", so it matches the value we
> find in the public S805 datasheet on page 31: [1] (the same goes for
> the variable name above and the CLKID #define)

No problem, will do.

> 
> > +               .ops = &clk_regmap_divider_ops,
> > +               .parent_names = (const char *[]){ "cpu_in_sel" },
> > +               .num_parents = 1,
> > +               .flags = CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +struct clk_regmap meson8b_cpu_out_sel = {
> > +       .data = &(struct clk_regmap_mux_data){
> > +               .offset = HHI_SYS_CPU_CLK_CNTL0,
> > +               .mask = 0x3,
> > +               .shift = 2,
> > +       },
> > +       .hw.init = &(struct clk_init_data){
> > +               .name = "cpu_out_sel",
> 
> I suggest to call this "cpu_scale_out_sel", so it matches the value we
> find in the public S805 datasheet on page 34: [1] (the same goes for
> the variable name above and the CLKID #define)

Sure.
