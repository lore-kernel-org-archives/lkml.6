Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbeDXOgk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:36:40 -0400
Received: from foss.arm.com ([217.140.101.70]:54486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756090AbeDXOg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:28 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] irqchip/partition-percpu: Refactor backend method calling
Date: Tue, 24 Apr 2018 15:36:16 +0100
Message-Id: <20180424143618.16073-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180424143618.16073-1-marc.zyngier@arm.com>
References: <20180424143618.16073-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various methods provided by the partition-percpu irqchip are only
wrappers that end-up calling into the underlying irqchip. As we're
about to change the code a bit, let's start with introducing a set
of helpers that will make that transition much more painless.

No functionnal change.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-partition-percpu.c | 70 +++++++++++++++-------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 229f96ab3e26..be0df6e0add9 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -39,68 +39,58 @@ static bool partition_check_cpu(struct partition_desc *part,
 	return cpumask_test_cpu(cpu, &part->parts[hwirq].mask);
 }
 
+#define PART_IF_METHOD(method, d)					\
+	struct partition_desc *part;					\
+	struct irq_chip *chip;						\
+	struct irq_data *data;						\
+									\
+	part = irq_data_get_irq_chip_data(d);				\
+	chip = irq_desc_get_chip(part->chained_desc);			\
+	data = irq_desc_get_irq_data(part->chained_desc);		\
+	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&	\
+	    chip->method)
+
+#define PART_CALL_METHOD_VOID(method, d, ...)				\
+	do {								\
+		PART_IF_METHOD(method, d)				\
+			chip->method(data, ##__VA_ARGS__);		\
+	} while(0)
+
+#define PART_CALL_METHOD_INT(retval, method, d, ...)			\
+	({								\
+		int ret = retval;					\
+		PART_IF_METHOD(method, d)				\
+			ret = chip->method(data, ##__VA_ARGS__);	\
+		ret;							\
+	})
+
 static void partition_irq_mask(struct irq_data *d)
 {
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_mask)
-		chip->irq_mask(data);
+	PART_CALL_METHOD_VOID(irq_mask, d);
 }
 
 static void partition_irq_unmask(struct irq_data *d)
 {
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_unmask)
-		chip->irq_unmask(data);
+	PART_CALL_METHOD_VOID(irq_unmask, d);
 }
 
 static int partition_irq_set_irqchip_state(struct irq_data *d,
 					   enum irqchip_irq_state which,
 					   bool val)
 {
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_set_irqchip_state)
-		return chip->irq_set_irqchip_state(data, which, val);
-
-	return -EINVAL;
+	return PART_CALL_METHOD_INT(-EINVAL, irq_set_irqchip_state, d, which, val);
 }
 
 static int partition_irq_get_irqchip_state(struct irq_data *d,
 					   enum irqchip_irq_state which,
 					   bool *val)
 {
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_get_irqchip_state)
-		return chip->irq_get_irqchip_state(data, which, val);
-
-	return -EINVAL;
+	return PART_CALL_METHOD_INT(-EINVAL, irq_get_irqchip_state, d, which, val);
 }
 
 static int partition_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
-
-	if (chip->irq_set_type)
-		return chip->irq_set_type(data, type);
-
-	return -EINVAL;
+	return PART_CALL_METHOD_INT(IRQ_SET_MASK_OK_NOCOPY, irq_set_type, d, type);
 }
 
 static void partition_irq_print_chip(struct irq_data *d, struct seq_file *p)
-- 
2.14.2
