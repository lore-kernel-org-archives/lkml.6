Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0130620892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTsXeFq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0130620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLFTWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41723 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeLFTWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so646744pfi.8;
        Thu, 06 Dec 2018 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CKNdYSnyIjWeOwcl4rxYGIZJ6JJiR3DKSNfyvqroON0=;
        b=ZTsXeFq5uqjxrG0Em2HGL1e4fjEI/r42b5CJznXZoTIpna33qSuVtljsMDcmBqYcCS
         cURBWSItbsun70oSRvrhOwKT6j0WmgTlivO0BrIJJxwcvBBToNXrbFiJUcme36mNuBUw
         mrMXmpUpQb8nhWOyTwZDAhFJevXRpaS9dN21M1iD14L8NiIa+TXU3FAipfhKzuUM7YtU
         Bt5kEbvGMI2q3c/Jx5/LhKvwxcoEh/lCzkjGcK/s3In5jRWOWeYgWkVRolLZQs4P8MiT
         L5NUZigGf2EnryOg5mVMdlSC1kZoJnGaTQ2P4V6fc1Tt6W0rLNb6TB+miqDkLmckPfV4
         NBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CKNdYSnyIjWeOwcl4rxYGIZJ6JJiR3DKSNfyvqroON0=;
        b=ueAyz9UfHqi/VN0r2JbSvXy5gGeWOpuhMhfCW7E1+VBzKXjuGiqs0Le9/mrjtaKAeE
         Gmn1sndPRIyMW0XRzdOFN0c2Rt0+w5Bzqn9xgKbD7gDgXxZ1epPo08pvee6qyezRcI7U
         22eCBs57dmmxtzPKtuj7fgN9swbY/oi7HA3GCsP4Bv4bv/88i2kbHVeXFecHMyreMOLb
         76HLrf7dujUvT6Qzy4WIes4pAoI8yi+l5O4cOVhZXpbvkqcSsfAJ8iSe85OVSgoH4ZKF
         celyQC+ebgyWNLgQ3D+D9rQg4v40EGKOCTil6wPfuvXB04+d2YP+bzd0+0A4jkvS5KoQ
         7IUw==
X-Gm-Message-State: AA+aEWapRk0bq2w8RIAAtWwEujKDhtoH0JXNXWF8aWYakI6Inx48AQDd
        SvL2zFzyHcvZU/9AMoIgbzOedLy+
X-Google-Smtp-Source: AFSGD/VVcNaWT8OgWa8FJh8Fk95nj84e2XT+OhIwz13VrVw9b3snntWxbZLZwDWAnmzaMygS2g7DpQ==
X-Received: by 2002:a62:44d8:: with SMTP id m85mr30166487pfi.164.1544124169217;
        Thu, 06 Dec 2018 11:22:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o1sm1688329pgn.63.2018.12.06.11.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:48 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/13] hwmon: (max6650) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:27 -0800
Message-Id: <1544124153-23961-8-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/max6650.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 65be4b19fe47..4752a9ee9645 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -209,8 +209,8 @@ static int max6650_set_operating_mode(struct max6650_data *data, u8 mode)
 	return 0;
 }
 
-static ssize_t get_fan(struct device *dev, struct device_attribute *devattr,
-		       char *buf)
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct max6650_data *data = max6650_update_device(dev);
@@ -514,8 +514,8 @@ static ssize_t fan1_div_store(struct device *dev,
  * 1 = alarm
  */
 
-static ssize_t get_alarm(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
+static ssize_t alarm_show(struct device *dev,
+			  struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct max6650_data *data = max6650_update_device(dev);
@@ -534,24 +534,19 @@ static ssize_t get_alarm(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%d\n", alarm);
 }
 
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, get_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, get_fan, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan, 3);
 static DEVICE_ATTR_RW(fan1_target);
 static DEVICE_ATTR_RW(fan1_div);
 static DEVICE_ATTR_RW(pwm1_enable);
 static DEVICE_ATTR_RW(pwm1);
-static SENSOR_DEVICE_ATTR(fan1_max_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_MAX);
-static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_MIN);
-static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_TACH);
-static SENSOR_DEVICE_ATTR(gpio1_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_GPIO1);
-static SENSOR_DEVICE_ATTR(gpio2_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_GPIO2);
+static SENSOR_DEVICE_ATTR_RO(fan1_max_alarm, alarm, MAX6650_ALRM_MAX);
+static SENSOR_DEVICE_ATTR_RO(fan1_min_alarm, alarm, MAX6650_ALRM_MIN);
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, alarm, MAX6650_ALRM_TACH);
+static SENSOR_DEVICE_ATTR_RO(gpio1_alarm, alarm, MAX6650_ALRM_GPIO1);
+static SENSOR_DEVICE_ATTR_RO(gpio2_alarm, alarm, MAX6650_ALRM_GPIO2);
 
 static umode_t max6650_attrs_visible(struct kobject *kobj, struct attribute *a,
 				    int n)
-- 
2.7.4

