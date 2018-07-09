Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DCEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E98220875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E98220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933392AbeGIQO1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:14:27 -0400
Received: from foss.arm.com ([217.140.101.70]:34404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932951AbeGIQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:14:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D7A1684;
        Mon,  9 Jul 2018 09:14:24 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F4B33F589;
        Mon,  9 Jul 2018 09:14:23 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        marc.zyngier@arm.com, peterz@infradead.org, mingo@kernel.org,
        Julien Thierry <julien.thierry@arm.com>
Subject: [RFC PATCH 2/4] genirq: Provide NMI management for percpu_devid interrupts
Date:   Mon,  9 Jul 2018 17:14:04 +0100
Message-Id: <1531152846-19374-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
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
index d99196d..ec2b9da 100644
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
 
@@ -225,7 +230,11 @@ struct irqaction {
 
 extern void disable_nmi_nosync(unsigned int irq);
 extern void disable_nmi(unsigned int irq);
+extern void disable_percpu_nmi(unsigned int irq);
 extern void enable_nmi(unsigned int irq);
+extern void enable_percpu_nmi(unsigned int irq, unsigned int type);
+extern int ready_percpu_nmi(unsigned int irq);
+extern void teardown_percpu_nmi(unsigned int irq);
 
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 47e2e9e..005540a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2186,6 +2186,11 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
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
@@ -2225,6 +2230,11 @@ void disable_percpu_irq(unsigned int irq)
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
@@ -2256,6 +2266,8 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	/* Found it - now remove it from the list of entries: */
 	desc->action = NULL;
 
+	desc->istate &= ~IRQS_NMI;
+
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	unregister_handler_proc(irq, action);
@@ -2309,6 +2321,19 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
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
@@ -2399,6 +2424,130 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
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
+	if (!desc || !irq_settings_can_request(desc)
+	    || !irq_settings_is_per_cpu_devid(desc)
+	    || irq_settings_can_autoenable(desc)
+	    || !irq_supports_nmi(desc))
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

