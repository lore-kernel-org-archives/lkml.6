Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934873AbeBMJqo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:46:44 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35525 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbeBMJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:46:38 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] clk: renesas: cpg-msr: Add support for R-Car M3-N
Date: Tue, 13 Feb 2018 10:45:49 +0100
Message-Id: <1518515162-23663-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for R-Car M3-N (r8a77965), including core and module
clocks.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   1 +
 drivers/clk/renesas/Kconfig                        |   5 +
 drivers/clk/renesas/Makefile                       |   1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            | 333 +++++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c             |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |   1 +
 include/dt-bindings/clock/r8a77965-cpg-mssr.h      |  62 ++++
 7 files changed, 409 insertions(+)
 create mode 100644 drivers/clk/renesas/r8a77965-cpg-mssr.c
 create mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
index f1890d0..246ab63 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -22,6 +22,7 @@ Required Properties:
       - "renesas,r8a7794-cpg-mssr" for the r8a7794 SoC (R-Car E2)
       - "renesas,r8a7795-cpg-mssr" for the r8a7795 SoC (R-Car H3)
       - "renesas,r8a7796-cpg-mssr" for the r8a7796 SoC (R-Car M3-W)
+      - "renesas,r8a77965-cpg-mssr" for the r8a77965 SoC (R-Car M3-N)
       - "renesas,r8a77970-cpg-mssr" for the r8a77970 SoC (R-Car V3M)
       - "renesas,r8a77995-cpg-mssr" for the r8a77995 SoC (R-Car D3)
 
diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 84b40b9..047d6b5 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -15,6 +15,7 @@ config CLK_RENESAS
 	select CLK_R8A7794 if ARCH_R8A7794
 	select CLK_R8A7795 if ARCH_R8A7795
 	select CLK_R8A7796 if ARCH_R8A7796
+	select CLK_R8A77965 if ARCH_R8A77965
 	select CLK_R8A77970 if ARCH_R8A77970
 	select CLK_R8A77995 if ARCH_R8A77995
 	select CLK_SH73A0 if ARCH_SH73A0
@@ -97,6 +98,10 @@ config CLK_R8A7796
 	bool "R-Car M3-W clock support" if COMPILE_TEST
 	select CLK_RCAR_GEN3_CPG
 
