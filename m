Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C372C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39DF20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcVCj95W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39DF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLFTX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45455 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLFTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so600837plm.12;
        Thu, 06 Dec 2018 11:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4e5+1M3430fd6oncWjPbtMjj83wvjYxilt6lZ/oqhmU=;
        b=VcVCj95WhuKQP4IFc43MBN0yHF/WJFbT9t1oNU56p/cCvZikuze3Msi9MZ+RTICf0V
         Lf3p0yol0iInDpc7jyWU5k7/j5fQPQKysAfcH1G1/GurK94CxevJbZE4BLNGP+geJFrv
         KY4d8rG8vEt03hyKhwM6EIXhIRwIazVeKsY0T5N+i+NA4L4EvzeTS7aWcrDchyLxS2zU
         ORY9YdGfIK06MwNe7gBeXOgCTOQL+sxqYCnriS45x83it1B+HRE3WCHJhdgAK37EgQou
         FvMitTrcuMSrnJs+g70qhspH21hZpjdsQ60++GU6FcQLN8o5+oxigfV/f7AODgu9HTLq
         31Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4e5+1M3430fd6oncWjPbtMjj83wvjYxilt6lZ/oqhmU=;
        b=HetbYY2zTxHhOjd2xon5TZJYxe57QhjPfNdJJlCvqONdKsVNbYOj2JZDHUEKpyOmF1
         y4vZz/3YjDTE7YWCs6SjQVjhyqHrWSqP2RJ0NyjPARvXJFjb+/z29kbqBm+vNdPZrLNL
         4kb9g/0DQZsLBgEfuPz4+qPP8hDZSCoGHPWRo97HVW7/F2jZnUq8ybe5jlNp/FTk47X1
         5NXulq5n/k3XyUAOyaF5bq+eCG+A9TejJuxdp+pu9Vb2pwCOZ8GN0s8TXkhvP/F+VJuB
         Flz5fFLPZQS58Qgv8wVClGoUCe7DxdHRGeujHVptnJu7xHO9HgCZgK0BYocUmWjWlI6g
         72lQ==
X-Gm-Message-State: AA+aEWYlrWJUymd4NcH4O7AQfR+lgIoDCUX41S14Ys5XunF+h4MdVWw7
        h7HPHvvIZ1AcRvqTU9o3spQKD+qw
X-Google-Smtp-Source: AFSGD/WTPitsjnl5mfcqo0d+CxTih2fZot/yfRP6IFC4demmX8axftjkZR/95TeCfr++R8butCdWSg==
X-Received: by 2002:a17:902:9345:: with SMTP id g5mr17729491plp.148.1544124161369;
        Thu, 06 Dec 2018 11:22:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 69sm1230798pgg.86.2018.12.06.11.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:40 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/13] hwmon: (ltc2945): Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:22 -0800
Message-Id: <1544124153-23961-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
References: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion was done done using the coccinelle script at
https://github.com/groeck/coccinelle-patches/raw/master/hwmon/sensor-devattr-w6.cocci

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc2945.c | 121 ++++++++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 71 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 1b92e4f6e234..f16716a1fead 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -226,7 +226,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	return val;
 }
 
