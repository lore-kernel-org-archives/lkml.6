Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275D82229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437077AbfBNGrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:47:25 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10026 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390389AbfBNGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:47:10 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1E6a4Qv025842;
        Thu, 14 Feb 2019 07:46:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qmy1n94aj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 07:46:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 446B131;
        Thu, 14 Feb 2019 06:46:49 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 222EF2431;
        Thu, 14 Feb 2019 06:46:49 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb
 2019 07:46:48 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb 2019 07:46:48
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH  5/8] net: ethernet: stmmac: update to be compatible with MCU family (stm32f4, stm32h7)
Date:   Thu, 14 Feb 2019 07:46:00 +0100
Message-ID: <1550126763-22669-6-git-send-email-christophe.roullier@st.com>
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

Update glue codes to be compatible with MCU family.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 ++++++++++++++++++-----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index cee59e8..20a2daa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -6,7 +6,6 @@
  * License terms:  GNU General Public License (GPL), version 2
  *
  */
-
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -119,12 +118,6 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	int ret;
 
-	if (dwmac->ops->set_mode) {
-		ret = dwmac->ops->set_mode(plat_dat);
-		if (ret)
-			return ret;
-	}
-
 	ret = clk_prepare_enable(dwmac->clk_tx);
 	if (ret)
 		return ret;
@@ -139,13 +132,26 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 
 	if (dwmac->ops->clk_prepare) {
 		ret = dwmac->ops->clk_prepare(dwmac, true);
+		if (ret)
+			goto err_clk_disable;
+	}
+
+	if (dwmac->ops->set_mode) {
+		ret = dwmac->ops->set_mode(plat_dat);
 		if (ret) {
-			clk_disable_unprepare(dwmac->clk_rx);
-			clk_disable_unprepare(dwmac->clk_tx);
+			if (dwmac->ops->clk_prepare)
+				dwmac->ops->clk_prepare(dwmac, false);
+			goto err_clk_disable;
 		}
 	}
 
 	return ret;
+
+err_clk_disable:
+	clk_disable_unprepare(dwmac->clk_rx);
+	clk_disable_unprepare(dwmac->clk_tx);
+
+	return ret;
 }
 
 static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
@@ -240,7 +246,19 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val);
+				 dwmac->ops->syscfg_eth_mask, val << 23);
+}
+
+static int stm32mcu_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
+{
+	int ret = 0;
+
+	if (prepare)
+		ret = clk_prepare_enable(dwmac->syscfg_clk);
+	else
+		clk_disable_unprepare(dwmac->syscfg_clk);
+
+	return ret;
 }
 
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac)
@@ -347,6 +365,17 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	return err;
 }
 
+static int stm32mcu_parse_data(struct stm32_dwmac *dwmac,
+			       struct device *dev)
+{
+	/*  Clock for sysconfig */
+	dwmac->syscfg_clk = devm_clk_get(dev, "syscfg-clk");
+	if (IS_ERR(dwmac->syscfg_clk))
+		dev_warn(dev, "No syscfg clock provided...\n");
+
+	return 0;
+}
+
 static int stm32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -493,7 +522,9 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 
 static struct stm32_ops stm32mcu_dwmac_data = {
 	.set_mode = stm32mcu_set_mode,
+	.clk_prepare = stm32mcu_clk_prepare,
 	.suspend = stm32mcu_suspend,
+	.parse_data = stm32mcu_parse_data,
 	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
 };
 
-- 
2.7.4

