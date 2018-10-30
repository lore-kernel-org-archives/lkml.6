Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9243FC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F23920664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhHqdt4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F23920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeJaIfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbeJaIfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:35:32 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC2A20664;
        Tue, 30 Oct 2018 23:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540942795;
        bh=JX/1uPnQOGQmZSiTYeA9GQGTzw4vnCwBTm9A6WBHPrA=;
        h=From:To:Cc:Subject:Date:From;
        b=HhHqdt4UB8Fhlm6JaVrZ9IZdZx+AnGpPyv5cvhRsNFMXIcJXO3kt8aI4KtGN/ALlL
         ZG+AAiGtCfX8aR2eLehVsLkJCBsNvmJpcjmnIkcTWc/hFRYIdY4RnJ7yv3GWYNUwkp
         i40u3E6AB+eB1mkuKpny3b3MiZumGpWddggZMWyk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for v4.20
Date:   Tue, 30 Oct 2018 16:39:54 -0700
Message-Id: <20181030233954.180489-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 9a1d6b232bed2117fa9608873be044a5e8965e76:

  Merge branches 'clk-fixed-rate-remove' and 'clk-qcom-cleanup' into clk-next (2018-10-18 15:44:13 -0700)

----------------------------------------------------------------
This time it looks like a quieter release cycle in the clk tree. I guess that's
because of summer time holidays/vacations. The biggest change in the diffstat
is in the Qualcomm clk driver, where they got support for CPUs and handful of
SoCs. After that, the at91 driver got a major rewrite for newer DT bindings
that should make things easier going forward and the TI code moved to a
clockdomain based design. The long tail is mostly small driver updates for
newer clks and some simpler SoC clock drivers such as the Hisilicon and imx
support.

In the core framework, we only have two small changes this time. One is a new
clk API to get all clks for a device with the bulk clk APIs. This allows
drivers that don't care about doing anything besides turning on all the clks to
just clk_get() them all and turn them on. The other change is the beginning of
a way to support save and restore of clk settings in the clk framework. TI is
the only user right now, but we will want to expand upon this design in the
future to support more save and restore of clk registers.  At least this gets
us started and works well enough for one SoC, but there's more work in the
future.

Core:
 - clk_bulk_get_all() API and friends to get all the clks for a device
 - Basic clk state save/restore hooks

New Drivers:
 - Renesas RZ/A2 (R7S9210) SoC, including early clocks
 - Rensas RZ/G1N (R8A7744) and RZ/G2E (R8A774C0) SoCs
 - Rensas RZ/G2M (r8a774a1) SoC
 - Qualcomm Krait CPU clk support
 - Qualcomm QCS404 GCC support
 - Qualcomm SDM660 GCC support
 - Qualcomm SDM845 camera clock controller
 - Ingenic jz4725b CGU
 - Hisilicon 3670 SoC support
 - TI SCI clks on K3 SoCs
 - iMX6 MMDC clks
 - Reset Controller (RMU) support for Actions Semi Owl S900 and S700 SoCs

Updates:
 - Rework at91 PMC clock driver for new DT bindings
 - Nvidia Tegra clk driver MBIST workaround fix
 - S2RAM support for Marvell mvebu periph clks
 - Use updated printk format for OF node names
 - Fix TI code to only search DT subnodes
 - Various static analysis finds
 - Tag various drivers with SPDX license tags
 - Support dynamic frequency switching (DFS) on qcom SDM845 GCC
 - Only use s2mps11 dt-binding defines instead of redefining them in the driver
 - Add some more missing clks to qcom MSM8996 GCC
 - Quad SPI clks on qcom SDM845
 - Add support for CMT timer clocks on R-Car V3H
 - Add support for SHDI and various timer clocks on R-Car V3M
 - Improve OSC and RCLK (watchdog) handling on R-Car Gen3 SoCs
 - Amlogic clk-pll driver improvements and updates
 - Amlogic axg audio controller system clocks
 - Register Amlogic meson8b clock controller early
 - Add support for SATA and Fine Display Processor (FDP) clocks on R-Car M3-N
 - Consolidation of system suspend related code in Exynos, S5P, S3C SoC clk drivers
 - Fixes for system suspend support on Exynos542x (Odroid boards) and Exynos5433 SoC
 - Remove obsoleted Exynos4212 ISP clock definitions
 - Migrated TI am3/4/5 and dra7 SoCs to clockdomain based design
 - TI RTC+DDR sleep mode support for clock save/restore
 - Allwinner A64 display engine support and fixes
 - Allwinner A83t display engine support and fixes

----------------------------------------------------------------
Alan Tull (1):
      clk: fixed-rate: fix of_node_get-put imbalance

Alexandre Belloni (15):
      clk: at91: audio-pll: fix audio pmc type
      clk: at91: generated: SSCs don't have a gclk
      clk: at91: h32mx: separate registration from DT parsing
      clk: at91: audio-pll: separate registration from DT parsing
      clk: at91: generated: set audio_pll_allowed in at91_clk_register_generated()
      clk: at91: allow clock registration from C code
      clk: at91: add pmc_data struct and helpers
      dt-bindings: clk: at91: Document new PMC binding
      clk: at91: add new DT lookup function
      clk: at91: add sama5d4 pmc driver
      clk: at91: add sama5d2 PMC driver
      clk: at91: add at91sam9260 PMC driver
      clk: at91: add at91sam9x5 PMCs driver
      clk: at91: add at91sam9rl PMC driver
      clk: at91: move DT compatibility code to its own file