-static ssize_t ltc2945_show_value(struct device *dev,
+static ssize_t ltc2945_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -238,9 +238,9 @@ static ssize_t ltc2945_show_value(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%lld\n", value);
 }
 
-static ssize_t ltc2945_set_value(struct device *dev,
-				     struct device_attribute *da,
-				     const char *buf, size_t count)
+static ssize_t ltc2945_value_store(struct device *dev,
+				   struct device_attribute *da,
+				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct regmap *regmap = dev_get_drvdata(dev);
@@ -273,7 +273,7 @@ static ssize_t ltc2945_set_value(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
-static ssize_t ltc2945_reset_history(struct device *dev,
+static ssize_t ltc2945_history_store(struct device *dev,
 				     struct device_attribute *da,
 				     const char *buf, size_t count)
 {
@@ -326,7 +326,7 @@ static ssize_t ltc2945_reset_history(struct device *dev,
 	return ret ? : count;
 }
 
-static ssize_t ltc2945_show_bool(struct device *dev,
+static ssize_t ltc2945_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -347,86 +347,65 @@ static ssize_t ltc2945_show_bool(struct device *dev,
 
 /* Input voltages */
 
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_VIN_H);
-static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_VIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_VIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in1_lowest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MIN_VIN_H);
-static SENSOR_DEVICE_ATTR(in1_highest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MAX_VIN_H);
-static SENSOR_DEVICE_ATTR(in1_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_VIN_H);
-
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_ADIN_H);
-static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_ADIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_ADIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in2_lowest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MIN_ADIN_H);
-static SENSOR_DEVICE_ATTR(in2_highest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MAX_ADIN_H);
-static SENSOR_DEVICE_ATTR(in2_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_ADIN_H);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc2945_value, LTC2945_VIN_H);
+static SENSOR_DEVICE_ATTR_RW(in1_min, ltc2945_value, LTC2945_MIN_VIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(in1_max, ltc2945_value, LTC2945_MAX_VIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(in1_lowest, ltc2945_value, LTC2945_MIN_VIN_H);
+static SENSOR_DEVICE_ATTR_RO(in1_highest, ltc2945_value, LTC2945_MAX_VIN_H);
+static SENSOR_DEVICE_ATTR_WO(in1_reset_history, ltc2945_history,
+			     LTC2945_MIN_VIN_H);
+
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc2945_value, LTC2945_ADIN_H);
+static SENSOR_DEVICE_ATTR_RW(in2_min, ltc2945_value, LTC2945_MIN_ADIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(in2_max, ltc2945_value, LTC2945_MAX_ADIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(in2_lowest, ltc2945_value, LTC2945_MIN_ADIN_H);
+static SENSOR_DEVICE_ATTR_RO(in2_highest, ltc2945_value, LTC2945_MAX_ADIN_H);
+static SENSOR_DEVICE_ATTR_WO(in2_reset_history, ltc2945_history,
+			     LTC2945_MIN_ADIN_H);
 
 /* Voltage alarms */
 
-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_VIN_UV);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_VIN_OV);
-static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_ADIN_UV);
-static SENSOR_DEVICE_ATTR(in2_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_ADIN_OV);
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ltc2945_bool, FAULT_VIN_UV);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ltc2945_bool, FAULT_VIN_OV);
+static SENSOR_DEVICE_ATTR_RO(in2_min_alarm, ltc2945_bool, FAULT_ADIN_UV);
+static SENSOR_DEVICE_ATTR_RO(in2_max_alarm, ltc2945_bool, FAULT_ADIN_OV);
 
 /* Currents (via sense resistor) */
 
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_SENSE_H);
-static SENSOR_DEVICE_ATTR(curr1_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_SENSE_THRES_H);
-static SENSOR_DEVICE_ATTR(curr1_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_SENSE_THRES_H);
-static SENSOR_DEVICE_ATTR(curr1_lowest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MIN_SENSE_H);
-static SENSOR_DEVICE_ATTR(curr1_highest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MAX_SENSE_H);
-static SENSOR_DEVICE_ATTR(curr1_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_SENSE_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc2945_value, LTC2945_SENSE_H);
+static SENSOR_DEVICE_ATTR_RW(curr1_min, ltc2945_value,
+			     LTC2945_MIN_SENSE_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(curr1_max, ltc2945_value,
+			     LTC2945_MAX_SENSE_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_lowest, ltc2945_value, LTC2945_MIN_SENSE_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_highest, ltc2945_value,
+			     LTC2945_MAX_SENSE_H);
+static SENSOR_DEVICE_ATTR_WO(curr1_reset_history, ltc2945_history,
+			     LTC2945_MIN_SENSE_H);
 
 /* Current alarms */
 
-static SENSOR_DEVICE_ATTR(curr1_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_SENSE_UV);
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_SENSE_OV);
+static SENSOR_DEVICE_ATTR_RO(curr1_min_alarm, ltc2945_bool, FAULT_SENSE_UV);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ltc2945_bool, FAULT_SENSE_OV);
 
 /* Power */
 
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_POWER_H);
-static SENSOR_DEVICE_ATTR(power1_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_POWER_THRES_H);
-static SENSOR_DEVICE_ATTR(power1_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_POWER_THRES_H);
-static SENSOR_DEVICE_ATTR(power1_input_lowest, S_IRUGO, ltc2945_show_value,
-			  NULL, LTC2945_MIN_POWER_H);
-static SENSOR_DEVICE_ATTR(power1_input_highest, S_IRUGO, ltc2945_show_value,
-			  NULL, LTC2945_MAX_POWER_H);
-static SENSOR_DEVICE_ATTR(power1_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_POWER_H);
+static SENSOR_DEVICE_ATTR_RO(power1_input, ltc2945_value, LTC2945_POWER_H);
+static SENSOR_DEVICE_ATTR_RW(power1_min, ltc2945_value,
+			     LTC2945_MIN_POWER_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(power1_max, ltc2945_value,
+			     LTC2945_MAX_POWER_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(power1_input_lowest, ltc2945_value,
+			     LTC2945_MIN_POWER_H);
+static SENSOR_DEVICE_ATTR_RO(power1_input_highest, ltc2945_value,
+			     LTC2945_MAX_POWER_H);
+static SENSOR_DEVICE_ATTR_WO(power1_reset_history, ltc2945_history,
+			     LTC2945_MIN_POWER_H);
 
 /* Power alarms */
 
-static SENSOR_DEVICE_ATTR(power1_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_POWER_UV);
-static SENSOR_DEVICE_ATTR(power1_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_POWER_OV);
+static SENSOR_DEVICE_ATTR_RO(power1_min_alarm, ltc2945_bool, FAULT_POWER_UV);
+static SENSOR_DEVICE_ATTR_RO(power1_max_alarm, ltc2945_bool, FAULT_POWER_OV);
 
 static struct attribute *ltc2945_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
-- 
2.7.4

