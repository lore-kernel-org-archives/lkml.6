Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935998AbeEYHru (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:47:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15367 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935922AbeEYHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:47:33 -0400
From: Christophe Roullier <christophe.roullier@st.com>
To: <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <peppe.cavallaro@st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <christophe.roullier@st.com>
Subject: [PATCH V0:net-next 1/4] net: ethernet: stmmac: add adaptation for stm32mp157c.
Date: Fri, 25 May 2018 09:46:38 +0200
Message-ID: <1527234401-15812-2-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
References: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glue codes to support stm32mp157c device and stay
compatible with stm32 mcu familly

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 267 ++++++++++++++++++++--
 1 file changed, 252 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 9e6db16..7e2e79d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -16,49 +16,180 @@
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/stmmac.h>
 
 #include "stmmac_platform.h"
 
-#define MII_PHY_SEL_MASK	BIT(23)
+#define SYSCFG_MCU_ETH_MASK		BIT(23)
+#define SYSCFG_MP1_ETH_MASK		GENMASK(23, 16)
+
+#define SYSCFG_PMCR_ETH_CLK_SEL		BIT(16)
+#define SYSCFG_PMCR_ETH_REF_CLK_SEL	BIT(17)
+#define SYSCFG_PMCR_ETH_SEL_MII		BIT(20)
+#define SYSCFG_PMCR_ETH_SEL_RGMII	BIT(21)
+#define SYSCFG_PMCR_ETH_SEL_RMII	BIT(23)
+#define SYSCFG_PMCR_ETH_SEL_GMII	0
+#define SYSCFG_MCU_ETH_SEL_MII		0
+#define SYSCFG_MCU_ETH_SEL_RMII		1
 
 struct stm32_dwmac {
 	struct clk *clk_tx;
 	struct clk *clk_rx;
+	struct clk *clk_eth_ck;
+	struct clk *clk_ethstp;
+	struct clk *syscfg_clk;
+	bool int_phyclk;	/* Clock from RCC to drive PHY */
 	u32 mode_reg;		/* MAC glue-logic mode register */
 	struct regmap *regmap;
 	u32 speed;
+	const struct stm32_ops *ops;
+	struct device *dev;
+};
+
+struct stm32_ops {
+	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
+	int (*clk_prepare)(struct stm32_dwmac *dwmac, bool prepare);
+	int (*suspend)(struct stm32_dwmac *dwmac);
+	void (*resume)(struct stm32_dwmac *dwmac);
+	int (*parse_data)(struct stm32_dwmac *dwmac,
+			  struct device *dev);
+	u32 syscfg_eth_mask;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
-	u32 reg = dwmac->mode_reg;
-	u32 val;
 	int ret;
 
-	val = (plat_dat->interface == PHY_INTERFACE_MODE_MII) ? 0 : 1;
-	ret = regmap_update_bits(dwmac->regmap, reg, MII_PHY_SEL_MASK, val);
-	if (ret)
-		return ret;
+	if (dwmac->ops->set_mode) {
+		ret = dwmac->ops->set_mode(plat_dat);
+		if (ret)
+			return ret;
+	}
 
 	ret = clk_prepare_enable(dwmac->clk_tx);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(dwmac->clk_rx);
-	if (ret)
-		clk_disable_unprepare(dwmac->clk_tx);
+	if (!dwmac->dev->power.is_suspended) {
+		ret = clk_prepare_enable(dwmac->clk_rx);
+		if (ret) {
+			clk_disable_unprepare(dwmac->clk_tx);
+			return ret;
+		}
+	}
+
+	if (dwmac->ops->clk_prepare) {
+		ret = dwmac->ops->clk_prepare(dwmac, true);
+		if (ret) {
+			clk_disable_unprepare(dwmac->clk_rx);
+			clk_disable_unprepare(dwmac->clk_tx);
+		}
+	}
 
 	return ret;
 }
 
+static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
+{
+	int ret = 0;
+
+	if (prepare) {
+		ret = clk_prepare_enable(dwmac->syscfg_clk);
+		if (ret)
+			return ret;
+
+		if (dwmac->int_phyclk) {
+			ret = clk_prepare_enable(dwmac->clk_eth_ck);
+			if (ret) {
+				clk_disable_unprepare(dwmac->syscfg_clk);
+				return ret;
+			}
+		}
+	} else {
+		clk_disable_unprepare(dwmac->syscfg_clk);
+		if (dwmac->int_phyclk)
+			clk_disable_unprepare(dwmac->clk_eth_ck);
+	}
+	return ret;
+}
+
+static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
+{
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+	u32 reg = dwmac->mode_reg;
+	int val;
+
+	switch (plat_dat->interface) {
+	case PHY_INTERFACE_MODE_MII:
+		val = SYSCFG_PMCR_ETH_SEL_MII;
+		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
+		break;
+	case PHY_INTERFACE_MODE_GMII:
+		val = SYSCFG_PMCR_ETH_SEL_GMII;
+		if (dwmac->int_phyclk)
+			val |= SYSCFG_PMCR_ETH_CLK_SEL;
+		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val = SYSCFG_PMCR_ETH_SEL_RMII;
+		if (dwmac->int_phyclk)
+			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
+		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+		val = SYSCFG_PMCR_ETH_SEL_RGMII;
+		if (dwmac->int_phyclk)
+			val |= SYSCFG_PMCR_ETH_CLK_SEL;
+		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
+		break;
+	default:
+		pr_debug("SYSCFG init :  Do not manage %d interface\n",
+			 plat_dat->interface);
+		/* Do not manage others interfaces */
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(dwmac->regmap, reg,
+				 dwmac->ops->syscfg_eth_mask, val);
+}
+
+static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
+{
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+	u32 reg = dwmac->mode_reg;
+	int val;
+
+	switch (plat_dat->interface) {
+	case PHY_INTERFACE_MODE_MII:
+		val = SYSCFG_MCU_ETH_SEL_MII;
+		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val = SYSCFG_MCU_ETH_SEL_RMII;
+		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
+		break;
+	default:
+		pr_debug("SYSCFG init :  Do not manage %d interface\n",
+			 plat_dat->interface);
+		/* Do not manage others interfaces */
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(dwmac->regmap, reg,
+				 dwmac->ops->syscfg_eth_mask, val);
+}
+
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac)
 {
 	clk_disable_unprepare(dwmac->clk_tx);
 	clk_disable_unprepare(dwmac->clk_rx);
+
+	if (dwmac->ops->clk_prepare)
+		dwmac->ops->clk_prepare(dwmac, false);
 }
 
 static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
@@ -70,15 +201,22 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 	/*  Get TX/RX clocks */
 	dwmac->clk_tx = devm_clk_get(dev, "mac-clk-tx");
 	if (IS_ERR(dwmac->clk_tx)) {
-		dev_err(dev, "No tx clock provided...\n");
+		dev_err(dev, "No ETH Tx clock provided...\n");
 		return PTR_ERR(dwmac->clk_tx);
 	}
+
 	dwmac->clk_rx = devm_clk_get(dev, "mac-clk-rx");
 	if (IS_ERR(dwmac->clk_rx)) {
-		dev_err(dev, "No rx clock provided...\n");
+		dev_err(dev, "No ETH Rx clock provided...\n");
 		return PTR_ERR(dwmac->clk_rx);
 	}
 
+	if (dwmac->ops->parse_data) {
+		err = dwmac->ops->parse_data(dwmac, dev);
+		if (err)
+			return err;
+	}
+
 	/* Get mode register */
 	dwmac->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
 	if (IS_ERR(dwmac->regmap))
@@ -91,11 +229,46 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 	return err;
 }
 
+static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
+			       struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+
+	dwmac->int_phyclk = of_property_read_bool(np, "st,int-phyclk");
+
+	/* Check if internal clk from RCC selected */
+	if (dwmac->int_phyclk) {
+		/*  Get ETH_CLK clocks */
+		dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
+		if (IS_ERR(dwmac->clk_eth_ck)) {
+			dev_err(dev, "No ETH CK clock provided...\n");
+			return PTR_ERR(dwmac->clk_eth_ck);
+		}
+	}
+
+	/*  Clock used for low power mode */
+	dwmac->clk_ethstp = devm_clk_get(dev, "ethstp");
+	if (IS_ERR(dwmac->clk_ethstp)) {
+		dev_err(dev, "No ETH peripheral clock provided for CStop mode ...\n");
+		return PTR_ERR(dwmac->clk_ethstp);
+	}
+
+	/*  Clock for sysconfig */
+	dwmac->syscfg_clk = devm_clk_get(dev, "syscfg-clk");
+	if (IS_ERR(dwmac->syscfg_clk)) {
+		dev_err(dev, "No syscfg clock provided...\n");
+		return PTR_ERR(dwmac->syscfg_clk);
+	}
+
+	return 0;
+}
+
 static int stm32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct stm32_dwmac *dwmac;
