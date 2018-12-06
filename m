Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABD7214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHxxOu26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABD7214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLFTWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45409 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLFTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so637811pfd.12;
        Thu, 06 Dec 2018 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4bkOSPSF6PSoXLKku8OGGYXzhbJaUrdkU5xWeSTPy0Q=;
        b=qHxxOu26AwldsCnDY8t7CkVCxN8cU7Dt7uSQH83M3ET42IkhN4k9NPoZPOKba2JXdd
         zWxBVHzIUHqv9TfMyMhNx/brPZc9Dvt+6MkpivZgx8vNEabfh0re2YR9AbWW9JIVwIwW
         KvA+rmgQcPp+TzksfH0ahO2xKXNAPkFUaEOyGAgdi361QCmzXvBaYlQR+vpUDatVg4H1
         e2IsqkhxUHIQ+vMqBfaUPhvjHF+cuK9TEqcIHCa8PrqEjtPUHym74pfp22KgPOruG8d8
         pYFalQ2P06V/zIDn5/X9NvLj1b74F1lILLkwTC+LbGWZvFNxko5tczapiadF3BsSN0Q/
         Jl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4bkOSPSF6PSoXLKku8OGGYXzhbJaUrdkU5xWeSTPy0Q=;
        b=pGVvarukcceL81o8Lkk+uk9nIAFyguCawdtDOLg7xO5kOaHNBk53RjIwpTkURCWaSt
         Fn8jJ+tGwzPf8wfkTM5lX1mHBuQQD4nHOlv7EzC36reLjLalcyqtth0X4qN0yo8z8bOc
         MrVjfAUkWsNtSM4jSgO6zqpzIeGpXsHfGMoU0rppvy6DComS+k6gky0XeEI+dNDGdjxo
         UKfYwErPfPEaEVBSSOvuvmOT/WlaPkOTHaZ6x5XJPkUe6WTtT4euLb061s0DplRzXtDI
         Zu/V9h7qCpkfj5kgGeSnWEWxD5TlBrqXIqT5zcn3mNQsPWACMGnt7cu0FSZry84xwUFg
         qjwQ==
X-Gm-Message-State: AA+aEWbo7aMtYhCOkL+UubDG2jNvasOaRxQ4TfV3alRhK0Z+KXbSVLZT
        Wtf+zruVUybAWq4PDCfk23f1Gnjt
X-Google-Smtp-Source: AFSGD/UjRpJRVF+IS7yWo7VA/FoC+TVJ8r7G2KFA4mwd7eSKn5S7KGDM6nCNeexOpvW/El7iC2xA8A==
X-Received: by 2002:a63:e516:: with SMTP id r22mr25713681pgh.256.1544124162939;
        Thu, 06 Dec 2018 11:22:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n21sm1507526pfg.84.2018.12.06.11.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:42 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/13] hwmon: (k10temp) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:23 -0800
Message-Id: <1544124153-23961-4-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/k10temp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 2cef0c37ff6f..cd601cd6f88a 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -191,7 +191,7 @@ static ssize_t temp1_max_show(struct device *dev,
 	return sprintf(buf, "%d\n", 70 * 1000);
 }
 
-static ssize_t show_temp_crit(struct device *dev,
+static ssize_t temp_crit_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -209,12 +209,12 @@ static ssize_t show_temp_crit(struct device *dev,
 
 static DEVICE_ATTR_RO(temp1_input);
 static DEVICE_ATTR_RO(temp1_max);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, temp_crit, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, temp_crit, 1);
 
-static SENSOR_DEVICE_ATTR(temp1_label, 0444, temp_label_show, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, temp_label, 0);
 static DEVICE_ATTR_RO(temp2_input);
-static SENSOR_DEVICE_ATTR(temp2_label, 0444, temp_label_show, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, temp_label, 1);
 
 static umode_t k10temp_is_visible(struct kobject *kobj,
 				  struct attribute *attr, int index)
-- 
2.7.4

