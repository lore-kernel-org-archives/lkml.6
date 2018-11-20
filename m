Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA7C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46E52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46E52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKTUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:42:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50739 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727791AbeKTUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:42:13 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAKA8kap014360;
        Tue, 20 Nov 2018 11:13:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nvg1t8380-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 20 Nov 2018 11:13:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 943A33A;
        Tue, 20 Nov 2018 10:13:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F7F3266D;
        Tue, 20 Nov 2018 10:13:04 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 20 Nov 2018 11:13:03
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/3] iio: adc: stm32-adc: add power management support
Date:   Tue, 20 Nov 2018 11:12:31 +0100
Message-ID: <1542708752-26163-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542708752-26163-1-git-send-email-fabrice.gasnier@st.com>
References: <1542708752-26163-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime PM & sleep. Move all regulator and clock management
to dedicated HW start/stop routines. Then rely on (runtime) PM OPS to
call them.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 182 +++++++++++++++++++++++++++------------
 drivers/iio/adc/stm32-adc.c      | 169 ++++++++++++++++++++++++++++--------
 2 files changed, 258 insertions(+), 93 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index ca432e7..2327ec1 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -16,6 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -48,15 +49,19 @@
 #define STM32H7_CKMODE_SHIFT		16
 #define STM32H7_CKMODE_MASK		GENMASK(17, 16)
 
+#define STM32_ADC_CORE_SLEEP_DELAY_MS	2000
+
 /**
  * stm32_adc_common_regs - stm32 common registers, compatible dependent data
  * @csr:	common status register offset
+ * @ccr:	common control register offset
  * @eoc1:	adc1 end of conversion flag in @csr
  * @eoc2:	adc2 end of conversion flag in @csr
  * @eoc3:	adc3 end of conversion flag in @csr
  */
 struct stm32_adc_common_regs {
 	u32 csr;
+	u32 ccr;
 	u32 eoc1_msk;
 	u32 eoc2_msk;
 	u32 eoc3_msk;
@@ -85,6 +90,7 @@ struct stm32_adc_priv_cfg {
  * @vref:		regulator reference
  * @cfg:		compatible configuration data
  * @common:		common data for all ADC instances
+ * @ccr_bak:		backup CCR in low power mode
  */
 struct stm32_adc_priv {
 	int				irq[STM32_ADC_MAX_ADCS];
@@ -94,6 +100,7 @@ struct stm32_adc_priv {
 	struct regulator		*vref;
 	const struct stm32_adc_priv_cfg	*cfg;
 	struct stm32_adc_common		common;
+	u32				ccr_bak;
 };
 
 static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
@@ -265,6 +272,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 /* STM32F4 common registers definitions */
 static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
 	.csr = STM32F4_ADC_CSR,
+	.ccr = STM32F4_ADC_CCR,
 	.eoc1_msk = STM32F4_EOC1,
 	.eoc2_msk = STM32F4_EOC2,
 	.eoc3_msk = STM32F4_EOC3,
@@ -273,6 +281,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 /* STM32H7 common registers definitions */
 static const struct stm32_adc_common_regs stm32h7_adc_common_regs = {
 	.csr = STM32H7_ADC_CSR,
+	.ccr = STM32H7_ADC_CCR,
 	.eoc1_msk = STM32H7_EOC_MST,
 	.eoc2_msk = STM32H7_EOC_SLV,
 };
@@ -379,6 +388,61 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 	}
 }
 
+static int stm32_adc_core_hw_start(struct device *dev)
+{
+	struct stm32_adc_common *common = dev_get_drvdata(dev);
+	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
+	int ret;
+
+	ret = regulator_enable(priv->vref);
+	if (ret < 0) {
+		dev_err(dev, "vref enable failed\n");
+		return ret;
+	}
+
+	if (priv->bclk) {
+		ret = clk_prepare_enable(priv->bclk);
+		if (ret < 0) {
+			dev_err(dev, "bus clk enable failed\n");
+			goto err_regulator_disable;
+		}
+	}
+
+	if (priv->aclk) {
+		ret = clk_prepare_enable(priv->aclk);
+		if (ret < 0) {
+			dev_err(dev, "adc clk enable failed\n");
+			goto err_bclk_disable;
+		}
+	}
+
+	writel_relaxed(priv->ccr_bak, priv->common.base + priv->cfg->regs->ccr);
+
+	return 0;
+
+err_bclk_disable:
+	if (priv->bclk)
+		clk_disable_unprepare(priv->bclk);
+err_regulator_disable:
+	regulator_disable(priv->vref);
+
+	return ret;
+}
+
+static void stm32_adc_core_hw_stop(struct device *dev)
+{
+	struct stm32_adc_common *common = dev_get_drvdata(dev);
+	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
+
+	/* Backup CCR that may be lost (depends on power state to achieve) */
+	priv->ccr_bak = readl_relaxed(priv->common.base + priv->cfg->regs->ccr);
+	if (priv->aclk)
+		clk_disable_unprepare(priv->aclk);
+	if (priv->bclk)
+		clk_disable_unprepare(priv->bclk);
+	regulator_disable(priv->vref);
+}
+
 static int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct stm32_adc_priv *priv;
@@ -393,6 +457,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	platform_set_drvdata(pdev, &priv->common);
 
 	priv->cfg = (const struct stm32_adc_priv_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
@@ -410,67 +475,51 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regulator_enable(priv->vref);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "vref enable failed\n");
-		return ret;
-	}
-
-	ret = regulator_get_voltage(priv->vref);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "vref get voltage failed, %d\n", ret);
-		goto err_regulator_disable;
-	}
-	priv->common.vref_mv = ret / 1000;
-	dev_dbg(&pdev->dev, "vref+=%dmV\n", priv->common.vref_mv);
-
 	priv->aclk = devm_clk_get(&pdev->dev, "adc");
 	if (IS_ERR(priv->aclk)) {
 		ret = PTR_ERR(priv->aclk);
-		if (ret == -ENOENT) {
-			priv->aclk = NULL;
-		} else {
+		if (ret != -ENOENT) {
 			dev_err(&pdev->dev, "Can't get 'adc' clock\n");
-			goto err_regulator_disable;
-		}
-	}
-
-	if (priv->aclk) {
-		ret = clk_prepare_enable(priv->aclk);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "adc clk enable failed\n");
-			goto err_regulator_disable;
+			return ret;
 		}
