Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC7CC04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2574C21776
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SWvrWrMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2574C21776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeHUUDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:03:41 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52986 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeHUUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:03:40 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/8] pinctrl: ingenic: Add support for the JZ4725B
Date:   Tue, 21 Aug 2018 18:42:34 +0200
Message-Id: <20180821164236.21101-7-paul@crapouillou.net>
In-Reply-To: <20180821164236.21101-1-paul@crapouillou.net>
References: <20180821164236.21101-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534869767; bh=0SR3p24tYqqMlPTdOgm1O4i19JE0XFCccekBEBazfy8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SWvrWrMBVrNfQDvXk44K15aj3NmAwdMI8RjLO1fzBnjH0TCfSeFkteNZzy6u8gfZaXuJULdWrYsaiVj3OsbB9BbLKPa8DHgVKhHnx7sTHA4lPmd9XlGQfRymWksEqoXWPdo1etJ9z1dih2kWAiOhK9DWfkUQLlSjfaBwPNXamBw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the JZ4725B and compatible SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: - Move dt-bindings doc update to its own patch
        - Remove ingenic,jz4725b-gpio compatible string, since it provided
          no functional difference

 drivers/pinctrl/pinctrl-ingenic.c | 98 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index f4aa7d4529e8..dc7031a2dca7 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -49,6 +49,7 @@
 
 enum jz_version {
 	ID_JZ4740,
+	ID_JZ4725B,
 	ID_JZ4770,
 	ID_JZ4780,
 };
@@ -215,6 +216,99 @@ static const struct ingenic_chip_info jz4740_chip_info = {
 	.pull_downs = jz4740_pull_downs,
 };
 
