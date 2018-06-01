Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeFARfu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:35:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45772 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbeFARfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:35:44 -0400
X-Google-Smtp-Source: ADUXVKKoYNUGbuoSrBUYIWgHjEre9BiJ9G8kf2OIl2Y6o2d/Rgi35i9I7QenXIuB15MUCKU1TDtXrQ==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/2] arm64: allwinner: a64-amarula-relic: Enable AP6330 WiFi support
Date: Fri,  1 Jun 2018 23:05:27 +0530
Message-Id: <20180601173527.18051-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180601173527.18051-1-jagan@amarulasolutions.com>
References: <20180601173527.18051-1-jagan@amarulasolutions.com>
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
Changes for v3:
- move dtsi change in separate patch
Changes for v2:
- Move external rtc clock nodes into main rtc node definition
  of sun50i-a64.dtsi

 .../dts/allwinner/sun50i-a64-amarula-relic.dts     | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index ce4a256ff086..eac4793c8502 100644
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
-- 
2.14.3
