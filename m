Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933188AbeBLWsy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:54 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37584 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932955AbeBLWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:38 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 29/45] rtc: ds1553: use generic nvmem
Date: Mon, 12 Feb 2018 23:47:43 +0100
Message-Id: <20180212224759.15999-30-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding a binary sysfs attribute from the driver (which suffers
from a race condition as the attribute appears after the device), use the
core to register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1553.c | 55 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 59eab5eceafa..6205c28e0cdc 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -233,46 +233,32 @@ static const struct rtc_class_ops ds1553_rtc_ops = {
 	.alarm_irq_enable	= ds1553_rtc_alarm_irq_enable,
 };
 
-static ssize_t ds1553_nvram_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
-				 char *buf, loff_t pos, size_t size)
+static int ds1553_nvram_read(void *priv, unsigned int pos, void *val,
+			     size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = priv;
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 	void __iomem *ioaddr = pdata->ioaddr;
-	ssize_t count;
+	u8 *buf = val;
 
-	for (count = 0; count < size; count++)
+	for (; bytes; bytes--)
 		*buf++ = readb(ioaddr + pos++);
-	return count;
+	return 0;
 }
 
-static ssize_t ds1553_nvram_write(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buf, loff_t pos, size_t size)
+static int ds1553_nvram_write(void *priv, unsigned int pos, void *val,
+			      size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = priv;
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 	void __iomem *ioaddr = pdata->ioaddr;
-	ssize_t count;
+	u8 *buf = val;
 
-	for (count = 0; count < size; count++)
+	for (; bytes; bytes--)
 		writeb(*buf++, ioaddr + pos++);
-	return count;
+	return 0;
 }
 
-static struct bin_attribute ds1553_nvram_attr = {
-	.attr = {
-		.name = "nvram",
-		.mode = S_IRUGO | S_IWUSR,
-	},
-	.size = RTC_OFFSET,
-	.read = ds1553_nvram_read,
-	.write = ds1553_nvram_write,
-};
-
 static int ds1553_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -280,6 +266,15 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 	struct rtc_plat_data *pdata;
 	void __iomem *ioaddr;
 	int ret = 0;
+	struct nvmem_config nvmem_cfg = {
+		.name = "ds1553_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = RTC_OFFSET,
+		.reg_read = ds1553_nvram_read,
+		.reg_write = ds1553_nvram_write,
+		.priv = pdev,
+	};
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -313,6 +308,7 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(pdata->rtc);
 
 	pdata->rtc->ops = &ds1553_rtc_ops;
+	pdata->rtc->nvram_old_abi = true;
 
 	ret = rtc_register_device(pdata->rtc);
 	if (ret)
@@ -328,10 +324,8 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &ds1553_nvram_attr);
-	if (ret)
-		dev_err(&pdev->dev, "unable to create sysfs file: %s\n",
-			ds1553_nvram_attr.attr.name);
+	if (rtc_nvmem_register(pdata->rtc, &nvmem_cfg))
+		dev_err(&pdev->dev, "unable to register nvmem\n");
 
 	return 0;
 }
@@ -340,7 +334,6 @@ static int ds1553_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
-	sysfs_remove_bin_file(&pdev->dev.kobj, &ds1553_nvram_attr);
 	if (pdata->irq > 0)
 		writeb(0, pdata->ioaddr + RTC_INTERRUPTS);
 	return 0;
-- 
2.16.1
