Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965261AbeEIRbi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:31:38 -0400
Received: from vern.gendns.com ([206.190.152.46]:51992 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965806AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: =?UTF-8?q?=5BPATCH=20v10=2000/27=5D=20ARM=3A=20davinci=3A=20convert=20to=20common=20clock=20framework=E2=80=8B?=
Date: Wed,  9 May 2018 12:25:39 -0500
Message-Id: <20180509172606.29387-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts mach-davinci to use the common clock framework.

The series works like this, the first 3 patches fix some issues with the clock
drivers that have already been accepted into the mainline kernel.

Then, starting with "ARM: davinci: pass clock as parameter to
davinci_timer_init()", we get the mach code ready for the switch by adding the
code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
around the legacy clocks so that we can switch easily between the old and the
new.

"ARM: davinci: switch to common clock framework" actually flips the switch
to start using the new clock drivers. Then the next 8 patches remove all
of the old clock code.

The final four patches add device tree clock support to the one SoC that
supports it.

This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
board file).


Changes:

v10 changes (also see individual patches for details):
- Reworked device tree bindings for DaVinci timer.
- Dropped helper functions to conditionally call devm_* versions of functions
- Fix some typos
- Fix some rebasing issues introduced in v9

v9 changes (also see individual patches for details):
- Rebased on linux-davnci/master (f5e3203bb775)
- Dropped drivers/clk patches that landed in v4.17
- New drivers/clk patches for early boot special case
- New patch for ti,davinci-timer device tree bindings
- Updated mach/davinci patches to register clocks in early boot when needed

v8 changes (also see individual patches for details):
- Rebased on linux-davinci/master
- Dropped use of __init and __initconst attributes in clk drivers
- Add clkdev lookups for PLL SYSCLKs
- Fix genpd clock reference counting issue
- Fix PSC clock driver loading order issue
- Fix typo in device tree and add more power-domains properties

v7 changes (also see individual patches for details):
- Rebased on linux-davinci/master (v4.16-rc)
- Convert clock drivers to platform devices
- New patch "ARM: davinci: pass clock as parameter to davinci_timer_init()"
- Fix issues with lcdk and aemif clock lookups and power domains
- Fixed other minor issues brought up in v6 review

v6 changes (also see individual patches for details):
- All of the device tree bindings are changed
- All of the clock drivers are changed significantly
- Fixed issues brought up during review of v5
- "ARM: davinci: move davinci_clk_init() to init_time" is removed from this
  series and submitted separately

v5 changes:
- Basically, this is an entirely new series
- Patches are broken up into bite-sized pieces
- Converted PSC clock driver to use regmap
- Restored "force" flag for certain DA850 clocks
- Added device tree bindings
- Moved more of the clock init to drivers/clk
- Fixed frequency scaling (maybe*)

* I have frequency scaling using cpufreq-dt, so I know the clocks are doing
  what they need to do to make this work, but I haven't figured out how to
  test davinci-cpufreq driver yet. (Patches to make cpufreq-dt work will be
  sent separately after this series has landed.)


Dependencies:

There are still some outstanding fixes to get everything working correctly.
These are all just runtime dependencies and only needed for certain platforms.

- "drm/tilcdc: Fix setting clock divider for omap-l138"[1]
- "clk: davinci: pll-dm355: fix SYSCLKn parent names"[2]
- "remoteproc/davinci: common clock framework related fixes"[3]

[1]: https://patchwork.freedesktop.org/patch/210696/
[2]: https://lkml.org/lkml/2018/5/9/626
[3]: https://lkml.org/lkml/2018/5/2/201

You can find a working branch with everything included (plus a few extras, like
cpufreq-dt) in the "common-clk-v10" branch of https://github.com/dlech/ev3dev-kernel.git.


Testing/debugging for the uninitiated:

I only have one device to test with, which is based on da850, so I will
have to rely on others to do some testing here. Since we are dealing with
clocks, if something isn't working, you most likely won't see output on
the serial port. To figure out what is going on, you need to enable...

	CONFIG_DEBUG_LL=y
	CONFIG_EARLY_PRINTK=y

and add "earlyprintk clk_ignore_unused" to the kernel command line options.
You may need to select a different UART for this depending on your board. I
think UART1 is the default in the kernel configuration.

On da850 devices comment out the lines:

	/* pll1_sysclk2 is not affected by CPU scaling, so use it for async3 */
	parent = clk_hw_get_parent_by_index(&mux->hw, 1);
	if (parent)
		clk_set_parent(mux->hw.clk, parent->clk);
	else
		dev_warn(dev, "Failed to find async3 parent clock\n");

in da8xx-cfgchip.c or, if using device tree, comment out the lines:

	assigned-clocks = <&async3_clk>;
	assigned-clock-parents = <&pll1_sysclk 2>;

in da850.dtsi when doing earlyprintk, otherwise the UART1 and UART2 clock
source will change during boot and cause garbled output after a point. 


