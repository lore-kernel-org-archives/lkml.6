Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1541820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg8gres6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1541820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeLFTW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32943 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeLFTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so662835pfb.0;
        Thu, 06 Dec 2018 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JEK4IxR6IeeR751caGxD39qkCDXrDdEdjmknhj9qAUA=;
        b=Zg8gres6fTXp5byldF3tABm1cYFd8HQ+CkAq6NhlIR81oS3h5MOtaQu0AhLhqperi/
         F1oMMdE2ypLEzumKK5nLihWXE9rkI02niIXH59kXYORG7+g+PF9inDrKmHVccn2kDXqa
         vO3C2uyueiajrGfw/okm1vwWqup5wYeDkQNjrDrR5j+sBCCr6QWypevd2X+ZSa4jMfLr
         yvNSXUL6zzlCuVk3NVmP76tlkKPs+0VB404x8AYppIBZO0zCnbL18GAJe1uolR7+JVR3
         FF8WE6UFqGK7Wt/PwmMP0J5/2pWyc5dSYsMmFbsFlQQr1YTtwrOVthtfP4lYftEdYDIw
         Y1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JEK4IxR6IeeR751caGxD39qkCDXrDdEdjmknhj9qAUA=;
        b=q++ED80XM5BPTJMQ5Veh5yBCXdnBLPR5FFVlQt225cpxYGzIu4Mcoq1OMv3TN6E5rI
         uo1msWGTddH0qTNXj86jwFen3QmrN2ykWrp8CCjy1drytgliszEeV5Am/sE/slqLFXmD
         tNQU9WcaWHtTyjgQuaQkDJwXn+I58UZ/0MMlspHi4JpXtIzP0gPj9hzvnFX9JmbTW8CP
         OTWTMIrqgfiMQfuhLUEA3FC9qdRqd8jj17S8xfmV/KqAJKBkay4lhpuJuS4VAyhCDlwD
         mkBCgbCglRAe5crIrk8YV6QVsEpJRAZhQsTECTUGRQCKrfPDgBYNd60DqGZbYDHhdXIC
         jb8A==
X-Gm-Message-State: AA+aEWZfl8dcD7Q+vv3pJxwYMzvnp4he6Rwf/gbP/vgURJsRMz2K8tgY
        2Pj1Mp3DzXABGNxgm+sAFCfrFyVx
X-Google-Smtp-Source: AFSGD/UQDngo/d/FR/XpnFOyhAVoN6OefPV4tRncYO4NGN7PXERrCf5O3GFHvL8vZJT8WgTx9s2KmA==
X-Received: by 2002:a63:4611:: with SMTP id t17mr24895032pga.119.1544124170634;
        Thu, 06 Dec 2018 11:22:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a90sm2572259pfj.109.2018.12.06.11.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:50 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/13] hwmon: (ntc_thermistor) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
Date:   Thu,  6 Dec 2018 11:22:28 -0800
Message-Id: <1544124153-23961-9-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/ntc_thermistor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 56d83b2472c8..2823aff82c82 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -601,14 +601,14 @@ static int ntc_read_temp(void *data, int *temp)
 	return 0;
 }
 
-static ssize_t ntc_show_type(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t ntc_type_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "4\n");
 }
 
-static ssize_t ntc_show_temp(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t ntc_temp_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct ntc_data *data = dev_get_drvdata(dev);
 	int ohm;
@@ -620,8 +620,8 @@ static ssize_t ntc_show_temp(struct device *dev,
 	return sprintf(buf, "%d\n", get_temp_mc(data, ohm));
 }
 
-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ntc_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_type, ntc_type, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ntc_temp, 0);
 
 static struct attribute *ntc_attrs[] = {
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
-- 
2.7.4

