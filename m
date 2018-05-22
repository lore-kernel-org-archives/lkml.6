Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeEVPqX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:46:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26218 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751196AbeEVPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:46:20 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>
CC: <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@st.com>
Subject: [PATCH v3] ARM: dts: stm32: Add ADC support to stm32mp157c
Date: Tue, 22 May 2018 17:45:37 +0200
Message-ID: <1527003937-15999-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stm32mp157c has an ADC block with two physical ADCs.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v3:
- Add dmas since dmamux1 has been added on top of stm32-next
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673..66d7496 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -600,6 +600,42 @@
 			clocks = <&rcc DMAMUX>;
 		};
 
+		adc: adc@48003000 {
+			compatible = "st,stm32mp1-adc-core";
+			reg = <0x48003000 0x400>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
+			clock-names = "bus", "adc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			adc1: adc@0 {
+				compatible = "st,stm32mp1-adc";
+				#io-channel-cells = <1>;
+				reg = <0x0>;
+				interrupt-parent = <&adc>;
+				interrupts = <0>;
+				dmas = <&dmamux1 9 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			adc2: adc@100 {
+				compatible = "st,stm32mp1-adc";
+				#io-channel-cells = <1>;
+				reg = <0x100>;
+				interrupt-parent = <&adc>;
+				interrupts = <1>;
+				dmas = <&dmamux1 10 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
1.9.1
