Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6657AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2069D20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym3EseBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2069D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLFTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLFTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so576273pgm.3;
        Thu, 06 Dec 2018 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZOqczAKBBnFxC04H7GYZ0UbWasi4OSn8T6AcRscW/14=;
        b=Ym3EseBJBhlZqbTRtpTtrGihgjr2/7bR2H6KkXi2GRA4wWWQwj76AnzoL37u1DhSaX
         fBtG/jYDGueeWhtJV73NjlsVdbiyadz6zAfhc2+Ws5VPTiXPkALaSCvXl6wdjxrDaA+P
         vDSOmAtwglnEwdsT0WepvvrY0xI3rWbXpnYmdSf4OEdAV4v4MJOoc65mXKcfZ0I6W9T7
         cZo82EhB+UDCd7rddQVKqWrzH15M9fnwJeolYG12MtEiNvWEm+I+KPAFZ28SxlXdvMEk
         y1oG5rZ7oitQklrcJNpw4DAc0WFl1Ky1u2E91rG138GJoFyHTT64r2vcxLhYQnw2QH3F
         mHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZOqczAKBBnFxC04H7GYZ0UbWasi4OSn8T6AcRscW/14=;
        b=iD6aDWLvxVubdQNPPTKumkfYiz8gKSUE3MKMMSTfB8r3ll+l1QIhxmtl5XyMJ9SNn2
         5P8nXOl5B8mZ0BglonpbRkG+czN5K2GxqqVDLynJlpzwFMzTakQUjLMxdOoZ3mGoS989
         YEHZBX+UNpGK8xngv7OwynzHskzhzjzkUGFlgNV0yi3lM36SVwxtu18WqX40vcivc7dQ
         EX5BXlK6G6UPV/wq+QL+Ohotpus7cH+Mf0TmNcLk11daVXFTELeGQVmHzPzMq2ZDV4VP
         BEuzOSTrD8/eMaA7oa9guS4VV4SLFf6H8HmgYVvqeHIZChq3Sq7LULgqeFghFYWePBSy
         Qg/Q==
X-Gm-Message-State: AA+aEWbie+VC8d82W+0KuKnKCiHdt0iIvTfWrySpPcGQd3zG2OP2VDnl
        3WseXzKRDoeh/jBf7X8OgorLJLf0
X-Google-Smtp-Source: AFSGD/VSl3XIg7F2LNDyoUke7FheeVfKFUOolEBulrRDbIU36Rt+f913qjEd0LEA1wGj5eD0iHw9wA==
X-Received: by 2002:a62:4641:: with SMTP id t62mr29428059pfa.141.1544124178129;
        Thu, 06 Dec 2018 11:22:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 89sm1903650pfl.120.2018.12.06.11.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:57 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 13/13] hwmon: (ltc4215) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:33 -0800
Message-Id: <1544124153-23961-14-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/ltc4215.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index c8a9bd9b050f..d4a1d033d3e8 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -136,9 +136,8 @@ static unsigned int ltc4215_get_current(struct device *dev)
 	return curr;
 }
 
-static ssize_t ltc4215_show_voltage(struct device *dev,
-				    struct device_attribute *da,
-				    char *buf)
+static ssize_t ltc4215_voltage_show(struct device *dev,
+				    struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	const int voltage = ltc4215_get_voltage(dev, attr->index);
@@ -146,18 +145,16 @@ static ssize_t ltc4215_show_voltage(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", voltage);
 }
 
-static ssize_t ltc4215_show_current(struct device *dev,
-				    struct device_attribute *da,
-				    char *buf)
+static ssize_t ltc4215_current_show(struct device *dev,
+				    struct device_attribute *da, char *buf)
 {
 	const unsigned int curr = ltc4215_get_current(dev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", curr);
 }
 
-static ssize_t ltc4215_show_power(struct device *dev,
-				  struct device_attribute *da,
-				  char *buf)
+static ssize_t ltc4215_power_show(struct device *dev,
+				  struct device_attribute *da, char *buf)
 {
 	const unsigned int curr = ltc4215_get_current(dev);
 	const int output_voltage = ltc4215_get_voltage(dev, LTC4215_ADIN);
@@ -168,9 +165,8 @@ static ssize_t ltc4215_show_power(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", power);
 }
 
-static ssize_t ltc4215_show_alarm(struct device *dev,
-					  struct device_attribute *da,
-					  char *buf)
+static ssize_t ltc4215_alarm_show(struct device *dev,
+				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ltc4215_data *data = ltc4215_update_device(dev);
@@ -189,26 +185,20 @@ static ssize_t ltc4215_show_alarm(struct device *dev,
 /* Construct a sensor_device_attribute structure for each register */
 
 /* Current */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4215_show_current, NULL, 0);
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 2);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc4215_current, 0);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ltc4215_alarm, 1 << 2);
 
 /* Power (virtual) */
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ltc4215_show_power, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(power1_input, ltc4215_power, 0);
 
 /* Input Voltage */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4215_show_voltage, NULL,
-			  LTC4215_ADIN);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 0);
-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 1);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc4215_voltage, LTC4215_ADIN);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ltc4215_alarm, 1 << 0);
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ltc4215_alarm, 1 << 1);
 
 /* Output Voltage */
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4215_show_voltage, NULL,
-			  LTC4215_SOURCE);
-static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 3);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc4215_voltage, LTC4215_SOURCE);
+static SENSOR_DEVICE_ATTR_RO(in2_min_alarm, ltc4215_alarm, 1 << 3);
 
 /*
  * Finally, construct an array of pointers to members of the above objects,
-- 
2.7.4

