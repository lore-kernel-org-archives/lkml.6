Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F771C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069152086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069152086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJPWOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:14:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48228 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeJPWNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 24FDF20DF8; Tue, 16 Oct 2018 16:22:31 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D02220DF9;
        Tue, 16 Oct 2018 16:22:05 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 16/22] ARM: dts: at91: sama5d4: switch to new clock bindings
Date:   Tue, 16 Oct 2018 16:21:54 +0200
Message-Id: <20181016142200.19741-17-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch sama5d4 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91-sama5d4ek.dts |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi       | 535 +++------------------------
 2 files changed, 49 insertions(+), 488 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 0702a2f2b336..12d5af938aa3 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -115,7 +115,7 @@
 				wm8904: codec@1a {
 					compatible = "wlf,wm8904";
 					reg = <0x1a>;
-					clocks = <&pck2>;
+					clocks = <&pmc PMC_TYPE_SYSTEM 10>;
 					clock-names = "mclk";
 				};
 
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 92a35a1942b6..107a704514e0 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -137,7 +137,7 @@
 			reg = <0x00400000 0x100000
 			       0xfc02c000 0x4000>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&udphs_clk>, <&utmi>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
 
@@ -264,7 +264,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 46>, <&pmc PMC_TYPE_PERIPHERAL 46>, <&pmc PMC_TYPE_SYSTEM 6>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
@@ -273,7 +273,7 @@
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&utmi>, <&uhphs_clk>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_PERIPHERAL 46>;
 			clock-names = "usb_clk", "ehci_clk";
 			status = "disabled";
 		};
@@ -297,7 +297,7 @@
 				  0x1 0x0 0x60000000 0x10000000
 				  0x2 0x0 0x70000000 0x10000000
 				  0x3 0x0 0x80000000 0x8000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
@@ -327,7 +327,7 @@
 				compatible = "atmel,sama5d4-hlcdc";
 				reg = <0xf0000000 0x4000>;
 				interrupts = <51 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 51>, <&pmc PMC_TYPE_SYSTEM 3>, <&clk32k>;
 				clock-names = "periph_clk","sys_clk", "slow_clk";
 				status = "disabled";
 
@@ -356,7 +356,7 @@
 				reg = <0xf0004000 0x200>;
 				interrupts = <50 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <1>;
-				clocks = <&dma1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 50>;
 				clock-names = "dma_clk";
 			};
 
@@ -366,7 +366,7 @@
 				interrupts = <52 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_isi_data_0_7>;
-				clocks = <&isi_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
 				clock-names = "isi_clk";
 				status = "disabled";
 				port {
@@ -378,7 +378,7 @@
 			ramc0: ramc@f0010000 {
 				compatible = "atmel,sama5d3-ddramc";
 				reg = <0xf0010000 0x200>;
-				clocks = <&ddrck>, <&mpddr_clk>;
+				clocks = <&pmc PMC_TYPE_SYSTEM 2>, <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "ddrck", "mpddr";
 			};
 
@@ -387,7 +387,7 @@
 				reg = <0xf0014000 0x200>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <1>;
-				clocks = <&dma0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "dma_clk";
 			};
 
@@ -395,448 +395,9 @@
 				compatible = "atmel,sama5d4-pmc", "syscon";
 				reg = <0xf0018000 0x120>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-