Alexey Khoroshilov (1):
      clk: cdce925: release child device nodes

Amit Nischal (2):
      dt-bindings: clock: Introduce QCOM Camera clock bindings
      clk: qcom: Add camera clock controller driver for SDM845

Anson Huang (9):
      clk: imx: imx7d: remove unnecessary clocks from clks_init_on array
      clk: imx: imx7d: remove clks_init_on array
      clk: imx: cpu clock should be always critical
      clk: imx7d: remove CLK_IS_CRITICAL flag for arm_a7_root_clk
      clk: imx6ul: add mmdc1 ipg clock
      clk: imx6sx: add mmdc1 ipg clock
      clk: imx6sll: add mmdc1 ipg clock
      clk: imx6sl: add mmdc ipg clocks
      clk: imx6q: add mmdc0 ipg clock

Arnd Bergmann (1):
      clk: keystone: add missing MODULE_LICENSE

Bartosz Golaszewski (1):
      clk: davinci: kill davinci_clk_reset_assert/deassert()

Biju Das (5):
      clk: renesas: Add r8a774a1 CPG Core Clock Definitions
      clk: renesas: cpg-mssr: Add r8a774a1 support
      dt-bindings: clock: renesas: cpg-mssr: Document r8a7744 binding
      clk: renesas: Add r8a7744 CPG Core Clock Definitions
      clk: renesas: r8a7743: Add r8a7744 support

Bjorn Andersson (1):
      clk: qcom: Export clk_alpha_pll_configure()

Chris Brandt (5):
      clk: renesas: cpg-mssr: Add R7S9210 support
      clk: renesas: cpg-mssr: Add early clock support
      clk: renesas: r7s9210: Convert some clocks to early
      clk: renesas: r7s9210: Move table update to separate function
      clk: renesas: r7s9210: Add SPI clocks

Colin Ian King (1):
      clk: mediatek: remove unused array audio_parents

Dong Aisheng (3):
      clk: bulk: add of_clk_bulk_get()
      clk: add new APIs to operate on all available clocks
      clk: add managed version of clk_bulk_get_all

Douglas Anderson (3):
      clk: qcom: Add qspi (Quad SPI) clock defines for sdm845 to header
      clk: qcom: Add qspi (Quad SPI) clocks for sdm845
      clk: qcom: Allocate space for NULL terimation in DFS table

Enric Balletbo i Serra (1):
      clk: rockchip: Fix static checker warning in rockchip_ddrclk_get_parent call

Evan Green (1):
      clk: qcom: Remove unused arrays in SDM845 GCC

Fabrizio Castro (3):
      clk: renesas: Add r8a774c0 CPG Core Clock Definitions
      clk: renesas: cpg-mssr: Add r8a774c0 support
      dt-bindings: clock: renesas: cpg-mssr: Document r8a774c0

Geert Uytterhoeven (14):
      clk: renesas: rcar-gen3: Rename rint to .r
      clk: renesas: rcar-gen3: Add support for OSC EXTAL predivider
      clk: renesas: r8a7795: Add OSC EXTAL predivider configuration
      clk: renesas: r8a7796: Add OSC EXTAL predivider configuration
      clk: renesas: r8a77965: Add OSC EXTAL predivider configuration
      clk: renesas: r8a77980: Add OSC predivider configuration and clock
      clk: renesas: cpg-mssr: Add support for fixed rate clocks
      clk: renesas: rcar-gen3: Add support for RCKSEL clock selection
      clk: renesas: r8a77990: Correct RCLK handling
      clk: renesas: r8a77995: Correct RCLK handling
      clk: renesas: rcar-gen3: Add support for mode pin clock selection
      clk: renesas: r8a77980: Add RCLK for watchdog timer
      clk: renesas: r8a77990: Add missing I2C7 clock
      clk: renesas: r8a77990: Fix incorrect PLL0 divider in comment

Gregory CLEMENT (3):
      clk: mvebu: use SPDX-License-Identifier
      clk: mvebu: ap806: Remove superfluous of_clk_add_provider
      clk: mvebu: armada-37xx-tbg: Switch to clk_get and balance it in probe

Gustavo A. R. Silva (2):
      clk: qcom: clk-branch: Use true and false for boolean values
      reset: hisilicon: fix potential NULL pointer dereference

Heiko Stuebner (2):
      clk: rockchip: add clock-id for HCLK_HDMI on rk3066
      clk: rockchip: use the newly added clock-id for hdmi on RK3066

Hoan Nguyen An (1):
      clk: renesas: r8a77965: Add FDP clock

Icenowy Zheng (3):
      clk: sunxi-ng: h6: fix bus clocks' divider position
      clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to MMC module clocks
      clk: sunxi-ng: a64: Add max. rate constraint to video PLLs

Jagan Teki (2):
      clk: sunxi-ng: a64: Add minimal rate for video PLLs
      dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO0 macro

