Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967411AbeCAKZy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:25:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37986 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965971AbeCAKZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:25:49 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] rtc: rp5c01: use generic nvmem
Date: Thu,  1 Mar 2018 11:25:45 +0100
Message-Id: <20180301102545.6586-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding a binary sysfs attribute from the driver, use the core to
register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rp5c01.c | 65 ++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/rtc/rtc-rp5c01.c b/drivers/rtc/rtc-rp5c01.c
index 38a12435b5a0..043b1667b41a 100644
--- a/drivers/rtc/rtc-rp5c01.c
+++ b/drivers/rtc/rtc-rp5c01.c
@@ -64,7 +64,6 @@ struct rp5c01_priv {
 	u32 __iomem *regs;
 	struct rtc_device *rtc;
 	spinlock_t lock;	/* against concurrent RTC/NVRAM access */
-	struct bin_attribute nvram_attr;
 };
 
 static inline unsigned int rp5c01_read(struct rp5c01_priv *priv,
@@ -160,17 +159,15 @@ static const struct rtc_class_ops rp5c01_rtc_ops = {
  * byte is stored in BLOCK10, the low nibble in BLOCK11.
  */
 
-static ssize_t rp5c01_nvram_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
-				 char *buf, loff_t pos, size_t size)
+static int rp5c01_nvram_read(void *_priv, unsigned int pos, void *val,
+			     size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct rp5c01_priv *priv = dev_get_drvdata(dev);
-	ssize_t count;
+	struct rp5c01_priv *priv = _priv;
+	u8 *buf = val;
 
 	spin_lock_irq(&priv->lock);
 
-	for (count = 0; count < size; count++) {
+	for (; bytes; bytes--) {
 		u8 data;
 
 		rp5c01_write(priv,
@@ -187,20 +184,18 @@ static ssize_t rp5c01_nvram_read(struct file *filp, struct kobject *kobj,
 	}
 
 	spin_unlock_irq(&priv->lock);
-	return count;
+	return 0;
 }
 
-static ssize_t rp5c01_nvram_write(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buf, loff_t pos, size_t size)
+static int rp5c01_nvram_write(void *_priv, unsigned int pos, void *val,
+			      size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct rp5c01_priv *priv = dev_get_drvdata(dev);
-	ssize_t count;
+	struct rp5c01_priv *priv = _priv;
+	u8 *buf = val;
 
 	spin_lock_irq(&priv->lock);
 
-	for (count = 0; count < size; count++) {
+	for (; bytes; bytes--) {
 		u8 data = *buf++;
 
 		rp5c01_write(priv,
@@ -216,7 +211,7 @@ static ssize_t rp5c01_nvram_write(struct file *filp, struct kobject *kobj,
 	}
 
 	spin_unlock_irq(&priv->lock);
-	return count;
+	return 0;
 }
 
 static int __init rp5c01_rtc_probe(struct platform_device *dev)
@@ -225,6 +220,14 @@ static int __init rp5c01_rtc_probe(struct platform_device *dev)
 	struct rp5c01_priv *priv;
 	struct rtc_device *rtc;
 	int error;
+	struct nvmem_config nvmem_cfg = {
+		.name = "rp5c01_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = RP5C01_MODE,
+		.reg_read = rp5c01_nvram_read,
+		.reg_write = rp5c01_nvram_write,
+	};
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -238,13 +241,6 @@ static int __init rp5c01_rtc_probe(struct platform_device *dev)
 	if (!priv->regs)
 		return -ENOMEM;
 
-	sysfs_bin_attr_init(&priv->nvram_attr);
-	priv->nvram_attr.attr.name = "nvram";
-	priv->nvram_attr.attr.mode = S_IRUGO | S_IWUSR;
-	priv->nvram_attr.read = rp5c01_nvram_read;
-	priv->nvram_attr.write = rp5c01_nvram_write;
-	priv->nvram_attr.size = RP5C01_MODE;
-
 	spin_lock_init(&priv->lock);
 
 	platform_set_drvdata(dev, priv);
@@ -254,35 +250,22 @@ static int __init rp5c01_rtc_probe(struct platform_device *dev)
 		return PTR_ERR(rtc);
 
 	rtc->ops = &rp5c01_rtc_ops;
+	rtc->nvram_old_abi = true;
 
 	priv->rtc = rtc;
 
-	error = sysfs_create_bin_file(&dev->dev.kobj, &priv->nvram_attr);
+	nvmem_cfg.priv = priv;
+	error = rtc_nvmem_register(rtc, &nvmem_cfg);
 	if (error)
 		return error;
 
-	error = rtc_register_device(rtc);
-	if (error) {
-		sysfs_remove_bin_file(&dev->dev.kobj, &priv->nvram_attr);
-		return error;
-	}
-
-	return 0;
-}
-
-static int __exit rp5c01_rtc_remove(struct platform_device *dev)
-{
-	struct rp5c01_priv *priv = platform_get_drvdata(dev);
-
-	sysfs_remove_bin_file(&dev->dev.kobj, &priv->nvram_attr);
-	return 0;
+	return rtc_register_device(rtc);
 }
 
 static struct platform_driver rp5c01_rtc_driver = {
 	.driver	= {
 		.name	= "rtc-rp5c01",
 	},
-	.remove	= __exit_p(rp5c01_rtc_remove),
 };
 
 module_platform_driver_probe(rp5c01_rtc_driver, rp5c01_rtc_probe);
-- 
2.16.2
