Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755481AbeDXOhe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:37:34 -0400
Received: from foss.arm.com ([217.140.101.70]:54498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756116AbeDXOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:30 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] irqchip/partition-percpu: Move allocation of chained interrupt to activate
Date: Tue, 24 Apr 2018 15:36:18 +0100
Message-Id: <20180424143618.16073-8-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180424143618.16073-1-marc.zyngier@arm.com>
References: <20180424143618.16073-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The partition-percpu helpers work by tying the real interrupt to an
affinity-driven chained irqchip. So far, all the interrupt that can be
partitionned are being created at boot time.

This is a waste of resource, and means that we need to bypass some of
the critical checks (such as the trigger configuration).

A much better approach would be to create the backing interrupt when
one of the muxed interrupts gets activated, making sure we do things
on demand, and expose the right trigger information to the rest of
the kernel.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c                 | 31 +++++++------------
 drivers/irqchip/irq-partition-percpu.c       | 45 +++++++++++++++++++++++++---
 include/linux/irqchip/irq-partition-percpu.h |  4 +--
 3 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e5d101418390..f4c6d2223191 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -922,8 +922,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -938,7 +936,6 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 			*hwirq = fwspec->param[1] + 32;
 			break;
 		case 1:			/* PPI */
-		case GIC_IRQ_TYPE_PARTITION:
 			*hwirq = fwspec->param[1] + 16;
 			break;
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
@@ -952,10 +949,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		/*
 		 * Make it clear that broken DTs are... broken.
-		 * Partitionned PPIs are an unfortunate exception.
 		 */
-		WARN_ON(*type == IRQ_TYPE_NONE &&
-			fwspec->param[0] != GIC_IRQ_TYPE_PARTITION);
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -1143,6 +1138,12 @@ static int __init gic_validate_dist_version(void __iomem *dist_base)
 	return 0;
 }
 
+static void partition_fwspec_convert(struct irq_fwspec *fwspec)
+{
+	BUG_ON(fwspec->param_count != 4);
+	fwspec->param_count = 3;
+}
+
 /* Create all possible partitions at boot time */
 static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 {
@@ -1207,23 +1208,11 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	}
 
 	for (i = 0; i < 16; i++) {
-		unsigned int irq;
 		struct partition_desc *desc;
-		struct irq_fwspec ppi_fwspec = {
-			.fwnode		= gic_data.fwnode,
-			.param_count	= 3,
-			.param		= {
-				[0]	= GIC_IRQ_TYPE_PARTITION,
-				[1]	= i,
-				[2]	= IRQ_TYPE_NONE,
-			},
-		};
-
-		irq = irq_create_fwspec_mapping(&ppi_fwspec);
-		if (WARN_ON(!irq))
-			continue;
+
 		desc = partition_create_desc(gic_data.fwnode, parts, nr_parts,
-					     irq, &partition_domain_ops);
+					     partition_fwspec_convert,
+					     &partition_domain_ops);
 		if (WARN_ON(!desc))
 			continue;
 
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 79a1ef0c0f73..009ce5c97b05 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -25,12 +25,15 @@
 #include <linux/slab.h>
 
 struct partition_desc {
+	struct mutex			lock;
 	int				nr_parts;
 	struct partition_affinity	*parts;
 	struct irq_domain		*domain;
 	struct irq_desc			*chained_desc;
 	unsigned long			*bitmap;
 	struct irq_domain_ops		ops;
+	struct irq_fwspec		fwspec;
+	void (*convert)(struct irq_fwspec *fwspec);
 };
 
 static struct irq_data *partition_get_irqd_chip(struct partition_desc *part,
@@ -166,9 +169,14 @@ static int partition_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	part = domain->host_data;
 
+	mutex_lock(&part->lock);
+	if (!part->fwspec.param_count) {
+		part->fwspec = *fwspec;
+		part->convert(&part->fwspec);
+	}
+	mutex_unlock(&part->lock);
+
 	set_bit(hwirq, part->bitmap);
-	irq_set_chained_handler_and_data(irq_desc_get_irq(part->chained_desc),
-					 partition_handle_irq, part);
 	irq_set_percpu_devid_partition(virq, &part->parts[hwirq].mask);
 	irq_domain_set_info(domain, virq, hwirq, &partition_irq_chip, part,
 			    handle_percpu_devid_irq, NULL, NULL);
@@ -209,6 +217,32 @@ int partition_translate_id(struct partition_desc *desc, void *partition_id)
 	return i;
 }
 
+static int partition_domain_activate(struct irq_domain *domain,
+				     struct irq_data *d, bool reserve)
+{
+	struct partition_desc *part = irq_data_get_irq_chip_data(d);
+	int ret = 0;
+
+	mutex_lock(&part->lock);
+	if (!part->chained_desc) {
+		unsigned int irq;
+
+		irq = irq_create_fwspec_mapping(&part->fwspec);
+		if (WARN_ON(!irq)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		part->chained_desc = irq_to_desc(irq);
+		irq_set_chained_handler_and_data(irq,
+						 partition_handle_irq,
+						 part);
+	}
+out:
+	mutex_unlock(&part->lock);
+	return ret;
+}
+
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 static atomic_t part_id;
 static char *partition_override_name(struct irq_domain *domain)
@@ -221,7 +255,7 @@ static char *partition_override_name(struct irq_domain *domain)
 struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 					     struct partition_affinity *parts,
 					     int nr_parts,
-					     int chained_irq,
+					     void (*convert)(struct irq_fwspec *fwspec),
 					     const struct irq_domain_ops *ops)
 {
 	struct partition_desc *desc;
@@ -233,12 +267,16 @@ struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 	if (!desc)
 		return NULL;
 
+	mutex_init(&desc->lock);
+
 	desc->ops = *ops;
 	desc->ops.free = partition_domain_free;
 	desc->ops.alloc = partition_domain_alloc;
+	desc->ops.activate = partition_domain_activate;
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	desc->ops.override_name = partition_override_name;
 #endif
+	desc->convert = convert;
 
 	d = irq_domain_create_linear(fwnode, nr_parts, &desc->ops, desc);
 	if (!d)
@@ -250,7 +288,6 @@ struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 	if (WARN_ON(!desc->bitmap))
 		goto out;
 
-	desc->chained_desc = irq_to_desc(chained_irq);
 	desc->nr_parts = nr_parts;
 	desc->parts = parts;
 
diff --git a/include/linux/irqchip/irq-partition-percpu.h b/include/linux/irqchip/irq-partition-percpu.h
index 87433a5d1285..9c408005fa25 100644
--- a/include/linux/irqchip/irq-partition-percpu.h
+++ b/include/linux/irqchip/irq-partition-percpu.h
@@ -31,7 +31,7 @@ int partition_translate_id(struct partition_desc *desc, void *partition_id);
 struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 					     struct partition_affinity *parts,
 					     int nr_parts,
-					     int chained_irq,
+					     void (*convert)(struct irq_fwspec *fwspec),
 					     const struct irq_domain_ops *ops);
 struct irq_domain *partition_get_domain(struct partition_desc *dsc);
 #else
@@ -45,7 +45,7 @@ static inline
 struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 					     struct partition_affinity *parts,
 					     int nr_parts,
-					     int chained_irq,
+					     void (*convert)(struct irq_fwspec *fwspec),
 					     const struct irq_domain_ops *ops)
 {
 	return NULL;
-- 
2.14.2
