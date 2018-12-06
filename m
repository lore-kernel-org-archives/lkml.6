Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B863C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4EE20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDb6dMN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4EE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLFTWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38604 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeLFTWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so650783pfi.5;
        Thu, 06 Dec 2018 11:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eftKSuL9peNDKKZDwErosq0qFhYkDcPtZtXPBeMIzfw=;
        b=cDb6dMN8e3lQy+hjil8wBjaUKHDzhUx8ezbvxwH7aWNyopocbrM/9LSJ1UX+Rpt+c+
         LXEMsb8H40qwOhkuH7N3Zaibq6Id6Syy1s2eRhgOozIvMjK4BMn+xt8h9wc5DyPTBPiK
         mT5fVV+ZiAxRZaSsYIeK9ijp0e4qWi4Bkw+OlIni/G3ew1cFUd5BSIna0Q/zsai0U4cy
         Zx2PrOGvHEkwdFSiwRx+Bufe/GxX6tYovdMoBRlAvNto2C0fsqqXI2QsxM36N1wNvGka
         n44T80pRX4FH5Kahvtq615FOqrrgGMjuAD1foJRKpmL3DjXfbuYrW2rYsGRST9epTpJU
         sYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=eftKSuL9peNDKKZDwErosq0qFhYkDcPtZtXPBeMIzfw=;
        b=IW/ZFoDIlHXrzekFgY/7bKIrGjRMFurxS20sddG0WuocOb2PMhzEctN6JpHkYzOMzH
         +eMDkGBmokypcURjM/xFS0XRGj14LbBogh1bhMKeQbkLQl+gTGtsqo7j6VeP/acN3kYD
         FTWwvFDHHTEY8FPCwzJFd39tSDTtnA4zMmyutOlZ3fNZBWuZA7xvIhsUze3MP6bkqY/+
         xRLD+XwtxjhGA40tfyAXtEkVnomK5XGhg4pPL4H8fpBueQgDOXgFGWwQwWoFYgFCTvUy
         OevIknrAnyKgublwrmbGUoZaYhMPyCz13BjBp9967VB9OLW5KCI9V4GL46/13GdzXmZX
         G3og==
X-Gm-Message-State: AA+aEWan7p2kQl2/iSe5n1TXXJUPbh7sDYWJk9n2QfwoHXgaFr9FbKNM
        CjCNrpSLtnqULhVA316BsjpZdn0k
X-Google-Smtp-Source: AFSGD/XeN1iz7gTlGwcbcbz68Llj3MQtXqi2fHFwsWs2hHCU9hHan2ethzw44mnoLFNOOMjR7/jSIg==
X-Received: by 2002:a62:d005:: with SMTP id p5mr21490650pfg.175.1544124166008;
        Thu, 06 Dec 2018 11:22:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12sm1701100pfk.70.2018.12.06.11.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:45 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/13] hwmon: (nct7802) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:25 -0800
Message-Id: <1544124153-23961-6-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
References: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-conversion was done done using the coccinelle script at
https://github.com/groeck/coccinelle-patches/raw/master/hwmon/sensor-devattr-w6.cocci

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct7802.c | 408 +++++++++++++++++++-----------------------------
 1 file changed, 157 insertions(+), 251 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 2876c18ed841..6aa44492ae30 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -69,8 +69,8 @@ struct nct7802_data {
 	struct mutex access_lock; /* for multi-byte read and write operations */
 };
 
-static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
-			      char *buf)
+static ssize_t temp_type_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
@@ -84,9 +84,9 @@ static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", (mode >> (2 * sattr->index) & 3) + 2);
 }
 
-static ssize_t store_temp_type(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t temp_type_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
@@ -105,8 +105,8 @@ static ssize_t store_temp_type(struct device *dev,
 	return err ? : count;
 }
 
-static ssize_t show_pwm_mode(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t pwm_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -123,7 +123,7 @@ static ssize_t show_pwm_mode(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", !(regval & (1 << sattr->index)));
 }
 
-static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -141,7 +141,7 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%d\n", val);
 }
 
-static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
+static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
 			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -157,7 +157,7 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
 	return err ? : count;
 }
 
