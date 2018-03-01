Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967184AbeCAKZq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:25:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37981 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965971AbeCAKZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:25:42 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] rtc: m48t59: use generic nvmem
Date: Thu,  1 Mar 2018 11:25:38 +0100
Message-Id: <20180301102538.6515-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding a binary sysfs attribute from the driver (which suffers
from a race condition as the attribute appears after the device), use the
core to register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m48t59.c | 56 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index e248e56ff8a1..d2ba7d76dbb9 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -334,16 +334,16 @@ static const struct rtc_class_ops m48t02_rtc_ops = {
 	.set_time	= m48t59_rtc_set_time,
 };
 
-static ssize_t m48t59_nvram_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
-				char *buf, loff_t pos, size_t size)
+static int m48t59_nvram_read(void *priv, unsigned int offset, void *val,
+			     size_t size)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = priv;
+	struct device *dev = &pdev->dev;
 	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
 	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
 	ssize_t cnt = 0;
 	unsigned long flags;
+	u8 *buf = val;
 
 	spin_lock_irqsave(&m48t59->lock, flags);
 
@@ -352,19 +352,19 @@ static ssize_t m48t59_nvram_read(struct file *filp, struct kobject *kobj,
 
 	spin_unlock_irqrestore(&m48t59->lock, flags);
 
-	return cnt;
+	return 0;
 }
 
-static ssize_t m48t59_nvram_write(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
-				char *buf, loff_t pos, size_t size)
+static int m48t59_nvram_write(void *priv, unsigned int offset, void *val,
+			      size_t size)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = priv;
+	struct device *dev = &pdev->dev;
 	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
 	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
 	ssize_t cnt = 0;
 	unsigned long flags;
+	u8 *buf = val;
 
 	spin_lock_irqsave(&m48t59->lock, flags);
 
@@ -373,18 +373,9 @@ static ssize_t m48t59_nvram_write(struct file *filp, struct kobject *kobj,
 
 	spin_unlock_irqrestore(&m48t59->lock, flags);
 
-	return cnt;
+	return 0;
 }
 
-static struct bin_attribute m48t59_nvram_attr = {
-	.attr = {
-		.name = "nvram",
-		.mode = S_IRUGO | S_IWUSR,
-	},
-	.read = m48t59_nvram_read,
-	.write = m48t59_nvram_write,
-};
-
 static int m48t59_rtc_probe(struct platform_device *pdev)
 {
 	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
@@ -393,6 +384,14 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	int ret = -ENOMEM;
 	char *name;
 	const struct rtc_class_ops *ops;
+	struct nvmem_config nvmem_cfg = {
+		.name = "m48t59-",
+		.word_size = 1,
+		.stride = 1,
+		.reg_read = m48t59_nvram_read,
+		.reg_write = m48t59_nvram_write,
+		.priv = pdev,
+	};
 
 	/* This chip could be memory-mapped or I/O-mapped */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -484,27 +483,21 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(m48t59->rtc))
 		return PTR_ERR(m48t59->rtc);
 
+	m48t59->rtc->nvram_old_abi = true;
 	m48t59->rtc->ops = ops;
 
-	ret = rtc_register_device(m48t59->rtc);
+	nvmem_cfg.size = pdata->offset;
+	ret = rtc_nvmem_register(m48t59->rtc, &nvmem_cfg);
 	if (ret)
 		return ret;
 
-	m48t59_nvram_attr.size = pdata->offset;
-
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &m48t59_nvram_attr);
+	ret = rtc_register_device(m48t59->rtc);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static int m48t59_rtc_remove(struct platform_device *pdev)
-{
-	sysfs_remove_bin_file(&pdev->dev.kobj, &m48t59_nvram_attr);
-	return 0;
-}
-
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:rtc-m48t59");
 
@@ -513,7 +506,6 @@ static struct platform_driver m48t59_rtc_driver = {
 		.name	= "rtc-m48t59",
 	},
 	.probe		= m48t59_rtc_probe,
-	.remove		= m48t59_rtc_remove,
 };
 
 module_platform_driver(m48t59_rtc_driver);
-- 
2.16.2
