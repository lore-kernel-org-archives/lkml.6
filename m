Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DDDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DD020854
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Te/jEkkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfAMPrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:47:48 -0500
Received: from onstation.org ([52.200.56.107]:42682 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfAMPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:47:42 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 50BB87EA;
        Sun, 13 Jan 2019 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547394461;
        bh=z1V3Re5izjinXi+80x4D/aE6gNnCHVzBiTyXPv3SsNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Te/jEkkG4hhEtVbAeYtAKzTqNnAM/a1y06SIy3w1kUONWvJGwkTXWP2YiE7yE5HwT
         Cd02jcWBflqk3pLCdZ0ZKIVH84x/nu22O++qgtxJwc2230us+RAukV3NNYTHETuaQn
         5+ucpAlH/NrOZPjEHb19643sAu7qLKU4WTCscUjI=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 03/14] pinctrl: qcom: spmi-gpio: hardcode IRQ counts
Date:   Sun, 13 Jan 2019 10:47:05 -0500
Message-Id: <20190113154716.5145-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190113154716.5145-1-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org>
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

This patch also removes the generic qcom,spmi-gpio OF match since we
don't know the number of pins. All of the existing upstream bindings
already include the more-specific binding.

The pm8941 code was tested on a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v3:
- More variants are now included. I missed these since I searched for
  qcom,spmi-gpio in the arm dts, and missed the ones in the arm64 dts.

Changes since v2:
- Don't move pmic_gpio_of_match block. Use device_get_match_data instead
  of of_match_device.
- Correct build warning on arm64: warning: cast from pointer to integer
  of different size

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 28 ++++++++++--------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 5f2977982ef1..b74c44357e8a 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -951,13 +951,7 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	npins = platform_irq_count(pdev);
-	if (!npins)
-		return -EINVAL;
-	if (npins < 0)
-		return npins;
-
-	BUG_ON(npins > ARRAY_SIZE(pmic_gpio_groups));
+	npins = (u16)(uintptr_t) device_get_match_data(&pdev->dev);
 
 	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
@@ -1063,16 +1057,16 @@ static int pmic_gpio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id pmic_gpio_of_match[] = {
-	{ .compatible = "qcom,pm8005-gpio" },	/* 4 GPIO's */
-	{ .compatible = "qcom,pm8916-gpio" },	/* 4 GPIO's */
-	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
-	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio" },	/* 26 GPIO's */
-	{ .compatible = "qcom,pmi8998-gpio" },	/* 14 GPIO's */
-	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pms405-gpio" },	/* 12 GPIO's, holes on 1 9 10 */
-	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
+	{ .compatible = "qcom,pm8005-gpio", .data = (void *) 4 },
+	{ .compatible = "qcom,pm8916-gpio", .data = (void *) 4 },
+	{ .compatible = "qcom,pm8941-gpio", .data = (void *) 36 },
+	{ .compatible = "qcom,pm8994-gpio", .data = (void *) 22 },
+	{ .compatible = "qcom,pmi8994-gpio", .data = (void *) 10 },
+	{ .compatible = "qcom,pm8998-gpio", .data = (void *) 26 },
+	{ .compatible = "qcom,pmi8998-gpio", .data = (void *) 14 },
+	{ .compatible = "qcom,pma8084-gpio", .data = (void *) 22 },
+	/* pms405 has 12 GPIOs with holes on 1, 9, and 10 */
+	{ .compatible = "qcom,pms405-gpio", .data = (void *) 12 },
 	{ },
 };
 
-- 
2.17.2

