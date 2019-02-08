Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4693C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C1721939
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="aye5mrAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBHCQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:16:52 -0500
Received: from onstation.org ([52.200.56.107]:34938 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfBHCQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:50 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 037DB3FF;
        Fri,  8 Feb 2019 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592209;
        bh=G+STzCYvGLFFDa/YIqkYWcyjUaP0wG3FoPN6+RvetTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aye5mrAlWI7xBuvASIWTDgeQ5l9YntwPCFBvSMv30sXJB9OEgvS/LtyZ/0ILJ2L3z
         zcoxwsv30M5ohY62XchE+FQ8izx61mWsXeGUo/lVI1v6zhsuJ8irIT9QzmJ31alBkK
         wmxuFvIeE1RizvKB/SaZ3AMTkMjEqyTohhABfV1g=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 01/11] pinctrl: qcom: ssbi-gpio: hardcode IRQ counts
Date:   Thu,  7 Feb 2019 21:16:21 -0500
Message-Id: <20190208021631.30252-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probing of this driver calls platform_irq_count, which will
setup all of the IRQs that are configured in device tree. In
preparation for converting this driver to be a hierarchical IRQ
chip, hardcode the IRQ count based on the hardware type so that all
the IRQs are not configured immediately and are configured on an
as-needed basis later in the boot process. This change will also
allow for the removal of the interrupts property later in this
patch series once the hierarchical IRQ chip support is in.

This patch also removes the generic qcom,ssbi-gpio OF match since we
don't know the number of pins. All of the existing upstream bindings
already include the more-specific binding.

This change was tested on an APQ8060 DragonBoard.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes since v1:
- Added pctrl->dev back that was mistakenly removed
- Removed npins local variable from _probe(); populate pctrl->npins
  directly.

 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index ded7d765af2e..23641e4d4521 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -665,12 +665,11 @@ static int pm8xxx_pin_populate(struct pm8xxx_gpio *pctrl,
 }
 
 static const struct of_device_id pm8xxx_gpio_of_match[] = {
-	{ .compatible = "qcom,pm8018-gpio" },
-	{ .compatible = "qcom,pm8038-gpio" },
-	{ .compatible = "qcom,pm8058-gpio" },
-	{ .compatible = "qcom,pm8917-gpio" },
-	{ .compatible = "qcom,pm8921-gpio" },
-	{ .compatible = "qcom,ssbi-gpio" },
+	{ .compatible = "qcom,pm8018-gpio", .data = (void *) 6 },
+	{ .compatible = "qcom,pm8038-gpio", .data = (void *) 12 },
+	{ .compatible = "qcom,pm8058-gpio", .data = (void *) 44 },
+	{ .compatible = "qcom,pm8917-gpio", .data = (void *) 38 },
+	{ .compatible = "qcom,pm8921-gpio", .data = (void *) 44 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_gpio_of_match);
@@ -680,20 +679,14 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 	struct pm8xxx_pin_data *pin_data;
 	struct pinctrl_pin_desc *pins;
 	struct pm8xxx_gpio *pctrl;
-	int ret;
-	int i, npins;
+	int ret, i;
 
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
 
 	pctrl->dev = &pdev->dev;
-	npins = platform_irq_count(pdev);
-	if (!npins)
-		return -EINVAL;
-	if (npins < 0)
-		return npins;
-	pctrl->npins = npins;
+	pctrl->npins = (uintptr_t) device_get_match_data(&pdev->dev);
 
 	pctrl->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!pctrl->regmap) {
-- 
2.17.2

