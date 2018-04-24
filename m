Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeDXOiU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:38:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756030AbeDXOgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:25 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] genirq/debugfs: Use irq_print_chip method if available
Date: Tue, 24 Apr 2018 15:36:13 +0100
Message-Id: <20180424143618.16073-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180424143618.16073-1-marc.zyngier@arm.com>
References: <20180424143618.16073-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an irqchip has provided an irq_print_chip method, let's use
it instead of the name field directly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/debugfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index da41150322e1..50e324110271 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -69,7 +69,13 @@ irq_debug_show_chip(struct seq_file *m, struct irq_data *data, int ind)
 		seq_printf(m, "chip: None\n");
 		return;
 	}
-	seq_printf(m, "%*schip:    %s\n", ind, "", chip->name);
+	seq_printf(m, "%*schip:    ", ind, "");
+	if (chip->irq_print_chip) {
+		chip->irq_print_chip(data, m);
+		seq_printf(m, "\n");
+	} else {
+		seq_printf(m, "%s\n", chip->name);
+	}
 	seq_printf(m, "%*sflags:   0x%lx\n", ind + 1, "", chip->flags);
 	irq_debug_show_bits(m, ind, chip->flags, irqchip_flags,
 			    ARRAY_SIZE(irqchip_flags));
-- 
2.14.2
