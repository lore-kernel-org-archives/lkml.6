Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeEPMxf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:53:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeEPMvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:51:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29E89609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com,
        sricharan@codeaurora.org
Subject: [PATCH V6 11/12] ARM: dts: ipq8074: Add pcie nodes
Date: Wed, 16 May 2018 18:20:03 +0530
Message-Id: <1526475004-10341-12-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
References: <1526475004-10341-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver/phy support for ipq8074 is available now.
So enabling the nodes in DT.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 157 +++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index bd58ab4..1822698 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -24,7 +24,7 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
-		pinctrl@1000000 {
+		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq8074-pinctrl";
 			reg = <0x1000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
@@ -278,6 +278,161 @@
 			pinctrl-names = "default";
 			status = "disabled";
 		};
+
+		pcie_phy0: phy@86000 {
+			compatible = "qcom,ipq8074-qmp-pcie-phy";
+			reg = <0x86000 0x1000>;
+			#phy-cells = <0>;
+			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+			clock-names = "pipe_clk";
+			clock-output-names = "pcie20_phy0_pipe_clk";
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				<&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+			status = "disabled";
+		};
+
+		pcie0: pci@20000000 {
+			compatible = "qcom,pcie-ipq8074";
+			reg =  <0x20000000 0xf1d
+				0x20000f20 0xa8
+				0x80000 0x2000
+				0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_phy0>;
+			phy-names = "pciephy";
+
+			ranges = <0x81000000 0 0x20200000 0x20200000
+				  0 0x100000   /* downstream I/O */
+				  0x82000000 0 0x20300000 0x20300000
+				  0 0xd00000>; /* non-prefetchable memory */
+
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 75
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>;
+
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux";
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_SLEEP_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky";
+			status = "disabled";
+		};
+
+		pcie_phy1: phy@8e000 {
+			compatible = "qcom,ipq8074-qmp-pcie-phy";
+			reg = <0x8e000 0x1000>;
+			#phy-cells = <0>;
+			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+			clock-names = "pipe_clk";
+			clock-output-names = "pcie20_phy1_pipe_clk";
+
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				<&gcc GCC_PCIE1PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+			status = "disabled";
+		};
+
+		pcie1: pci@10000000 {
+			compatible = "qcom,pcie-ipq8074";
+			reg =  <0x10000000 0xf1d
+				0x10000f20 0xa8
+				0x88000 0x2000
+				0x10100000 0x1000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_phy1>;
+			phy-names = "pciephy";
+
+			ranges = <0x81000000 0 0x10200000 0x10200000
+				  0 0x100000   /* downstream I/O */
+				  0x82000000 0 0x10300000 0x10300000
+				  0 0xd00000>; /* non-prefetchable memory */
+
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 142
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 143
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 144
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 145
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux";
+			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+				 <&gcc GCC_PCIE1_SLEEP_ARES>,
+				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE1_AHB_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky";
+			status = "disabled";
+		};
 	};
 
 	cpus {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
