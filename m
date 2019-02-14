Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C5C10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7869B222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437113AbfBNGrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:47:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35612 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729871AbfBNGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:47:08 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1E6a8rn025862;
        Thu, 14 Feb 2019 07:46:46 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qmy1n94a7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 07:46:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 273D131;
        Thu, 14 Feb 2019 06:46:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EABF32432;
        Thu, 14 Feb 2019 06:46:45 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb
 2019 07:46:45 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb 2019 07:46:45
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH  2/8] net: ethernet: stmmac: update to support all PHY config for stm32mp157c.
Date:   Thu, 14 Feb 2019 07:45:57 +0100
Message-ID: <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update glue codes to support all PHY config on stm32mp157c
 PHY_MODE	(MII,GMII, RMII, RGMII) and in normal, PHY wo crystal (25Mhz),
PHY wo crystal (50Mhz), No 125Mhz from PHY config.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 102 +++++++++++++++++-----
 1 file changed, 82 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index d1cf145..cee59e8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -25,9 +25,24 @@
 
 #define SYSCFG_MCU_ETH_MASK		BIT(23)
 #define SYSCFG_MP1_ETH_MASK		GENMASK(23, 16)
+#define SYSCFG_PMCCLRR_OFFSET		0x40
 
 #define SYSCFG_PMCR_ETH_CLK_SEL		BIT(16)
 #define SYSCFG_PMCR_ETH_REF_CLK_SEL	BIT(17)
+
+/*  Ethernet PHY interface selection in register SYSCFG Configuration
+ *------------------------------------------
+ * src	 |BIT(23)| BIT(22)| BIT(21)|BIT(20)|
+ *------------------------------------------
+ * MII   |   0	 |   0	  |   0    |   1   |
+ *------------------------------------------
+ * GMII  |   0	 |   0	  |   0    |   0   |
+ *------------------------------------------
+ * RGMII |   0	 |   0	  |   1	   |  n/a  |
+ *------------------------------------------
+ * RMII  |   1	 |   0	  |   0	   |  n/a  |
+ *------------------------------------------
+ */
 #define SYSCFG_PMCR_ETH_SEL_MII		BIT(20)
 #define SYSCFG_PMCR_ETH_SEL_RGMII	BIT(21)
 #define SYSCFG_PMCR_ETH_SEL_RMII	BIT(23)
@@ -35,15 +50,54 @@
 #define SYSCFG_MCU_ETH_SEL_MII		0
 #define SYSCFG_MCU_ETH_SEL_RMII		1
 
