Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9EC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HzOoNuPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfAQKXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:23:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37947 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfAQKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:23:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so452726wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Y0Y5B6s0w0R3Gp1L8M/91nvIc1hUn7ja0tycQpJro8=;
        b=HzOoNuPdoK9zHB3vqZE86aLSUSENong1ks01P2QHeVQ6ZAHt5MqnxRh8hf1J/cwIo6
         GqRcSKTR03esabYqdhw0iJkLipx5NqOqTkny55JN+wxHdeuqzLGSt/M0I36Tn7Z+pPik
         2QacXWzVG+re0r3nAtURi3FSsSjyuL+S2XbS0rla/qUP5N6Dv6t8fUQG2cH4RrRzLnau
         g/DnhUptnm7Z13p5IoN79X642DJTDCQyDzhOkR+8/Q9WsgSy0yudjp4xKuLNOPJF6D0Q
         OUydwcTgOzE/g9VugndT90IAdQ9fagXP5YBeaYyehkLvo+vluMNnOkl7rmkrOZwkv9+n
         +2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Y0Y5B6s0w0R3Gp1L8M/91nvIc1hUn7ja0tycQpJro8=;
        b=mnDEB+mI8We4C3MdR7293JZi4DicGBFPkB0FYdgbZaEf1NTzi/tk9HzZ4qnksZYNu3
         687hR6TScMrHiRATeHAYP8UAkss9ZAddMaD+F1G0OQXegZ7h+PFnajYvA4iPsMN5kCdw
         nPx6OgC7ljsLA+SBQaZRmJBvukFhNWvSnndb/Ifpi+VSTd0GCaPyA/9lHwG5PwgU1ZNd
         LUlA44x+oGGiqmHKLaM1JVdECYBxZlw1HENnrxwphA8FHJtuaZ6TQzdfDu3Rq8m8zrBc
         C2cpBsmTRGnl7VcHOXl5Cych4pFqra5WrO2UIcJD2S5CFH1/QtCYVnp9mipVjgO3wKJq
         wEkA==
X-Gm-Message-State: AJcUuke05hwU/WGKu8cAVNh+/ZcLxtIMiTejDbiJ1B2ocg5XNwiJxYmQ
        XKLkSKIrmJwK1mI7cOtC0LcTqw==
X-Google-Smtp-Source: ALg8bN6oj3zTDxDK/3lEWYmXIfBdJ8/WDqpeY/FgGXn5Hhv/4j6+xjMsB0USmaApqRcJRBcid+MceQ==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr11758492wmh.76.1547720606130;
        Thu, 17 Jan 2019 02:23:26 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id u10sm66400530wrr.33.2019.01.17.02.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:23:25 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/3] pinctrl: meson: fix G12A ao pull registers base address
Date:   Thu, 17 Jan 2019 11:23:14 +0100
Message-Id: <20190117102315.1833-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117102315.1833-1-jbrunet@baylibre.com>
References: <20190117102315.1833-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Since Meson G12A SoC, Introduce new ao registers AO_RTI_PULL_UP_EN_REG
and AO_GPIO_O.

These bits of controlling output level are remapped to the new register
AO_GPIO_O, and the AO_GPIO_O_EN_N support only controlling output enable.

These bits of controlling pull enable are remapped to the new register
AO_RTI_PULL_UP_EN_REG, and the AO_RTI_PULL_UP_REG support only controlling
pull type(up/down).

The new layout of ao gpio/pull registers is as follows:
- AO_GPIO_O_EN_N        [offset: 0x9 << 2]
- AO_GPIO_I             [offset: 0xa << 2]
- AO_RTI_PULL_UP_REG    [offset: 0xb << 2]
- AO_RTI_PULL_UP_EN_REG [offset: 0xc << 2]
- AO_GPIO_O             [offset: 0xd << 2]

From above, we can see ao GPIO registers region has been separated by the
ao pull registers. In order to ensure the continuity of the region on
software, the ao GPIO and ao pull registers use the same base address, but
can be identified by the offset.

Fixes: 29ae0952e85f ("pinctrl: meson-g12a: add pinctrl driver support")
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index ea87d739f534..a4ae1ac5369e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -31,6 +31,9 @@
  * In some cases the register ranges for pull enable and pull
  * direction are the same and thus there are only 3 register ranges.
  *
+ * Since Meson G12A SoC, the ao register ranges for gpio, pull enable
+ * and pull direction are the same, so there are only 2 register ranges.
+ *
  * For the pull and GPIO configuration every bank uses a contiguous
  * set of bits in the register sets described above; the same register
  * can be shared by more banks with different offsets.
@@ -488,23 +491,22 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 		return PTR_ERR(pc->reg_mux);
 	}
 
-	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
-	if (IS_ERR(pc->reg_pull)) {
-		dev_err(pc->dev, "pull registers not found\n");
-		return PTR_ERR(pc->reg_pull);
+	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
+	if (IS_ERR(pc->reg_gpio)) {
+		dev_err(pc->dev, "gpio registers not found\n");
+		return PTR_ERR(pc->reg_gpio);
 	}
 
+	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
+	/* Use gpio region if pull one is not present */
+	if (IS_ERR(pc->reg_pull))
+		pc->reg_pull = pc->reg_gpio;
+
 	pc->reg_pullen = meson_map_resource(pc, gpio_np, "pull-enable");
 	/* Use pull region if pull-enable one is not present */
 	if (IS_ERR(pc->reg_pullen))
 		pc->reg_pullen = pc->reg_pull;
 
-	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
-	if (IS_ERR(pc->reg_gpio)) {
-		dev_err(pc->dev, "gpio registers not found\n");
-		return PTR_ERR(pc->reg_gpio);
-	}
-
 	return 0;
 }
 
-- 
2.20.1