Jernej Skrabec (5):
      clk: sunxi-ng: Add maximum rate constraint to NM PLLs
      clk: sunxi-ng: h3/h5: Add max. rate constraint to pll-video
      clk: sunxi-ng: r40: Add max. rate constraint to video PLLs
      clk: sunxi-ng: nkmp: Add constraint for maximum rate
      clk: sunxi-ng: a83t: Add max. rate constraint to video PLLs

Jerome Brunet (5):
      clk: meson: clk-pll: add enable bit
      clk: meson: clk-pll: drop CLK_GET_RATE_NOCACHE where unnecessary
      clk: meson: clk-pll: remove od parameters
      clk: meson: clk-pll: drop hard-coded rates from pll tables
      clk: meson: axg: round audio system master clocks down

Johan Hovold (1):
      clk: ti: fix OF child-node lookup

Joonyoung Shim (1):
      clk: samsung: exynos5420: Define CLK_SECKEY gate clock only or Exynos5420

Joseph Lo (1):
      clk: tegra: Fixes for MBIST work around

Keerthy (1):
      clk: clk: Add clk_gate_restore_context function

Krzysztof Kozlowski (5):
      clk: max77686: Add SPDX license identifiers
      clk: s2mps11,s3c64xx: Add SPDX license identifiers
      clk: s2mps11: Use existing defines from bindings for clock IDs
      dt-bindings: clock: samsung: Add SPDX license identifiers
      clk: s2mps11: Fix matching when built as module and DT node contains compatible

Kuninori Morimoto (2):
      dt-bindings: clock: renesas: Convert to SPDX identifiers
      clk: renesas: Convert to SPDX identifiers

Lubomir Rintel (1):
      clk: mmp2: fix the clock id for sdh2_clk and sdh3_clk

Manivannan Sadhasivam (9):
      clk: actions: Cache regmap info in private clock descriptor
      dt-bindings: clock: Add reset controller bindings for Actions Semi Owl SoCs
      dt-bindings: reset: Add binding constants for Actions Semi S700 RMU
      dt-bindings: reset: Add binding constants for Actions Semi S900 RMU
      clk: actions: Add Actions Semi Owl SoCs Reset Management Unit support
      clk: actions: Add Actions Semi S700 SoC Reset Management Unit support
      clk: actions: Add Actions Semi S900 SoC Reset Management Unit support
      dt-bindings: clk: hisilicon: Add bindings for Hi3670 clk
      clk: hisilicon: Add clock driver for Hi3670 SoC

Marcel Ziswiler (1):
      clk: tegra: probe deferral error reporting

Marek Szyprowski (16):
      clk: samsung: Remove excessive include
      clk: samsung: s3c2410: Use generic helper for handling suspend/resume
      clk: samsung: s3c2412: Use generic helper for handling suspend/resume
      clk: samsung: s3c2443: Use generic helper for handling suspend/resume
      clk: samsung: s3c64xx: Use generic helper for handling suspend/resume
      clk: samsung: s5pv210: Use generic helper for handling suspend/resume
      clk: samsung: exynos5250: Use generic helper for handling suspend/resume
      clk: samsung: Add support for setting registers state before suspend
      clk: samsung: exynos4: Use generic helper for handling suspend/resume
      clk: samsung: exynos5420: Use generic helper for handling suspend/resume
      clk: samsung: Use NOIRQ stage for Exynos5433 clocks suspend/resume
      clk: samsung: exynos5433: Add suspend state for TOP, CPIF & PERIC CMUs
      clk: samsung: Remove obsolete code for Exynos4412 ISP clocks
      clk: samsung: exynos5433: Keep sclk_uart clocks enabled in suspend
      clk: samsung: exynos5420: Enable PERIS clocks for suspend
      clk: samsung: Use clk_hw API for calling clk framework from clk notifiers

Martin Blumenstingl (2):
      clk: meson: meson8b: register the clock controller early
      clk: meson: meson8b: use the regmap in the internal reset controller

Miquel Raynal (2):
      clk: mvebu: armada-37xx-periph: save the IP base address in the driver data
      clk: mvebu: armada-37xx-periph: add suspend/resume support

Nathan Chancellor (1):
      clk: s2mps11: Add used attribute to s2mps11_dt_match

Nishanth Menon (1):
      clk: keystone: Enable TISCI clocks if K3_ARCH

Paul Cercueil (4):
      clk: ingenic: Add proper Kconfig entries
      dt-bindings: clock: ingenic: Explicitly list compatible strings
      dt-bindings: clock: Add jz4725b-cgu.h header
      clk: Add Ingenic jz4725b CGU driver

Phil Edworthy (1):
      clk: renesas: r9a06g032: Fix UART34567 clock rate

Rajendra Nayak (1):
      clk: qcom: Add some missing gcc clks for msm8996

Rob Herring (1):
      clk: Convert to using %pOFn instead of device_node.name

Ronald Wahl (1):
      clk: at91: Fix division by zero in PLL recalc_rate()

Rongyi Chen (1):
      clk: sunxi-ng: h6: fix PWM gate/reset offset

Russ Dill (2):
      clk: Add functions to save/restore clock context en-masse
      clk: ti: Add functions to save/restore clk context

