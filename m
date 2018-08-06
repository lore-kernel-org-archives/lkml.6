Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00394C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D5121884
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D5121884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbeHFSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:16:50 -0400
Received: from bran.ispras.ru ([83.149.199.196]:34609 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728626AbeHFSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:16:50 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 824E6203C7;
        Mon,  6 Aug 2018 19:07:02 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>, Chen-Yu Tsai <wens@csie.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] pinctrl: axp209: Fix NULL pointer dereference after allocation
Date:   Mon,  6 Aug 2018 19:06:35 +0300
Message-Id: <20180806160635.9293-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no check that allocation in axp20x_funcs_groups_from_mask
is successful.
The patch adds corresponding check and return values.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/pinctrl/pinctrl-axp209.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index a52779f33ad4..afd0b533c40a 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -316,7 +316,7 @@ static const struct pinctrl_ops axp20x_pctrl_ops = {
 	.get_group_pins		= axp20x_group_pins,
 };
 
-static void axp20x_funcs_groups_from_mask(struct device *dev, unsigned int mask,
+static int axp20x_funcs_groups_from_mask(struct device *dev, unsigned int mask,
 					  unsigned int mask_len,
 					  struct axp20x_pinctrl_function *func,
 					  const struct pinctrl_pin_desc *pins)
@@ -331,18 +331,22 @@ static void axp20x_funcs_groups_from_mask(struct device *dev, unsigned int mask,
 		func->groups = devm_kcalloc(dev,
 					    ngroups, sizeof(const char *),
 					    GFP_KERNEL);
+		if (!func->groups)
+			return -ENOMEM;
 		group = func->groups;
 		for_each_set_bit(bit, &mask_cpy, mask_len) {
 			*group = pins[bit].name;
 			group++;
 		}
 	}
+
+	return 0;
 }
 
-static void axp20x_build_funcs_groups(struct platform_device *pdev)
+static int axp20x_build_funcs_groups(struct platform_device *pdev)
 {
 	struct axp20x_pctl *pctl = platform_get_drvdata(pdev);
-	int i, pin, npins = pctl->desc->npins;
+	int i, ret, pin, npins = pctl->desc->npins;
 
 	pctl->funcs[AXP20X_FUNC_GPIO_OUT].name = "gpio_out";
 	pctl->funcs[AXP20X_FUNC_GPIO_OUT].muxval = AXP20X_MUX_GPIO_OUT;
@@ -366,13 +370,19 @@ static void axp20x_build_funcs_groups(struct platform_device *pdev)
 			pctl->funcs[i].groups[pin] = pctl->desc->pins[pin].name;
 	}
 
-	axp20x_funcs_groups_from_mask(&pdev->dev, pctl->desc->ldo_mask,
+	ret = axp20x_funcs_groups_from_mask(&pdev->dev, pctl->desc->ldo_mask,
 				      npins, &pctl->funcs[AXP20X_FUNC_LDO],
 				      pctl->desc->pins);
+	if (ret)
+		return ret;
 
-	axp20x_funcs_groups_from_mask(&pdev->dev, pctl->desc->adc_mask,
+	ret = axp20x_funcs_groups_from_mask(&pdev->dev, pctl->desc->adc_mask,
 				      npins, &pctl->funcs[AXP20X_FUNC_ADC],
 				      pctl->desc->pins);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static const struct of_device_id axp20x_pctl_match[] = {
@@ -424,7 +434,11 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pctl);
 
-	axp20x_build_funcs_groups(pdev);
+	ret = axp20x_build_funcs_groups(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to build groups\n");
+		return ret;
+	}
 
 	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
 	if (!pctrl_desc)
-- 
2.18.0

