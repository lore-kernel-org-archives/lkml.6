Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9A5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D8020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D8020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeGSXXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:23:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGSXXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:23:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fgHZC-0007i7-UZ; Fri, 20 Jul 2018 00:38:35 +0200
Date:   Fri, 20 Jul 2018 00:38:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.18-rt10
Message-ID: <20180719223834.yw6blkapv3fgxeha@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.18-rt10 patch set. 

Changes since v4.16.18-rt9:

  - The gicv3 now gained a raw_spinlock_t and allocates memory early.
    This avoids splats early during boot.

  - The migrate_disable() replacements for UP and non-RT builds were
    broken. The logic changed for this configuration and now
    migrate_disable() turns on preempt_disable(). Reported by Joe Korty.

  - The trace events in the cgroup code allocate a sleeping lock which
    does not work on RT. Reported by Clark Williams, patch by Steven
    Rostedt.

  - Avoid a preempt_disable() section during fork. This gives
    debug_object() an additional opportunity to refill its pool if
    needed.

  - Drop the "Prevent broadcast signals" patch.  Broadcast signals are
    not prevented by preventing sig_kernel_only() and
    sig_kernel_coredump() (as explained by Eric W. Biederman). This change
    was probably required in the early days but I can't find a reason why it
    should be still required.

  - The "delay ioapic unmask during pending setaffinity" patch been
    replaced with an updated version by Thomas Gleixner.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.18-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.18-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.18-rt10

The RT patch against v4.16.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.18-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.18-rt10.tar.xz

Sebastian

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b11ef4be6f2..75cff68944e6 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1729,20 +1729,20 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 	return false;
 }
 
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	/* If we are moving the irq we need to mask it */
-	if (unlikely(irqd_is_setaffinity_pending(data) &&
-		     !irqd_irq_inprogress(data))) {
-		mask_ioapic_irq(data);
+	if (unlikely(irqd_is_setaffinity_pending(data))) {
+		if (!irqd_irq_masked(data))
+			mask_ioapic_irq(data);
 		return true;
 	}
 	return false;
 }
 
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
-	if (unlikely(masked)) {
+	if (unlikely(moveit)) {
 		/* Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
@@ -1771,15 +1771,17 @@ static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
 		 */
 		if (!io_apic_level_ack_pending(data->chip_data))
 			irq_move_masked_irq(data);
-		unmask_ioapic_irq(data);
+		/* If the irq is masked in the core, leave it */
+		if (!irqd_irq_masked(data))
+			unmask_ioapic_irq(data);
 	}
 }
 #else
-static inline bool ioapic_irqd_mask(struct irq_data *data)
+static inline bool ioapic_prepare_move(struct irq_data *data)
 {
 	return false;
 }
-static inline void ioapic_irqd_unmask(struct irq_data *data, bool masked)
+static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 }
 #endif
@@ -1788,11 +1790,11 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 {
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	unsigned long v;
-	bool masked;
+	bool moveit;
 	int i;
 
 	irq_complete_move(cfg);
-	masked = ioapic_irqd_mask(irq_data);
+	moveit = ioapic_prepare_move(irq_data);
 
 	/*
 	 * It appears there is an erratum which affects at least version 0x11
@@ -1847,7 +1849,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 		eoi_ioapic_pin(cfg->vector, irq_data->chip_data);
 	}
 
-	ioapic_irqd_unmask(irq_data, masked);
+	ioapic_finish_move(irq_data, moveit);
 }
 
 static void ioapic_ir_ack_level(struct irq_data *irq_data)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2cbb19cddbf8..d9c479dcd4cb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -156,7 +156,7 @@ static struct {
 } vpe_proxy;
 
 static LIST_HEAD(its_nodes);
-static DEFINE_SPINLOCK(its_lock);
+static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
 
@@ -167,6 +167,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 static DEFINE_IDA(its_vpeid_ida);
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
@@ -1827,15 +1828,17 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
-static struct page *its_allocate_pending_table(gfp_t gfp_flags)
+static struct page *its_allocate_pending_table(unsigned int cpu)
 {
 	struct page *pend_page;
+	unsigned int order;
 	/*
 	 * The pending pages have to be at least 64kB aligned,
 	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
 	 */
-	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
-				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
+	order = get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K));
+	pend_page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				     order);
 	if (!pend_page)
 		return NULL;
 
@@ -1851,6 +1854,28 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
 
