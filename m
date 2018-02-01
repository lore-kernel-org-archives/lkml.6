Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeBAXDw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:03:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBAXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:03:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E44F960A36
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
From: Stephen Boyd <sboyd@codeaurora.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for v4.16
Date: Thu,  1 Feb 2018 15:03:40 -0800
Message-Id: <20180201230340.13805-1-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.15.0.374.g5f9953d2c365
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 975b820b6836b6b6c42fb84cd2e772e2b41bca67:

  clk: fix a panic error caused by accessing NULL pointer (2017-12-05 15:28:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to c43a52cfd27b20292d19d924eddfa5ff8dce87e5:

  Merge branches 'clk-aspeed', 'clk-lock-UP', 'clk-mediatek' and 'clk-allwinner' into clk-next (2018-01-26 16:43:39 -0800)

----------------------------------------------------------------
The core framework has a handful of patches this time around, mostly due
to the clk rate protection support added by Jerome Brunet. This feature
will allow consumers to lock in a certain rate on the output of a clk so
that things like audio playback don't hear pops when the clk frequency
changes due to shared parent clks changing rates. Currently the clk
API doesn't guarantee the rate of a clk stays at the rate you request
after clk_set_rate() is called, so this new API will allow drivers
to express that requirement. Beyond this, the core got some debugfs
pretty printing patches and a couple minor non-critical fixes.

Looking outside of the core framework diff we have some new driver
additions and the removal of a legacy TI clk driver. Both of these hit
high in the dirstat. Also, the removal of the asm-generic/clkdev.h file
causes small one-liners in all the architecture Kbuild files. Overall, the
driver diff seems to be the normal stuff that comes all the time to
fix little problems here and there and to support new hardware.

Core:
 - Clk rate protection
 - Symbolic clk flags in debugfs output
 - Clk registration enabled clks while doing bookkeeping updates

New Drivers:
 - Spreadtrum SC9860
 - HiSilicon hi3660 stub
 - Qualcomm A53 PLL, SPMI clkdiv, and MSM8916 APCS
 - Amlogic Meson-AXG
 - ASPEED BMC

Removed Drivers:
 - TI OMAP 3xxx legacy clk (non-DT) support
 - asm*/clkdev.h got removed (not really a driver)

Updates:
 - Renesas FDP1-0 module clock on R-Car M3-W
 - Renesas LVDS module clock on R-Car V3M
 - Misc fixes to pr_err() prints
 - Qualcomm MSM8916 audio fixes
 - Qualcomm IPQ8074 rounded out support for more peripherals
 - Qualcomm Alpha PLL variants
 - Divider code was using container_of() on bad pointers
 - Allwinner DE2 clks on H3
 - Amlogic minor data fixes and dropping of CLK_IGNORE_UNUSED
 - Mediatek clk driver compile test support
 - AT91 PMC clk suspend/resume restoration support
 - PLL issues fixed on si5351
 - Broadcom IProc PLL calculation updates
 - DVFS support for Armada mvebu CPU clks
 - Allwinner fixed post-divider support
 - TI clkctrl fixes and support for newer SoCs

----------------------------------------------------------------
ABE Hiroshige (1):
      clk: renesas: r8a7796: Add FDP clock

Abhishek Sahu (20):
      clk: qcom: support for alpha pll properties
      clk: qcom: fix 16 bit alpha support calculation
      clk: qcom: flag for 64 bit CONFIG_CTL
      clk: qcom: support for alpha mode configuration
      clk: qcom: support for dynamic updating the PLL
      clk: qcom: support Huayra type Alpha PLL
      clk: qcom: support Brammo type Alpha PLL
      clk: qcom: support for 2 bit PLL post divider
      clk: qcom: add read-only alpha pll post divider operations
      clk: qcom: add read-only divider operations
      clk: qcom: add parent map for regmap mux
      clk: qcom: ipq8074: fix missing GPLL0 divider width
      dt-bindings: clock: qcom: add remaining clocks for IPQ8074
      clk: qcom: ipq8074: add remaining PLL’s
      clk: qcom: ipq8074: add PCIE, USB and SDCC clocks
      clk: qcom: ipq8074: add NSS clocks
      clk: qcom: ipq8074: add NSS ethernet port clocks
      clk: qcom: ipq8074: add GP and Crypto clocks
      dt-bindings: clock: qcom: add misc resets for PCIE and NSS
      clk: qcom: ipq8074: add misc resets for PCIE and NSS

Alexey Khoroshilov (1):
      clk: si5351: implement remove handler

Arvind Yadav (6):
      clk: stm32f4: pr_err() strings should end with newlines
      clk: lpc32xx: pr_err() strings should end with newlines
      clk: SPEAr: pr_err() strings should end with newlines
      SPEAr: clk: pr_err() strings should end with newlines
      clk: h8s2678: pr_err() strings should end with newlines
      clk: h8300: pr_err() strings should end with newlines

Benjamin Gaignard (1):
      clk: stm32-h7: fix copyright

Benjamin Herrenschmidt (1):
      clk: aspeed: Handle inverse polarity of USB port 1 clock gate

Chen-Yu Tsai (5):
      clk: sunxi-ng: Support fixed post-dividers on MP style clocks
      clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module clocks
      clk: sunxi-ng: Support fixed post-dividers on NM style clocks
      clk: sunxi-ng: sun8i: a83t: Add /2 fixed post divider to audio PLL
      clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL

Chunyan Zhang (10):
      clk: move clock common macros out from vendor directories
      clk: sprd: Add common infrastructure
      clk: sprd: add gate clock support
      clk: sprd: add mux clock support
      clk: sprd: add divider clock support
      clk: sprd: add composite clock support
      clk: sprd: add adjustable pll support
      dt-bindings: Add Spreadtrum clock binding documentation
      clk: sprd: Add dt-bindings include file for SC9860
      clk: sprd: add clocks support for SC9860

David Lechner (1):
      clk: fix reentrancy of clk_enable() on UP systems

Geert Uytterhoeven (5):
      clk: renesas: mstp: Keep wakeup sources active during system suspend
      clk: renesas: cpg-mssr: Keep wakeup sources active during system suspend
      clk: Improve flags doc for of_clk_detect_critical()
      clk: Show symbolic clock flags in debugfs
      clk: Fix debugfs_create_*() usage

Georgi Djakov (3):
      clk: qcom: Add A53 PLL support
      clk: qcom: Add regmap mux-div clocks support
      clk: qcom: Add APCS clock controller support

Gomonovych, Vasyl (1):
      clk: mvebu: armada-37xx-periph: Use PTR_ERR_OR_ZERO()

Gregory CLEMENT (3):
      clk: mvebu: armada-37xx-periph: cosmetic changes
      clk: mvebu: armada-37xx-periph: prepare cpu clk to be used with DVFS
      clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks

Icenowy Zheng (3):
      dt-bindings: fix the binding of Allwinner DE2 CCU of A83T and H3
      clk: sunxi-ng: add support for Allwinner H3 DE2 CCU
      clk: sunxi-ng: fix the A64/H5 clock description of DE2 CCU

Igor Grinberg (1):
      clk: pxa: unbreak lookup of CLK_POUT

Jernej Škrabec (1):
      clk: sunxi-ng: a83t: Add M divider to TCON1 clock

Jerome Brunet (13):
      clk: meson: gxbb: remove IGNORE_UNUSED from mmc clocks
      Merge branch 'next/dt' into next/drivers
      clk: check ops pointer on clock register
      clk: fix incorrect usage of ENOSYS
      clk: take the prepare lock out of clk_core_set_parent
      clk: add clk_core_set_phase_nolock function
      clk: rework calls to round and determine rate callbacks
      clk: use round rate to bail out early in set_rate
      clk: add clock protection mechanism to clk core
      clk: cosmetic changes to clk_summary debugfs entry
      clk: add clk_rate_exclusive api
      clk: fix set_rate_range when current rate is out of range
      clk: divider: fix incorrect usage of container_of

Joel Stanley (6):
      dt-bindings: clock: Add ASPEED constants
      clk: Add clock driver for ASPEED BMC SoCs
      clk: aspeed: Register core clocks
      clk: aspeed: Add platform driver and register PLLs
      clk: aspeed: Register gated clocks
      clk: aspeed: Add reset controller

Kaihua Zhong (1):
      clk: hisilicon: Add support for Hi3660 stub clocks

Lars-Peter Clausen (2):
      clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()
      clk: axi-clkgen: Round closest in round_rate() and recalc_rate()

Leo Yan (1):
      dt-bindings: clk: Hi3660: Document stub clock

Lori Hikichi (4):
      clk: iproc: Allow iproc pll to runtime calculate vco parameters
      clk: iproc: Fix error in the pll post divider rate calculation
      clk: iproc: Allow plls to do minor rate changes without reset
      clk: iproc: Minor tidy up of iproc pll data structures

Martin Blumenstingl (1):
      clk: meson: mpll: use 64-bit maths in params_from_rate

Michael Turquette (3):
      Merge tag 'clk-for-v4.16-1' of git://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'meson-clk-for-v4.16-2' of git://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'omap-for-v4.16/clk-omap3-legacy-signed' of git://git.kernel.org/.../tmlind/linux-omap into clk-omap

Philipp Zabel (1):
      clk: imx51: uart4, uart5 gates only exist on imx50, imx53

Qiufang Dai (2):
      clk: meson-axg: add clocks dt-bindings required header
      clk: meson-axg: add clock controller drivers

Romain Izard (3):
      clk: at91: pmc: Wait for clocks when resuming
      clk: at91: pmc: Save SCSR during suspend
      clk: at91: pmc: Support backup for programmable clocks

Sean Wang (4):
      clk: mediatek: group drivers under indpendent menu
      clk: mediatek: fixup test-building of MediaTek clock drivers
      clk: mediatek: Fix all warnings for missing struct clk_onecell_data
      clk: mediatek: adjust dependency of reset.c to avoid unexpectedly being built

Sergei Shtylyov (1):
      clk: renesas: r8a77970: Add LVDS clock

Sergej Sawazki (4):
      clk: si5351: Add DT property to enable PLL reset
      clk: si5351: Apply PLL soft reset before enabling the outputs
      clk: si5351: Rename internal plls to avoid name collisions
      clk: si5351: Do not enable parent clocks on probe

Srinivas Kandagatla (3):
      clk: qcom: msm8916: Fix i2s clk rates required for mclk
      clk: qcom: msm8916: fix mnd_width for codec_digcodec
      clk: qcom: msm8916: add 12.288 MHz support to codec dig clk

Stephen Boyd (27):
      Merge branch 'clk-fixes' into clk-next
      Merge branch 'clk-qcom-audio-fixes' into clk-next
      Merge branch 'clk-qcom-spmi-div' into clk-next
      Merge branch 'clk-pr-err' into clk-next
      Merge branch 'clk-hi3660-stub' into clk-next
      Merge branch 'clk-stm32-copyright' into clk-next
      Merge branch '4.15-rc1-clkctrl-driver' of https://github.com/t-kristo/linux-pm into clk-next
      Merge tag 'clk-renesas-for-v4.16-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      clk: Don't touch hardware when reparenting during registration
      Merge tag 'sunxi-clk-for-4.16' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      blackfin: Use generic clkdev.h header
      clk: Prepare to remove asm-generic/clkdev.h
      Merge tag 'aspeed-4.16-clk-binding' of git://git.kernel.org/.../joel/aspeed into HEAD
      Merge tag 'meson-clk-for-v4.16-3' of git://github.com/BayLibre/clk-meson into clk-meson
      arch: Remove clkdev.h asm-generic from Kbuild
      clk: sunxi: Use CLK_IS_CRITICAL flag for critical clks
      clk: Move __clk_{get,put}() into private clk.h API
      clk: Simplify debugfs registration
      Merge tag 'clk-renesas-for-v4.16-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-4.16-2' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge branches 'clk-qcom-alpha-pll', 'clk-check-ops-ptr', 'clk-protect-rate' and 'clk-omap' into clk-next
      Merge branches 'clk-spreadtrum', 'clk-mvebu-dvfs', 'clk-qoriq', 'clk-imx' and 'clk-qcom-ipq8074' into clk-next
      Merge branches 'clk-at91', 'clk-imx7ulp', 'clk-axigen', 'clk-si5351' and 'clk-pxa' into clk-next
      Merge branches 'clk-iproc', 'clk-mvebu' and 'clk-qcom-a53' into clk-next
      Merge branch 'clk-divider-container' into clk-next
      Merge branches 'clk-remove-asm-clkdev', 'clk-debugfs-fixes', 'clk-renesas' and 'clk-meson' into clk-next
      Merge branches 'clk-aspeed', 'clk-lock-UP', 'clk-mediatek' and 'clk-allwinner' into clk-next

Tero Kristo (28):
      clk: ti: clkctrl: fix error messages to print out node name properly
      clk: ti: clkctrl: add support for clkdm init for clkctrl clocks
      clk: ti: add support for clkctrl aliases
      clk: ti: clkctrl: use fallback udelay approach if timekeeping is suspended
      clk: ti: convert retry_init param to use void data type
      clk: ti: clkctrl: add support for retrying failed init
      clk: ti: clkctrl: fix flags for mux and divider opt clocks
      clk: ti: omap4: cleanup unnecessary clock aliases
      clk: ti: dra7: drop unnecessary clock aliases
      clk: ti: omap5: cleanup unnecessary clock aliases
      clk: ti: dm814x: cleanup unnecessary clock aliases
      clk: ti: dm816x: cleanup unnecessary clock aliases
      clk: ti: am33xx: cleanup unnecessary clock aliases
      clk: ti: am43xx: cleanup unnecessary clock aliases
      clk: ti: omap3: cleanup unnecessary clock aliases
      dt-bindings: clk: add omap5 clkctrl definitions
      clk: ti: omap5: add clkctrl clock data
      dt-bindings: clk: add dra7 clkctrl definitions
      clk: ti: dra7: add clkctrl clock data
      dt-bindings: clk: add am33xx clkctrl definitions
      clk: ti: am33xx: add clkctrl clock data
      dt-bindings: clk: add am43xx clkctrl definitions
      clk: ti: am43xx: add clkctrl clock data
      dt-bindings: clk: add dm814 clkctrl definitions
      clk: ti: dm814: add clkctrl clock data
      dt-bindings: clk: add dm816 clkctrl definitions
      clk: ti: dm816: add clkctrl clock data
      clk: ti: omap4: clkctrl data fixes for opt-clocks

Tirupathi Reddy (2):
      dt-bindings: Add qcom spmi_pmic clock divider bindings
      clk: qcom: Add spmi_pmic clock divider support

Tony Lindgren (1):
      clk: ti: Drop legacy clk-3xxx-legacy code

Vasyl Gomonovych (1):
      clk: sunxi: Use PTR_ERR_OR_ZERO()

Wei Yongjun (1):
      clk: aspeed: Fix return value check in aspeed_cc_init()

Wu Fengguang (1):
      clk: si5351: _si5351_clkout_reset_pll() can be static

Yixun Lan (3):
      clk: meson: gxbb: fix wrong clock for SARADC/SANA
      clk: meson: make the spinlock naming more specific
      dt-bindings: clock: add compatible variant for the Meson-AXG

Yuantian Tang (1):
      clk: qoriq: add more divider clocks support

weiyongjun (A) (3):
      clk: meson-axg: fix return value check in axg_clkc_probe()
      clk: meson-axg: make local symbol axg_gp0_params_table static
      clk: meson-axg: fix potential NULL dereference in axg_clkc_probe()

 .../bindings/clock/amlogic,gxbb-clkc.txt           |    7 +-
 .../devicetree/bindings/clock/hi3660-clock.txt     |    6 +
 .../devicetree/bindings/clock/qcom,a53pll.txt      |   22 +
 .../devicetree/bindings/clock/qcom,spmi-clkdiv.txt |   59 +
 .../devicetree/bindings/clock/qoriq-clock.txt      |    1 +
 .../devicetree/bindings/clock/silabs,si5351.txt    |    1 +
 Documentation/devicetree/bindings/clock/sprd.txt   |   63 +
 .../devicetree/bindings/clock/sun8i-de2.txt        |    5 +-
 arch/alpha/include/asm/Kbuild                      |    1 -
 arch/arc/include/asm/Kbuild                        |    1 -
 arch/arm/include/asm/Kbuild                        |    1 -
 arch/arm64/Kconfig.platforms                       |    1 +
 arch/arm64/include/asm/Kbuild                      |    1 -
 arch/blackfin/include/asm/clkdev.h                 |   17 -
 arch/c6x/include/asm/Kbuild                        |    1 -
 arch/cris/include/asm/Kbuild                       |    1 -
 arch/frv/include/asm/Kbuild                        |    1 -
 arch/h8300/include/asm/Kbuild                      |    1 -
 arch/hexagon/include/asm/Kbuild                    |    1 -
 arch/ia64/include/asm/Kbuild                       |    1 -
 arch/m32r/include/asm/Kbuild                       |    1 -
 arch/m68k/include/asm/Kbuild                       |    1 -
 arch/metag/include/asm/Kbuild                      |    1 -
 arch/microblaze/include/asm/Kbuild                 |    1 -
 arch/mips/include/asm/Kbuild                       |    1 -
 arch/mn10300/include/asm/Kbuild                    |    1 -
 arch/nios2/include/asm/Kbuild                      |    1 -
 arch/openrisc/include/asm/Kbuild                   |    1 -
 arch/parisc/include/asm/Kbuild                     |    1 -
 arch/powerpc/include/asm/Kbuild                    |    1 -
 arch/riscv/include/asm/Kbuild                      |    1 -
 arch/s390/include/asm/Kbuild                       |    1 -
 arch/score/include/asm/Kbuild                      |    1 -
 arch/sh/include/asm/Kbuild                         |    1 -
 arch/sparc/include/asm/Kbuild                      |    1 -
 arch/tile/include/asm/Kbuild                       |    1 -
 arch/um/include/asm/Kbuild                         |    1 -
 arch/unicore32/include/asm/Kbuild                  |    1 -
 arch/x86/include/asm/Kbuild                        |    1 -
 arch/xtensa/include/asm/Kbuild                     |    1 -
 drivers/clk/Kconfig                                |   13 +
 drivers/clk/Makefile                               |    4 +-
 drivers/clk/at91/clk-programmable.c                |    2 +
 drivers/clk/at91/pmc.c                             |   63 +-
 drivers/clk/at91/pmc.h                             |    2 +
 drivers/clk/bcm/clk-cygnus.c                       |   25 +-
 drivers/clk/bcm/clk-iproc-pll.c                    |  260 +-
 drivers/clk/bcm/clk-iproc.h                        |    5 +
 drivers/clk/clk-aspeed.c                           |  667 +++
 drivers/clk/clk-axi-clkgen.c                       |   39 +-
 drivers/clk/clk-divider.c                          |    7 +-
 drivers/clk/clk-qoriq.c                            |    9 +-
 drivers/clk/clk-si5351.c                           |   68 +-
 drivers/clk/clk-stm32f4.c                          |    2 +-
 drivers/clk/clk-stm32h7.c                          |   19 +-
 drivers/clk/clk.c                                  |  620 ++-
 drivers/clk/clk.h                                  |    4 +
 drivers/clk/clkdev.c                               |    2 +-
 drivers/clk/h8300/clk-div.c                        |    4 +-
 drivers/clk/h8300/clk-h8s2678.c                    |    6 +-
 drivers/clk/hisilicon/Kconfig                      |    6 +
 drivers/clk/hisilicon/Makefile                     |    1 +
 drivers/clk/hisilicon/clk-hi3660-stub.c            |  185 +
 drivers/clk/hisilicon/clkdivider-hi6220.c          |    2 +-
 drivers/clk/imx/clk-imx51-imx53.c                  |   12 +-
 drivers/clk/mediatek/Kconfig                       |   97 +-
 drivers/clk/mediatek/Makefile                      |    3 +-
 drivers/clk/mediatek/clk-mtk.h                     |    8 +-
 drivers/clk/meson/Kconfig                          |    8 +
 drivers/clk/meson/Makefile                         |    1 +
 drivers/clk/meson/axg.c                            |  938 ++++
 drivers/clk/meson/axg.h                            |  126 +
 drivers/clk/meson/clk-mpll.c                       |    2 +-
 drivers/clk/meson/clkc.h                           |    2 +-
 drivers/clk/meson/gxbb.c                           |  132 +-
 drivers/clk/meson/meson8b.c                        |   24 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |  317 +-
 drivers/clk/nxp/clk-lpc32xx.c                      |    6 +-
 drivers/clk/pxa/clk-pxa3xx.c                       |    6 +-
 drivers/clk/qcom/Kconfig                           |   30 +
 drivers/clk/qcom/Makefile                          |    4 +
 drivers/clk/qcom/a53-pll.c                         |  107 +
 drivers/clk/qcom/apcs-msm8916.c                    |  138 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  516 ++-
 drivers/clk/qcom/clk-alpha-pll.h                   |   35 +-
 drivers/clk/qcom/clk-rcg.h                         |   10 -
 drivers/clk/qcom/clk-regmap-divider.c              |   31 +-
 drivers/clk/qcom/clk-regmap-divider.h              |    1 +
 drivers/clk/qcom/clk-regmap-mux-div.c              |  231 +
 drivers/clk/qcom/clk-regmap-mux-div.h              |   44 +
 drivers/clk/qcom/clk-regmap-mux.c                  |    6 +
 drivers/clk/qcom/clk-regmap-mux.h                  |    2 +
 drivers/clk/qcom/clk-spmi-pmic-div.c               |  302 ++
 drivers/clk/qcom/common.h                          |   11 +-
 drivers/clk/qcom/gcc-ipq8074.c                     | 4182 +++++++++++++++++-
 drivers/clk/qcom/gcc-msm8916.c                     |   13 +-
 drivers/clk/qcom/gcc-msm8994.c                     |    4 +
 drivers/clk/qcom/gcc-msm8996.c                     |    4 +
 drivers/clk/qcom/mmcc-msm8996.c                    |   16 +
 drivers/clk/renesas/clk-mstp.c                     |    2 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    1 +
 drivers/clk/renesas/r8a77970-cpg-mssr.c            |    1 +
 drivers/clk/renesas/renesas-cpg-mssr.c             |    2 +-
 drivers/clk/spear/clk-frac-synth.c                 |    2 +-
 drivers/clk/spear/clk-gpt-synth.c                  |    2 +-
 drivers/clk/sprd/Kconfig                           |   14 +
 drivers/clk/sprd/Makefile                          |   11 +
 drivers/clk/sprd/common.c                          |   96 +
 drivers/clk/sprd/common.h                          |   38 +
 drivers/clk/sprd/composite.c                       |   60 +
 drivers/clk/sprd/composite.h                       |   51 +
 drivers/clk/sprd/div.c                             |   91 +
 drivers/clk/sprd/div.h                             |   75 +
 drivers/clk/sprd/gate.c                            |  111 +
 drivers/clk/sprd/gate.h                            |   59 +
 drivers/clk/sprd/mux.c                             |   76 +
 drivers/clk/sprd/mux.h                             |   74 +
 drivers/clk/sprd/pll.c                             |  266 ++
 drivers/clk/sprd/pll.h                             |  108 +
 drivers/clk/sprd/sc9860-clk.c                      | 1974 +++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   57 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |   22 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |   53 +-
 drivers/clk/sunxi-ng/ccu_common.h                  |   29 -
 drivers/clk/sunxi-ng/ccu_div.c                     |    2 +-
 drivers/clk/sunxi-ng/ccu_mp.c                      |   20 +-
 drivers/clk/sunxi-ng/ccu_mp.h                      |   24 +
 drivers/clk/sunxi-ng/ccu_nm.c                      |   50 +-
 drivers/clk/sunxi-ng/ccu_nm.h                      |    2 +
 drivers/clk/sunxi/clk-factors.c                    |   26 +-
 drivers/clk/sunxi/clk-factors.h                    |    4 +
 drivers/clk/sunxi/clk-mod0.c                       |    9 +-
 drivers/clk/sunxi/clk-sun8i-apb0.c                 |    5 +-
 drivers/clk/sunxi/clk-sun8i-mbus.c                 |    7 +-
 drivers/clk/sunxi/clk-sun9i-core.c                 |    9 +-
 drivers/clk/sunxi/clk-sunxi.c                      |   36 +-
 drivers/clk/ti/Makefile                            |    4 -
 drivers/clk/ti/apll.c                              |    3 +-
 drivers/clk/ti/clk-33xx.c                          |  279 +-
 drivers/clk/ti/clk-3xxx-legacy.c                   | 4656 --------------------
 drivers/clk/ti/clk-3xxx.c                          |  263 +-
 drivers/clk/ti/clk-43xx.c                          |  295 +-
 drivers/clk/ti/clk-44xx.c                          |  200 +-
 drivers/clk/ti/clk-54xx.c                          |  697 ++-
 drivers/clk/ti/clk-7xx.c                           | 1076 +++--
 drivers/clk/ti/clk-814x.c                          |   50 +-
 drivers/clk/ti/clk-816x.c                          |   62 +-
 drivers/clk/ti/clk.c                               |  205 +-
 drivers/clk/ti/clkctrl.c                           |   91 +-
 drivers/clk/ti/clock.h                             |   81 +-
 drivers/clk/ti/composite.c                         |   48 +-
 drivers/clk/ti/dpll.c                              |   93 +-
 drivers/clk/ti/gate.c                              |   48 -
 drivers/clk/ti/interface.c                         |   32 -
 drivers/clk/zte/clk.h                              |   18 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c         |    2 +-
 drivers/rtc/rtc-ac100.c                            |    6 +-
 include/asm-generic/clkdev.h                       |   30 -
 include/dt-bindings/clock/am3.h                    |  108 +
 include/dt-bindings/clock/am4.h                    |  113 +
 include/dt-bindings/clock/aspeed-clock.h           |   52 +
 include/dt-bindings/clock/axg-clkc.h               |   71 +
 include/dt-bindings/clock/dm814.h                  |   45 +
 include/dt-bindings/clock/dm816.h                  |   53 +
 include/dt-bindings/clock/dra7.h                   |  172 +
 include/dt-bindings/clock/hi3660-clock.h           |    7 +
 include/dt-bindings/clock/omap5.h                  |  118 +
 include/dt-bindings/clock/qcom,gcc-ipq8074.h       |  222 +
 include/dt-bindings/clock/sprd,sc9860-clk.h        |  404 ++
 include/linux/clk-provider.h                       |   43 +-
 include/linux/clk.h                                |   62 +
 include/linux/clkdev.h                             |    7 +-
 include/linux/platform_data/si5351.h               |    2 +
 173 files changed, 15658 insertions(+), 7125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,spmi-clkdiv.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd.txt
 delete mode 100644 arch/blackfin/include/asm/clkdev.h
 create mode 100644 drivers/clk/clk-aspeed.c
 create mode 100644 drivers/clk/hisilicon/clk-hi3660-stub.c
 create mode 100644 drivers/clk/meson/axg.c
 create mode 100644 drivers/clk/meson/axg.h
 create mode 100644 drivers/clk/qcom/a53-pll.c
 create mode 100644 drivers/clk/qcom/apcs-msm8916.c
 create mode 100644 drivers/clk/qcom/clk-regmap-mux-div.c
 create mode 100644 drivers/clk/qcom/clk-regmap-mux-div.h
 create mode 100644 drivers/clk/qcom/clk-spmi-pmic-div.c
 create mode 100644 drivers/clk/sprd/Kconfig
 create mode 100644 drivers/clk/sprd/Makefile
 create mode 100644 drivers/clk/sprd/common.c
 create mode 100644 drivers/clk/sprd/common.h
 create mode 100644 drivers/clk/sprd/composite.c
 create mode 100644 drivers/clk/sprd/composite.h
 create mode 100644 drivers/clk/sprd/div.c
 create mode 100644 drivers/clk/sprd/div.h
 create mode 100644 drivers/clk/sprd/gate.c
 create mode 100644 drivers/clk/sprd/gate.h
 create mode 100644 drivers/clk/sprd/mux.c
 create mode 100644 drivers/clk/sprd/mux.h
 create mode 100644 drivers/clk/sprd/pll.c
 create mode 100644 drivers/clk/sprd/pll.h
 create mode 100644 drivers/clk/sprd/sc9860-clk.c
 delete mode 100644 drivers/clk/ti/clk-3xxx-legacy.c
 delete mode 100644 include/asm-generic/clkdev.h
 create mode 100644 include/dt-bindings/clock/am3.h
 create mode 100644 include/dt-bindings/clock/am4.h
 create mode 100644 include/dt-bindings/clock/aspeed-clock.h
 create mode 100644 include/dt-bindings/clock/axg-clkc.h
 create mode 100644 include/dt-bindings/clock/dm814.h
 create mode 100644 include/dt-bindings/clock/dm816.h
 create mode 100644 include/dt-bindings/clock/dra7.h
 create mode 100644 include/dt-bindings/clock/omap5.h
 create mode 100644 include/dt-bindings/clock/sprd,sc9860-clk.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
