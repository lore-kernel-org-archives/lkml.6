Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566F2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0370526D11
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZi8SkSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0370526D11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbeF1FRt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:17:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38426 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbeF1FRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:17:45 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so2174659plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7ifO15Z29OAnWQ0+lH7n1waetv2rLEYA+oUyDOvnn78=;
        b=KZi8SkSL1ykDjsA+EFnjaMLhYNypyQIqdtS6RbYpv7evU+v7kdQuQe+WNgFeynVXgZ
         FWeFi+QWZ9TYnF2tM9zb1VH1Y0Um40/B8p+pNzfBVss+TKO2UaTl8UtP9hLWjpCvljxx
         uTC5fgcEM+P8d1dV61VOgrnYxgt3jB7QJ1eBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7ifO15Z29OAnWQ0+lH7n1waetv2rLEYA+oUyDOvnn78=;
        b=th8Lg8aUhUmrb7YOwzsOjJcb5wtKDJoTxrto+YTbS+biOEX9EDZgLscHvggwPFH+KQ
         2OvwovN9O3LY6lW9z4t95/FnDnFQ83/3JK0cdTDf4f6KArhpqMWy3s9ifEv3KKfozSw+
         HFdImeN+wZ1LY0q1quai8H5xIbMSmVXo86I59gFYy33lTsW1I714a3m3ZREIVg28miYD
         snONijgEW1QBCBhtWzBQvROrx39TICy1rITvIzbJluZKorTumc2wu5WjouIWGPeagMyi
         dATToCRARpcorFxOxEhIgcQUrpEaeKFtBWnQdT1Ug14TJEoq1EX963QWMRtXjHCHJwUr
         uKYQ==
X-Gm-Message-State: APt69E1e8ibRibTHmzOjuDXBDx19A4YF8feJPszVuzqDT25SjiE4OA2L
        N+FdYVotP6EWeFYt3n5F5iIBig==
X-Google-Smtp-Source: ADUXVKJ3AwJUWNdLfpBMSyX7IuDd/lXfF3fj1BG4YZfvMHI9/Osv/Cc+CaDll8vw13HukFbBJwkH5A==
X-Received: by 2002:a17:902:7898:: with SMTP id q24-v6mr8974998pll.254.1530163064422;
        Wed, 27 Jun 2018 22:17:44 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k71-v6sm16726798pga.62.2018.06.27.22.17.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 22:17:43 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     bjorn.andersson@linaro.org, baolin.wang@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] leds: sc27xx: Add pattern_set/get/clear interfaces for LED controller
Date:   Thu, 28 Jun 2018 13:16:41 +0800
Message-Id: <22a9eda2b0dd689135f2336c37be2bf94893e28c.1530162340.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
References: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
In-Reply-To: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
References: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the 'pattern_set', 'pattern_get' and 'pattern_clear'
interfaces to support SC27XX LED breathing mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - No updates.
---
 drivers/leds/leds-sc27xx-bltc.c |  160 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index 9d9b7aa..898f92d 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 #include <uapi/linux/uleds.h>
 
 /* PMIC global control register definition */
@@ -32,8 +33,13 @@
 #define SC27XX_DUTY_MASK	GENMASK(15, 0)
 #define SC27XX_MOD_MASK		GENMASK(7, 0)
 
+#define SC27XX_CURVE_SHIFT	8
+#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
+#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
+
 #define SC27XX_LEDS_OFFSET	0x10
 #define SC27XX_LEDS_MAX		3
+#define SC27XX_LEDS_PATTERN_CNT	4
 
 struct sc27xx_led {
 	char name[LED_MAX_NAME_SIZE];
@@ -122,6 +128,157 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
 	return err;
 }
 
