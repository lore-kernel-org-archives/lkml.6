Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeBSUWl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:22:41 -0500
Received: from vern.gendns.com ([206.190.152.46]:58384 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753605AbeBSUWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:37 -0500
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
Subject: =?UTF-8?q?=5BPATCH=20v7=2000/42=5D=20ARM=3A=20davinci=3A=20convert=20to=20common=20clock=20framework=E2=80=8B?=
Date: Mon, 19 Feb 2018 14:21:21 -0600
Message-Id: <1519071723-31790-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
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

The series works like this, the first 19 patches create new clock drivers
using the common clock framework. There are basically 3 groups of clocks -
PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
unique init data, which is the reason for so many patches.

Then, starting with "ARM: davinci: pass clock as parameter to
davinci_timer_init()", we get the mach code ready for the switch by adding the
code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
around the legacy clocks so that we can switch easily between the old and the
new.

"ARM: davinci: switch to common clock framework" actually flips the switch
to start using the new clock drivers. Then the next 8 patches remove all
of the old clock code.

The final three patches add device tree clock support to the one SoC that
supports it.

---

The change to make all of the clocks platform devices in v7 was a pretty
major change, so unfortunately I had to drop quite a few Reviewed-bys and
this series will need more close review and testing again.

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

Most of the dependencies have landed in mainline already in v4.16-rc1 or
are in linux-davinci/master.

There are no build dependencies any more, but you will need to pickup a
couple of patches to get CPU frequency scaling working because of a divider
clock bug.

- https://patchwork.kernel.org/patch/10218941/
- https://patchwork.kernel.org/patch/10218927/

You can find a working branch with everything included in the "common-clk-v7"
branch of https://github.com/dlech/ev3dev-kernel.git.


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

	else
		clk_set_parent(clk, parent->clk);

in da850.c or, if using device tree, comment out the lines:

	assigned-clocks = <&async3_clk>;
	assigned-clock-parents = <&pll1_sysclk 2>;

in da850.dtsi when doing earlyprintk, otherwise the UART1 and UART2 clock
source will change during boot and cause garbled output after a point. 

David Lechner (42):
  dt-bindings: clock: Add new bindings for TI Davinci PLL clocks
  clk: davinci: New driver for davinci PLL clocks
  clk: davinci: Add platform information for TI DA830 PLL
  clk: davinci: Add platform information for TI DA850 PLL
  clk: davinci: Add platform information for TI DM355 PLL
  clk: davinci: Add platform information for TI DM365 PLL
  clk: davinci: Add platform information for TI DM644x PLL
  clk: davinci: Add platform information for TI DM646x PLL
  dt-bindings: clock: New bindings for TI Davinci PSC
  clk: davinci: New driver for davinci PSC clocks
  clk: davinci: Add platform information for TI DA830 PSC
  clk: davinci: Add platform information for TI DA850 PSC
  clk: davinci: Add platform information for TI DM355 PSC
  clk: davinci: Add platform information for TI DM365 PSC
  clk: davinci: Add platform information for TI DM644x PSC
  clk: davinci: Add platform information for TI DM646x PSC
  dt-bindings: clock: Add bindings for DA8XX CFGCHIP clocks
  clk: davinci: New driver for TI DA8XX CFGCHIP clocks
  clk: davinci: cfgchip: Add TI DA8XX USB PHY clocks
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
  ARM: davinci: add device tree support to timer
  ARM: davinci: da8xx-dt: switch to device tree clocks
  ARM: dts: da850: Add clocks

 .../bindings/clock/ti/davinci/da8xx-cfgchip.txt    |  93 +++
 .../devicetree/bindings/clock/ti/davinci/pll.txt   |  96 +++
 .../devicetree/bindings/clock/ti/davinci/psc.txt   |  71 ++
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |   5 +-
 arch/arm/boot/dts/da850-enbw-cmc.dts               |   4 +
 arch/arm/boot/dts/da850-evm.dts                    |   4 +
 arch/arm/boot/dts/da850-lcdk.dts                   |   9 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |   4 +
 arch/arm/boot/dts/da850.dtsi                       | 159 ++++
 arch/arm/configs/davinci_all_defconfig             |   1 -
 arch/arm/mach-davinci/Kconfig                      |  13 +-
 arch/arm/mach-davinci/Makefile                     |   4 +-
 arch/arm/mach-davinci/board-da830-evm.c            |  12 +-
 arch/arm/mach-davinci/board-da850-evm.c            |   2 +
 arch/arm/mach-davinci/board-dm355-evm.c            |   2 +
 arch/arm/mach-davinci/board-dm355-leopard.c        |   2 +
 arch/arm/mach-davinci/board-dm365-evm.c            |   2 +
 arch/arm/mach-davinci/board-dm644x-evm.c           |   2 +
 arch/arm/mach-davinci/board-dm646x-evm.c           |   2 +
 arch/arm/mach-davinci/board-mityomapl138.c         |   2 +
 arch/arm/mach-davinci/board-neuros-osd2.c          |   2 +
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  11 +-
 arch/arm/mach-davinci/board-sffsdr.c               |   2 +
 arch/arm/mach-davinci/clock.c                      | 745 -----------------
 arch/arm/mach-davinci/clock.h                      |  76 --
 arch/arm/mach-davinci/common.c                     |   3 -
 arch/arm/mach-davinci/da830.c                      | 469 ++---------
 arch/arm/mach-davinci/da850.c                      | 766 +++---------------
 arch/arm/mach-davinci/da8xx-dt.c                   |  60 --
 arch/arm/mach-davinci/davinci.h                    |   8 +
 arch/arm/mach-davinci/devices-da8xx.c              |  43 +-
 arch/arm/mach-davinci/devices.c                    |   1 -
 arch/arm/mach-davinci/dm355.c                      | 425 ++--------
 arch/arm/mach-davinci/dm365.c                      | 517 ++----------
 arch/arm/mach-davinci/dm644x.c                     | 363 ++-------
 arch/arm/mach-davinci/dm646x.c                     | 391 ++-------
 arch/arm/mach-davinci/include/mach/clock.h         |   3 -
 arch/arm/mach-davinci/include/mach/common.h        |  11 +-
 arch/arm/mach-davinci/include/mach/da8xx.h         |   6 +-
 arch/arm/mach-davinci/pm_domain.c                  |   5 +
 arch/arm/mach-davinci/psc.c                        | 137 ----
 arch/arm/mach-davinci/psc.h                        |  12 -
 arch/arm/mach-davinci/time.c                       |  46 +-
 arch/arm/mach-davinci/usb-da8xx.c                  | 250 +-----
 drivers/clk/Makefile                               |   1 +
 drivers/clk/davinci/Makefile                       |  21 +
 drivers/clk/davinci/da8xx-cfgchip.c                | 786 ++++++++++++++++++
 drivers/clk/davinci/pll-da830.c                    |  58 ++
 drivers/clk/davinci/pll-da850.c                    | 178 +++++
 drivers/clk/davinci/pll-dm355.c                    |  75 ++
 drivers/clk/davinci/pll-dm365.c                    | 119 +++
 drivers/clk/davinci/pll-dm644x.c                   |  76 ++
 drivers/clk/davinci/pll-dm646x.c                   |  78 ++
 drivers/clk/davinci/pll.c                          | 877 +++++++++++++++++++++
 drivers/clk/davinci/pll.h                          | 141 ++++
 drivers/clk/davinci/psc-da830.c                    |  89 +++
 drivers/clk/davinci/psc-da850.c                    | 109 +++
 drivers/clk/davinci/psc-dm355.c                    |  72 ++
 drivers/clk/davinci/psc-dm365.c                    |  77 ++
 drivers/clk/davinci/psc-dm644x.c                   |  67 ++
 drivers/clk/davinci/psc-dm646x.c                   |  62 ++
 drivers/clk/davinci/psc.c                          | 505 ++++++++++++
 drivers/clk/davinci/psc.h                          | 101 +++
 include/linux/platform_data/clk-da8xx-cfgchip.h    |  21 +
 65 files changed, 4515 insertions(+), 3846 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
 delete mode 100644 arch/arm/mach-davinci/clock.c
 delete mode 100644 arch/arm/mach-davinci/psc.c
 create mode 100644 drivers/clk/davinci/Makefile
 create mode 100644 drivers/clk/davinci/da8xx-cfgchip.c
 create mode 100644 drivers/clk/davinci/pll-da830.c
 create mode 100644 drivers/clk/davinci/pll-da850.c
 create mode 100644 drivers/clk/davinci/pll-dm355.c
 create mode 100644 drivers/clk/davinci/pll-dm365.c
 create mode 100644 drivers/clk/davinci/pll-dm644x.c
 create mode 100644 drivers/clk/davinci/pll-dm646x.c
 create mode 100644 drivers/clk/davinci/pll.c
 create mode 100644 drivers/clk/davinci/pll.h
 create mode 100644 drivers/clk/davinci/psc-da830.c
 create mode 100644 drivers/clk/davinci/psc-da850.c
 create mode 100644 drivers/clk/davinci/psc-dm355.c
 create mode 100644 drivers/clk/davinci/psc-dm365.c
 create mode 100644 drivers/clk/davinci/psc-dm644x.c
 create mode 100644 drivers/clk/davinci/psc-dm646x.c
 create mode 100644 drivers/clk/davinci/psc.c
 create mode 100644 drivers/clk/davinci/psc.h
 create mode 100644 include/linux/platform_data/clk-da8xx-cfgchip.h

-- 
2.7.4
