Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967460AbeCAK0A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:26:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38005 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966238AbeCAKZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:25:56 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] rtc: stk17ta8: use generic nvmem
Date: Thu,  1 Mar 2018 11:25:54 +0100
Message-Id: <20180301102554.6687-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding a binary sysfs attribute from the driver, use the core to
register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stk17ta8.c | 64 +++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index 1d6febbe7d39..01a3bef77aa5 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -242,46 +242,30 @@ static const struct rtc_class_ops stk17ta8_rtc_ops = {
 	.alarm_irq_enable	= stk17ta8_rtc_alarm_irq_enable,
 };
 
-static ssize_t stk17ta8_nvram_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *attr, char *buf,
-				 loff_t pos, size_t size)
+static int stk17ta8_nvram_read(void *priv, unsigned int pos, void *val,
+			       size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = priv;
 	void __iomem *ioaddr = pdata->ioaddr;
-	ssize_t count;
+	u8 *buf = val;
 
-	for (count = 0; count < size; count++)
+	for (; bytes; bytes--)
 		*buf++ = readb(ioaddr + pos++);
-	return count;
+	return 0;
 }
 
-static ssize_t stk17ta8_nvram_write(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *attr, char *buf,
-				  loff_t pos, size_t size)
+static int stk17ta8_nvram_write(void *priv, unsigned int pos, void *val,
+				size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = priv;
 	void __iomem *ioaddr = pdata->ioaddr;
-	ssize_t count;
+	u8 *buf = val;
 
-	for (count = 0; count < size; count++)
+	for (; bytes; bytes--)
 		writeb(*buf++, ioaddr + pos++);
-	return count;
+	return 0;
 }
 
-static struct bin_attribute stk17ta8_nvram_attr = {
-	.attr = {
-		.name = "nvram",
-		.mode = S_IRUGO | S_IWUSR,
-	},
-	.size = RTC_OFFSET,
-	.read = stk17ta8_nvram_read,
-	.write = stk17ta8_nvram_write,
-};
-
 static int stk17ta8_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -290,6 +274,14 @@ static int stk17ta8_rtc_probe(struct platform_device *pdev)
 	struct rtc_plat_data *pdata;
 	void __iomem *ioaddr;
 	int ret = 0;
+	struct nvmem_config nvmem_cfg = {
+		.name = "stk17ta8_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = RTC_OFFSET,
+		.reg_read = stk17ta8_nvram_read,
+		.reg_write = stk17ta8_nvram_write,
+	};
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -333,21 +325,14 @@ static int stk17ta8_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(pdata->rtc);
 
 	pdata->rtc->ops = &stk17ta8_rtc_ops;
+	pdata->rtc->nvram_old_abi = true;
 
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &stk17ta8_nvram_attr);
+	nvmem_cfg.priv = pdata;
+	ret = rtc_nvmem_register(pdata->rtc, &nvmem_cfg);
 	if (ret)
 		return ret;
 
-	ret = rtc_register_device(pdata->rtc);
-
-	return ret;
-}
-
-static int stk17ta8_rtc_remove(struct platform_device *pdev)
-{
-	sysfs_remove_bin_file(&pdev->dev.kobj, &stk17ta8_nvram_attr);
-
-	return 0;
+	return rtc_register_device(pdata->rtc);
 }
 
 /* work with hotplug and coldplug */
@@ -355,7 +340,6 @@ MODULE_ALIAS("platform:stk17ta8");
 
 static struct platform_driver stk17ta8_rtc_driver = {
 	.probe		= stk17ta8_rtc_probe,
-	.remove		= stk17ta8_rtc_remove,
 	.driver		= {
 		.name	= "stk17ta8",
 	},
-- 
2.16.2
