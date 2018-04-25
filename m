Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeDYLIj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:08:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeDYLHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:07:51 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 2/3] net: mvpp2: Fix clock resource by adding missing mg_core_clk
Date: Wed, 25 Apr 2018 13:07:30 +0200
Message-Id: <20180425110731.20153-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
References: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell's PPv2.2 IP needs an additional clock named "MG Core clock".
This is required on Armada 7K and 8K.

This commit adds the required clock, updates the devicetree and its
documentation accordingly, also fixing a small typo in the
marvell-mpp2.txt examples.

Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../devicetree/bindings/net/marvell-pp2.txt          |  9 +++++----
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi        |  5 +++--
 drivers/net/ethernet/marvell/mvpp2.c                 | 20 ++++++++++++++++++--
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-pp2.txt b/Documentation/devicetree/bindings/net/marvell-pp2.txt
index 1814fa13f6ab..fc019df0d863 100644
--- a/Documentation/devicetree/bindings/net/marvell-pp2.txt
+++ b/Documentation/devicetree/bindings/net/marvell-pp2.txt
@@ -21,9 +21,10 @@ Required properties:
 	- main controller clock (for both armada-375-pp2 and armada-7k-pp2)
 	- GOP clock (for both armada-375-pp2 and armada-7k-pp2)
 	- MG clock (only for armada-7k-pp2)
+	- MG Core clock (only for armada-7k-pp2)
 	- AXI clock (only for armada-7k-pp2)
-- clock-names: names of used clocks, must be "pp_clk", "gop_clk", "mg_clk"
-  and "axi_clk" (the 2 latter only for armada-7k-pp2).
+- clock-names: names of used clocks, must be "pp_clk", "gop_clk", "mg_clk",
+  "mg_core_clk" and "axi_clk" (the 3 latter only for armada-7k-pp2).
 
 The ethernet ports are represented by subnodes. At least one port is
 required.
@@ -80,8 +81,8 @@ cpm_ethernet: ethernet@0 {
 	compatible = "marvell,armada-7k-pp22";
 	reg = <0x0 0x100000>, <0x129000 0xb000>;
 	clocks = <&cpm_syscon0 1 3>, <&cpm_syscon0 1 9>,
-		 <&cpm_syscon0 1 5>, <&cpm_syscon0 1 18>;
-	clock-names = "pp_clk", "gop_clk", "gp_clk", "axi_clk";
+		 <&cpm_syscon0 1 5>, <&cpm_syscon0 1 6>, <&cpm_syscon0 1 18>;
+	clock-names = "pp_clk", "gop_clk", "mg_clk", "mg_core_clk", "axi_clk";
 
 	eth0: eth0 {
 		interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 48cad7919efa..6c137ac656e9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -38,9 +38,10 @@
 			compatible = "marvell,armada-7k-pp22";
 			reg = <0x0 0x100000>, <0x129000 0xb000>;
 			clocks = <&CP110_LABEL(clk) 1 3>, <&CP110_LABEL(clk) 1 9>,
-				 <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 18>;
+				 <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 6>,
+				 <&CP110_LABEL(clk) 1 18>;
 			clock-names = "pp_clk", "gop_clk",
-				      "mg_clk", "axi_clk";
+				      "mg_clk", "mg_core_clk", "axi_clk";
 			marvell,system-controller = <&CP110_LABEL(syscon0)>;
 			status = "disabled";
 			dma-coherent;
diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 0c2f04813d42..6a17b67a0d61 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -942,6 +942,7 @@ struct mvpp2 {
 	struct clk *pp_clk;
 	struct clk *gop_clk;
 	struct clk *mg_clk;
+	struct clk *mg_core_clk;
 	struct clk *axi_clk;
 
 	/* List of pointers to port structures */
@@ -8768,18 +8769,28 @@ static int mvpp2_probe(struct platform_device *pdev)
 			err = clk_prepare_enable(priv->mg_clk);
 			if (err < 0)
 				goto err_gop_clk;
+
+			priv->mg_core_clk = devm_clk_get(&pdev->dev, "mg_core_clk");
+			if (IS_ERR(priv->mg_core_clk)) {
+				err = PTR_ERR(priv->mg_core_clk);
+				goto err_mg_clk;
+			}
+
+			err = clk_prepare_enable(priv->mg_core_clk);
+			if (err < 0)
+				goto err_mg_clk;
 		}
 
 		priv->axi_clk = devm_clk_get(&pdev->dev, "axi_clk");
 		if (IS_ERR(priv->axi_clk)) {
 			err = PTR_ERR(priv->axi_clk);
 			if (err == -EPROBE_DEFER)
-				goto err_mg_clk;
+				goto err_mg_core_clk;
 			priv->axi_clk = NULL;
 		} else {
 			err = clk_prepare_enable(priv->axi_clk);
 			if (err < 0)
-				goto err_mg_clk;
+				goto err_mg_core_clk;
 		}
 
 		/* Get system's tclk rate */
@@ -8851,6 +8862,10 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 err_axi_clk:
 	clk_disable_unprepare(priv->axi_clk);
+
+err_mg_core_clk:
+	if (priv->hw_version == MVPP22)
+		clk_disable_unprepare(priv->mg_core_clk);
 err_mg_clk:
 	if (priv->hw_version == MVPP22)
 		clk_disable_unprepare(priv->mg_clk);
@@ -8898,6 +8913,7 @@ static int mvpp2_remove(struct platform_device *pdev)
 		return 0;
 
 	clk_disable_unprepare(priv->axi_clk);
+	clk_disable_unprepare(priv->mg_core_clk);
 	clk_disable_unprepare(priv->mg_clk);
 	clk_disable_unprepare(priv->pp_clk);
 	clk_disable_unprepare(priv->gop_clk);
-- 
2.11.0