+	const struct stm32_ops *data;
 	int ret;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -112,6 +285,16 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 		goto err_remove_config_dt;
 	}
 
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data) {
+		dev_err(&pdev->dev, "no of match data provided\n");
+		ret = -EINVAL;
+		goto err_remove_config_dt;
+	}
+
+	dwmac->ops = data;
+	dwmac->dev = &pdev->dev;
+
 	ret = stm32_dwmac_parse_data(dwmac, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to parse OF data\n");
@@ -149,15 +332,48 @@ static int stm32_dwmac_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
+{
+	int ret = 0;
+
+	ret = clk_prepare_enable(dwmac->clk_ethstp);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(dwmac->clk_tx);
+	clk_disable_unprepare(dwmac->syscfg_clk);
+	if (dwmac->int_phyclk)
+		clk_disable_unprepare(dwmac->clk_eth_ck);
+
+	return ret;
+}
+
+static void stm32mp1_resume(struct stm32_dwmac *dwmac)
+{
+	clk_disable_unprepare(dwmac->clk_ethstp);
+}
+
+static int stm32mcu_suspend(struct stm32_dwmac *dwmac)
+{
+	clk_disable_unprepare(dwmac->clk_tx);
+	clk_disable_unprepare(dwmac->clk_rx);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int stm32_dwmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stm32_dwmac *dwmac = priv->plat->bsp_priv;
+
 	int ret;
 
 	ret = stmmac_suspend(dev);
-	stm32_dwmac_clk_disable(priv->plat->bsp_priv);
+
+	if (dwmac->ops->suspend)
+		ret = dwmac->ops->suspend(dwmac);
 
 	return ret;
 }
@@ -166,8 +382,12 @@ static int stm32_dwmac_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stm32_dwmac *dwmac = priv->plat->bsp_priv;
 	int ret;
 
+	if (dwmac->ops->resume)
+		dwmac->ops->resume(dwmac);
+
 	ret = stm32_dwmac_init(priv->plat);
 	if (ret)
 		return ret;
@@ -181,8 +401,24 @@ static int stm32_dwmac_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 	stm32_dwmac_suspend, stm32_dwmac_resume);
 
