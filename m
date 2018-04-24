Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756176AbeDXOgd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:36:33 -0400
Received: from foss.arm.com ([217.140.101.70]:54482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbeDXOg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:27 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] irqchip/partition-percpu: Override domain name in debugfs
Date: Tue, 24 Apr 2018 15:36:15 +0100
Message-Id: <20180424143618.16073-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180424143618.16073-1-marc.zyngier@arm.com>
References: <20180424143618.16073-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, domain names that implement a percpu_devid partition
inherit the main domain name, which leads to conflicts in debugfs
and results in the absence of important data.

Let's provide a callback that will repaint the default name, and
keep all the data available.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-partition-percpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index ccd72c2cbc23..229f96ab3e26 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -205,6 +205,15 @@ int partition_translate_id(struct partition_desc *desc, void *partition_id)
 	return i;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static atomic_t part_id;
+static char *partition_override_name(struct irq_domain *domain)
+{
+	return kasprintf(GFP_KERNEL, "%s-part-%d",
+			 domain->name, atomic_fetch_inc(&part_id));
+}
+#endif
+
 struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 					     struct partition_affinity *parts,
 					     int nr_parts,
@@ -223,6 +232,9 @@ struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 	desc->ops = *ops;
 	desc->ops.free = partition_domain_free;
 	desc->ops.alloc = partition_domain_alloc;
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	desc->ops.override_name = partition_override_name;
+#endif
 
 	d = irq_domain_create_linear(fwnode, nr_parts, &desc->ops, desc);
 	if (!d)
-- 
2.14.2
