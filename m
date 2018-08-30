Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65112C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A7A20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A7A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeH3MbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:31:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49642 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeH3MbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:31:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fvIL3-0007Fh-Et; Thu, 30 Aug 2018 10:30:01 +0200
Date:   Thu, 30 Aug 2018 10:30:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.18.5-rt3
Message-ID: <20180830083001.iaxp6jei6473qpul@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.18.5-rt3 patch set. 

Changes since v4.18.5-rt2:

  - PowerPC did not compile due to impossible constrains in the
    preempt-lazy assembly code.

  - Replace one GICv3 patch with a patch by Marc Zyngier which should be
    merged upstream.

  - Android Virtual System on a Chip (VSoC) driver did not compile.
    Patch updated by Anna-Maria Gleixner.

  - A BUG() statement could be triggered during CPU-hotplug if it tried
    to wake up a task within a migrate-disabled section on the CPU which
    was going down. Reported by Steven Rostedt, patched by Mike
    Galbraith.

  - The HV driver failed to compile. Reported by Bernhard Landauer and
    Ralf Ramsauer, an initial patch was provided by Steven Rostedt.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.18.5-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/incr/patch-4.18.5-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.18.5-rt3

The RT patch against v4.18.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patch-4.18.5-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patches-4.18.5-rt3.tar.xz

Sebastian

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 431759836861e..15c2c0925b6c1 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -82,7 +82,7 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_FSCHECK		3	/* Check FS is USER_DS on return */
-#define TIF_32BIT		4	/* 32 bit binary */
+#define TIF_NEED_RESCHED_LAZY	4       /* lazy rescheduling necessary */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
@@ -101,7 +101,7 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TIF_ELF2ABI		18	/* function descriptors must die! */
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
-#define TIF_NEED_RESCHED_LAZY	20       /* lazy rescheduling necessary */
+#define TIF_32BIT		20	/* 32 bit binary */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0c519f5bd6286..9a2e5645b29ac 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -168,7 +168,7 @@ system_call:			/* label this so stack traces look sane */
  * based on caller's run-mode / personality.
  */
 	ld	r11,SYS_CALL_TABLE@toc(2)
-	andi.	r10,r10,_TIF_32BIT
+	andis.	r10,r10,_TIF_32BIT@h
 	beq	15f
 	addi	r11,r11,8	/* use 32-bit syscall entries */
 	clrldi	r3,r3,32
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 72eaba3d50fc2..797f07918197c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -31,6 +31,7 @@
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include "hv_trace.h"
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4bca2439ee7dc..907e5c5169e9c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1556,7 +1556,7 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
+static int __init its_alloc_lpi_prop_table(void)
 {
 	phys_addr_t paddr;
 
@@ -1854,17 +1854,15 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
-static struct page *its_allocate_pending_table(unsigned int cpu)
+static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
 	struct page *pend_page;
-	unsigned int order;
 	/*
 	 * The pending pages have to be at least 64kB aligned,
 	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
 	 */
-	order = get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K));
-	pend_page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
-				     order);
+	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
+				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 	if (!pend_page)
 		return NULL;
 
@@ -1880,25 +1878,31 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
 
-static int its_alloc_pend_page(unsigned int cpu)
+static int __init allocate_lpi_tables(void)
 {
-	struct page *pend_page;
-	phys_addr_t paddr;
+	int err, cpu;
 
-	pend_page = gic_data_rdist_cpu(cpu)->pend_page;
-	if (pend_page)
-		return 0;
+	err = its_alloc_lpi_prop_table();
+	if (err)
+		return err;
 
-	pend_page = its_allocate_pending_table(cpu);
-	if (!pend_page) {
-		pr_err("Failed to allocate PENDBASE for CPU%d\n",
-		       smp_processor_id());
-		return -ENOMEM;
+	/*
+	 * We allocate all the pending tables anyway, as we may have a
+	 * mix of RDs that have had LPIs enabled, and some that
+	 * don't. We'll free the unused ones as each CPU comes online.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct page *pend_page;
+
+		pend_page = its_allocate_pending_table(GFP_NOWAIT);
+		if (!pend_page) {
+			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
+			return -ENOMEM;
+		}
+
+		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	}
 
-	paddr = page_to_phys(pend_page);
-	pr_info("CPU%d: using LPI pending table @%pa\n", cpu, &paddr);
-	gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	return 0;
 }
 
@@ -1906,13 +1910,15 @@ static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
 	struct page *pend_page;
+	phys_addr_t paddr;
 	u64 val, tmp;
 
-	/* If we didn't allocate the pending table yet, do it now */
-	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page)
+	if (gic_data_rdist()->lpi_enabled)
 		return;
 
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
+
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
@@ -1964,6 +1970,10 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+	gic_data_rdist()->lpi_enabled = true;
+	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
+		smp_processor_id(),
+		&paddr);
 }
 
 static void its_cpu_init_collection(struct its_node *its)
@@ -2744,7 +2754,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
 
 	/* Allocate VPT */
-	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
+	vpt_page = its_allocate_pending_table(GFP_KERNEL);
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3439,16 +3449,6 @@ static int redist_disable_lpis(void)
 	u64 timeout = USEC_PER_SEC;
 	u64 val;
 
-	/*
-	 * If coming via a CPU hotplug event, we don't need to disable
-	 * LPIs before trying to re-enable them. They are already
-	 * configured and all is well in the world. Detect this case
-	 * by checking the allocation of the pending table for the
-	 * current CPU.
-	 */
-	if (gic_data_rdist()->pend_page)
-		return 0;
-
 	if (!gic_rdists_supports_plpis()) {
 		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 		return -ENXIO;
@@ -3458,7 +3458,18 @@ static int redist_disable_lpis(void)
 	if (!(val & GICR_CTLR_ENABLE_LPIS))
 		return 0;
 
-	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
+	/*
+	 * If coming via a CPU hotplug event, we don't need to disable
+	 * LPIs before trying to re-enable them. They are already
+	 * configured and all is well in the world.
+	 */
+	if (gic_data_rdist()->lpi_enabled)
+		return 0;
+
+	/*
+	 * From that point on, we only try to do some damage control.
+	 */
+	pr_warn("GICv3: CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
 		smp_processor_id());
 	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
 
@@ -3714,18 +3725,9 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	err = its_alloc_lpi_tables();
-	if (err)
-		return err;
 
-	err = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "irqchip/arm/gicv3:prepare",
-				its_alloc_pend_page, NULL);
-	if (err < 0) {
-		pr_warn("ITS: Can't register CPU-hoplug callback.\n");
-		return err;
-	}
-	err = its_alloc_pend_page(smp_processor_id());
-	if (err < 0)
+	err = allocate_lpi_tables();
+	if (err)
 		return err;
 
 	list_for_each_entry(its, &its_nodes, entry)
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 806beda1040b1..6c7f666c0e330 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -438,12 +438,10 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 
 		if (!timespec_valid(&ts))
 			return -EINVAL;
-		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+		hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires_range_ns(&to->timer, timespec_to_ktime(ts),
 					     current->timer_slack_ns);
-
-		hrtimer_init_sleeper(to, current);
 	}
 
 	while (1) {
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index cbb872c1b607c..f4bf3bd5f3db2 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -574,6 +574,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
+		bool		lpi_enabled;
 	} __percpu		*rdist;
 	struct page		*prop_page;
 	int			id_bits;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 530118fbfe210..7d789c1b316b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -968,7 +968,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
