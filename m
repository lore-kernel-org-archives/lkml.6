Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01842C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF162080D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UY9oL0U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF162080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeKOOVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:21:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45238 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:21:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so4236611plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMww0j8vs5eiNJilKCl4wAWICg/Z8BIVlIe2J/W0AtY=;
        b=UY9oL0U4DkbciwUANCVdhzBzqNR85zEw0MlhaxUm0w4KsjPMDFmWITJM9Wwj8Gf9dS
         ft4jCerx+sMTrmbxqx8v2Y3iQRVqK1aXrm5+4pPfkyzqGkq95AwGmbI4iBE77vBmUrQd
         RjIucGqcphoIm5a7RvJGfSBg03rvCqlLI50lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMww0j8vs5eiNJilKCl4wAWICg/Z8BIVlIe2J/W0AtY=;
        b=TdlDxHpZHkCapR9J7UO7yGizqhaCc/ujuue5UejwTpIoOAT6BAVp8RKi4mgBTq8t2u
         aktJKzGXEaZeByVgkAuzyRVkwAe2e1q4ewr2oQ0gsL65oxH7uuBZz7R6yurB2GcWqxdE
         K2PFDJxcKQctSbiEeXFZW81RL7k+81SlV+y7j7s1oClmHSpx9cJzAlHQgAJ88MdrMuAo
         flUB7Uoj8O8FkrRbf06yXU3HSTdhYInvP6fxO0RofquHrqUYQ/tgIdtLtoccpDYzEG7e
         R18WJTPFZ/dhFZyyZuB0KvrvQih6hrZBoVOLJF11Uw+OtI7Gf72I5ZOizNwr7DMQW7R4
         byxg==
X-Gm-Message-State: AGRZ1gJb1+AZLOnw1b7Hz5UGfm19t/T2yzRQGRyQuMCyz6RItFFG8F4y
        Ez+Cc/uSiUgBcygJ00w/08fX8hZIUpw=
X-Google-Smtp-Source: AJdET5csRkRIr+aq215eQ5zWkRYx4NBBYnONmzpQyAjViHfEFXxLNtSxVS2cm8gMLqqA/mWCsNv36w==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr4788465pll.305.1542255307851;
        Wed, 14 Nov 2018 20:15:07 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id d11sm10976297pgi.25.2018.11.14.20.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 20:15:07 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 2/2] ASoC: rt5663: Add regulator support
Date:   Thu, 15 Nov 2018 12:13:34 +0800
Message-Id: <20181115041334.79446-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181115041334.79446-1-cychiang@chromium.org>
References: <20181115041334.79446-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator support to turn on cpvdd and avdd in probe.
If a regulator is not given from device tree, a dummy regulator will be
used.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/codecs/rt5663.c | 68 +++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 2444fad7c2dfe..7e9c1901a0a67 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
+#include <linux/regulator/consumer.h>
 #include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -33,6 +34,9 @@
 #define RT5663_DEVICE_ID_2 0x6451
 #define RT5663_DEVICE_ID_1 0x6406
 
+#define RT5663_POWER_ON_DELAY_MS 300
+#define RT5663_SUPPLY_CURRENT_UA 500000
+
 enum {
 	CODEC_VER_1,
 	CODEC_VER_0,
@@ -48,6 +52,11 @@ struct impedance_mapping_table {
 	unsigned int dc_offset_r_manual_mic;
 };
 
+static const char *const rt5663_supply_names[] = {
+	"avdd",
+	"cpvdd",
+};
+
 struct rt5663_priv {
 	struct snd_soc_component *component;
 	struct rt5663_platform_data pdata;
@@ -56,6 +65,7 @@ struct rt5663_priv {
 	struct snd_soc_jack *hs_jack;
 	struct timer_list btn_check_timer;
 	struct impedance_mapping_table *imp_table;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(rt5663_supply_names)];
 
 	int codec_ver;
 	int sysclk;
@@ -3480,7 +3490,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt5663_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5663_priv *rt5663;
-	int ret;
+	int ret, i;
 	unsigned int val;
 	struct regmap *regmap;
 
@@ -3497,6 +3507,37 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	else
 		rt5663_parse_dp(rt5663, &i2c->dev);
 
+	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++)
+		rt5663->supplies[i].supply = rt5663_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev,
+				      ARRAY_SIZE(rt5663->supplies),
+				      rt5663->supplies);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* Set load for regulator. */
+	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++) {
+		ret = regulator_set_load(rt5663->supplies[i].consumer,
+					 RT5663_SUPPLY_CURRENT_UA);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to set regulator %s, ret: %d\n",
+				rt5663->supplies[i].supply, ret);
+		}
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(rt5663->supplies),
+				    rt5663->supplies);
+
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+	msleep(RT5663_POWER_ON_DELAY_MS);
+
 	regmap = devm_regmap_init_i2c(i2c, &temp_regmap);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
@@ -3527,7 +3568,8 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5663\n",
 			val);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_enable;
 	}
 
 	if (IS_ERR(rt5663->regmap)) {
@@ -3632,20 +3674,30 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = request_irq(i2c->irq, rt5663_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5663", rt5663);
-		if (ret)
+		if (ret) {
 			dev_err(&i2c->dev, "%s Failed to reguest IRQ: %d\n",
 				__func__, ret);
+			goto err_enable;
+		}
 	}
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_rt5663,
 			rt5663_dai, ARRAY_SIZE(rt5663_dai));
 
-	if (ret) {
-		if (i2c->irq)
-			free_irq(i2c->irq, rt5663);
-	}
+	if (ret)
+		goto err_irq;
 
+	return 0;
+
+err_irq:
+	if (i2c->irq)
+		free_irq(i2c->irq, rt5663);
+
+err_enable:
+	dev_err(&i2c->dev,
+		"%s: Disable regulator after probe error\n", __func__);
+	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 	return ret;
 }
 
@@ -3656,6 +3708,8 @@ static int rt5663_i2c_remove(struct i2c_client *i2c)
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5663);
 
+	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
+
 	return 0;
 }
 
-- 
2.19.1.930.g4563a0d9d0-goog

