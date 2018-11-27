Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D765C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE631208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE631208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeK1Bd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:33:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbeK1Bd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:33:57 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAREYRdW006604;
        Tue, 27 Nov 2018 15:35:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nxw02gvnm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Nov 2018 15:35:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63FCC35A;
        Tue, 27 Nov 2018 15:35:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 134544EFC;
        Tue, 27 Nov 2018 14:35:32 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 27 Nov 2018 15:35:31
 +0100
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] i2c: i2c-stm32f7: add PM Runtime support
Date:   Tue, 27 Nov 2018 15:35:31 +0100
Message-ID: <1543329331-2471-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_13:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PM Runtime API to enable/disable clock

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v3:
       * Rebase
    v2:
       * missing define
    v1:
       * Initial
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 144 +++++++++++++++++++++++++++------------
 1 file changed, 101 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index e9f0c0b..13e1213 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -28,6 +28,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -165,6 +167,8 @@
 #define STM32F7_SCLH_MAX			BIT(8)
 #define STM32F7_SCLL_MAX			BIT(8)
 
+#define STM32F7_AUTOSUSPEND_DELAY		(HZ / 100)
+
 /**
  * struct stm32f7_i2c_spec - private i2c specification timing
  * @rate: I2C bus speed (Hz)
@@ -1549,15 +1553,13 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 	i2c_dev->msg_id = 0;
 	f7_msg->smbus = false;
 
-	ret = clk_enable(i2c_dev->clk);
-	if (ret) {
-		dev_err(i2c_dev->dev, "Failed to enable clock\n");
+	ret = pm_runtime_get_sync(i2c_dev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32f7_i2c_wait_free_bus(i2c_dev);
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	stm32f7_i2c_xfer_msg(i2c_dev, msgs);
 
@@ -1573,8 +1575,9 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_adap,
 		ret = -ETIMEDOUT;
 	}
 
-clk_free:
-	clk_disable(i2c_dev->clk);
+pm_free:
+	pm_runtime_mark_last_busy(i2c_dev->dev);
+	pm_runtime_put_autosuspend(i2c_dev->dev);
 
 	return (ret < 0) ? ret : num;
 }
@@ -1596,39 +1599,37 @@ static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	f7_msg->read_write = read_write;
 	f7_msg->smbus = true;
 
-	ret = clk_enable(i2c_dev->clk);
-	if (ret) {
-		dev_err(i2c_dev->dev, "Failed to enable clock\n");
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32f7_i2c_wait_free_bus(i2c_dev);
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	ret = stm32f7_i2c_smbus_xfer_msg(i2c_dev, flags, command, data);
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	timeout = wait_for_completion_timeout(&i2c_dev->complete,
 					      i2c_dev->adap.timeout);
 	ret = f7_msg->result;
 	if (ret)
-		goto clk_free;
+		goto pm_free;
 
 	if (!timeout) {
 		dev_dbg(dev, "Access to slave 0x%x timed out\n", f7_msg->addr);
 		if (i2c_dev->use_dma)
 			dmaengine_terminate_all(dma->chan_using);
 		ret = -ETIMEDOUT;
-		goto clk_free;
+		goto pm_free;
 	}
 
 	/* Check PEC */
 	if ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK && read_write) {
 		ret = stm32f7_i2c_smbus_check_pec(i2c_dev);
 		if (ret)
-			goto clk_free;
+			goto pm_free;
 	}
 
 	if (read_write && size != I2C_SMBUS_QUICK) {
@@ -1653,8 +1654,9 @@ static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 		}
 	}
 
-clk_free:
-	clk_disable(i2c_dev->clk);
+pm_free:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -1680,13 +1682,9 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 	if (ret)
 		return ret;
 
-	if (!(stm32f7_i2c_is_slave_registered(i2c_dev))) {
-		ret = clk_enable(i2c_dev->clk);
-		if (ret) {
-			dev_err(dev, "Failed to enable clock\n");
-			return ret;
-		}
-	}
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
 
 	if (id == 0) {
 		/* Configure Own Address 1 */
@@ -1707,7 +1705,7 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 		oar2 &= ~STM32F7_I2C_OAR2_MASK;
 		if (slave->flags & I2C_CLIENT_TEN) {
 			ret = -EOPNOTSUPP;
-			goto exit;
+			goto pm_free;
 		}
 
 		oar2 |= STM32F7_I2C_OAR2_OA2_7(slave->addr);
@@ -1716,7 +1714,7 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 		writel_relaxed(oar2, i2c_dev->base + STM32F7_I2C_OAR2);
 	} else {
 		ret = -ENODEV;
-		goto exit;
+		goto pm_free;
 	}
 
 	/* Enable ACK */
@@ -1727,11 +1725,10 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
 		STM32F7_I2C_CR1_PE;
 	stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
 
-	return 0;
-
-exit:
-	if (!(stm32f7_i2c_is_slave_registered(i2c_dev)))
-		clk_disable(i2c_dev->clk);
+	ret = 0;
+pm_free:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -1749,6 +1746,10 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 
 	WARN_ON(!i2c_dev->slave[id]);
 