-static ssize_t show_pwm_enable(struct device *dev,
+static ssize_t pwm_enable_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -172,7 +172,7 @@ static ssize_t show_pwm_enable(struct device *dev,
 	return sprintf(buf, "%u\n", enabled + 1);
 }
 
-static ssize_t store_pwm_enable(struct device *dev,
+static ssize_t pwm_enable_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
@@ -345,7 +345,7 @@ static int nct7802_write_voltage(struct nct7802_data *data, int nr, int index,
 	return err;
 }
 
-static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -359,7 +359,7 @@ static ssize_t show_in(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", voltage);
 }
 
-static ssize_t store_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_store(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -377,7 +377,7 @@ static ssize_t store_in(struct device *dev, struct device_attribute *attr,
 	return err ? : count;
 }
 
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -391,7 +391,7 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", temp);
 }
 
-static ssize_t store_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -410,7 +410,7 @@ static ssize_t store_temp(struct device *dev, struct device_attribute *attr,
 	return err ? : count;
 }
 
-static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
@@ -424,7 +424,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", speed);
 }
 
-static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_min_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -438,8 +438,9 @@ static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", speed);
 }
 
-static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -454,7 +455,7 @@ static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
 	return err ? : count;
 }
 
-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -471,7 +472,7 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
-show_beep(struct device *dev, struct device_attribute *attr, char *buf)
+beep_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -486,7 +487,7 @@ show_beep(struct device *dev, struct device_attribute *attr, char *buf)
 }
 
 static ssize_t
-store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
+beep_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	   size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -505,108 +506,64 @@ store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
 	return err ? : count;
 }
 
