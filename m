Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755133AbeCVNAh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:00:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755104AbeCVNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:00:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDA3E60F91
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
Cc: sricharan@codeaurora.org
Subject: [PATCH v4 11/13] ARM: dts: ipq8074: Add peripheral nodes
Date: Thu, 22 Mar 2018 18:28:50 +0530
Message-Id: <1521723532-28361-12-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521723532-28361-1-git-send-email-sricharan@codeaurora.org>
References: <1521723532-28361-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add serial, i2c, bam, spi, qpic peripheral nodes.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 105 ++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2bc5dec..a8dbbf0 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -124,6 +124,111 @@
 			clock-names = "core", "iface";
 			status = "disabled";
 		};
+
+		blsp_dma: dma@7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x7884000 0x2b000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		serial_blsp0: serial@78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78af000 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		serial_blsp2: serial@78b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78b1000 0x200>;
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 4>,
+				<&blsp_dma 5>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi_0: spi@78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			spi-max-frequency = <50000000>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				<&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		i2c_0: i2c@78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			clock-frequency = <400000>;
+			dmas = <&blsp_dma 15>, <&blsp_dma 14>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c_1: i2c@78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			clock-frequency = <100000>;
+			dmas = <&blsp_dma 17>, <&blsp_dma 16>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		qpic_bam: dma@7984000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x7984000 0x1a000>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: nand@79b0000 {
+			compatible = "qcom,ipq8074-nand";
+			reg = <0x79b0000 0x10000>;
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
+		};
 	};
 
 	cpus {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