+		priv->aclk = NULL;
 	}
 
 	priv->bclk = devm_clk_get(&pdev->dev, "bus");
 	if (IS_ERR(priv->bclk)) {
 		ret = PTR_ERR(priv->bclk);
-		if (ret == -ENOENT) {
-			priv->bclk = NULL;
-		} else {
+		if (ret != -ENOENT) {
 			dev_err(&pdev->dev, "Can't get 'bus' clock\n");
-			goto err_aclk_disable;
+			return ret;
 		}
+		priv->bclk = NULL;
 	}
 
-	if (priv->bclk) {
-		ret = clk_prepare_enable(priv->bclk);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "adc clk enable failed\n");
-			goto err_aclk_disable;
-		}
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, STM32_ADC_CORE_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	ret = stm32_adc_core_hw_start(dev);
+	if (ret)
+		goto err_pm_stop;
+
+	ret = regulator_get_voltage(priv->vref);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "vref get voltage failed, %d\n", ret);
+		goto err_hw_stop;
 	}
+	priv->common.vref_mv = ret / 1000;
+	dev_dbg(&pdev->dev, "vref+=%dmV\n", priv->common.vref_mv);
 
 	ret = priv->cfg->clk_sel(pdev, priv);
 	if (ret < 0)
-		goto err_bclk_disable;
+		goto err_hw_stop;
 
 	ret = stm32_adc_irq_probe(pdev, priv);
 	if (ret < 0)
-		goto err_bclk_disable;
-
-	platform_set_drvdata(pdev, &priv->common);
+		goto err_hw_stop;
 
 	ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
 	if (ret < 0) {
@@ -478,21 +527,19 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		goto err_irq_remove;
 	}
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 err_irq_remove:
 	stm32_adc_irq_remove(pdev, priv);
-
-err_bclk_disable:
-	if (priv->bclk)
-		clk_disable_unprepare(priv->bclk);
-
-err_aclk_disable:
-	if (priv->aclk)
-		clk_disable_unprepare(priv->aclk);
-
-err_regulator_disable:
-	regulator_disable(priv->vref);
+err_hw_stop:
+	stm32_adc_core_hw_stop(dev);
+err_pm_stop:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 
 	return ret;
 }
