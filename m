Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F5C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA7E20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm6IEedU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA7E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeIDP0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:26:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45532 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeIDP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:26:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so1506515pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dT5+c/rDXK0w6ZgGs2dsNIH02hHTsUSsivRMGYKlavM=;
        b=cm6IEedUlZiFA5n+B1YGE1l+868/CNdUZEc2ILgPw3g1arUa7IFJJW1vvw1B+1M5FL
         aJ/6k6Mo7Zhg/ZSUxthTWRyAoVhWU4VRTwAVh9z+luuxJuUQsY+AD5buuPa0Zi5cipoF
         vRCH1mq0XejpzfE1TlaXO5wX8G5T398i5EfZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dT5+c/rDXK0w6ZgGs2dsNIH02hHTsUSsivRMGYKlavM=;
        b=mHHjQRrg4FwgwqmY6uGNoqSNq4kAlm963nlrjxi6jwDuYPDkzvCoq1LNofK3haOzJr
         7nBCUKO4f10C/KfbInDN+TggQWNU2+Z6Q/RwQ2kQTFuiE9cWPqWZQ8JoIZeOEj33iDNI
         ki+aOPQxQXjIgboE/yo/2ecP/uWcPiD4fU5Szh6jDUOdV8RZJsdUCHpxzlVA9T/P/iSD
         f1YxxjiZc2ItYj0hk1BN0AFfPmX8aGvtJ13IrYfwMeK7kp8rUiysBU7t9sKHlEpgtQ2U
         mWIhMKDbV5kouXXsbdZDOI0Y5ShD49vA4LwAxQ+w2bPrEycishzNx+rqe8MGPTgNX8Fz
         /2Kw==
X-Gm-Message-State: APzg51AeE+e3zEc02+AQEcpY5MykqbVx16dDQEQCgBNo8vxW55ohImL6
        8DiTx9Dfnb2ySK6rPFciwNMuYw==
X-Google-Smtp-Source: ANB0VdZsxivUcURq6ZTzgleLe3nLpMxqAE2/qCQI5dW+lx5SOsnE7OL2xUzBF3cVcAeScF0ETZqGzw==
X-Received: by 2002:a63:4a09:: with SMTP id x9-v6mr29828207pga.34.1536058915885;
        Tue, 04 Sep 2018 04:01:55 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 8-v6sm23075478pgu.10.2018.09.04.04.01.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:01:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] leds: sc27xx: Add pattern_set/clear interfaces for LED controller
Date:   Tue,  4 Sep 2018 19:01:31 +0800
Message-Id: <e7642c73ac1c20b97990a887f76f2f51c41f930b.1536027873.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
In-Reply-To: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the 'pattern_set'and 'pattern_clear'
interfaces to support SC27XX LED breathing mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v7:
 - Add its own ABI documentation file.

Changes from v6:
 - None.

Changes from v5:
 - None.

Changes from v4:
 - None.

Changes from v3:
 - None.

Changes from v2:
 - None.

Changes from v1:
 - Remove pattern_get interface.
---
 .../ABI/testing/sysfs-class-led-driver-sc27xx      |   11 +++
 drivers/leds/leds-sc27xx-bltc.c                    |   94 ++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
new file mode 100644
index 0000000..ecef3ba
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
@@ -0,0 +1,11 @@
+What:		/sys/class/leds/<led>/hw_pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a hardware pattern for the SC27XX LED. For the SC27XX
+		LED controller, it only supports 4 hardware patterns to configure
+		the low time, rise time, high time and fall time for the breathing
+		mode, and each stage duration unit is 125ms. So the format of
+		the hardware pattern values should be:
+		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
+		duration_3 brightness_4 duration_4".
diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index 9d9b7aa..297dd43 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -32,8 +32,13 @@
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
@@ -122,6 +127,91 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
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
+				  int len, u32 repeat)
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
 static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 {
 	int i, err;
@@ -140,6 +230,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 		led->priv = priv;
 		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
+		led->ldev.pattern_set = sc27xx_led_pattern_set;
+		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
+		led->ldev.default_trigger = "pattern";
 
 		err = devm_led_classdev_register(dev, &led->ldev);
 		if (err)
@@ -241,4 +334,5 @@ static int sc27xx_led_remove(struct platform_device *pdev)
 
 MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
 MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

