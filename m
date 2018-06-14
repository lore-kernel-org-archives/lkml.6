Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BEE77C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F46208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F46208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeFNGQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:16:07 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:39315 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeFNGQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:16:05 -0400
Received: from david.wu?rock-chips.com (unknown [192.168.167.87])
        by regular1.263xmail.com (Postfix) with ESMTP id 72E221E020;
        Thu, 14 Jun 2018 14:15:52 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 43B5D382;
        Thu, 14 Jun 2018 14:15:46 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: davem@davemloft.net
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <6a09b529cda04d9abaff4483c0af72f2>
X-ATTACHMENT-NUM: 0
X-SENDER: wdc@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 12107GQK1H6;
        Thu, 14 Jun 2018 14:15:49 +0800 (CST)
From:   David Wu <david.wu@rock-chips.com>
To:     davem@davemloft.net, heiko@sntech.de, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, huangtao@rock-chips.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for PX30
Date:   Thu, 14 Jun 2018 14:15:27 +0800
Message-Id: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add constants and callback functions for the dwmac on PX30 Soc.
The base structure is the same, but registers and the bits in
them are moved slightly, and add the clk_mac_speed for selecting
mac speed.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Change in v2:
- Fix some error in commit title and message

 .../devicetree/bindings/net/rockchip-dwmac.txt     |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 64 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
index 9c16ee2..3b71da7 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
@@ -4,6 +4,7 @@ The device node has following properties.
 
 Required properties:
  - compatible: should be "rockchip,<name>-gamc"
+   "rockchip,px30-gmac":   found on PX30 SoCs
    "rockchip,rk3128-gmac": found on RK312x SoCs
    "rockchip,rk3228-gmac": found on RK322x SoCs
    "rockchip,rk3288-gmac": found on RK3288 SoCs
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 13133b3..5e69dd0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -61,6 +61,7 @@ struct rk_priv_data {
 	struct clk *mac_clk_tx;
 	struct clk *clk_mac_ref;
 	struct clk *clk_mac_refout;
+	struct clk *clk_mac_speed;
 	struct clk *aclk_mac;
 	struct clk *pclk_mac;
 	struct clk *clk_phy;
@@ -83,6 +84,64 @@ struct rk_priv_data {
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
+#define PX30_GRF_GMAC_CON1		0x0904
+
+/* PX30_GRF_GMAC_CON1 */
+#define PX30_GMAC_PHY_INTF_SEL_RMII	(GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | \
+					 GRF_BIT(6))
+#define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
+#define PX30_GMAC_SPEED_100M		GRF_BIT(2)
+
+static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+
+	if (IS_ERR(bsp_priv->grf)) {
+		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
+		return;
+	}
+
+	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
+		     PX30_GMAC_PHY_INTF_SEL_RMII);
+}
+
+static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
+{
+	struct device *dev = &bsp_priv->pdev->dev;
+	int ret;
+
+	if (IS_ERR(bsp_priv->clk_mac_speed)) {
+		dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
+		return;
+	}
+
+	if (speed == 10) {
+		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
+			     PX30_GMAC_SPEED_10M);
+
+		ret = clk_set_rate(bsp_priv->clk_mac_speed, 2500000);
+		if (ret)
+			dev_err(dev, "%s: set clk_mac_speed rate 2500000 failed: %d\n",
+				__func__, ret);
+	} else if (speed == 100) {
+		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
+			     PX30_GMAC_SPEED_100M);
+
+		ret = clk_set_rate(bsp_priv->clk_mac_speed, 25000000);
+		if (ret)
+			dev_err(dev, "%s: set clk_mac_speed rate 25000000 failed: %d\n",
+				__func__, ret);
+
+	} else {
+		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
+	}
+}
+
+static const struct rk_gmac_ops px30_ops = {
+	.set_to_rmii = px30_set_to_rmii,
+	.set_rmii_speed = px30_set_rmii_speed,
+};
+
 #define RK3128_GRF_MAC_CON0	0x0168
 #define RK3128_GRF_MAC_CON1	0x016c
 
@@ -1042,6 +1101,10 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 		}
 	}
 
+	bsp_priv->clk_mac_speed = devm_clk_get(dev, "clk_mac_speed");
+	if (IS_ERR(bsp_priv->clk_mac_speed))
+		dev_err(dev, "cannot get clock %s\n", "clk_mac_speed");
+
 	if (bsp_priv->clock_input) {
 		dev_info(dev, "clock input from PHY\n");
 	} else {
@@ -1424,6 +1487,7 @@ static int rk_gmac_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rk_gmac_pm_ops, rk_gmac_suspend, rk_gmac_resume);
 
 static const struct of_device_id rk_gmac_dwmac_match[] = {
+	{ .compatible = "rockchip,px30-gmac",	.data = &px30_ops   },
 	{ .compatible = "rockchip,rk3128-gmac", .data = &rk3128_ops },
 	{ .compatible = "rockchip,rk3228-gmac", .data = &rk3228_ops },
 	{ .compatible = "rockchip,rk3288-gmac", .data = &rk3288_ops },
-- 
2.7.4


