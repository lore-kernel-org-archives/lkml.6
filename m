Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E305121721
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SPYdhqby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E305121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHOCdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:33:42 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43732 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbeHOCdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:33:42 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 633CF30C075;
        Tue, 14 Aug 2018 16:44:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 633CF30C075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1534290248;
        bh=IX+4ea/Q3fKYpSOurHAqiHra49GeAkVfHB6TNiMTsZY=;
        h=From:To:Cc:Subject:Date:From;
        b=SPYdhqby3daC5XAMgxp/Tv4VT7oWB+IQAp7HfKV/0U8K/bUO2u1RqesPVYFe3Izg+
         4kDNgbL2veanaVS+eQ/zTa64IiIQCQfhNsKOe29O9gE+KcHotOVAK1b57ltZFoIH2d
         m5Hzo+6dOYSwMahvg4IFIt/kSWxxsHzekCvYga5s=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 89D92AC07C5;
        Tue, 14 Aug 2018 16:44:09 -0700 (PDT)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id AF6A727F3D0; Tue, 14 Aug 2018 16:32:07 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        computersforpeace@gmail.com, linus.walleij@linaro.org,
        gregory.0xf0@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] gpio: brcmstb: allow 0 width GPIO banks
Date:   Tue, 14 Aug 2018 16:31:57 -0700
Message-Id: <1534289517-1805-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Sometimes we have empty banks within the GPIO block. This commit allows
proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
incrementing the bank and number of GPIOs, but not initializing them.
This will mean a call into the non-existent GPIOs will return an error.

Also remove banks and GPIO information from the dev_info print. This
information is misleading since the incremented banks and gpio_base do
not reflect the actual GPIOs that got initialized. We leave this
information out since it is already printed with dev_dbg.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 16c7f9f..8658910 100644
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
+					num_banks);
+			num_banks++;
+			gpio_base += MAX_GPIO_PER_BANK;
+			continue;
+		}
+
 		bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
 		if (!bank) {
 			err = -ENOMEM;
@@ -740,8 +752,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			goto fail;
 	}
 
-	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
-			num_banks, priv->gpio_base, gpio_base - 1);
+	dev_info(dev, "Brcmstb GPIO registered\n");
 
 	if (priv->parent_wake_irq && need_wakeup_event)
 		pm_wakeup_event(dev, 0);
-- 
2.7.4