@@ -502,17 +549,39 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	struct stm32_adc_common *common = platform_get_drvdata(pdev);
 	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
 
+	pm_runtime_get_sync(&pdev->dev);
 	of_platform_depopulate(&pdev->dev);
 	stm32_adc_irq_remove(pdev, priv);
-	if (priv->bclk)
-		clk_disable_unprepare(priv->bclk);
-	if (priv->aclk)
-		clk_disable_unprepare(priv->aclk);
-	regulator_disable(priv->vref);
+	stm32_adc_core_hw_stop(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
 }
 
+#if defined(CONFIG_PM)
+static int stm32_adc_core_runtime_suspend(struct device *dev)
+{
+	stm32_adc_core_hw_stop(dev);
+
+	return 0;
+}
+
+static int stm32_adc_core_runtime_resume(struct device *dev)
+{
+	return stm32_adc_core_hw_start(dev);
+}
+#endif
+
+static const struct dev_pm_ops stm32_adc_core_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
+			   stm32_adc_core_runtime_resume,
+			   NULL)
+};
+
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.regs = &stm32f4_adc_common_regs,
 	.clk_sel = stm32f4_adc_clk_sel,
@@ -552,6 +621,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	.driver = {
 		.name = "stm32-adc-core",
 		.of_match_table = stm32_adc_of_match,
+		.pm = &stm32_adc_core_pm_ops,
 	},
 };
 module_platform_driver(stm32_adc_driver);
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index dca8733..32c9c61 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -22,6 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -148,6 +149,7 @@ enum stm32h7_adc_dmngt {
 #define STM32_ADC_MAX_SMP		7	/* SMPx range is [0..7] */
 #define STM32_ADC_TIMEOUT_US		100000
 #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
+#define STM32_ADC_HW_STOP_DELAY_MS	100
 
 #define STM32_DMA_BUFFER_SIZE		PAGE_SIZE
 
@@ -623,6 +625,47 @@ static void stm32_adc_set_res(struct stm32_adc *adc)
 	stm32_adc_writel(adc, res->reg, val);
 }
 
+static int stm32_adc_hw_stop(struct device *dev)
+{
+	struct stm32_adc *adc = dev_get_drvdata(dev);
+
+	if (adc->cfg->unprepare)
+		adc->cfg->unprepare(adc);
+
+	if (adc->clk)
+		clk_disable_unprepare(adc->clk);
+
+	return 0;
+}
+
+static int stm32_adc_hw_start(struct device *dev)
+{
+	struct stm32_adc *adc = dev_get_drvdata(dev);
+	int ret;
+
+	if (adc->clk) {
+		ret = clk_prepare_enable(adc->clk);
+		if (ret)
+			return ret;
+	}
+
+	stm32_adc_set_res(adc);
+
+	if (adc->cfg->prepare) {
+		ret = adc->cfg->prepare(adc);
+		if (ret)
+			goto err_clk_dis;
+	}
+
+	return 0;
+
+err_clk_dis:
+	if (adc->clk)
+		clk_disable_unprepare(adc->clk);
+
+	return ret;
+}
+
 /**
  * stm32f4_adc_start_conv() - Start conversions for regular channels.
  * @adc: stm32 adc instance
@@ -1171,6 +1214,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 				 int *res)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	const struct stm32_adc_regspec *regs = adc->cfg->regs;
 	long timeout;
 	u32 val;
@@ -1180,10 +1224,10 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	adc->bufi = 0;
 
-	if (adc->cfg->prepare) {
-		ret = adc->cfg->prepare(adc);
-		if (ret)
-			return ret;
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
 	}
 
 	/* Apply sampling time settings */
@@ -1221,8 +1265,8 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	stm32_adc_conv_irq_disable(adc);
 
-	if (adc->cfg->unprepare)
-		adc->cfg->unprepare(adc);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -1330,15 +1374,22 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
 				      const unsigned long *scan_mask)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
 	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
 
 	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
-	if (ret)
-		return ret;
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
-	return 0;
+	return ret;
 }
 
 static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