-				main_rc_osc: main_rc_osc {
-					compatible = "atmel,at91sam9x5-clk-main-rc-osc";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MOSCRCS>;
-					clock-frequency = <12000000>;
-					clock-accuracy = <100000000>;
-				};
-
-				main_osc: main_osc {
-					compatible = "atmel,at91rm9200-clk-main-osc";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MOSCS>;
-					clocks = <&main_xtal>;
-				};
-
-				main: mainck {
-					compatible = "atmel,at91sam9x5-clk-main";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MOSCSELS>;
-					clocks = <&main_rc_osc &main_osc>;
-				};
-
-				plla: pllack {
-					compatible = "atmel,sama5d3-clk-pll";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_LOCKA>;
-					clocks = <&main>;
-					reg = <0>;
-					atmel,clk-input-range = <12000000 12000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <600000000 1200000000 0 0>;
-				};
-
-				plladiv: plladivck {
-					compatible = "atmel,at91sam9x5-clk-plldiv";
-					#clock-cells = <0>;
-					clocks = <&plla>;
-				};
-
-				utmi: utmick {
-					compatible = "atmel,at91sam9x5-clk-utmi";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_LOCKU>;
-					clocks = <&main>;
-				};
-
-				mck: masterck {
-					compatible = "atmel,at91sam9x5-clk-master";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MCKRDY>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>;
-					atmel,clk-output-range = <125000000 200000000>;
-					atmel,clk-divisors = <1 2 4 3>;
-				};
-
-				h32ck: h32mxck {
-					#clock-cells = <0>;
-					compatible = "atmel,sama5d4-clk-h32mx";
-					clocks = <&mck>;
-				};
-
-				usb: usbck {
-					compatible = "atmel,at91sam9x5-clk-usb";
-					#clock-cells = <0>;
-					clocks = <&plladiv>, <&utmi>;
-				};
-
-				prog: progck {
-					compatible = "atmel,at91sam9x5-clk-programmable";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
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
-				};
-
-				smd: smdclk {
-					compatible = "atmel,at91sam9x5-clk-smd";
-					#clock-cells = <0>;
-					clocks = <&plladiv>, <&utmi>;
-				};
-
-				systemck {
-					compatible = "atmel,at91rm9200-clk-system";
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					ddrck: ddrck {
-						#clock-cells = <0>;
-						reg = <2>;
-						clocks = <&mck>;
-					};
-
-					lcdck: lcdck {
-						#clock-cells = <0>;
-						reg = <3>;
-						clocks = <&mck>;
-					};
-
-					smdck: smdck {
-						#clock-cells = <0>;
-						reg = <4>;
-						clocks = <&smd>;
-					};
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
-				};
-
-				periph32ck {
-					compatible = "atmel,at91sam9x5-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&h32ck>;
-
-					pioD_clk: pioD_clk {
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
-					icm_clk: icm_clk {
-						#clock-cells = <0>;
-						reg = <9>;
-					};
-
-					aes_clk: aes_clk {
-						#clock-cells = <0>;
-						reg = <12>;
-					};
-
-					tdes_clk: tdes_clk {
-						#clock-cells = <0>;
-						reg = <14>;
-					};
-
-					sha_clk: sha_clk {
-						#clock-cells = <0>;
-						reg = <15>;
-					};
-
-					matrix1_clk: matrix1_clk {
-						#clock-cells = <0>;
-						reg = <17>;
-					};
-
-					hsmc_clk: hsmc_clk {
-						#clock-cells = <0>;
-						reg = <22>;
-					};
-
-					pioA_clk: pioA_clk {
-						#clock-cells = <0>;
-						reg = <23>;
-					};
-
-					pioB_clk: pioB_clk {
-						#clock-cells = <0>;
-						reg = <24>;
-					};
-
-					pioC_clk: pioC_clk {
-						#clock-cells = <0>;
-						reg = <25>;
-					};
-
-					pioE_clk: pioE_clk {
-						#clock-cells = <0>;
-						reg = <26>;
-					};
-
-					uart0_clk: uart0_clk {
-						#clock-cells = <0>;
-						reg = <27>;
-					};
-
-					uart1_clk: uart1_clk {
-						#clock-cells = <0>;
-						reg = <28>;
-					};
-
-					usart2_clk: usart2_clk {
-						#clock-cells = <0>;
-						reg = <29>;
-					};
-
-					usart3_clk: usart3_clk {
-						#clock-cells = <0>;
-						reg = <30>;
-					};
-
-					usart4_clk: usart4_clk {
-						#clock-cells = <0>;
-						reg = <31>;
-					};
-
-					twi0_clk: twi0_clk {
-						reg = <32>;
-						#clock-cells = <0>;
-					};
-
-					twi1_clk: twi1_clk {
-						#clock-cells = <0>;
-						reg = <33>;
-					};
-
-					twi2_clk: twi2_clk {
-						#clock-cells = <0>;
-						reg = <34>;
-					};
-
-					mci0_clk: mci0_clk {
-						#clock-cells = <0>;
-						reg = <35>;
-					};
-
-					mci1_clk: mci1_clk {
-						#clock-cells = <0>;
-						reg = <36>;
-					};
-
-					spi0_clk: spi0_clk {
-						#clock-cells = <0>;
-						reg = <37>;
-					};
-
-					spi1_clk: spi1_clk {
-						#clock-cells = <0>;
-						reg = <38>;
-					};
-
-					spi2_clk: spi2_clk {
-						#clock-cells = <0>;
-						reg = <39>;
-					};
-
-					tcb0_clk: tcb0_clk {
-						#clock-cells = <0>;
-						reg = <40>;
-					};
-
-					tcb1_clk: tcb1_clk {
-						#clock-cells = <0>;
-						reg = <41>;
-					};
-
-					tcb2_clk: tcb2_clk {
-						#clock-cells = <0>;
-						reg = <42>;
-					};
-
-					pwm_clk: pwm_clk {
-						#clock-cells = <0>;
-						reg = <43>;
-					};
-
-					adc_clk: adc_clk {
-						#clock-cells = <0>;
-						reg = <44>;
-					};
-
-					dbgu_clk: dbgu_clk {
-						#clock-cells = <0>;
-						reg = <45>;
-					};
-
-					uhphs_clk: uhphs_clk {
-						#clock-cells = <0>;
-						reg = <46>;
-					};
-
-					udphs_clk: udphs_clk {
-						#clock-cells = <0>;
-						reg = <47>;
-					};
-
-					ssc0_clk: ssc0_clk {
-						#clock-cells = <0>;
-						reg = <48>;
-					};
-
-					ssc1_clk: ssc1_clk {
-						#clock-cells = <0>;
-						reg = <49>;
-					};
-
-					trng_clk: trng_clk {
-						#clock-cells = <0>;
-						reg = <53>;
-					};
-
-					macb0_clk: macb0_clk {
-						#clock-cells = <0>;
-						reg = <54>;
-					};
-
-					macb1_clk: macb1_clk {
-						#clock-cells = <0>;
-						reg = <55>;
-					};
-
-					fuse_clk: fuse_clk {
-						#clock-cells = <0>;
-						reg = <57>;
-					};
-
-					securam_clk: securam_clk {
-						#clock-cells = <0>;
-						reg = <59>;
-					};
-
-					smd_clk: smd_clk {
-						#clock-cells = <0>;
-						reg = <61>;
-					};
-
-					twi3_clk: twi3_clk {
-						#clock-cells = <0>;
-						reg = <62>;
-					};
-
-					catb_clk: catb_clk {
-						#clock-cells = <0>;
-						reg = <63>;
-					};
-				};
-
-				periph64ck {
-					compatible = "atmel,at91sam9x5-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&mck>;
-
-					dma0_clk: dma0_clk {
-						#clock-cells = <0>;
-						reg = <8>;
-					};
-
-					cpkcc_clk: cpkcc_clk {
-						#clock-cells = <0>;
-						reg = <10>;
-					};
-
-					aesb_clk: aesb_clk {
-						#clock-cells = <0>;
-						reg = <13>;
-					};
-
-					mpddr_clk: mpddr_clk {
-						#clock-cells = <0>;
-						reg = <16>;
-					};
-
-					matrix0_clk: matrix0_clk {
-						#clock-cells = <0>;
-						reg = <18>;
-					};
-
-					vdec_clk: vdec_clk {
-						#clock-cells = <0>;
-						reg = <19>;
-					};
-
-					dma1_clk: dma1_clk {
-						#clock-cells = <0>;
-						reg = <50>;
-					};
-
-					lcdc_clk: lcdc_clk {
-						#clock-cells = <0>;
-						reg = <51>;
-					};
-
-					isi_clk: isi_clk {
-						#clock-cells = <0>;
-						reg = <52>;
-					};
-				};
+				#clock-cells = <2>;
+				clocks = <&clk32k>, <&main_xtal>;
+				clock-names = "slow_clk", "main_xtal";
 			};
 
 			mmc0: mmc@f8000000 {
@@ -852,7 +413,7 @@
 				status = "disabled";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&mci0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>;
 				clock-names = "mci_clk";
 			};
 
