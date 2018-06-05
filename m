Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeFEIfr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:35:47 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:43334 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751361AbeFEIfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:35:44 -0400
X-IronPort-AV: E=Sophos;i="5.49,478,1520866800";
   d="scan'208";a="283073070"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] arm: Base support for Renesas RZN1D-DB Board
Date: Tue,  5 Jun 2018 09:29:56 +0100
Message-Id: <1528187462-47093-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the plain basic support for booting a bare
kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
minimum as a 'base', further patches that could add the
rest of the support.

Note on the clock driver: Current usage of the clocks on Linux
involves Linux 'claiming' all of them, disabling the one it doesn't
need and so on.
On *this* architecture it can't be done, there is at least one other
OS running on the CM3 core that claims it's own clock; Linux can claim
some others but definitely not start disabling stuff it isn't supposed to.

Thanks for the comments on the previous versions!

v8:
 + Added Reviewed mentions as appropriate.
 + Moved some of the clocks #defines into the driver
 + Tweaked the pointer arithmetics in the clock driver.
 + Removed clk_readl/writel
 + Use CLK_IS_CRITICAL instead of my own flag
 + Also added that critical section to the dualgate object.
 + Few other nitpicks fixed.
 + Rebased on next-20180604
v7:
 + Removed mention of 'rz[/]n1' from everywhere.
 + Removed unwanted documentation.
 + Renamed clock node back to sysctrl.
 + Renamed rzn1-clocks.h to r9a06g032-sysctrl.h to match
 + Made the clock driver claim the sysctrl node.
 + Fixed a couple of 'sparse' warning in the clock driver.
v6:
 + Fix for suggestion by Geert Uytterhoeven
 + Removed "renesas,rzn1" from the board bindings
 + Removed patches already merged.
 + Removed reboot driver
 + Added a whole clock infrastructure.
 + Rebased on next-20180517
v5:
 + Given the problems I have with getting in some structure around the
   sysctrl block, I've removed the MFD, I've now attached the reboot
   driver on it's  own pair of registers.
 + Rebased on next-20180417
v4:
 + Fixes for suggestions by Simon Horman
 + Fixes for suggestions by Jacopo Mondi
 + Fixes for suggestions by Geert Uytterhoeven
 + Renamed the r9a06g0xx.dtsi file, given up on trying to get a family
   common file in, so dropped potential RZ/N1S support and now only
   focus on RZ/N1D for this patchset.
 + Added 'always-on' to the architected timer node, because it is.
 + Added ARCH_R9A06G032, to match others patterns like RCAR
 + Sorted the .dts files, added empty lines as required.
 + Fixed patch prefixes to match git-log for bindings&dts
 + Merged board .dts & Makefile changes together
 + Rebased on next-20180410
v3:
 + Fixes for suggestions by Geert Uytterhoeven
 + Removed SoC Specific renesas,r9a06g032-xxx, as it's not needed for now.
 + Kept renesas,rzn1 as a family/generic for this family.
 + Fixed a couple of the commit messages.
 + Added Geert's Reviewed-By where appropriate.
v2:
 + Fixes for suggestions by Simon Horman
 + Fixes for suggestions by Rob Herring
 + Fixes for suggestions by Geert Uytterhoeven
 + Removed the mach file
 + Added a MFD base for the sysctrl block
 + Added a regmap based sub driver for the reboot handler
 + Renamed the files to match shmobile conventions
 + Adapted the compatible= strings to reflect 'family' vs 'part'
   distinction.
 + Removed the sysctrl.h file entirelly.
 + Fixed every warnings from the DTC compiler on W=12 mode.
 + Split the device-tree patches from the code.

Michel Pollet (5):
  dt-bindings: Add the r9a06g032-sysctrl.h file
  dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
  ARM: dts: Renesas R9A06G032 base device tree file
  ARM: dts: Renesas RZN1D-DB Board base file
  clk: renesas: Renesas R9A06G032 clock driver

 .../bindings/clock/renesas,r9a06g032-sysctrl.txt   |  32 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  28 +
 arch/arm/boot/dts/r9a06g032.dtsi                   |  86 +++
 drivers/clk/renesas/Kconfig                        |   6 +
 drivers/clk/renesas/Makefile                       |   1 +
 drivers/clk/renesas/r9a06g032-clocks.c             | 853 +++++++++++++++++++++
 include/dt-bindings/clock/r9a06g032-sysctrl.h      | 148 ++++
 8 files changed, 1155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
 create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi
 create mode 100644 drivers/clk/renesas/r9a06g032-clocks.c
 create mode 100644 include/dt-bindings/clock/r9a06g032-sysctrl.h

-- 
2.7.4
