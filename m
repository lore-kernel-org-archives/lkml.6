Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeCTNnW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:43:22 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:58801 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753501AbeCTNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:43:01 -0400
From: tali.perry1@gmail.com
To: brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com, tmaimon77@gmail.com,
        raltherr@google.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v11 1/2] dt-binding: clk: npcm750: Add binding for Nuvoton NPCM7XX Clock
Date: Tue, 20 Mar 2018 15:40:48 +0200
Message-Id: <1521553249-6971-2-git-send-email-tali.perry1@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1521553249-6971-1-git-send-email-tali.perry1@gmail.com>
References: <1521553249-6971-1-git-send-email-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tali Perry <tali.perry1@gmail.com>

* Nuvoton NPCM7XX Clock Controller

Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
generates and supplies clocks to all modules within the BMC.

---

10 ==> 11
update documentation. "eth" replaced with "ethernet" in use case eaxample.

2 ==> 10
update documentation. add external clocks as inputs to clk driver.
fix SPDX comment.

1 ==> 2
This patch includes fix request described here:
https://patchwork.kernel.org/patch/10200033/
(move fixed clocks to DT)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>


 .../bindings/clock/nuvoton,npcm750-clk.txt         | 100 +++++++++++++++++++++
 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |  44 +++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt b/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
new file mode 100644
index 000000000000..f82064546d11
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
@@ -0,0 +1,100 @@
+* Nuvoton NPCM7XX Clock Controller
+
+Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
+generates and supplies clocks to all modules within the BMC.
+
+External clocks:
+
+There are six fixed clocks that are generated outside the BMC. All clocks are of
+a known fixed value that cannot be changed. clk_refclk, clk_mcbypck and
+clk_sysbypck are inputs to the clock controller.
+clk_rg1refck, clk_rg2refck and clk_xin are external clocks suppling the
+network. They are set on the device tree, but not used by the clock module. The
+network devices use them directly.
+Example can be found below.
+
+All available clocks are defined as preprocessor macros in:
+dt-bindings/clock/nuvoton,npcm7xx-clock.h
+and can be reused as DT sources.
+
+Required Properties of clock controller:
+
+	- compatible: "nuvoton,npcm750-clk" : for clock controller of Nuvoton
+		  Poleg BMC NPCM750
+
+	- reg: physical base address of the clock controller and length of
+		memory mapped region.
+
+	- #clock-cells: should be 1.
+
+Example: Clock controller node:
+
+	clk: clock-controller@f0801000 {
+		compatible = "nuvoton,npcm750-clk";
+		#clock-cells = <1>;
+		reg = <0xf0801000 0x1000>;
+		clock-names = "refclk", "sysbypck", "mcbypck";
+		clocks = <&clk_refclk>, <&clk_sysbypck>, <&clk_mcbypck>;
+	};
+
+Example: Required external clocks for network:
+
+	/* external reference clock */
+	clk_refclk: clk-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "refclk";
+	};
+
+	/* external reference clock for cpu. float in normal operation */
+	clk_sysbypck: clk-sysbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "sysbypck";
+	};
+
+	/* external reference clock for MC. float in normal operation */
+	clk_mcbypck: clk-mcbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "mcbypck";
+	};
+
+	 /* external clock signal rg1refck, supplied by the phy */
+	clk_rg1refck: clk-rg1refck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_rg1refck";
+	};
+
+	 /* external clock signal rg2refck, supplied by the phy */
+	clk_rg2refck: clk-rg2refck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_rg2refck";
+	};
+
+	clk_xin: clk-xin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "clk_xin";
+	};
+
+
+Example: GMAC controller node that consumes two clocks: a generated clk by the
+clock controller and a fixed clock from DT (clk_rg1refck).
+
+	ethernet0: ethernet@f0802000 {
+		compatible = "snps,dwmac";
+		reg = <0xf0802000 0x2000>;
+		interrupts = <0 14 4>;
+		interrupt-names = "macirq";
+		clocks	= <&clk_rg1refck>, <&clk NPCM7XX_CLK_AHB>;
+		clock-names = "stmmaceth", "clk_gmac";
+	};
diff --git a/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
new file mode 100644
index 000000000000..f21522605b94
--- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Nuvoton NPCM7xx Clock Generator binding
+ * clock binding number for all clocks supportted by nuvoton,npcm7xx-clk
+ *
+ * Copyright (C) 2018 Nuvoton Technologies tali.perry@nuvoton.com
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_NPCM7XX_H
+#define __DT_BINDINGS_CLOCK_NPCM7XX_H
+
+
+#define NPCM7XX_CLK_CPU 0
+#define NPCM7XX_CLK_GFX_PIXEL 1
+#define NPCM7XX_CLK_MC 2
+#define NPCM7XX_CLK_ADC 3
+#define NPCM7XX_CLK_AHB 4
+#define NPCM7XX_CLK_TIMER 5
+#define NPCM7XX_CLK_UART 6
+#define NPCM7XX_CLK_MMC  7
+#define NPCM7XX_CLK_SPI3 8
+#define NPCM7XX_CLK_PCI  9
+#define NPCM7XX_CLK_AXI 10
+#define NPCM7XX_CLK_APB4 11
+#define NPCM7XX_CLK_APB3 12
+#define NPCM7XX_CLK_APB2 13
+#define NPCM7XX_CLK_APB1 14
+#define NPCM7XX_CLK_APB5 15
+#define NPCM7XX_CLK_CLKOUT 16
+#define NPCM7XX_CLK_GFX  17
+#define NPCM7XX_CLK_SU   18
+#define NPCM7XX_CLK_SU48 19
+#define NPCM7XX_CLK_SDHC 20
+#define NPCM7XX_CLK_SPI0 21
+#define NPCM7XX_CLK_SPIX 22
+
+#define NPCM7XX_CLK_REFCLK 23
+#define NPCM7XX_CLK_SYSBYPCK 24
+#define NPCM7XX_CLK_MCBYPCK 25
+
+#define NPCM7XX_NUM_CLOCKS	 (NPCM7XX_CLK_MCBYPCK+1)
+
+#endif
-- 
2.14.1
