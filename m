Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB96FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849FD2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="eYN4RYCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849FD2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404441AbeHPTf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:35:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42632 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404413AbeHPTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:35:25 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/7] pinctrl: ingenic: Mark probe function as __init
Date:   Thu, 16 Aug 2018 18:35:39 +0200
Message-Id: <20180816163544.9072-2-paul@crapouillou.net>
In-Reply-To: <20180816163544.9072-1-paul@crapouillou.net>
References: <20180816163544.9072-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534437351; bh=uT/Rh5yK/Gm203EbdVbo5bXt/Wr17PnAZEr17W53qRE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eYN4RYCjw9GHTL5RjhhwQ/6R20MBmrfnQDnU0g4fGClaTFaMLNqCn+jUJHVIKxaHpfLoQo0riPFLIq0cIgfJu7sxhZaQwk7jhv8dbMBHW9oDV7T94ymYlNuFVFddcSXvb/rOdM6m0sSRwxElj3nBSsfoSD2joDsc0OEU8snm1ms=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using platform_driver_probe() instead of platform_driver_register(),
we can mark the ingenic_pinctrl_probe() function as __init.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 4bceae88d056..1d6d7c6aecfc 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -717,7 +717,7 @@ static const struct of_device_id ingenic_pinctrl_of_match[] = {
 	{},
 };
 
-static int ingenic_pinctrl_probe(struct platform_device *pdev)
+static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ingenic_pinctrl *jzpc;
@@ -837,14 +837,13 @@ static struct platform_driver ingenic_pinctrl_driver = {
 	.driver = {
 		.name = "pinctrl-ingenic",
 		.of_match_table = of_match_ptr(ingenic_pinctrl_of_match),
-		.suppress_bind_attrs = true,
 	},
-	.probe = ingenic_pinctrl_probe,
 	.id_table = ingenic_pinctrl_ids,
 };
 
 static int __init ingenic_pinctrl_drv_register(void)
 {
-	return platform_driver_register(&ingenic_pinctrl_driver);
+	return platform_driver_probe(&ingenic_pinctrl_driver,
+				     ingenic_pinctrl_probe);
 }
 subsys_initcall(ingenic_pinctrl_drv_register);
-- 
2.11.0

