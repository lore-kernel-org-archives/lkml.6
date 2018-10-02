Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC58AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A976F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TF7a1PVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A976F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJBW2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:28:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41282 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeJBW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:28:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id q17-v6so1953706plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3argqhPtup/ppfa0Do6Pgd5p1OXZuYJFvc8uoI059XA=;
        b=TF7a1PVHsypuB1aRMXKMjbJWt34Bu0JMOgMeV0li/gb4UJnpiuaDYE77qg+VaZSCDR
         To7+wzyS8wSWgNGf/bPBaDNi2DeiweK1WiUNRv9tQ0mAmbEtAeIAUdBHIrF3lMtMrNmt
         MBVZlfDtM3xtAU4yQOWQy44HJyCG/9kg27hsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3argqhPtup/ppfa0Do6Pgd5p1OXZuYJFvc8uoI059XA=;
        b=Y5C8J4GN/IoxN3ox9jX3Gd9LKM3GmfGrshdMtY91dAiDXg5LhUNJjrzhwsPlOQmMlv
         zZFFe/A6j3ry0UXztiEvlZWXdH2wg2UDWewJpICT4afAtDgotKl2tlakSep/4btTpa4Z
         k2ZxPmeC6LK8V/kz3mrRXZ6yNJDRf67/EwsdwyGfdtk4B8nWxipikal6tWoZIYgeu/96
         AIoaa1ALi3lcaVUgvja3gyX+j2zxAPcFiJOUpbNuwZkY3/s6epCeRlYot7ZVvWsoihBH
         8FmIpRP4nbBInD8pdRaeAAL4fgxQd10EBsW0Y05Gt0oLoQSce1jf+XPJpWElncfA0YVC
         RlQw==
X-Gm-Message-State: ABuFfogUw+QHJHyVyw6S/k+g/uqgPReUBpOEZOLClBlIb37dsWfoNdms
        DeTTmTyJUbjnzT/v7PIf3jFQKg==
X-Google-Smtp-Source: ACcGV617Dov/cwU6U+XVrTklu0isTHVMkm1mJEF5dr5Mam/JasRYWaxydPFjUVnxbiP+p14s5ZZbTw==
X-Received: by 2002:a17:902:b109:: with SMTP id q9-v6mr17302020plr.83.1538495063520;
        Tue, 02 Oct 2018 08:44:23 -0700 (PDT)
Received: from ubuntu.localdomain ([64.64.108.144])
        by smtp.gmail.com with ESMTPSA id h77-v6sm23362441pfh.13.2018.10.02.08.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Oct 2018 08:44:22 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 2/2] leds: sc27xx: Add pattern_set/clear interfaces for LED controller
Date:   Tue,  2 Oct 2018 08:43:01 -0700
Message-Id: <cf9e16706f7b424c80002402997b48168dbbb8f4.1538494476.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
In-Reply-To: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the 'pattern_set'and 'pattern_clear'
interfaces to support SC27XX LED breathing mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.c>
---
Changes from v13:
 - None.

Changes from v12:
 - None.

Changes from v11:
 - None.

Changes from v10:
 - Add duration alignment function suggested by Jacek.
 - Add acked tag from Pavel.

Changes from v9:
 - Optimize the ABI documentation file.
 - Update the brightness value in hardware pattern mode.

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
 .../ABI/testing/sysfs-class-led-driver-sc27xx      |  22 ++++
 drivers/leds/leds-sc27xx-bltc.c                    | 121 +++++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
new file mode 100644
index 0000000..45b1e60
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
@@ -0,0 +1,22 @@
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
+		Min stage duration: 125 ms
+		Max stage duration: 31875 ms
+
+		Since the stage duration step is 125 ms, the duration should be
+		a multiplier of 125, like 125ms, 250ms, 375ms, 500ms ... 31875ms.
+
+		Thus the format of the hardware pattern values should be:
+		"0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index 9d9b7aa..fecf27f 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -32,8 +32,18 @@
 #define SC27XX_DUTY_MASK	GENMASK(15, 0)
 #define SC27XX_MOD_MASK		GENMASK(7, 0)
 
+#define SC27XX_CURVE_SHIFT	8
+#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
+#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
+
 #define SC27XX_LEDS_OFFSET	0x10
 #define SC27XX_LEDS_MAX		3
+#define SC27XX_LEDS_PATTERN_CNT	4
+/* Stage duration step, in milliseconds */
+#define SC27XX_LEDS_STEP	125
+/* Minimum and maximum duration, in milliseconds */
+#define SC27XX_DELTA_T_MIN	SC27XX_LEDS_STEP
+#define SC27XX_DELTA_T_MAX	(SC27XX_LEDS_STEP * 255)
 
 struct sc27xx_led {
 	char name[LED_MAX_NAME_SIZE];
@@ -122,6 +132,113 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
 	return err;
 }
 
+static void sc27xx_led_clamp_align_delta_t(u32 *delta_t)
+{
+	u32 v, offset, t = *delta_t;
+
+	v = t + SC27XX_LEDS_STEP / 2;
+	v = clamp_t(u32, v, SC27XX_DELTA_T_MIN, SC27XX_DELTA_T_MAX);
+	offset = v - SC27XX_DELTA_T_MIN;
+	offset = SC27XX_LEDS_STEP * (offset / SC27XX_LEDS_STEP);
+
+	*delta_t = SC27XX_DELTA_T_MIN + offset;
+}
+
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
+	ldev->brightness = LED_OFF;
+
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static int sc27xx_led_pattern_set(struct led_classdev *ldev,
+				  struct led_pattern *pattern,
+				  u32 len, int repeat)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	struct regmap *regmap = leds->priv->regmap;
+	int err;
+
+	/*
+	 * Must contain 4 tuples to configure the rise time, high time, fall
+	 * time and low time to enable the breathing mode.
+	 */
+	if (len != SC27XX_LEDS_PATTERN_CNT)
+		return -EINVAL;
+
+	mutex_lock(&leds->priv->lock);
+
+	sc27xx_led_clamp_align_delta_t(&pattern[0].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_L_MASK,
+				 pattern[0].delta_t / SC27XX_LEDS_STEP);
+	if (err)
+		goto out;
+
+	sc27xx_led_clamp_align_delta_t(&pattern[1].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_L_MASK,
+				 pattern[1].delta_t / SC27XX_LEDS_STEP);
+	if (err)
+		goto out;
+
+	sc27xx_led_clamp_align_delta_t(&pattern[2].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_H_MASK,
+				 (pattern[2].delta_t / SC27XX_LEDS_STEP) <<
+				 SC27XX_CURVE_SHIFT);
+	if (err)
+		goto out;
+
+	sc27xx_led_clamp_align_delta_t(&pattern[3].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_H_MASK,
+				 (pattern[3].delta_t / SC27XX_LEDS_STEP) <<
+				 SC27XX_CURVE_SHIFT);
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
+	if (!err)
+		ldev->brightness = pattern[1].brightness;
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
@@ -140,6 +257,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 		led->priv = priv;
 		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
+		led->ldev.pattern_set = sc27xx_led_pattern_set;
+		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
+		led->ldev.default_trigger = "pattern";
 
 		err = devm_led_classdev_register(dev, &led->ldev);
 		if (err)
@@ -241,4 +361,5 @@ static int sc27xx_led_remove(struct platform_device *pdev)
 
 MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
 MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