+static int sc27xx_led_pattern_clear(struct led_classdev *ldev)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	struct regmap *regmap = leds->priv->regmap;
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	int err;
+
+	mutex_lock(&leds->priv->lock);
+
+	/* Reset the rise, high, fall and low time to zero. */
+	regmap_write(regmap, base + SC27XX_LEDS_CURVE0, 0);
+	regmap_write(regmap, base + SC27XX_LEDS_CURVE1, 0);
+
+	err = regmap_update_bits(regmap, ctrl_base,
+			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
+
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static int sc27xx_led_pattern_set(struct led_classdev *ldev,
+				  struct led_pattern *pattern,
+				  int len)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	struct regmap *regmap = leds->priv->regmap;
+	int err;
+
+	/*
+	 * Must contain 4 patterns to configure the rise time, high time, fall
+	 * time and low time to enable the breathing mode.
+	 */
+	if (len != SC27XX_LEDS_PATTERN_CNT)
+		return -EINVAL;
+
+	mutex_lock(&leds->priv->lock);
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_L_MASK, pattern[0].delta_t);
+	if (err)
+		goto out;
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_L_MASK, pattern[1].delta_t);
+	if (err)
+		goto out;
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_H_MASK,
+				 pattern[2].delta_t << SC27XX_CURVE_SHIFT);
+	if (err)
+		goto out;
+
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_H_MASK,
+				 pattern[3].delta_t << SC27XX_CURVE_SHIFT);
+	if (err)
+		goto out;
+
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
+				 SC27XX_DUTY_MASK,
+				 (pattern[0].brightness << SC27XX_DUTY_SHIFT) |
+				 SC27XX_MOD_MASK);
+	if (err)
+		goto out;
+
+	/* Enable the LED breathing mode */
+	err = regmap_update_bits(regmap, ctrl_base,
+				 SC27XX_LED_RUN << ctrl_shift,
+				 SC27XX_LED_RUN << ctrl_shift);
+
+out:
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static struct led_pattern *sc27xx_led_pattern_get(struct led_classdev *ldev,
+						  int *len)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 base = sc27xx_led_get_offset(leds);
+	struct regmap *regmap = leds->priv->regmap;
+	struct led_pattern *pattern;
+	int i, err;
+	u32 val;
+
+	/*
+	 * Must allocate 4 patterns to show the rise time, high time, fall time
+	 * and low time.
+	 */
+	pattern = kcalloc(SC27XX_LEDS_PATTERN_CNT, sizeof(*pattern),
+			  GFP_KERNEL);
+	if (!pattern)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&leds->priv->lock);
+
+	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE0, &val);
+	if (err)
+		goto out;
+
+	pattern[0].delta_t = val & SC27XX_CURVE_L_MASK;
+
+	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE1, &val);
+	if (err)
+		goto out;
+
+	pattern[1].delta_t = val & SC27XX_CURVE_L_MASK;
+
+	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE0, &val);
+	if (err)
+		goto out;
+
+	pattern[2].delta_t = (val & SC27XX_CURVE_H_MASK) >> SC27XX_CURVE_SHIFT;
+
+	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE1, &val);
+	if (err)
+		goto out;
+
+	pattern[3].delta_t = (val & SC27XX_CURVE_H_MASK) >> SC27XX_CURVE_SHIFT;
+
+	err = regmap_read(regmap, base + SC27XX_LEDS_DUTY, &val);
+	if (err)
+		goto out;
+
+	mutex_unlock(&leds->priv->lock);
+
+	val = (val & SC27XX_DUTY_MASK) >> SC27XX_DUTY_SHIFT;
+	for (i = 0; i < SC27XX_LEDS_PATTERN_CNT; i++)
+		pattern[i].brightness = val;
+
+	*len = SC27XX_LEDS_PATTERN_CNT;
+
+	return pattern;
+
+out:
+	mutex_unlock(&leds->priv->lock);
+	kfree(pattern);
+
+	return ERR_PTR(err);
+}
+
 static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 {
 	int i, err;
@@ -140,6 +297,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 		led->priv = priv;
 		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
+		led->ldev.pattern_set = sc27xx_led_pattern_set;
+		led->ldev.pattern_get = sc27xx_led_pattern_get;
+		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
 
 		err = devm_led_classdev_register(dev, &led->ldev);
 		if (err)
-- 
1.7.9.5

