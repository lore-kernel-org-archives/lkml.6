Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80235C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153AA223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="ZPN1FEoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153AA223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbeKMXmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:42:38 -0500
Received: from mail.nic.cz ([217.31.204.67]:44890 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733258AbeKMXmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:42:37 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id E3DE162C0B;
        Tue, 13 Nov 2018 14:44:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1542116660; bh=v0ETVszvOwnCZ/Tb+oRgAjuR5oGW6cM2tHcHRwN0x7w=;
        h=From:To:Date;
        b=ZPN1FEoAFn9osWn+hiDn0txu+xIspxqaufpF6GqBGhe35lDlM6S21tJOfEwXlWySR
         D5KV16f71Ul4QEAss5s6WLNI4D8RmMMEne/8g1D8BgBli4AjvJqp7rmXK12Q8EgjBK
         SHMkgUufYf6n/2Szi25g6apXzvfoCuwV951iA6rE=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC] ARM64: dts: marvell: Add DTS file for Turris Mox
Date:   Tue, 13 Nov 2018 14:44:08 +0100
Message-Id: <20181113134408.5681-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a RFC, please do not merge.

This adds basic support for the Turris Mox board from CZ.NIC.

Turris Mox is as modular router based on the Armada 3720 SOC (same as
EspressoBin).

The basic module can be extended by different modules.
When those modules are connected, U-Boot has to let kernel know via
device-tree. Since modules can be connected in different order and
some modules can be connected multiple times (up to three 8-port
switch modules can be connected), using dtb overlays would result in
too files.

I therefore chose to put all the possible connected devices in one dts
and disable them. If U-Boot finds these modules, it fixes the device
tree accrodginly, by enabling some nodes (setting status to "okay") and
by setting some addresses and references.

For example there are 6 switch nodes - three for 8-port switch module
and three for 4-port switch module. This is because another switch
(either 8-port or 4-port) can be connected to a 8-port switch, in DSA,
and interface names have to be defined (from lan1 to lan24).

Another way (for defining switch nodes) would have to be either:
  - including a file where switch nodes are defined, which would need
    #defining lan interface names (and some other things), and #undefing
    them after the #include
  - defining a macro for switch nodes
  - have a separate DTBs for each possible configuration (this would
    result in too many DTBs)
  - not defining these nodes in device-tree at all, instead creating
    them in U-Boot when patching the device-tree (I actually tried this,
    but the resulting code in U-Boot was horrible)

Please let me know if doing it this way is acceptable, or if I should
try something different (and if yes, what?).

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>
---
 .../arm/marvell/armada-3720-turris-mox.txt    |   6 +
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../dts/marvell/armada-3720-turris-mox.dts    | 838 ++++++++++++++++++
 4 files changed, 846 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index f6e60e7f6c11..81b57260b110 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1348,6 +1348,7 @@ ARM/CZ.NIC TURRIS MOX SUPPORT
 M:	Marek Behun <marek.behun@nic.cz>
 W:	http://mox.turris.cz
 S:	Maintained
+F:	arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
 F:	include/mfd/moxtet.h
 F:	drivers/gpio/gpio-moxtet.c
 F:	drivers/mfd/moxtet.c
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 5633676fa9d0..51782b31b441 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
new file mode 100644
index 000000000000..1315c59ecef3
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -0,0 +1,838 @@
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
+	sdhci1_pwrseq: sdhci1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpionb 19 GPIO_ACTIVE_HIGH>;
+		status = "okay";
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
+	mmc-pwrseq = <&sdhci1_pwrseq>;
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
+		spi-max-frequency = <20000000>;
+
+		partition@0 {
+			label = "secure-firmware";
+			reg = <0x0 0x20000>;
+		};
+
+		partition@20000 {
+			label = "u-boot";
+			reg = <0x20000 0x160000>;
+		};
+
+		partition@180000 {
+			label = "u-boot-env";
+			reg = <0x180000 0x10000>;
+		};
+
+		partition@190000 {
+			label = "Rescue system";
+			reg = <0x190000 0x660000>;
+		};
+
+		partition@7f0000 {
+			label = "dtb";
+			reg = <0x7f0000 0x10000>;
+		};
+	};
+
+	moxtet@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "cznic,moxtet";
+		reg = <1>;
+		devrst-gpio = <&gpiosb 2 GPIO_ACTIVE_LOW>;
+		spi-max-frequency = <10000000>;
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
+&usb2 {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
-- 
2.18.1

