Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeDXOlh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:41:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54458 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756025AbeDXOgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:24 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] genirq/debugfs: Print percpu affinity for percpu_devid interrupts
Date: Tue, 24 Apr 2018 15:36:12 +0100
Message-Id: <20180424143618.16073-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180424143618.16073-1-marc.zyngier@arm.com>
References: <20180424143618.16073-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_devid interrupts have their affinities stored in a different
field. Let's special-case it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 4dadeb3d6666..da41150322e1 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -32,7 +32,10 @@ static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc)
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct cpumask *msk;
 
-	msk = irq_data_get_affinity_mask(data);
+	if (irq_is_percpu_devid(data->irq))
+		msk = (struct cpumask *)desc->percpu_affinity;
+	else
+		msk = irq_data_get_affinity_mask(data);
 	seq_printf(m, "affinity: %*pbl\n", cpumask_pr_args(msk));
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	msk = irq_data_get_effective_affinity_mask(data);
-- 
2.14.2
