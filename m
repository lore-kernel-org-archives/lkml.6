Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3175CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AD72084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/pYhpkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AD72084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJZI0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:26:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45785 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJZI0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:26:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so4749661pga.12;
        Thu, 25 Oct 2018 16:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WhIVuvKjVd2x3Svm7Qnl0DY6kw49Vyz/j7HQ4NEdOMI=;
        b=H/pYhpkXfPKX5PM68KnHszps0OkiRmEqrKDvPeAOPjWOm2TZc0BGB3fma9GkJFGKo4
         FOHO/o0FIanSZZs8g2oYojQICfbSvH43GSIj1GeyvuEhT6lVxYz2qigDE+CrKYhHy15z
         EuN3FPESM39GLp08qB/2soJNznz4k/IldbeBf89NSXaEnCH9VbeQQmD4x9XHy/xiZPsh
         tRI1ACRA2WQBi0j2wxQ2pmOHQUAD481LOPasuJooyagZx1g3FNUZGhNubuPDQlilYg8A
         5K82K8L4e5+BY7jGS5en4uov2hNssoLOQTsCwTVCRR21jOdiAEzBBRAlPt1hTWW0rfsa
         shsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WhIVuvKjVd2x3Svm7Qnl0DY6kw49Vyz/j7HQ4NEdOMI=;
        b=AuxNDijgRTswWLciP0svgz7dW0E8aRl3ms+GnPJCAE1/NnT5N6ROsIYtRpcPtjg3wN
         aaWYMCYEsGzwdtuHQyyrhhKChPwQ/j5aVZ7Go1UD62y9aWhB+L6RTrzVmj7cirLZPjLl
         g3XG57D2UEblOoKM9ihwPai6OPkqrs3vikXRIl0/eaAg6gp345ltS29Gsopym5i+F79Y
         hHdK19wko4EdQh3X3S8L5msfJcyoPnYYGkmT6wnW/I9z6+5UTrH2PFLjH2gSyHGxMfxG
         +tkqawMvjCLbqFGGiOwBIetaP0BzuzCVhgb7EI3mihfqD0x3GnEeoXl7v5+9ckrtW/ZF
         lzXw==
X-Gm-Message-State: AGRZ1gKeHhJ34zmKB/s8mqZ9thCuU0yOfn9ZKeS0KjlYdcvxgyh8t5k9
        dN6zBpwUEYsv/j5OAGc7EVL4vfhc
X-Google-Smtp-Source: AJdET5fneIBKaQ+ZPci9npuxx5t+ki0xWyFaG6PBKg0x3iZFsvXs3SkZuO1L1B5lkuRR9ZPgSxcOOw==
X-Received: by 2002:a63:2903:: with SMTP id p3-v6mr1187078pgp.188.1540511491263;
        Thu, 25 Oct 2018 16:51:31 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e189-v6sm10453806pfa.91.2018.10.25.16.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 16:51:30 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] hwmon: (ina3221) Serialize sysfs ABI accesses
Date:   Thu, 25 Oct 2018 16:51:20 -0700
Message-Id: <20181025235122.3240-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025235122.3240-1-nicoleotsuka@gmail.com>
References: <20181025235122.3240-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a mutex to serialize accesses of sysfs attributes.

This is required when polling CVRF bit of the MASK/ENABLE register
because this bit is cleared on a read of this MASK/ENABLE register
or a write to CONFIG register, which means that this bit might be
accidentally cleared by reading other fields like alert flags.

So this patch adds a mutex lock to protect the write() and read()
callbacks. The read_string() callback won't need the lock since it
just returns the label without touching any hardware register.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changlog
v1->v4:
 * N/A

 drivers/hwmon/ina3221.c | 51 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 26cdf3342d80..10e8347a3c80 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -18,6 +18,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 
@@ -94,12 +95,14 @@ struct ina3221_input {
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @inputs: Array of channel input source specific structures
+ * @lock: mutex lock to serialize sysfs attribute accesses
  * @reg_config: Register value of INA3221_CONFIG
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
+	struct mutex lock;
 	u32 reg_config;
 };
 
@@ -265,29 +268,53 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&ina->lock);
+
 	switch (type) {
 	case hwmon_in:
 		/* 0-align channel ID */
-		return ina3221_read_in(dev, attr, channel - 1, val);
+		ret = ina3221_read_in(dev, attr, channel - 1, val);
+		break;
 	case hwmon_curr:
-		return ina3221_read_curr(dev, attr, channel, val);
+		ret = ina3221_read_curr(dev, attr, channel, val);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+
+	mutex_unlock(&ina->lock);
+
+	return ret;
 }
 
 static int ina3221_write(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long val)
 {
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&ina->lock);
+
 	switch (type) {
 	case hwmon_in:
 		/* 0-align channel ID */
-		return ina3221_write_enable(dev, channel - 1, val);
+		ret = ina3221_write_enable(dev, channel - 1, val);
+		break;
 	case hwmon_curr:
-		return ina3221_write_curr(dev, attr, channel, val);
+		ret = ina3221_write_curr(dev, attr, channel, val);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+
+	mutex_unlock(&ina->lock);
+
+	return ret;
 }
 
 static int ina3221_read_string(struct device *dev, enum hwmon_sensor_types type,
@@ -582,6 +609,7 @@ static int ina3221_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	mutex_init(&ina->lock);
 	dev_set_drvdata(dev, ina);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
@@ -589,12 +617,22 @@ static int ina3221_probe(struct i2c_client *client,
 							 ina3221_groups);
 	if (IS_ERR(hwmon_dev)) {
 		dev_err(dev, "Unable to register hwmon device\n");
+		mutex_destroy(&ina->lock);
 		return PTR_ERR(hwmon_dev);
 	}
 
 	return 0;
 }
 
+static int ina3221_remove(struct i2c_client *client)
+{
+	struct ina3221_data *ina = dev_get_drvdata(&client->dev);
+
+	mutex_destroy(&ina->lock);
+
+	return 0;
+}
+
 static int __maybe_unused ina3221_suspend(struct device *dev)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
@@ -663,6 +701,7 @@ MODULE_DEVICE_TABLE(i2c, ina3221_ids);
 
 static struct i2c_driver ina3221_i2c_driver = {
 	.probe = ina3221_probe,
+	.remove = ina3221_remove,
 	.driver = {
 		.name = INA3221_DRIVER_NAME,
 		.of_match_table = ina3221_of_match_table,
-- 
2.17.1

