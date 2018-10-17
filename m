Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA30C5ACCD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03277214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQujuozW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03277214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJQJRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:17:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40821 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeJQJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:17:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so5328273pfi.7;
        Tue, 16 Oct 2018 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gWfmCcpf7HgzojI1AcY47Q6G9hhldA69dpOLXL491Lo=;
        b=HQujuozW3vDZEBbemfDyuNW+ctdf9/tGDmrVWoSYVLHeb/7nHKRQccU11BF/MGMDvx
         y9VYY0nZlqJNPQJjrhjui3iIUkU3c7davttLHIhq4f68UgY/F3d8b8NZlqfM+WO+48PG
         vSTEDtwESiBpDJLEzLogsxh6dA6Lxhu6xi1qwwPaIY1kFvI/133Hdt8msyvIeGGiIRNW
         WkvEFjnAcuOLVUlFwcRVrqD3NPHRe/tAivusRl3y9TmusvCNqW+PRcLWraPUtgf7rTaT
         sAImsmANZZa8+y+JCo1NjYDoFX0ay7vZOgqohYq9l+WvckO1VWeWsK769VmKYuGWfhmj
         5xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gWfmCcpf7HgzojI1AcY47Q6G9hhldA69dpOLXL491Lo=;
        b=p5+Rs6K47QoD3FEFC9rjW2kWY9ZRTjuzcwQz4XQf3pl5OYXpyBk6heJ1Crm2biZIXG
         cyU2wc/NWMNwKw+4vj8o3O44n/hMhg6A30L+jww6hcsYPw2A0GkI4SNkWcSWoxHQ4B71
         atisqPhlhulPP8+2zUP8oIlrJm/M6/X74Sh5eVuxqtdjMoqzb68vQOTAXHvwXPWdgPJ4
         kemuIcOlfDeL/O9MBxfd2+l0/2Elhd67AXLhxDoWEHnR+TU/w3s9XyofSivFXihCtjY/
         oY+vRviXXWS0J0+l2iN2hq856CcrWZtHNRWQFji7p8LNKak5O6vzvbJ0R5qIRoZn5FD+
         qq3g==
X-Gm-Message-State: ABuFfogyKMvZzatX8J8u4h72/1qmklcDEQditYuU7XcQ8k+4Sm3jDpIT
        kUOm5MA/wVu9VutqOM4PcBo=
X-Google-Smtp-Source: ACcGV61vg9bKhdnnZ8nsIIuc+ZR8ZvjL3YN9QS18n2MgPUpMzNpbGhaqNhty5iQ9MIm3rNqcjy4Gkw==
X-Received: by 2002:a62:c186:: with SMTP id i128-v6mr24542472pfg.248.1539739476829;
        Tue, 16 Oct 2018 18:24:36 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n64-v6sm22841851pfi.185.2018.10.16.18.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 18:24:36 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] hwmon: (ina3221) Add PM runtime support
Date:   Tue, 16 Oct 2018 18:24:26 -0700
Message-Id: <20181017012426.26958-6-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017012426.26958-1-nicoleotsuka@gmail.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all three channels are disabled via in[123]_enable ABI,
the driver could suspend the chip for power saving purpose.

So this patch addsd the PM runtime support in order to gain
more power control than system suspend and resume use case.

For PM runtime, there are a few related changes happening:
1) Added a new explicit hdev device pointer for all the pm
   runtime callbacks. This is because hwmon core registers
   a child device for each hwmon driver. So there might be
   a mismatch between two device pointers in the driver if
   mixing using them.
2) Added a check in ina3221_is_enabled() to make sure that
   the chip is resumed.
3) Bypassed the unchanged status in ina3221_write_enable()
   in order to keep the pm runtime refcount being matched.
4) Removed the reset routine in the probe() by calling the
   resume() via pm_runtime_get_sync(), as they're similar.
   It's also necessary to do so to match initial refcount
   with the number of enabled channels.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 104 +++++++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 160ddc404d73..5ad3ab22b07a 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#include <linux/pm_runtime.h>
 
 #define INA3221_DRIVER_NAME		"ina3221"
 
@@ -47,6 +48,7 @@
 #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
 
