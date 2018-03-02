Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeCBTnV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:43:21 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34769 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeCBTnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:43:18 -0500
X-Google-Smtp-Source: AG47ELs9RvW3ULe6bLw4YdC76L/YCA6R1zEkYfwQzIeQSGx5fzqmdjTvXAuhNbB7yBWxAEwMIQy9Rg==
From: Vivek Unune <npcomplete13@gmail.com>
To: florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH v2] ARM: dts: BCM5301X: Add support for Linksys EA9500
Date: Fri,  2 Mar 2018 14:41:55 -0500
Message-Id: <20180302194155.50808-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware Info
-------------

Processor	- Broadcom BCM4709C0KFEBG dual-core @ 1.4 GHz
Switch		- BCM53012 in BCM4709C0KFEBG & external BCM53125
DDR3 RAM	- 256 MB
Flash		- 128 MB (Toshiba TC58BVG0S3HTA00)
2.4GHz		- BCM4366 4×4 2.4/5G single chip 802.11ac SoC
Power Amp	- Skyworks SE2623L 2.4 GHz power amp (x4)
5GHz x 2	- BCM4366 4×4 2.4/5G single chip 802.11ac SoC
Power Amp	- PLX Technology PEX8603 3-lane, 3-port PCIe switch
Ports		- 8 Ports, 1 WAN Ports
Antennas	- 8 Antennas
Serial Port	- @J6 [GND,TX,RX] (VCC NC)    115200 8n1

Tested with OpenWrt built with DSA driver and Kernel v4.14

Note:

"make sure that port 0 of the internal switch is not accidentally
configured back to untagged since that would cause problem when
terminating the VLAN tag on the SW side." - Florian Fainelli [1]

This can be ensured by running following command in OpenWrt:

bridge vlan add vid 1 dev extsw pvid tagged

[1] https://www.spinics.net/lists/arm-kernel/msg590992.html

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
Changes in v2:
 - Properly define mdio mux, internal mdio, external mdio, mii bus
 - Now we define usb3 phy as a mdio node connected to internal mdio,
   thanks to work done by Rafał Miłecki on the bcm usb3 phy mdio driver
 - Define external SW as a mdio-mii node connected to external mdio
---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts | 239 +++++++++++++++++++++++-
 arch/arm/boot/dts/bcm47094.dtsi                 |   6 +-
 arch/arm/boot/dts/bcm5301x.dtsi                 |  55 +++++-
 3 files changed, 288 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index b6750f7..5f53207 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -7,7 +7,7 @@
 /dts-v1/;
 
 #include "bcm47094.dtsi"
