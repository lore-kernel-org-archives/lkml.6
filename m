Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A71C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99314208DA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99314208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeH1Fm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35496 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeH1Fm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so34302oic.2;
        Mon, 27 Aug 2018 18:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wuRpGge/NMC2oy1JXZyquK/m5VcBihkhIPmX9fI4eX8=;
        b=KXALkJtZBOXDLWYwW0taqsXwbZRlnNpU1+1atGIdCxZjBAPzY8cwQ4uKzG3p9jzSRJ
         UStHvL76pOG8ZxA+SG/L7Mx76tQHSQG38A5QI1T+LtI0k2/f7GkIc6hmNWMCPZMmJRE+
         MHMjwokhtp0eUNJE8/miuNKm2jdfO52EhM7PgaA1+9S3j1wP6DlbUerbVzZxqaYkwFYl
         srhegM3F1pjwm2U7ODhHj/2QxSOOQ2Ru7bfyy52elUZ5R6mkTGZHUiL4sf2EkG9xR8Qs
         ANBf01CqwyKWleO0Nnclp8sKrTP/fR+WbO5T6ezEwa3I6oEFBciKxoFUrCGfwJbFbxhB
         o9Sw==
X-Gm-Message-State: APzg51D1EoQVlQ7RheNAXtRV/A7+Sbzlj+zdvX7hwb34R98D0M/9B/5n
        QqCBbnmAUHlyeCcN/3Qfilymvpw=
X-Google-Smtp-Source: ANB0VdaXqqKDEVS913gFOd2QbBXCOlI7h5lGDzR//GcDWBciOVKzvS2MzslgM2bYwNugrntoCeK6tQ==
X-Received: by 2002:aca:6ac8:: with SMTP id f191-v6mr1128477oic.223.1535421193632;
        Mon, 27 Aug 2018 18:53:13 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:21 -0500
Message-Id: <20180828015252.28511-20-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
 drivers/hwmon/ibmpowernv.c       | 4 ++--
 drivers/hwmon/iio_hwmon.c        | 9 ++++-----
 drivers/hwmon/npcm750-pwm-fan.c  | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 5e449eac788a..92de8139d398 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -852,7 +852,7 @@ static int aspeed_create_pwm_cooling(struct device *dev,
 		dev_err(dev, "Property 'cooling-levels' cannot be read.\n");
 		return ret;
 	}
-	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%s%d", child->name, pwm_port);
+	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
 
 	cdev->tcdev = thermal_of_cooling_device_register(child,
 							 cdev->name,
diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 83472808c816..4935897f1527 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -603,8 +603,8 @@ static int create_device_attrs(struct platform_device *pdev)
 		if (of_property_read_u32(np, "sensor-id", &sensor_id) &&
 		    of_property_read_u32(np, "sensor-data", &sensor_id)) {
 			dev_info(&pdev->dev,
-				 "'sensor-id' missing in the node '%s'\n",
-				 np->name);
+				 "'sensor-id' missing in the node '%pOFn'\n",
+				 np);
 			continue;
 		}
 
diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 2f3f875c06ac..7566991f1c04 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -65,13 +65,9 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
 	enum iio_chan_type type;
 	struct iio_channel *channels;
-	const char *name = "iio_hwmon";
 	struct device *hwmon_dev;
 	char *sname;
 
-	if (dev->of_node && dev->of_node->name)
-		name = dev->of_node->name;
-
 	channels = devm_iio_channel_get_all(dev);
 	if (IS_ERR(channels)) {
 		if (PTR_ERR(channels) == -ENODEV)
@@ -141,7 +137,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	st->attr_group.attrs = st->attrs;
 	st->groups[0] = &st->attr_group;
 
-	sname = devm_kstrdup(dev, name, GFP_KERNEL);
+	if (dev->of_node)
+		sname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
+	else
+		sname = devm_kstrdup(dev, "iio_hwmon", GFP_KERNEL);
 	if (!sname)
 		return -ENOMEM;
 
diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 8474d601aa63..96634fd54e0b 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -861,7 +861,7 @@ static int npcm7xx_create_pwm_cooling(struct device *dev,
 		dev_err(dev, "Property 'cooling-levels' cannot be read.\n");
 		return ret;
 	}
-	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%s%d", child->name,
+	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%pOFn%d", child,
 		 pwm_port);
 
 	cdev->tcdev = thermal_of_cooling_device_register(child,
-- 
2.17.1

