Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F4CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA612081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcjRnrXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA612081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbeKFGKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:10:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34303 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbeKFGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:10:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1-v6so4769292pgq.1;
        Mon, 05 Nov 2018 12:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ag7ymbQUhUKOFa848vV76yrTHubxL26VbSmRYSD6E5o=;
        b=XcjRnrXPpxcsMqUdCr8f7cAF7y33Zkp8CB+dmEIIhPBZbYjX6c9PZKqisMDsYG0zM6
         lMBQsGtsMKeHSL8MVuH9yFF0rjpUAN5NzAQESuCgkovdOurvMR33qUXukeygTkmPM0nK
         d6JbMwf6+1u4G7V3xGDrJmuTNAxsySxCIUIlcgQU+V1zaI8fUAo7u1CISFmMtOMr3YfC
         cXruxWnBbxBKpFbzNsH70+aAPZJxB9Hgs7fO3iCsginVDObNiNCQuRQpWPunlM5JTN7A
         VkaQmhLYjOuptjfsqBwpOEWIsn4/1GDMKEfam6DjXZE0obyxGH1sUgolhge/ATs/KRpO
         wwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ag7ymbQUhUKOFa848vV76yrTHubxL26VbSmRYSD6E5o=;
        b=PbYxfe8cm53tjAkS3+B6dXpX0B6B5/+FNq1BHCzOZIQr28FOLTmRwwPncxLxxnR252
         drWMbAdgoR0qf/zo7P/zq+qJS8E25xVH0QQPGyy2SwciOg+tVAtXbG3zbdcCgBNQ9Qyz
         GuXWordDIl+wrulTC/82eIgq0hjid4B0OvkxQNsUQcLZA7sxKHEHmBFaSF2qNCTGNJMs
         FjnZR0N5G3EbE/T8HXqBNoSVCZ7tWA6eSay+lNCa7BVx84OeaHAecoXSRR3mFGS+X6z9
         F6Lm0HtTnPFXe+VTAjCHYD8DfxwxXbUZEv3lGXLSFFNy6zu8t49yOk9dq4JvUqEtSR5J
         iOYQ==
X-Gm-Message-State: AGRZ1gIQHVvY7VOW375n/CE1DYpDKA1b4L/ZNWoK9R8WLCjfWfFpS7fg
        dqUNjIO+ea7VldPnBRIyjCk=
X-Google-Smtp-Source: AJdET5cb3DdawMH/ihPKA9eB08+bmb+cPs5VyC0th4co4WXNIcu+DWnc1wqvwaFWZgtUTVMtbpMGsw==
X-Received: by 2002:a62:1cc6:: with SMTP id c189-v6mr8294804pfc.49.1541450931753;
        Mon, 05 Nov 2018 12:48:51 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q1sm25569257pgs.14.2018.11.05.12.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:48:51 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] hwmon: (ina3221) Serialize sysfs ABI accesses
Date:   Mon,  5 Nov 2018 12:48:41 -0800
Message-Id: <20181105204843.4081-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105204843.4081-1-nicoleotsuka@gmail.com>
References: <20181105204843.4081-1-nicoleotsuka@gmail.com>
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
v1->v5:
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

