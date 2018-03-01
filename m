Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967482AbeCAK0G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:26:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38025 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966238AbeCAK0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:26:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] rtc: tx4939: use generic nvmem
Date: Thu,  1 Mar 2018 11:25:59 +0100
Message-Id: <20180301102559.6759-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding a binary sysfs attribute from the driver, use the core to
register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 59 +++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 5a3a6b457b8f..fcf837d50b70 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -212,58 +212,52 @@ static const struct rtc_class_ops tx4939_rtc_ops = {
 	.alarm_irq_enable	= tx4939_rtc_alarm_irq_enable,
 };
 
-static ssize_t tx4939_rtc_nvram_read(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *bin_attr,
-				     char *buf, loff_t pos, size_t size)
+static int tx4939_nvram_read(void *priv, unsigned int pos, void *val,
+			     size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
+	struct tx4939rtc_plat_data *pdata = priv;
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
-	ssize_t count;
+	u8 *buf = val;
 
 	spin_lock_irq(&pdata->lock);
-	for (count = 0; count < size; count++) {
+	for (; bytes; bytes--) {
 		__raw_writel(pos++, &rtcreg->adr);
 		*buf++ = __raw_readl(&rtcreg->dat);
 	}
 	spin_unlock_irq(&pdata->lock);
-	return count;
+	return 0;
 }
 
-static ssize_t tx4939_rtc_nvram_write(struct file *filp, struct kobject *kobj,
-				      struct bin_attribute *bin_attr,
-				      char *buf, loff_t pos, size_t size)
+static int tx4939_nvram_write(void *priv, unsigned int pos, void *val,
+			      size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
+	struct tx4939rtc_plat_data *pdata = priv;
 	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
-	ssize_t count;
+	u8 *buf = val;
 
 	spin_lock_irq(&pdata->lock);
-	for (count = 0; count < size; count++) {
+	for (; bytes; bytes--) {
 		__raw_writel(pos++, &rtcreg->adr);
 		__raw_writel(*buf++, &rtcreg->dat);
 	}
 	spin_unlock_irq(&pdata->lock);
-	return count;
+	return 0;
 }
 
-static struct bin_attribute tx4939_rtc_nvram_attr = {
-	.attr = {
-		.name = "nvram",
-		.mode = S_IRUGO | S_IWUSR,
-	},
-	.size = TX4939_RTC_REG_RAMSIZE,
-	.read = tx4939_rtc_nvram_read,
-	.write = tx4939_rtc_nvram_write,
-};
-
 static int __init tx4939_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct tx4939rtc_plat_data *pdata;
 	struct resource *res;
 	int irq, ret;
+	struct nvmem_config nvmem_cfg = {
+		.name = "rv8803_nvram",
+		.word_size = 4,
+		.stride = 4,
+		.size = TX4939_RTC_REG_RAMSIZE,
+		.reg_read = tx4939_nvram_read,
+		.reg_write = tx4939_nvram_write,
+	};
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -288,23 +282,22 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(rtc);
 
 	rtc->ops = &tx4939_rtc_ops;
-
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &tx4939_rtc_nvram_attr);
-	if (ret)
-		return ret;
+	rtc->nvram_old_abi = true;
 
 	pdata->rtc = rtc;
 
-	ret = rtc_register_device(rtc);
+	nvmem_cfg.priv = pdata;
+	ret = rtc_nvmem_register(rtc, &nvmem_cfg);
+	if (ret)
+		return ret;
 
-	return ret;
+	return rtc_register_device(rtc);
 }
 
 static int __exit tx4939_rtc_remove(struct platform_device *pdev)
 {
 	struct tx4939rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
-	sysfs_remove_bin_file(&pdev->dev.kobj, &tx4939_rtc_nvram_attr);
 	spin_lock_irq(&pdata->lock);
 	tx4939_rtc_cmd(pdata->rtcreg, TX4939_RTCCTL_COMMAND_NOP);
 	spin_unlock_irq(&pdata->lock);
-- 
2.16.2
