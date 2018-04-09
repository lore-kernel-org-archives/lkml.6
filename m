Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeDIWb7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 18:31:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36893 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeDIWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 18:31:56 -0400
X-Google-Smtp-Source: AIpwx4+Pz/e84xvSB0KMWYAZ0XCpSWkmuISYvJU4AmB+Hfcu8asAHF+IhKaN4ihSntt5GHY1m6+dyg==
From: Vivek Unune <npcomplete13@gmail.com>
To: florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH v2] ARM: dts: BCM5301X: Make usb3 phy use mdio phy driver
Date: Mon,  9 Apr 2018 18:31:53 -0400
Message-Id: <20180409223153.41893-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180315135647.48456-1-npcomplete13@gmail.com>
References: <20180315135647.48456-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, usb3 phy in bcm5301x.dtsi uses platform driver which
requires register range "ccb-mii" <0x18003000 0x1000>. This range
overlaps with mdio cmd and param registers (<0x18003000 0x8>).
Essentially, the platform driver partly acts like a mdio bus
driver, hence to use of this register range.

In some Northstar devices like Linksys EA9500, secondary switch
is connected via external mdio. The only way to access and
configure the external switch is via mdio bus. When we enable the
mdio bus in it's current state, the mdio bus and any child buses
fail to register because of the register range overlap.

On Northstar, the usb3 phy is connected at address 0x10 on the
internal mdio bus. This change moves the usb3_phy node and makes
it a child node of internal mdio bus.

Thanks to Rafał Miłecki's commit af850e14a7ae
("phy: bcm-ns-usb3: add MDIO driver using proper bus layer") the
same usb3 platform driver can now act as usb3 phy mdio driver.

Tested on Linksys Panamera (EA9500)

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
v2: Disabled usb3_phy by default, then enabled in dts where
    necessary
---
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        |  4 +++
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        |  4 +++
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |  4 +++
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    |  4 +++
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |  4 +++
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  4 +++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  4 +++
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     |  4 +++
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  4 +++
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        |  4 +++
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |  4 +++
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |  4 +++
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |  4 +++
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |  4 +++
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |  4 +++
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |  4 +++
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |  4 +++
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts       |  4 +++
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        |  4 +++
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |  4 +++
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |  4 +++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  4 +++
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts    |  4 +++
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |  4 +++
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |  4 +++
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  4 +++
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |  4 +++
 arch/arm/boot/dts/bcm47094.dtsi                    |  7 +++--
 arch/arm/boot/dts/bcm5301x.dtsi                    | 35 +++++++++++++++++-----
 arch/arm/boot/dts/bcm94708.dts                     |  4 +++
 arch/arm/boot/dts/bcm94709.dts                     |  4 +++
 arch/arm/boot/dts/bcm953012er.dts                  |  4 +++
 arch/arm/boot/dts/bcm953012hr.dts                  |  4 +++
 arch/arm/boot/dts/bcm953012k.dts                   |  4 +++
 35 files changed, 175 insertions(+), 11 deletions(-)
 create mode 100755 patchdts.sh

diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
index 4175174e589a..c9e49e63db9f 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
@@ -101,3 +101,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
index 8fa033fea959..7e6848980098 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
@@ -91,3 +91,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index 8b64caabaad8..6663bdc27163 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -147,3 +147,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
index 126ab5867772..8ffb6f49a87f 100644
--- a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
@@ -39,3 +39,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
index f591b0f256d8..837ab26f28a3 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
@@ -58,3 +58,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index 50d65d8fbd9a..d1f7154ad622 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -59,3 +59,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index d7c34fa72b4b..d9b518ec3e62 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -91,3 +91,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index bb66cebe0bd8..9ae81d053ba1 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -94,3 +94,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 83a4c60bb431..913624b54696 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -159,3 +159,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 0800a964f2fe..fa2b795c1e80 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -85,3 +85,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index c2af33eb47de..6a58344feedb 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -129,3 +129,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index 87ea6ba664f5..bc25c7b6ed82 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -115,3 +115,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
index 9b5759849983..04f6b798342a 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
@@ -58,3 +58,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
index ba1c19b1b3eb..747eccdf2581 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
@@ -106,3 +106,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
index 3ed8de42cb48..5915533e58fb 100644
--- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
+++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
@@ -100,3 +100,7 @@
 &usb2 {
 	vcc-gpio = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index df473cc41572..5a37580191b4 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -73,3 +73,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index 92058c73ee59..5c1221bb68de 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -128,3 +128,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
index 3d1d9c2c4efc..fa08eecae510 100644
--- a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
+++ b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
@@ -40,3 +40,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index f43ab4721456..0046ad0fab23 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -112,3 +112,7 @@
 &usb3 {
 	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index d266131652ad..7ba26ef0c924 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -182,3 +182,7 @@
 &usb3 {
 	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index ec4a50e440f6..aa37323cf045 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -105,3 +105,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 7cc7d344fe5b..808d7efcc113 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -120,3 +120,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index b6750f70dffb..d9f538c3cddb 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -34,3 +34,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
index ecd22a246746..e337f65cd047 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
@@ -61,3 +61,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
index 15ffb1abc440..f75ec243c405 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
@@ -61,3 +61,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index bc1d1e10d4ac..a3852f85f119 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -101,3 +101,7 @@
 &spi_nor {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index 859929973158..578fa1a29bd5 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -92,3 +92,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/bcm47094.dtsi
index 4840a782fc05..f7c3e274b354 100644
--- a/arch/arm/boot/dts/bcm47094.dtsi
+++ b/arch/arm/boot/dts/bcm47094.dtsi
@@ -7,9 +7,10 @@
 #include "bcm4708.dtsi"
 
 / {
-	usb3_phy: usb3-phy {
-		compatible = "brcm,ns-bx-usb3-phy";
-	};
+};
+
+&usb3_phy {
+	compatible = "brcm,ns-bx-usb3-phy";
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9a076c409f4e..f65aca8e0fc0 100644
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
@@ -359,7 +352,33 @@
 		reg = <0x18003000 0x8>;
 		#size-cells = <1>;
 		#address-cells = <0>;
-		status = "disabled";
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
+		mdio@0 {
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb3_phy: usb3-phy@10 {
+				compatible = "brcm,ns-ax-usb3-phy";
+				reg = <0x10>;
+				usb3-dmp-syscon = <&usb3_dmp>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
+	usb3_dmp: syscon@18105000 {
+		reg = <0x18105000 0x1000>;
 	};
 
 	i2c0: i2c@18009000 {
diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/bcm94708.dts
index 2e08c895f281..24a80584d8b2 100644
--- a/arch/arm/boot/dts/bcm94708.dts
+++ b/arch/arm/boot/dts/bcm94708.dts
@@ -42,3 +42,7 @@
 		reg = <0x00000000 0x08000000>;
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm94709.dts b/arch/arm/boot/dts/bcm94709.dts
index c37616c67edc..ff778540ae87 100644
--- a/arch/arm/boot/dts/bcm94709.dts
+++ b/arch/arm/boot/dts/bcm94709.dts
@@ -42,3 +42,7 @@
 		reg = <0x00000000 0x08000000>;
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/bcm953012er.dts
index 40e694bfe5ca..4f23dc300bc3 100644
--- a/arch/arm/boot/dts/bcm953012er.dts
+++ b/arch/arm/boot/dts/bcm953012er.dts
@@ -90,3 +90,7 @@
 		};
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
index 3076e81699cf..42b72f3bf575 100644
--- a/arch/arm/boot/dts/bcm953012hr.dts
+++ b/arch/arm/boot/dts/bcm953012hr.dts
@@ -95,3 +95,7 @@
 		reg = <0x00700000 0x00900000>;
 	};
 };
+
+&usb3_phy {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index 79c168e2714b..f06f3c094c51 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -113,3 +113,7 @@
 &uart1 {
 	status = "okay";
 };
+
+&usb3_phy {
+        status = "okay";
+};
-- 
2.11.0
