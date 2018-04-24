Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeDXOhl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:37:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54490 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756103AbeDXOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:30 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] irqchip/partition-percpu: Allow chained_desc to be NULL
Date: Tue, 24 Apr 2018 15:36:17 +0100
Message-Id: <20180424143618.16073-7-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180424143618.16073-1-marc.zyngier@arm.com>
References: <20180424143618.16073-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're about to delay the binding of the partionned interrupt
to the underlying irqchip, we can end-up in a situation where
chained_desc will be NULL, and the operation cannot be carried
out.

Let's make sure we don't explode if that happens.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-partition-percpu.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index be0df6e0add9..79a1ef0c0f73 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -33,6 +33,18 @@ struct partition_desc {
 	struct irq_domain_ops		ops;
 };
 
+static struct irq_data *partition_get_irqd_chip(struct partition_desc *part,
+						struct irq_chip **chip)
+{
+	if (part->chained_desc) {
+		*chip = irq_desc_get_chip(part->chained_desc);
+		return irq_desc_get_irq_data(part->chained_desc);
+	}
+
+	*chip = NULL;
+	return NULL;
+}
+
 static bool partition_check_cpu(struct partition_desc *part,
 				unsigned int cpu, unsigned int hwirq)
 {
@@ -45,9 +57,9 @@ static bool partition_check_cpu(struct partition_desc *part,
 	struct irq_data *data;						\
 									\
 	part = irq_data_get_irq_chip_data(d);				\
-	chip = irq_desc_get_chip(part->chained_desc);			\
-	data = irq_desc_get_irq_data(part->chained_desc);		\
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&	\
+	data = partition_get_irqd_chip(part, &chip);			\
+	if (data &&							\
+	    partition_check_cpu(part, smp_processor_id(), d->hwirq) &&	\
 	    chip->method)
 
 #define PART_CALL_METHOD_VOID(method, d, ...)				\
@@ -96,10 +108,12 @@ static int partition_irq_set_type(struct irq_data *d, unsigned int type)
 static void partition_irq_print_chip(struct irq_data *d, struct seq_file *p)
 {
 	struct partition_desc *part = irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
+	struct irq_chip *chip;
+	struct irq_data *data;
 
-	seq_printf(p, " %5s-%lu", chip->name, data->hwirq);
+	data = partition_get_irqd_chip(part, &chip);
+	if (data)
+		seq_printf(p, " %5s-%lu", chip->name, data->hwirq);
 }
 
 static struct irq_chip partition_irq_chip = {
-- 
2.14.2