-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
-			  show_temp_type, store_temp_type, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0x01,
-			    REG_TEMP_LSB);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x31, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x30, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3a, 0);
-
-static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
-			  show_temp_type, store_temp_type, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0x02,
-			    REG_TEMP_LSB);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x33, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x32, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3b, 0);
-
-static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
-			  show_temp_type, store_temp_type, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0x03,
-			    REG_TEMP_LSB);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x35, 0);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x34, 0);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3c, 0);
-
-static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 0x04, 0);
-static SENSOR_DEVICE_ATTR_2(temp4_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x37, 0);
-static SENSOR_DEVICE_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x36, 0);
-static SENSOR_DEVICE_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3d, 0);
-
-static SENSOR_DEVICE_ATTR_2(temp5_input, S_IRUGO, show_temp, NULL, 0x06,
-			    REG_TEMP_PECI_LSB);
-static SENSOR_DEVICE_ATTR_2(temp5_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x39, 0);
-static SENSOR_DEVICE_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x38, 0);
-static SENSOR_DEVICE_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3e, 0);
-
-static SENSOR_DEVICE_ATTR_2(temp6_input, S_IRUGO, show_temp, NULL, 0x07,
-			    REG_TEMP_PECI_LSB);
-
-static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 4);
-
-static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 4);
-
-static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 4);
-
-static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, show_alarm, NULL, 0x17, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_fault, S_IRUGO, show_alarm, NULL, 0x17, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_alarm, NULL, 0x17, 2);
-
-static SENSOR_DEVICE_ATTR_2(temp1_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 4);
-static SENSOR_DEVICE_ATTR_2(temp6_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 5);
+static SENSOR_DEVICE_ATTR_RW(temp1_type, temp_type, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0x01, REG_TEMP_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_min, temp, 0x31, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0x30, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0x3a, 0);
+
+static SENSOR_DEVICE_ATTR_RW(temp2_type, temp_type, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0x02, REG_TEMP_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_min, temp, 0x33, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 0x32, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, 0x3b, 0);
+
+static SENSOR_DEVICE_ATTR_RW(temp3_type, temp_type, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 0x03, REG_TEMP_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_min, temp, 0x35, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 0x34, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, 0x3c, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 0x04, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_min, temp, 0x37, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_max, temp, 0x36, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_crit, temp, 0x3d, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp5_input, temp, 0x06, REG_TEMP_PECI_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_min, temp, 0x39, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_max, temp, 0x38, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_crit, temp, 0x3e, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp6_input, temp, 0x07, REG_TEMP_PECI_LSB);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_min_alarm, alarm, 0x18, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_min_alarm, alarm, 0x18, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_min_alarm, alarm, 0x18, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_min_alarm, alarm, 0x18, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_min_alarm, alarm, 0x18, 4);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_max_alarm, alarm, 0x19, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_max_alarm, alarm, 0x19, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_max_alarm, alarm, 0x19, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_max_alarm, alarm, 0x19, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_max_alarm, alarm, 0x19, 4);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_crit_alarm, alarm, 0x1b, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_crit_alarm, alarm, 0x1b, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_crit_alarm, alarm, 0x1b, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_crit_alarm, alarm, 0x1b, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_crit_alarm, alarm, 0x1b, 4);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_fault, alarm, 0x17, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_fault, alarm, 0x17, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_fault, alarm, 0x17, 2);
+
+static SENSOR_DEVICE_ATTR_2_RW(temp1_beep, beep, 0x5c, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_beep, beep, 0x5c, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_beep, beep, 0x5c, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_beep, beep, 0x5c, 3);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_beep, beep, 0x5c, 4);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_beep, beep, 0x5c, 5);
 
 static struct attribute *nct7802_temp_attrs[] = {
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
@@ -709,43 +666,31 @@ static const struct attribute_group nct7802_temp_group = {
 	.is_visible = nct7802_temp_is_visible,
 };
 
-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    0, 1);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    0, 2);
-static SENSOR_DEVICE_ATTR_2(in0_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 3);
-static SENSOR_DEVICE_ATTR_2(in0_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 3);
-
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 1, 0);
-
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 2, 0);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    2, 1);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    2, 2);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 0);
-static SENSOR_DEVICE_ATTR_2(in2_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 0);
-
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 3, 0);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    3, 1);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    3, 2);
-static SENSOR_DEVICE_ATTR_2(in3_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 1);
-static SENSOR_DEVICE_ATTR_2(in3_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 1);
-
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    4, 1);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    4, 2);
-static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 2);
-static SENSOR_DEVICE_ATTR_2(in4_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in0_input, in, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, in, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, in, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in0_alarm, alarm, 0x1e, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in0_beep, beep, 0x5a, 3);
+
+static SENSOR_DEVICE_ATTR_2_RO(in1_input, in, 1, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(in2_input, in, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, in, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, in, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in2_alarm, alarm, 0x1e, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in2_beep, beep, 0x5a, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(in3_input, in, 3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, in, 3, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, in, 3, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in3_alarm, alarm, 0x1e, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in3_beep, beep, 0x5a, 1);
+
+static SENSOR_DEVICE_ATTR_2_RO(in4_input, in, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, in, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, in, 4, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in4_alarm, alarm, 0x1e, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in4_beep, beep, 0x5a, 2);
 
 static struct attribute *nct7802_in_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
@@ -807,45 +752,33 @@ static const struct attribute_group nct7802_in_group = {
 	.is_visible = nct7802_in_is_visible,
 };
 
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0x10);
-static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGO | S_IWUSR, show_fan_min,
-			    store_fan_min, 0x49, 0x4c);
-static SENSOR_DEVICE_ATTR_2(fan1_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 0);
-static SENSOR_DEVICE_ATTR_2(fan1_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5b, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 0x11);
-static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGO | S_IWUSR, show_fan_min,
-			    store_fan_min, 0x4a, 0x4d);
-static SENSOR_DEVICE_ATTR_2(fan2_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 1);
-static SENSOR_DEVICE_ATTR_2(fan2_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5b, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 0x12);
-static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGO | S_IWUSR, show_fan_min,
-			    store_fan_min, 0x4b, 0x4e);
-static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 2);
-static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5b, 2);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0x10);
+static SENSOR_DEVICE_ATTR_2_RW(fan1_min, fan_min, 0x49, 0x4c);
+static SENSOR_DEVICE_ATTR_2_RO(fan1_alarm, alarm, 0x1a, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan1_beep, beep, 0x5b, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 0x11);
+static SENSOR_DEVICE_ATTR_2_RW(fan2_min, fan_min, 0x4a, 0x4d);
+static SENSOR_DEVICE_ATTR_2_RO(fan2_alarm, alarm, 0x1a, 1);
+static SENSOR_DEVICE_ATTR_2_RW(fan2_beep, beep, 0x5b, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 0x12);
+static SENSOR_DEVICE_ATTR_2_RW(fan3_min, fan_min, 0x4b, 0x4e);
+static SENSOR_DEVICE_ATTR_2_RO(fan3_alarm, alarm, 0x1a, 2);
+static SENSOR_DEVICE_ATTR_2_RW(fan3_beep, beep, 0x5b, 2);
 
 /* 7.2.89 Fan Control Output Type */
