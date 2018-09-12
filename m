Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A41CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B6F20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aOKTVol0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B6F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeILRYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:24:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43000 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeILRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:24:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so927585pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bx4U/efRCYPj+DbdOzjjJdclFU9QHreZRHqNGwFsXYo=;
        b=aOKTVol0aNYDGorMvHx76vyO9F4TLnwdZDHsRbYWfpRpohp7Doxc19nkiX1YxN1pz7
         lxjutPNS52mXRP7iCt63N9qOEAjoymEEC7QtG8AyhYhjNufbPsS1PFyEyA0y+aUN/Tpn
         ECT9cM5lQWE4d0QORuyaxL4AS2HDdgAAytPZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bx4U/efRCYPj+DbdOzjjJdclFU9QHreZRHqNGwFsXYo=;
        b=ApfedvRsl8zV4Gfimz/XAzsDEvqWHgfbeBnJYIC0yWWW7J4hPswipjXe6tZ4AeL1KR
         AXyG6vSJRiW3jNvHuWtkHXUPFD2cqTF5qyuxhOUAS65BJ/fVlqqQ1hTxxjx669LzWY1N
         15f92xo6z300MZHGobmAlrKLzGy/InBV0yIxok6AgUbUXQWU3RL8jH3ockMK3GoHUnxV
         nBnLi4T6KuBXbr0aytKZLFBaC4Q5w0TrqXJ+dmbV8G9+kBpGENkyuwnV41uG0sDHPeri
         kx+f8TjddIBF84Su2M5nr5DkAPvTLUS6RcKwOrAZ1NZErVzg0Bo7AsftGMAfFj1oEfFd
         xbKg==
X-Gm-Message-State: APzg51BdvmhXjXOU9JTaANXsJBL7op9bCLsgu0SOwwPXtHC0lWLE9mGU
        9zw0QEJJhZpvSVCqRG64cs5ZLzJF0Rs=
X-Google-Smtp-Source: ANB0VdbzZre5W7iirO5Q2EETc5JhQEOlKFJgpaWjRoIwJTu9j/wWglMWjhujryKSQKdZhghBTfvxiA==
X-Received: by 2002:a65:62d8:: with SMTP id m24-v6mr1950853pgv.307.1536754833576;
        Wed, 12 Sep 2018 05:20:33 -0700 (PDT)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id t9-v6sm1729038pgi.87.2018.09.12.05.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 05:20:32 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, ryans.lee@maximintegrated.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Date:   Wed, 12 Sep 2018 20:19:55 +0800
Message-Id: <20180912121955.33048-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180912121955.33048-1-cychiang@chromium.org>
References: <20180912121955.33048-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toggle reset line in max98927_i2c_probe.
Use a list to store max98927 instances so we do not toggle reset line
again if more than one instances share the same reset line.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/codecs/max98927.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max98927.h |  2 ++
 2 files changed, 80 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 941712058a8f5..789b27cdfd9e0 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -24,6 +25,11 @@
 #include <sound/tlv.h>
 #include "max98927.h"
 
+#define MAX98927_MIN_RESET_US 1
+#define MAX98927_RELEASE_RESET_DELAY_US 500
+
+static LIST_HEAD(reset_list);
+
 static struct reg_default max98927_reg[] = {
 	{MAX98927_R0001_INT_RAW1,  0x00},
 	{MAX98927_R0002_INT_RAW2,  0x00},
@@ -877,6 +883,54 @@ static void max98927_slot_config(struct i2c_client *i2c,
 		max98927->i_l_slot = 1;
 }
 
+static int max98927_i2c_toggle_reset(struct device *dev,
+				     struct max98927_priv *max98927)
+{
+	/*
+	 * If we do not have reset gpio, assume platform firmware
+	 * controls the regulator and toggles it for us.
+	 */
+	if (!max98927->reset_gpio)
+		return 0;
+
+	gpiod_set_value_cansleep(max98927->reset_gpio, 1);
+
+	/*
+	 * We need to wait a bit before we are allowed to release reset GPIO.
+	 */
+	usleep_range(MAX98927_MIN_RESET_US, MAX98927_MIN_RESET_US + 5);
+
+	gpiod_set_value_cansleep(max98927->reset_gpio, 0);
+
+	/*
+	 * We need to wait a bit before I2C communication is available.
+	 */
+	usleep_range(MAX98927_RELEASE_RESET_DELAY_US,
+		     MAX98927_RELEASE_RESET_DELAY_US + 5);
+
+	/*
+	 * Release reset GPIO because we are not going to use it.
+	 */
+	devm_gpiod_put(dev, max98927->reset_gpio);
+
+	return 0;
+}
+
+static bool max98927_is_first_to_reset(struct max98927_priv *max98927)
+{
+	struct max98927_priv *p;
+
+	if (!max98927->reset_gpio)
+		return false;
+
+	list_for_each_entry(p, &reset_list, list) {
+		if (max98927->reset_gpio == p->reset_gpio)
+			return false;
+	}
+
+	return true;
+}
+
 static int max98927_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
@@ -904,6 +958,28 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	} else
 		max98927->interleave_mode = 0;
 
+	/* Gets optional GPIO for reset line. */
+	max98927->reset_gpio = devm_gpiod_get_optional(
+			&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(max98927->reset_gpio)) {
+		ret = PTR_ERR(max98927->reset_gpio);
+		dev_err(&i2c->dev, "error getting reset gpio: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Only toggle reset line for the first instance when the
+	 * reset line is shared among instances. For example,
+	 * left and right amplifier share the same reset line, and
+	 * we should only toggle the reset line once.
+	 */
+	if (max98927_is_first_to_reset(max98927)) {
+		dev_info(&i2c->dev, "%s: toggle reset line\n", __func__);
+		ret = max98927_i2c_toggle_reset(&i2c->dev, max98927);
+		if (ret)
+			return ret;
+	}
+
 	/* regmap initialization */
 	max98927->regmap
 		= devm_regmap_init_i2c(i2c, &max98927_regmap);
@@ -934,6 +1010,8 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 
+	list_add(&max98927->list, &reset_list);
+
 	return ret;
 }
 
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index 538992a238b28..d48f61f6c3ba5 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -275,5 +275,7 @@ struct max98927_priv {
 	unsigned int master;
 	unsigned int digital_gain;
 	bool tdm_mode;
+	struct gpio_desc *reset_gpio;
+	struct list_head list;
 };
 #endif
-- 
2.16.4

