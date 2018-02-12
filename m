Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933143AbeBLWsw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:52 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37577 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932940AbeBLWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:37 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 23/45] rtc: ds1343: remove undocumented and useless sysfs files
Date: Mon, 12 Feb 2018 23:47:37 +0100
Message-Id: <20180212224759.15999-24-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A documented ABI already exists to get information about the alarm. It is
the only one that is used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1343.c | 96 +-----------------------------------------------
 1 file changed, 1 insertion(+), 95 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index a5a5a363c6e1..67cae0dd8154 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -199,74 +199,6 @@ static struct bin_attribute nvram_attr = {
 	.size		= DS1343_NVRAM_LEN,
 };
 
-static ssize_t ds1343_show_alarmstatus(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct ds1343_priv *priv = dev_get_drvdata(dev);
-	int alarmstatus, data;
-
-	regmap_read(priv->map, DS1343_CONTROL_REG, &data);
-
-	alarmstatus = !!(data & DS1343_A0IE);
-
-	if (alarmstatus)
-		return sprintf(buf, "enabled\n");
-	else
-		return sprintf(buf, "disabled\n");
-}
-
-static DEVICE_ATTR(alarm_status, S_IRUGO, ds1343_show_alarmstatus, NULL);
-
-static ssize_t ds1343_show_alarmmode(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct ds1343_priv *priv = dev_get_drvdata(dev);
-	int alarm_mode, data;
-	char *alarm_str;
-
-	regmap_read(priv->map, DS1343_ALM0_SEC_REG, &data);
-	alarm_mode = (data & 0x80) >> 4;
-
-	regmap_read(priv->map, DS1343_ALM0_MIN_REG, &data);
-	alarm_mode |= (data & 0x80) >> 5;
-
-	regmap_read(priv->map, DS1343_ALM0_HOUR_REG, &data);
-	alarm_mode |= (data & 0x80) >> 6;
-
-	regmap_read(priv->map, DS1343_ALM0_DAY_REG, &data);
-	alarm_mode |= (data & 0x80) >> 7;
-
-	switch (alarm_mode) {
-	case 15:
-		alarm_str = "each second";
-		break;
-
-	case 7:
-		alarm_str = "seconds match";
-		break;
-
-	case 3:
-		alarm_str = "minutes and seconds match";
-		break;
-
-	case 1:
-		alarm_str = "hours, minutes and seconds match";
-		break;
-
-	case 0:
-		alarm_str = "day, hours, minutes and seconds match";
-		break;
-
-	default:
-		alarm_str = "invalid";
-		break;
-	}
-
-	return sprintf(buf, "%s\n", alarm_str);
-}
-
-static DEVICE_ATTR(alarm_mode, S_IRUGO, ds1343_show_alarmmode, NULL);
-
 static ssize_t ds1343_show_tricklecharger(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -313,7 +245,6 @@ static DEVICE_ATTR(trickle_charger, S_IRUGO, ds1343_show_tricklecharger, NULL);
 
 static int ds1343_sysfs_register(struct device *dev)
 {
-	struct ds1343_priv *priv = dev_get_drvdata(dev);
 	int err;
 
 	err = device_create_file(dev, &dev_attr_glitch_filter);
@@ -325,26 +256,9 @@ static int ds1343_sysfs_register(struct device *dev)
 		goto error1;
 
 	err = device_create_bin_file(dev, &nvram_attr);
-	if (err)
-		goto error2;
-
-	if (priv->irq <= 0)
-		return err;
-
-	err = device_create_file(dev, &dev_attr_alarm_mode);
-	if (err)
-		goto error3;
-
-	err = device_create_file(dev, &dev_attr_alarm_status);
 	if (!err)
-		return err;
-
-	device_remove_file(dev, &dev_attr_alarm_mode);
-
-error3:
-	device_remove_bin_file(dev, &nvram_attr);
+		return 0;
 
-error2:
 	device_remove_file(dev, &dev_attr_trickle_charger);
 
 error1:
@@ -355,17 +269,9 @@ static int ds1343_sysfs_register(struct device *dev)
 
 static void ds1343_sysfs_unregister(struct device *dev)
 {
-	struct ds1343_priv *priv = dev_get_drvdata(dev);
-
 	device_remove_file(dev, &dev_attr_glitch_filter);
 	device_remove_file(dev, &dev_attr_trickle_charger);
 	device_remove_bin_file(dev, &nvram_attr);
-
-	if (priv->irq <= 0)
-		return;
-
-	device_remove_file(dev, &dev_attr_alarm_status);
-	device_remove_file(dev, &dev_attr_alarm_mode);
 }
 
 static int ds1343_read_time(struct device *dev, struct rtc_time *dt)
-- 
2.16.1