+static int its_alloc_pend_page(unsigned int cpu)
+{
+	struct page *pend_page;
+	phys_addr_t paddr;
+
+	pend_page = gic_data_rdist_cpu(cpu)->pend_page;
+	if (pend_page)
+		return 0;
+
+	pend_page = its_allocate_pending_table(cpu);
+	if (!pend_page) {
+		pr_err("Failed to allocate PENDBASE for CPU%d\n",
+		       smp_processor_id());
+		return -ENOMEM;
+	}
+
+	paddr = page_to_phys(pend_page);
+	pr_info("CPU%d: using LPI pending table @%pa\n", cpu, &paddr);
+	gic_data_rdist_cpu(cpu)->pend_page = pend_page;
+	return 0;
+}
+
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
@@ -1859,21 +1884,8 @@ static void its_cpu_init_lpis(void)
 
 	/* If we didn't allocate the pending table yet, do it now */
 	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page) {
-		phys_addr_t paddr;
-
-		pend_page = its_allocate_pending_table(GFP_NOWAIT);
-		if (!pend_page) {
-			pr_err("Failed to allocate PENDBASE for CPU%d\n",
-			       smp_processor_id());
-			return;
-		}
-
-		paddr = page_to_phys(pend_page);
-		pr_info("CPU%d: using LPI pending table @%pa\n",
-			smp_processor_id(), &paddr);
-		gic_data_rdist()->pend_page = pend_page;
-	}
+	if (!pend_page)
+		return;
 
 	/* Disable LPIs */
 	val = readl_relaxed(rbase + GICR_CTLR);
@@ -1943,7 +1955,7 @@ static void its_cpu_init_collection(void)
 	struct its_node *its;
 	int cpu;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	cpu = smp_processor_id();
 
 	list_for_each_entry(its, &its_nodes, entry) {
@@ -1985,7 +1997,7 @@ static void its_cpu_init_collection(void)
 		its_send_invall(its, &its->collections[cpu]);
 	}
 
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
 
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
@@ -2708,7 +2720,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
 
 	/* Allocate VPT */
-	vpt_page = its_allocate_pending_table(GFP_KERNEL);
+	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3264,9 +3276,9 @@ static int __init its_probe_one(struct resource *res,
 	if (err)
 		goto out_free_tables;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 
 	return 0;
 
@@ -3505,6 +3517,16 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (err)
 		return err;
 
+	err = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "irqchip/arm/gicv3:prepare",
+				its_alloc_pend_page, NULL);
+	if (err < 0) {
+		pr_warn("ITS: Can't register CPU-hoplug callback.\n");
+		return err;
+	}
+	err = its_alloc_pend_page(smp_processor_id());
+	if (err < 0)
+		return err;
+
 	list_for_each_entry(its, &its_nodes, entry)
 		has_v4 |= its->is_v4;
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 043e431a7e8e..9e41b8548be8 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -224,7 +224,7 @@ do { \
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 extern void migrate_disable(void);
 extern void migrate_enable(void);
@@ -241,8 +241,8 @@ static inline int __migrate_disabled(struct task_struct *p)
 }
 
 #else
-#define migrate_disable()		barrier()
-#define migrate_enable()		barrier()
+#define migrate_disable()		preempt_disable()
+#define migrate_enable()		preempt_enable()
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1e7e4bf3a756..a0c1c0cae992 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -646,7 +646,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	int				migrate_disable;
 	int				migrate_disable_update;
 	int				pinned_on_cpu;