-#include "bcm5301x-nand-cs0-bch8.dtsi"
+#include "bcm5301x-nand-cs0-bch1.dtsi"
 
 / {
 	compatible = "linksys,panamera", "brcm,bcm47094", "brcm,bcm4708";
@@ -32,5 +32,242 @@
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
+
+		rfkill {
+				label = "WiFi";
+				linux,code = <KEY_RFKILL>;
+				gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
+		};
+
+		reset {
+				label = "Reset";
+				linux,code = <KEY_RESTART>;
+				gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		wps {
+			label = "bcm53xx:white:wps";
+			gpios = <&chipcommon 22 GPIO_ACTIVE_LOW>;
+		};
+
+		usb2 {
+			label = "bcm53xx:green:usb2";
+			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ohci_port2>, <&ehci_port2>;
+			linux,default-trigger = "usbport";
+		};
+
+		usb3 {
+			label = "bcm53xx:green:usb3";
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>;
+			linux,default-trigger = "usbport";
+		};
+
+		power {
+			label = "bcm53xx:white:power";
+			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		wifi-disabled {
+			label = "bcm53xx:amber:wifi-disabled";
+			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
+		};
+
+		wifi-enabled {
+			label = "bcm53xx:white:wifi-enabled";
+			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar1 {
+			label = "bcm53xx:white:bluebar1";
+			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar2 {
+			label = "bcm53xx:white:bluebar2";
+			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar3 {
+			label = "bcm53xx:white:bluebar3";
+			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
+		};
+
+		bluebar4 {
+			label = "bcm53xx:white:bluebar4";
+			gpios = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar5 {
+			label = "bcm53xx:white:bluebar5";
+			gpios = <&chipcommon 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar6 {
+			label = "bcm53xx:white:bluebar6";
+			gpios = <&chipcommon 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar7 {
+			label = "bcm53xx:white:bluebar7";
+			gpios = <&chipcommon 21 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar8 {
+			label = "bcm53xx:white:bluebar8";
+			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&usb2 {
+	vcc-gpio = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
+};
+
+&mdio_mii_mux {
+	status = "okay";
+};
+
+&mdio_ext {
+	status = "okay";
+};
+
+&srab {
+	compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
+	status = "okay";
+	dsa,member = <0 0>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+			label = "lan7";
+		};
+
+		port@2 {
+			reg = <2>;
+			label = "lan4";
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "lan8";
+		};
+
+		port@4 {
+			reg = <4>;
+			label = "wan";
+		};
+
+		port@5 {
+			reg = <5>;
+			ethernet = <&gmac0>;
+			label = "cpu";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		port@7 {
+			reg = <7>;
+			ethernet = <&gmac1>;
+			label = "cpu";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		port@8 {
+			reg = <8>;
+			ethernet = <&gmac2>;
+			label = "cpu";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		sw0_p0: port@0 {
+			reg = <0>;
+			label = "extsw";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
 	};
 };
+
+&mdio_mii {
+	status = "okay";
+
+		switch@0  {
+			compatible = "brcm,bcm53125";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reset-gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+			reset-names = "robo_reset";
+			reg = <0>;
+			dsa,member = <1 0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "lan1";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "lan5";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "lan2";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "lan6";
+				};
+
+				port@4 {
+					reg = <4>;
+					label = "lan3";
+				};
+
+				sw1_p8: port@8 {
+					reg = <8>;
+					ethernet = <&sw0_p0>;
+					label = "cpu";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+};
+
diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/bcm47094.dtsi
index 4840a78..8f3ec57 100644
--- a/arch/arm/boot/dts/bcm47094.dtsi
+++ b/arch/arm/boot/dts/bcm47094.dtsi
@@ -6,10 +6,8 @@
 
 #include "bcm4708.dtsi"
 
-/ {
-	usb3_phy: usb3-phy {
-		compatible = "brcm,ns-bx-usb3-phy";
-	};
+&usb3_phy {
+	compatible = "brcm,ns-bx-usb3-phy";
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9a076c4..9e4386a 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -154,13 +154,6 @@
 		clock-names = "phy-ref-clk";
 	};
 
-	usb3_phy: usb3-phy {
-		compatible = "brcm,ns-ax-usb3-phy";
-		reg = <0x18105000 0x1000>, <0x18003000 0x1000>;
-		reg-names = "dmp", "ccb-mii";
-		#phy-cells = <0>;
-	};
-
 	axi@18000000 {
 		compatible = "brcm,bus-axi";
 		reg = <0x18000000 0x1000>;
@@ -359,7 +352,55 @@
 		reg = <0x18003000 0x8>;
 		#size-cells = <1>;
 		#address-cells = <0>;
+	};
+
+	mdio-bus-mux {
+		compatible = "mdio-mux-mmioreg";
+		mdio-parent-bus = <&mdio>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x18003000 0x4>;
+		mux-mask = <0x200>;
+
+		mdio_int: mdio@0 {		/* BIT(9) = 0 => internal mdio */
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb3_phy: usb3-phy@10 {
+				compatible = "brcm,ns-ax-usb3-phy";
+				reg = <0x10>;
+				usb3-dmp-syscon = <&usb3_dmp>;
+				#phy-cells = <0>;
+			};
+		};
+
+		mdio_ext: mdio@200 {		/* BIT(9) = 1 => external mdio */
+			reg = <0x200>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+	};
+
+	mdio_mii_mux: mdio-mii-mux {
+		compatible = "mdio-mux-mmioreg";
+		mdio-parent-bus = <&mdio_ext>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x1800c1c0 0x4>;
+		mux-mask = <0xc0>;		/* BIT(6) = mdc, BIT(7) = mdio */
 		status = "disabled";
+
+		mdio_mii: mdio-mii@0 {
+			reg = <0x0>;		/* Enable mii function */
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	usb3_dmp: syscon@18105000 {
+		reg = <0x18105000 0x1000>;
 	};
 
 	i2c0: i2c@18009000 {
-- 
2.9.3
