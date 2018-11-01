Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2114420830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K98MLrFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2114420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeKAVnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:43:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43074 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbeKAVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:43:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id h4-v6so9272382pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/f3iNmnZvEx+BLph1cKnkz6V+wPNI9ojBFBkofUvlg=;
        b=K98MLrFyeVlqysJpJx+J+Ck2UA99gm3DjPcesEl42q3pnkez0uU3NKZiPGdQKouocS
         qSlYsO2IJNZsBYOb7ULw8MUxzCoyOYNygv5qOa8SOKJ+DmNUvZXRMJEtE8RV58fVWEfX
         FK92tpkoruO+5BI139b05cNrStwNPMpyXaXjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/f3iNmnZvEx+BLph1cKnkz6V+wPNI9ojBFBkofUvlg=;
        b=ikEzg2MZJ2RFNClqpKDZM4+Ly8Wk3k+8jbT7pg8QOHS0pau87WU1EDFgsc83Y5dQUy
         COCiy4nQbH7Fi9kBfE+SNMk3hEJO9ZkyL2m2ifd9BNP9/jGS410UQNmq27EBRD5lCtaX
         JDk2BLo6vyU78BcGX0InU7Z5snMjSRgbVDdKdrZuSmFwHkUcUxqefgyo+LCuRb/izPIF
         70FufBD+AzsW0CxmrTOls7WYpkYu4wM5Ax9X4HsSpqxdPrTq6IuajVnGUgf7NiBdOW38
         7K1KTLi7OPYTPC+6C4TpHNaT/Lr7xMXMzy/5PUjtbX2rqB50UAdmc9JMyogHtHW2Ckb5
         Ktrw==
X-Gm-Message-State: AGRZ1gLR+Pf8GOlepMPNPV9NPDywo8ax+kE39Y6eH9D8w7Cl7IY2Vz1K
        N9GP6fAhyrdd02RXXdVILRfVhSiDt50=
X-Google-Smtp-Source: AJdET5eZ61tsklqmUFlOx0k5EGCO3NUTELfgy/kzB/iMjNshhFKlNfxoDnP5JaAdGihM94i5NFuHqA==
X-Received: by 2002:a62:8288:: with SMTP id w130-v6mr7558552pfd.68.1541076051495;
        Thu, 01 Nov 2018 05:40:51 -0700 (PDT)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id g20-v6sm10856210pfj.145.2018.11.01.05.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:40:50 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 2/2] CHROMIUM: ASoC: rt5663: Add regulator support
Date:   Thu,  1 Nov 2018 20:40:07 +0800
Message-Id: <20181101124007.243258-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181101124007.243258-1-cychiang@chromium.org>
References: <20181101124007.243258-1-cychiang@chromium.org>
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
2.19.1.568.g152ad8e336-goog

