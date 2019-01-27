Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E9C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F44321473
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfA0LKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:10:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40079 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfA0LKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:10:48 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gniKr-000244-Ie; Sun, 27 Jan 2019 12:10:45 +0100
Subject: [GIT pull] genirq updates for 5.0
Message-ID: <154858736708.17771.12039221093557296917.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 27 Jan 2019 12:10:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

A small set of fixes for the interrupt subsystem:

  - Fix a double increment in the irq descriptor allocator which causes
    that a sanity check is only done for every second affinity mask

  - Add a missing device tree translation in the stm32-exti driver. Without
    that the interrupt association is completely wrong.

  - Initialize the mutex in the GIC-V3 MBI driver

  - Fix the alignment for aliasing devices in the GIC-V3-ITS driver so
    multi MSI allocations work correctly

  - Ensure that the initial affinity of a interrupt is not empty at startup
    time.

  - Drop bogus include in the madera irq chip driver

  - Fix KernelDoc regression

Thanks,

	tglx

------------------>
Huacai Chen (1):
      genirq/irqdesc: Fix double increment in alloc_descs()

Jonathan Corbet (1):
      genirq: Fix the kerneldoc comment for struct irq_affinity_desc

Linus Walleij (1):
      irqchip/madera: Drop GPIO includes

Loic Pallardy (1):
      irqchip/stm32-exti: Add domain translate function

Marc Zyngier (1):
      irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Srinivas Ramana (1):
      genirq: Make sure the initial affinity is not empty

Yang Yingliang (1):
      irqchip/gic-v3-mbi: Fix uninitialized mbi_lock


 drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++++------------
 drivers/irqchip/irq-gic-v3-mbi.c |  2 +-
 drivers/irqchip/irq-madera.c     |  2 --
 drivers/irqchip/irq-stm32-exti.c |  1 +
 include/linux/interrupt.h        |  1 +
 kernel/irq/irqdesc.c             |  2 +-
 kernel/irq/manage.c              |  3 +++
 7 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e992a40f..7f2a45445b00 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2399,13 +2399,14 @@ static void its_free_device(struct its_device *its_dev)
 	kfree(its_dev);
 }
 
-static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
+static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number_t *hwirq)
 {
 	int idx;
 
-	idx = find_first_zero_bit(dev->event_map.lpi_map,
-				  dev->event_map.nr_lpis);
-	if (idx == dev->event_map.nr_lpis)
+	idx = bitmap_find_free_region(dev->event_map.lpi_map,
+				      dev->event_map.nr_lpis,
+				      get_count_order(nvecs));
+	if (idx < 0)
 		return -ENOSPC;
 
 	*hwirq = dev->event_map.lpi_base + idx;
@@ -2501,21 +2502,21 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int err;
 	int i;
 
-	for (i = 0; i < nr_irqs; i++) {
-		err = its_alloc_device_irq(its_dev, &hwirq);
-		if (err)
-			return err;
+	err = its_alloc_device_irq(its_dev, nr_irqs, &hwirq);
+	if (err)
+		return err;
 
-		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq);
+	for (i = 0; i < nr_irqs; i++) {
+		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
 			return err;
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
-					      hwirq, &its_irq_chip, its_dev);
+					      hwirq + i, &its_irq_chip, its_dev);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq + i)));
 		pr_debug("ID:%d pID:%d vID:%d\n",
-			 (int)(hwirq - its_dev->event_map.lpi_base),
-			 (int) hwirq, virq + i);
+			 (int)(hwirq + i - its_dev->event_map.lpi_base),
+			 (int)(hwirq + i), virq + i);
 	}
 
 	return 0;
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index ad70e7c416e3..fbfa7ff6deb1 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -24,7 +24,7 @@ struct mbi_range {
 	unsigned long		*bm;
 };
 
-static struct mutex		mbi_lock;
+static DEFINE_MUTEX(mbi_lock);
 static phys_addr_t		mbi_phys_base;
 static struct mbi_range		*mbi_ranges;
 static unsigned int		mbi_range_nr;
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index e9256dee1a45..8b81271c823c 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -16,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip/irq-madera.h>
 #include <linux/mfd/madera/core.h>
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6edfd4bfa169..a93296b9b45d 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -822,6 +822,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 static const struct irq_domain_ops stm32_exti_h_domain_ops = {
 	.alloc	= stm32_exti_h_domain_alloc,
 	.free	= irq_domain_free_irqs_common,
+	.xlate = irq_domain_xlate_twocell,
 };
 
 static int
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..4a728dba02e2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -260,6 +260,7 @@ struct irq_affinity {
 /**
  * struct irq_affinity_desc - Interrupt affinity descriptor
  * @mask:	cpumask to hold the affinity assignment
+ * @is_managed: 1 if the interrupt is managed internally
  */
 struct irq_affinity_desc {
 	struct cpumask	mask;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index ee062b7939d3..ef8ad36cadcf 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -457,7 +457,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 
 	/* Validate affinity mask(s) */
 	if (affinity) {
-		for (i = 0; i < cnt; i++, i++) {
+		for (i = 0; i < cnt; i++) {
 			if (cpumask_empty(&affinity[i].mask))
 				return -EINVAL;
 		}
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a4888ce4667a..84b54a17b95d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -393,6 +393,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 	}
 
 	cpumask_and(&mask, cpu_online_mask, set);
+	if (cpumask_empty(&mask))
+		cpumask_copy(&mask, cpu_online_mask);
+
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
 

