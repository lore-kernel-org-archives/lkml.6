Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C45C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F12214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ8tSMTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F12214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLFTWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36288 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeLFTWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so654815pfc.3;
        Thu, 06 Dec 2018 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RHPPEPnYKHow4XGRcU1oCogeUqJe4B58l6SUQxY7qlQ=;
        b=vJ8tSMTp1olSxSnlpoO1WP8LWiT//felO/zNtrJNIgKr8WEthMkt69bkVOI5H0SnmY
         rQUhVDURrDyyVSXS6tsM66/Lu2IYIrINq00AtIxelZMJOCMOHNBmmIbKK8B7HMrPE4Zj
         tFFL0qQQB+lL1AN37qi+L9kbqu2OSni+6CRSJEMojs96EErDP2dHgWnmVu29PFIx0+Ks
         ejl/AdOMH8ceXXy9yj60twyxFr7jSv14Axz87X2cqplFrvmczD+1rLRqDD0gU67gWwih
         1s7x+EkTkNcQlfDswT1P+A5XcEOlWexRVUm+4/krkt1unxYFdghGi+n1UhWayUd3nod2
         taUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RHPPEPnYKHow4XGRcU1oCogeUqJe4B58l6SUQxY7qlQ=;
        b=S8sKEZvJl9eeg4pOktRqO4t/0hRGfQadJnc6C2O8HzOEhwv17gebsisHWMjb5/tdml
         DXTdno0HK3vNpi0x16gXYuDpzIp55mosa8lACqiN4joZ3fiaL3w9Z2QvRHl3lUbBWgWj
         J46jd/n8UzXY/UFq05VGFnVZps6/DqA9FB9gl5qG7TsjBbUQn47jURZzC72vPxEpHFN3
         Ek3HnpXkLfdVJPNx3Hzzg5HHcdWGSalihARpd7U1z5wW19jO/IsDNPowcZEtX8fi65wD
         /U2LWlaXFvpuIuLyTF4UXuO3uZW3D55DFAnVwrXTX4lOoDDu2GpbvwtsxyTfDCwXbw+b
         RNHw==
X-Gm-Message-State: AA+aEWZ1CnkcXR4o2slrBaT23LrbX1DJwBrMdq613Mc2CiMXW8uvX53a
        tVGmKDPGoTL3+w9jQWqa2tdxu2jQ
X-Google-Smtp-Source: AFSGD/XgmQFZRun18xzeX1ohJ6zDI+WLoC/wyEo+tMYj6IkQ9o1cwnVDxuiet/f9Zhyd1EIPjtMAVA==
X-Received: by 2002:a62:26c7:: with SMTP id m190mr30321885pfm.79.1544124164378;
        Thu, 06 Dec 2018 11:22:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y6sm1685694pfd.104.2018.12.06.11.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:43 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/13] hwmon: (lm95234) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:24 -0800
Message-Id: <1544124153-23961-5-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
References: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-conversion was done done using the coccinelle script at
https://github.com/groeck/coccinelle-patches/blob/master/hwmon/sensor-devattr-w6.cocci

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm95234.c | 161 ++++++++++++++++++++----------------------------
 1 file changed, 67 insertions(+), 94 deletions(-)

diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index c7fcc9e7f57a..02cd48bdde8d 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -211,7 +211,7 @@ static int lm95234_update_device(struct lm95234_data *data)
 	return ret;
 }
 
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -225,8 +225,8 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
 		       DIV_ROUND_CLOSEST(data->temp[index] * 125, 32));
 }
 
-static ssize_t show_alarm(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	u32 mask = to_sensor_dev_attr(attr)->index;
@@ -238,7 +238,7 @@ static ssize_t show_alarm(struct device *dev,
 	return sprintf(buf, "%u", !!(data->status & mask));
 }
 
-static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -251,8 +251,8 @@ static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, data->sensor_type & mask ? "1\n" : "2\n");
 }
 
