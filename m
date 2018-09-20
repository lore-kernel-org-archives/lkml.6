Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B70C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C8C20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C8C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeITUTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:19:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58467 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeITUT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:19:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0363F207D4; Thu, 20 Sep 2018 16:35:41 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 40B5420379;
        Thu, 20 Sep 2018 16:35:30 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: ds1307: use rtc_add_group
Date:   Thu, 20 Sep 2018 16:35:26 +0200
Message-Id: <20180920143526.18704-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register frequency test using rtc_add_group to avoid a possible race
condition and simplify the code.

This also moves the attribute to its proper location under the rtc device
instead of the i2c parent device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1307.c | 53 +++++++++++-----------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index edccd0c0da25..982503a168d0 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1050,11 +1050,11 @@ static int m41txx_rtc_set_offset(struct device *dev, long offset)
 				  ctrl_reg);
 }
 
-static ssize_t frequency_test_enable_store(struct device *dev,
-					   struct device_attribute *attr,
-					   const char *buf, size_t count)
+static ssize_t frequency_test_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	struct ds1307 *ds1307 = dev_get_drvdata(dev->parent);
 	bool freq_test_en;
 	int ret;
 
@@ -1070,11 +1070,11 @@ static ssize_t frequency_test_enable_store(struct device *dev,
 	return count;
 }
 
-static ssize_t frequency_test_enable_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+static ssize_t frequency_test_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	struct ds1307 *ds1307 = dev_get_drvdata(dev->parent);
 	unsigned int ctrl_reg;
 
 	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
@@ -1083,10 +1083,10 @@ static ssize_t frequency_test_enable_show(struct device *dev,
 			"off\n");
 }
 
-static DEVICE_ATTR_RW(frequency_test_enable);
+static DEVICE_ATTR_RW(frequency_test);
 
 static struct attribute *rtc_freq_test_attrs[] = {
-	&dev_attr_frequency_test_enable.attr,
+	&dev_attr_frequency_test.attr,
 	NULL,
 };
 
@@ -1094,13 +1094,6 @@ static const struct attribute_group rtc_freq_test_attr_group = {
 	.attrs		= rtc_freq_test_attrs,
 };
 
-static void rtc_calib_remove_sysfs_group(void *_dev)
-{
-	struct device *dev = _dev;
-
-	sysfs_remove_group(&dev->kobj, &rtc_freq_test_attr_group);
-}
-
 static int ds1307_add_frequency_test(struct ds1307 *ds1307)
 {
 	int err;
@@ -1109,27 +1102,9 @@ static int ds1307_add_frequency_test(struct ds1307 *ds1307)
 	case m41t0:
 	case m41t00:
 	case m41t11:
-		/* Export sysfs entries */
-		err = sysfs_create_group(&(ds1307->dev)->kobj,
-					 &rtc_freq_test_attr_group);
-		if (err) {
-			dev_err(ds1307->dev,
-				"Failed to create sysfs group: %d\n",
-				err);
-			return err;
-		}
-
-		err = devm_add_action_or_reset(ds1307->dev,
-					       rtc_calib_remove_sysfs_group,
-					       ds1307->dev);
-		if (err) {
-			dev_err(ds1307->dev,
-				"Failed to add sysfs cleanup action: %d\n",
-				err);
-			sysfs_remove_group(&(ds1307->dev)->kobj,
-					   &rtc_freq_test_attr_group);
+		err = rtc_add_group(ds1307->rtc, &rtc_freq_test_attr_group);
+		if (err)
 			return err;
-		}
 		break;
 	default:
 		break;
@@ -1876,11 +1851,11 @@ static int ds1307_probe(struct i2c_client *client,
 	}
 
 	ds1307->rtc->ops = chip->rtc_ops ?: &ds13xx_rtc_ops;
-	err = rtc_register_device(ds1307->rtc);
+	err = ds1307_add_frequency_test(ds1307);
 	if (err)
 		return err;
 
-	err = ds1307_add_frequency_test(ds1307);
+	err = rtc_register_device(ds1307->rtc);
 	if (err)
 		return err;
 
-- 
2.19.0

