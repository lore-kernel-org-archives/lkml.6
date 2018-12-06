Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A97EC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D553214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcPVozyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D553214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLFTXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36552 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeLFTW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so576220pgm.3;
        Thu, 06 Dec 2018 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kxQNx5U5OpAjYRP1NllBU4oOIxGI/CyHuvMxeTPU4ss=;
        b=PcPVozyH8cFMPlMHnTQkEjaqh0A16RKbkg7l66y4OG3ym0dGFRaDSCKVrSmBP+WtGw
         25PY/ZikslutJuaetLo0qeX4BF4UuWnxBi+js29V9yoADo938D3xy6hmsp3+iKzGoYpg
         w1QdLg579R/KLDLpzG/hskBr6xdQ3D0gMQds8VoFq0uiI7g2gAfxCILeK4sdu8UnEVDp
         NuuIgR842Z9pz2Yn3GJ7rRPCMeV4keQ0I3wTijiGdZP4Fq5vLKOJjIxvZt4AqkRltwW0
         UJRdqEfv0Tpml9O9elj8QumvEGrCEFJepXUEgm4wWaoe/IpgORlKd0vAoQdeE38NlGjd
         r3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kxQNx5U5OpAjYRP1NllBU4oOIxGI/CyHuvMxeTPU4ss=;
        b=bvFhGA4shALaiQCBivIfsnJS049jnem31VkbfmqyDKKLQ/bVCoEwMFafIMTUupSorg
         rE7kaM+oOjxyKrYBAsb5jG1pp9LkDm8IG6RUL7vqpA5KvuGlY/Yq2ckTHNhz/XpB/n5/
         FkL50i56Qv4Cm8IGgwyv4eIC8zgsWnqgGrC653oT7OvqthVE/Ni+jWuneoZCJ0B4jSTj
         D6mytg9XTwc9m4icJK6nbmVlwo2IIiqp7YgdMW2DDoHKLkgd9TJaXUUDgZ0OwzL2/HJi
         PZkaQv/qL91KL1mHgC9Jw9NB+CwFu4KkEcd+sB+guvWrSoEL0q8tq1Rbf/eJ1eShYReo
         U5ug==
X-Gm-Message-State: AA+aEWaJCgBg8Q5LnxHpTJeQmjkCbpKEpcp8cB4TUyM4/W7KQ5MAjQiA
        s9oHE5zUcIDoKWjW2IyG52ZOfLLh
X-Google-Smtp-Source: AFSGD/Vg7l38tc0t0C64cHRYrTQWy+G9D8Dk3gCy365XjkVgcSiJwZHfy2CrrsLODEFNzuZqiVRiIg==
X-Received: by 2002:a63:6782:: with SMTP id b124mr25513333pgc.151.1544124175051;
        Thu, 06 Dec 2018 11:22:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l22sm2229135pfj.179.2018.12.06.11.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:54 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/13] hwmon: (tmp401) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:31 -0800
Message-Id: <1544124153-23961-12-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/tmp401.c | 126 ++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 69 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index 1f2d13dc9439..ff66cf1bfb2e 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -288,8 +288,8 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
 	return ret;
 }
 
-static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int index = to_sensor_dev_attr_2(devattr)->index;
@@ -302,8 +302,9 @@ static ssize_t show_temp(struct device *dev,
 		tmp401_register_to_temp(data->temp[nr][index], data->config));
 }
 