Sergei Shtylyov (5):
      clk: renesas: r8a77980: Add CMT clocks
      clk: renesas: r8a77970: Add SD0H/SD0 clocks for SDHI
      clk: renesas: r8a77970: Add CMT clocks
      clk: renesas: r8a77970: Add TMU clocks
      clk: renesas: r8a77970: Add TPU clock

Shefali Jain (1):
      clk: qcom: gcc: Add global clock controller driver for QCS404

Sricharan R (1):
      clk: qcom: Add safe switch hook for krait mux clocks

Stephen Boyd (37):
      Merge tag 'clk-renesas-for-v4.20-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'meson-clk-4.20-1' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'clk-renesas-for-v4.20-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-4.20' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'clk-ti-for-4.20' of git://git.kernel.org/.../kristo/linux into clk-ti
      clk: Clean up suspend/resume coding style
      Merge tag 'clk-v4.20-samsung' of git://git.kernel.org/.../snawrocki/clk into clk-samsung
      clk: ti: Prepare for remove of OF node name
      clk: tegra210: Include size.h for compilation ease
      ARM: Add Krait L2 register accessor functions
      clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
      clk: qcom: Add HFPLL driver
      dt-bindings: clock: Document qcom,hfpll
      clk: qcom: Add MSM8960/APQ8064's HFPLLs
      clk: qcom: Add IPQ806X's HFPLLs
      clk: qcom: Add support for Krait clocks
      clk: qcom: Add KPSS ACC/GCC driver
      dt-bindings: arm: Document qcom,kpss-gcc
      clk: qcom: Add Krait clock controller driver
      dt-bindings: clock: Document qcom,krait-cc
      Merge tag 'v4.20-rockchip-clk1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      clk: qcom: gcc-sdm660: Add MODULE_LICENSE
      Merge branches 'clk-spdx', 'clk-qcom-dfs', 'clk-smp2s11-include', 'clk-qcom-8996-missing' and 'clk-qcom-qspi' into clk-next
      Merge branches 'clk-dt-name', 'clk-ti-of-node' and 'clk-sa' into clk-next
      Merge branch 'clk-renesas' into clk-next
      Merge branches 'clk-qcom-sdm845-camcc' and 'clk-mtk-unused' into clk-next
      Merge branches 'clk-mvebu-periph-pm', 'clk-meson', 'clk-allwinner', 'clk-mvebu-dup' and 'clk-davinci' into clk-next
      Merge branch 'clk-k3-tisci' into clk-next
      Merge branch 'clk-ti' into clk-next
      Merge branches 'clk-samsung', 'clk-hisi3670' and 'clk-at91-div-0' into clk-next
      Merge branch 'clk-qcom-sdm660' into clk-next
      Merge branch 'clk-qcom-qcs404' into clk-next
      Merge branch 'clk-ingenic-jz4725b' into clk-next
      Merge branches 'clk-tegra' and 'clk-bulk-get-all' into clk-next
      Merge branches 'clk-actions-reset', 'clk-imx7-init-critical', 'clk-mmp2-ids' and 'clk-at91-pmc-rework' into clk-next
      Merge branches 'clk-imx6-mmdc', 'clk-qcom-krait', 'clk-rockchip' and 'clk-smp2s11-match' into clk-next
      Merge branches 'clk-fixed-rate-remove' and 'clk-qcom-cleanup' into clk-next

Takeshi Kihara (1):
      clk: renesas: r8a77965: Add SATA clock

Taniya Das (3):
      clk: qcom: Add support for RCG to register for DFS
      clk: qcom: gcc: Register QUPv3 RCGs for DFS on SDM845
      clk: qcom: Add Global Clock controller (GCC) driver for SDM660

Tero Kristo (11):
      dt-bindings: clock: am33xx: add clkctrl indices for new data layout
      dt-bindings: clock: am43xx: add clkctrl indices for new data layout
      dt-bindings: clock: dra7xx: add clkctrl indices for new data layout
      clk: ti: clkctrl: support multiple clkctrl nodes under a cm node
      clk: ti: clkctrl: replace dashes from clkdm name with underscore
      clk: ti: am33xx: rename existing clkctrl data as compat data
      clk: ti: am33xx: add new clkctrl data for am33xx
      clk: ti: am43xx: rename existing clkctrl data as compat data
      clk: ti: am43xx: add new clkctrl data for am43xx
      clk: ti: dra7xx: rename existing clkctrl data as compat data
      clk: ti: dra7: add new clkctrl data

Urja Rannikko (1):
      clk: rockchip: improve rk3288 pll rates for better hdmi output

Wolfram Sang (1):
      clk: renesas: use SPDX identifier for Renesas drivers

Yixun Lan (1):
      clk: meson-axg: pcie: drop the mpll3 clock parent

