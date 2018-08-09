Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3324C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA0421EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VRK8mpgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA0421EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeHJAMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:12:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33964 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeHJAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:12:05 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 16/24] pwm: jz4740: Add support for the JZ4725B
Date:   Thu,  9 Aug 2018 23:44:06 +0200
Message-Id: <20180809214414.20905-17-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851117; bh=UyBLAsOOTuJ4f+TurpqvcRjgdULRZ8b5sl56Lf3CILM=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VRK8mpgziRyqvIyB35CWOT/oc1hJlf1XMo7a1RQlY3tTOcbYUUbqKwS7Za+dEDneYPsLZ09p9X6uGuD9sfX5VJRhCyHAQUwNKCpLFSumX2wwXT1TtfNimWkfG85gieMfaBpnvY1EyFiWrTWVsMepErfxjtuQKqe2OJBHTWMtRsM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM in the JZ4725B works the same as in the JZ4740, except that it
only has 6 channels available instead of 8.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

 v5: New patch

 v6: - Move of_device_id structure back at the bottom (less noise in
       patch)
     - Use device_get_match_data() instead of of_* variant

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