@@ -655,8 +655,8 @@ struct task_struct {
 # endif
 
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	int				migrate_disable;
 # ifdef CONFIG_SCHED_DEBUG
+	int				migrate_disable;
 	int				migrate_disable_atomic;
 # endif
 #endif
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index d74722c2ac8b..a401ff5e7847 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -53,24 +53,22 @@ DEFINE_EVENT(cgroup_root, cgroup_remount,
 
 DECLARE_EVENT_CLASS(cgroup,
 
-	TP_PROTO(struct cgroup *cgrp),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgrp),
+	TP_ARGS(cgrp, path),
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
 		__field(	int,		id			)
 		__field(	int,		level			)
-		__dynamic_array(char,		path,
-				cgroup_path(cgrp, NULL, 0) + 1)
+		__string(	path,		path			)
 	),
 
 	TP_fast_assign(
 		__entry->root = cgrp->root->hierarchy_id;
 		__entry->id = cgrp->id;
 		__entry->level = cgrp->level;
-		cgroup_path(cgrp, __get_dynamic_array(path),
-				  __get_dynamic_array_len(path));
+		__assign_str(path, path);
 	),
 
 	TP_printk("root=%d id=%d level=%d path=%s",
@@ -79,45 +77,45 @@ DECLARE_EVENT_CLASS(cgroup,
 
 DEFINE_EVENT(cgroup, cgroup_mkdir,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DEFINE_EVENT(cgroup, cgroup_rmdir,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DEFINE_EVENT(cgroup, cgroup_release,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DEFINE_EVENT(cgroup, cgroup_rename,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DECLARE_EVENT_CLASS(cgroup_migrate,
 
-	TP_PROTO(struct cgroup *dst_cgrp, struct task_struct *task, bool threadgroup),
+	TP_PROTO(struct cgroup *dst_cgrp, const char *path,
+		 struct task_struct *task, bool threadgroup),
 
-	TP_ARGS(dst_cgrp, task, threadgroup),
+	TP_ARGS(dst_cgrp, path, task, threadgroup),
 
 	TP_STRUCT__entry(
 		__field(	int,		dst_root		)
 		__field(	int,		dst_id			)
 		__field(	int,		dst_level		)
-		__dynamic_array(char,		dst_path,
-				cgroup_path(dst_cgrp, NULL, 0) + 1)
 		__field(	int,		pid			)
+		__string(	dst_path,	path			)
 		__string(	comm,		task->comm		)
 	),
 
@@ -125,8 +123,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__entry->dst_root = dst_cgrp->root->hierarchy_id;
 		__entry->dst_id = dst_cgrp->id;
 		__entry->dst_level = dst_cgrp->level;
-		cgroup_path(dst_cgrp, __get_dynamic_array(dst_path),
-				      __get_dynamic_array_len(dst_path));
+		__assign_str(dst_path, path);
 		__entry->pid = task->pid;
 		__assign_str(comm, task->comm);
 	),
@@ -138,16 +135,18 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 
 DEFINE_EVENT(cgroup_migrate, cgroup_attach_task,
 
-	TP_PROTO(struct cgroup *dst_cgrp, struct task_struct *task, bool threadgroup),
+	TP_PROTO(struct cgroup *dst_cgrp, const char *path,
+		 struct task_struct *task, bool threadgroup),
 
-	TP_ARGS(dst_cgrp, task, threadgroup)
+	TP_ARGS(dst_cgrp, path, task, threadgroup)
 );
 
 DEFINE_EVENT(cgroup_migrate, cgroup_transfer_tasks,
 
-	TP_PROTO(struct cgroup *dst_cgrp, struct task_struct *task, bool threadgroup),
+	TP_PROTO(struct cgroup *dst_cgrp, const char *path,
+		 struct task_struct *task, bool threadgroup),
 
-	TP_ARGS(dst_cgrp, task, threadgroup)
+	TP_ARGS(dst_cgrp, path, task, threadgroup)
 );
 
 #endif /* _TRACE_CGROUP_H */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index b928b27050c6..8ece16c74598 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -8,6 +8,32 @@
 #include <linux/list.h>
 #include <linux/refcount.h>
 
+#define TRACE_CGROUP_PATH_LEN 1024
+extern spinlock_t trace_cgroup_path_lock;
+extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
+
+/*
+ * cgroup_path() takes a spin lock. It is good practice not to take
+ * spin locks within trace point handlers, as they are mostly hidden
+ * from normal view. As cgroup_path() can take the kernfs_rename_lock
+ * spin lock, it is best to not call that function from the trace event
+ * handler.
+ *
+ * Note: trace_cgroup_##type##_enabled() is a static branch that will only
+ *       be set when the trace event is enabled.
+ */
+#define TRACE_CGROUP_PATH(type, cgrp, ...)				\
+	do {								\
+		if (trace_cgroup_##type##_enabled()) {			\
+			spin_lock(&trace_cgroup_path_lock);		\
+			cgroup_path(cgrp, trace_cgroup_path,		\
+				    TRACE_CGROUP_PATH_LEN);		\
+			trace_cgroup_##type(cgrp, trace_cgroup_path,	\
+					    ##__VA_ARGS__);		\
+			spin_unlock(&trace_cgroup_path_lock);		\
+		}							\
+	} while (0)
+
 /*
  * A cgroup can be associated with multiple css_sets as different tasks may
  * belong to different cgroups on different hierarchies.  In the other
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a2c05d2476ac..d309cd0f94f2 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -135,7 +135,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 		if (task) {
 			ret = cgroup_migrate(task, false, &mgctx);
 			if (!ret)
-				trace_cgroup_transfer_tasks(to, task, false);
+				TRACE_CGROUP_PATH(transfer_tasks, to, task, false);
 			put_task_struct(task);
 		}
 	} while (task && !ret);
@@ -877,7 +877,7 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 
 	ret = kernfs_rename(kn, new_parent, new_name_str);
 	if (!ret)
-		trace_cgroup_rename(cgrp);
+		TRACE_CGROUP_PATH(rename, cgrp);
 
 	mutex_unlock(&cgroup_mutex);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ea798813a79d..e8e6afc8a5a2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -80,6 +80,9 @@ EXPORT_SYMBOL_GPL(cgroup_mutex);
 EXPORT_SYMBOL_GPL(css_set_lock);
 #endif
 
+DEFINE_SPINLOCK(trace_cgroup_path_lock);
+char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
+
 /*
  * Protects cgroup_idr and css_idr so that IDs can be released without
  * grabbing cgroup_mutex.
@@ -2620,7 +2623,7 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 	cgroup_migrate_finish(&mgctx);
 
 	if (!ret)
-		trace_cgroup_attach_task(dst_cgrp, leader, threadgroup);
+		TRACE_CGROUP_PATH(attach_task, dst_cgrp, leader, threadgroup);
 
 	return ret;
 }
@@ -4603,7 +4606,7 @@ static void css_release_work_fn(struct swork_event *sev)
 		struct cgroup *tcgrp;
 
 		/* cgroup release path */
-		trace_cgroup_release(cgrp);
+		TRACE_CGROUP_PATH(release, cgrp);
 
 		if (cgroup_on_dfl(cgrp))
 			cgroup_stat_flush(cgrp);
@@ -4939,7 +4942,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	if (ret)
 		goto out_destroy;
 
-	trace_cgroup_mkdir(cgrp);
+	TRACE_CGROUP_PATH(mkdir, cgrp);
 
 	/* let's create and online css's */
 	kernfs_activate(kn);
@@ -5129,9 +5132,8 @@ int cgroup_rmdir(struct kernfs_node *kn)
 		return 0;
 
 	ret = cgroup_destroy_locked(cgrp);
-
 	if (!ret)
-		trace_cgroup_rmdir(cgrp);
+		TRACE_CGROUP_PATH(rmdir, cgrp);
 
 	cgroup_kn_unlock(kn);
 	return ret;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac3fb8495bd5..70641e8f3c89 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1101,7 +1101,7 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
@@ -1140,7 +1140,7 @@ static void __do_set_cpus_allowed_tail(struct task_struct *p,
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		lockdep_assert_held(&p->pi_lock);
 
@@ -1213,7 +1213,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
 		goto out;
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		p->migrate_disable_update = 1;
 		goto out;
@@ -2428,7 +2428,6 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
-	int cpu = get_cpu();
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -2464,14 +2463,12 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->sched_reset_on_fork = 0;
 	}
 
-	if (dl_prio(p->prio)) {
-		put_cpu();
+	if (dl_prio(p->prio))
 		return -EAGAIN;
-	} else if (rt_prio(p->prio)) {
+	else if (rt_prio(p->prio))
 		p->sched_class = &rt_sched_class;
-	} else {
+	else
 		p->sched_class = &fair_sched_class;
-	}
 
 	init_entity_runnable_average(&p->se);
 
@@ -2487,7 +2484,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 * We're setting the CPU for the first time, we don't migrate,
 	 * so use __set_task_cpu().
 	 */
-	__set_task_cpu(p, cpu);
+	__set_task_cpu(p, smp_processor_id());
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
@@ -2507,8 +2504,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
-
-	put_cpu();
 	return 0;
 }
 
@@ -7159,7 +7154,7 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 static inline void
 update_nr_migratory(struct task_struct *p, long delta)
@@ -7310,45 +7305,44 @@ EXPORT_SYMBOL(migrate_enable);
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 void migrate_disable(void)
 {
+#ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
 	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
-#endif
 		return;
 	}
-#ifdef CONFIG_SCHED_DEBUG
+
 	if (unlikely(p->migrate_disable_atomic)) {
 		tracing_off();
 		WARN_ON_ONCE(1);
 	}
-#endif
 
 	p->migrate_disable++;
+#endif
+	barrier();
 }
 EXPORT_SYMBOL(migrate_disable);
 
 void migrate_enable(void)
 {
+#ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
 	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
-#endif
 		return;
 	}
 
-#ifdef CONFIG_SCHED_DEBUG
 	if (unlikely(p->migrate_disable_atomic)) {
 		tracing_off();
 		WARN_ON_ONCE(1);
 	}
-#endif
 
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	p->migrate_disable--;
+#endif
+	barrier();
 }
 EXPORT_SYMBOL(migrate_enable);
 #endif
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 93f4765520d1..a8fb58a0f24e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1030,7 +1030,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.runtime);
 		P(dl.deadline);
 	}
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	P(migrate_disable);
 #endif
 	P(nr_cpus_allowed);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e1c5b9b64140..0d14e044b46f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -434,7 +434,6 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct task_struct *rtn = current->group_leader;
-	int sig = event->sigev_signo;
 
 	switch (event->sigev_notify) {
 	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
@@ -444,8 +443,7 @@ static struct pid *good_sigevent(sigevent_t * event)
 		/* FALLTHRU */
 	case SIGEV_SIGNAL:
 	case SIGEV_THREAD:
-		if (sig <= 0 || sig > SIGRTMAX ||
-		    sig_kernel_only(sig) || sig_kernel_coredump(sig))
+		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
 			return NULL;
 		/* FALLTHRU */
 	case SIGEV_NONE:
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a4..d79dde624aaa 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