+#define INA3221_CONFIG_DEFAULT		0x7127
 #define INA3221_RSHUNT_DEFAULT		10000
 
 enum ina3221_fields {
@@ -97,6 +99,7 @@ struct ina3221_input {
 
 /**
  * struct ina3221_data - device specific information
+ * @hdev: Device pointer of hwmon child device, used for pm runtime
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @inputs: Array of channel input source specific structures
@@ -104,6 +107,7 @@ struct ina3221_input {
  * @reg_config: Register value of INA3221_CONFIG
  */
 struct ina3221_data {
+	struct device *hdev;
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
@@ -113,7 +117,8 @@ struct ina3221_data {
 
 static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 {
-	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
+	return pm_runtime_active(ina->hdev) &&
+	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
 }
 
 static inline int ina3221_wait_for_data_if_active(struct ina3221_data *ina)
@@ -262,19 +267,33 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
+	u16 config_old = ina->reg_config & mask;
 	int ret;
 
 	config = enable ? mask : 0;
 
+	/* Bypass if enable status is not being changed */
+	if (config_old == config)
+		return 0;
+
+	/* For enabling routine, increase refcount and resume() at first */
+	if (enable) {
+		ret = pm_runtime_get_sync(ina->hdev);
+		if (ret < 0) {
+			dev_err(dev, "Failed to get PM runtime");
+			return ret;
+		}
+	}
+
 	/* Enable or disable the channel */
 	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/* Cache the latest config register value */
 	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/* Make sure data conversion is finished */
 	ret = ina3221_wait_for_data_if_active(ina);
@@ -283,7 +302,20 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 		return ret;
 	}
 
+	/* For disabling routine, decrease refcount or suspend() at last */
+	if (!enable)
+		pm_runtime_put_sync(ina->hdev);
+
 	return 0;
+
+fail:
+	if (enable) {
+		dev_err(dev, "Reverting channel%d enabling: %d\n",
+			channel, ret);
+		pm_runtime_put_sync(ina->hdev);
+	}
+
+	return ret;
 }
 
 static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
@@ -578,7 +610,6 @@ static int ina3221_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct ina3221_data *ina;
-	struct device *hwmon_dev;
 	int i, ret;
 
 	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
@@ -610,44 +641,71 @@ static int ina3221_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = regmap_field_write(ina->fields[F_RST], true);
-	if (ret) {
-		dev_err(dev, "Unable to reset device\n");
-		return ret;
-	}
-
-	/* Sync config register after reset */
-	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
-	if (ret)
-		return ret;
+	/* The driver will be reset, so use reset value */
+	ina->reg_config = INA3221_CONFIG_DEFAULT;
 
 	/* Disable channels if their inputs are disconnected */
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
 		if (ina->inputs[i].disconnected)
 			ina->reg_config &= ~INA3221_CONFIG_CHx_EN(i);
 	}
-	ret = regmap_write(ina->regmap, INA3221_CONFIG, ina->reg_config);
-	if (ret)
-		return ret;
 
 	mutex_init(&ina->lock);
 	dev_set_drvdata(dev, ina);
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
+	/* Fence sysfs nodes till pm_runtime is resumed */
+	mutex_lock(&ina->lock);
+
+	/* Use the returned hdev for pm_runtime */
+	ina->hdev = devm_hwmon_device_register_with_info(dev, client->name, ina,
 							 &ina3221_chip_info,
 							 ina3221_groups);
-	if (IS_ERR(hwmon_dev)) {
+	if (IS_ERR(ina->hdev)) {
 		dev_err(dev, "Unable to register hwmon device\n");
-		mutex_destroy(&ina->lock);
-		return PTR_ERR(hwmon_dev);
+		ret = PTR_ERR(ina->hdev);
+		goto fail_lock;
 	}
 
+	/* Enable PM runtime -- status is suspended by default */
+	pm_runtime_enable(ina->hdev);
+
+	/* Initialize (resume) the device */
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
+		if (ina->inputs[i].disconnected)
+			continue;
+		/* Match the refcount with number of enabled channels */
+		ret = pm_runtime_get_sync(ina->hdev);
+		if (ret < 0)
+			goto fail_pm;
+	}
+
+	mutex_unlock(&ina->lock);
+
 	return 0;
+
+fail_pm:
+	pm_runtime_disable(ina->hdev);
+	pm_runtime_set_suspended(ina->hdev);
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
+		pm_runtime_put_noidle(ina->hdev);
+fail_lock:
+	mutex_unlock(&ina->lock);
+	mutex_destroy(&ina->lock);
+
+	return ret;
 }
 
 static int ina3221_remove(struct i2c_client *client)
 {
 	struct ina3221_data *ina = dev_get_drvdata(&client->dev);
+	int i;
+
+	pm_runtime_disable(ina->hdev);
+	pm_runtime_set_suspended(ina->hdev);
+
+	/* Decrease the PM refcount */
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
+		pm_runtime_put_noidle(ina->hdev);
 
 	mutex_destroy(&ina->lock);
 
@@ -712,7 +770,9 @@ static int __maybe_unused ina3221_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops ina3221_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(ina3221_suspend, ina3221_resume, NULL)
 };
 
 static const struct of_device_id ina3221_of_match_table[] = {
-- 
2.17.1