-static ssize_t show_temp_crit_hyst(struct device *dev,
-	struct device_attribute *devattr, char *buf)
+static ssize_t temp_crit_hyst_show(struct device *dev,
+				   struct device_attribute *devattr,
+				   char *buf)
 {
 	int temp, index = to_sensor_dev_attr(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
@@ -319,8 +320,8 @@ static ssize_t show_temp_crit_hyst(struct device *dev,
 	return sprintf(buf, "%d\n", temp);
 }
 
-static ssize_t show_status(struct device *dev,
-	struct device_attribute *devattr, char *buf)
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int mask = to_sensor_dev_attr_2(devattr)->index;
@@ -332,8 +333,9 @@ static ssize_t show_status(struct device *dev,
 	return sprintf(buf, "%d\n", !!(data->status[nr] & mask));
 }
 
-static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
-			  const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int index = to_sensor_dev_attr_2(devattr)->index;
@@ -365,8 +367,9 @@ static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
 	return count;
 }
 
-static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+static ssize_t temp_crit_hyst_store(struct device *dev,
+				    struct device_attribute *devattr,
+				    const char *buf, size_t count)
 {
 	int temp, index = to_sensor_dev_attr(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
@@ -404,8 +407,9 @@ static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
  * This is done by writing any value to any of the minimum/maximum registers
  * (0x30-0x37).
  */
-static ssize_t reset_temp_history(struct device *dev,
-	struct device_attribute	*devattr, const char *buf, size_t count)
+static ssize_t reset_temp_history_store(struct device *dev,
+					struct device_attribute *devattr,
+					const char *buf, size_t count)
 {
 	struct tmp401_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -467,38 +471,29 @@ static ssize_t update_interval_store(struct device *dev,
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 1, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 3, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_crit_hyst, store_temp_crit_hyst, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO, show_status, NULL,
-			    1, TMP432_STATUS_LOCAL);
-static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO, show_status, NULL,
-			    2, TMP432_STATUS_LOCAL);
-static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, show_status, NULL,
-			    3, TMP432_STATUS_LOCAL);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 1, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 3, 1);
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst,
-			  NULL, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_fault, S_IRUGO, show_status, NULL,
-			    0, TMP432_STATUS_REMOTE1);
-static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO, show_status, NULL,
-			    1, TMP432_STATUS_REMOTE1);
-static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO, show_status, NULL,
-			    2, TMP432_STATUS_REMOTE1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO, show_status, NULL,
-			    3, TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_min, temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 3, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst, temp_crit_hyst, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_min_alarm, status, 1,
+			       TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_max_alarm, status, 2,
+			       TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_crit_alarm, status, 3,
+			       TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_min, temp, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, 3, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_hyst, temp_crit_hyst, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_fault, status, 0, TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_min_alarm, status, 1,
+			       TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_max_alarm, status, 2,
+			       TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_crit_alarm, status, 3,
+			       TMP432_STATUS_REMOTE1);
 
 static DEVICE_ATTR_RW(update_interval);
 
@@ -538,12 +533,11 @@ static const struct attribute_group tmp401_group = {
  * minimum and maximum register reset for both the local
  * and remote channels.
  */
-static SENSOR_DEVICE_ATTR_2(temp1_lowest, S_IRUGO, show_temp, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_highest, S_IRUGO, show_temp, NULL, 5, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_lowest, S_IRUGO, show_temp, NULL, 4, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_highest, S_IRUGO, show_temp, NULL, 5, 1);
-static SENSOR_DEVICE_ATTR(temp_reset_history, S_IWUSR, NULL, reset_temp_history,
-			  0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_lowest, temp, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_highest, temp, 5, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_lowest, temp, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_highest, temp, 5, 1);
+static SENSOR_DEVICE_ATTR_WO(temp_reset_history, reset_temp_history, 0);
 
 static struct attribute *tmp411_attributes[] = {
 	&sensor_dev_attr_temp1_highest.dev_attr.attr,
@@ -558,23 +552,18 @@ static const struct attribute_group tmp411_group = {
 	.attrs = tmp411_attributes,
 };
 
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 1, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 2, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 3, 2);
-static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst,
-			  NULL, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_status, NULL,
-			    0, TMP432_STATUS_REMOTE2);
-static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO, show_status, NULL,
-			    1, TMP432_STATUS_REMOTE2);
-static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO, show_status, NULL,
-			    2, TMP432_STATUS_REMOTE2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO, show_status, NULL,
-			    3, TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_min, temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, 3, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_hyst, temp_crit_hyst, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_fault, status, 0, TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_min_alarm, status, 1,
+			       TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_max_alarm, status, 2,
+			       TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_crit_alarm, status, 3,
+			       TMP432_STATUS_REMOTE2);
 
 static struct attribute *tmp432_attributes[] = {
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
@@ -598,8 +587,7 @@ static const struct attribute_group tmp432_group = {
  * Additional features of the TMP461 chip.
  * The TMP461 temperature offset for the remote channel.
  */
-static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 6, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_offset, temp, 6, 1);
 
 static struct attribute *tmp461_attributes[] = {
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
-- 
2.7.4

