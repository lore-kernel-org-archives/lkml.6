Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeBBSHC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:07:02 -0500
Received: from hermes.aosc.io ([199.195.250.187]:54886 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753874AbeBBSFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:05:44 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s compatible and add V3 one
Date: Sat,  3 Feb 2018 02:04:54 +0800
Message-Id: <20180202180456.60378-2-icenowy@aosc.io>
In-Reply-To: <20180202180456.60378-1-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3s is just a differently packaged version of the V3 chip, which has
a MAC with the same capability with H3. The V3s just doesn't wire out
the external MII/RMII/RGMII bus. (V3 wired out it).

Drop the compatible string of V3s in the dwmac-sun8i driver, and add a
V3 compatible string, which has all capabilities.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 10 +++++-----
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c     | 10 ++++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index 3d6d5fa0c4d5..158124e8ee71 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -7,7 +7,7 @@ Required properties:
 - compatible: must be one of the following string:
 		"allwinner,sun8i-a83t-emac"
 		"allwinner,sun8i-h3-emac"
-		"allwinner,sun8i-v3s-emac"
+		"allwinner,sun8i-v3-emac"
 		"allwinner,sun50i-a64-emac"
 - reg: address and length of the register for the device.
 - interrupts: interrupt for the device
@@ -23,7 +23,7 @@ Required properties:
 - syscon: A phandle to the syscon of the SoC with one of the following
  compatible string:
   - allwinner,sun8i-h3-system-controller
-  - allwinner,sun8i-v3s-system-controller
+  - allwinner,sun8i-v3-system-controller
   - allwinner,sun50i-a64-system-controller
   - allwinner,sun8i-a83t-system-controller
 
@@ -35,7 +35,7 @@ external PHY.
 
 Optional properties for the following compatibles:
   - "allwinner,sun8i-h3-emac",
-  - "allwinner,sun8i-v3s-emac":
+  - "allwinner,sun8i-v3-emac":
 - allwinner,leds-active-low: EPHY LEDs are active low
 
 Required child node of emac:
@@ -51,7 +51,7 @@ of the mdio node. See phy.txt for the generic PHY bindings.
 The following compatibles require that the emac node have a mdio-mux child
 node called "mdio-mux":
   - "allwinner,sun8i-h3-emac"
-  - "allwinner,sun8i-v3s-emac":
+  - "allwinner,sun8i-v3-emac":
 Required properties for the mdio-mux node:
   - compatible = "allwinner,sun8i-h3-mdio-mux"
   - mdio-parent-bus: a phandle to EMAC mdio
@@ -64,7 +64,7 @@ Required properties for the mdio-mux children node:
 The following compatibles require a PHY node representing the integrated
 PHY, under the integrated MDIO bus node if an mdio-mux node is used:
   - "allwinner,sun8i-h3-emac",
-  - "allwinner,sun8i-v3s-emac":
+  - "allwinner,sun8i-v3-emac":
 
 Additional information regarding generic multiplexer properties can be found
 at Documentation/devicetree/bindings/net/mdio-mux.txt
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index a3fa65b1ca8e..fd0519cf27b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -84,10 +84,12 @@ static const struct emac_variant emac_variant_h3 = {
 	.support_rgmii = true
 };
 
-static const struct emac_variant emac_variant_v3s = {
+static const struct emac_variant emac_variant_v3 = {
 	.default_syscon_value = 0x38000,
 	.soc_has_internal_phy = true,
-	.support_mii = true
+	.support_mii = true,
+	.support_rmii = true,
+	.support_rgmii = true
 };
 
 static const struct emac_variant emac_variant_a83t = {
@@ -1074,8 +1076,8 @@ return ret;
 static const struct of_device_id sun8i_dwmac_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-emac",
 		.data = &emac_variant_h3 },
-	{ .compatible = "allwinner,sun8i-v3s-emac",
-		.data = &emac_variant_v3s },
+	{ .compatible = "allwinner,sun8i-v3-emac",
+		.data = &emac_variant_v3 },
 	{ .compatible = "allwinner,sun8i-a83t-emac",
 		.data = &emac_variant_a83t },
 	{ .compatible = "allwinner,sun50i-a64-emac",
-- 
2.15.1
