Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE47ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C218B20857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAtlN1ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C218B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbeGSQpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732162AbeGSQpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:50 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD2520856;
        Thu, 19 Jul 2018 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532016120;
        bh=PYEkuazbbieej7kfZSsRKhklgXYa/ZHgDw3X975qgRM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OAtlN1ki/xXzDCWQ9GE2GC5mIFj63hqJFUedCHeK2jSAIfCs0Q0mqtQu9Rm0q6mAu
         3FXrZq7bUjn7+Qxb9Dl02MVbIYKQNKbHjX950Op8arv/E1bgmSxyYQ1j+SudDrTT0p
         CGdTRS+HZHlu7ATpPwlZA3AupZRskTblkDER+3Ms=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 10/10] pinctrl: samsung: Remove legacy API for handling external wakeup interrupts mask
Date:   Thu, 19 Jul 2018 18:00:50 +0200
Message-Id: <20180719160050.22566-11-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the legacy, ugly API of exposing the static value of external
wakeup interrupts mask, because all arch-machine users where converted
to use generic implementation from pinctrl driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 40ef14956876..eec174a65c6f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -325,13 +325,6 @@ int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 	return ret;
 }
 
-static u32 exynos_eint_wake_mask = 0xffffffff;
-
-u32 exynos_get_eint_wake_mask(void)
-{
-	return exynos_eint_wake_mask;
-}
-
 static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
@@ -342,10 +335,9 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 	pr_info("wake %s for irq %d\n", on ? "enabled" : "disabled", irqd->irq);
 
 	if (!on)
-		exynos_eint_wake_mask |= bit;
+		our_chip->eint_wake_mask_value |= bit;
 	else
-		exynos_eint_wake_mask &= ~bit;
-	our_chip->eint_wake_mask_value = exynos_eint_wake_mask;
+		our_chip->eint_wake_mask_value &= ~bit;
 
 	return 0;
 }
-- 
2.14.1

