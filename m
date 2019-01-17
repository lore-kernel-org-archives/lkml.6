Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B4C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A4320675
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="WmuqrDQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfAQAdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:33:02 -0500
Received: from onstation.org ([52.200.56.107]:54370 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbfAQAdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:33:01 -0500
Received: from localhost.localdomain (mobile-166-171-186-103.mycingular.net [166.171.186.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2707A47;
        Thu, 17 Jan 2019 00:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547685180;
        bh=DOhd3+EH9t72MVHtWrBz7yWQcJOAgDovCJRr56ixHXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmuqrDQqtUHhRD2rIJXqYoTldi3zLiBv3eeYR2oqKgvOibwUNEMbd+G7hWBSFRStI
         Gj8KZGdUXoKlULBEjuSxVuuy0KzIUNFNwOaeJHtC0Q/dB3p61oS+Z8dcnmg/Yq33kZ
         avNRwLYF2eKPBoqiMC1FgjVAlacP1Ci41arTkEsY=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 02/14] pinctrl: qcom: spmi-gpio: add support for three new variants
Date:   Wed, 16 Jan 2019 19:32:22 -0500
Message-Id: <20190117003234.22127-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117003234.22127-1-masneyb@onstation.org>
References: <20190117003234.22127-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for qcom,pm8005-gpio, qcom,pm8998-gpio, and
qcom,pmi8998-gpio. These three variants are already in use in some
arm64 dtsi files. Those boards work since the generic binding
qcom,spmi-gpio is also specified.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v4:
- None

Patch introduced in v4.

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4458d44dfcf6..5f2977982ef1 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1063,10 +1063,13 @@ static int pmic_gpio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id pmic_gpio_of_match[] = {
+	{ .compatible = "qcom,pm8005-gpio" },	/* 4 GPIO's */
 	{ .compatible = "qcom,pm8916-gpio" },	/* 4 GPIO's */
 	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
+	{ .compatible = "qcom,pm8998-gpio" },	/* 26 GPIO's */
+	{ .compatible = "qcom,pmi8998-gpio" },	/* 14 GPIO's */
 	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pms405-gpio" },	/* 12 GPIO's, holes on 1 9 10 */
 	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
-- 
2.17.2

