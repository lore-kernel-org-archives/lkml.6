Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A694AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565D020867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565D020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH1TWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:22:37 -0400
Received: from foss.arm.com ([217.140.101.70]:40484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbeH1TWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:22:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FD8315BF;
        Tue, 28 Aug 2018 08:30:01 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51B803F557;
        Tue, 28 Aug 2018 08:30:00 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 2/4] genirq: Provide NMI management for percpu_devid interrupts
Date:   Tue, 28 Aug 2018 16:29:46 +0100
Message-Id: <1535470188-38155-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535470188-38155-1-git-send-email-julien.thierry@arm.com>
References: <1535470188-38155-1-git-send-email-julien.thierry@arm.com>
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
 kernel/irq/manage.c       | 149 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3b1a320..59d3877 100644
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
+extern int ready_percpu_nmi(unsigned int irq);
+extern void teardown_percpu_nmi(unsigned int irq);
 
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dabcf48..b1dcd39 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2178,6 +2178,11 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
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
@@ -2217,6 +2222,11 @@ void disable_percpu_irq(unsigned int irq)
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
@@ -2248,6 +2258,8 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	/* Found it - now remove it from the list of entries: */
 	desc->action = NULL;
 
+	desc->istate &= ~IRQS_NMI;
+
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	unregister_handler_proc(irq, action);
@@ -2301,6 +2313,19 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
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
@@ -2391,6 +2416,130 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 EXPORT_SYMBOL_GPL(__request_percpu_irq);
 
 /**
+ *	request_percpu_nmi - allocate a percpu interrupt line for NMI delivery
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs.
+ *	@devname: An ascii name for the claiming device
+ *	@dev_id: A percpu cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources and enables the
+ *	interrupt on the local CPU. If the interrupt is supposed to be
+ *	enabled on other CPUs, it has to be done on each CPU using
+ *	enable_percpu_nmi().
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
+int ready_percpu_nmi(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_get_desc_lock(irq, &flags,
+						  IRQ_GET_DESC_CHECK_PERCPU);
+	int ret = 0;
+
+	if (!desc) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (WARN(!(desc->istate & IRQS_NMI),
+		 KERN_ERR "ready_percpu_nmi called for a non-NMI interrupt: irq %u\n",
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
+void teardown_percpu_nmi(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_get_desc_lock(irq, &flags,
+						  IRQ_GET_DESC_CHECK_PERCPU);
+
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