+	ret = pm_runtime_get_sync(i2c_dev->dev);
+	if (ret < 0)
+		return ret;
+
 	if (id == 0) {
 		mask = STM32F7_I2C_OAR1_OA1EN;
 		stm32f7_i2c_clr_bits(base + STM32F7_I2C_OAR1, mask);
@@ -1759,10 +1760,11 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
 
 	i2c_dev->slave[id] = NULL;
 
-	if (!(stm32f7_i2c_is_slave_registered(i2c_dev))) {
+	if (!(stm32f7_i2c_is_slave_registered(i2c_dev)))
 		stm32f7_i2c_disable_irq(i2c_dev, STM32F7_I2C_ALL_IRQ_MASK);
-		clk_disable(i2c_dev->clk);
-	}
+
+	pm_runtime_mark_last_busy(i2c_dev->dev);
+	pm_runtime_put_autosuspend(i2c_dev->dev);
 
 	return 0;
 }
@@ -1847,6 +1849,7 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Error: Missing controller clock\n");
 		return PTR_ERR(i2c_dev->clk);
 	}
+
 	ret = clk_prepare_enable(i2c_dev->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare_enable clock\n");
@@ -1920,8 +1923,6 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_free;
 
-	stm32f7_i2c_hw_config(i2c_dev);
-
 	adap = &i2c_dev->adap;
 	i2c_set_adapdata(adap, i2c_dev);
 	snprintf(adap->name, sizeof(adap->name), "STM32F7 I2C(%pa)",
@@ -1940,18 +1941,35 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 					     STM32F7_I2C_TXDR,
 					     STM32F7_I2C_RXDR);
 
-	ret = i2c_add_adapter(adap);
-	if (ret)
-		goto clk_free;
-
 	platform_set_drvdata(pdev, i2c_dev);
 
-	clk_disable(i2c_dev->clk);
+	pm_runtime_set_autosuspend_delay(i2c_dev->dev,
+					 STM32F7_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(i2c_dev->dev);
+	pm_runtime_set_active(i2c_dev->dev);
+	pm_runtime_enable(i2c_dev->dev);
+
+	pm_runtime_get_noresume(&pdev->dev);
+
+	stm32f7_i2c_hw_config(i2c_dev);
+
+	ret = i2c_add_adapter(adap);
+	if (ret)
+		goto pm_disable;
 
 	dev_info(i2c_dev->dev, "STM32F7 I2C-%d bus adapter\n", adap->nr);
 
+	pm_runtime_mark_last_busy(i2c_dev->dev);
+	pm_runtime_put_autosuspend(i2c_dev->dev);
+
 	return 0;
 
+pm_disable:
+	pm_runtime_put_noidle(i2c_dev->dev);
+	pm_runtime_disable(i2c_dev->dev);
+	pm_runtime_set_suspended(i2c_dev->dev);
+	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
+
 clk_free:
 	clk_disable_unprepare(i2c_dev->clk);
 
@@ -1968,11 +1986,50 @@ static int stm32f7_i2c_remove(struct platform_device *pdev)
 	}
 
 	i2c_del_adapter(&i2c_dev->adap);
+	pm_runtime_get_sync(i2c_dev->dev);
+
+	clk_disable_unprepare(i2c_dev->clk);
+
+	pm_runtime_put_noidle(i2c_dev->dev);
+	pm_runtime_disable(i2c_dev->dev);
+	pm_runtime_set_suspended(i2c_dev->dev);
+	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int stm32f7_i2c_runtime_suspend(struct device *dev)
+{
+	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
+
+	if (!stm32f7_i2c_is_slave_registered(i2c_dev))
+		clk_disable_unprepare(i2c_dev->clk);
+
+	return 0;
+}
+
+static int stm32f7_i2c_runtime_resume(struct device *dev)
+{
+	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
+	int ret;
 
-	clk_unprepare(i2c_dev->clk);
+	if (!stm32f7_i2c_is_slave_registered(i2c_dev)) {
+		ret = clk_prepare_enable(i2c_dev->clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare_enable clock\n");
+			return ret;
+		}
+	}
 
 	return 0;
 }
+#endif
+
+static const struct dev_pm_ops stm32f7_i2c_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32f7_i2c_runtime_suspend,
+			   stm32f7_i2c_runtime_resume, NULL)
+};
 
 static const struct of_device_id stm32f7_i2c_match[] = {
 	{ .compatible = "st,stm32f7-i2c", .data = &stm32f7_setup},
@@ -1984,6 +2041,7 @@ static struct platform_driver stm32f7_i2c_driver = {
 	.driver = {
 		.name = "stm32f7-i2c",
 		.of_match_table = stm32f7_i2c_match,
+		.pm = &stm32f7_i2c_pm_ops,
 	},
 	.probe = stm32f7_i2c_probe,
 	.remove = stm32f7_i2c_remove,
-- 
2.7.4

