Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758261AbeD0MM5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:12:57 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:49448 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758026AbeD0MJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:09:32 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v4 04/14] ARM: dts: am57xx-idk: Use pinctrl group from dra7-mmc-iodelay.dtsi to select pulldown
Date: Fri, 27 Apr 2018 17:38:55 +0530
Message-ID: <20180427120905.3665-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 18aa0f4bca701cb078a6 ("ARM: dts: am57xx-idk: Select pull down
for mmc1_clk line in default mode") modified mmc1_pins_default
pinctrl group in am57xx-idk-common.dtsi in order to change the CLK
line to PIN_INPUT_PULLDOWN. However instead of modifying the pinctrl
group, use the new pinctrl group "mmc1_pins_default_no_clk_pu" in
dra7-mmc-iodelay.dtsi added specifically to be used for CLK line without
external pull up.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts         |  3 ++-
 arch/arm/boot/dts/am572x-idk.dts         |  3 ++-
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 11 -----------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index a2555140babc..f7de03eb4377 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -10,6 +10,7 @@
 #include "dra72x.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include "dra7-mmc-iodelay.dtsi"
 #include "dra72x-mmc-iodelay.dtsi"
 #include "am57xx-idk-common.dtsi"
 
@@ -102,7 +103,7 @@
 
 &mmc1 {
 	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
-	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
 	pinctrl-2 = <&mmc1_pins_sdr12>;
 	pinctrl-3 = <&mmc1_pins_sdr25>;
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 3a02ed720957..98b42ef33c46 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include "dra74x.dtsi"
+#include "dra7-mmc-iodelay.dtsi"
 #include "dra74x-mmc-iodelay.dtsi"
 #include "am572x-idk-common.dtsi"
 
@@ -20,7 +21,7 @@
 
 &mmc1 {
 	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
-	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
 	pinctrl-2 = <&mmc1_pins_sdr12>;
 	pinctrl-3 = <&mmc1_pins_sdr25>;
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43cdf523a8a0..43a6d0590f7c 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -115,17 +115,6 @@
 			DRA7XX_CORE_IOPAD(0x37d4, MUX_MODE15 | PULL_UP)	/* dcan1_rx.off */
 		>;
 	};
-
-	mmc1_pins_default: mmc1_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
-			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
-			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
-			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
-			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
-			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
-		>;
-	};
 };
 
 &i2c1 {
-- 
2.17.0