Ziyuan Xu (1):
      clk: rockchip: fix wrong mmc sample phase shift for rk3328

 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |   19 +
 .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  |   44 +
 .../devicetree/bindings/clock/actions,owl-cmu.txt  |    2 +
 .../devicetree/bindings/clock/at91-clock.txt       |  516 +---
 .../devicetree/bindings/clock/hi3670-clock.txt     |   43 +
 .../devicetree/bindings/clock/ingenic,cgu.txt      |    7 +-
 .../devicetree/bindings/clock/qcom,camcc.txt       |   18 +
 .../devicetree/bindings/clock/qcom,gcc.txt         |    3 +
 .../devicetree/bindings/clock/qcom,hfpll.txt       |   60 +
 .../devicetree/bindings/clock/qcom,krait-cc.txt    |   34 +
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   17 +-
 arch/arm/common/Kconfig                            |    3 +
 arch/arm/common/Makefile                           |    1 +
 arch/arm/common/krait-l2-accessors.c               |   48 +
 arch/arm/include/asm/krait-l2-accessors.h          |    9 +
 arch/arm/mach-davinci/include/mach/clock.h         |   21 -
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    3 +-
 drivers/clk/actions/Kconfig                        |    1 +
 drivers/clk/actions/Makefile                       |    1 +
 drivers/clk/actions/owl-common.c                   |    3 +-
 drivers/clk/actions/owl-common.h                   |    5 +-
 drivers/clk/actions/owl-reset.c                    |   66 +
 drivers/clk/actions/owl-reset.h                    |   31 +
 drivers/clk/actions/owl-s700.c                     |   55 +-
 drivers/clk/actions/owl-s900.c                     |   86 +-
 drivers/clk/at91/Makefile                          |    5 +-
 drivers/clk/at91/at91sam9260.c                     |  494 ++++
 drivers/clk/at91/at91sam9rl.c                      |  171 ++
 drivers/clk/at91/at91sam9x5.c                      |  309 +++
 drivers/clk/at91/clk-audio-pll.c                   |  109 +-
 drivers/clk/at91/clk-generated.c                   |   81 +-
 drivers/clk/at91/clk-h32mx.c                       |   22 +-
 drivers/clk/at91/clk-i2s-mux.c                     |   40 +-
 drivers/clk/at91/clk-main.c                        |  112 +-
 drivers/clk/at91/clk-master.c                      |   99 +-
 drivers/clk/at91/clk-peripheral.c                  |   81 +-
 drivers/clk/at91/clk-pll.c                         |  190 +-
 drivers/clk/at91/clk-plldiv.c                      |   27 +-
 drivers/clk/at91/clk-programmable.c                |   81 +-
 drivers/clk/at91/clk-slow.c                        |   32 +-
 drivers/clk/at91/clk-smd.c                         |   34 +-
 drivers/clk/at91/clk-system.c                      |   39 +-
 drivers/clk/at91/clk-usb.c                         |   94 +-
 drivers/clk/at91/clk-utmi.c                        |   45 +-
 drivers/clk/at91/dt-compat.c                       |  961 +++++++
 drivers/clk/at91/pmc.c                             |   78 +
 drivers/clk/at91/pmc.h                             |  159 ++
 drivers/clk/at91/sama5d2.c                         |  336 +++
 drivers/clk/at91/sama5d4.c                         |  264 ++
 drivers/clk/axs10x/pll_clock.c                     |    4 +-
 drivers/clk/bcm/clk-kona-setup.c                   |   22 +-
 drivers/clk/clk-asm9260.c                          |    4 +-
 drivers/clk/clk-bulk.c                             |   80 +
 drivers/clk/clk-cdce925.c                          |   11 +-
 drivers/clk/clk-devres.c                           |   24 +
 drivers/clk/clk-fixed-factor.c                     |    8 +-
 drivers/clk/clk-fixed-rate.c                       |    1 +
 drivers/clk/clk-gpio.c                             |    8 +-
 drivers/clk/clk-hsdk-pll.c                         |    4 +-
 drivers/clk/clk-max77686.c                         |   27 +-
 drivers/clk/clk-nomadik.c                          |    4 +-
 drivers/clk/clk-npcm7xx.c                          |    2 +-
 drivers/clk/clk-palmas.c                           |    4 +-
 drivers/clk/clk-qoriq.c                            |   14 +-
 drivers/clk/clk-s2mps11.c                          |   58 +-
 drivers/clk/clk-scmi.c                             |    2 +-
 drivers/clk/clk-scpi.c                             |    6 +-
 drivers/clk/clk-si5351.c                           |    4 +-
 drivers/clk/clk-stm32f4.c                          |    2 +-
 drivers/clk/clk-stm32h7.c                          |    2 +-
 drivers/clk/clk-stm32mp1.c                         |    2 +-
 drivers/clk/clk-tango4.c                           |   10 +-
 drivers/clk/clk.c                                  |   95 +
 drivers/clk/davinci/psc.c                          |   18 -
 drivers/clk/hisilicon/Kconfig                      |    7 +
 drivers/clk/hisilicon/Makefile                     |    1 +
 drivers/clk/hisilicon/clk-hi3670.c                 | 1016 ++++++++
 drivers/clk/hisilicon/reset.c                      |    5 +-
 drivers/clk/imx/clk-cpu.c                          |    2 +-
 drivers/clk/imx/clk-imx6q.c                        |    1 +
 drivers/clk/imx/clk-imx6sl.c                       |    2 +
 drivers/clk/imx/clk-imx6sll.c                      |    1 +
 drivers/clk/imx/clk-imx6sx.c                       |    1 +
 drivers/clk/imx/clk-imx6ul.c                       |    1 +
 drivers/clk/imx/clk-imx7d.c                        |   28 +-
 drivers/clk/imx/clk.h                              |    7 +
 drivers/clk/ingenic/Kconfig                        |   47 +
 drivers/clk/ingenic/Makefile                       |    9 +-
 drivers/clk/ingenic/jz4725b-cgu.c                  |  225 ++
 drivers/clk/keystone/Kconfig                       |    2 +-
 drivers/clk/keystone/gate.c                        |    7 +-
 drivers/clk/keystone/pll.c                         |    7 +-
 drivers/clk/mediatek/clk-mt2701.c                  |    5 -
 drivers/clk/meson/axg-audio.c                      |   34 +-
 drivers/clk/meson/axg.c                            |  332 ++-
 drivers/clk/meson/axg.h                            |    8 +-
 drivers/clk/meson/clk-pll.c                        |  156 +-
 drivers/clk/meson/clkc.h                           |   16 +-
 drivers/clk/meson/gxbb.c                           |  518 ++--
 drivers/clk/meson/gxbb.h                           |   10 +-
 drivers/clk/meson/meson8b.c                        |  280 +-
 drivers/clk/meson/meson8b.h                        |    5 +-
 drivers/clk/mmp/clk-of-mmp2.c                      |    4 +-
 drivers/clk/mvebu/ap806-system-controller.c        |    5 +-
 drivers/clk/mvebu/armada-370.c                     |    4 +-
 drivers/clk/mvebu/armada-375.c                     |    4 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |   58 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                |    8 +-
 drivers/clk/mvebu/armada-37xx-xtal.c               |    4 +-
 drivers/clk/mvebu/armada-38x.c                     |    4 +-
 drivers/clk/mvebu/armada-39x.c                     |    4 +-
 drivers/clk/mvebu/armada-xp.c                      |    4 +-
 drivers/clk/mvebu/clk-corediv.c                    |    4 +-
 drivers/clk/mvebu/clk-cpu.c                        |    4 +-
 drivers/clk/mvebu/common.c                         |    4 +-
 drivers/clk/mvebu/common.h                         |    4 +-
 drivers/clk/mvebu/cp110-system-controller.c        |    4 +-
 drivers/clk/mvebu/dove.c                           |    4 +-
 drivers/clk/mvebu/kirkwood.c                       |    4 +-
 drivers/clk/mvebu/mv98dx3236.c                     |    4 +-
 drivers/clk/mvebu/orion.c                          |    4 +-
 drivers/clk/qcom/Kconfig                           |   53 +
 drivers/clk/qcom/Makefile                          |    8 +
 drivers/clk/qcom/camcc-sdm845.c                    | 1745 +++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |    1 +
 drivers/clk/qcom/clk-branch.c                      |    2 +-
 drivers/clk/qcom/clk-hfpll.c                       |  244 ++
 drivers/clk/qcom/clk-hfpll.h                       |   44 +
 drivers/clk/qcom/clk-krait.c                       |  126 +
 drivers/clk/qcom/clk-krait.h                       |   40 +
 drivers/clk/qcom/clk-rcg.h                         |   11 +
 drivers/clk/qcom/clk-rcg2.c                        |  195 ++
 drivers/clk/qcom/gcc-ipq806x.c                     |   82 +
 drivers/clk/qcom/gcc-msm8960.c                     |  172 ++
 drivers/clk/qcom/gcc-msm8996.c                     |  152 ++
 drivers/clk/qcom/gcc-qcs404.c                      | 2744 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sdm660.c                      | 2480 ++++++++++++++++++
 drivers/clk/qcom/gcc-sdm845.c                      |  321 ++-
 drivers/clk/qcom/hfpll.c                           |   96 +
 drivers/clk/qcom/kpss-xcc.c                        |   87 +
 drivers/clk/qcom/krait-cc.c                        |  397 +++
 drivers/clk/renesas/Kconfig                        |   19 +-
 drivers/clk/renesas/Makefile                       |    3 +
 drivers/clk/renesas/clk-div6.c                     |   17 +-
 drivers/clk/renesas/clk-emev2.c                    |   22 +-
 drivers/clk/renesas/clk-mstp.c                     |   13 +-
 drivers/clk/renesas/clk-r8a73a4.c                  |    9 +-
 drivers/clk/renesas/clk-r8a7740.c                  |    9 +-
 drivers/clk/renesas/clk-r8a7778.c                  |    9 +-
 drivers/clk/renesas/clk-r8a7779.c                  |    9 +-
 drivers/clk/renesas/clk-rcar-gen2.c                |    9 +-
 drivers/clk/renesas/clk-rz.c                       |    9 +-
 drivers/clk/renesas/clk-sh73a0.c                   |    9 +-
 drivers/clk/renesas/r7s9210-cpg-mssr.c             |  217 ++
 drivers/clk/renesas/r8a7743-cpg-mssr.c             |   18 +-
 drivers/clk/renesas/r8a7745-cpg-mssr.c             |    5 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |  323 +++
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |  286 ++
 drivers/clk/renesas/r8a7790-cpg-mssr.c             |    5 +-
 drivers/clk/renesas/r8a7791-cpg-mssr.c             |    5 +-
 drivers/clk/renesas/r8a7792-cpg-mssr.c             |    5 +-
 drivers/clk/renesas/r8a7794-cpg-mssr.c             |    5 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |   72 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |   72 +-
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |   69 +-
 drivers/clk/renesas/r8a77970-cpg-mssr.c            |   81 +-
 drivers/clk/renesas/r8a77980-cpg-mssr.c            |   32 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |   17 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |   17 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    3 +-
 drivers/clk/renesas/rcar-gen2-cpg.c                |    5 +-
 drivers/clk/renesas/rcar-gen2-cpg.h                |    7 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |   45 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |   33 +-
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |    5 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |  205 +-
 drivers/clk/renesas/renesas-cpg-mssr.h             |   38 +-
 drivers/clk/rockchip/clk-ddr.c                     |    4 -
 drivers/clk/rockchip/clk-rk3188.c                  |    2 +-
 drivers/clk/rockchip/clk-rk3288.c                  |   29 +-
 drivers/clk/rockchip/clk-rk3328.c                  |    8 +-
 drivers/clk/samsung/clk-cpu.c                      |    6 +-
 drivers/clk/samsung/clk-cpu.h                      |    2 +-
 drivers/clk/samsung/clk-exynos-audss.c             |    1 -
 drivers/clk/samsung/clk-exynos3250.c               |    1 -
 drivers/clk/samsung/clk-exynos4.c                  |  226 +-
 drivers/clk/samsung/clk-exynos5250.c               |   42 +-
 drivers/clk/samsung/clk-exynos5420.c               |   76 +-
 drivers/clk/samsung/clk-exynos5433.c               |   33 +-
 drivers/clk/samsung/clk-s3c2410.c                  |   43 +-
 drivers/clk/samsung/clk-s3c2412.c                  |   43 +-
 drivers/clk/samsung/clk-s3c2443.c                  |   43 +-
 drivers/clk/samsung/clk-s3c64xx.c                  |   66 +-
 drivers/clk/samsung/clk-s5pv210.c                  |   41 +-
 drivers/clk/samsung/clk.c                          |   23 +-
 drivers/clk/samsung/clk.h                          |   18 +-
 drivers/clk/st/clkgen-fsyn.c                       |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   48 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |    4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   53 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |    2 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   25 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |   52 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |    7 +
 drivers/clk/sunxi-ng/ccu_nkmp.h                    |    1 +
 drivers/clk/sunxi-ng/ccu_nm.c                      |    7 +
 drivers/clk/sunxi-ng/ccu_nm.h                      |   30 +
 drivers/clk/sunxi/clk-mod0.c                       |    6 +-
 drivers/clk/sunxi/clk-sun9i-core.c                 |   20 +-
 drivers/clk/sunxi/clk-sunxi.c                      |    4 +-
 drivers/clk/tegra/clk-dfll.c                       |    8 +-
 drivers/clk/tegra/clk-tegra210.c                   |    7 +-
 drivers/clk/ti/Makefile                            |    9 +-
 drivers/clk/ti/apll.c                              |   18 +-
 drivers/clk/ti/clk-33xx-compat.c                   |  218 ++
 drivers/clk/ti/clk-33xx.c                          |  232 +-
 drivers/clk/ti/clk-43xx-compat.c                   |  225 ++
 drivers/clk/ti/clk-43xx.c                          |  249 +-
 drivers/clk/ti/clk-7xx-compat.c                    |  823 ++++++
 drivers/clk/ti/clk-7xx.c                           |  590 +++--
 drivers/clk/ti/clk-dra7-atl.c                      |    4 +-
 drivers/clk/ti/clk.c                               |   28 +-
 drivers/clk/ti/clkctrl.c                           |  101 +-
 drivers/clk/ti/clock.h                             |   11 +
 drivers/clk/ti/composite.c                         |   14 +-
 drivers/clk/ti/divider.c                           |   40 +-
 drivers/clk/ti/dpll.c                              |   18 +-
 drivers/clk/ti/dpll3xxx.c                          |  124 +
 drivers/clk/ti/fapll.c                             |    8 +-
 drivers/clk/ti/fixed-factor.c                      |    4 +-
 drivers/clk/ti/gate.c                              |    5 +-
 drivers/clk/ti/interface.c                         |    2 +-
 drivers/clk/ti/mux.c                               |   33 +-
 drivers/clk/zynq/clkc.c                            |    4 +-
 include/dt-bindings/clock/am3.h                    |  119 +
 include/dt-bindings/clock/am4.h                    |  132 +
 include/dt-bindings/clock/at91.h                   |   15 +
 include/dt-bindings/clock/dra7.h                   |  326 ++-
 include/dt-bindings/clock/exynos3250.h             |    5 +-
 include/dt-bindings/clock/exynos4.h                |   37 +-
 include/dt-bindings/clock/exynos5250.h             |    7 +-
 include/dt-bindings/clock/exynos5260-clk.h         |    7 +-
 include/dt-bindings/clock/exynos5410.h             |    7 +-
 include/dt-bindings/clock/exynos5420.h             |    7 +-
 include/dt-bindings/clock/exynos5433.h             |    5 +-
 include/dt-bindings/clock/exynos7-clk.h            |    7 +-
 include/dt-bindings/clock/hi3670-clock.h           |  348 +++
 include/dt-bindings/clock/imx6qdl-clock.h          |    3 +-
 include/dt-bindings/clock/imx6sl-clock.h           |    4 +-
 include/dt-bindings/clock/imx6sll-clock.h          |    3 +-
 include/dt-bindings/clock/imx6sx-clock.h           |    3 +-
 include/dt-bindings/clock/imx6ul-clock.h           |    3 +-
 include/dt-bindings/clock/jz4725b-cgu.h            |   35 +
 include/dt-bindings/clock/maxim,max77686.h         |    5 +-
 include/dt-bindings/clock/maxim,max77802.h         |    5 +-
 include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 +
 include/dt-bindings/clock/qcom,gcc-msm8960.h       |    2 +
 include/dt-bindings/clock/qcom,gcc-msm8996.h       |    9 +
 include/dt-bindings/clock/qcom,gcc-qcs404.h        |  165 ++
 include/dt-bindings/clock/qcom,gcc-sdm660.h        |  156 ++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |    3 +
 include/dt-bindings/clock/r7s72100-clock.h         |    7 +-
 include/dt-bindings/clock/r7s9210-cpg-mssr.h       |   20 +
 include/dt-bindings/clock/r8a7743-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a7744-cpg-mssr.h       |   39 +
 include/dt-bindings/clock/r8a7745-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h      |   58 +
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h      |   60 +
 include/dt-bindings/clock/r8a7790-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a7791-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a7792-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a7793-clock.h          |   12 +-
 include/dt-bindings/clock/r8a7793-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a7794-clock.h          |    8 +-
 include/dt-bindings/clock/r8a7794-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a7795-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a7796-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/r8a77970-cpg-mssr.h      |    8 +-
 include/dt-bindings/clock/r8a77995-cpg-mssr.h      |    8 +-
 include/dt-bindings/clock/renesas-cpg-mssr.h       |    8 +-
 include/dt-bindings/clock/rk3188-cru-common.h      |    3 +-
 include/dt-bindings/clock/s3c2410.h                |    5 +-
 include/dt-bindings/clock/s3c2412.h                |    5 +-
 include/dt-bindings/clock/s3c2443.h                |    5 +-
 include/dt-bindings/clock/samsung,s2mps11.h        |    5 +-
 include/dt-bindings/clock/samsung,s3c64xx-clock.h  |    7 +-
 include/dt-bindings/clock/sun50i-a64-ccu.h         |    1 +
 include/dt-bindings/reset/actions,s700-reset.h     |   34 +
 include/dt-bindings/reset/actions,s900-reset.h     |   65 +
 include/linux/clk-provider.h                       |    9 +
 include/linux/clk.h                                |   90 +-
 include/linux/clk/renesas.h                        |    8 +-
 include/linux/clk/ti.h                             |    7 +
 294 files changed, 20499 insertions(+), 4273 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/hi3670-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 arch/arm/common/krait-l2-accessors.c
 create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h
 create mode 100644 drivers/clk/actions/owl-reset.c
 create mode 100644 drivers/clk/actions/owl-reset.h
 create mode 100644 drivers/clk/at91/at91sam9260.c
 create mode 100644 drivers/clk/at91/at91sam9rl.c
 create mode 100644 drivers/clk/at91/at91sam9x5.c
 create mode 100644 drivers/clk/at91/dt-compat.c
 create mode 100644 drivers/clk/at91/sama5d2.c
 create mode 100644 drivers/clk/at91/sama5d4.c
 create mode 100644 drivers/clk/hisilicon/clk-hi3670.c
 create mode 100644 drivers/clk/ingenic/Kconfig
 create mode 100644 drivers/clk/ingenic/jz4725b-cgu.c
 create mode 100644 drivers/clk/qcom/camcc-sdm845.c
 create mode 100644 drivers/clk/qcom/clk-hfpll.c
 create mode 100644 drivers/clk/qcom/clk-hfpll.h
 create mode 100644 drivers/clk/qcom/clk-krait.c
 create mode 100644 drivers/clk/qcom/clk-krait.h
 create mode 100644 drivers/clk/qcom/gcc-qcs404.c
 create mode 100644 drivers/clk/qcom/gcc-sdm660.c
 create mode 100644 drivers/clk/qcom/hfpll.c
 create mode 100644 drivers/clk/qcom/kpss-xcc.c
 create mode 100644 drivers/clk/qcom/krait-cc.c
 create mode 100644 drivers/clk/renesas/r7s9210-cpg-mssr.c
 create mode 100644 drivers/clk/renesas/r8a774a1-cpg-mssr.c
 create mode 100644 drivers/clk/renesas/r8a774c0-cpg-mssr.c
 create mode 100644 drivers/clk/ti/clk-33xx-compat.c
 create mode 100644 drivers/clk/ti/clk-43xx-compat.c
 create mode 100644 drivers/clk/ti/clk-7xx-compat.c
 create mode 100644 include/dt-bindings/clock/hi3670-clock.h
 create mode 100644 include/dt-bindings/clock/jz4725b-cgu.h
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sdm845.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-qcs404.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm660.h
 create mode 100644 include/dt-bindings/clock/r7s9210-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/r8a7744-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/r8a774a1-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/r8a774c0-cpg-mssr.h
 create mode 100644 include/dt-bindings/reset/actions,s700-reset.h
 create mode 100644 include/dt-bindings/reset/actions,s900-reset.h

-- 
Sent by a computer through tubes
