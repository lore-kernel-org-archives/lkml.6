Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A50BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2038521780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Pr0JETbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2038521780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbeKPF4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:56:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57906 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPF4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NwOqsP2VwNg4cMcnV9Ursyg2QBGAiXR2GG/UkmwAYWU=; b=Pr0JETbVIvjs
        dwYnjBkERs4oX/2Ua3QAimgEN4HU8KHEIq8MvRtyPF0CgOjpMb3+HS9gFL1Yr5Vl7SEsB0U4xz3eT
        UiMfzUTj78KupIgKCjDpmBChPLEYwHC13lpN56brxaEtdkwPJ8+BpwnQ+8fakG1faLmfG2TSGCxvd
        3g9HA=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNNbX-0006Fc-Qe; Thu, 15 Nov 2018 19:47:08 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0EDD2440079; Thu, 15 Nov 2018 19:47:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77686: Pass descriptor instead of GPIO number" to the regulator tree
In-Reply-To: 
Message-Id: <20181115194706.0EDD2440079@finisterre.ee.mobilebroadband>
Date:   Thu, 15 Nov 2018 19:47:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77686: Pass descriptor instead of GPIO number

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 96392c3d8ca47f6654dfa40680c926b1a3419754 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 Nov 2018 09:01:19 +0100
Subject: [PATCH] regulator: max77686: Pass descriptor instead of GPIO number

Instead of passing a global GPIO number, pass a descriptor looked
up from the device tree configuration node.

Tested on Odroid U3 (with max77686 although not using any GPIOs
for regulators, so at least default paths are not broken).

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77686-regulator.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index bee060937f56..f5cee1775905 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -11,8 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -76,6 +75,7 @@ enum max77686_ramp_rate {
 };
 
 struct max77686_data {
+	struct device *dev;
 	DECLARE_BITMAP(gpio_enabled, MAX77686_REGULATORS);
 
 	/* Array indexed by regulator id */
@@ -255,16 +255,20 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpio = of_get_named_gpio(np,
-					"maxim,ena-gpios", 0);
-		config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
-		config->ena_gpio_initialized = true;
+		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
+				np,
+				"maxim,ena",
+				0,
+				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+				"max77686-regulator");
+		if (IS_ERR(config->ena_gpiod))
+			config->ena_gpiod = NULL;
 		break;
 	default:
 		return 0;
 	}
 
-	if (gpio_is_valid(config->ena_gpio)) {
+	if (config->ena_gpiod) {
 		set_bit(desc->id, max77686->gpio_enabled);
 
 		return regmap_update_bits(config->regmap, desc->enable_reg,
@@ -507,6 +511,7 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	if (!max77686)
 		return -ENOMEM;
 
+	max77686->dev = &pdev->dev;
 	config.dev = iodev->dev;
 	config.regmap = iodev->regmap;
 	config.driver_data = max77686;
-- 
2.19.1

