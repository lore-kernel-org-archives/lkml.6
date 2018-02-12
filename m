Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbeBLWwo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:52:44 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37589 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933042AbeBLWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:46 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 34/45] rtc: ds1742: use generic nvmem
Date: Mon, 12 Feb 2018 23:47:48 +0100
Message-Id: <20180212224759.15999-35-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1742.c | 67 +++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 84e19fe2ca3b..52baf925a690 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -53,9 +53,7 @@
 struct rtc_plat_data {
 	void __iomem *ioaddr_nvram;
 	void __iomem *ioaddr_rtc;
-	size_t size_nvram;
 	unsigned long last_jiffies;
-	struct bin_attribute nvram_attr;
 };
 
 static int ds1742_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -122,34 +120,28 @@ static const struct rtc_class_ops ds1742_rtc_ops = {
 	.set_time	= ds1742_rtc_set_time,
 };
 
-static ssize_t ds1742_nvram_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
-				 char *buf, loff_t pos, size_t size)
+static int ds1742_nvram_read(void *priv, unsigned int pos, void *val,
+			     size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = priv;
 	void __iomem *ioaddr = pdata->ioaddr_nvram;
-	ssize_t count;
+	u8 *buf = val;
 
-	for (count = 0; count < size; count++)
+	for (; bytes; bytes--)
 		*buf++ = readb(ioaddr + pos++);
-	return count;
+	return 0;
 }
 
-static ssize_t ds1742_nvram_write(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buf, loff_t pos, size_t size)
+static int ds1742_nvram_write(void *priv, unsigned int pos, void *val,
+			      size_t bytes)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = priv;
 	void __iomem *ioaddr = pdata->ioaddr_nvram;
-	ssize_t count;
+	u8 *buf = val;
 
-	for (count = 0; count < size; count++)
+	for (; bytes; bytes--)
 		writeb(*buf++, ioaddr + pos++);
-	return count;
+	return 0;
 }
 
 static int ds1742_rtc_probe(struct platform_device *pdev)
@@ -160,6 +152,14 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 	struct rtc_plat_data *pdata;
 	void __iomem *ioaddr;
 	int ret = 0;
+	struct nvmem_config nvmem_cfg = {
+		.name = "ds1742_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.reg_read = ds1742_nvram_read,
+		.reg_write = ds1742_nvram_write,
+	};
+
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -171,15 +171,10 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(ioaddr);
 
 	pdata->ioaddr_nvram = ioaddr;
-	pdata->size_nvram = resource_size(res) - RTC_SIZE;
-	pdata->ioaddr_rtc = ioaddr + pdata->size_nvram;
+	pdata->ioaddr_rtc = ioaddr + resource_size(res) - RTC_SIZE;
 
-	sysfs_bin_attr_init(&pdata->nvram_attr);
-	pdata->nvram_attr.attr.name = "nvram";
-	pdata->nvram_attr.attr.mode = S_IRUGO | S_IWUSR;
-	pdata->nvram_attr.read = ds1742_nvram_read;
-	pdata->nvram_attr.write = ds1742_nvram_write;
-	pdata->nvram_attr.size = pdata->size_nvram;
+	nvmem_cfg.size = resource_size(res) - RTC_SIZE;
+	nvmem_cfg.priv = pdata;
 
 	/* turn RTC on if it was not on */
 	ioaddr = pdata->ioaddr_rtc;
@@ -202,24 +197,15 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(rtc);
 
 	rtc->ops = &ds1742_rtc_ops;
+	rtc->nvram_old_abi = true;
 
 	ret = rtc_register_device(rtc);
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &pdata->nvram_attr);
-	if (ret)
-		dev_err(&pdev->dev, "Unable to create sysfs entry: %s\n",
-			pdata->nvram_attr.attr.name);
-
-	return 0;
-}
-
-static int ds1742_rtc_remove(struct platform_device *pdev)
-{
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	if (rtc_nvmem_register(rtc, &nvmem_cfg))
+		dev_err(&pdev->dev, "Unable to register nvmem\n");
 
-	sysfs_remove_bin_file(&pdev->dev.kobj, &pdata->nvram_attr);
 	return 0;
 }
 
@@ -231,7 +217,6 @@ MODULE_DEVICE_TABLE(of, ds1742_rtc_of_match);
 
 static struct platform_driver ds1742_rtc_driver = {
 	.probe		= ds1742_rtc_probe,
-	.remove		= ds1742_rtc_remove,
 	.driver		= {
 		.name	= "rtc-ds1742",
 		.of_match_table = of_match_ptr(ds1742_rtc_of_match),
-- 
2.16.1
