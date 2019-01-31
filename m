Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD3C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911E120869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbfAaOyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:54:23 -0500
Received: from foss.arm.com ([217.140.101.70]:45300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732073AbfAaOyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:54:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 450B81596;
        Thu, 31 Jan 2019 06:54:20 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 360763F59C;
        Thu, 31 Jan 2019 06:54:19 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v6 2/4] genirq: Provide NMI management for percpu_devid interrupts
Date:   Thu, 31 Jan 2019 14:53:59 +0000
Message-Id: <1548946441-38546-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
References: <1548946441-38546-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for percpu_devid interrupts treated as NMIs.

Percpu_devid NMIs need to be setup/torn down on each CPU they target.

The same restrictions as for global NMIs still apply for percpu_devid NMIs.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/interrupt.h |   9 +++
 kernel/irq/manage.c       | 177 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9941d1a..831ddcd 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -168,10 +168,15 @@ struct irqaction {
 				    devname, percpu_dev_id);
 }
 
+extern int __must_check
+request_percpu_nmi(unsigned int irq, irq_handler_t handler,
+		   const char *devname, void __percpu *dev);
+
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
 
 extern const void *free_nmi(unsigned int irq, void *dev_id);
+extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
 
 struct device;
 
@@ -224,7 +229,11 @@ struct irqaction {
 extern void irq_wake_thread(unsigned int irq, void *dev_id);
 
 extern void disable_nmi_nosync(unsigned int irq);
+extern void disable_percpu_nmi(unsigned int irq);
 extern void enable_nmi(unsigned int irq);
+extern void enable_percpu_nmi(unsigned int irq, unsigned int type);
+extern int prepare_percpu_nmi(unsigned int irq);
+extern void teardown_percpu_nmi(unsigned int irq);
 
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9472ae9..0a1ebc0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2182,6 +2182,11 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
 }
 EXPORT_SYMBOL_GPL(enable_percpu_irq);
 
+void enable_percpu_nmi(unsigned int irq, unsigned int type)
+{
+	enable_percpu_irq(irq, type);
+}
+
 /**
  * irq_percpu_is_enabled - Check whether the per cpu irq is enabled
  * @irq:	Linux irq number to check for
@@ -2221,6 +2226,11 @@ void disable_percpu_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(disable_percpu_irq);
 
+void disable_percpu_nmi(unsigned int irq)
+{
+	disable_percpu_irq(irq);
+}
+
 /*
  * Internal function to unregister a percpu irqaction.
  */
@@ -2252,6 +2262,8 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	/* Found it - now remove it from the list of entries: */
 	desc->action = NULL;
 
+	desc->istate &= ~IRQS_NMI;
+
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	unregister_handler_proc(irq, action);
@@ -2305,6 +2317,19 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 }
 EXPORT_SYMBOL_GPL(free_percpu_irq);
 
+void free_percpu_nmi(unsigned int irq, void __percpu *dev_id)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !irq_settings_is_per_cpu_devid(desc))
+		return;
+
+	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+		return;
+
+	kfree(__free_percpu_irq(irq, dev_id));
+}
+
 /**
  *	setup_percpu_irq - setup a per-cpu interrupt
  *	@irq: Interrupt line to setup
@@ -2395,6 +2420,158 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 EXPORT_SYMBOL_GPL(__request_percpu_irq);
 
 /**
+ *	request_percpu_nmi - allocate a percpu interrupt line for NMI delivery
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs.
+ *	@name: An ascii name for the claiming device
+ *	@dev_id: A percpu cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
+ *	have to be setup on each CPU by calling ready_percpu_nmi() before being
+ *	enabled on the same CPU by using enable_percpu_nmi().
+ *
+ *	Dev_id must be globally unique. It is a per-cpu variable, and
+ *	the handler gets called with the interrupted CPU's instance of
+ *	that variable.
+ *
+ *	Interrupt lines requested for NMI delivering should have auto enabling
+ *	setting disabled.
+ *
+ *	If the interrupt line cannot be used to deliver NMIs, function
+ *	will fail returning a negative value.
+ */
+int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
+		       const char *name, void __percpu *dev_id)
+{
+	struct irqaction *action;
+	struct irq_desc *desc;
+	unsigned long flags;
+	int retval;
+
+	if (!handler)
+		return -EINVAL;
+
+	desc = irq_to_desc(irq);
+
+	if (!desc || !irq_settings_can_request(desc) ||
+	    !irq_settings_is_per_cpu_devid(desc) ||
+	    irq_settings_can_autoenable(desc) ||
+	    !irq_supports_nmi(desc))
+		return -EINVAL;
+
+	/* The line cannot already be NMI */
+	if (desc->istate & IRQS_NMI)
+		return -EINVAL;
+
+	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+	if (!action)
+		return -ENOMEM;
+
+	action->handler = handler;
+	action->flags = IRQF_PERCPU | IRQF_NO_SUSPEND | IRQF_NO_THREAD
+		| IRQF_NOBALANCING;
+	action->name = name;
+	action->percpu_dev_id = dev_id;
+
+	retval = irq_chip_pm_get(&desc->irq_data);
+	if (retval < 0)
+		goto err_out;
+
+	retval = __setup_irq(irq, desc, action);
+	if (retval)
+		goto err_irq_setup;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	desc->istate |= IRQS_NMI;
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	return 0;
+
+err_irq_setup:
+	irq_chip_pm_put(&desc->irq_data);
+err_out:
+	kfree(action);
+
+	return retval;
+}
+
+/**
+ *	prepare_percpu_nmi - performs CPU local setup for NMI delivery
+ *	@irq: Interrupt line to prepare for NMI delivery
+ *
+ *	This call prepares an interrupt line to deliver NMI on the current CPU,
+ *	before that interrupt line gets enabled with enable_percpu_nmi().
+ *
+ *	As a CPU local operation, this should be called from non-preemptible
+ *	context.
+ *
+ *	If the interrupt line cannot be used to deliver NMIs, function
+ *	will fail returning a negative value.
+ */
+int prepare_percpu_nmi(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc;
+	int ret = 0;
+
+	WARN_ON(preemptible());
+
+	desc = irq_get_desc_lock(irq, &flags,
+				 IRQ_GET_DESC_CHECK_PERCPU);
+	if (!desc)
+		return -EINVAL;
+
+	if (WARN(!(desc->istate & IRQS_NMI),
+		 KERN_ERR "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n",
+		 irq)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = irq_nmi_setup(desc);
+	if (ret) {
+		pr_err("Failed to setup NMI delivery: irq %u\n", irq);
+		goto out;
+	}
+
+out:
+	irq_put_desc_unlock(desc, flags);
+	return ret;
+}
+
+/**
+ *	teardown_percpu_nmi - undoes NMI setup of IRQ line
+ *	@irq: Interrupt line from which CPU local NMI configuration should be
+ *	      removed
+ *
+ *	This call undoes the setup done by prepare_percpu_nmi().
+ *
+ *	IRQ line should not be enabled for the current CPU.
+ *
+ *	As a CPU local operation, this should be called from non-preemptible
+ *	context.
+ */
+void teardown_percpu_nmi(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc;
+
+	WARN_ON(preemptible());
+
+	desc = irq_get_desc_lock(irq, &flags,
+				 IRQ_GET_DESC_CHECK_PERCPU);
+	if (!desc)
+		return;
+
+	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+		goto out;
+
+	irq_nmi_teardown(desc);
+out:
+	irq_put_desc_unlock(desc, flags);
+}
+
+/**
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
  *	@which: One of IRQCHIP_STATE_* the caller wants to know about
-- 
1.9.1

