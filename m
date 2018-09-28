Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E40C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980F2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QKlBmADZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C980F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeI2EFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:05:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55940 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeI2EFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:05:33 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8SLdqV0126812;
        Fri, 28 Sep 2018 16:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538170792;
        bh=3GRyt6PnhXCI2UoyqXCCEkckUvU2iLy6jvv9V0k0qOU=;
        h=From:To:CC:Subject:Date;
        b=QKlBmADZuKgJ7DHwVSIDflhSSjNNsmcNWcT4j+ut7b69j0+Ss+qSCZIyTcxUtQK8a
         i+pz5iNe/31Pj/2PY1cO1ZrN+Ukj+cm3BYg1ah90lFhauBh0uhE5uEjQA85ixeYpIi
         eXLLBXZjLGpqKplsZy1NlQhkUpv/mm6eyS6Astt8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SLdquh010918;
        Fri, 28 Sep 2018 16:39:52 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 16:39:51 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 16:39:52 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SLdpkb021735;
        Fri, 28 Sep 2018 16:39:51 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8SLdpx12683;
        Fri, 28 Sep 2018 16:39:51 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: get rid of the conditional PM runtime calls
Date:   Fri, 28 Sep 2018 16:39:50 -0500
Message-ID: <20180928213950.27415-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP GPIO driver is checking !BANK_USED() used condition before calling PM
runtime API, because of PM runtime calls in
omap2_gpio_prepare/resume_for_idle(). It's not required any more since
"omap gpio add level idle, cpu_pm and drop runtime_irq_safe" series [1]
from Tony Lindgren was accepted and PM runtime management was enabled in
IRQ chip core by commit be45beb2df69 ("genirq: Add runtime power management
support for IRQ chips") .

As result safely drop !BANK_USED() checks from omap_gpio_request/free(),
omap_gpio_irq_bus_lock/unlock() and enable PM runtime management for OMAP
GPIO IRQ chip.

[1] https://www.spinics.net/lists/arm-kernel/msg677583.html
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 287c933..c081f39 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -702,12 +702,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	/*
-	 * If this is the first gpio_request for the bank,
-	 * enable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(chip->parent);
+	pm_runtime_get_sync(chip->parent);
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_enable_gpio_module(bank, offset);
@@ -731,12 +726,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	omap_disable_gpio_module(bank, offset);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
-	/*
-	 * If this is the last gpio to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(chip->parent);
+	pm_runtime_put(chip->parent);
 }
 
 /*
@@ -862,20 +852,14 @@ static void omap_gpio_irq_bus_lock(struct irq_data *data)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(data);
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->chip.parent);
+	pm_runtime_get_sync(bank->chip.parent);
 }
 
 static void gpio_irq_bus_sync_unlock(struct irq_data *data)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(data);
 
-	/*
-	 * If this is the last IRQ to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->chip.parent);
+	pm_runtime_put(bank->chip.parent);
 }
 
 static void omap_gpio_ack_irq(struct irq_data *d)
@@ -1385,6 +1369,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
 	irqc->name = dev_name(&pdev->dev);
 	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
+	irqc->parent_device = dev;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
-- 
2.10.5