+/* STM32MP1 register definitions
+ *
+ * Below table summarizes the clock requirement and clock sources for
+ * supported phy interface modes.
+ * __________________________________________________________________________
+ *|PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125Mhz from PHY|
+ *|         |        |      25MHz    |        50MHz       |                  |
+ * ---------------------------------------------------------------------------
+ *|  MII    |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
+ *|         |        |		     |                    |		     |
+ * ---------------------------------------------------------------------------
+ *|  GMII   |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
+ *|         |        |               |                    |		     |
+ * ---------------------------------------------------------------------------
+ *| RGMII   |	 -   |     eth-ck    |	      n/a	  |  eth-ck (no pin) |
+ *|         |        |               |                    |  st,eth_clk_sel  |
+ * ---------------------------------------------------------------------------
+ *| RMII    |	 -   |     eth-ck    |	    eth-ck        |	  n/a        |
+ *|         |        |		     | st,eth_ref_clk_sel |		     |
+ * ---------------------------------------------------------------------------
+ *
+ * BIT(17) : set this bit in RMII mode when you have PHY without crystal 50MHz
+ * BIT(16) : set this bit in GMII/RGMII PHY when you do not want use 125Mhz
+ * from PHY
+ *-----------------------------------------------------
+ * src	 |         BIT(17)       |       BIT(16)      |
+ *-----------------------------------------------------
+ * MII   |           n/a	 |         n/a        |
+ *-----------------------------------------------------
+ * GMII  |           n/a         |   st,eth_clk_sel   |
+ *-----------------------------------------------------
+ * RGMII |           n/a         |   st,eth_clk_sel   |
+ *-----------------------------------------------------
+ * RMII  |   st,eth_ref_clk_sel	 |         n/a        |
+ *-----------------------------------------------------
+ *
+ */
+
 struct stm32_dwmac {
 	struct clk *clk_tx;
 	struct clk *clk_rx;
 	struct clk *clk_eth_ck;
 	struct clk *clk_ethstp;
 	struct clk *syscfg_clk;
-	bool int_phyclk;	/* Clock from RCC to drive PHY */
+	int eth_clk_sel_reg;
+	int eth_ref_clk_sel_reg;
 	int irq_pwr_wakeup;
-	u32 mode_reg;		/* MAC glue-logic mode register */
+	u32 mode_reg;		 /* MAC glue-logic mode register */
 	struct regmap *regmap;
 	u32 speed;
 	const struct stm32_ops *ops;
@@ -103,7 +157,7 @@ static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
 		if (ret)
 			return ret;
 
-		if (dwmac->int_phyclk) {
+		if (dwmac->clk_eth_ck) {
 			ret = clk_prepare_enable(dwmac->clk_eth_ck);
 			if (ret) {
 				clk_disable_unprepare(dwmac->syscfg_clk);
@@ -112,7 +166,7 @@ static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
 		}
 	} else {
 		clk_disable_unprepare(dwmac->syscfg_clk);
-		if (dwmac->int_phyclk)
+		if (dwmac->clk_eth_ck)
 			clk_disable_unprepare(dwmac->clk_eth_ck);
 	}
 	return ret;
@@ -122,7 +176,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	u32 reg = dwmac->mode_reg;
-	int val;
+	int val, ret;
 
 	switch (plat_dat->interface) {
 	case PHY_INTERFACE_MODE_MII:
@@ -131,19 +185,19 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
-		if (dwmac->int_phyclk)
+		if (dwmac->eth_clk_sel_reg)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = SYSCFG_PMCR_ETH_SEL_RMII;
-		if (dwmac->int_phyclk)
+		if (dwmac->eth_ref_clk_sel_reg)
 			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 		val = SYSCFG_PMCR_ETH_SEL_RGMII;
-		if (dwmac->int_phyclk)
+		if (dwmac->eth_clk_sel_reg)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
 		break;
@@ -154,6 +208,11 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		return -EINVAL;
 	}
 
+	/* Need to update PMCCLRR (clear register) */
+	ret = regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
+			   dwmac->ops->syscfg_eth_mask);
+
+	/* Update PMCSETR (set register) */
 	return regmap_update_bits(dwmac->regmap, reg,
 				 dwmac->ops->syscfg_eth_mask, val);
 }
@@ -237,22 +296,25 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	struct device_node *np = dev->of_node;
 	int err = 0;
 
-	dwmac->int_phyclk = of_property_read_bool(np, "st,int-phyclk");
+	/* Gigabit Ethernet 125MHz clock selection. */
+	dwmac->eth_clk_sel_reg = of_property_read_bool(np, "st,eth_clk_sel");
 
-	/* Check if internal clk from RCC selected */
-	if (dwmac->int_phyclk) {
-		/*  Get ETH_CLK clocks */
-		dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
-		if (IS_ERR(dwmac->clk_eth_ck)) {
-			dev_err(dev, "No ETH CK clock provided...\n");
-			return PTR_ERR(dwmac->clk_eth_ck);
-		}
+	/* Ethernet 50Mhz RMII clock selection */
+	dwmac->eth_ref_clk_sel_reg =
+		of_property_read_bool(np, "st,eth_ref_clk_sel");
+
+	/*  Get ETH_CLK clocks */
+	dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
+	if (IS_ERR(dwmac->clk_eth_ck)) {
+		dev_warn(dev, "No phy clock provided...\n");
+		dwmac->clk_eth_ck = NULL;
 	}
 
 	/*  Clock used for low power mode */
 	dwmac->clk_ethstp = devm_clk_get(dev, "ethstp");
 	if (IS_ERR(dwmac->clk_ethstp)) {
-		dev_err(dev, "No ETH peripheral clock provided for CStop mode ...\n");
+		dev_err(dev,
+			"No ETH peripheral clock provided for CStop mode ...\n");
 		return PTR_ERR(dwmac->clk_ethstp);
 	}
 
@@ -268,7 +330,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	 */
 	dwmac->irq_pwr_wakeup = platform_get_irq_byname(pdev,
 							"stm32_pwr_wakeup");
-	if (!dwmac->int_phyclk && dwmac->irq_pwr_wakeup >= 0) {
+	if (!dwmac->clk_eth_ck && dwmac->irq_pwr_wakeup >= 0) {
 		err = device_init_wakeup(&pdev->dev, true);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to init wake up irq\n");
@@ -370,7 +432,7 @@ static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
 
 	clk_disable_unprepare(dwmac->clk_tx);
 	clk_disable_unprepare(dwmac->syscfg_clk);
-	if (dwmac->int_phyclk)
+	if (dwmac->clk_eth_ck)
 		clk_disable_unprepare(dwmac->clk_eth_ck);
 
 	return ret;
-- 
2.7.4

