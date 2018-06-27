Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59753C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074C824056
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ClUiUaAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074C824056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeF0LzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:55:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35980 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbeF0LzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:55:03 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] pinctrl: ingenic: Fix inverted direction for < JZ4770
Date:   Wed, 27 Jun 2018 13:49:02 +0200
Message-Id: <20180627114904.10890-4-paul@crapouillou.net>
In-Reply-To: <20180627114904.10890-1-paul@crapouillou.net>
References: <20180627114904.10890-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530100165; bh=jf2rBtm8BZJxURIHPbWIOrZgESo7nHCDqq/3xhi7g8k=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ClUiUaAP/gWUdYGyNbOsAu3wuMq5sdm4e+vs1cDZvjuPtzy3CDgAqR4PkMC3PBe4xlKXC/SkuSvAKNVHoVHSiVLL1YZII2esJq6aavLLY8pr3qDBdifN7PUraTB33q7vAR5dGPmlxDsv+v7MjYrU/jgasss3Hee3Zzzm65Lbm1k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .gpio_set_direction() callback was setting inverted direction
for SoCs older than the JZ4770, this restores the correct behaviour.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index a1d7156d0a43..6a1b6058b991 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -536,7 +536,7 @@ static int ingenic_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 		ingenic_config_pin(jzpc, pin, JZ4770_GPIO_PAT1, input);
 	} else {
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_SELECT, false);
-		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_DIR, input);
+		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_DIR, !input);
 		ingenic_config_pin(jzpc, pin, JZ4740_GPIO_FUNC, false);
 	}
 
-- 
2.11.0

