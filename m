Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C530FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2D12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2D12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeJPWNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48252 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeJPWNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 305AA20DF9; Tue, 16 Oct 2018 16:22:31 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E83C20DFB;
        Tue, 16 Oct 2018 16:22:05 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 18/22] ARM: dts: at91: at91sam9260: switch to new clock bindings
Date:   Tue, 16 Oct 2018 16:21:56 +0200
Message-Id: <20181016142200.19741-19-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch at91sam9260 and at91sam9g20 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 308 +++--------------------------
 arch/arm/boot/dts/at91sam9g20.dtsi |  23 +--
 2 files changed, 31 insertions(+), 300 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 9118e29b6d6a..7cd9c3bc4dfb 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -113,276 +113,28 @@
 				compatible = "atmel,at91sam9260-pmc", "syscon";
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
-				slow_rc_osc: slow_rc_osc {
-					compatible = "fixed-clock";
-					#clock-cells = <0>;
-					clock-frequency = <32768>;
-					clock-accuracy = <50000000>;
-				};
-
-				clk32k: slck {
-					compatible = "atmel,at91sam9260-clk-slow";
-					#clock-cells = <0>;
-					clocks = <&slow_rc_osc>, <&slow_xtal>;
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
-					atmel,pll-clk-output-ranges = <80000000 160000000 0 1>,
-								<150000000 240000000 2 1>;
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
-					clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
-					atmel,clk-output-range = <0 105000000>;
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
-					clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
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
-					adc_clk: adc_clk {
-						#clock-cells = <0>;
-						reg = <5>;
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
-					macb0_clk: macb0_clk {
-						#clock-cells = <0>;
-						reg = <21>;
-					};
-
-					isi_clk: isi_clk {
-						#clock-cells = <0>;
-						reg = <22>;
-					};
-
-					usart3_clk: usart3_clk {
-						#clock-cells = <0>;
-						reg = <23>;
-					};
-
-					uart0_clk: uart0_clk {
-						#clock-cells = <0>;
-						reg = <24>;
-					};
-
-					uart1_clk: uart1_clk {
-						#clock-cells = <0>;
-						reg = <25>;
-					};
-
-					tc3_clk: tc3_clk {
-						#clock-cells = <0>;
-						reg = <26>;
-					};
-
-					tc4_clk: tc4_clk {
-						#clock-cells = <0>;
-						reg = <27>;
-					};
-
-					tc5_clk: tc5_clk {
-						#clock-cells = <0>;
-						reg = <28>;
-					};
-				};
+				#clock-cells = <2>;
+				clocks = <&slow_xtal>, <&main_xtal>;
+				clock-names = "slow_xtal", "main_xtal";
 			};
 
 			rstc@fffffd00 {
 				compatible = "atmel,at91sam9260-rstc";
 				reg = <0xfffffd00 0x10>;
-				clocks = <&clk32k>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
 			};
 
 			shdwc@fffffd10 {
 				compatible = "atmel,at91sam9260-shdwc";
 				reg = <0xfffffd10 0x10>;
-				clocks = <&clk32k>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
 			};
 
 			pit: timer@fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
 			tcb0: timer@fffa0000 {
@@ -393,7 +145,7 @@
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
 					      18 IRQ_TYPE_LEVEL_HIGH 0
 					      19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc0_clk>, <&tc1_clk>, <&tc2_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_PERIPHERAL 18>, <&pmc PMC_TYPE_PERIPHERAL 19>, <&pmc PMC_TYPE_CORE PMC_SLOW>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
@@ -405,7 +157,7 @@
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0
 					      27 IRQ_TYPE_LEVEL_HIGH 0
 					      28 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tc3_clk>, <&tc4_clk>, <&tc5_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 26>, <&pmc PMC_TYPE_PERIPHERAL 27>, <&pmc PMC_TYPE_PERIPHERAL 28>, <&pmc PMC_TYPE_CORE PMC_SLOW>;
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
@@ -746,7 +498,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioA_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioB: gpio@fffff600 {
@@ -757,7 +509,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 
 				pioC: gpio@fffff800 {
@@ -768,7 +520,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioC_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
 				};
 			};
 
@@ -778,7 +530,7 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -791,7 +543,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
-				clocks = <&usart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -804,7 +556,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
-				clocks = <&usart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -817,7 +569,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
-				clocks = <&usart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -830,7 +582,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
-				clocks = <&usart3_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -843,7 +595,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
-				clocks = <&uart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -856,7 +608,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
-				clocks = <&uart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 25>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -867,7 +619,7 @@
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
-				clocks = <&macb0_clk>, <&macb0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 21>, <&pmc PMC_TYPE_PERIPHERAL 21>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
@@ -876,7 +628,7 @@
 				compatible = "atmel,at91sam9260-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
-				clocks = <&udc_clk>, <&udpck>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>, <&pmc PMC_TYPE_SYSTEM 7>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
 			};
@@ -887,7 +639,7 @@
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
 				status = "disabled";
 			};
 
@@ -898,7 +650,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pinctrl-names = "default";
-				clocks = <&mci0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "mci_clk";
 				status = "disabled";
 			};
@@ -909,7 +661,7 @@
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -922,7 +674,7 @@
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -935,7 +687,7 @@
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
-				clocks = <&spi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -946,7 +698,7 @@
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&adc_clk>, <&adc_op_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>, <&adc_op_clk>;
 				clock-names = "adc_clk", "adc_op_clk";
 				atmel,adc-use-external-triggers;
 				atmel,adc-channels-used = <0xf>;
@@ -981,7 +733,7 @@
 				compatible = "atmel,at91sam9260-rtt";
 				reg = <0xfffffd20 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
 				status = "disabled";
 			};
 
@@ -989,7 +741,7 @@
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffd40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1007,7 +759,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&ohci_clk>, <&ohci_clk>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 20>, <&pmc PMC_TYPE_PERIPHERAL 20>, <&pmc PMC_TYPE_SYSTEM 6>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
@@ -1027,7 +779,7 @@
 				  0x5 0x0 0x60000000 0x10000000
 				  0x6 0x0 0x70000000 0x10000000
 				  0x7 0x0 0x80000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 90705ee6008b..e976fd6bc6fd 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -40,28 +40,7 @@
 			};
 
 			pmc: pmc@fffffc00 {
-				plla: pllack {
-					atmel,clk-input-range = <2000000 32000000>;
-					atmel,pll-clk-output-ranges = <745000000 800000000 0 0>,
-								<695000000 750000000 1 0>,
-								<645000000 700000000 2 0>,
-								<595000000 650000000 3 0>,
-								<545000000 600000000 0 1>,
-								<495000000 550000000 1 1>,
-								<445000000 500000000 2 1>,
-								<400000000 450000000 3 1>;
-				};
-
-				pllb: pllbck {
-					compatible = "atmel,at91sam9g20-clk-pllb";
-					atmel,clk-input-range = <2000000 32000000>;
-					atmel,pll-clk-output-ranges = <30000000 100000000 0 0>;
-				};
-
-				mck: masterck {
-					atmel,clk-output-range = <0 133000000>;
-					atmel,clk-divisors = <1 2 4 6>;
-				};
+				compatible = "atmel,at91sam9g20-pmc", "atmel,at91sam9260-pmc", "syscon";
 			};
 		};
 	};
-- 
2.19.1

