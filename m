Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F8BC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCBE20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuWRs/W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCBE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLFTXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44950 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeLFTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so561345pgr.11;
        Thu, 06 Dec 2018 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1/6agFlpRt+08ZxxIaIhPePfLZAeTzCqcROYxg7U30=;
        b=JuWRs/W+oKLte3cavGDQTHcueOeAt4Z585VjC8/Er0t58pADhJWGuahxYWUTSi2A0s
         wIfVlJRncLShONrpZyVOMnfF1RE9ZR4Ut4MoNIk3oinEtndOZwbVzMXHtRhZ9rZfguJ9
         yTVlqvkLZGqsCu8oJ+81SUXhg4u2gYpz0rfQVnyoXfDa/4m5d/DZwI/cXJCy9C5MU6TJ
         aLwfWfxKBm70almfizg9qbonCRk4HgjKWhROh37y6DvT8sRKlRrAg1Y424T5T5u114Rk
         OzDBuYgLuigHokA+6hKN93WPvS6Fbva5U1tUpQFXWoPUJUfgTLTMOWEwXHgTOyoy1jE6
         CLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Z1/6agFlpRt+08ZxxIaIhPePfLZAeTzCqcROYxg7U30=;
        b=lia6ilJzFuDPi4ExY7nbwMTgIdZHF56tWbJWGReGGoTpmor4MAnvqQArjIrvXbpJON
         s3e8OeIsujhHtpmbp9D2Z2dlS7FS2Zmpofquvx/n4ce+zvyMtV5NaVYOfwyw8YkxNQ9v
         F5tJuTe+J8YbmAA7+fChoOBHymdMZBrKVdC4HGZGGhe2xRNOi7j+o5uTsmb9Dv+IAsBV
         uo/2A+NH5qW63opl6G8hGClQNdKRk3fbpj5Rg5c17Hcf40kHmgMSsXUVMVzikr6gdgJj
         rtUXicjp3P27UJ8E2llprhfUOCe6VHAdX2mwcQFD3CvHbHOiBjs/DyZK5Wyt3r7WOQN4
         xQ5g==
X-Gm-Message-State: AA+aEWbFwNKhln/uK2cEBNbPbRqLU1O1YYw75jr0dtQypN9RTnzq0Cij
        /T6hgzXawdFkx+vstowMQX+aiTFz
X-Google-Smtp-Source: AFSGD/VPc7M6w+EUQ/ihEViXPutqbvEfMDFpjkORLF5K3BWsScib0qFlsRWAfq/kDk0AEpUSU8X0Ow==
X-Received: by 2002:a62:f247:: with SMTP id y7mr29824794pfl.25.1544124173505;
        Thu, 06 Dec 2018 11:22:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm1547353pfa.167.2018.12.06.11.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:52 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 10/13] hwmon: (max6697) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:30 -0800
Message-Id: <1544124153-23961-11-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/max6697.c | 144 +++++++++++++++++++++---------------------------
 1 file changed, 64 insertions(+), 80 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 221fd1492057..da43f7ae3de1 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -250,7 +250,7 @@ static struct max6697_data *max6697_update_device(struct device *dev)
 	return ret;
 }
 
-static ssize_t show_temp_input(struct device *dev,
+static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -266,8 +266,8 @@ static ssize_t show_temp_input(struct device *dev,
 	return sprintf(buf, "%d\n", temp * 125);
 }
 
-static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int index = to_sensor_dev_attr_2(devattr)->index;
@@ -283,7 +283,7 @@ static ssize_t show_temp(struct device *dev,
 	return sprintf(buf, "%d\n", temp * 1000);
 }
 
-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -298,9 +298,9 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", (data->alarms >> index) & 0x1);
 }
 
-static ssize_t set_temp(struct device *dev,
-			struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int index = to_sensor_dev_attr_2(devattr)->index;
@@ -325,79 +325,63 @@ static ssize_t set_temp(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input, NULL, 3);
-static SENSOR_DEVICE_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp_input, NULL, 4);
-static SENSOR_DEVICE_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp_input, NULL, 5);
-static SENSOR_DEVICE_ATTR_2(temp6_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp6_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp_input, NULL, 6);
-static SENSOR_DEVICE_ATTR_2(temp7_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    6, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp7_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    6, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp_input, NULL, 7);
-static SENSOR_DEVICE_ATTR_2(temp8_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    7, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp8_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    7, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 22);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 18);
-static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL, 19);
-static SENSOR_DEVICE_ATTR(temp6_max_alarm, S_IRUGO, show_alarm, NULL, 20);
-static SENSOR_DEVICE_ATTR(temp7_max_alarm, S_IRUGO, show_alarm, NULL, 21);
-static SENSOR_DEVICE_ATTR(temp8_max_alarm, S_IRUGO, show_alarm, NULL, 23);
-
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp4_crit_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp6_crit_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp7_crit_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp8_crit_alarm, S_IRUGO, show_alarm, NULL, 15);
-
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_fault, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_fault, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 1, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, 1, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_input, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 2, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, 2, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp_input, 3);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_max, temp, 3, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_crit, temp, 3, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp_input, 4);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_max, temp, 4, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_crit, temp, 4, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp6_input, temp_input, 5);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_max, temp, 5, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_crit, temp, 5, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp7_input, temp_input, 6);
+static SENSOR_DEVICE_ATTR_2_RW(temp7_max, temp, 6, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp7_crit, temp, 6, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp8_input, temp_input, 7);
+static SENSOR_DEVICE_ATTR_2_RW(temp8_max, temp, 7, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp8_crit, temp, 7, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 22);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, alarm, 18);
+static SENSOR_DEVICE_ATTR_RO(temp5_max_alarm, alarm, 19);
+static SENSOR_DEVICE_ATTR_RO(temp6_max_alarm, alarm, 20);
+static SENSOR_DEVICE_ATTR_RO(temp7_max_alarm, alarm, 21);
+static SENSOR_DEVICE_ATTR_RO(temp8_max_alarm, alarm, 23);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(temp5_crit_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp6_crit_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(temp7_crit_alarm, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(temp8_crit_alarm, alarm, 15);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_fault, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_fault, alarm, 7);
 
 static DEVICE_ATTR(dummy, 0, NULL, NULL);
 
-- 
2.7.4

