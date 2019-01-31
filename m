Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FABC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADDB20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfAaOyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:54:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732138AbfAaOyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:54:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15C315AD;
        Thu, 31 Jan 2019 06:54:21 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 838AC3F59C;
        Thu, 31 Jan 2019 06:54:20 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v6 3/4] genirq: Provide NMI handlers
Date:   Thu, 31 Jan 2019 14:54:00 +0000
Message-Id: <1548946441-38546-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
References: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide flow handlers that are NMI safe for interrupts and percpu_devid
interrupts.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/irq.h |  3 +++
 kernel/irq/chip.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a7298e4..5e91f6b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -601,6 +601,9 @@ static inline int irq_set_parent(int irq, int parent_irq)
 extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
+extern void handle_fasteoi_nmi(struct irq_desc *desc);
+extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
+
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
 extern int irq_chip_pm_put(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 34e9690..c32d5f3 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -730,6 +730,37 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
 
 /**
+ *	handle_fasteoi_nmi - irq handler for NMI interrupt lines
+ *	@desc:	the interrupt description structure for this irq
+ *
+ *	A simple NMI-safe handler, considering the restrictions
+ *	from request_nmi.
+ *
+ *	Only a single callback will be issued to the chip: an ->eoi()
+ *	call when the interrupt has been serviced. This enables support
+ *	for modern forms of interrupt handlers, which handle the flow
+ *	details in hardware, transparently.
+ */
+void handle_fasteoi_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	trace_irq_handler_entry(irq, action);
+	/*
+	 * NMIs cannot be shared, there is only one action.
+	 */
+	res = action->handler(irq, action->dev_id);
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
+
+/**
  *	handle_edge_irq - edge type IRQ handler
  *	@desc:	the interrupt description structure for this irq
  *
@@ -908,6 +939,29 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
+/**
+ * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
+ *				     dev ids
+ * @desc:	the interrupt description structure for this irq
+ *
+ * Similar to handle_fasteoi_nmi, but handling the dev_id cookie
+ * as a percpu pointer.
+ */
+void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
 static void
 __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		     int is_chained, const char *name)
-- 
1.9.1

