Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35D4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27962183D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TfQ9Ozfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27962183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeHUUiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:38:18 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57628 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeHUUiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:17 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 16/24] pwm: jz4740: Add support for the JZ4725B
Date:   Tue, 21 Aug 2018 19:16:27 +0200
Message-Id: <20180821171635.22740-17-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871835; bh=gClKGgt4YRbnlUWaCQo7tFZmt8rVN4ZA1fw/vcxEai4=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TfQ9OzfhuEunnPz30GG6tCvHl+EpdLCvpPGBgW+MZbphYb1q7ai9lKvcaEY9zvHQqmu9Q7sXghP7xLaVtf9eXwmqRSoulV136o9M3QvsBaTwFu//pQq7UfyVqs7Vc7vw2gcNOlkI9GhZ49cu4EE8Bgt53zS3yTp6IcGs+uofL3Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM in the JZ4725B works the same as in the JZ4740, except that it
only has 6 channels available instead of 8.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: - Move of_device_id structure back at the bottom (less noise in
           patch)
         - Use device_get_match_data() instead of of_* variant
    
     v7: No change

 drivers/pwm/pwm-jz4740.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 5814825d9bed..66a72bd7424f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -25,6 +25,10 @@
 
 #define NUM_PWM 8
 
+struct jz4740_soc_info {
+	unsigned int num_pwms;
+};
+
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clks[NUM_PWM];
@@ -200,9 +204,14 @@ static const struct pwm_ops jz4740_pwm_ops = {
 
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
+	const struct jz4740_soc_info *soc_info;
 	struct jz4740_pwm_chip *jz4740;
 	struct device *dev = &pdev->dev;
 
+	soc_info = device_get_match_data(dev);
+	if (!soc_info)
+		return -EINVAL;
+
 	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
 	if (!jz4740)
 		return -ENOMEM;
@@ -215,7 +224,7 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 
 	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
-	jz4740->chip.npwm = NUM_PWM;
+	jz4740->chip.npwm = soc_info->num_pwms;
 	jz4740->chip.base = -1;
 	jz4740->chip.of_xlate = of_pwm_xlate_with_flags;
 	jz4740->chip.of_pwm_n_cells = 3;
@@ -233,8 +242,17 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
+static const struct jz4740_soc_info jz4740_soc_info = {
+	.num_pwms = 8,
+};
+
+static const struct jz4740_soc_info jz4725b_soc_info = {
+	.num_pwms = 6,
+};
+
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
-	{ .compatible = "ingenic,jz4740-pwm", },
+	{ .compatible = "ingenic,jz4740-pwm", .data = &jz4740_soc_info },
+	{ .compatible = "ingenic,jz4725b-pwm", .data = &jz4725b_soc_info },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-- 
2.11.0

