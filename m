Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeA3Mjq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:39:46 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:59237 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752009AbeA3Mjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:39:43 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH 3/4] arm64: dts: rockchip: add Haikou baseboard with RK3368-uQ7 SoM
Date: Tue, 30 Jan 2018 13:39:30 +0100
Message-Id: <20180130123931.50781-4-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
References: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haikou is a Qseven and μQseven baseboard used in Theobroma Systems
evaluation kits. This dts adds a version for use with a RK3368-uQ7 SoM
called Lion.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
---

 .../arm64/boot/dts/rockchip/rk3368-lion-haikou.dts | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
new file mode 100644
index 000000000000..795f5f5eeaf4
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Theobroma Systems Design und Consulting GmbH
+ */
+
+/dts-v1/;
+#include "rk3368-lion.dtsi"
+
+/ {
+	model = "Theobroma Systems RK3368-uQ7 Baseboard";
+	compatible = "tsd,rk3368-lion-haikou", "rockchip,rk3368";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	i2cmux2 {
+		i2c@0 {
+			eeprom: eeprom@50 {
+				compatible = "atmel,24c01";
+				pagesize = <8>;
+				reg = <0x50>;
+			};
+		};
+	};
+
+	leds {
+		pinctrl-0 = <&led_pins_module>, <&led_sd_haikou>;
+
+		sd-card-led {
+			label = "sd_card_led";
+			gpios = <&gpio0 RK_PD2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+		};
+	};
+
+	dc_12v: dc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc3v3_baseboard: vcc3v3-baseboard {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_otg: vcc5v0-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		regulator-name = "vcc5v0_otg";
+		regulator-always-on;
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio2 RK_PB3 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	max-frequency = <25000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
+	rockchip,default-sample-phase = <90>;
+	vmmc-supply = <&vcc3v3_baseboard>;
+	status = "okay";
+};
+
+&spi2 {
+		cs-gpios = <0>, <&gpio2 RK_PC3 GPIO_ACTIVE_LOW>;
+		status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	status = "okay";
+};
+
+&uart1 {
+	/* alternate function of GPIO5/6 */
+	status = "disabled";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&haikou_pin_hog>;
+
+	hog {
+		haikou_pin_hog: haikou-pin-hog {
+			rockchip,pins =
+			  /* LID_BTN */
+			  <RK_GPIO3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+			  /* BATLOW# */
+			  <RK_GPIO0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>,
+			  /* SLP_BTN# */
+			  <RK_GPIO3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+			  /* BIOS_DISABLE# */
+			  <RK_GPIO3 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		led_sd_haikou: led-sd-gpio {
+			rockchip,pins =
+			  <RK_GPIO0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_cd_gpio: sdmmc-cd-gpio {
+			rockchip,pins =
+			  <RK_GPIO2 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb_otg {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins =
+			  <RK_GPIO0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.11.0
