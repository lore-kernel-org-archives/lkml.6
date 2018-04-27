Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757856AbeD0MEZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:04:25 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35414 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757530AbeD0MEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:04:23 -0400
X-Google-Smtp-Source: AB8JxZrVsOfJAebneBgYTQtLpoBgQmaO7kgtI7xfKNU19qVg9m5kqmSexJgM6u+Un6MdOBxbPtZ5yapxOZ0Zs6kFYJg=
MIME-Version: 1.0
In-Reply-To: <20180427001745.4116-1-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 27 Apr 2018 14:04:19 +0200
Message-ID: <CAMpxmJUCOHqds-zVz736fma7EDZ_o6PpbHMwtFF8wRXJMHCqzA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v9_00=2F27=5D_ARM=3A_davinci=3A_convert_to_common?=
        =?UTF-8?Q?_clock_framework=E2=80=8B?=
To: Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Adam Ford <aford173@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-27 2:17 GMT+02:00 David Lechner <david@lechnology.com>:
> This series converts mach-davinci to use the common clock framework.
>
> The series works like this, the first 3 patches fix some issues with the clock
> drivers that have already been accepted into the mainline kernel.
>
> Then, starting with "ARM: davinci: pass clock as parameter to
> davinci_timer_init()", we get the mach code ready for the switch by adding the
> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
> around the legacy clocks so that we can switch easily between the old and the
> new.
>
> "ARM: davinci: switch to common clock framework" actually flips the switch
> to start using the new clock drivers. Then the next 8 patches remove all
> of the old clock code.
>
> The final four patches add device tree clock support to the one SoC that
> supports it.
>
> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
> board file).
>
>
> Changes:
>
> v9 changes (also see individual patches for details):
> - Rebased on linux-davnci/master (f5e3203bb775)
> - Dropped drivers/clk patches that landed in v4.17
> - New drivers/clk patches for early boot special case
> - New patch for ti,davinci-timer device tree bindings
> - Updated mach/davinci patches to register clocks in early boot when needed
>
> v8 changes (also see individual patches for details):
> - Rebased on linux-davinci/master
> - Dropped use of __init and __initconst attributes in clk drivers
> - Add clkdev lookups for PLL SYSCLKs
> - Fix genpd clock reference counting issue
> - Fix PSC clock driver loading order issue
> - Fix typo in device tree and add more power-domains properties
>
> v7 changes (also see individual patches for details):
> - Rebased on linux-davinci/master (v4.16-rc)
> - Convert clock drivers to platform devices
> - New patch "ARM: davinci: pass clock as parameter to davinci_timer_init()"
> - Fix issues with lcdk and aemif clock lookups and power domains
> - Fixed other minor issues brought up in v6 review
>
> v6 changes (also see individual patches for details):
> - All of the device tree bindings are changed
> - All of the clock drivers are changed significantly
> - Fixed issues brought up during review of v5
> - "ARM: davinci: move davinci_clk_init() to init_time" is removed from this
>   series and submitted separately
>
> v5 changes:
> - Basically, this is an entirely new series
> - Patches are broken up into bite-sized pieces
> - Converted PSC clock driver to use regmap
> - Restored "force" flag for certain DA850 clocks
> - Added device tree bindings
> - Moved more of the clock init to drivers/clk
> - Fixed frequency scaling (maybe*)
>
> * I have frequency scaling using cpufreq-dt, so I know the clocks are doing
>   what they need to do to make this work, but I haven't figured out how to
>   test davinci-cpufreq driver yet. (Patches to make cpufreq-dt work will be
>   sent separately after this series has landed.)
>
>
> Dependencies:
>
> Only one dependency didn't land in v4.17. It is just a runtime dependency for
> the LCDK board to make the display work.
>
> - "drm/tilcdc: Fix setting clock divider for omap-l138"[1]
>
> [1]: https://patchwork.freedesktop.org/patch/210696/
>
> You can find a working branch with everything included (plus a few extras, like
> cpufreq-dt) in the "common-clk-v8" branch of https://github.com/dlech/ev3dev-kernel.git.
>
>
> Testing/debugging for the uninitiated:
>
> I only have one device to test with, which is based on da850, so I will
> have to rely on others to do some testing here. Since we are dealing with
> clocks, if something isn't working, you most likely won't see output on
> the serial port. To figure out what is going on, you need to enable...
>
>         CONFIG_DEBUG_LL=y
>         CONFIG_EARLY_PRINTK=y
>
> and add "earlyprintk clk_ignore_unused" to the kernel command line options.
> You may need to select a different UART for this depending on your board. I
> think UART1 is the default in the kernel configuration.
>
> On da850 devices comment out the lines:
>
>         else
>                 clk_set_parent(clk, parent->clk);
>
> in da850.c or, if using device tree, comment out the lines:
>
>         assigned-clocks = <&async3_clk>;
>         assigned-clock-parents = <&pll1_sysclk 2>;
>
> in da850.dtsi when doing earlyprintk, otherwise the UART1 and UART2 clock
> source will change during boot and cause garbled output after a point.
>
>

Hi David, Sekhar,

Patches 3-5 from the reset series[1] should go in before this series
or we'll be getting WARN's from the common clock framework core about
unprepared clocks on boards using the remoteproc driver.

Thanks,
Bartosz

[1] https://lkml.org/lkml/2018/4/17/1000