-static ssize_t set_type(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t type_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -282,7 +282,7 @@ static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_tcrit2(struct device *dev, struct device_attribute *attr,
+static ssize_t tcrit2_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -295,8 +295,8 @@ static ssize_t show_tcrit2(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u", data->tcrit2[index] * 1000);
 }
 
-static ssize_t set_tcrit2(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t tcrit2_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -320,7 +320,7 @@ static ssize_t set_tcrit2(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_tcrit2_hyst(struct device *dev,
+static ssize_t tcrit2_hyst_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -335,7 +335,7 @@ static ssize_t show_tcrit2_hyst(struct device *dev,
 		       ((int)data->tcrit2[index] - (int)data->thyst) * 1000);
 }
 
-static ssize_t show_tcrit1(struct device *dev, struct device_attribute *attr,
+static ssize_t tcrit1_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -344,8 +344,8 @@ static ssize_t show_tcrit1(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u", data->tcrit1[index] * 1000);
 }
 
-static ssize_t set_tcrit1(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t tcrit1_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -369,7 +369,7 @@ static ssize_t set_tcrit1(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_tcrit1_hyst(struct device *dev,
+static ssize_t tcrit1_hyst_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -384,9 +384,9 @@ static ssize_t show_tcrit1_hyst(struct device *dev,
 		       ((int)data->tcrit1[index] - (int)data->thyst) * 1000);
 }
 
-static ssize_t set_tcrit1_hyst(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t tcrit1_hyst_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -411,7 +411,7 @@ static ssize_t set_tcrit1_hyst(struct device *dev,
 	return count;
 }
 
-static ssize_t show_offset(struct device *dev, struct device_attribute *attr,
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -424,8 +424,8 @@ static ssize_t show_offset(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d", data->toffset[index] * 500);
 }
 
-static ssize_t set_offset(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t offset_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -492,80 +492,53 @@ static ssize_t update_interval_store(struct device *dev,
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
-
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(0) | BIT(1));
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(2) | BIT(3));
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(4) | BIT(5));
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(6) | BIT(7));
-
-static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(1));
-static SENSOR_DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(2));
-static SENSOR_DEVICE_ATTR(temp4_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(3));
-static SENSOR_DEVICE_ATTR(temp5_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(4));
-
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_tcrit2,
-			  set_tcrit2, 0);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_tcrit2,
-			  set_tcrit2, 1);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 3);
-static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 4);
-
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_tcrit1_hyst,
-			  set_tcrit1_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO, show_tcrit2_hyst, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO, show_tcrit2_hyst, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_max_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 4);
-
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(0 + 8));
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(1 + 16));
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(2 + 16));
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(3 + 8));
-static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(4 + 8));
-
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 1);
-static SENSOR_DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 2);
-
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 2);
-
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(1 + 8));
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(2 + 8));
-
-static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 0);
-static SENSOR_DEVICE_ATTR(temp3_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 1);
-static SENSOR_DEVICE_ATTR(temp4_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 2);
-static SENSOR_DEVICE_ATTR(temp5_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp, 4);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, BIT(0) | BIT(1));
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, BIT(2) | BIT(3));
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, alarm, BIT(4) | BIT(5));
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, alarm, BIT(6) | BIT(7));
+
+static SENSOR_DEVICE_ATTR_RW(temp2_type, type, BIT(1));
+static SENSOR_DEVICE_ATTR_RW(temp3_type, type, BIT(2));
+static SENSOR_DEVICE_ATTR_RW(temp4_type, type, BIT(3));
+static SENSOR_DEVICE_ATTR_RW(temp5_type, type, BIT(4));
+
+static SENSOR_DEVICE_ATTR_RW(temp1_max, tcrit1, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, tcrit2, 0);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, tcrit2, 1);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, tcrit1, 3);
+static SENSOR_DEVICE_ATTR_RW(temp5_max, tcrit1, 4);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, tcrit1_hyst, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_hyst, tcrit2_hyst, 0);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_hyst, tcrit2_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_hyst, tcrit1_hyst, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_max_hyst, tcrit1_hyst, 4);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, BIT(0 + 8));
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, BIT(1 + 16));
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, BIT(2 + 16));
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, alarm, BIT(3 + 8));
+static SENSOR_DEVICE_ATTR_RO(temp5_max_alarm, alarm, BIT(4 + 8));
+
+static SENSOR_DEVICE_ATTR_RW(temp2_crit, tcrit1, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_crit, tcrit1, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_hyst, tcrit1_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_hyst, tcrit1_hyst, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, BIT(1 + 8));
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, BIT(2 + 8));
+
+static SENSOR_DEVICE_ATTR_RW(temp2_offset, offset, 0);
+static SENSOR_DEVICE_ATTR_RW(temp3_offset, offset, 1);
+static SENSOR_DEVICE_ATTR_RW(temp4_offset, offset, 2);
+static SENSOR_DEVICE_ATTR_RW(temp5_offset, offset, 3);
 
 static DEVICE_ATTR_RW(update_interval);
 
-- 
2.7.4

