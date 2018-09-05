Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ADAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FDD2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXMjmF41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FDD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeIELtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:49:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42458 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeIELtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:49:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so2960028pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MsZ65Y/Ek7k7XgCqpDuTbSQGCpDSNaqAmgZxLkIQWVA=;
        b=ZXMjmF41pJI5mx40NVXPnERnOiAMhBPUbgTroE879rqWHza4vKoS1KVUnb4h2ZOBwz
         CjXW0rQm4RE1JBOZSvqkt9BYvC76JiMCfuNRR1RXh7Uz8ev4Stz2dx5J9C0YEJI1lgkD
         vMNyZhHe3kmfbkjuQdj7pS9/raAtE93RqATvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MsZ65Y/Ek7k7XgCqpDuTbSQGCpDSNaqAmgZxLkIQWVA=;
        b=WgnHEC65CV4ThPpKYalmtStAEnLvp8Slm9bqhpSyMldx7H4Ydl4AFeAt4G4NydOKHq
         HAPcHcFyX1vi6O7MXOea4U2zrzB7SFbuAW6382AOzSAi394kQ2pGBJZfEQcMv2S7/bhQ
         hm6basbaKF1uwt1EnOQwkV22iahVFO3aELL9W7I7CFHvkCK/Ivy6yJjTBbUioo2mcqiy
         /NCKgpMJFcF36gSBZh8gdrB/vZM09wfrE/CmeDsMAVihXpkSGEwwr6YFZ8utOEFCcape
         rGF9hpSrFG+QOLIWfzFPAxj2KbibrnM0G9FLJeXNiArt18P6IZna/ngThutRLUVbC9tE
         t9Zw==
X-Gm-Message-State: APzg51Af86T7+bLNoaDdCE/yj0+MkRcLcIs9F6Wgd9H9trCvaR09/XDq
        PRop4olvrQ1nUIwVvL4wwIfgzw==
X-Google-Smtp-Source: ANB0VdZixXkmnPupEmB2ftWiSLKy04W+fONwAHIcewEXJ15UggfOtiUULs28su4+YRczFoGSjnP4+A==
X-Received: by 2002:a62:384a:: with SMTP id f71-v6mr38799481pfa.48.1536132023762;
        Wed, 05 Sep 2018 00:20:23 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s85-v6sm1662755pfa.116.2018.09.05.00.20.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 00:20:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] leds: sc27xx: Add pattern_set/clear interfaces for LED controller
Date:   Wed,  5 Sep 2018 15:20:00 +0800
Message-Id: <b079d9a27390d6589195906606e6bac143bdb95c.1536131926.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536131926.git.baolin.wang@linaro.org>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536131926.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the 'pattern_set'and 'pattern_clear'
interfaces to support SC27XX LED breathing mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v8:
 - Optimize the ABI documentation file.

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
 .../ABI/testing/sysfs-class-led-driver-sc27xx      |   20 +++++
 drivers/leds/leds-sc27xx-bltc.c                    |   93 ++++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
new file mode 100644
index 0000000..391ca6e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
@@ -0,0 +1,20 @@
+What:		/sys/class/leds/<led>/hw_pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a hardware pattern for the SC27XX LED. For the SC27XX
+		LED controller, it only supports 4 stages to make a single
+		hardware pattern, which is used to configure the rise time,
+		high time, fall time and low time for the breathing mode.
+
+		For the breathing mode, the SC27XX LED only expects one brightness
+		for the high stage. To be compatible with the hardware pattern
+		format, we should set brightness as 0 for rise stage, fall
+		stage and low stage.
+
+		Min stage duration: 1
+		Max stage duration: 255
+		Stage duration step: 125 ms
+
+		Thus the format of the hardware pattern values should be:
+		"0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index 9d9b7aa..bff2f8f 100644
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
@@ -122,6 +127,90 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
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
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
+				 SC27XX_DUTY_MASK,
+				 (pattern[1].brightness << SC27XX_DUTY_SHIFT) |
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
@@ -140,6 +229,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 		led->priv = priv;
 		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
+		led->ldev.pattern_set = sc27xx_led_pattern_set;
+		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
+		led->ldev.default_trigger = "pattern";
 
 		err = devm_led_classdev_register(dev, &led->ldev);
 		if (err)
@@ -241,4 +333,5 @@ static int sc27xx_led_remove(struct platform_device *pdev)
 
 MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
 MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