+config CLK_R8A77965
+	bool "R-Car M3-N clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN3_CPG
+
 config CLK_R8A77970
 	bool "R-Car V3M clock support" if COMPILE_TEST
 	select CLK_RCAR_GEN3_CPG
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 34c4e0b..2e0982f 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_R8A7792)		+= r8a7792-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A7794)		+= r8a7794-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A7795)		+= r8a7795-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A7796)		+= r8a7796-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A77965)		+= r8a77965-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A77970)		+= r8a77970-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A77995)		+= r8a77995-cpg-mssr.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
new file mode 100644
index 0000000..f29d42c
--- /dev/null
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * r8a77965 Clock Pulse Generator / Module Standby and Software Reset
+ *
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ *
+ * Based on r8a7795-cpg-mssr.c
+ *
+ * Copyright (C) 2015 Glider bvba
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/soc/renesas/rcar-rst.h>
+
+#include <dt-bindings/clock/r8a77965-cpg-mssr.h>
+
+#include "renesas-cpg-mssr.h"
+#include "rcar-gen3-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R8A77965_CLK_OSC,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+	CLK_EXTALR,
+
+	/* Internal Core Clocks */
+	CLK_MAIN,
+	CLK_PLL0,
+	CLK_PLL1,
+	CLK_PLL3,
+	CLK_PLL4,
+	CLK_PLL1_DIV2,
+	CLK_PLL1_DIV4,
+	CLK_S0,
+	CLK_S1,
+	CLK_S2,
+	CLK_S3,
+	CLK_SDSRC,
+	CLK_SSPSRC,
+	CLK_RINT,
+
+	/* Module Clocks */
+	MOD_CLK_BASE
+};
+
+static const struct cpg_core_clk r8a77965_core_clks[] __initconst = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal",      CLK_EXTAL),
+	DEF_INPUT("extalr",     CLK_EXTALR),
+
+	/* Internal Core Clocks */
+	DEF_BASE(".main",	CLK_MAIN, CLK_TYPE_GEN3_MAIN, CLK_EXTAL),
+	DEF_BASE(".pll0",	CLK_PLL0, CLK_TYPE_GEN3_PLL0, CLK_MAIN),
+	DEF_BASE(".pll1",	CLK_PLL1, CLK_TYPE_GEN3_PLL1, CLK_MAIN),
+	DEF_BASE(".pll3",	CLK_PLL3, CLK_TYPE_GEN3_PLL3, CLK_MAIN),
+	DEF_BASE(".pll4",	CLK_PLL4, CLK_TYPE_GEN3_PLL4, CLK_MAIN),
+
+	DEF_FIXED(".pll1_div2", CLK_PLL1_DIV2,		CLK_PLL1,	2, 1),
+	DEF_FIXED(".pll1_div4", CLK_PLL1_DIV4,		CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s0",	CLK_S0,			CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s1",	CLK_S1,			CLK_PLL1_DIV2,	3, 1),
+	DEF_FIXED(".s2",	CLK_S2,			CLK_PLL1_DIV2,	4, 1),
+	DEF_FIXED(".s3",	CLK_S3,			CLK_PLL1_DIV2,	6, 1),
+	DEF_FIXED(".sdsrc",	CLK_SDSRC,		CLK_PLL1_DIV2,	2, 1),
+
+	/* Core Clock Outputs */
+	DEF_FIXED("ztr",	R8A77965_CLK_ZTR,	CLK_PLL1_DIV2,	6, 1),
+	DEF_FIXED("ztrd2",	R8A77965_CLK_ZTRD2,	CLK_PLL1_DIV2,	12, 1),
+	DEF_FIXED("zt",		R8A77965_CLK_ZT,	CLK_PLL1_DIV2,	4, 1),
+	DEF_FIXED("zx",		R8A77965_CLK_ZX,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED("s0d1",	R8A77965_CLK_S0D1,	CLK_S0,		1, 1),
+	DEF_FIXED("s0d2",	R8A77965_CLK_S0D2,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d3",	R8A77965_CLK_S0D3,	CLK_S0,		3, 1),
+	DEF_FIXED("s0d4",	R8A77965_CLK_S0D4,	CLK_S0,		4, 1),
+	DEF_FIXED("s0d6",	R8A77965_CLK_S0D6,	CLK_S0,		6, 1),
+	DEF_FIXED("s0d8",	R8A77965_CLK_S0D8,	CLK_S0,		8, 1),
+	DEF_FIXED("s0d12",	R8A77965_CLK_S0D12,	CLK_S0,		12, 1),
+	DEF_FIXED("s1d1",	R8A77965_CLK_S1D1,	CLK_S1,		1, 1),
+	DEF_FIXED("s1d2",	R8A77965_CLK_S1D2,	CLK_S1,		2, 1),
+	DEF_FIXED("s1d4",	R8A77965_CLK_S1D4,	CLK_S1,		4, 1),
+	DEF_FIXED("s2d1",	R8A77965_CLK_S2D1,	CLK_S2,		1, 1),
+	DEF_FIXED("s2d2",	R8A77965_CLK_S2D2,	CLK_S2,		2, 1),
+	DEF_FIXED("s2d4",	R8A77965_CLK_S2D4,	CLK_S2,		4, 1),
+	DEF_FIXED("s3d1",	R8A77965_CLK_S3D1,	CLK_S3,		1, 1),
+	DEF_FIXED("s3d2",	R8A77965_CLK_S3D2,	CLK_S3,		2, 1),
+	DEF_FIXED("s3d4",	R8A77965_CLK_S3D4,	CLK_S3,		4, 1),
+
+	DEF_GEN3_SD("sd0",	R8A77965_CLK_SD0,	CLK_SDSRC,	0x074),
+	DEF_GEN3_SD("sd1",	R8A77965_CLK_SD1,	CLK_SDSRC,	0x078),
+	DEF_GEN3_SD("sd2",	R8A77965_CLK_SD2,	CLK_SDSRC,	0x268),
+	DEF_GEN3_SD("sd3",	R8A77965_CLK_SD3,	CLK_SDSRC,	0x26c),
+
+	DEF_FIXED("cl",		R8A77965_CLK_CL,	CLK_PLL1_DIV2,	48, 1),
+	DEF_FIXED("cp",		R8A77965_CLK_CP,	CLK_EXTAL,	2, 1),
+
+	DEF_DIV6P1("canfd",	R8A77965_CLK_CANFD,	CLK_PLL1_DIV4,	0x244),
+	DEF_DIV6P1("csi0",	R8A77965_CLK_CSI0,	CLK_PLL1_DIV4,	0x00c),
+	DEF_DIV6P1("mso",	R8A77965_CLK_MSO,	CLK_PLL1_DIV4,	0x014),
+	DEF_DIV6P1("hdmi",	R8A77965_CLK_HDMI,	CLK_PLL1_DIV4,	0x250),
+
+	DEF_DIV6_RO("osc",	R8A77965_CLK_OSC, CLK_EXTAL, CPG_RCKCR, 8),
+	DEF_DIV6_RO("r_int",	CLK_RINT, CLK_EXTAL, CPG_RCKCR, 32),
+
+	DEF_BASE("r",		R8A77965_CLK_R,	CLK_TYPE_GEN3_R, CLK_RINT),
+};
+
+static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
+	DEF_MOD("scif5",		202,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif4",		203,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif3",		204,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif1",		206,	R8A77965_CLK_S3D4),
+	DEF_MOD("scif0",		207,	R8A77965_CLK_S3D4),
+	DEF_MOD("sys-dmac2",		217,	R8A77965_CLK_S0D3),
+	DEF_MOD("sys-dmac1",		218,	R8A77965_CLK_S0D3),
+	DEF_MOD("sys-dmac0",		219,	R8A77965_CLK_S0D3),
+
+	DEF_MOD("cmt3",			300,	R8A77965_CLK_R),
+	DEF_MOD("cmt2",			301,	R8A77965_CLK_R),
+	DEF_MOD("cmt1",			302,	R8A77965_CLK_R),
+	DEF_MOD("cmt0",			303,	R8A77965_CLK_R),
+	DEF_MOD("scif2",		310,	R8A77965_CLK_S3D4),
+	DEF_MOD("sdif3",		311,	R8A77965_CLK_SD3),
+	DEF_MOD("sdif2",		312,	R8A77965_CLK_SD2),
+	DEF_MOD("sdif1",		313,	R8A77965_CLK_SD1),
+	DEF_MOD("sdif0",		314,	R8A77965_CLK_SD0),
+	DEF_MOD("pcie1",		318,	R8A77965_CLK_S3D1),
+	DEF_MOD("pcie0",		319,	R8A77965_CLK_S3D1),
+	DEF_MOD("usb3-if0",		328,	R8A77965_CLK_S3D1),
+	DEF_MOD("usb-dmac0",		330,	R8A77965_CLK_S3D1),
+	DEF_MOD("usb-dmac1",		331,	R8A77965_CLK_S3D1),
+
+	DEF_MOD("rwdt",			402,	R8A77965_CLK_R),
+	DEF_MOD("intc-ex",		407,	R8A77965_CLK_CP),
+	DEF_MOD("intc-ap",		408,	R8A77965_CLK_S3D1),
+
+	DEF_MOD("audmac1",		501,	R8A77965_CLK_S0D3),
+	DEF_MOD("audmac0",		502,	R8A77965_CLK_S0D3),
+	DEF_MOD("drif7",		508,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif6",		509,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif5",		510,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif4",		511,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif3",		512,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif2",		513,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif1",		514,	R8A77965_CLK_S3D2),
+	DEF_MOD("drif0",		515,	R8A77965_CLK_S3D2),
+	DEF_MOD("hscif4",		516,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif3",		517,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif2",		518,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif1",		519,	R8A77965_CLK_S3D1),
+	DEF_MOD("hscif0",		520,	R8A77965_CLK_S3D1),
+	DEF_MOD("thermal",		522,	R8A77965_CLK_CP),
+	DEF_MOD("pwm",			523,	R8A77965_CLK_S0D12),
+
+	DEF_MOD("fcpvd1",		602,	R8A77965_CLK_S0D2),
+	DEF_MOD("fcpvd0",		603,	R8A77965_CLK_S0D2),
+	DEF_MOD("fcpvb0",		607,	R8A77965_CLK_S0D1),
+	DEF_MOD("fcpvi0",		611,	R8A77965_CLK_S0D1),
+	DEF_MOD("fcpf0",		615,	R8A77965_CLK_S0D1),
+	DEF_MOD("fcpcs",		619,	R8A77965_CLK_S0D2),
+	DEF_MOD("vspd1",		622,	R8A77965_CLK_S0D2),
+	DEF_MOD("vspd0",		623,	R8A77965_CLK_S0D2),
+	DEF_MOD("vspb",			626,	R8A77965_CLK_S0D1),
+	DEF_MOD("vspi0",		631,	R8A77965_CLK_S0D1),
+
+	DEF_MOD("ehci1",		702,	R8A77965_CLK_S3D4),
+	DEF_MOD("ehci0",		703,	R8A77965_CLK_S3D4),
+	DEF_MOD("hsusb",		704,	R8A77965_CLK_S3D4),
+	DEF_MOD("csi20",		714,	R8A77965_CLK_CSI0),
+	DEF_MOD("csi40",		716,	R8A77965_CLK_CSI0),
+	DEF_MOD("du2",			722,	R8A77965_CLK_S2D1),
+	DEF_MOD("du1",			723,	R8A77965_CLK_S2D1),
+	DEF_MOD("du0",			724,	R8A77965_CLK_S2D1),
+	DEF_MOD("lvds",			727,	R8A77965_CLK_S2D1),
+	DEF_MOD("hdmi0",		729,	R8A77965_CLK_HDMI),
+
+	DEF_MOD("vin7",			804,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin6",			805,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin5",			806,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin4",			807,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin3",			808,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin2",			809,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin1",			810,	R8A77965_CLK_S0D2),
+	DEF_MOD("vin0",			811,	R8A77965_CLK_S0D2),
+	DEF_MOD("etheravb",		812,	R8A77965_CLK_S0D6),
+	DEF_MOD("imr1",			822,	R8A77965_CLK_S0D2),
+	DEF_MOD("imr0",			823,	R8A77965_CLK_S0D2),
+
+	DEF_MOD("gpio7",		905,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio6",		906,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio5",		907,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio4",		908,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio3",		909,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio2",		910,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio1",		911,	R8A77965_CLK_S3D4),
+	DEF_MOD("gpio0",		912,	R8A77965_CLK_S3D4),
+	DEF_MOD("can-fd",		914,	R8A77965_CLK_S3D2),
+	DEF_MOD("can-if1",		915,	R8A77965_CLK_S3D4),
+	DEF_MOD("can-if0",		916,	R8A77965_CLK_S3D4),
+	DEF_MOD("i2c6",			918,	R8A77965_CLK_S0D6),
+	DEF_MOD("i2c5",			919,	R8A77965_CLK_S0D6),
+	DEF_MOD("i2c-dvfs",		926,	R8A77965_CLK_CP),
+	DEF_MOD("i2c4",			927,	R8A77965_CLK_S0D6),
+	DEF_MOD("i2c3",			928,	R8A77965_CLK_S0D6),
+	DEF_MOD("i2c2",			929,	R8A77965_CLK_S3D2),
+	DEF_MOD("i2c1",			930,	R8A77965_CLK_S3D2),
+	DEF_MOD("i2c0",			931,	R8A77965_CLK_S3D2),
+
+	DEF_MOD("ssi-all",		1005,	R8A77965_CLK_S3D4),
+	DEF_MOD("ssi9",			1006,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi8",			1007,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi7",			1008,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi6",			1009,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi5",			1010,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi4",			1011,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi3",			1012,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi2",			1013,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi1",			1014,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi0",			1015,	MOD_CLK_ID(1005)),
+	DEF_MOD("scu-all",		1017,	R8A77965_CLK_S3D4),
+	DEF_MOD("scu-dvc1",		1018,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-dvc0",		1019,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-ctu1-mix1",	1020,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-ctu0-mix0",	1021,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src9",		1022,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src8",		1023,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src7",		1024,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src6",		1025,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src5",		1026,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src4",		1027,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src3",		1028,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src2",		1029,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src1",		1030,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src0",		1031,	MOD_CLK_ID(1017)),
+};
+
+static const unsigned int r8a77965_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
+};
+
+/*
+ * CPG Clock Data
+ */
+
+/*
+ *   MD		EXTAL		PLL0	PLL1	PLL3	PLL4
+ * 14 13 19 17	(MHz)
+ *-----------------------------------------------------------
+ * 0  0  0  0	16.66 x 1	x180	x192	x192	x144
+ * 0  0  0  1	16.66 x 1	x180	x192	x128	x144
+ * 0  0  1  0	Prohibited setting
+ * 0  0  1  1	16.66 x 1	x180	x192	x192	x144
+ * 0  1  0  0	20    x 1	x150	x160	x160	x120
+ * 0  1  0  1	20    x 1	x150	x160	x106	x120
+ * 0  1  1  0	Prohibited setting
+ * 0  1  1  1	20    x 1	x150	x160	x160	x120
+ * 1  0  0  0	25    x 1	x120	x128	x128	x96
+ * 1  0  0  1	25    x 1	x120	x128	x84	x96
+ * 1  0  1  0	Prohibited setting
+ * 1  0  1  1	25    x 1	x120	x128	x128	x96
+ * 1  1  0  0	33.33 / 2	x180	x192	x192	x144
+ * 1  1  0  1	33.33 / 2	x180	x192	x128	x144
+ * 1  1  1  0	Prohibited setting
+ * 1  1  1  1	33.33 / 2	x180	x192	x192	x144
+ */
+#define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 11) | \
+					 (((md) & BIT(13)) >> 11) | \
+					 (((md) & BIT(19)) >> 18) | \
+					 (((md) & BIT(17)) >> 17))
+
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
+	/* EXTAL div	PLL1 mult/div	PLL3 mult/div */
+	{ 1,		192,	1,	192,	1,	},
+	{ 1,		192,	1,	128,	1,	},
+	{ 0, /* Prohibited setting */			},
+	{ 1,		192,	1,	192,	1,	},
+	{ 1,		160,	1,	160,	1,	},
+	{ 1,		160,	1,	106,	1,	},
+	{ 0, /* Prohibited setting */			},
+	{ 1,		160,	1,	160,	1,	},
+	{ 1,		128,	1,	128,	1,	},
+	{ 1,		128,	1,	84,	1,	},
+	{ 0, /* Prohibited setting */			},
+	{ 1,		128,	1,	128,	1,	},
+	{ 2,		192,	1,	192,	1,	},
+	{ 2,		192,	1,	128,	1,	},
+	{ 0, /* Prohibited setting */			},
+	{ 2,		192,	1,	192,	1,	},
+};
+
+static int __init r8a77965_cpg_mssr_init(struct device *dev)
+{
+	const struct rcar_gen3_cpg_pll_config *cpg_pll_config;
+	u32 cpg_mode;
+	int error;
+
+	error = rcar_rst_read_mode_pins(&cpg_mode);
+	if (error)
+		return error;
+
+	cpg_pll_config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
+	if (!cpg_pll_config->extal_div) {
+		dev_err(dev, "Prohibited setting (cpg_mode=0x%x)\n", cpg_mode);
+		return -EINVAL;
+	}
+
+	return rcar_gen3_cpg_init(cpg_pll_config, CLK_EXTALR, cpg_mode);
+};
+
+const struct cpg_mssr_info r8a77965_cpg_mssr_info __initconst = {
+	/* Core Clocks */
+	.core_clks		= r8a77965_core_clks,
+	.num_core_clks		= ARRAY_SIZE(r8a77965_core_clks),
+	.last_dt_core_clk	= LAST_DT_CORE_CLK,
+	.num_total_core_clks	= MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks		= r8a77965_mod_clks,
+	.num_mod_clks		= ARRAY_SIZE(r8a77965_mod_clks),
+	.num_hw_mod_clks	= 12 * 32,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks		= r8a77965_crit_mod_clks,
+	.num_crit_mod_clks	= ARRAY_SIZE(r8a77965_crit_mod_clks),
+
+	/* Callbacks */
+	.init			= r8a77965_cpg_mssr_init,
+	.cpg_clk_register	= rcar_gen3_cpg_clk_register,
+};
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index e3cc72c..b4b7d36 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -693,6 +693,12 @@ static const struct of_device_id cpg_mssr_match[] = {
 		.data = &r8a7796_cpg_mssr_info,
 	},
 #endif
+#ifdef CONFIG_CLK_R8A77965
+	{
+		.compatible = "renesas,r8a77965-cpg-mssr",
+		.data = &r8a77965_cpg_mssr_info,
+	},
+#endif
 #ifdef CONFIG_CLK_R8A77970
 	{
 		.compatible = "renesas,r8a77970-cpg-mssr",
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index 0745b09..44397d3 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -139,6 +139,7 @@ extern const struct cpg_mssr_info r8a7792_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a7794_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a7795_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a7796_cpg_mssr_info;
+extern const struct cpg_mssr_info r8a77965_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a77970_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a77995_cpg_mssr_info;
 
diff --git a/include/dt-bindings/clock/r8a77965-cpg-mssr.h b/include/dt-bindings/clock/r8a77965-cpg-mssr.h
new file mode 100644
index 0000000..6d3b5a9
--- /dev/null
+++ b/include/dt-bindings/clock/r8a77965-cpg-mssr.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A77965_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_R8A77965_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* r8a77965 CPG Core Clocks */
+#define R8A77965_CLK_Z			0
+#define R8A77965_CLK_ZR			1
+#define R8A77965_CLK_ZG			2
+#define R8A77965_CLK_ZTR		3
+#define R8A77965_CLK_ZTRD2		4
+#define R8A77965_CLK_ZT			5
+#define R8A77965_CLK_ZX			6
+#define R8A77965_CLK_S0D1		7
+#define R8A77965_CLK_S0D2		8
+#define R8A77965_CLK_S0D3		9
+#define R8A77965_CLK_S0D4		10
+#define R8A77965_CLK_S0D6		11
+#define R8A77965_CLK_S0D8		12
+#define R8A77965_CLK_S0D12		13
+#define R8A77965_CLK_S1D1		14
+#define R8A77965_CLK_S1D2		15
+#define R8A77965_CLK_S1D4		16
+#define R8A77965_CLK_S2D1		17
+#define R8A77965_CLK_S2D2		18
+#define R8A77965_CLK_S2D4		19
+#define R8A77965_CLK_S3D1		20
+#define R8A77965_CLK_S3D2		21
+#define R8A77965_CLK_S3D4		22
+#define R8A77965_CLK_LB			23
+#define R8A77965_CLK_CL			24
+#define R8A77965_CLK_ZB3		25
+#define R8A77965_CLK_ZB3D2		26
+#define R8A77965_CLK_CR			27
+#define R8A77965_CLK_CRD2		28
+#define R8A77965_CLK_SD0H		29
+#define R8A77965_CLK_SD0		30
+#define R8A77965_CLK_SD1H		31
+#define R8A77965_CLK_SD1		32
+#define R8A77965_CLK_SD2H		33
+#define R8A77965_CLK_SD2		34
+#define R8A77965_CLK_SD3H		35
+#define R8A77965_CLK_SD3		36
+#define R8A77965_CLK_SSP2		37
+#define R8A77965_CLK_SSP1		38
+#define R8A77965_CLK_SSPRS		39
+#define R8A77965_CLK_RPC		40
+#define R8A77965_CLK_RPCD2		41
+#define R8A77965_CLK_MSO		42
+#define R8A77965_CLK_CANFD		43
+#define R8A77965_CLK_HDMI		44
+#define R8A77965_CLK_CSI0		45
+#define R8A77965_CLK_CP			46
+#define R8A77965_CLK_CPEX		47
+#define R8A77965_CLK_R			48
+#define R8A77965_CLK_OSC		49
+
+#endif /* __DT_BINDINGS_CLOCK_R8A77965_CPG_MSSR_H__ */
-- 
2.7.4
