Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCON5A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:57:00 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36199 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeCON46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:56:58 -0400
X-Google-Smtp-Source: AG47ELsJ4GDNKrIrGiRjN3cqoy1uQaQfSSojsOmN8dBLh2t8yu07i14YTaSOVvC4Zt/8n20+4yoYvQ==
From: Vivek Unune <npcomplete13@gmail.com>
To: florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH] ARM: dts: BCM5301X:Make usb3 phy use mdio phy driver
Date: Thu, 15 Mar 2018 09:56:47 -0400
Message-Id: <20180315135647.48456-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.11.0
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
 arch/arm/boot/dts/bcm47094.dtsi |  7 ++++---
 arch/arm/boot/dts/bcm5301x.dtsi | 34 ++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 11 deletions(-)

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
index 9a076c409f4e..7ba6533f7615 100644
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
@@ -359,7 +352,32 @@
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
+		mdio_int: mdio@0 {
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
+	};
+
+	usb3_dmp: syscon@18105000 {
+		reg = <0x18105000 0x1000>;
 	};
 
 	i2c0: i2c@18009000 {
-- 
2.11.0
