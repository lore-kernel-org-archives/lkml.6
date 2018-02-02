Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBBOFQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:05:16 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1859 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752136AbeBBOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:41 -0500
From: <gabriel.fernandez@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>
Subject: [PATCH 01/14] dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
Date: Fri, 2 Feb 2018 15:03:29 +0100
Message-ID: <1517580222-23301-2-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The RCC block is responsible of the management of the clock and reset
generation for the complete circuit.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/mfd/st,stm32-rcc.txt       | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
new file mode 100644
index 0000000..28017a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
@@ -0,0 +1,85 @@
+STMicroelectronics STM32 Peripheral Reset Clock Controller
+==========================================================
+
+The RCC IP is both a reset and a clock controller.
+
+Please also refer to reset.txt for common reset controller binding usage.
+
+Please also refer to clock-bindings.txt for common clock controller
+binding usage.
+
+
+Required properties:
+- compatible: "simple-mfd", "syscon"
+- reg: should be register base and length as documented in the datasheet
+
+- Sub-nodes:
+  - compatible: "st,stm32mp1-rcc-clk"
+	- #clock-cells: 1, device nodes should specify the clock in their
+	  "clocks" property, containing a phandle to the clock device node,
+	  an index specifying the clock to use.
+
+  - compatible: "st,stm32mp1-rcc-rst"
+	- #reset-cells: Shall be 1
+
+Example:
+	rcc: rcc@50000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x50000000 0x1000>;
+
+		rcc_clk: rcc-clk@50000000 {
+			#clock-cells = <1>;
+			compatible = "st,stm32mp1-rcc-clk";
+		};
+
+		rcc_rst: rcc-reset@50000000 {
+			#reset-cells = <1>;
+			compatible = "st,stm32mp1-rcc-rst";
+		};
+	};
+
+Specifying clocks
+=================
+
+All available clocks are defined as preprocessor macros in
+dt-bindings/clock/stm32mp1-clks.h header and can be used in device
+tree sources.
+
+Example:
+
+	/* Accessing DMA1 clock */
+	... {
+		clocks = <&rcc_clk DMA1>
+	};
+
+	/* Accessing SPI6 kernel clock */
+	... {
+		clocks = <&rcc_clk SPI6_K>
+	};
+
+Specifying softreset control of devices
+=======================================
+
+Device nodes should specify the reset channel required in their "resets"
+property, containing a phandle to the reset device node and an index specifying
+which channel to use.
+The index is the bit number within the RCC registers bank, starting from RCC
+base address.
+It is calculated as: index = register_offset / 4 * 32 + bit_offset.
+Where bit_offset is the bit offset within the register.
+
+For example on STM32MP1, for LTDC reset:
+ ltdc = APB4_RSTSETR_offset / 4 * 32 + LTDC_bit_offset
+      = 0x180 / 4 * 32 + 0 = 3072
+
+The list of valid indices for STM32MP1 is available in:
+include/dt-bindings/reset-controller/stm32mp1-resets.h
+
+This file implements defines like:
+#define LTDC_R	3072
+
+example:
+
+	ltdc {
+		resets = <&rcc_rst LTDC_R>;
+	};
-- 
1.9.1
