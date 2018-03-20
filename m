Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCTD7c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:59:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeCTD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:59:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38B2D60F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com
Cc: sricharan@codeaurora.org
Subject: [PATCH v3 02/13] ARM: dts: ipq4019: Add a few peripheral nodes
Date: Tue, 20 Mar 2018 09:28:45 +0530
Message-Id: <1521518336-5467-3-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with the driver updates for some peripherals being there,
add i2c, spi, pcie, bam, qpic-nand, scm nodes to enhance the available
peripheral support.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 134 ++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 10d112a..3a7127c 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -25,7 +25,9 @@
 
 	aliases {
 		spi0 = &spi_0;
+		spi1 = &spi_1;
 		i2c0 = &i2c_0;
+		i2c1 = &i2c_1;
 	};
 
 	cpus {
@@ -104,6 +106,12 @@
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-ipq4019";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 2 0xf08>,
@@ -172,6 +180,22 @@
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi_1: spi@78b6000 { /* BLSP1 QUP2 */
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x78b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -184,9 +208,24 @@
 			clock-names = "iface", "core";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dmas = <&blsp_dma 9>, <&blsp_dma 8>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
+		i2c_1: i2c@78b8000 { /* BLSP1 QUP4 */
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
 
 		cryptobam: dma@8e04000 {
 			compatible = "qcom,bam-v1.7.0";
@@ -293,6 +332,101 @@
 			reg = <0x4ab000 0x4>;
 		};
 
+		pcie0: pci@40000000 {
+			compatible = "qcom,pcie-ipq4019", "snps,dw-pcie";
+			reg =  <0x40000000 0xf1d
+				0x40000f20 0xa8
+				0x80000 0x2000
+				0x40100000 0x1000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
+				  0x82000000 0 0x48000000 0x48000000 0 0x10000000>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			clocks = <&gcc GCC_PCIE_AHB_CLK>,
+				 <&gcc GCC_PCIE_AXI_M_CLK>,
+				 <&gcc GCC_PCIE_AXI_S_CLK>;
+			clock-names = "aux",
+				      "master_bus",
+				      "slave_bus";
+
+			resets = <&gcc PCIE_AXI_M_ARES>,
+				 <&gcc PCIE_AXI_S_ARES>,
+				 <&gcc PCIE_PIPE_ARES>,
+				 <&gcc PCIE_AXI_M_VMIDMT_ARES>,
+				 <&gcc PCIE_AXI_S_XPU_ARES>,
+				 <&gcc PCIE_PARF_XPU_ARES>,
+				 <&gcc PCIE_PHY_ARES>,
+				 <&gcc PCIE_AXI_M_STICKY_ARES>,
+				 <&gcc PCIE_PIPE_STICKY_ARES>,
+				 <&gcc PCIE_PWR_ARES>,
+				 <&gcc PCIE_AHB_ARES>,
+				 <&gcc PCIE_PHY_AHB_ARES>;
+			reset-names = "axi_m",
+				      "axi_s",
+				      "pipe",
+				      "axi_m_vmid",
+				      "axi_s_xpu",
+				      "parf",
+				      "phy",
+				      "axi_m_sticky",
+				      "pipe_sticky",
+				      "pwr",
+				      "ahb",
+				      "phy_ahb";
+
+			status = "disabled";
+		};
+
+		qpic_bam: dma@7984000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x7984000 0x1a000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		nand: qpic-nand@79b0000 {
+			compatible = "qcom,ipq4019-nand";
+			reg = <0x79b0000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "core", "aon";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			status = "disabled";
+
+			nand@0 {
+				reg = <0>;
+
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+				nand-bus-width = <8>;
+			};
+		};
+
 		wifi0: wifi@a000000 {
 			compatible = "qcom,ipq4019-wifi";
 			reg = <0xa000000 0x200000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