+static struct stm32_ops stm32mcu_dwmac_data = {
+	.set_mode = stm32mcu_set_mode,
+	.suspend = stm32mcu_suspend,
+	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
+};
+
+static struct stm32_ops stm32mp1_dwmac_data = {
+	.set_mode = stm32mp1_set_mode,
+	.clk_prepare = stm32mp1_clk_prepare,
+	.suspend = stm32mp1_suspend,
+	.resume = stm32mp1_resume,
+	.parse_data = stm32mp1_parse_data,
+	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+};
+
 static const struct of_device_id stm32_dwmac_match[] = {
-	{ .compatible = "st,stm32-dwmac"},
+	{ .compatible = "st,stm32-dwmac", .data = &stm32mcu_dwmac_data},
+	{ .compatible = "st,stm32mp1-dwmac", .data = &stm32mp1_dwmac_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dwmac_match);
@@ -199,5 +435,6 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 module_platform_driver(stm32_dwmac_driver);
 
 MODULE_AUTHOR("Alexandre Torgue <alexandre.torgue@gmail.com>");
-MODULE_DESCRIPTION("STMicroelectronics MCU DWMAC Specific Glue layer");
+MODULE_AUTHOR("Christophe Roullier <christophe.roullier@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 DWMAC Specific Glue layer");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
