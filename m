Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeDSNWu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:22:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57453 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753180AbeDSNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:22:46 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 4/4] rtc: stm32: get DBP register and mask from DT st,syscfg property
Date: Thu, 19 Apr 2018 15:21:43 +0200
Message-ID: <1524144103-21432-5-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC driver should not be aware of the PWR registers offset and bits
position. Furthermore, we can imagine that DBP relative register and bit
mask could change depending on the SoC.
So this patch introduces 2 parameters, dbp_reg and dbp_mask, allowing to
get PWR_CR and PWR_CR_DBP from device tree. And it prepares next RTC
version, backup domain write protection is disabled only if needed.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 59 +++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 6a06078..de49b5b 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -85,23 +85,17 @@
 #define RTC_WPR_2ND_KEY			0x53
 #define RTC_WPR_WRONG_KEY		0xFF
 
-/*
- * RTC registers are protected against parasitic write access.
- * PWR_CR_DBP bit must be set to enable write access to RTC registers.
- */
-/* STM32_PWR_CR */
-#define PWR_CR				0x00
-/* STM32_PWR_CR bit field */
-#define PWR_CR_DBP			BIT(8)
-
 struct stm32_rtc_data {
 	bool has_pclk;
+	bool need_dbp;
 };
 
 struct stm32_rtc {
 	struct rtc_device *rtc_dev;
 	void __iomem *base;
 	struct regmap *dbp;
+	unsigned int dbp_reg;
+	unsigned int dbp_mask;
 	struct stm32_rtc_data *data;
 	struct clk *pclk;
 	struct clk *rtc_ck;
@@ -498,10 +492,12 @@ static const struct rtc_class_ops stm32_rtc_ops = {
 
 static const struct stm32_rtc_data stm32_rtc_data = {
 	.has_pclk = false,
+	.need_dbp = true,
 };
 
 static const struct stm32_rtc_data stm32h7_rtc_data = {
 	.has_pclk = true,
+	.need_dbp = true,
 };
 
 static const struct of_device_id stm32_rtc_of_match[] = {
@@ -576,7 +572,6 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 {
 	struct stm32_rtc *rtc;
 	struct resource *res;
-	const struct of_device_id *match;
 	int ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -588,15 +583,31 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
-	rtc->dbp = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						   "st,syscfg");
-	if (IS_ERR(rtc->dbp)) {
-		dev_err(&pdev->dev, "no st,syscfg\n");
-		return PTR_ERR(rtc->dbp);
-	}
+	rtc->data = (struct stm32_rtc_data *)
+		    of_device_get_match_data(&pdev->dev);
+
+	if (rtc->data->need_dbp) {
+		rtc->dbp = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							   "st,syscfg");
+		if (IS_ERR(rtc->dbp)) {
+			dev_err(&pdev->dev, "no st,syscfg\n");
+			return PTR_ERR(rtc->dbp);
+		}
 
-	match = of_match_device(stm32_rtc_of_match, &pdev->dev);
-	rtc->data = (struct stm32_rtc_data *)match->data;
+		ret = of_property_read_u32_index(pdev->dev.of_node, "st,syscfg",
+						 1, &rtc->dbp_reg);
+		if (ret) {
+			dev_err(&pdev->dev, "can't read DBP register offset\n");
+			return ret;
+		}
+
+		ret = of_property_read_u32_index(pdev->dev.of_node, "st,syscfg",
+						 2, &rtc->dbp_mask);
+		if (ret) {
+			dev_err(&pdev->dev, "can't read DBP register mask\n");
+			return ret;
+		}
+	}
 
 	if (!rtc->data->has_pclk) {
 		rtc->pclk = NULL;
@@ -624,7 +635,9 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, PWR_CR_DBP);
+	if (rtc->data->need_dbp)
+		regmap_update_bits(rtc->dbp, rtc->dbp_reg,
+				   rtc->dbp_mask, rtc->dbp_mask);
 
 	/*
 	 * After a system reset, RTC_ISR.INITS flag can be read to check if
@@ -684,7 +697,8 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		clk_disable_unprepare(rtc->pclk);
 	clk_disable_unprepare(rtc->rtc_ck);
 
-	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
+	if (rtc->data->need_dbp)
+		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
 
 	device_init_wakeup(&pdev->dev, false);
 
@@ -707,8 +721,9 @@ static int stm32_rtc_remove(struct platform_device *pdev)
 	if (rtc->data->has_pclk)
 		clk_disable_unprepare(rtc->pclk);
 
-	/* Enable backup domain write protection */
-	regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, 0);
+	/* Enable backup domain write protection if needed */
+	if (rtc->data->need_dbp)
+		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
 
 	device_init_wakeup(&pdev->dev, false);
 
-- 
2.7.4
