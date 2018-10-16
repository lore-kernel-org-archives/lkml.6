Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1008C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6709D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6709D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJPWNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48241 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeJPWNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2EC4D20DE6; Tue, 16 Oct 2018 16:22:31 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E747A20DFC;
        Tue, 16 Oct 2018 16:22:05 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 19/22] ARM: dts: at91: at91sam9261: switch to new clock bindings
Date:   Tue, 16 Oct 2018 16:21:57 +0200
Message-Id: <20181016142200.19741-20-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch at91sam9261 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 287 +++--------------------------
 1 file changed, 23 insertions(+), 264 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 33f09d5ea020..01d700b63b45 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -75,7 +75,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&ohci_clk>, <&hclk0>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 20>, <&pmc PMC_TYPE_SYSTEM 16>, <&pmc PMC_TYPE_SYSTEM 6>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
@@ -86,7 +86,7 @@
 			interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_fb>;
-			clocks = <&lcd_clk>, <&hclk1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 21>, <&pmc PMC_TYPE_SYSTEM 17>;
 			clock-names = "lcdc_clk", "hclk";
 			status = "disabled";
 		};
@@ -106,7 +106,7 @@
 				  0x5 0x0 0x60000000 0x10000000
 				  0x6 0x0 0x70000000 0x10000000
 				  0x7 0x0 0x80000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
@@ -132,7 +132,7 @@
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>,
 					     <18 IRQ_TYPE_LEVEL_HIGH 0>,
 					     <19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>, <&slow_xtal>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_PERIPHERAL 18>, <&pmc PMC_TYPE_PERIPHERAL 19>, <&slow_xtal>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
@@ -140,7 +140,7 @@
 				compatible = "atmel,at91sam9261-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
-				clocks = <&udc_clk>, <&udpck>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>, <&pmc PMC_TYPE_SYSTEM 7>;
 				clock-names = "pclk", "hclk";
 				atmel,matrix = <&matrix>;
 				status = "disabled";
@@ -154,7 +154,7 @@
 				pinctrl-0 = <&pinctrl_mmc0_clk>, <&pinctrl_mmc0_slot0_cmd_dat0>, <&pinctrl_mmc0_slot0_dat1_3>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&mci0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "mci_clk";
 				status = "disabled";
 			};
@@ -167,7 +167,7 @@
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
 				status = "disabled";
 			};
 
@@ -179,7 +179,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
-				clocks = <&usart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -192,7 +192,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
-				clocks = <&usart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -205,7 +205,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
-				clocks = <&usart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -216,7 +216,7 @@
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -227,7 +227,7 @@
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
-				clocks = <&ssc1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -238,7 +238,7 @@
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc2_tx &pinctrl_ssc2_rx>;
-				clocks = <&ssc2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -252,7 +252,7 @@
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -265,7 +265,7 @@
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
-				clocks = <&spi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -299,7 +299,7 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -563,7 +563,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioA_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioB: gpio@fffff600 {
@@ -574,7 +574,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 
 				pioC: gpio@fffff800 {
@@ -585,7 +585,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioC_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
 				};
 			};
 
@@ -593,250 +593,9 @@
 				compatible = "atmel,at91sam9261-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-
