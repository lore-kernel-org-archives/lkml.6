Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13535C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48DB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my78gjtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48DB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLFTXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32937 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLFTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so662758pfb.0;
        Thu, 06 Dec 2018 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WvpEzzmxSiIi5TjN+3iU3cCsLOz6nCv8zhUHDCCajyk=;
        b=my78gjtVPmY50LoAl5PogV3Mqx65hFu0/pyk5s2l2h+Pg9A8gi+zzAVLuwRu0tzvpW
         KRoECbvyerPRqVsiwVw4siz0X4wlSkXmBOoi4nVkPMsQfkGOrqmnCBnAB71zSwKNXcpy
         3YsCxSqzYd2Wdz9FUC2cCQV2JIsKszkcuXOee84Vv2kZBmmOQin143zxHrEWp/JY8hFp
         wxG39usauvtosiU9f8oz2z8W8j/5VovopjQKfCFJtzTB56c9ib7JQERi0nSk2J/Uiw3R
         a8HwiVCkQFeOXcnSqdXOvmSIUqYtxxfw9XQUQmmTUzgN2HcIcV4cagKWH5uILGl3CgUC
         XazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=WvpEzzmxSiIi5TjN+3iU3cCsLOz6nCv8zhUHDCCajyk=;
        b=Vcqz3YLjP9Ow8vEhqciG4nKl+aLKgGjUaLHwXWeXbsFNL7BmddvcX6P9mWJiV3SZNT
         puToQPTqZfGFmY9ejo49o53+5/KdAmBzuxkX8G7Ym3pAs0mbrkNt3WZM+YOY1t+4OsMB
         i+WvHIzTkLK/LdS7USI01V74WnbO+mBi5wQ+lEDRTUFDrb+o3M0wN9Tvp118+Hz4PcsN
         oL4D0nFNsCfa/rX5i9oFiGMdmfGhpWFtMgpae40ew9dJ7wVayhofMCvP2HvIMhxW2P6W
         TI+JGRcua/xO5k+VP9xXX1TBJT4gwFPj6JkGkSoxIJ2Bdxk6sCPEuTb10kG1BaRhD45z
         wuew==
X-Gm-Message-State: AA+aEWaFmlnspQ7swgub6YHCIw2a7KF7BefuYA1joZlnHvPgjBdnWt7d
        oZnYuE6AsvgtFlrg1Gxkm5Zp0l5B
X-Google-Smtp-Source: AFSGD/WY76TIKbemJLg+eLCwQBTTShSY7S6jAvj62HdG7VnsljH2hTAz9dp4qoZTD334+65BczAPzg==
X-Received: by 2002:a65:6491:: with SMTP id e17mr24919616pgv.418.1544124167809;
        Thu, 06 Dec 2018 11:22:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m85sm1458259pfj.171.2018.12.06.11.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:47 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/13] hwmon: (ltc4260) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:26 -0800
Message-Id: <1544124153-23961-7-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/ltc4260.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/ltc4260.c b/drivers/hwmon/ltc4260.c
index afb09574b12c..011b1ae98ff1 100644
--- a/drivers/hwmon/ltc4260.c
+++ b/drivers/hwmon/ltc4260.c
@@ -79,7 +79,7 @@ static int ltc4260_get_value(struct device *dev, u8 reg)
 	return val;
 }
 
-static ssize_t ltc4260_show_value(struct device *dev,
+static ssize_t ltc4260_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -91,7 +91,7 @@ static ssize_t ltc4260_show_value(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", value);
 }
 
-static ssize_t ltc4260_show_bool(struct device *dev,
+static ssize_t ltc4260_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -111,30 +111,24 @@ static ssize_t ltc4260_show_bool(struct device *dev,
 }
 
 /* Voltages */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4260_show_value, NULL,
-			  LTC4260_SOURCE);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4260_show_value, NULL,
-			  LTC4260_ADIN);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc4260_value, LTC4260_SOURCE);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc4260_value, LTC4260_ADIN);
 
 /*
  * Voltage alarms
  * UV/OV faults are associated with the input voltage, and the POWER BAD and
  * FET SHORT faults are associated with the output voltage.
  */
-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_UV);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_OV);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_POWER_BAD | FAULT_FET_SHORT);
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ltc4260_bool, FAULT_UV);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ltc4260_bool, FAULT_OV);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, ltc4260_bool,
+			     FAULT_POWER_BAD | FAULT_FET_SHORT);
 
 /* Current (via sense resistor) */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4260_show_value, NULL,
-			  LTC4260_SENSE);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc4260_value, LTC4260_SENSE);
 
 /* Overcurrent alarm */
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_OC);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ltc4260_bool, FAULT_OC);
 
 static struct attribute *ltc4260_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
-- 
2.7.4

