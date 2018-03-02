Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428881AbeCBO5M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:57:12 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39599 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1426510AbeCBO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:57:07 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: add support for STM32 USB PHY Controller (USBPHYC)
Date: Fri, 2 Mar 2018 15:56:24 +0100
Message-ID: <1520002585-13113-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520002585-13113-1-git-send-email-amelie.delaunay@st.com>
References: <1520002585-13113-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings description for STM32 USBPHYC
(USB PHY Controller).

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
new file mode 100644
index 0000000..725ae71
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
@@ -0,0 +1,73 @@
+STMicroelectronics STM32 USB HS PHY controller
+
+The STM32 USBPHYC block contains a dual port High Speed UTMI+ PHY and a UTMI
+switch. It controls PHY configuration and status, and the UTMI+ switch that
+selects either OTG or HOST controller for the second PHY port. It also sets
+PLL configuration.
+
+USBPHYC
+      |_ PLL
+      |
+      |_ PHY port#1 _________________ HOST controller
+      |                    _                 |
+      |                  / 1|________________|
+      |_ PHY port#2 ----|   |________________
+      |                  \_0|                |
+      |_ UTMI switch_______|          OTG controller
+
+
+Phy provider node
+=================
+
+Required properties:
+- compatible: must be "st,stm32mp1-usbphyc"
+- reg: address and length of the usb phy control register set
+- clocks: phandle + clock specifier for the PLL phy clock
+- #address-cells: number of address cells for phys sub-nodes, must be <1>
+- #size-cells: number of size cells for phys sub-nodes, must be <0>
+
+Optional properties:
+- assigned-clocks: phandle + clock specifier for the PLL phy clock
+- assigned-clock-parents: the PLL phy clock parent
+- resets: phandle + reset specifier
+
+Required nodes: one sub-node per port the controller provides.
+
+Phy sub-nodes
+==============
+
+Required properties:
+- reg: phy port index
+- phy-supply: phandle to the regulator providing 3V3 power to the PHY,
+	      see phy-bindings.txt in the same directory.
+- vdda1v1-supply: phandle to the regulator providing 1V1 power to the PHY
+- vdda1v8-supply: phandle to the regulator providing 1V8 power to the PHY
+- #phy-cells: see phy-bindings.txt in the same directory, must be <0> for PHY
+  port#1 and must be <1> for PHY port#2, to select USB controller
+
+
+Example:
+		usbphyc: usb-phy@5a006000 {
+			compatible = "st,stm32mp1-usbphyc";
+			reg = <0x5a006000 0x1000>;
+			clocks = <&rcc_clk USBPHY_K>;
+			resets = <&rcc_rst USBPHY_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usbphyc_port0: usb-phy@0 {
+				reg = <0>;
+				phy-supply = <&vdd_usb>;
+				vdda1v1-supply = <&reg11>;
+				vdda1v8-supply = <&reg18>
+				#phy-cells = <0>;
+			};
+
+			usbphyc_port1: usb-phy@1 {
+				reg = <1>;
+				phy-supply = <&vdd_usb>;
+				vdda1v1-supply = <&reg11>;
+				vdda1v8-supply = <&reg18>
+				#phy-cells = <1>;
+			};
+		};
-- 
2.7.4
