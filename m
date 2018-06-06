Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14EC960767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932412AbeFFP5k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:57:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57268 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeFFPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:54:22 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
Subject: [PATCH 2/8] ARM: dts: am335x-sl50: use phy-phandle declarations
Date: Wed,  6 Jun 2018 17:54:07 +0200
Message-Id: <20180606155413.23542-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606155413.23542-1-enric.balletbo@collabora.com>
References: <20180606155413.23542-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy-phandle is now a preferred method to reference a PHY device. The new
method also allows you to specify a reset gpio which is required for
this board.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 6d78bf828bbf..58fe84f2ec8b 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -253,6 +253,8 @@
 			/* MDIO */
 			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
 			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			/* Ethernet */
+			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE7)	/* Ethernet_nRST - gpmc_ad14.gpio1_14 */
 		>;
 	};
 
@@ -324,7 +326,6 @@
 			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)	/* nKbdOnC - gpmc_ad10.gpio0_26 */
 			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdInt - gpmc_ad12.gpio1_12 */
 			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdReset - gpmc_ad13.gpio1_13 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE7)	/* nDispReset - gpmc_ad14.gpio1_14 */
 			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* USB1_enPower - gpmc_a1.gpio1_17 */
 			/* PDI Bus - Battery system */
 			AM33XX_IOPAD(0x840, PIN_INPUT_PULLUP | MUX_MODE7)	/* nBattReset  gpmc_a0.gpio1_16 */
@@ -553,13 +554,8 @@
 };
 
 &cpsw_emac0 {
-	phy_id = <&davinci_mdio>, <0>;
-	phy-mode = "mii";
-};
-
-&cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "mii";
+	phy-handle = <&ethphy0>;
 };
 
 &mac {
@@ -574,6 +570,12 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&davinci_mdio_default>;
 	pinctrl-1 = <&davinci_mdio_sleep>;
+	reset-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+	reset-delay-us = <100>;   /* PHY datasheet states 100us min */
+
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
 };
 
 &sham {
-- 
2.17.1
