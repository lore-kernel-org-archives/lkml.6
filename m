Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9967121502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy/CZwhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9967121502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeHOTmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbeHOTmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:42:46 -0400
Received: from mail.kernel.org (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A69221502;
        Wed, 15 Aug 2018 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534351791;
        bh=ymKZxnc5jOFD1JqkO1uyaFXicSFuQEOTVp3+iv91IrI=;
        h=From:To:Cc:Subject:Date:From;
        b=Dy/CZwhqE4q4K3uiGlosp4UZzkUBXTyMoNaqUHweewGoxoRFs32fK8kaycoeRjycC
         oKa7hSNm6oFnKUiJdsR9J5tJbJfpl3EIzXwT7MMs4ADgksK4s3fuQBfx28A/PqgF9o
         w0l/ZefR/jLCT9SjYQ9+eG6XohN0c0kkiw7oqQfc=
From:   sboyd@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for v4.19
Date:   Wed, 15 Aug 2018 09:49:50 -0700
Message-Id: <20180815164950.203459-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit 55c5e0c602c20cb6f350e5ae357cfd7e04ebb189:

  dt-bindings: clock: imx6ul: Do not change the clock definition order (2018-06-29 11:40:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to ac7da1b787d9ea43680c487613269742c48d8747:

  Merge branches 'clk-actions-s700', 'clk-exynos-unused', 'clk-qcom-dispcc-845', 'clk-scmi-round' and 'clk-cs2000-spdx' into clk-next (2018-08-14 23:00:15 -0700)

----------------------------------------------------------------
The new and exciting feature this time around is in the clk core.
We've added duty cycle support to the clk API so that clk signal
duty cycle ratios can be adjusted while taking into account things
like clk dividers and clk tree hierarchy. So far only one SoC has
implemented support for this, but I expect there will be more to
come in the future.

Outside of the core, we have the usual pile of clk driver updates
and additions. The Amlogic meson driver got the most lines in the
diffstat this time around because it added support for a whole bunch
of hardware and duty cycle configuration. After that the Rockchip PX30,
Qualcomm SDM845, and Renesas SoC drivers fill in a majority of the diff.
We're left with the collection of non-critical fixes after that. Overall
it looks pretty quiet this time.

Core:
 - Clk duty cycle support
 - Proper CLK_SET_RATE_GATE support throughout the tree

New Drivers:
 - Actions Semi Owl series S700 SoC clk driver
 - Qualcomm SDM845 display clock controller
 - i.MX6SX ocram_s clk support
 - Uniphier NAND, USB3 PHY, and SPI clk support
 - Qualcomm RPMh clk driver
 - i.MX7D mailbox clk support
 - Maxim 9485 Programmable Clock Generator
 - Expose 32 kHz PLL on PXA SoCs
 - imx6sll GPIO clk gate support
 - Atmel at91 I2S audio clk support
 - SI544/SI514 clk on/off support
 - i.MX6UL GPIO clock gates in CCM CCGR
 - Renesas Crypto Engine clocks on R-Car H3
 - Renesas clk support for the new RZ/N1D SoC
 - Allwinner A64 display engine clock support
 - Support for Rockchip's PX30 SoC
 - Amlogic Meson axg PCIe and audio clocks
 - Amlogic Meson GEN CLK on gxbb, gxl and axg

Updates:
 - Remove an unused variable from Exynos4412 ISP driver
 - Fix a thinko bug in SCMI clk division logic
 - Add missing of_node_put()s in some i.MX clk drivers
 - Tegra SDMMC clk jitter improvements with high speed signaling modes
 - SPDX tagging for qcom and cs2000-cp drivers
 - Stop leaking con ids in __clk_put()
 - Fix a corner case in fixed factor clk probing where node is in DT but
   parent clk is registered much later
 - Marvell Armada 3700 clk_pm_cpu_get_parent() had an invalid return value
 - i.MX clk init arrays removed in place of CLK_IS_CRITICAL
 - Convert to CLK_IS_CRITICAL for i.MX51/53 driver
 - Fix Tegra BPMP driver oops when xlating a NULL clk
 - Proper default configuration for vic03 and vde clks on Tegra124
 - Mark Tegra memory controller clks as critical
 - Fix array bounds clamp in Tegra's emc determine_rate() op
 - Ingenic i2s bit update and allow UDC clk to gate
 - Fix name of aspeed SDC clk define to have only one 'CLK'
 - Fix i.MX6QDL video clk parent
 - Critical clk markings for qcom SDM845
 - Fix Stratix10 mpu_free_clk and sdmmc_free_clk parents
 - Mark Rockchip's pclk_rkpwm_pmu as critical clock, due to it supplying
   the pwm used to drive the logic supply of the rk3399 core.

----------------------------------------------------------------
Aapo Vienamo (1):
      clk: tegra: Fix includes required by fence_udelay()

Alberto Panizzo (1):
      clk: rockchip: fix clk_i2sout parent selection bits on rk3399

Amit Daniel Kachhap (1):
      clk: scmi: Fix the rounding of clock rate

Amit Nischal (1):
      clk: qcom: Enable clocks which needs to be always on for SDM845

Anders Roxell (1):
      clk: mvebu: armada-37xx-periph: Remove unused var num_parents

Anson Huang (7):
      clk: imx6q: remove clks_init_on array
      clk: imx6sl: remove clks_init_on array
      clk: imx6sx: remove clks_init_on array
      clk: imx6ul: add GPIO clock gates
      clk: imx6ul: remove clks_init_on array
      clk: imx6sll: add GPIO LPCGs
      clk: imx: add ocram_s clock for i.mx6sx

Codrin Ciubotariu (2):
      dt-bindings: clk: at91: add an I2S mux clock
      clk: at91: add I2S clock mux driver

Daniel Mack (2):
      dts: clk: add devicetree bindings for MAX9485
      clk: Add driver for MAX9485

Dinh Nguyen (2):
      clk: socfpga: stratix10: fix the parents of mpu_free_clk
      clk: socfpga: stratix10: fix the sdmmc_free_clk mux

Dmitry Osipenko (2):
      clk: tegra: Mark Memory Controller clock as critical
      clk: tegra: emc: Avoid out-of-bounds bug

Elaine Zhang (4):
      clk: rockchip: add dt-binding header for px30
      dt-bindings: add bindings for px30 clock controller
      clk: rockchip: add support for half divider
      clk: rockchip: add clock controller for px30

Fabio Estevam (1):
      clk: imx51-imx53: Annotate critical clocks as CLK_IS_CRITICAL

Geert Uytterhoeven (1):
      clk: renesas: r8a7795: Add CR clock

Gilad Ben-Yossef (1):
      clk: renesas: r8a7795: Add CCREE clock

Gregory CLEMENT (2):
      clk: mvebu: armada-37xx-periph: switch to SPDX license identifier
      clk: mvebu: armada-37xx-periph: Fix wrong return value in get_parent

Heiko Stuebner (1):
      Merge branch 'v4.19-shared/clkids' into v4.19-clk/next

Icenowy Zheng (2):
      dt-bindings: add compatible string for the A64 DE2 CCU
      clk: sunxi-ng: add A64 compatible string

Jernej Skrabec (3):
      clk: sunxi-ng: r40: Add minimal rate for video PLLs
      clk: sunxi-ng: r40: Allow setting parent rate to display related clocks
      clk: sunxi-ng: r40: Export video PLLs

Jerome Brunet (16):
      clk: qcom: drop CLK_SET_RATE_GATE from sdc clocks
      clk: fix CLK_SET_RATE_GATE with clock rate protection
      dt-bindings: clock: add meson axg audio clock controller bindings
      clk: meson: expose GEN_CLK clkid
      clk: meson: remove obsolete register access
      clk: meson: clean-up meson clock configuration
      Merge branch 'next/dt' into next/drivers
      clk: meson: add clk-phase clock driver
      clk: meson: add triple phase clock driver
      Merge remote-tracking branch 'clk/clk-core-duty-cycle' into next/drivers
      clk: meson: add axg audio sclk divider driver
      clk: meson: axg: add the audio clock controller driver
      clk: meson: stop rate propagation for audio clocks
      clk: meson: remove unused clk-audio-divider driver
      clk: meson: gxbb: remove HHI_GEN_CLK_CTNL duplicate definition
      clk: meson: add gen_clk

Krzysztof Kozlowski (1):
      clk: samsung: Remove unused mout_user_aclk400_mcuisp_p4x12 variable

Kunihiko Hayashi (1):
      clk: uniphier: add clock frequency support for SPI

Kuninori Morimoto (1):
      clk: cs2000-cp: convert to SPDX identifiers

Lei YU (1):
      clk: aspeed: Fix SDCLK name

Levin Du (1):
      clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399

Masahiro Yamada (2):
      clk: uniphier: add NAND 200MHz clock
      clk: uniphier: add more USB3 PHY clocks

Michel Pollet (3):
      dt-bindings: clock: Add the r9a06g032-sysctrl.h file
      dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
      clk: renesas: Renesas R9A06G032 clock driver

Mike Looijmans (1):
      clk-si514, clk-si544: Implement prepare/unprepare/is_prepared operations

Mikko Perttunen (2):
      clk: tegra: bpmp: Don't crash when a clock fails to register
      clk: core: Potentially free connection id

Nicholas Mc Guire (2):
      clk: imx6ul: fix missing of_node_put()
      clk: imx6sll: fix missing of_node_put()

Oleksij Rempel (1):
      clk: imx7d: add IMX7D_MU_ROOT_CLK

Paul Cercueil (2):
      clk: ingenic: Fix incorrect data for the i2s clock
      clk: ingenic: Add missing flag for UDC clock

Peter De Schrijver (1):
      clk: tegra: Refactor fractional divider calculation

Peter De-Schrijver (2):
      clk: tegra: Add sdmmc mux divider clock
      clk: tegra: make sdmmc2 and sdmmc4 as sdmmc clocks

Philipp Puschmann (1):
      clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL

Rajan Vaja (1):
      clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure

Robert Jarzmik (1):
      clk: pxa: export 32kHz PLL

Saravanan Sekar (3):
      clk: actions: Add missing REGMAP_MMIO dependency
      dt-bindings: clock: Add S700 support for Actions Semi Soc's
      clk: actions: Add S700 SoC clock support

Stephen Boyd (14):
      Merge tag 'clk-renesas-for-v4.19-tag1' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      clk: imx51-imx53: Include sizes.h to silence compile errors
      Merge tag 'meson-clk-4.19-1' of https://github.com/BayLibre/clk-meson into clk-meson
      Merge tag 'v4.19-rockchip-clk1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge tag 'sunxi-clk-for-4.19' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      Merge tag 'v4.19-rockchip-clk2' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge branches 'clk-qcom-set-rate-gate', 'clk-core-set-rate-gate', 'clk-core-duty-cycle', 'clk-si-prepare' and 'clk-imx-gpio-gates' into clk-next
      Merge branches 'clk-imx6-video-parent', 'clk-qcom-sdm845-criticals', 'clk-renesas', 'clk-stratix10-fixes' and 'clk-atmel-i2s' into clk-next
      Merge branches 'clk-ingenic-fixes', 'clk-max9485', 'clk-pxa-32k-pll', 'clk-aspeed' and 'clk-imx6sll-gpio' into clk-next
      Merge branches 'clk-imx-critical', 'clk-tegra-bpmp', 'clk-tegra-124', 'clk-tegra-critical' and 'clk-tegra-emc-oob' into clk-next
      Merge branches 'clk-mvebu-spdx', 'clk-meson', 'clk-imx7d-mu', 'clk-imx-init-array-cleanup' and 'clk-rockchip' into clk-next
      Merge branches 'clk-qcom-rpmh', 'clk-qcom-spdx', 'clk-con-id-leak', 'clk-fixed-factor-populated' and 'clk-mvebu-periph-parent' into clk-next
      Merge branches 'clk-imx6-ocram', 'clk-missing-put', 'clk-tegra-sdmmc-jitter', 'clk-allwinner' and 'clk-uniphier' into clk-next
      Merge branches 'clk-actions-s700', 'clk-exynos-unused', 'clk-qcom-dispcc-845', 'clk-scmi-round' and 'clk-cs2000-spdx' into clk-next

Taniya Das (5):
      clk: qcom: Move frequency table macro to common file
      dt-bindings: clock: Introduce QCOM Display clock bindings
      clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
      clk: qcom: Update SPDX headers for common files
      clk: qcom: Add display clock controller driver for SDM845

Thierry Reding (2):
      clk: tegra: Make vic03 a child of pll_c3
      clk: tegra: Make vde a child of pll_c3

Yixun Lan (2):
      clk: meson-axg: add pcie and mipi clock bindings
      clk: meson-axg: add clocks required by pcie driver

 .../{actions,s900-cmu.txt => actions,owl-cmu.txt}  |   20 +-
 .../bindings/clock/amlogic,axg-audio-clkc.txt      |   56 ++
 .../devicetree/bindings/clock/at91-clock.txt       |   35 +
 .../devicetree/bindings/clock/maxim,max9485.txt    |   59 ++
 .../devicetree/bindings/clock/qcom,dispcc.txt      |   19 +
 .../bindings/clock/renesas,r9a06g032-sysctrl.txt   |   43 +
 .../bindings/clock/rockchip,px30-cru.txt           |   65 ++
 .../devicetree/bindings/clock/sun8i-de2.txt        |    1 +
 arch/arm/mach-at91/Kconfig                         |    4 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/actions/Kconfig                        |    7 +
 drivers/clk/actions/Makefile                       |    1 +
 drivers/clk/actions/owl-s700.c                     |  606 ++++++++++++
 drivers/clk/at91/Makefile                          |    1 +
 drivers/clk/at91/clk-i2s-mux.c                     |  116 +++
 drivers/clk/clk-aspeed.c                           |    2 +-
 drivers/clk/clk-cs2000-cp.c                        |    5 +-
 drivers/clk/clk-fixed-factor.c                     |    9 +-
 drivers/clk/clk-max9485.c                          |  387 ++++++++
 drivers/clk/clk-scmi.c                             |    5 +-
 drivers/clk/clk-si514.c                            |   38 +-
 drivers/clk/clk-si544.c                            |   38 +-
 drivers/clk/clk.c                                  |  218 +++-
 drivers/clk/imx/clk-imx51-imx53.c                  |   44 +-
 drivers/clk/imx/clk-imx6q.c                        |   16 +-
 drivers/clk/imx/clk-imx6sl.c                       |   12 -
 drivers/clk/imx/clk-imx6sll.c                      |    7 +
 drivers/clk/imx/clk-imx6sx.c                       |   41 +-
 drivers/clk/imx/clk-imx6ul.c                       |   29 +-
 drivers/clk/imx/clk-imx7d.c                        |    1 +
 drivers/clk/ingenic/jz4740-cgu.c                   |    4 +-
 drivers/clk/meson/Kconfig                          |   28 +-
 drivers/clk/meson/Makefile                         |    4 +-
 drivers/clk/meson/axg-audio.c                      |  845 ++++++++++++++++
 drivers/clk/meson/axg-audio.h                      |  127 +++
 drivers/clk/meson/axg.c                            |  244 ++++-
 drivers/clk/meson/axg.h                            |    8 +-
 drivers/clk/meson/clk-audio-divider.c              |  110 ---
 drivers/clk/meson/clk-phase.c                      |   63 ++
 drivers/clk/meson/clk-triphase.c                   |   68 ++
 drivers/clk/meson/clkc-audio.h                     |   28 +
 drivers/clk/meson/clkc.h                           |   11 +-
 drivers/clk/meson/gxbb.c                           |  119 ++-
 drivers/clk/meson/gxbb.h                           |    5 +-
 drivers/clk/meson/sclk-div.c                       |  243 +++++
 drivers/clk/mvebu/armada-37xx-periph.c             |    9 +-
 drivers/clk/pxa/clk-pxa25x.c                       |    6 +-
 drivers/clk/pxa/clk-pxa27x.c                       |    7 +-
 drivers/clk/pxa/clk-pxa3xx.c                       |    7 +-
 drivers/clk/qcom/Kconfig                           |   19 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   10 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |   14 +-
 drivers/clk/qcom/clk-branch.c                      |   10 +-
 drivers/clk/qcom/clk-branch.h                      |   14 +-
 drivers/clk/qcom/clk-rcg.h                         |    2 +
 drivers/clk/qcom/clk-regmap.c                      |   10 +-
 drivers/clk/qcom/clk-regmap.h                      |   14 +-
 drivers/clk/qcom/clk-rpmh.c                        |  329 +++++++
 drivers/clk/qcom/common.c                          |   10 +-
 drivers/clk/qcom/common.h                          |   15 +-
 drivers/clk/qcom/dispcc-sdm845.c                   |  685 +++++++++++++
 drivers/clk/qcom/gcc-apq8084.c                     |    2 -
 drivers/clk/qcom/gcc-ipq4019.c                     |    2 -
 drivers/clk/qcom/gcc-ipq806x.c                     |    3 -
 drivers/clk/qcom/gcc-ipq8074.c                     |    2 -
 drivers/clk/qcom/gcc-mdm9615.c                     |    2 -
 drivers/clk/qcom/gcc-msm8660.c                     |    5 -
 drivers/clk/qcom/gcc-msm8916.c                     |    2 -
 drivers/clk/qcom/gcc-msm8960.c                     |    5 -
 drivers/clk/qcom/gcc-msm8974.c                     |    2 -
 drivers/clk/qcom/gcc-msm8994.c                     |    2 -
 drivers/clk/qcom/gcc-msm8996.c                     |    2 -
 drivers/clk/qcom/gcc-msm8998.c                     |    2 -
 drivers/clk/qcom/gcc-sdm845.c                      |   45 +-
 drivers/clk/qcom/mmcc-apq8084.c                    |    2 -
 drivers/clk/qcom/mmcc-msm8974.c                    |    2 -
 drivers/clk/qcom/mmcc-msm8996.c                    |    2 -
 drivers/clk/qcom/videocc-sdm845.c                  |    2 -
 drivers/clk/renesas/Kconfig                        |    6 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    2 +
 drivers/clk/renesas/r9a06g032-clocks.c             |  893 +++++++++++++++++
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-half-divider.c            |  227 +++++
 drivers/clk/rockchip/clk-px30.c                    | 1039 ++++++++++++++++++++
 drivers/clk/rockchip/clk-rk3399.c                  |    3 +-
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |  126 ++-
 drivers/clk/samsung/clk-exynos4412-isp.c           |    2 -
 drivers/clk/socfpga/clk-s10.c                      |    9 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |   11 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |   58 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |    8 +-
 drivers/clk/tegra/Makefile                         |    2 +
 drivers/clk/tegra/clk-bpmp.c                       |   12 +-
 drivers/clk/tegra/clk-divider.c                    |   35 +-
 drivers/clk/tegra/clk-emc.c                        |    2 +-
 drivers/clk/tegra/clk-id.h                         |    2 -
 drivers/clk/tegra/clk-sdmmc-mux.c                  |  251 +++++
 drivers/clk/tegra/clk-tegra-periph.c               |   11 -
 drivers/clk/tegra/clk-tegra124.c                   |    3 +-
 drivers/clk/tegra/clk-tegra210.c                   |   14 +-
 drivers/clk/tegra/clk-utils.c                      |   43 +
 drivers/clk/tegra/clk.h                            |   30 +
 drivers/clk/uniphier/clk-uniphier-peri.c           |    9 +
 drivers/clk/uniphier/clk-uniphier-sys.c            |   58 +-
 include/dt-bindings/clock/actions,s700-cmu.h       |  118 +++
 include/dt-bindings/clock/aspeed-clock.h           |    2 +-
 include/dt-bindings/clock/axg-audio-clkc.h         |   94 ++
 include/dt-bindings/clock/axg-clkc.h               |    4 +
 include/dt-bindings/clock/gxbb-clkc.h              |    1 +
 include/dt-bindings/clock/imx6sll-clock.h          |    9 +-
 include/dt-bindings/clock/imx6ul-clock.h           |    8 +-
 include/dt-bindings/clock/maxim,max9485.h          |   18 +
 include/dt-bindings/clock/px30-cru.h               |  389 ++++++++
 include/dt-bindings/clock/pxa-clock.h              |    3 +-
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |   45 +
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |    2 +
 include/dt-bindings/clock/r9a06g032-sysctrl.h      |  148 +++
 include/dt-bindings/clock/sun8i-r40-ccu.h          |    4 +
 include/linux/clk-provider.h                       |   26 +
 include/linux/clk.h                                |   33 +
 include/trace/events/clk.h                         |   36 +
 125 files changed, 8269 insertions(+), 586 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (68%)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/maxim,max9485.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 drivers/clk/at91/clk-i2s-mux.c
 create mode 100644 drivers/clk/clk-max9485.c
 create mode 100644 drivers/clk/meson/axg-audio.c
 create mode 100644 drivers/clk/meson/axg-audio.h
 delete mode 100644 drivers/clk/meson/clk-audio-divider.c
 create mode 100644 drivers/clk/meson/clk-phase.c
 create mode 100644 drivers/clk/meson/clk-triphase.c
 create mode 100644 drivers/clk/meson/clkc-audio.h
 create mode 100644 drivers/clk/meson/sclk-div.c
 create mode 100644 drivers/clk/qcom/clk-rpmh.c
 create mode 100644 drivers/clk/qcom/dispcc-sdm845.c
 create mode 100644 drivers/clk/renesas/r9a06g032-clocks.c
 create mode 100644 drivers/clk/rockchip/clk-half-divider.c
 create mode 100644 drivers/clk/rockchip/clk-px30.c
 create mode 100644 drivers/clk/tegra/clk-sdmmc-mux.c
 create mode 100644 drivers/clk/tegra/clk-utils.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
 create mode 100644 include/dt-bindings/clock/axg-audio-clkc.h
 create mode 100644 include/dt-bindings/clock/maxim,max9485.h
 create mode 100644 include/dt-bindings/clock/px30-cru.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h
 create mode 100644 include/dt-bindings/clock/r9a06g032-sysctrl.h

-- 
Sent by a computer through tubes
