Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4913F20833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TImCr9U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4913F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIZBX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:23:56 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47938 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeIZBX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:23:56 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8PJEmHs065025;
        Tue, 25 Sep 2018 14:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537902888;
        bh=s11WQKrrbYEJdR2CgMtTdlBi/rq+mjESuMJAzWZEGBw=;
        h=From:To:CC:Subject:Date;
        b=TImCr9U1A1mTPiiBvyUoRv4AXg0brAHMGoYG63j53N3hsqSqvPHNrOhuFO8yP9X/0
         CV6cZRvmlNJs0d7ZfKCYN1pr7WJQSs0SxRfKl4kQPcOn71i605Nx4fMJ3qygpJTQS0
         fHlXN6CSaQ2NowZUIUe1m5GCX7kuDap153XFur64=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PJEmVt000899;
        Tue, 25 Sep 2018 14:14:48 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 14:14:47 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 14:14:48 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PJEliJ004157;
        Tue, 25 Sep 2018 14:14:47 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8PJElx12410;
        Tue, 25 Sep 2018 14:14:47 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: switch to use irq_chip pm runtime
Date:   Tue, 25 Sep 2018 14:14:46 -0500
Message-ID: <20180925191446.31504-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM runtime management can be delegated from OMAP GPIO driver to the IRQ
chip core, since commit be45beb2df69 ("genirq: Add runtime power management
support for IRQ chips") introduces runtime power management support for IRQ
chips.

Hence, drop custom PM runtime support for OMAP GPIO IRQs and switch to IRQ
chip core PM runtime (set irq_chip->parent_device).

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Based on:
 "[PATCHv2 0/3] omap gpio add level idle, cpu_pm and drop runtime_irq_safe"
 https://www.spinics.net/lists/arm-kernel/msg677583.html

 drivers/gpio/gpio-omap.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c0d7ae7..f292796 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -860,26 +860,6 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static void omap_gpio_irq_bus_lock(struct irq_data *data)
-{
-	struct gpio_bank *bank = omap_irq_data_get_bank(data);
-
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->chip.parent);
-}
-
-static void gpio_irq_bus_sync_unlock(struct irq_data *data)
-{
-	struct gpio_bank *bank = omap_irq_data_get_bank(data);
-
-	/*
-	 * If this is the last IRQ to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->chip.parent);
-}
-
 static void omap_gpio_ack_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
@@ -1383,10 +1363,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_unmask = omap_gpio_unmask_irq,
 	irqc->irq_set_type = omap_gpio_irq_type,
 	irqc->irq_set_wake = omap_gpio_wake_enable,
-	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
-	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
 	irqc->name = dev_name(&pdev->dev);
 	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
+	irqc->parent_device = dev;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
-- 
2.10.5

