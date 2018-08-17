Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D40C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4142188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M4ciEgA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4142188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeHRCxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 22:53:23 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:57838 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbeHRCxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 22:53:23 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id AF75E30C04E;
        Fri, 17 Aug 2018 16:47:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com AF75E30C04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1534549676;
        bh=em0aFiRqn82cVDEOLrPMM2mkacS1Ivlrwh1OBAO0E68=;
        h=From:To:Cc:Subject:Date:From;
        b=M4ciEgA3N8ZLOyTw0EboQdUGatTay/awNL9rRTTIXfqgir2HfRHNqUME1zZUcJ8rh
         gIcgcwB4/Yhzy86kDtKlGARRRDB+iTVfT3KJ5B1odoI/ZsN2Ha++dzc+U4zEroaAE6
         ZiiHfq31h/hBaRc9zoJ1mUcbFo4hM0N+FRUQdt8g=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 468F0AC071D;
        Fri, 17 Aug 2018 16:47:57 -0700 (PDT)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id 349C927F3D0; Fri, 17 Aug 2018 16:47:57 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     linux-gpio@vger.kernel.org
Cc:     gregory.0xf0@gmail.com, linus.walleij@linaro.org,
        computersforpeace@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v2] gpio: brcmstb: allow 0 width GPIO banks
Date:   Fri, 17 Aug 2018 16:47:39 -0700
Message-Id: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
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

Also remove "GPIO registered" dev print. This information is misleading
since the incremented banks and gpio_base do not reflect the actual GPIOs
that get initialized. We leave this information out since it is already
printed with dev_dbg.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 16c7f9f..af936dc 100644
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
2.7.4