+static int jz4725b_mmc0_1bit_pins[] = { 0x48, 0x49, 0x5c, };
+static int jz4725b_mmc0_4bit_pins[] = { 0x5d, 0x5b, 0x56, };
+static int jz4725b_mmc1_1bit_pins[] = { 0x7a, 0x7b, 0x7c, };
+static int jz4725b_mmc1_4bit_pins[] = { 0x7d, 0x7e, 0x7f, };
+static int jz4725b_uart_data_pins[] = { 0x4c, 0x4d, };
+static int jz4725b_nand_cs1_pins[] = { 0x55, };
+static int jz4725b_nand_cs2_pins[] = { 0x56, };
+static int jz4725b_nand_cs3_pins[] = { 0x57, };
+static int jz4725b_nand_cs4_pins[] = { 0x58, };
+static int jz4725b_nand_cle_ale_pins[] = { 0x48, 0x49 };
+static int jz4725b_nand_fre_fwe_pins[] = { 0x5c, 0x5d };
+static int jz4725b_pwm_pwm0_pins[] = { 0x4a, };
+static int jz4725b_pwm_pwm1_pins[] = { 0x4b, };
+static int jz4725b_pwm_pwm2_pins[] = { 0x4c, };
+static int jz4725b_pwm_pwm3_pins[] = { 0x4d, };
+static int jz4725b_pwm_pwm4_pins[] = { 0x4e, };
+static int jz4725b_pwm_pwm5_pins[] = { 0x4f, };
+
+static int jz4725b_mmc0_1bit_funcs[] = { 1, 1, 1, };
+static int jz4725b_mmc0_4bit_funcs[] = { 1, 0, 1, };
+static int jz4725b_mmc1_1bit_funcs[] = { 0, 0, 0, };
+static int jz4725b_mmc1_4bit_funcs[] = { 0, 0, 0, };
+static int jz4725b_uart_data_funcs[] = { 1, 1, };
+static int jz4725b_nand_cs1_funcs[] = { 0, };
+static int jz4725b_nand_cs2_funcs[] = { 0, };
+static int jz4725b_nand_cs3_funcs[] = { 0, };
+static int jz4725b_nand_cs4_funcs[] = { 0, };
+static int jz4725b_nand_cle_ale_funcs[] = { 0, 0, };
+static int jz4725b_nand_fre_fwe_funcs[] = { 0, 0, };
+static int jz4725b_pwm_pwm0_funcs[] = { 0, };
+static int jz4725b_pwm_pwm1_funcs[] = { 0, };
+static int jz4725b_pwm_pwm2_funcs[] = { 0, };
+static int jz4725b_pwm_pwm3_funcs[] = { 0, };
+static int jz4725b_pwm_pwm4_funcs[] = { 0, };
+static int jz4725b_pwm_pwm5_funcs[] = { 0, };
+
+static const struct group_desc jz4725b_groups[] = {
+	INGENIC_PIN_GROUP("mmc0-1bit", jz4725b_mmc0_1bit),
+	INGENIC_PIN_GROUP("mmc0-4bit", jz4725b_mmc0_4bit),
+	INGENIC_PIN_GROUP("mmc1-1bit", jz4725b_mmc1_1bit),
+	INGENIC_PIN_GROUP("mmc1-4bit", jz4725b_mmc1_4bit),
+	INGENIC_PIN_GROUP("uart-data", jz4725b_uart_data),
+	INGENIC_PIN_GROUP("nand-cs1", jz4725b_nand_cs1),
+	INGENIC_PIN_GROUP("nand-cs2", jz4725b_nand_cs2),
+	INGENIC_PIN_GROUP("nand-cs3", jz4725b_nand_cs3),
+	INGENIC_PIN_GROUP("nand-cs4", jz4725b_nand_cs4),
+	INGENIC_PIN_GROUP("nand-cle-ale", jz4725b_nand_cle_ale),
+	INGENIC_PIN_GROUP("nand-fre-fwe", jz4725b_nand_fre_fwe),
+	INGENIC_PIN_GROUP("pwm0", jz4725b_pwm_pwm0),
+	INGENIC_PIN_GROUP("pwm1", jz4725b_pwm_pwm1),
+	INGENIC_PIN_GROUP("pwm2", jz4725b_pwm_pwm2),
+	INGENIC_PIN_GROUP("pwm3", jz4725b_pwm_pwm3),
+	INGENIC_PIN_GROUP("pwm4", jz4725b_pwm_pwm4),
+	INGENIC_PIN_GROUP("pwm5", jz4725b_pwm_pwm5),
+};
+
+static const char *jz4725b_mmc0_groups[] = { "mmc0-1bit", "mmc0-4bit", };
+static const char *jz4725b_mmc1_groups[] = { "mmc1-1bit", "mmc1-4bit", };
+static const char *jz4725b_uart_groups[] = { "uart-data", };
+static const char *jz4725b_nand_groups[] = {
+	"nand-cs1", "nand-cs2", "nand-cs3", "nand-cs4",
+	"nand-cle-ale", "nand-fre-fwe",
+};
+static const char *jz4725b_pwm0_groups[] = { "pwm0", };
+static const char *jz4725b_pwm1_groups[] = { "pwm1", };
+static const char *jz4725b_pwm2_groups[] = { "pwm2", };
+static const char *jz4725b_pwm3_groups[] = { "pwm3", };
+static const char *jz4725b_pwm4_groups[] = { "pwm4", };
+static const char *jz4725b_pwm5_groups[] = { "pwm5", };
+
+static const struct function_desc jz4725b_functions[] = {
+	{ "mmc0", jz4725b_mmc0_groups, ARRAY_SIZE(jz4725b_mmc0_groups), },
+	{ "mmc1", jz4725b_mmc1_groups, ARRAY_SIZE(jz4725b_mmc1_groups), },
+	{ "uart", jz4725b_uart_groups, ARRAY_SIZE(jz4725b_uart_groups), },
+	{ "nand", jz4725b_nand_groups, ARRAY_SIZE(jz4725b_nand_groups), },
+	{ "pwm0", jz4725b_pwm0_groups, ARRAY_SIZE(jz4725b_pwm0_groups), },
+	{ "pwm1", jz4725b_pwm1_groups, ARRAY_SIZE(jz4725b_pwm1_groups), },
+	{ "pwm2", jz4725b_pwm2_groups, ARRAY_SIZE(jz4725b_pwm2_groups), },
+	{ "pwm3", jz4725b_pwm3_groups, ARRAY_SIZE(jz4725b_pwm3_groups), },
+	{ "pwm4", jz4725b_pwm4_groups, ARRAY_SIZE(jz4725b_pwm4_groups), },
+	{ "pwm5", jz4725b_pwm5_groups, ARRAY_SIZE(jz4725b_pwm5_groups), },
+};
+
+static const struct ingenic_chip_info jz4725b_chip_info = {
+	.num_chips = 4,
+	.groups = jz4725b_groups,
+	.num_groups = ARRAY_SIZE(jz4725b_groups),
+	.functions = jz4725b_functions,
+	.num_functions = ARRAY_SIZE(jz4725b_functions),
+	.pull_ups = jz4740_pull_ups,
+	.pull_downs = jz4740_pull_downs,
+};
+
 static const u32 jz4770_pull_ups[6] = {
 	0x3fffffff, 0xfff0030c, 0xffffffff, 0xffff4fff, 0xfffffb7c, 0xffa7f00f,
 };
@@ -966,6 +1060,7 @@ static const struct regmap_config ingenic_pinctrl_regmap_config = {
 
 static const struct of_device_id ingenic_pinctrl_of_match[] = {
 	{ .compatible = "ingenic,jz4740-pinctrl", .data = (void *) ID_JZ4740 },
+	{ .compatible = "ingenic,jz4725b-pinctrl", .data = (void *)ID_JZ4725B },
 	{ .compatible = "ingenic,jz4770-pinctrl", .data = (void *) ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-pinctrl", .data = (void *) ID_JZ4780 },
 	{},
@@ -1092,6 +1187,8 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 
 	if (jzpc->version >= ID_JZ4770)
 		chip_info = &jz4770_chip_info;
+	else if (jzpc->version >= ID_JZ4725B)
+		chip_info = &jz4725b_chip_info;
 	else
 		chip_info = &jz4740_chip_info;
 	jzpc->info = chip_info;
@@ -1165,6 +1262,7 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 
 static const struct platform_device_id ingenic_pinctrl_ids[] = {
 	{ "jz4740-pinctrl", ID_JZ4740 },
+	{ "jz4725b-pinctrl", ID_JZ4725B },
 	{ "jz4770-pinctrl", ID_JZ4770 },
 	{ "jz4780-pinctrl", ID_JZ4780 },
 	{},
-- 
2.11.0

