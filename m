Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90462C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EAA217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549396765;
	bh=Lmc2QzvU6mlVrbu9yAFloJg089oDSJS72xZtA5Ecs9U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aBnZLD33T4cUVDUC8zB/5FYXl5hAERlByphRnaw+1rW50R1N9YHsDGKxIjMiipQu2
	 tKNFDjNCijafeMD+3GZaeW6NN4nWKeHvjxgDKpvRyhwgU1o/IItWw3IGpjJmVhucoQ
	 1+MMobLzjdQQGNTtx8EQTIwOu9mhwdk+54KfUmO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfBET7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbfBET7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:59:23 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 546012083B;
        Tue,  5 Feb 2019 19:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549396762;
        bh=Lmc2QzvU6mlVrbu9yAFloJg089oDSJS72xZtA5Ecs9U=;
        h=From:To:Cc:Subject:Date:From;
        b=VGdnhplap5z5ZwIRXClS50FCFf/blPWIqOmbeypB2YRKVeAP25CDSvKgi81uuSmy/
         HNauCpsYg+yYp+w2M39XWSgaf4o9/NLJ/EtcRYuRZN9Luph2KAf6gKgZKFuiyCErQ2
         CX2HsO2EWqd2TKOWrzWi88W1Zbi8NNKPKZ0E9m0s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v3] pinctrl: samsung: Remove legacy API for handling external wakeup interrupts mask
Date:   Tue,  5 Feb 2019 20:59:09 +0100
Message-Id: <20190205195909.3565-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the legacy, ugly API of exposing the static value of external
wakeup interrupts mask, because all arch-machine users where converted
to use generic implementation from pinctrl driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

---

Dear Linus,

Could you apply this directly? It is an old cleanup patch, waiting for
dependencies to get into mainline (v5.0-rc1).

Changes since v3:
1. Rebased on latest linux-next.
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index f49ea3d92aa1..ebc27b06718c 100644
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
2.17.1

