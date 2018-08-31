Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E6EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3969520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3969520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeHaMXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:23:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53892 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeHaMXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:23:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0DEED1;
        Fri, 31 Aug 2018 01:17:30 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B4BB3F721;
        Fri, 31 Aug 2018 01:17:29 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 1/4] genirq: Provide basic NMI management for interrupt lines
Date:   Fri, 31 Aug 2018 09:17:14 +0100
Message-Id: <1535703437-9453-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535703437-9453-1-git-send-email-julien.thierry@arm.com>
References: <1535703437-9453-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality to allocate interrupt lines that will deliver IRQs
as Non-Maskable Interrupts. These allocations are only successful if
the irqchip provides the necessary support and allows NMI delivery for the
interrupt line.

Interrupt lines allocated for NMI delivery must be enabled/disabled through
enable_nmi/disable_nmi_nosync to keep their state consistent.

To treat a PERCPU IRQ as NMI, the interrupt must not be shared nor threaded,
the irqchip directly managing the IRQ must be the root irqchip and the
irqchip cannot be behind a slow bus.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/interrupt.h |   9 ++
 include/linux/irq.h       |   7 ++
 kernel/irq/debugfs.c      |   6 +-
 kernel/irq/internals.h    |   2 +
 kernel/irq/manage.c       | 228 +++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 249 insertions(+), 3 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index eeceac3..3b1a320 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -156,6 +156,10 @@ struct irqaction {
 		     unsigned long flags, const char *devname,
 		     void __percpu *percpu_dev_id);
 
+extern int __must_check
+request_nmi(unsigned int irq, irq_handler_t handler, unsigned long flags,
+	    const char *name, void *dev);
+
 static inline int __must_check
 request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *percpu_dev_id)
@@ -167,6 +171,8 @@ struct irqaction {
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
 
+extern const void *free_nmi(unsigned int irq, void *dev_id);
+
 struct device;
 
 extern int __must_check
@@ -217,6 +223,9 @@ struct irqaction {
 extern bool irq_percpu_is_enabled(unsigned int irq);
 extern void irq_wake_thread(unsigned int irq, void *dev_id);
 
+extern void disable_nmi_nosync(unsigned int irq);
+extern void enable_nmi(unsigned int irq);
+
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 201de12..0d71f63 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -441,6 +441,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
  * @ipi_send_single:	send a single IPI to destination cpus
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
+ * @irq_nmi_setup:	function called from core code before enabling an NMI
+ * @irq_nmi_teardown:	function called from core code after disabling an NMI
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -489,6 +491,9 @@ struct irq_chip {
 	void		(*ipi_send_single)(struct irq_data *data, unsigned int cpu);
 	void		(*ipi_send_mask)(struct irq_data *data, const struct cpumask *dest);
 
+	int		(*irq_nmi_setup)(struct irq_data *data);
+	void		(*irq_nmi_teardown)(struct irq_data *data);
+
 	unsigned long	flags;
 };
 
@@ -504,6 +509,7 @@ struct irq_chip {
  * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
  * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
  * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
+ * IRQCHIP_SUPPORTS_NMI:	Chip can deliver NMIs, only for root irqchips
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
@@ -514,6 +520,7 @@ enum {
 	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
 	IRQCHIP_EOI_THREADED		= (1 <<  6),
 	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
+	IRQCHIP_SUPPORTS_NMI		= (1 <<  8),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 6f63613..59a04d2 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -56,6 +56,7 @@ static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc) { }
 	BIT_MASK_DESCR(IRQCHIP_ONESHOT_SAFE),
 	BIT_MASK_DESCR(IRQCHIP_EOI_THREADED),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
+	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 };
 
 static void
@@ -140,6 +141,7 @@ static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc) { }
 	BIT_MASK_DESCR(IRQS_WAITING),
 	BIT_MASK_DESCR(IRQS_PENDING),
 	BIT_MASK_DESCR(IRQS_SUSPENDED),
+	BIT_MASK_DESCR(IRQS_NMI),
 };
 
 
@@ -203,8 +205,8 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 		chip_bus_lock(desc);
 		raw_spin_lock_irqsave(&desc->lock, flags);
 