@@ -1368,12 +1419,23 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
 					unsigned *readval)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
 
 	if (!readval)
 		stm32_adc_writel(adc, reg, writeval);
 	else
 		*readval = stm32_adc_readl(adc, reg);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 }
 
@@ -1459,18 +1521,19 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
 static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
-	if (adc->cfg->prepare) {
-		ret = adc->cfg->prepare(adc);
-		if (ret)
-			return ret;
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
 	}
 
 	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Can't set trigger\n");
-		goto err_unprepare;
+		goto err_pm_put;
 	}
 
 	ret = stm32_adc_dma_start(indio_dev);
@@ -1498,9 +1561,9 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 		dmaengine_terminate_all(adc->dma_chan);
 err_clr_trig:
 	stm32_adc_set_trig(indio_dev, NULL);
-err_unprepare:
-	if (adc->cfg->unprepare)
-		adc->cfg->unprepare(adc);
+err_pm_put:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -1508,6 +1571,7 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
 	adc->cfg->stop_conv(adc);
@@ -1524,8 +1588,8 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");
 
-	if (adc->cfg->unprepare)
-		adc->cfg->unprepare(adc);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -1864,26 +1928,17 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (adc->clk) {
-		ret = clk_prepare_enable(adc->clk);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "clk enable failed\n");
-			return ret;
-		}
-	}
-
 	ret = stm32_adc_of_get_resolution(indio_dev);
 	if (ret < 0)
-		goto err_clk_disable;
-	stm32_adc_set_res(adc);
+		return ret;
 
 	ret = stm32_adc_chan_of_init(indio_dev);
 	if (ret < 0)
-		goto err_clk_disable;
+		return ret;
 
 	ret = stm32_adc_dma_request(indio_dev);
 	if (ret < 0)
-		goto err_clk_disable;
+		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time,
@@ -1894,15 +1949,35 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		goto err_dma_disable;
 	}
 
+	/* Get stm32-adc-core PM online */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, STM32_ADC_HW_STOP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	ret = stm32_adc_hw_start(dev);
+	if (ret)
+		goto err_buffer_cleanup;
+
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "iio dev register failed\n");
-		goto err_buffer_cleanup;
+		goto err_hw_stop;
 	}
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
+err_hw_stop:
+	stm32_adc_hw_stop(dev);
+
 err_buffer_cleanup:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
 err_dma_disable:
@@ -1912,9 +1987,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
 				  adc->rx_buf, adc->rx_dma_buf);
 		dma_release_channel(adc->dma_chan);
 	}
-err_clk_disable:
-	if (adc->clk)
-		clk_disable_unprepare(adc->clk);
 
 	return ret;
 }
@@ -1924,7 +1996,12 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	struct stm32_adc *adc = platform_get_drvdata(pdev);
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 
+	pm_runtime_get_sync(&pdev->dev);
 	iio_device_unregister(indio_dev);
+	stm32_adc_hw_stop(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (adc->dma_chan) {
 		dma_free_coherent(adc->dma_chan->device->dev,
@@ -1932,12 +2009,29 @@ static int stm32_adc_remove(struct platform_device *pdev)
 				  adc->rx_buf, adc->rx_dma_buf);
 		dma_release_channel(adc->dma_chan);
 	}
-	if (adc->clk)
-		clk_disable_unprepare(adc->clk);
 
 	return 0;
 }
 
+#if defined(CONFIG_PM)
+static int stm32_adc_runtime_suspend(struct device *dev)
+{
+	return stm32_adc_hw_stop(dev);
+}
+
+static int stm32_adc_runtime_resume(struct device *dev)
+{
+	return stm32_adc_hw_start(dev);
+}
+#endif
+
+static const struct dev_pm_ops stm32_adc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(stm32_adc_runtime_suspend, stm32_adc_runtime_resume,
+			   NULL)
+};
+
 static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.regs = &stm32f4_adc_regspec,
 	.adc_info = &stm32f4_adc_info,
@@ -1985,6 +2079,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	.driver = {
 		.name = "stm32-adc",
 		.of_match_table = stm32_adc_of_match,
+		.pm = &stm32_adc_pm_ops,
 	},
 };
 module_platform_driver(stm32_adc_driver);
-- 
1.9.1

