Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeEVS4J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:56:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52862 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbeEVS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:56:07 -0400
X-Google-Smtp-Source: AB8JxZp0sIh7gZ2HLRAx2ZDqZ+GyHsap1ovhEE5KkVkEHPUqOBaBObyhlWlr8r0lE88PA3NuBtTfTw==
From: Scott Branden <scott.branden@broadcom.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] arm64: dts: stingray: move common board components to stingray-board-base
Date: Tue, 22 May 2018 11:55:42 -0700
Message-Id: <1527015342-9317-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common board components from base bcm958742 dtsi file to new
stingray-board-base dtsi file so they can be shared between many stingray
boards following common design.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 35 +--------------
 .../dts/broadcom/stingray/stingray-board-base.dtsi | 51 ++++++++++++++++++++++
 2 files changed, 52 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
index cacc25e..d74f6df 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
@@ -30,20 +30,9 @@
  *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include "stingray.dtsi"
+#include "stingray-board-base.dtsi"
 
 / {
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	aliases {
-		serial0 = &uart1;
-		serial1 = &uart0;
-		serial2 = &uart2;
-		serial3 = &uart3;
-	};
-
 	sdio0_vddo_ctrl_reg: sdio0_vddo_ctrl {
 		compatible = "regulator-gpio";
 		regulator-name = "sdio0_vddo_ctrl_reg";
@@ -67,23 +56,6 @@
 	};
 };
 
-&memory { /* Default DRAM banks */
-	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
-	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
-};
-
-&mdio_mux_iproc {
-	mdio@10 {
-		gphy0: eth-phy@10 {
-			reg = <0x10>;
-		};
-	};
-};
-
-&uart1 {
-	status = "okay";
-};
-
 &pwm {
 	status = "okay";
 };
@@ -111,8 +83,6 @@
 };
 
 &enet {
-	phy-mode = "rgmii-id";
-	phy-handle = <&gphy0>;
 	status = "okay";
 };
 
@@ -133,13 +103,10 @@
 
 &sdio0 {
 	vqmmc-supply = <&sdio0_vddo_ctrl_reg>;
-	non-removable;
-	full-pwr-cycle;
 	status = "okay";
 };
 
 &sdio1 {
 	vqmmc-supply = <&sdio1_vddo_ctrl_reg>;
-	full-pwr-cycle;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
new file mode 100644
index 0000000..82a2471
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *  Copyright(c) 2016-2018 Broadcom
+ */
+
+#include "stingray.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart0;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&memory { /* Default DRAM banks */
+	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
+	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
+};
+
+&enet {
+	phy-mode = "rgmii-id";
+	phy-handle = <&gphy0>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&sdio0 {
+	non-removable;
+	full-pwr-cycle;
+};
+
+&sdio1 {
+	full-pwr-cycle;
+};
+
+&mdio_mux_iproc {
+	mdio@10 {
+		gphy0: eth-phy@10 {
+			reg = <0x10>;
+		};
+	};
+};
-- 
2.5.0
