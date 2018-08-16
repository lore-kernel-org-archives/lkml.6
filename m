Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AFC20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nrbMVpQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AFC20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404459AbeHPTfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:35:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42994 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404443AbeHPTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:35:28 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/7] pinctrl: ingenic: Implement .get_direction for GPIO chips
Date:   Thu, 16 Aug 2018 18:35:41 +0200
Message-Id: <20180816163544.9072-4-paul@crapouillou.net>
In-Reply-To: <20180816163544.9072-1-paul@crapouillou.net>
References: <20180816163544.9072-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534437353; bh=meXFoKDD4BoK3mXDaPLXBulcGpliJGlPX+UIzuvtSaQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nrbMVpQjCRFE5pufsT37C44cO7gb9JLUfXvUzuUQNQIk5JvHNnpW/QDgg6nwN4/aanUVINulso6kkh6U9l+bCv3xz7lDIv0hWPEwbctoFgHhuP2oPFQVIuUdtxZinWhzJckmnqzJ6mdDhNIRGlV3/vv9h7uZ1UOJ9/sEkNqWR5w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to read from debugfs whether the GPIOs requested are set as
input or output.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 75115733144e..f4aa7d4529e8 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -699,6 +699,21 @@ static inline bool ingenic_get_pin_config(struct ingenic_pinctrl *jzpc,
 	return val & BIT(idx);
 }
 
+static int ingenic_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	struct ingenic_pinctrl *jzpc = jzgc->jzpc;
+	unsigned int pin = gc->base + offset;
+
+	if (jzpc->version >= ID_JZ4770)
+		return ingenic_get_pin_config(jzpc, pin, JZ4770_GPIO_PAT1);
+
+	if (ingenic_get_pin_config(jzpc, pin, JZ4740_GPIO_SELECT))
+		return true;
+
+	return !ingenic_get_pin_config(jzpc, pin, JZ4740_GPIO_DIR);
+}
+
 static const struct pinctrl_ops ingenic_pctlops = {
 	.get_groups_count = pinctrl_generic_get_group_count,
 	.get_group_name = pinctrl_generic_get_group_name,
@@ -1003,6 +1018,7 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 	jzgc->gc.get = ingenic_gpio_get;
 	jzgc->gc.direction_input = ingenic_gpio_direction_input;
 	jzgc->gc.direction_output = ingenic_gpio_direction_output;
+	jzgc->gc.get_direction = ingenic_gpio_get_direction;
 
 	if (of_property_read_bool(node, "gpio-ranges")) {
 		jzgc->gc.request = gpiochip_generic_request;
-- 
2.11.0

