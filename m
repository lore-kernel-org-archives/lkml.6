Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B263EC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830402084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830402084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeLLQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:48:40 -0500
Received: from foss.arm.com ([217.140.101.70]:44726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeLLQsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:48:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918D980D;
        Wed, 12 Dec 2018 08:48:37 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A7A03F575;
        Wed, 12 Dec 2018 08:48:35 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v7 21/25] irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
Date:   Wed, 12 Dec 2018 16:47:21 +0000
Message-Id: <1544633245-6036-22-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement NMI callbacks for GICv3 irqchip. Install NMI safe handlers
when setting up interrupt line as NMI.

Only SPIs and PPIs are allowed to be set up as NMI.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b9a00364..d730dae 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 
 #include <linux/irqchip.h>
@@ -90,6 +91,9 @@ struct gic_chip_data {
  */
 static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
+/* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
+static refcount_t ppi_nmi_refs[16];
+
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
 
@@ -314,6 +318,72 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int gic_irq_nmi_setup(struct irq_data *d)
+{
+	struct irq_desc *desc = irq_to_desc(d->irq);
+
+	if (!gic_supports_nmi())
+		return -EINVAL;
+
+	if (gic_peek_irq(d, GICD_ISENABLER)) {
+		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
+		return -EINVAL;
+	}
+
+	/*
+	 * A secondary irq_chip should be in charge of LPI request,
+	 * it should not be possible to get there
+	 */
+	if (WARN_ON(gic_irq(d) >= 8192))
+		return -EINVAL;
+
+	/* desc lock should already be held */
+	if (gic_irq(d) < 32) {
+		/* Setting up PPI as NMI, only switch handler for first NMI */
+		if (!refcount_inc_not_zero(&ppi_nmi_refs[gic_irq(d) - 16])) {
+			refcount_set(&ppi_nmi_refs[gic_irq(d) - 16], 1);
+			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
+		}
+	} else {
+		desc->handle_irq = handle_fasteoi_nmi;
+	}
+
+	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_NMI_PRI);
+
+	return 0;
+}
+
+static void gic_irq_nmi_teardown(struct irq_data *d)
+{
+	struct irq_desc *desc = irq_to_desc(d->irq);
+
+	if (WARN_ON(!gic_supports_nmi()))
+		return;
+
+	if (gic_peek_irq(d, GICD_ISENABLER)) {
+		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
+		return;
+	}
+
+	/*
+	 * A secondary irq_chip should be in charge of LPI request,
+	 * it should not be possible to get there
+	 */
+	if (WARN_ON(gic_irq(d) >= 8192))
+		return;
+
+	/* desc lock should already be held */
+	if (gic_irq(d) < 32) {
+		/* Tearing down NMI, only switch handler for last NMI */
+		if (refcount_dec_and_test(&ppi_nmi_refs[gic_irq(d) - 16]))
+			desc->handle_irq = handle_percpu_devid_irq;
+	} else {
+		desc->handle_irq = handle_fasteoi_irq;
+	}
+
+	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_DEF_PRI);
+}
+
 static void gic_eoi_irq(struct irq_data *d)
 {
 	gic_write_eoir(gic_irq(d));
@@ -952,6 +1022,8 @@ static inline void gic_cpu_pm_init(void) { }
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
+	.irq_nmi_setup		= gic_irq_nmi_setup,
+	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -967,6 +1039,8 @@ static inline void gic_cpu_pm_init(void) { }
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
+	.irq_nmi_setup		= gic_irq_nmi_setup,
+	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1161,7 +1235,17 @@ static int partition_domain_translate(struct irq_domain *d,
 
 static void gic_enable_nmi_support(void)
 {
+	int i;
+
+	for (i = 0; i < 16; i++)
+		refcount_set(&ppi_nmi_refs[i], 0);
+
 	static_branch_enable(&supports_pseudo_nmis);
+
+	if (static_branch_likely(&supports_deactivate_key))
+		gic_eoimode1_chip.flags |= IRQCHIP_SUPPORTS_NMI;
+	else
+		gic_chip.flags |= IRQCHIP_SUPPORTS_NMI;
 }
 
 static int __init gic_init_bases(void __iomem *dist_base,
-- 
1.9.1