-static SENSOR_DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL, 0);
-static SENSOR_DEVICE_ATTR(pwm2_mode, S_IRUGO, show_pwm_mode, NULL, 1);
-static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(pwm1_mode, pwm_mode, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm2_mode, pwm_mode, 1);
+static SENSOR_DEVICE_ATTR_RO(pwm3_mode, pwm_mode, 2);
 
 /* 7.2.91... Fan Control Output Value */
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
-			  REG_PWM(0));
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
-			  REG_PWM(1));
-static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
-			  REG_PWM(2));
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, REG_PWM(0));
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, REG_PWM(1));
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, REG_PWM(2));
 
 /* 7.2.95... Temperature to Fan mapping Relationships Register */
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-			  store_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-			  store_pwm_enable, 1);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-			  store_pwm_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_enable, 2);
 
 static struct attribute *nct7802_fan_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
@@ -903,73 +836,46 @@ static const struct attribute_group nct7802_pwm_group = {
 };
 
 /* 7.2.115... 0x80-0x83, 0x84 Temperature (X-axis) transition */
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x80, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x81, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x82, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x83, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point5_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x84, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp, temp, 0x80, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_temp, temp, 0x81, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_temp, temp, 0x82, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_temp, temp, 0x83, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_temp, temp, 0x84, 0);
 
 /* 7.2.120... 0x85-0x88 PWM (Y-axis) transition */
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x85);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x86);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x87);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x88);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm, 0x85);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm, 0x86);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm, 0x87);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm, 0x88);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point5_pwm, pwm, 0);
 
 /* 7.2.124 Table 2 X-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x90, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x91, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x92, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x93, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point5_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x94, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_temp, temp, 0x90, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_temp, temp, 0x91, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_temp, temp, 0x92, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point4_temp, temp, 0x93, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point5_temp, temp, 0x94, 0);
 
 /* 7.2.129 Table 2 Y-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x95);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x96);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x97);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point4_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x98);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point1_pwm, pwm, 0x95);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point2_pwm, pwm, 0x96);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point3_pwm, pwm, 0x97);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point4_pwm, pwm, 0x98);
+static SENSOR_DEVICE_ATTR_RO(pwm2_auto_point5_pwm, pwm, 0);
 
 /* 7.2.133 Table 3 X-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA3, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point5_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp, temp, 0xA0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_temp, temp, 0xA1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_temp, temp, 0xA2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_temp, temp, 0xA3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_temp, temp, 0xA4, 0);
 
 /* 7.2.138 Table 3 Y-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA5);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA6);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA7);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point4_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA8);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point1_pwm, pwm, 0xA5);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point2_pwm, pwm, 0xA6);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point3_pwm, pwm, 0xA7);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point4_pwm, pwm, 0xA8);
+static SENSOR_DEVICE_ATTR_RO(pwm3_auto_point5_pwm, pwm, 0);
 
 static struct attribute *nct7802_auto_point_attrs[] = {
 	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
-- 
2.7.4

