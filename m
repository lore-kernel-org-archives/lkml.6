Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E02C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226DB25513
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VJpSCV7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226DB25513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964992AbeF0Lzz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:55:55 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35978 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeF0LzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:55:03 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] pinctrl: ingenic: Implement pinmux callback .gpio_get_direction
Date:   Wed, 27 Jun 2018 13:49:03 +0200
Message-Id: <20180627114904.10890-5-paul@crapouillou.net>
In-Reply-To: <20180627114904.10890-1-paul@crapouillou.net>
References: <20180627114904.10890-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530100166; bh=lMB3Kcfp70Si2MDWAF6ZTiqsNFXanURFN68wtgxyH0A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VJpSCV7xLwde6xko82biiZ5uJk6FScLTFr0C5gOE+5yotIAF3+q8pbn10F1rbgvag1x+M/hMswynia5AGF2KeXhwprm8BsmGSFvljnxTKy+Gp6Qyz+dKFsa1+soosSZ976lwIYO6pW7Nu+i7PH+B4YOhit6JKDuEW575FCceo5c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow the GPIO driver to use the previously introduced
pinctrl_gpio_get_direction function to implement its .get_direction
callback.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 6a1b6058b991..2dab52cf119b 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -543,12 +543,25 @@ static int ingenic_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int ingenic_pinmux_gpio_get_direction(struct pinctrl_dev *pctldev,
+		struct pinctrl_gpio_range *range,
+		unsigned int pin)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+
+	if (jzpc->version >= ID_JZ4770)
+		return ingenic_get_pin_config(jzpc, pin, JZ4770_GPIO_PAT1);
+	else
+		return !ingenic_get_pin_config(jzpc, pin, JZ4740_GPIO_DIR);
+}
+
 static const struct pinmux_ops ingenic_pmxops = {
 	.get_functions_count = pinmux_generic_get_function_count,
 	.get_function_name = pinmux_generic_get_function_name,
 	.get_function_groups = pinmux_generic_get_function_groups,
 	.set_mux = ingenic_pinmux_set_mux,
 	.gpio_set_direction = ingenic_pinmux_gpio_set_direction,
+	.gpio_get_direction = ingenic_pinmux_gpio_get_direction,
 };
 
 static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
-- 
2.11.0

