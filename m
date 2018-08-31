Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C75C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326AD2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326AD2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeHaMXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:23:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeHaMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:23:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AEC21684;
        Fri, 31 Aug 2018 01:17:33 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 606FD3F721;
        Fri, 31 Aug 2018 01:17:32 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 3/4] genirq: Provide NMI handlers
Date:   Fri, 31 Aug 2018 09:17:16 +0100
Message-Id: <1535703437-9453-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535703437-9453-1-git-send-email-julien.thierry@arm.com>
References: <1535703437-9453-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide flow handlers that are NMI safe for interrupts and percpu_devid
interrupts.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/irq.h |  3 +++
 kernel/irq/chip.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0d71f63..88cbad3 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -600,6 +600,9 @@ static inline int irq_set_parent(int irq, int parent_irq)
 extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
+extern void handle_fasteoi_nmi(struct irq_desc *desc);
+extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
+
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
 extern int irq_chip_pm_put(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a2b3d9d..c332c17 100644
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

