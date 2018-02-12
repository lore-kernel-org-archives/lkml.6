Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933011AbeBLWsm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:42 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37580 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932948AbeBLWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:38 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 24/45] rtc: ds1343: use generic nvmem
Date: Mon, 12 Feb 2018 23:47:38 +0100
Message-Id: <20180212224759.15999-25-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1343.c | 66 +++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 67cae0dd8154..59d27db2fd37 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -153,52 +153,22 @@ static ssize_t ds1343_store_glitchfilter(struct device *dev,
 static DEVICE_ATTR(glitch_filter, S_IRUGO | S_IWUSR, ds1343_show_glitchfilter,
 			ds1343_store_glitchfilter);
 
-static ssize_t ds1343_nvram_write(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *attr,
-			char *buf, loff_t off, size_t count)
+static int ds1343_nvram_write(void *priv, unsigned int off, void *val,
+			      size_t bytes)
 {
-	int ret;
-	unsigned char address;
-	struct device *dev = kobj_to_dev(kobj);
-	struct ds1343_priv *priv = dev_get_drvdata(dev);
-
-	address = DS1343_NVRAM + off;
+	struct ds1343_priv *ds1343 = priv;
 
-	ret = regmap_bulk_write(priv->map, address, buf, count);
-	if (ret < 0)
-		dev_err(&priv->spi->dev, "Error in nvram write %d", ret);
-
-	return (ret < 0) ? ret : count;
+	return regmap_bulk_write(ds1343->map, DS1343_NVRAM + off, val, bytes);
 }
 
-
-static ssize_t ds1343_nvram_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
-				char *buf, loff_t off, size_t count)
+static int ds1343_nvram_read(void *priv, unsigned int off, void *val,
+			     size_t bytes)
 {
-	int ret;
-	unsigned char address;
-	struct device *dev = kobj_to_dev(kobj);
-	struct ds1343_priv *priv = dev_get_drvdata(dev);
-
-	address = DS1343_NVRAM + off;
+	struct ds1343_priv *ds1343 = priv;
 
-	ret = regmap_bulk_read(priv->map, address, buf, count);
-	if (ret < 0)
-		dev_err(&priv->spi->dev, "Error in nvram read %d\n", ret);
-
-	return (ret < 0) ? ret : count;
+	return regmap_bulk_read(ds1343->map, DS1343_NVRAM + off, val, bytes);
 }
 
-
-static struct bin_attribute nvram_attr = {
-	.attr.name	= "nvram",
-	.attr.mode	= S_IRUGO | S_IWUSR,
-	.read		= ds1343_nvram_read,
-	.write		= ds1343_nvram_write,
-	.size		= DS1343_NVRAM_LEN,
-};
-
 static ssize_t ds1343_show_tricklecharger(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -252,16 +222,9 @@ static int ds1343_sysfs_register(struct device *dev)
 		return err;
 
 	err = device_create_file(dev, &dev_attr_trickle_charger);
-	if (err)
-		goto error1;
-
-	err = device_create_bin_file(dev, &nvram_attr);
 	if (!err)
 		return 0;
 
-	device_remove_file(dev, &dev_attr_trickle_charger);
-
-error1:
 	device_remove_file(dev, &dev_attr_glitch_filter);
 
 	return err;
@@ -271,7 +234,6 @@ static void ds1343_sysfs_unregister(struct device *dev)
 {
 	device_remove_file(dev, &dev_attr_glitch_filter);
 	device_remove_file(dev, &dev_attr_trickle_charger);
-	device_remove_bin_file(dev, &nvram_attr);
 }
 
 static int ds1343_read_time(struct device *dev, struct rtc_time *dt)
@@ -509,6 +471,14 @@ static int ds1343_probe(struct spi_device *spi)
 					.write_flag_mask = 0x80, };
 	unsigned int data;
 	int res;
+	struct nvmem_config nvmem_cfg = {
+		.name = "ds1343-",
+		.word_size = 1,
+		.stride = 1,
+		.size = DS1343_NVRAM_LEN,
+		.reg_read = ds1343_nvram_read,
+		.reg_write = ds1343_nvram_write,
+	};
 
 	priv = devm_kzalloc(&spi->dev, sizeof(struct ds1343_priv), GFP_KERNEL);
 	if (!priv)
@@ -552,12 +522,16 @@ static int ds1343_probe(struct spi_device *spi)
 	if (IS_ERR(priv->rtc))
 		return PTR_ERR(priv->rtc);
 
+	priv->rtc->nvram_old_abi = true;
 	priv->rtc->ops = &ds1343_rtc_ops;
 
 	res = rtc_register_device(priv->rtc);
 	if (res)
 		return res;
 
+	nvmem_cfg.priv = priv;
+	rtc_nvmem_register(priv->rtc, &nvmem_cfg);
+
 	priv->irq = spi->irq;
 
 	if (priv->irq >= 0) {
-- 
2.16.1
