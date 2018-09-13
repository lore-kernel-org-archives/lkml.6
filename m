Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36FCC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A54520652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A54520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbeIMTG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:06:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbeIMTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:06:56 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6DE5D0E;
        Thu, 13 Sep 2018 13:57:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 096/197] pinctrl: axp209: Fix NULL pointer dereference after allocation
Date:   Thu, 13 Sep 2018 15:30:45 +0200
Message-Id: <20180913131845.376032824@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 504c76979bccec66e4c2e41f6a006e49e284466f ]

There is no check that allocation in axp20x_funcs_groups_from_mask
is successful.
The patch adds corresponding check and return values.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-axp209.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -316,7 +316,7 @@ static const struct pinctrl_ops axp20x_p
 	.get_group_pins		= axp20x_group_pins,
 };
 
-static void axp20x_funcs_groups_from_mask(struct device *dev, unsigned int mask,
+static int axp20x_funcs_groups_from_mask(struct device *dev, unsigned int mask,
 					  unsigned int mask_len,
 					  struct axp20x_pinctrl_function *func,
 					  const struct pinctrl_pin_desc *pins)
@@ -331,18 +331,22 @@ static void axp20x_funcs_groups_from_mas
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
@@ -366,13 +370,19 @@ static void axp20x_build_funcs_groups(st
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
@@ -424,7 +434,11 @@ static int axp20x_pctl_probe(struct plat
 
 	platform_set_drvdata(pdev, pctl);
 
-	axp20x_build_funcs_groups(pdev);
+	ret = axp20x_build_funcs_groups(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to build groups\n");
+		return ret;
+	}
 
 	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
 	if (!pctrl_desc)