-		if (irq_settings_is_level(desc)) {
-			/* Can't do level, sorry */
+		if (irq_settings_is_level(desc) || desc->istate & IRQS_NMI) {
+			/* Can't do level nor NMIs, sorry */
 			err = -EINVAL;
 		} else {
 			desc->istate |= IRQS_PENDING;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ca6afa2..2a77cdd2 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -49,6 +49,7 @@ enum {
  * IRQS_WAITING			- irq is waiting
  * IRQS_PENDING			- irq is pending and replayed later
  * IRQS_SUSPENDED		- irq is suspended
+ * IRQS_NMI			- irq line is used to deliver NMIs
  */
 enum {
 	IRQS_AUTODETECT		= 0x00000001,
@@ -60,6 +61,7 @@ enum {
 	IRQS_PENDING		= 0x00000200,
 	IRQS_SUSPENDED		= 0x00000800,
 	IRQS_TIMINGS		= 0x00001000,
+	IRQS_NMI		= 0x00002000,
 };
 
 #include "debug.h"
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fb86146..15ae2ee 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -341,7 +341,7 @@ static void irq_affinity_notify(struct work_struct *work)
 	/* The release function is promised process context */
 	might_sleep();
 
-	if (!desc)
+	if (!desc || desc->istate & IRQS_NMI)
 		return -EINVAL;
 
 	/* Complete initialisation of *notify */
@@ -550,6 +550,21 @@ bool disable_hardirq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(disable_hardirq);
 
+/**
+ *	disable_nmi_nosync - disable an nmi without waiting
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line. Disables and enables are
+ *	nested.
+ *	The interrupt to disable must have been requested through request_nmi.
+ *	Unlike disable_nmi(), this function does not ensure existing
+ *	instances of the IRQ handler have completed before returning.
+ */
+void disable_nmi_nosync(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+}
+
 void __enable_irq(struct irq_desc *desc)
 {
 	switch (desc->depth) {
@@ -606,6 +621,20 @@ void enable_irq(unsigned int irq)
 }
 EXPORT_SYMBOL(enable_irq);
 
+/**
+ *	enable_nmi - enable handling of an nmi
+ *	@irq: Interrupt to enable
+ *
+ *	The interrupt to enable must have been requested through request_nmi.
+ *	Undoes the effect of one call to disable_nmi(). If this
+ *	matches the last disable, processing of interrupts on this
+ *	IRQ line is re-enabled.
+ */
+void enable_nmi(unsigned int irq)
+{
+	enable_irq(irq);
+}
+
 static int set_irq_wake_real(unsigned int irq, unsigned int on)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
@@ -641,6 +670,12 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 	if (!desc)
 		return -EINVAL;
 
+	/* Don't use NMIs as wake up interrupts please */
+	if (desc->istate & IRQS_NMI) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/* wakeup-capable irqs can be shared between drivers that
 	 * don't need to have the same sleep mode behaviors.
 	 */
@@ -663,6 +698,8 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 				irqd_clear(&desc->irq_data, IRQD_WAKEUP_STATE);
 		}
 	}
+
+out_unlock:
 	irq_put_desc_busunlock(desc, flags);
 	return ret;
 }
@@ -1121,6 +1158,39 @@ static void irq_release_resources(struct irq_desc *desc)
 		c->irq_release_resources(d);
 }
 
+static bool irq_supports_nmi(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	/* Only IRQs directly managed by the root irqchip can be set as NMI */
+	if (d->parent_data)
+		return false;
+#endif
+	/* Don't support NMIs for chips behind a slow bus */
+	if (d->chip->irq_bus_lock || d->chip->irq_bus_sync_unlock)
+		return false;
+
+	return d->chip->flags & IRQCHIP_SUPPORTS_NMI;
+}
+
+static int irq_nmi_setup(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	struct irq_chip *c = d->chip;
+
+	return c->irq_nmi_setup ? c->irq_nmi_setup(d) : -EINVAL;
+}
+
+static void irq_nmi_teardown(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	struct irq_chip *c = d->chip;
+
+	if (c->irq_nmi_teardown)
+		c->irq_nmi_teardown(d);
+}
+
 static int
 setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 {
@@ -1295,9 +1365,17 @@ static void irq_release_resources(struct irq_desc *desc)
 		 * fields must have IRQF_SHARED set and the bits which
 		 * set the trigger type must match. Also all must
 		 * agree on ONESHOT.
+		 * Interrupt lines used for NMIs cannot be shared.
 		 */
 		unsigned int oldtype;
 
+		if (desc->istate & IRQS_NMI) {
+			pr_err("Invalid attempt to share NMI for %s (irq %d) on irqchip %s.\n",
+				new->name, irq, desc->irq_data.chip->name);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
 		/*
 		 * If nobody did set the configuration before, inherit
 		 * the one provided by the requester.
@@ -1749,6 +1827,59 @@ const void *free_irq(unsigned int irq, void *dev_id)
 }
 EXPORT_SYMBOL(free_irq);
 
+/* This function must be called with desc->lock held */
+static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
+{
+	const char *devname = NULL;
+
+	desc->istate &= ~IRQS_NMI;
+
+	if (!WARN_ON(desc->action == NULL)) {
+		irq_pm_remove_action(desc, desc->action);
+		devname = desc->action->name;
+		unregister_handler_proc(irq, desc->action);
+
+		kfree(desc->action);
+		desc->action = NULL;
+	}
+
+	irq_settings_clr_disable_unlazy(desc);
+	irq_shutdown(desc);
+
+	irq_release_resources(desc);
+
+	irq_chip_pm_put(&desc->irq_data);
+	module_put(desc->owner);
+
+	return devname;
+}
+
+const void *free_nmi(unsigned int irq, void *dev_id)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	unsigned long flags;
+	const void *devname;
+
+	if (!desc || WARN_ON(!(desc->istate & IRQS_NMI)))
+		return NULL;
+
+	if (WARN_ON(irq_settings_is_per_cpu_devid(desc)))
+		return NULL;
+
+	/* NMI still enabled */
+	if (WARN_ON(desc->depth == 0))
+		disable_nmi_nosync(irq);
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	irq_nmi_teardown(desc);
+	devname = __cleanup_nmi(irq, desc);
+
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	return devname;
+}
+
 /**
  *	request_threaded_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
@@ -1918,6 +2049,101 @@ int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 }
 EXPORT_SYMBOL_GPL(request_any_context_irq);
 
+/**
+ *	request_nmi - allocate an interrupt line for NMI delivery
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs.
+ *		  Threaded handler for threaded interrupts.
+ *	@irqflags: Interrupt type flags
+ *	@name: An ascii name for the claiming device
+ *	@dev_id: A cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources and enables the
+ *	interrupt line and IRQ handling. It sets up the IRQ line
+ *	to be handled as an NMI.
+ *
+ *	An interrupt line delivering NMIs cannot be shared and IRQ handling
+ *	cannot be threaded.
+ *
+ *	Interrupt lines requested for NMI delivering must produce per cpu
+ *	interrupts and have auto enabling setting disabled.
+ *
+ *	Dev_id must be globally unique. Normally the address of the
+ *	device data structure is used as the cookie. Since the handler
+ *	receives this value it makes sense to use it.
+ *
+ *	If the interrupt line cannot be used to deliver NMIs, function
+ *	will fail and return a negative value.
+ */
+int request_nmi(unsigned int irq, irq_handler_t handler,
+		unsigned long irqflags, const char *name, void *dev_id)
+{
+	struct irqaction *action;
+	struct irq_desc *desc;
+	unsigned long flags;
+	int retval;
+
+	if (irq == IRQ_NOTCONNECTED)
+		return -ENOTCONN;
+
+	/* NMI cannot be shared, used for Polling */
+	if (irqflags & (IRQF_SHARED | IRQF_COND_SUSPEND | IRQF_IRQPOLL))
+		return -EINVAL;
+
+	if (!(irqflags & IRQF_PERCPU))
+		return -EINVAL;
+
+	if (!handler)
+		return -EINVAL;
+
+	desc = irq_to_desc(irq);
+
+	if (!desc || irq_settings_can_autoenable(desc) ||
+	    !irq_settings_can_request(desc) ||
+	    WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
+	    !irq_supports_nmi(desc))
+		return -EINVAL;
+
+	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+	if (!action)
+		return -ENOMEM;
+
+	action->handler = handler;
+	action->flags = irqflags | IRQF_NO_THREAD | IRQF_NOBALANCING;
+	action->name = name;
+	action->dev_id = dev_id;
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
+
+	/* Setup NMI state */
+	desc->istate |= IRQS_NMI;
+	retval = irq_nmi_setup(desc);
+	if (retval) {
+		__cleanup_nmi(irq, desc);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		return -EINVAL;
+	}
+
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
 void enable_percpu_irq(unsigned int irq, unsigned int type)
 {
 	unsigned int cpu = smp_processor_id();
-- 
1.9.1

