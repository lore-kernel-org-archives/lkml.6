Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA70C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C6B20858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C6B20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391419AbeIVBum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:50:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41268 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391371AbeIVBum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41C101596;
        Fri, 21 Sep 2018 13:00:18 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EACEA3F5BD;
        Fri, 21 Sep 2018 13:00:17 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 01/10] irqchip/gic-v3-its: Change initialization ordering for LPIs
Date:   Fri, 21 Sep 2018 20:59:45 +0100
Message-Id: <20180921195954.21574-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently initialize the LPIs (and the ITS) fairly early, even
before the SMP support and the CPU interface. This is a bit odd
(as LPIs are not exactly crutial for the early boot process),
and is going to cause issues when reorganizing the probing code.

Let's move this initialization later.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d5912f1ec884..6232f98ef81b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -653,7 +653,9 @@ early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
 
 static int gic_dist_supports_lpis(void)
 {
-	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;
+	return (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) &&
+		!!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) &&
+		!gicv3_nolpi);
 }
 
 static void gic_cpu_init(void)
@@ -673,10 +675,6 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
-	/* Give LPIs a spin */
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_cpu_init();
-
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
 }
@@ -689,6 +687,10 @@ static void gic_cpu_init(void)
 static int gic_starting_cpu(unsigned int cpu)
 {
 	gic_cpu_init();
+
+	if (gic_dist_supports_lpis())
+		its_cpu_init();
+
 	return 0;
 }
 
@@ -1127,14 +1129,16 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_vlpi_properties();
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_init(handle, &gic_data.rdists, gic_data.domain);
-
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
 	gic_cpu_pm_init();
 
+	if (gic_dist_supports_lpis()) {
+		its_init(handle, &gic_data.rdists, gic_data.domain);
+		its_cpu_init();
+	}
+
 	return 0;
 
 out_free:
-- 
2.18.0

