Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F582C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19532098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19532098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeHZNVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 09:21:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41653 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 09:21:24 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftrVv-0000GT-Tm; Sun, 26 Aug 2018 11:39:20 +0200
Subject: [GIT pull] irq updates for 4.19
Message-ID: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Date:   Sun, 26 Aug 2018 11:39:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

A small set of updats/fixes for the irq subsystem:

 - Allow GICv3 interrupts to be configured as wake-up sources to enable
   wakeup from suspend

 - Make the error handling of the STM32 irqchip init function work

 - A set of small cleanups and improvements

Thanks,

	tglx

------------------>
Dan Carpenter (1):
      irqchip/stm32: Fix init error handling

Fabrizio Castro (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774a1 support

Jonas Gorski (1):
      irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Krzysztof Kozlowski (1):
      irqchip/s3c24xx: Remove unneeded comparison of unsigned long to 0

Marc Zyngier (1):
      irqchip/gic-v3: Allow interrupt to be configured as wake-up sources

Martin Kaiser (1):
      irqchip/tango: Set irq handler and data in one go


 .../bindings/interrupt-controller/renesas,irqc.txt |  1 +
 drivers/irqchip/irq-bcm7038-l1.c                   |  4 ++++
 drivers/irqchip/irq-gic-v3.c                       |  8 +++++--
 drivers/irqchip/irq-s3c24xx.c                      |  2 +-
 drivers/irqchip/irq-stm32-exti.c                   | 25 +++++++++++-----------
 drivers/irqchip/irq-tango.c                        |  3 +--
 6 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index 697ca2f26d1b..a046ed374d80 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -13,6 +13,7 @@ Required properties:
     - "renesas,irqc-r8a7792" (R-Car V2H)
     - "renesas,irqc-r8a7793" (R-Car M2-N)
     - "renesas,irqc-r8a7794" (R-Car E2)
+    - "renesas,intc-ex-r8a774a1" (RZ/G2M)
     - "renesas,intc-ex-r8a7795" (R-Car H3)
     - "renesas,intc-ex-r8a7796" (R-Car M3-W)
     - "renesas,intc-ex-r8a77965" (R-Car M3-N)
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index faf734ff4cf3..0f6e30e9009d 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -217,6 +217,7 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 	return 0;
 }
 
+#ifdef CONFIG_SMP
 static void bcm7038_l1_cpu_offline(struct irq_data *d)
 {
 	struct cpumask *mask = irq_data_get_affinity_mask(d);
@@ -241,6 +242,7 @@ static void bcm7038_l1_cpu_offline(struct irq_data *d)
 	}
 	irq_set_affinity_locked(d, &new_affinity, false);
 }
+#endif
 
 static int __init bcm7038_l1_init_one(struct device_node *dn,
 				      unsigned int idx,
@@ -293,7 +295,9 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
+#ifdef CONFIG_SMP
 	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
+#endif
 };
 
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e214181b77b7..d5912f1ec884 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -861,7 +861,9 @@ static struct irq_chip gic_chip = {
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static struct irq_chip gic_eoimode1_chip = {
@@ -874,7 +876,9 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
 #define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index f6fd57ebe6e6..c19766fe8a1a 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -250,7 +250,7 @@ static int s3c_irqext0_type(struct irq_data *data, unsigned int type)
 	void __iomem *gpcon_reg;
 	unsigned long gpcon_offset, extint_offset;
 
-	if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
+	if (data->hwirq <= 3) {
 		gpcon_reg = S3C2410_GPFCON;
 		extint_reg = S3C24XX_EXTINT0;
 		gpcon_offset = (data->hwirq) * 2;
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 3df527fcf4e1..0a2088e12d96 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -603,17 +603,24 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					sizeof(struct stm32_exti_chip_data),
 					GFP_KERNEL);
 	if (!host_data->chips_data)
-		return NULL;
+		goto free_host_data;
 
 	host_data->base = of_iomap(node, 0);
 	if (!host_data->base) {
 		pr_err("%pOF: Unable to map registers\n", node);
-		return NULL;
+		goto free_chips_data;
 	}
 
 	stm32_host_data = host_data;
 
 	return host_data;
+
+free_chips_data:
+	kfree(host_data->chips_data);
+free_host_data:
+	kfree(host_data);
+
+	return NULL;
 }
 
 static struct
@@ -665,10 +672,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	struct irq_domain *domain;
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
@@ -725,7 +730,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	irq_domain_remove(domain);
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;
@@ -752,10 +756,8 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 	}
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	for (i = 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, node);
@@ -777,7 +779,6 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;
diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index 0c085303a583..580e2d72b9ba 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -205,8 +205,7 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 
 	tangox_irq_domain_init(dom);
 
-	irq_set_chained_handler(irq, tangox_irq_handler);
-	irq_set_handler_data(irq, dom);
+	irq_set_chained_handler_and_data(irq, tangox_irq_handler, dom);
 
 	return 0;
 }