David Lechner (27):
  clk: davinci: pll: allow dev == NULL
  clk: davinci: da850-pll: change PLL0 to CLK_OF_DECLARE
  clk: davinci: psc: allow for dev == NULL
  ARM: davinci: pass clock as parameter to davinci_timer_init()
  ARM: davinci: da830: add new clock init using common clock framework
  ARM: davinci: da850: add new clock init using common clock framework
  ARM: davinci: dm355: add new clock init using common clock framework
  ARM: davinci: dm365: add new clock init using common clock framework
  ARM: davinci: dm644x: add new clock init using common clock framework
  ARM: davinci: dm646x: add new clock init using common clock framework
  ARM: davinci: da8xx: add new USB PHY clock init using common clock
    framework
  ARM: davinci: da8xx: add new sata_refclk init using common clock
    framework
  ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
  ARM: davinci_all_defconfig: remove CONFIG_DAVINCI_RESET_CLOCKS
  ARM: davinci: switch to common clock framework
  ARM: davinci: da830: Remove legacy clock init
  ARM: davinci: da850: Remove legacy clock init
  ARM: davinci: dm355: Remove legacy clock init
  ARM: davinci: dm365: Remove legacy clock init
  ARM: davinci: dm644x: Remove legacy clock init
  ARM: davinci: dm646x: Remove legacy clock init
  ARM: davinci: da8xx: Remove legacy USB and SATA clock init
  ARM: davinci: remove legacy clocks
  dt-bindings: timer: new bindings for TI DaVinci timer
  ARM: davinci: add device tree support to timer
  ARM: davinci: da8xx-dt: switch to device tree clocks
  ARM: dts: da850: Add clocks

 .../bindings/timer/ti,davinci-timer.txt       |  37 +
 arch/arm/Kconfig                              |   5 +-
 arch/arm/boot/dts/da850-enbw-cmc.dts          |   4 +
 arch/arm/boot/dts/da850-evm.dts               |   4 +
 arch/arm/boot/dts/da850-lcdk.dts              |   9 +
 arch/arm/boot/dts/da850-lego-ev3.dts          |   4 +
 arch/arm/boot/dts/da850.dtsi                  | 168 ++++
 arch/arm/configs/davinci_all_defconfig        |   1 -
 arch/arm/mach-davinci/Kconfig                 |  13 +-
 arch/arm/mach-davinci/Makefile                |   4 +-
 arch/arm/mach-davinci/board-da830-evm.c       |  12 +-
 arch/arm/mach-davinci/board-da850-evm.c       |   2 +
 arch/arm/mach-davinci/board-dm355-evm.c       |   2 +
 arch/arm/mach-davinci/board-dm355-leopard.c   |   2 +
 arch/arm/mach-davinci/board-dm365-evm.c       |   2 +
 arch/arm/mach-davinci/board-dm644x-evm.c      |   2 +
 arch/arm/mach-davinci/board-dm646x-evm.c      |   2 +
 arch/arm/mach-davinci/board-mityomapl138.c    |   2 +
 arch/arm/mach-davinci/board-neuros-osd2.c     |   2 +
 arch/arm/mach-davinci/board-omapl138-hawk.c   |  11 +-
 arch/arm/mach-davinci/board-sffsdr.c          |   2 +
 arch/arm/mach-davinci/clock.c                 | 745 -----------------
 arch/arm/mach-davinci/clock.h                 |  76 --
 arch/arm/mach-davinci/common.c                |   3 -
 arch/arm/mach-davinci/da830.c                 | 462 ++---------
 arch/arm/mach-davinci/da850.c                 | 778 +++---------------
 arch/arm/mach-davinci/da8xx-dt.c              |  66 --
 arch/arm/mach-davinci/davinci.h               |   8 +
 arch/arm/mach-davinci/devices-da8xx.c         |  43 +-
 arch/arm/mach-davinci/devices.c               |   1 -
 arch/arm/mach-davinci/dm355.c                 | 406 ++-------
 arch/arm/mach-davinci/dm365.c                 | 485 +----------
 arch/arm/mach-davinci/dm644x.c                | 344 +-------
 arch/arm/mach-davinci/dm646x.c                | 372 +--------
 arch/arm/mach-davinci/include/mach/clock.h    |   3 -
 arch/arm/mach-davinci/include/mach/common.h   |  11 +-
 arch/arm/mach-davinci/include/mach/da8xx.h    |   6 +-
 arch/arm/mach-davinci/pm_domain.c             |   5 +
 arch/arm/mach-davinci/psc.c                   | 137 ---
 arch/arm/mach-davinci/psc.h                   |  12 -
 arch/arm/mach-davinci/time.c                  |  39 +-
 arch/arm/mach-davinci/usb-da8xx.c             | 242 +-----
 drivers/clk/davinci/pll-da830.c               |   4 +-
 drivers/clk/davinci/pll-da850.c               |  36 +-
 drivers/clk/davinci/pll-dm355.c               |   8 +-
 drivers/clk/davinci/pll-dm365.c               |   8 +-
 drivers/clk/davinci/pll-dm644x.c              |   8 +-
 drivers/clk/davinci/pll-dm646x.c              |   8 +-
 drivers/clk/davinci/pll.c                     | 110 +--
 drivers/clk/davinci/pll.h                     |  30 +-
 drivers/clk/davinci/psc-dm355.c               |   2 +-
 drivers/clk/davinci/psc-dm365.c               |   2 +-
 drivers/clk/davinci/psc-dm644x.c              |   2 +-
 drivers/clk/davinci/psc-dm646x.c              |   2 +-
 drivers/clk/davinci/psc.c                     |  27 +-
 include/linux/clk/davinci.h                   |  29 +
 56 files changed, 860 insertions(+), 3950 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
 delete mode 100644 arch/arm/mach-davinci/clock.c
 delete mode 100644 arch/arm/mach-davinci/psc.c
 create mode 100644 include/linux/clk/davinci.h

-- 
2.17.0
