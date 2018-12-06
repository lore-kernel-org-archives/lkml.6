Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E9C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EE120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrsHXeFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLFTXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44731 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLFTW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so604333pls.11;
        Thu, 06 Dec 2018 11:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dg4drLdWaHWSY4sbNetdW2QJJ3Q4V3io2XclzuLDaec=;
        b=NrsHXeFVrABiztpLecJagUZB99VdM18a18/HE5SPzqCiIKbmh8h3fVQ2dtvg6c++yP
         Xtca3SQCfUDiEOQimFi26lBk0HJCcmR4TeBuwjWpVAgwDFMg5TCc0dRmMVr3lFbDBt8o
         AwLg/xdErXVWqR/9htsHDl78kNFmTUhf6OiO5G+WkJaUWGqumVdQoIMFBBGmgWYJ/1Q7
         mggE3rs+u1B9Yk/QJc9NBY2ZS/ELoM/HrJXqJEMP1YSbgjyl0Tmb0nTOa0i4LNxUhtv4
         qbSOeB8LrTmSpFnS/Vo2MnLTJe54j+3QbEN5m+bfP4S2WAaC3f8EllNNLMIxciGApBPV
         dkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dg4drLdWaHWSY4sbNetdW2QJJ3Q4V3io2XclzuLDaec=;
        b=CYejPplsK+sSL+DS8XsGxWmFW15YpEbIUoDwSmS33BZkpiROtqUB0TFQxB7b87KPOK
         iRwFVD+e2ys2d14mwRoprO1wI3LK4AqTuDBPa/+CCTpDgQMIwAGT59cICnV5Hp7nZgpk
         0Nhe+e0ed86Jg6cQERi2D5wtRJGd8pn2SGKk+kdm77caqnbN/vZegP6LmF5kHllyPeWf
         Bj6Hwt9W1tZFLODW/8WSFtvS/20jSijOM8H4dx5in0ATiS9OObO7f/EGH0SbEp4hs52d
         TQkGobMc4pBORRegEuNrvSip86TYYrlswesuvCsBt83Y8Jr3lq3qL0CECBylkDOlKRJY
         Dzjw==
X-Gm-Message-State: AA+aEWarvA4gGDq/8dZJCRVGWROEF7UH2B6B4n9n7be2cX7oeIPAJG8t
        c3RAhTjleHnyUbIABvJ9TbK8J0VF
X-Google-Smtp-Source: AFSGD/Ua5mJEBDk8H6jPW9NQXBVUxqvGZxWv82NElTy1iut0RCapKT5vXVweVxPy0tb4xLyHf9rxJA==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr29990280plu.127.1544124176671;
        Thu, 06 Dec 2018 11:22:56 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e24sm1399469pfi.153.2018.12.06.11.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:55 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 12/13] hwmon: (ina2xx) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:32 -0800
Message-Id: <1544124153-23961-13-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/ina2xx.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 07ee19573b3f..290379c49be9 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -290,7 +290,7 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
 	return val;
 }
 
-static ssize_t ina2xx_show_value(struct device *dev,
+static ssize_t ina2xx_value_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -329,16 +329,15 @@ static int ina2xx_set_shunt(struct ina2xx_data *data, long val)
 	return 0;
 }
 
-static ssize_t ina2xx_show_shunt(struct device *dev,
-			      struct device_attribute *da,
-			      char *buf)
+static ssize_t ina2xx_shunt_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE, "%li\n", data->rshunt);
 }
 
-static ssize_t ina2xx_store_shunt(struct device *dev,
+static ssize_t ina2xx_shunt_store(struct device *dev,
 				  struct device_attribute *da,
 				  const char *buf, size_t count)
 {
@@ -356,9 +355,9 @@ static ssize_t ina2xx_store_shunt(struct device *dev,
 	return count;
 }
 
-static ssize_t ina226_set_interval(struct device *dev,
-				   struct device_attribute *da,
-				   const char *buf, size_t count)
+static ssize_t ina226_interval_store(struct device *dev,
+				     struct device_attribute *da,
+				     const char *buf, size_t count)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -380,7 +379,7 @@ static ssize_t ina226_set_interval(struct device *dev,
 	return count;
 }
 
-static ssize_t ina226_show_interval(struct device *dev,
+static ssize_t ina226_interval_show(struct device *dev,
 				    struct device_attribute *da, char *buf)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
@@ -395,29 +394,22 @@ static ssize_t ina226_show_interval(struct device *dev,
 }
 
 /* shunt voltage */
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_SHUNT_VOLTAGE);
+static SENSOR_DEVICE_ATTR_RO(in0_input, ina2xx_value, INA2XX_SHUNT_VOLTAGE);
 
 /* bus voltage */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_BUS_VOLTAGE);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ina2xx_value, INA2XX_BUS_VOLTAGE);
 
 /* calculated current */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_CURRENT);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ina2xx_value, INA2XX_CURRENT);
 
 /* calculated power */
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_POWER);
+static SENSOR_DEVICE_ATTR_RO(power1_input, ina2xx_value, INA2XX_POWER);
 
 /* shunt resistance */
-static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_shunt, ina2xx_store_shunt,
-			  INA2XX_CALIBRATION);
+static SENSOR_DEVICE_ATTR_RW(shunt_resistor, ina2xx_shunt, INA2XX_CALIBRATION);
 
 /* update interval (ina226 only) */
-static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
-			  ina226_show_interval, ina226_set_interval, 0);
+static SENSOR_DEVICE_ATTR_RW(update_interval, ina226_interval, 0);
 
 /* pointers to created device attributes */
 static struct attribute *ina2xx_attrs[] = {
-- 
2.7.4