-				main_osc: main_osc {
-					compatible = "atmel,at91rm9200-clk-main-osc";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCS>;
-					clocks = <&main_xtal>;
-				};
-
-				main: mainck {
-					compatible = "atmel,at91rm9200-clk-main";
-					#clock-cells = <0>;
-					clocks = <&main_osc>;
-				};
-
-				plla: pllack {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKA>;
-					clocks = <&main>;
-					reg = <0>;
-					atmel,clk-input-range = <1000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <80000000 200000000 0 1>,
-								<190000000 240000000 2 1>;
-				};
-
-				pllb: pllbck {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKB>;
-					clocks = <&main>;
-					reg = <1>;
-					atmel,clk-input-range = <1000000 5000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <70000000 130000000 1 1>;
-				};
-
-				mck: masterck {
-					compatible = "atmel,at91rm9200-clk-master";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
-					clocks = <&slow_xtal>, <&main>, <&plla>, <&pllb>;
-					atmel,clk-output-range = <0 94000000>;
-					atmel,clk-divisors = <1 2 4 0>;
-				};
-
-				usb: usbck {
-					compatible = "atmel,at91rm9200-clk-usb";
-					#clock-cells = <0>;
-					atmel,clk-divisors = <1 2 4 0>;
-					clocks = <&pllb>;
-				};
-
-				prog: progck {
-					compatible = "atmel,at91rm9200-clk-programmable";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					interrupt-parent = <&pmc>;
-					clocks = <&slow_xtal>, <&main>, <&plla>, <&pllb>;
-
-					prog0: prog0 {
-						#clock-cells = <0>;
-						reg = <0>;
-						interrupts = <AT91_PMC_PCKRDY(0)>;
-					};
-
-					prog1: prog1 {
-						#clock-cells = <0>;
-						reg = <1>;
-						interrupts = <AT91_PMC_PCKRDY(1)>;
-					};
-
-					prog2: prog2 {
-						#clock-cells = <0>;
-						reg = <2>;
-						interrupts = <AT91_PMC_PCKRDY(2)>;
-					};
-
-					prog3: prog3 {
-						#clock-cells = <0>;
-						reg = <3>;
-						interrupts = <AT91_PMC_PCKRDY(3)>;
-					};
-				};
-
-				systemck {
-					compatible = "atmel,at91rm9200-clk-system";
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					uhpck: uhpck {
-						#clock-cells = <0>;
-						reg = <6>;
-						clocks = <&usb>;
-					};
-
-					udpck: udpck {
-						#clock-cells = <0>;
-						reg = <7>;
-						clocks = <&usb>;
-					};
-
-					pck0: pck0 {
-						#clock-cells = <0>;
-						reg = <8>;
-						clocks = <&prog0>;
-					};
-
-					pck1: pck1 {
-						#clock-cells = <0>;
-						reg = <9>;
-						clocks = <&prog1>;
-					};
-
-					pck2: pck2 {
-						#clock-cells = <0>;
-						reg = <10>;
-						clocks = <&prog2>;
-					};
-
-					pck3: pck3 {
-						#clock-cells = <0>;
-						reg = <11>;
-						clocks = <&prog3>;
-					};
-
-					hclk0: hclk0 {
-						#clock-cells = <0>;
-						reg = <16>;
-						clocks = <&mck>;
-					};
-
-					hclk1: hclk1 {
-						#clock-cells = <0>;
-						reg = <17>;
-						clocks = <&mck>;
-					};
-				};
-
-				periphck {
-					compatible = "atmel,at91rm9200-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&mck>;
-
-					pioA_clk: pioA_clk {
-						#clock-cells = <0>;
-						reg = <2>;
-					};
-
-					pioB_clk: pioB_clk {
-						#clock-cells = <0>;
-						reg = <3>;
-					};
-
-					pioC_clk: pioC_clk {
-						#clock-cells = <0>;
-						reg = <4>;
-					};
-
-					usart0_clk: usart0_clk {
-						#clock-cells = <0>;
-						reg = <6>;
-					};
-
-					usart1_clk: usart1_clk {
-						#clock-cells = <0>;
-						reg = <7>;
-					};
-
-					usart2_clk: usart2_clk {
-						#clock-cells = <0>;
-						reg = <8>;
-					};
-
-					mci0_clk: mci0_clk {
-						#clock-cells = <0>;
-						reg = <9>;
-					};
-
-					udc_clk: udc_clk {
-						#clock-cells = <0>;
-						reg = <10>;
-					};
-
-					twi0_clk: twi0_clk {
-						reg = <11>;
-						#clock-cells = <0>;
-					};
-
-					spi0_clk: spi0_clk {
-						#clock-cells = <0>;
-						reg = <12>;
-					};
-
-					spi1_clk: spi1_clk {
-						#clock-cells = <0>;
-						reg = <13>;
-					};
-
-					ssc0_clk: ssc0_clk {
-						#clock-cells = <0>;
-						reg = <14>;
-					};
-
-					ssc1_clk: ssc1_clk {
-						#clock-cells = <0>;
-						reg = <15>;
-					};
-
-					ssc2_clk: ssc2_clk {
-						#clock-cells = <0>;
-						reg = <16>;
-					};
-
-					tc0_clk: tc0_clk {
-						#clock-cells = <0>;
-						reg = <17>;
-					};
-
-					tc1_clk: tc1_clk {
-						#clock-cells = <0>;
-						reg = <18>;
-					};
-
-					tc2_clk: tc2_clk {
-						#clock-cells = <0>;
-						reg = <19>;
-					};
-
-					ohci_clk: ohci_clk {
-						#clock-cells = <0>;
-						reg = <20>;
-					};
-
-					lcd_clk: lcd_clk {
-						#clock-cells = <0>;
-						reg = <21>;
-					};
-				};
+				#clock-cells = <2>;
+				clocks = <&slow_xtal>, <&main_xtal>;
+				clock-names = "slow_xtal", "main_xtal";
 			};
 
 			rstc@fffffd00 {
@@ -855,7 +614,7 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
 			rtc@fffffd20 {
-- 
2.19.1

