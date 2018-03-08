Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeCHQyq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:54:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57358 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932131AbeCHQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:54:43 -0500
From: <gabriel.fernandez@st.com>
To: <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: [PATCH v2 01/12] dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
Date: Thu, 8 Mar 2018 17:53:54 +0100
Message-ID: <1520528045-18330-2-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The RCC block is responsible of the management of the clock and reset
generation for the complete circuit.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
new file mode 100644
index 0000000..fb9495e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
@@ -0,0 +1,60 @@
+STMicroelectronics STM32 Peripheral Reset Clock Controller
+==========================================================
+
+The RCC IP is both a reset and a clock controller.
+
+RCC makes also power management (resume/supend and wakeup interrupt).
+
+Please also refer to reset.txt for common reset controller binding usage.
+
+Please also refer to clock-bindings.txt for common clock controller
+binding usage.
+
+
+Required properties:
+- compatible: "st,stm32mp1-rcc", "syscon"
+- reg: should be register base and length as documented in the datasheet
+- #clock-cells: 1, device nodes should specify the clock in their
+  "clocks" property, containing a phandle to the clock device node,
+  an index specifying the clock to use.
+- #reset-cells: Shall be 1
+- interrupts: Should contain a general interrupt line and a interrupt line
+  to the wake-up of processor (CSTOP).
+
+Example:
+	rcc: rcc@50000000 {
+		compatible = "st,stm32mp1-rcc", "syscon";
+		reg = <0x50000000 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>,
+			     <GIC_SPI 145 IRQ_TYPE_NONE>;
+	};
+
+Specifying clocks
+=================
+
+All available clocks are defined as preprocessor macros in
+dt-bindings/clock/stm32mp1-clks.h header and can be used in device
+tree sources.
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
-- 
1.9.1
