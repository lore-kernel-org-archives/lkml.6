Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED03EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B300C20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vzqhX4CG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B300C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbeKAIf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbeKAIJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A0E2081B;
        Wed, 31 Oct 2018 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027336;
        bh=xXl0T0UaSbTCJv8rNceggG65O/Iizv3+FBKTy9tKiOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzqhX4CGIQNMSAd8zsyLPoRl9uTIYquEVHZtm5NwjCtdgdotxm6oeXuUNvPtsSfpc
         +PbOd2D0phdorlkuQUTj34XbaQ7IOGUw9aMVrEEXtjViV3C3tUjf1qOJ6SjgG6i4Rk
         SuuXl6q3WcNZU/n9R6IlzfN3NBrfvGE6DJvF/rUM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 067/126] gpio: brcmstb: allow 0 width GPIO banks
Date:   Wed, 31 Oct 2018 19:06:55 -0400
Message-Id: <20181031230754.29029-67-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

[ Upstream commit bfba223dcc4548632d8f3bfd15690a86d4c68504 ]

Sometimes we have empty banks within the GPIO block. This commit allows
proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
incrementing the bank and number of GPIOs, but not initializing them.
This will mean a call into the non-existent GPIOs will return an error.

Also remove "GPIO registered" dev print. This information is misleading
since the incremented banks and gpio_base do not reflect the actual GPIOs
that get initialized. We leave this information out since it is already
printed with dev_dbg.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-brcmstb.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 16c7f9f49416..af936dcca659 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -664,6 +664,18 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		struct brcmstb_gpio_bank *bank;
 		struct gpio_chip *gc;
 
+		/*
+		 * If bank_width is 0, then there is an empty bank in the
+		 * register block. Special handling for this case.
+		 */
+		if (bank_width == 0) {
+			dev_dbg(dev, "Width 0 found: Empty bank @ %d\n",
+				num_banks);
+			num_banks++;
+			gpio_base += MAX_GPIO_PER_BANK;
+			continue;
+		}
+
 		bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
 		if (!bank) {
 			err = -ENOMEM;
@@ -740,9 +752,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			goto fail;
 	}
 
-	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
-			num_banks, priv->gpio_base, gpio_base - 1);
-
 	if (priv->parent_wake_irq && need_wakeup_event)
 		pm_wakeup_event(dev, 0);
 
-- 
2.17.1

