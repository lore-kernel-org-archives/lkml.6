Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E6ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223AF2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223AF2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeISXbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:31:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58483 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbeISXbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:31:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7CC3520798; Wed, 19 Sep 2018 19:52:20 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id BE5D2204AE;
        Wed, 19 Sep 2018 19:52:19 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: ds1685: use generic nvmem
Date:   Wed, 19 Sep 2018 19:52:10 +0200
Message-Id: <20180919175211.25150-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919175211.25150-1-alexandre.belloni@bootlin.com>
References: <20180919175211.25150-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding a binary sysfs attribute from the driver, use the core to
register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 92 +++++++++++-----------------------------
 1 file changed, 25 insertions(+), 67 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 2bad1f50414f..1f85e46b7888 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -866,30 +866,13 @@ ds1685_rtc_ops = {
 };
 /* ----------------------------------------------------------------------- */
 
-
-/* ----------------------------------------------------------------------- */
-/* SysFS interface */
-
-#ifdef CONFIG_SYSFS
-/**
- * ds1685_rtc_sysfs_nvram_read - reads rtc nvram via sysfs.
- * @file: pointer to file structure.
- * @kobj: pointer to kobject structure.
- * @bin_attr: pointer to bin_attribute structure.
- * @buf: pointer to char array to hold the output.
- * @pos: current file position pointer.
- * @size: size of the data to read.
- */
-static ssize_t
-ds1685_rtc_sysfs_nvram_read(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
-			    loff_t pos, size_t size)
+static int ds1685_nvram_read(void *priv, unsigned int pos, void *val,
+			     size_t size)
 {
-	struct platform_device *pdev =
-		to_platform_device(container_of(kobj, struct device, kobj));
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = priv;
 	ssize_t count;
 	unsigned long flags = 0;
+	u8 *buf = val;
 
 	spin_lock_irqsave(&rtc->lock, flags);
 	ds1685_rtc_switch_to_bank0(rtc);
@@ -943,33 +926,16 @@ ds1685_rtc_sysfs_nvram_read(struct file *filp, struct kobject *kobj,
 #endif /* !CONFIG_RTC_DRV_DS1689 */
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-	/*
-	 * XXX: Bug? this appears to cause the function to get executed
-	 * several times in succession.  But it's the only way to actually get
-	 * data written out to a file.
-	 */
-	return count;
+	return 0;
 }
 
-/**
- * ds1685_rtc_sysfs_nvram_write - writes rtc nvram via sysfs.
- * @file: pointer to file structure.
- * @kobj: pointer to kobject structure.
- * @bin_attr: pointer to bin_attribute structure.
- * @buf: pointer to char array to hold the input.
- * @pos: current file position pointer.
- * @size: size of the data to write.
- */
-static ssize_t
-ds1685_rtc_sysfs_nvram_write(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
-			     loff_t pos, size_t size)
+static int ds1685_nvram_write(void *priv, unsigned int pos, void *val,
+			      size_t size)
 {
-	struct platform_device *pdev =
-		to_platform_device(container_of(kobj, struct device, kobj));
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = priv;
 	ssize_t count;
 	unsigned long flags = 0;
+	u8 *buf = val;
 
 	spin_lock_irqsave(&rtc->lock, flags);
 	ds1685_rtc_switch_to_bank0(rtc);
@@ -1023,27 +989,13 @@ ds1685_rtc_sysfs_nvram_write(struct file *filp, struct kobject *kobj,
 #endif /* !CONFIG_RTC_DRV_DS1689 */
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-	return count;
+	return 0;
 }
 
-/**
- * struct ds1685_rtc_sysfs_nvram_attr - sysfs attributes for rtc nvram.
- * @attr: nvram attributes.
- * @read: nvram read function.
- * @write: nvram write function.
- * @size: nvram total size (bank0 + extended).
- */
-static struct bin_attribute
-ds1685_rtc_sysfs_nvram_attr = {
-	.attr = {
-		.name = "nvram",
-		.mode = S_IRUGO | S_IWUSR,
-	},
-	.read = ds1685_rtc_sysfs_nvram_read,
-	.write = ds1685_rtc_sysfs_nvram_write,
-	.size = NVRAM_TOTAL_SZ
-};
+/* ----------------------------------------------------------------------- */
+/* SysFS interface */
 
+#ifdef CONFIG_SYSFS
 /**
  * ds1685_rtc_sysfs_battery_show - sysfs file for main battery status.
  * @dev: pointer to device structure.
@@ -1136,11 +1088,6 @@ ds1685_rtc_sysfs_register(struct device *dev)
 {
 	int ret = 0;
 
-	sysfs_bin_attr_init(&ds1685_rtc_sysfs_nvram_attr);
-	ret = sysfs_create_bin_file(&dev->kobj, &ds1685_rtc_sysfs_nvram_attr);
-	if (ret)
-		return ret;
-
 	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_misc_grp);
 	if (ret)
 		return ret;
@@ -1155,7 +1102,6 @@ ds1685_rtc_sysfs_register(struct device *dev)
 static int
 ds1685_rtc_sysfs_unregister(struct device *dev)
 {
-	sysfs_remove_bin_file(&dev->kobj, &ds1685_rtc_sysfs_nvram_attr);
 	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_misc_grp);
 
 	return 0;
@@ -1181,6 +1127,12 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	u8 ctrla, ctrlb, hours;
 	unsigned char am_pm;
 	int ret = 0;
+	struct nvmem_config nvmem_cfg = {
+		.name = "ds1685_nvram",
+		.size = NVRAM_TOTAL_SZ,
+		.reg_read = ds1685_nvram_read,
+		.reg_write = ds1685_nvram_write,
+	};
 
 	/* Get the platform data. */
 	pdata = (struct ds1685_rtc_platform_data *) pdev->dev.platform_data;
@@ -1444,6 +1396,12 @@ ds1685_rtc_probe(struct platform_device *pdev)
 		return ret;
 #endif
 
+	rtc_dev->nvram_old_abi = true;
+	nvmem_cfg.priv = rtc;
+	ret = rtc_nvmem_register(rtc_dev, &nvmem_cfg);
+	if (ret)
+		return ret;
+
 	return rtc_register_device(rtc_dev);
 }
 
-- 
2.19.0

