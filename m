Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33975C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0B82177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wymy7v4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0B82177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHUUDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:03:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53958 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbeHUUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:03:44 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/8] pinctrl: ingenic: Implement .get_direction for GPIO chips
Date:   Tue, 21 Aug 2018 18:42:33 +0200
Message-Id: <20180821164236.21101-6-paul@crapouillou.net>
In-Reply-To: <20180821164236.21101-1-paul@crapouillou.net>
References: <20180821164236.21101-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534869766; bh=tRhxcdd8npzEVKHGuYafs8t+RuyApg6MZBYZayQP0pI=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=wymy7v4GvvWE9kB0HJyQh/gmYJv2mhUCl3M4f8kk/DAH1NbTgPu400/749orscLb/xtwt1cxU9uzXU61SL+ZvtyYjvvRvVhr7nk1libpR/mO0hASQjWNLzfE3vLKlTqU1kcFrVFbHmw5C8XX5eX5USd+BXlN7NMjcy7nmA3q+FE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to read from debugfs whether the GPIOs requested are set as
input or output.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

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

