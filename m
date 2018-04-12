Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeDLURH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752304AbeDLURE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:17:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711F621777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
From: sboyd@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for v4.17
Date: Thu, 12 Apr 2018 13:17:01 -0700
Message-Id: <20180412201701.79834-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit e2749bb998701e21cdb8b34486b82fc1c051ab41:

  reset: modify the way reset lookup works for board files (2018-03-27 10:39:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to b44c4ddf4a15c42a91a88aaa32b7d53cf43391cb:

  Merge branch 'clk-davinci' into clk-next (2018-04-06 13:38:08 -0700)

----------------------------------------------------------------
The large diff this time around is from the addition of a new clk driver
for the TI Davinci family of SoCs. So far those clks have been supported
with a custom implementation of the clk API in the arch port instead of in
the CCF. With this driver merged we're one step closer to having a single
clk API implementation.

The other large diff is from the Amlogic clk driver that underwent some
major surgery to use regmap. Beyond that, the biggest hitter is Samsung
which needed some reworks to properly handle clk provider power domains
and a bunch of PLL rate updates.

The core framework was fairly quiet this round, just getting some cleanups
and small fixes for some of the more esoteric features. And the usual
set of driver non-critical fixes, cleanups, and minor additions are here as
well.

Core:
 - Rejig clk_ops::init() to be a little earlier for phase/accuracy ops
 - debugfs ops macroized to shave some lines of boilerplate code
 - Always calculate the phase instead of caching it in clk_get_phase()
 - More __must_check on bulk clk APIs

New Drivers:
 - TI's Davinci family of SoCs
 - Intel's Stratix10 SoC
 - stm32mp157 SoC
 - Allwinner H6 CCU
 - Silicon Labs SI544 clock generator chip
 - Renesas R-Car M3-N and V3H SoCs
 - i.MX6SLL SoCs

Removed Drivers:
 - ST-Ericsson AB8540/9540

Updates:
 - Mediatek MT2701 and MT7622 audsys support and MT2712 updates
 - STM32F469 DSI and STM32F769 sdmmc2 support
 - GPIO clks can sleep now
 - Spreadtrum SC9860 RTC clks
 - Nvidia Tegra MBIST workarounds and various minor fixes
 - Rockchip phase handling fixes and a memory leak plugged
 - Renesas drivers switch to readl/writel from clk_readl/clk_writel
 - Renesas gained CPU (Z/Z2) and watchdog support
 - Rockchip rk3328 display clks and rk3399 1.6GHz PLL support
 - Qualcomm PM8921 PMIC XO buffers
 - Amlogic migrates to regmap APIs
 - TI Keystone clk latching support
 - Allwinner H3 and H5 video clk fixes
 - Broadcom BCM2835 PLLs needed another bit to enable
 - i.MX6SX CKO mux fix and i.MX7D Video PLL divider fix
 - i.MX6UL/ULL epdc_podf support
 - Hi3798CV200 COMBPHY0 and USB2_OTG_UTMI and phase support for eMMC

----------------------------------------------------------------
Andrzej Hajda (7):
      clk: samsung: exynos3250: Fix PLL rates
      clk: samsung: exynos5250: Fix PLL rates
      clk: samsung: exynos5260: Fix PLL rates
      clk: samsung: exynos5433: Fix PLL rates
      clk: samsung: exynos7: Fix PLL rates
      clk: samsung: s3c2410: Fix PLL rates
      clk: samsung: Add compile time PLL rate validators

Andy Shevchenko (1):
      clk: Re-use DEFINE_SHOW_ATTRIBUTE() macro

Anson Huang (4):
      clk: imx: imx6sx: update cko mux options
      clk: imx: imx7d: correct video pll clock tree
      clk: imx7d: Correct dram pll type
      clk: imx7d: Correct ahb clk parent select

Arnd Bergmann (2):
      clk: fix false-positive Wmaybe-uninitialized warning
      clk: hisilicon: mark wdt_mux_p[] as const

Bai Ping (4):
      clk: imx: Add CLK_IS_CRITICAL flag for busy divider and busy mux
      clk: imx: add new gate/gate2 wrapper funtion
      dt-bindings: imx: update clock doc for imx6sll
      clk: imx: add clock driver for imx6sll

Bartosz Golaszewski (1):
      clk: davinci: add a reset lookup table for psc0

Benjamin Gaignard (1):
      clk: stm32: add configuration flags for each of the stm32 drivers

Boris Brezillon (1):
      clk: bcm2835: De-assert/assert PLL reset signal when appropriate

Brian Starkey (1):
      clk: versatile: Remove WARNs in ->round_rate()

Chanwoo Choi (1):
      clk: samsung: s3c: Remove unneeded enumeration

Chunyan Zhang (2):
      dt-bindings: clocks: add APB RTC gate for SC9860
      clk: sprd: add RTC gate for SC9860

Corentin Labbe (1):
      clk: sunxi-ng: remove select on obsolete SUNXI_CCU_X kconfig name

David Lechner (19):
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

Derek Basehore (1):
      clk: rockchip: Add 1.6GHz PLL rate for rk3399

Dinh Nguyen (2):
      dt-bindings: documentation: add clock bindings information for Stratix10
      clk: socfpga: stratix10: add clock driver for Stratix10 platform

Dmitry Osipenko (3):
      clk: tegra: Mark HCLK, SCLK and EMC as critical
      clk: tegra20: Correct PLL_C_OUT1 setup
      clk: tegra: Specify VDE clock rate

Dong Aisheng (3):
      Documentation: clk: enable lock is not held for clk_is_enabled API
      clk: add more __must_check for bulk APIs
      clk: imx7d: Move clks_init_on before any clock operations

Fabrizio Castro (5):
      clk: renesas: r8a7743: Add rwdt clock
      clk: renesas: r8a7745: Add rwdt clock
      clk: renesas: r8a7790: Add rwdt clock
      clk: renesas: r8a7791/r8a7793: Add rwdt clock
      clk: renesas: r8a7794: Add rwdt clock

Gabriel Fernandez (14):
      dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
      clk: stm32mp1: Introduce STM32MP1 clock driver
      clk: stm32mp1: add MP1 gate for hse/hsi/csi oscillators
      clk: stm32mp1: add Source Clocks for PLLs
      clk: stm32mp1: add PLL clocks
      clk: stm32mp1: add Post-dividers for PLL
      clk: stm32mp1: add Sub System clocks
      clk: stm32mp1: add Kernel timers
      clk: stm32mp1: add Peripheral & Kernel Clocks
      clk: stm32mp1: add RTC clock
      clk: stm32mp1: add MCO clocks
      clk: stm32mp1: add Debug clocks
      clk: stm32: END_PRIMARY_CLK should be declare after CLK_SYSCLK
      clk: stm32: Add DSI clock for STM32F469 Board

Geert Uytterhoeven (10):
      clk: renesas: Stop enabling legacy DT clock support by default
      clk: renesas: r8a7792: Add rwdt clock
      clk: renesas: div6: Always use readl()/writel()
      clk: renesas: mstp: Always use readl()/writel()
      clk: renesas: r8a73a4: Always use readl()/writel()
      clk: renesas: r8a7740: Always use readl()/writel()
      clk: renesas: rcar-gen2: Always use readl()/writel()
      clk: renesas: rza1: Always use readl()/writel()
      clk: renesas: sh73a0: Always use readl()/writel()
      clk: renesas: rcar-gen3: Always use readl()/writel()

Gregory CLEMENT (1):
      clk: mvebu: cp110: Fix clock tree representation

Heiko Stuebner (6):
      clk: rockchip: fix hclk_vio_niu on rk3328
      clk: rockchip: remove HCLK_VIO from rk3328 dt header
      clk: rockchip: export sclk_hdmi_sfc on rk3328
      clk: rockchip: protect all remaining rk3328 interconnect clocks
      clk: rockchip: remove ignore_unused flag from rk3328 vio_h2p clocks
      clk: rockchip: document hdmi_phy external input for rk3328

Icenowy Zheng (4):
      clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
      dt-bindings: add device tree binding for Allwinner H6 main CCU
      clk: sunxi-ng: add support for the Allwinner H6 CCU
      clk: sunxi-ng: add missing hdmi-slow clock for H6 CCU

Jacopo Mondi (2):
      clk: renesas: cpg-mssr: Add support for R-Car M3-N
      clk: renesas: r8a77965: Replace DU2 clock

Jeffy Chen (1):
      clk: lpc32xx: Set name of regmap_config

Jernej Skrabec (6):
      clk: sunxi-ng: Mask nkmp factors when setting register
      clk: sunxi-ng: Use u64 for calculation of nkmp rate
      clk: sunxi-ng: Add check for minimal rate to NM PLLs
      clk: sunxi-ng: h3: h5: Add minimal rate for video PLL
      clk: sunxi-ng: h3: h5: Allow some clocks to set parent rate
      clk: sunxi-ng: h3: h5: export CLK_PLL_VIDEO

Jerome Brunet (46):
      clk: meson: check pll rate param table before using it
      clk: meson: remove useless pll rate params tables
      clk: meson: remove unnecessary rounding in the pll clock
      clk: meson: use the frac parameter width instead of a constant
      clk: meson: add od3 to the pll driver
      clk: meson: add the gxl hdmi pll
      clk: meson: fix rate calculation of plls with a fractional part
      clk: meson: gxbb: add the fractional part of the fixed_pll
      clk: meson: axg: add the fractional part of the fixed_pll
      clk: meson: add axg misc bit to the mpll driver
      clk: divider: export clk_div_mask() helper
      clk: mux: add helper function for index/value translation
      clk: call the clock init() callback before any other ops callback
      clk: fix mux clock documentation
      clk: divider: read-only divider can propagate rate change
      clk: qcom: use divider_ro_round_rate helper
      clk: meson: use dev pointer where possible
      clk: meson: use devm_of_clk_add_hw_provider
      clk: meson: only one loop index is necessary in probe
      clk: meson: remove obsolete comments
      clk: meson: add regmap clocks
      clk: meson: switch gxbb ao_clk to clk_regmap
      clk: meson: remove superseded aoclk_gate_regmap
      clk: meson: add regmap to the clock controllers
      clk: meson: migrate gates to clk_regmap
      clk: meson: migrate dividers to clk_regmap
      clk: meson: migrate muxes to clk_regmap
      clk: meson: add regmap helpers for parm
      clk: meson: migrate mplls clocks to clk_regmap
      clk: meson: migrate the audio divider clock to clk_regmap
      clk: meson: migrate plls clocks to clk_regmap
      clk: meson: split divider and gate part of mpll
      clk: meson: rework meson8b cpu clock
      clk: meson: remove obsolete cpu_clk
      clk: meson: use hhi syscon if available
      clk: meson: add fractional part of meson8b fixed_pll
      clk: meson: poke pll CNTL last
      clk: meson: remove special gp0 lock loop
      clk: meson: improve pll driver results with frac
      clk: meson: add gp0 frac parameter for axg and gxl
      clk: meson: add ROUND_CLOSEST to the pll driver
      clk: meson: axg: add hifi clock bindings
      clk: meson: axg: add hifi pll clock
      clk: meson: add mpll pre-divider
      clk: meson: add fdiv clock gates
      clk: meson: clean-up clk81 clocks

Jianguo Sun (1):
      clk: hi3798cv200: add COMBPHY0 clock support

Katsuhiro Suzuki (1):
      clk: uniphier: add Pro4/Pro5/PXs2 audio system clock

Kunihiko Hayashi (4):
      clk: uniphier: add ethernet clock control support for PXs3
      clk: uniphier: add PCIe clock control support
      clk: uniphier: add SATA clock control support
      clk: uniphier: add additional ethernet clock lines for Pro4

Leonard Crestez (1):
      clk: imx6ull: Add epdc_podf instead of sim_podf

Lin Huang (1):
      clk: rockchip: assign correct id for pclk_ddr and hclk_sd in rk3399

Linus Walleij (1):
      clk: ux500: Drop AB8540/9540 support

Lucas Stach (1):
      clk: imx: pllv2: avoid using uninitialized values

Magnus Damm (1):
      clk: renesas: cpg-mssr: Adjust r8a77980 ifdef

Marcel Ziswiler (1):
      clk: tegra: Fix pll_u rate configuration

Marek Szyprowski (5):
      soc: samsung: pm_domains: Add blacklisting clock handling
      clk: samsung: Add Exynos5 sub-CMU clock driver
      clk: samsung: exynos5420: Move PD-dependent clocks to Exynos5 sub-CMU
      clk: samsung: exynos5250: Move PD-dependent clocks to Exynos5 sub-CMU
      clk: samsung: exynos5250: Add missing clocks for FIMC LITE SYSMMU devices

Mike Looijmans (2):
      clk: clk-gpio: Allow GPIO to sleep in set/get_parent
      clk: Add driver for the si544 clock generator chip

Neil Armstrong (1):
      Merge branch 'topic/pll-fixes' into next/drivers

Nikita Yushchenko (1):
      clk: cs2000: set pm_ops in hibernate-compatible way

Patrice Chotard (1):
      clk: stm32: Add clk entry for SDMMC2 on stm32F769

Peter Chen (1):
      clk: imx7d: Add USB clock information

Peter De Schrijver (3):
      clk: tegra: Add la clock for Tegra210
      clk: tegra: add fence_delay for clock registers
      clk: tegra: MBIST work around for Tegra210

Richard Genoud (1):
      clk: mvebu: armada-38x: add support for missing clocks

Riku Voipio (1):
      clk: enable hi655x common clk automatically

Ryder Lee (5):
      clk: mediatek: update missing clock data for MT7622 audsys
      dt-bindings: clock: mediatek: update audsys documentation to adapt MFD device
      dt-bindings: clock: mediatek: add audsys support for MT2701
      clk: mediatek: add devm_of_platform_populate() for MT7622 audsys
      clk: mediatek: add audsys support for MT2701

Sean Wang (2):
      dt-bindings: clock: mediatek: add binding for fixed-factor clock axisel_d4
      clk: mediatek: fix PWM clock source by adding a fixed-factor clock

Sergei Shtylyov (2):
      dt-bindings: clock: add R8A77980 CPG core clock definitions
      clk: renesas: cpg-mssr: add R8A77980 support

Shawn Guo (3):
      clk: hi3798cv200: fix unregister call sequence in error path
      clk: hi3798cv200: add support for HISTB_USB2_OTG_UTMI_CLK
      clk: hi3798cv200: fix define indentation

Shawn Lin (8):
      clk: rockchip: Free the memory on the error path
      clk: rockchip: Prevent calculating mmc phase if clock rate is zero
      clk: rockchip: Restore the clock phase after the rate was changed
      clk: Don't show the incorrect clock phase
      clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228
      clk: rockchip: Fix wrong parents for MMC phase clock for rk3328
      clk: rockchip: Correct the behaviour of restoring cached phase
      clk: rockchip: Fix error return in phase clock registration

Srinivas Kandagatla (2):
      clk: qcom: gcc-msm8996: Mark aggre0 noc clks as critical
      clk: qcom: rpmcc: Add support to XO buffered clocks

Stephen Boyd (25):
      Merge tag 'clk-hi3798cv200-4.17' of git://git.kernel.org/.../shawnguo/linux into clk-hisi
      clk: hisilicon: Mark phase_ops static
      Merge tag 'clk-renesas-for-v4.17-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'ti-clk-for-4.17' of https://github.com/t-kristo/linux-pm into clk-ti
      Merge tag 'clk-imx-4.17-newid' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'clk-imx-4.17-misc' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'clk-for-v4.17-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      clk: meson: Drop unused local variable and add static
      Merge tag 'v4.17-rockchip-clk-1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge tag 'tegra-for-4.17-clk' of git://git.kernel.org/.../tegra/linux into clk-tegra
      Merge tag 'clk-v4.17-samsung' of git://git.kernel.org/.../snawrocki/clk into clk-samsung
      clk: samsung: Mark a few things static
      clk: qcom: smd-rpm: Migrate to devm_of_clk_add_hw_provider()
      Merge tag 'sunxi-clk-for-4.17' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'clk-renesas-for-v4.17-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'v4.17-rockchip-clk-2' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge branches 'clk-ti', 'clk-amlogic', 'clk-tegra' and 'clk-samsung' into clk-next
      Merge branches 'clk-versatile', 'clk-doc', 'clk-must-check', 'clk-qcom' and 'clk-debugfs' into clk-next
      Merge branches 'clk-spreadtrum', 'clk-stm32f', 'clk-stm32mp1', 'clk-hi655x' and 'clk-gpio' into clk-next
      Merge branches 'clk-mvebu', 'clk-phase', 'clk-nxp', 'clk-mtk2712' and 'clk-qcom-rpmcc' into clk-next
      Merge branches 'clk-mediatek', 'clk-hisi', 'clk-allwinner', 'clk-ux500' and 'clk-renesas' into clk-next
      Merge branches 'clk-davinci', 'clk-si544', 'clk-rockchip', 'clk-uniphier' and 'clk-ti-flag-fix' into clk-next
      Merge branches 'clk-stratix10', 'clk-imx', 'clk-bcm', 'clk-cs2000' and 'clk-imx6sll' into clk-next
      Merge branch 'reset/lookup' of git://git.pengutronix.de/git/pza/linux into clk-davinci
      Merge branch 'clk-davinci' into clk-next

Sudeep Holla (1):
      clk: versatile: add min/max rate boundaries for vexpress osc clock

Sylwester Nawrocki (7):
      clk: samsung: Add a git tree entry to MAINTAINERS
      clk: exynos5433: Add CLK_IGNORE_UNUSED flag to sclk_ioclk_i2s1_bclk
      clk: exynos5433: Extend list of available AUD_PLL output frequencies
      Merge branch 'for-v4.17/power_domains' into for-v4.17/next
      clk: samsung: exynos5420: Add CLK_SET_RATE_PARENT flag to mout_mau_epll_clk
      clk: samsung: exynos5420: Add more entries to EPLL rate table
      clk: samsung: Add fout=196608001 Hz EPLL rate entry for exynos4412

Takeshi Kihara (6):
      clk: renesas: rcar-gen3: Add Z clock divider support
      clk: renesas: rcar-gen3: Add Z2 clock divider support
      clk: renesas: r8a7795: Add Z clock
      clk: renesas: r8a7795: Add Z2 clock
      clk: renesas: r8a7796: Add Z clock
      clk: renesas: r8a7796: Add Z2 clock

Tero Kristo (7):
      dt-bindings: clock: ti: add latching support to mux and divider clocks
      clk: ti: add support for register read-modify-write low-level operation
      clk: ti: add generic support for clock latching
      clk: ti: add support for clock latching to divider clocks
      clk: ti: add support for clock latching to mux clocks
      clk: keystone: sci-clk: add support for dynamically probing clocks
      clk: ti: fix flag space conflict with clkctrl clocks

Wei Yongjun (4):
      clk: samsung: Remove redundant dev_err call in exynos5433_cmu_probe()
      clk: samsung: Remove redundant dev_err call in exynos_audss_clk_probe()
      clk: hisilicon: fix potential NULL dereference in hisi_clk_alloc()
      clk: davinci: Remove redundant dev_err calls

Weiyi Lu (2):
      dt-bindings: clock: add clocks for MT2712
      clk: mediatek: update clock driver of MT2712

Yixun Lan (1):
      clk: meson: axg: fix the od shift of the sys_pll

Younian Wang (1):
      clk: hi3798cv200: correct IR clock parent

Zheng Yang (1):
      clk: rockchip: add flags for rk3328 dclk_lcdc

tianshuliang (2):
      clk: hisilicon: add hisi phase clock support
      clk: hi3798cv200: add emmc sample and drive clock

 Documentation/clk.txt                              |   16 +-
 .../bindings/arm/mediatek/mediatek,audsys.txt      |   20 +-
 .../devicetree/bindings/clock/imx6sll-clock.txt    |   36 +
 .../devicetree/bindings/clock/intc_stratix10.txt   |   20 +
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |    6 +-
 .../bindings/clock/rockchip,rk3328-cru.txt         |    1 +
 .../devicetree/bindings/clock/silabs,si544.txt     |   25 +
 .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  |   60 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |    4 +
 .../bindings/clock/ti/davinci/da8xx-cfgchip.txt    |   93 +
 .../devicetree/bindings/clock/ti/davinci/pll.txt   |   96 +
 .../devicetree/bindings/clock/ti/davinci/psc.txt   |   71 +
 .../devicetree/bindings/clock/ti/divider.txt       |    3 +
 Documentation/devicetree/bindings/clock/ti/mux.txt |    3 +
 MAINTAINERS                                        |    8 +
 drivers/clk/Kconfig                                |   35 +-
 drivers/clk/Makefile                               |    8 +-
 drivers/clk/bcm/clk-bcm2835.c                      |    8 +-
 drivers/clk/clk-cs2000-cp.c                        |    2 +-
 drivers/clk/clk-divider.c                          |   58 +-
 drivers/clk/clk-gpio.c                             |    4 +-
 drivers/clk/clk-mux.c                              |   75 +-
 drivers/clk/clk-si544.c                            |  411 ++++
 drivers/clk/clk-stm32f4.c                          |   14 +-
 drivers/clk/clk-stm32mp1.c                         | 2117 ++++++++++++++++++++
 drivers/clk/clk.c                                  |  131 +-
 drivers/clk/davinci/Makefile                       |   21 +
 drivers/clk/davinci/da8xx-cfgchip.c                |  790 ++++++++
 drivers/clk/davinci/pll-da830.c                    |   70 +
 drivers/clk/davinci/pll-da850.c                    |  212 ++
 drivers/clk/davinci/pll-dm355.c                    |   79 +
 drivers/clk/davinci/pll-dm365.c                    |  145 ++
 drivers/clk/davinci/pll-dm644x.c                   |   80 +
 drivers/clk/davinci/pll-dm646x.c                   |   84 +
 drivers/clk/davinci/pll.c                          |  899 +++++++++
 drivers/clk/davinci/pll.h                          |  141 ++
 drivers/clk/davinci/psc-da830.c                    |  116 ++
 drivers/clk/davinci/psc-da850.c                    |  156 ++
 drivers/clk/davinci/psc-dm355.c                    |   88 +
 drivers/clk/davinci/psc-dm365.c                    |   96 +
 drivers/clk/davinci/psc-dm644x.c                   |   83 +
 drivers/clk/davinci/psc-dm646x.c                   |   80 +
 drivers/clk/davinci/psc.c                          |  551 +++++
 drivers/clk/davinci/psc.h                          |  108 +
 drivers/clk/hisilicon/Makefile                     |    2 +-
 drivers/clk/hisilicon/clk-hisi-phase.c             |  121 ++
 drivers/clk/hisilicon/clk.c                        |   26 +
 drivers/clk/hisilicon/clk.h                        |   19 +
 drivers/clk/hisilicon/crg-hi3516cv300.c            |    2 +-
 drivers/clk/hisilicon/crg-hi3798cv200.c            |  100 +-
 drivers/clk/imx/Makefile                           |    1 +
 drivers/clk/imx/clk-busy.c                         |    4 +-
 drivers/clk/imx/clk-imx6sll.c                      |  340 ++++
 drivers/clk/imx/clk-imx6sx.c                       |   14 +-
 drivers/clk/imx/clk-imx6ul.c                       |    5 +-
 drivers/clk/imx/clk-imx7d.c                        |  116 +-
 drivers/clk/imx/clk-pllv2.c                        |    6 +-
 drivers/clk/imx/clk.h                              |   14 +
 drivers/clk/keystone/sci-clk.c                     |  380 +---
 drivers/clk/mediatek/Kconfig                       |    6 +
 drivers/clk/mediatek/Makefile                      |    1 +
 drivers/clk/mediatek/clk-mt2701-aud.c              |  186 ++
 drivers/clk/mediatek/clk-mt2701.c                  |   15 +-
 drivers/clk/mediatek/clk-mt2712.c                  |   69 +-
 drivers/clk/mediatek/clk-mt7622-aud.c              |   15 +-
 drivers/clk/meson/Kconfig                          |    9 +
 drivers/clk/meson/Makefile                         |    5 +-
 drivers/clk/meson/axg.c                            |  955 +++++----
 drivers/clk/meson/axg.h                            |   12 +-
 drivers/clk/meson/clk-audio-divider.c              |   63 +-
 drivers/clk/meson/clk-cpu.c                        |  178 --
 drivers/clk/meson/clk-mpll.c                       |  125 +-
 drivers/clk/meson/clk-pll.c                        |  306 +--
 drivers/clk/meson/clk-regmap.c                     |  166 ++
 drivers/clk/meson/clk-regmap.h                     |  111 +
 drivers/clk/meson/clkc.h                           |  107 +-
 drivers/clk/meson/gxbb-aoclk-regmap.c              |   46 -
 drivers/clk/meson/gxbb-aoclk.c                     |   20 +-
 drivers/clk/meson/gxbb-aoclk.h                     |   11 -
 drivers/clk/meson/gxbb.c                           | 1591 ++++++++-------
 drivers/clk/meson/gxbb.h                           |   14 +-
 drivers/clk/meson/meson8b.c                        |  705 ++++---
 drivers/clk/meson/meson8b.h                        |   17 +-
 drivers/clk/mvebu/armada-38x.c                     |   14 +-
 drivers/clk/mvebu/cp110-system-controller.c        |   94 +-
 drivers/clk/nxp/clk-lpc32xx.c                      |    1 +
 drivers/clk/qcom/clk-regmap-divider.c              |   20 +-
 drivers/clk/qcom/clk-rpm.c                         |   79 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |    9 +-
 drivers/clk/qcom/gcc-msm8996.c                     |    8 +-
 drivers/clk/renesas/Kconfig                        |   13 +-
 drivers/clk/renesas/Makefile                       |    2 +
 drivers/clk/renesas/clk-div6.c                     |   22 +-
 drivers/clk/renesas/clk-mstp.c                     |    4 +-
 drivers/clk/renesas/clk-r8a73a4.c                  |   11 +-
 drivers/clk/renesas/clk-r8a7740.c                  |    8 +-
 drivers/clk/renesas/clk-rcar-gen2.c                |   17 +-
 drivers/clk/renesas/clk-rz.c                       |    4 +-
 drivers/clk/renesas/clk-sh73a0.c                   |   20 +-
 drivers/clk/renesas/r8a7743-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a7745-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a7790-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a7791-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a7792-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a7794-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |  334 +++
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |  227 +++
 drivers/clk/renesas/rcar-gen3-cpg.c                |  143 ++
 drivers/clk/renesas/rcar-gen3-cpg.h                |    2 +
 drivers/clk/renesas/renesas-cpg-mssr.c             |   12 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |    2 +
 drivers/clk/rockchip/clk-mmc-phase.c               |   78 +-
 drivers/clk/rockchip/clk-rk3228.c                  |    2 +-
 drivers/clk/rockchip/clk-rk3328.c                  |   83 +-
 drivers/clk/rockchip/clk-rk3399.c                  |    5 +-
 drivers/clk/rockchip/clk.c                         |   22 +-
 drivers/clk/samsung/Makefile                       |    2 +
 drivers/clk/samsung/clk-exynos-audss.c             |    4 +-
 drivers/clk/samsung/clk-exynos3250.c               |  114 +-
 drivers/clk/samsung/clk-exynos4.c                  |  103 +-
 drivers/clk/samsung/clk-exynos5-subcmu.c           |  189 ++
 drivers/clk/samsung/clk-exynos5-subcmu.h           |   26 +
 drivers/clk/samsung/clk-exynos5250.c               |  111 +-
 drivers/clk/samsung/clk-exynos5260.c               |   90 +-
 drivers/clk/samsung/clk-exynos5410.c               |   20 +-
 drivers/clk/samsung/clk-exynos5420.c               |  189 +-
 drivers/clk/samsung/clk-exynos5433.c               |  121 +-
 drivers/clk/samsung/clk-exynos7.c                  |    2 +-
 drivers/clk/samsung/clk-pll.h                      |   48 +-
 drivers/clk/samsung/clk-s3c2410.c                  |  148 +-
 drivers/clk/samsung/clk-s3c2412.c                  |   25 +-
 drivers/clk/samsung/clk-s3c2443.c                  |   55 +-
 drivers/clk/samsung/clk-s3c64xx.c                  |   17 +-
 drivers/clk/socfpga/Makefile                       |    9 +-
 drivers/clk/socfpga/clk-gate-s10.c                 |  125 ++
 drivers/clk/socfpga/clk-periph-s10.c               |  149 ++
 drivers/clk/socfpga/clk-pll-s10.c                  |  146 ++
 drivers/clk/socfpga/clk-s10.c                      |  345 ++++
 drivers/clk/socfpga/clk.h                          |    4 +
 drivers/clk/socfpga/stratix10-clk.h                |   80 +
 drivers/clk/sprd/sc9860-clk.c                      |   76 +
 drivers/clk/sunxi-ng/Kconfig                       |   12 +-
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               | 1211 +++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.h               |   56 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   32 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |    4 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |   58 +-
 drivers/clk/sunxi-ng/ccu_nkmp.h                    |    2 +
 drivers/clk/sunxi-ng/ccu_nm.c                      |    7 +
 drivers/clk/sunxi-ng/ccu_nm.h                      |   27 +
 drivers/clk/tegra/clk-emc.c                        |    2 +-
 drivers/clk/tegra/clk-pll.c                        |    2 +
 drivers/clk/tegra/clk-tegra-periph.c               |    2 +-
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    8 +-
 drivers/clk/tegra/clk-tegra114.c                   |    4 +-
 drivers/clk/tegra/clk-tegra124.c                   |    9 +-
 drivers/clk/tegra/clk-tegra20.c                    |   24 +-
 drivers/clk/tegra/clk-tegra210.c                   |  361 +++-
 drivers/clk/tegra/clk-tegra30.c                    |   15 +-
 drivers/clk/tegra/clk.h                            |    7 +
 drivers/clk/ti/clk.c                               |   38 +
 drivers/clk/ti/clkctrl.c                           |    2 +
 drivers/clk/ti/clock.h                             |   13 +-
 drivers/clk/ti/divider.c                           |   26 +-
 drivers/clk/ti/mux.c                               |   13 +-
 drivers/clk/uniphier/clk-uniphier-sys.c            |   25 +
 drivers/clk/ux500/Makefile                         |    2 -
 drivers/clk/ux500/abx500-clk.c                     |   16 -
 drivers/clk/ux500/u8540_clk.c                      |  597 ------
 drivers/clk/ux500/u9540_clk.c                      |   18 -
 drivers/clk/versatile/clk-vexpress-osc.c           |    5 +-
 drivers/soc/samsung/pm_domains.c                   |   11 +
 include/dt-bindings/clock/axg-clkc.h               |    1 +
 include/dt-bindings/clock/histb-clock.h            |   55 +-
 include/dt-bindings/clock/imx6sll-clock.h          |  202 ++
 include/dt-bindings/clock/imx7d-clock.h            |    5 +-
 include/dt-bindings/clock/mt2701-clk.h             |    3 +-
 include/dt-bindings/clock/mt2712-clk.h             |   12 +-
 include/dt-bindings/clock/mt7622-clk.h             |    3 +-
 include/dt-bindings/clock/qcom,rpmcc.h             |    5 +
 include/dt-bindings/clock/r8a77965-cpg-mssr.h      |   62 +
 include/dt-bindings/clock/r8a77980-cpg-mssr.h      |   51 +
 include/dt-bindings/clock/rk3328-cru.h             |    1 -
 include/dt-bindings/clock/sprd,sc9860-clk.h        |   21 +-
 include/dt-bindings/clock/stm32fx-clock.h          |    7 +-
 include/dt-bindings/clock/stm32mp1-clks.h          |  254 +++
 include/dt-bindings/clock/stratix10-clock.h        |   84 +
 include/dt-bindings/clock/sun50i-h6-ccu.h          |  125 ++
 include/dt-bindings/clock/sun8i-h3-ccu.h           |    2 +
 include/dt-bindings/clock/tegra210-car.h           |    2 +-
 include/dt-bindings/reset/sun50i-h6-ccu.h          |   73 +
 include/linux/clk-provider.h                       |   23 +-
 include/linux/clk.h                                |   16 +-
 include/linux/clk/tegra.h                          |    1 +
 include/linux/clk/ti.h                             |    2 +
 include/linux/platform_data/clk-da8xx-cfgchip.h    |   21 +
 include/linux/platform_data/clk-davinci-pll.h      |   21 +
 200 files changed, 16150 insertions(+), 3969 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/intc_stratix10.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si544.txt
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
 create mode 100644 drivers/clk/clk-si544.c
 create mode 100644 drivers/clk/clk-stm32mp1.c
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
 create mode 100644 drivers/clk/hisilicon/clk-hisi-phase.c
 create mode 100644 drivers/clk/imx/clk-imx6sll.c
 create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c
 delete mode 100644 drivers/clk/meson/clk-cpu.c
 create mode 100644 drivers/clk/meson/clk-regmap.c
 create mode 100644 drivers/clk/meson/clk-regmap.h
 delete mode 100644 drivers/clk/meson/gxbb-aoclk-regmap.c
 create mode 100644 drivers/clk/renesas/r8a77965-cpg-mssr.c
 create mode 100644 drivers/clk/renesas/r8a77980-cpg-mssr.c
 create mode 100644 drivers/clk/samsung/clk-exynos5-subcmu.c
 create mode 100644 drivers/clk/samsung/clk-exynos5-subcmu.h
 create mode 100644 drivers/clk/socfpga/clk-gate-s10.c
 create mode 100644 drivers/clk/socfpga/clk-periph-s10.c
 create mode 100644 drivers/clk/socfpga/clk-pll-s10.c
 create mode 100644 drivers/clk/socfpga/clk-s10.c
 create mode 100644 drivers/clk/socfpga/stratix10-clk.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.h
 delete mode 100644 drivers/clk/ux500/u8540_clk.c
 delete mode 100644 drivers/clk/ux500/u9540_clk.c
 create mode 100644 include/dt-bindings/clock/imx6sll-clock.h
 create mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/r8a77980-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h
 create mode 100644 include/dt-bindings/clock/stratix10-clock.h
 create mode 100644 include/dt-bindings/clock/sun50i-h6-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-h6-ccu.h
 create mode 100644 include/linux/platform_data/clk-da8xx-cfgchip.h
 create mode 100644 include/linux/platform_data/clk-davinci-pll.h

-- 
Sent by a computer through tubes
