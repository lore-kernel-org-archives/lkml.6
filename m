Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965352AbeE2RW4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:22:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43198 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965068AbeE2RWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:22:53 -0400
X-Google-Smtp-Source: ADUXVKIhLcx3qlrQirdcc1/CfF6TvEqBwU+VSOQWyofU7Q9SpeBzPprbfVfIJUiSukt+QHx8HWqzJg==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: allwinner: a64-amarula-relic: Enable AP6330 WiFi support
Date: Tue, 29 May 2018 22:52:38 +0530
Message-Id: <20180529172238.9718-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable AP6330 WiFi/BT combo chip on Amarula A64-Relic board:
- WiFi SDIO interface is connected to MMC1
- WiFi WL-PMU-EN pin connected to gpio PL2: attach to mmc-pwrseq
- WiFi WL-WAKE-AP pin connected to gpio PL3
- 32kHz external oscillator gate clock from RTC

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-amarula-relic.dts     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index ce4a256ff086..a77b70ca88e3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -21,12 +21,43 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* WL-PMU-EN: PL2 */
+	};
 };
 
 &ehci0 {
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	/*
+	 * Schematic shows both dldo4 and eldo1 connected for vcc-io-wifi, but
+	 * dldo4 connection shows DNP(Do Not Populate) and eldo1 connected with
+	 * 0Ohm register to vcc-io-wifi so eldo1 is used.
+	 */
+	vqmmc-supply = <&reg_eldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>;	/* WL-WAKE-AP: PL3 */
+		interrupt-names = "host-wake";
+	};
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
@@ -170,6 +201,12 @@
 	regulator-name = "vcc-rtc";
 };
 
+&rtc {
+	clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
+	clocks = <&osc32k>;
+	#clock-cells = <1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.14.3
