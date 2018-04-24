Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeDXOiR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:38:17 -0400
Received: from foss.arm.com ([217.140.101.70]:54476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756040AbeDXOg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:26 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] genirq/debugfs: Allow irq domain name to be overriden
Date: Tue, 24 Apr 2018 15:36:14 +0100
Message-Id: <20180424143618.16073-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180424143618.16073-1-marc.zyngier@arm.com>
References: <20180424143618.16073-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for irqchip, it would be useful for a domain to generate its
name dynamically, and thus control the name that gets used in
debugfs.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h |  1 +
 kernel/irq/irqdomain.c    | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 48c7e86bb556..a912b1cc1715 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -119,6 +119,7 @@ struct irq_domain_ops {
 			 unsigned long *out_hwirq, unsigned int *out_type);
 #endif
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	char *(*override_name)(struct irq_domain *d);
 	void (*debug_show)(struct seq_file *m, struct irq_domain *d,
 			   struct irq_data *irqd, int ind);
 #endif
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5d9fc01b60a6..521065c8bace 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -220,6 +220,20 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 	domain->revmap_direct_max_irq = direct_max;
 	irq_domain_check_hierarchy(domain);
 
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	if (domain->ops->override_name) {
+		char *new_name;
+
+		new_name = domain->ops->override_name(domain);
+		if (new_name) {
+			if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+				kfree(domain->name);
+			domain->name = new_name;
+			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+		}
+	}
+#endif
+
 	mutex_lock(&irq_domain_mutex);
 	debugfs_add_domain_dir(domain);
 	list_add(&domain->link, &irq_domain_list);
-- 
2.14.2
