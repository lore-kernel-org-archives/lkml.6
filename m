Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D36C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9BB20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="sQi6pF54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9BB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeH3TKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:10:39 -0400
Received: from mail.nic.cz ([217.31.204.67]:40506 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbeH3TKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:10:38 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 5C8C6600B7;
        Thu, 30 Aug 2018 17:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1535641680; bh=VIsfA+KLWMIjKXIUGpJJY4JhcH56oawvqmCG3P0p4W8=;
        h=From:To:Date;
        b=sQi6pF54BztcBQBlZg3TR11c977erqkw255FCT53Vq6aQKI9rIbRJU2CQO/hjbDIg
         RYqbcrCMCLj8yxMNL1BBQY+qUarHcKSwwmCPak6g0bLFW0i1B3SsEEAvaQVYiQEUNh
         zPMs2umFTKXIq7vjEBv4TVlAZu/QhBOnPunkzd6g=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     gregory.clement@bootlin.com
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH mvebu-dt64] arm64: dts: marvell: armada-37xx: Add DTS file for Turris Mox
Date:   Thu, 30 Aug 2018 17:05:44 +0200
Message-Id: <20180830150544.14814-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Turris Mox board from CZ.NIC.

Turris Mox is as modular router based on the Armada 3720 SOC (same as
EspressoBin).

The basic module can be extended by different modules.
When those modules are connected, U-Boot shall patch this device-tree
by enabling nodes corresponding to those modules.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 .../arm/marvell/armada-3720-turris-mox.txt         |   6 +
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 .../boot/dts/marvell/armada-3720-turris-mox.dts    | 817 +++++++++++++++++++++
 3 files changed, 824 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt b/Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt
new file mode 100644
index 000000000000..408fc07a9bbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-3720-turris-mox.txt
@@ -0,0 +1,6 @@
+CZ.NIC's Turris Mox SOHO router Device Tree Bindings
+----------------------------------------------------
+
+Required root node property:
+
+compatible: must contain "cznic,turris-mox"
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index ea9d49f2a911..1dd89d1bf8ad 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -2,6 +2,7 @@
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
new file mode 100644
index 000000000000..9267ae96f14f
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -0,0 +1,817 @@
+// SPDX-License-Identifier: GPL-2.0+ or X11
+/*
+ * Device Tree file for CZ.NIC Turris Mox Board
+ * 2018 by Marek Behun <marek.behun@nic.cz>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "armada-372x.dtsi"
+
+/ {
+	model = "CZ.NIC Turris Mox Board";
+	compatible = "cznic,turris-mox", "marvell,armada3720",
+		     "marvell,armada3710";
+
+	aliases {
+		spi0 = &spi0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		red {
+			gpios = <&gpiosb 21 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		reset_button {
+			label = "reset";
+			linux,code = <BTN_MISC>;
+			gpios = <&gpiosb 20 GPIO_ACTIVE_LOW>;
+			debounce-interval = <60>;
+		};
+	};
+
+	exp_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&gpiosb 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	usb3_phy: usb3-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&exp_usb3_vbus>;
+	};
+
+	vsdc_reg: vsdc_reg {
+		compatible = "regulator-gpio";
+		regulator-name = "vsdc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+
+		gpios = <&gpiosb 23 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
+
+	vsdio_reg: vsdio_reg {
+		compatible = "regulator-gpio";
+		regulator-name = "vsdio";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+
+		gpios = <&gpiosb 22 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp+";
+		i2c-bus = <&i2c0>;
+		los-gpio = <&moxtet_sfp 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&moxtet_sfp 1 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&moxtet_sfp 2 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&moxtet_sfp 3 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpio = <&moxtet_sfp 4 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+};
+
+&pinctrl_nb {
+	spi_cs1_pins: spi-cs1-pins {
+		groups = "spi_cs1";
+		function = "spi";
+	};
+
+	sdio0_pins: sdio0-pins {
+		groups = "sdio0";
+		function = "sdio";
+	};
+};
+
+&pinctrl_sb {
+	sdio_sb_pins: sdio-sb-pins {
+		groups = "sdio_sb";
+		function = "sdio";
+	};
+
+	smi_pins: smi-pins {
+		groups = "smi";
+		function = "smi";
+	};
+
+	pcie_pins: pcie1-pins {
+		groups = "pcie1";
+		function = "gpio";
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+
+	rtc@6f {
+		compatible = "microchip,mcp7940x";
+		reg = <0x6f>;
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+	max-link-speed = <2>;
+	reset-gpio = <&gpiosb 3 GPIO_ACTIVE_HIGH>;
+
+	/* this shall be enabled by u-boot if the PCIe module is present */
+	status = "disabled";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&phy1>;
+	status = "okay";
+};
+
+&eth1 {
+	phy-mode = "1000base-x";
+	managed = "in-band-status";
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&smi_pins>;
+	status = "okay";
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+
+	switch0@10 {
+		compatible = "marvell,mv88e6190";
+		reg = <0x10 0>;
+		dsa,member = <0 0>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy1: switch0phy1@1 {
+				reg = <0x1>;
+			};
+
+			switch0phy2: switch0phy2@2 {
+				reg = <0x2>;
+			};
+
+			switch0phy3: switch0phy3@3 {
+				reg = <0x3>;
+			};
+
+			switch0phy4: switch0phy4@4 {
+				reg = <0x4>;
+			};
+
+			switch0phy5: switch0phy5@5 {
+				reg = <0x5>;
+			};
+
+			switch0phy6: switch0phy6@6 {
+				reg = <0x6>;
+			};
+
+			switch0phy7: switch0phy7@7 {
+				reg = <0x7>;
+			};
+
+			switch0phy8: switch0phy8@8 {
+				reg = <0x8>;
+			};
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <0x1>;
+				label = "lan1";
+				phy-handle = <&switch0phy1>;
+			};
+
+			port@2 {
+				reg = <0x2>;
+				label = "lan2";
+				phy-handle = <&switch0phy2>;
+			};
+
+			port@3 {
+				reg = <0x3>;
+				label = "lan3";
+				phy-handle = <&switch0phy3>;
+			};
+
+			port@4 {
+				reg = <0x4>;
+				label = "lan4";
+				phy-handle = <&switch0phy4>;
+			};
+
+			port@5 {
+				reg = <0x5>;
+				label = "lan5";
+				phy-handle = <&switch0phy5>;
+			};
+
+			port@6 {
+				reg = <0x6>;
+				label = "lan6";
+				phy-handle = <&switch0phy6>;
+			};
+
+			port@7 {
+				reg = <0x7>;
+				label = "lan7";
+				phy-handle = <&switch0phy7>;
+			};
+
+			port@8 {
+				reg = <0x8>;
+				label = "lan8";
+				phy-handle = <&switch0phy8>;
+			};
+
+			port@9 {
+				reg = <0x9>;
+				label = "cpu";
+				ethernet = <&eth1>;
+			};
+
+			switch0port10: port@a {
+				reg = <0xa>;
+				label = "dsa";
+				phy-mode = "2500base-x";
+				link = <&switch1port9 &switch2port9>;
+				status = "disabled";
+			};
+
+			port-sfp@a {
+				reg = <0xa>;
+				label = "sfp";
+				sfp = <&sfp>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+				status = "disabled";
+			};
+		};
+	};
+
+	switch0@2 {
+		compatible = "marvell,mv88e6085";
+		reg = <0x2 0>;
+		dsa,member = <0 0>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy1_topaz: switch0phy1@11 {
+				reg = <0x11>;
+			};
+
+			switch0phy2_topaz: switch0phy2@12 {
+				reg = <0x12>;
+			};
+
+			switch0phy3_topaz: switch0phy3@13 {
+				reg = <0x13>;
+			};
+
+			switch0phy4_topaz: switch0phy4@14 {
+				reg = <0x14>;
+			};
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <0x1>;
+				label = "lan1";
+				phy-handle = <&switch0phy1_topaz>;
+			};
+
+			port@2 {
+				reg = <0x2>;
+				label = "lan2";
+				phy-handle = <&switch0phy2_topaz>;
+			};
+
+			port@3 {
+				reg = <0x3>;
+				label = "lan3";
+				phy-handle = <&switch0phy3_topaz>;
+			};
+
+			port@4 {
+				reg = <0x4>;
+				label = "lan4";
+				phy-handle = <&switch0phy4_topaz>;
+			};
+
+			port@5 {
+				reg = <0x5>;
+				label = "cpu";
+				ethernet = <&eth1>;
+			};
+		};
+	};
+
+	switch1@11 {
+		compatible = "marvell,mv88e6190";
+		reg = <0x11 0>;
+		dsa,member = <0 1>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch1phy1: switch1phy1@1 {
+				reg = <0x1>;
+			};
+
+			switch1phy2: switch1phy2@2 {
+				reg = <0x2>;
+			};
+
+			switch1phy3: switch1phy3@3 {
+				reg = <0x3>;
+			};
+
+			switch1phy4: switch1phy4@4 {
+				reg = <0x4>;
+			};
+
+			switch1phy5: switch1phy5@5 {
+				reg = <0x5>;
+			};
+
+			switch1phy6: switch1phy6@6 {
+				reg = <0x6>;
+			};
+
+			switch1phy7: switch1phy7@7 {
+				reg = <0x7>;
+			};
+
+			switch1phy8: switch1phy8@8 {
+				reg = <0x8>;
+			};
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <0x1>;
+				label = "lan9";
+				phy-handle = <&switch1phy1>;
+			};
+
+			port@2 {
+				reg = <0x2>;
+				label = "lan10";
+				phy-handle = <&switch1phy2>;
+			};
+
+			port@3 {
+				reg = <0x3>;
+				label = "lan11";
+				phy-handle = <&switch1phy3>;
+			};
+
+			port@4 {
+				reg = <0x4>;
+				label = "lan12";
+				phy-handle = <&switch1phy4>;
+			};
+
+			port@5 {
+				reg = <0x5>;
+				label = "lan13";
+				phy-handle = <&switch1phy5>;
+			};
+
+			port@6 {
+				reg = <0x6>;
+				label = "lan14";
+				phy-handle = <&switch1phy6>;
+			};
+
+			port@7 {
+				reg = <0x7>;
+				label = "lan15";
+				phy-handle = <&switch1phy7>;
+			};
+
+			port@8 {
+				reg = <0x8>;
+				label = "lan16";
+				phy-handle = <&switch1phy8>;
+			};
+
+			switch1port9: port@9 {
+				reg = <0x9>;
+				label = "dsa";
+				phy-mode = "2500base-x";
+				link = <&switch0port10>;
+			};
+
+			switch1port10: port@a {
+				reg = <0xa>;
+				label = "dsa";
+				phy-mode = "2500base-x";
+				link = <&switch2port9>;
+				status = "disabled";
+			};
+
+			port-sfp@a {
+				reg = <0xa>;
+				label = "sfp";
+				sfp = <&sfp>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+				status = "disabled";
+			};
+		};
+	};
+
+	switch1@2 {
+		compatible = "marvell,mv88e6085";
+		reg = <0x2 0>;
+		dsa,member = <0 1>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch1phy1_topaz: switch1phy1@11 {
+				reg = <0x11>;
+			};
+
+			switch1phy2_topaz: switch1phy2@12 {
+				reg = <0x12>;
+			};
+
+			switch1phy3_topaz: switch1phy3@13 {
+				reg = <0x13>;
+			};
+
+			switch1phy4_topaz: switch1phy4@14 {
+				reg = <0x14>;
+			};
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <0x1>;
+				label = "lan9";
+				phy-handle = <&switch1phy1_topaz>;
+			};
+
+			port@2 {
+				reg = <0x2>;
+				label = "lan10";
+				phy-handle = <&switch1phy2_topaz>;
+			};
+
+			port@3 {
+				reg = <0x3>;
+				label = "lan11";
+				phy-handle = <&switch1phy3_topaz>;
+			};
+
+			port@4 {
+				reg = <0x4>;
+				label = "lan12";
+				phy-handle = <&switch1phy4_topaz>;
+			};
+
+			port@5 {
+				reg = <0x5>;
+				label = "dsa";
+				phy-mode = "2500base-x";
+				link = <&switch0port10>;
+			};
+		};
+	};
+
+	switch2@12 {
+		compatible = "marvell,mv88e6190";
+		reg = <0x12 0>;
+		dsa,member = <0 2>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch2phy1: switch2phy1@1 {
+				reg = <0x1>;
+			};
+
+			switch2phy2: switch2phy2@2 {
+				reg = <0x2>;
+			};
+
+			switch2phy3: switch2phy3@3 {
+				reg = <0x3>;
+			};
+
+			switch2phy4: switch2phy4@4 {
+				reg = <0x4>;
+			};
+
+			switch2phy5: switch2phy5@5 {
+				reg = <0x5>;
+			};
+
+			switch2phy6: switch2phy6@6 {
+				reg = <0x6>;
+			};
+
+			switch2phy7: switch2phy7@7 {
+				reg = <0x7>;
+			};
+
+			switch2phy8: switch2phy8@8 {
+				reg = <0x8>;
+			};
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <0x1>;
+				label = "lan17";
+				phy-handle = <&switch2phy1>;
+			};
+
+			port@2 {
+				reg = <0x2>;
+				label = "lan18";
+				phy-handle = <&switch2phy2>;
+			};
+
+			port@3 {
+				reg = <0x3>;
+				label = "lan19";
+				phy-handle = <&switch2phy3>;
+			};
+
+			port@4 {
+				reg = <0x4>;
+				label = "lan20";
+				phy-handle = <&switch2phy4>;
+			};
+
+			port@5 {
+				reg = <0x5>;
+				label = "lan21";
+				phy-handle = <&switch2phy5>;
+			};
+
+			port@6 {
+				reg = <0x6>;
+				label = "lan22";
+				phy-handle = <&switch2phy6>;
+			};
+
+			port@7 {
+				reg = <0x7>;
+				label = "lan23";
+				phy-handle = <&switch2phy7>;
+			};
+
+			port@8 {
+				reg = <0x8>;
+				label = "lan24";
+				phy-handle = <&switch2phy8>;
+			};
+
+			switch2port9: port@9 {
+				reg = <0x9>;
+				label = "dsa";
+				phy-mode = "2500base-x";
+				link = <&switch1port10 &switch0port10>;
+			};
+
+			port-sfp@a {
+				reg = <0xa>;
+				label = "sfp";
+				sfp = <&sfp>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+				status = "disabled";
+			};
+		};
+	};
+
+	switch2@2 {
+		compatible = "marvell,mv88e6085";
+		reg = <0x2 0>;
+		dsa,member = <0 2>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch2phy1_topaz: switch2phy1@11 {
+				reg = <0x11>;
+			};
+
+			switch2phy2_topaz: switch2phy2@12 {
+				reg = <0x12>;
+			};
+
+			switch2phy3_topaz: switch2phy3@13 {
+				reg = <0x13>;
+			};
+
+			switch2phy4_topaz: switch2phy4@14 {
+				reg = <0x14>;
+			};
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <0x1>;
+				label = "lan17";
+				phy-handle = <&switch2phy1_topaz>;
+			};
+
+			port@2 {
+				reg = <0x2>;
+				label = "lan18";
+				phy-handle = <&switch2phy2_topaz>;
+			};
+
+			port@3 {
+				reg = <0x3>;
+				label = "lan19";
+				phy-handle = <&switch2phy3_topaz>;
+			};
+
+			port@4 {
+				reg = <0x4>;
+				label = "lan20";
+				phy-handle = <&switch2phy4_topaz>;
+			};
+
+			port@5 {
+				reg = <0x5>;
+				label = "dsa";
+				phy-mode = "2500base-x";
+				link = <&switch1port10 &switch0port10>;
+			};
+		};
+	};
+
+};
+
+&sdhci0 {
+	wp-inverted;
+	bus-width = <4>;
+	cd-gpios = <&gpionb 10 GPIO_ACTIVE_HIGH>;
+	vqmmc-supply = <&vsdc_reg>;
+	marvell,pad-type = "sd";
+	status = "okay";
+};
+
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_pins &sdio_sb_pins>;
+	non-removable;
+	bus-width = <4>;
+	marvell,pad-type = "sd";
+	vqmmc-supply = <&vsdio_reg>;
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_quad_pins &spi_cs1_pins>;
+	assigned-clocks = <&nb_periph_clk 7>;
+	assigned-clock-parents = <&tbg 1>;
+	assigned-clock-rates = <20000000>;
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0x0 0x3f0000>;
+		};
+
+		partition@3f0000 {
+			label = "u-boot-env";
+			reg = <0x180000 0x10000>;
+		};
+
+		partition@400000 {
+			label = "Rescue system";
+			reg = <0x190000 0x670000>;
+		};
+	};
+
+	moxtet@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "cznic,moxtet";
+		reg = <1>;
+		devrst-gpio = <&gpiosb 2 GPIO_ACTIVE_LOW>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+		spi-cpha;
+
+		moxtet_sfp: moxtet-sfp@0 {
+			compatible = "cznic,moxtet-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0>;
+			moxtet,id = <1>;
+			moxtet,input-mask = <0x7>;
+			moxtet,output-mask = <0x3>;
+			status = "disabled";
+		};
+	};
+};
+
+&usb3 {
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
-- 
2.16.4