@@ -869,7 +430,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
-				clocks = <&uart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -887,7 +448,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(27))>;
 				dma-names = "tx", "rx";
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 48>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -897,7 +458,7 @@
 				reg = <0xf800c000 0x300>;
 				interrupts = <43 IRQ_TYPE_LEVEL_HIGH 4>;
 				#pwm-cells = <3>;
-				clocks = <&pwm_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 43>;
 				status = "disabled";
 			};
 
@@ -916,7 +477,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -936,7 +497,7 @@
 				pinctrl-0 = <&pinctrl_i2c0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
 				status = "disabled";
 			};
 
@@ -955,7 +516,7 @@
 				pinctrl-0 = <&pinctrl_i2c1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
 				status = "disabled";
 			};
 
@@ -965,7 +526,7 @@
 				#size-cells = <0>;
 				reg = <0xf801c000 0x100>;
 				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 40>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -977,7 +538,7 @@
 				pinctrl-0 = <&pinctrl_macb0_rmii>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&macb0_clk>, <&macb0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 54>, <&pmc PMC_TYPE_PERIPHERAL 54>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
@@ -997,7 +558,7 @@
 				pinctrl-0 = <&pinctrl_i2c2>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 34>;
 				status = "disabled";
 			};
 
@@ -1019,7 +580,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts &pinctrl_usart0_cts>;
-				clocks = <&usart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1037,7 +598,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts &pinctrl_usart1_cts>;
-				clocks = <&usart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1055,7 +616,7 @@
 				status = "disabled";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&mci1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>;
 				clock-names = "mci_clk";
 			};
 
@@ -1072,7 +633,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
-				clocks = <&uart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1090,7 +651,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rts &pinctrl_usart2_cts>;
-				clocks = <&usart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 29>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1108,7 +669,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
-				clocks = <&usart3_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 30>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1126,7 +687,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart4>;
-				clocks = <&usart4_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 31>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1144,7 +705,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(29))>;
 				dma-names = "tx", "rx";
-				clocks = <&ssc1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 49>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -1164,7 +725,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
-				clocks = <&spi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -1184,7 +745,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi2>;
-				clocks = <&spi2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -1195,7 +756,7 @@
 				#size-cells = <0>;
 				reg = <0xfc020000 0x100>;
 				interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb1_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 41>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -1205,7 +766,7 @@
 				#size-cells = <0>;
 				reg = <0xfc024000 0x100>;
 				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb2_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -1217,7 +778,7 @@
 				pinctrl-0 = <&pinctrl_macb1_rmii>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&macb1_clk>, <&macb1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 55>, <&pmc PMC_TYPE_PERIPHERAL 55>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
@@ -1226,14 +787,14 @@
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfc030000 0x100>;
 				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&trng_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 53>;
 			};
 
 			adc0: adc@fc034000 {
 				compatible = "atmel,at91sam9x5-adc";
 				reg = <0xfc034000 0x100>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 5>;
-				clocks = <&adc_clk>,
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 44>,
 					 <&adc_op_clk>;
 				clock-names = "adc_clk", "adc_op_clk";
 				atmel,adc-channels-used = <0x01f>;
@@ -1276,7 +837,7 @@
 				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(40))>;
 				dma-names = "tx", "rx";
-				clocks = <&aes_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "aes_clk";
 				status = "okay";
 			};
@@ -1290,7 +851,7 @@
 				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(43))>;
 				dma-names = "tx", "rx";
-				clocks = <&tdes_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "tdes_clk";
 				status = "okay";
 			};
@@ -1302,7 +863,7 @@
 				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(44))>;
 				dma-names = "tx";
-				clocks = <&sha_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				clock-names = "sha_clk";
 				status = "okay";
 			};
@@ -1311,7 +872,7 @@
 				compatible = "atmel,sama5d3-smc", "syscon", "simple-mfd";
 				reg = <0xfc05c000 0x1000>;
 				interrupts = <22 IRQ_TYPE_LEVEL_HIGH 6>;
-				clocks = <&hsmc_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges;
@@ -1339,7 +900,7 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfc068630 0x10>;
 				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
-				clocks = <&h32ck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK2>;
 			};
 
 			watchdog@fc068640 {
@@ -1370,7 +931,7 @@
 				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
-				clocks = <&dbgu_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 45>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1400,7 +961,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioA_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 				};
 
 				pioB: gpio@fc06b000 {
@@ -1411,7 +972,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 24>;
 				};
 
 				pioC: gpio@fc06c000 {
@@ -1422,7 +983,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioC_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 25>;
 				};
 
 				pioD: gpio@fc068000 {
@@ -1433,7 +994,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioD_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 				};
 
 				pioE: gpio@fc06d000 {
@@ -1444,7 +1005,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioE_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 26>;
 				};
 
 				/* pinctrl pin settings */
-- 
2.19.1

