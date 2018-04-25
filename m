Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756279AbeDYSSv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:18:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:41720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756024AbeDYSMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243749"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 29/39] x86/intel_rdt: Pseudo-lock region creation/removal core
Date: Wed, 25 Apr 2018 03:10:05 -0700
Message-Id: <31027d1150a9c5deebf5e9e78609dc101e927075.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user requests a pseudo-locked region by providing a schemata to a
resource group that is in the pseudo-locksetup mode. This is the
functionality that consumes the parsed user data and creates the
pseudo-locked region.

First, required information is deduced from user provided data.
This includes, how much memory does the requested bitmask represent,
which CPU the requested region is associated with, and what is the
cache line size of that cache (to learn the stride needed for locking).
Second, a contiguous block of memory matching the requested bitmask is
allocated.

Finally, pseudo-locking is performed. The resource group already has the
allocation that reflects the requested bitmask. With this class of service
active and interference minimized, the allocated memory is loaded into the
cache.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  17 ++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 334 ++++++++++++++++++++++++++++
 2 files changed, 351 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index acc08b850f41..c33bad31bf9f 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -128,11 +128,26 @@ struct mongroup {
  * @d:			RDT domain to which this pseudo-locked region
  *			belongs
  * @cbm:		bitmask of the pseudo-locked region
+ * @lock_thread_wq:	waitqueue used to wait on the pseudo-locking thread
+ *			completion
+ * @thread_done:	variable used by waitqueue to test if pseudo-locking
+ *			thread completed
+ * @cpu:		core associated with the cache on which the setup code
+ *			will be run
+ * @line_size:		size of the cache lines
+ * @size:		size of pseudo-locked region in bytes
+ * @kmem:		the kernel memory associated with pseudo-locked region
  */
 struct pseudo_lock_region {
 	struct rdt_resource	*r;
 	struct rdt_domain	*d;
 	u32			cbm;
+	wait_queue_head_t	lock_thread_wq;
+	int			thread_done;
+	int			cpu;
+	unsigned int		line_size;
+	unsigned int		size;
+	void			*kmem;
 };
 
 /**
@@ -490,6 +505,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
 bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, u32 _cbm);
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
+int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
+void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
 void closid_free(int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index aa3e0a15c246..a347f42010c8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -19,8 +19,14 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/kthread.h>
 #include <linux/slab.h>
+#include <asm/cacheflush.h>
 #include <asm/intel-family.h>
+#include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
 /*
@@ -88,6 +94,51 @@ static u64 get_prefetch_disable_bits(void)
 }
 
 /**
+ * pseudo_lock_region_init - Initialize pseudo-lock region information
+ * @plr: pseudo-lock region
+ *
+ * Called after user provided a schemata to be pseudo-locked. From the
+ * schemata the &struct pseudo_lock_region is on entry already initialized
+ * with the resource, domain, and capacity bitmask. Here the information
+ * required for pseudo-locking is deduced from this data and &struct
+ * pseudo_lock_region initialized further. This information includes:
+ * - size in bytes of the region to be pseudo-locked
+ * - cache line size to know the stride with which data needs to be accessed
+ *   to be pseudo-locked
+ * - a cpu associated with the cache instance on which the pseudo-locking
+ *   flow can be executed
+ *
+ * Return: 0 on success, <0 on failure. Descriptive error will be written
+ * to last_cmd_status buffer.
+ */
+static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(plr->cpu);
+	int i;
+
+	/* Pick the first cpu we find that is associated with the cache. */
+	plr->cpu = cpumask_first(&plr->d->cpu_mask);
+
+	if (!cpu_online(plr->cpu)) {
+		rdt_last_cmd_printf("cpu %u associated with cache not online\n",
+				    plr->cpu);
+		return -ENODEV;
+	}
+
+	plr->size = rdtgroup_cbm_to_size(plr->r, plr->d, plr->cbm);
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == plr->r->cache_level) {
+			plr->line_size = ci->info_list[i].coherency_line_size;
+			return 0;
+		}
+	}
+
+	rdt_last_cmd_puts("unable to determine cache line size\n");
+	return -1;
+}
+
+/**
  * pseudo_lock_init - Initialize a pseudo-lock region
  * @rdtgrp: resource group to which new pseudo-locked region will belong
  *
@@ -106,11 +157,70 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
 	if (!plr)
 		return -ENOMEM;
 
+	init_waitqueue_head(&plr->lock_thread_wq);
 	rdtgrp->plr = plr;
 	return 0;
 }
 
 /**
+ * pseudo_lock_region_clear - Reset pseudo-lock region data
+ * @plr: pseudo-lock region
+ *
+ * All content of the pseudo-locked region is reset - any memory allocated
+ * freed.
+ *
+ * Return: void
+ */
+static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
+{
+	plr->size = 0;
+	plr->line_size = 0;
+	kfree(plr->kmem);
+	plr->kmem = NULL;
+	plr->r = NULL;
+	if (plr->d)
+		plr->d->plr = NULL;
+	plr->d = NULL;
+	plr->cbm = 0;
+}
+
+/**
+ * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-locked
+ * @plr: pseudo-lock region
+ *
+ * Initialize the details required to set up the pseudo-locked region and
+ * allocate the contiguous memory that will be pseudo-locked to the cache.
+ *
+ * Return: 0 on success, <0 on failure.  Descriptive error will be written
+ * to last_cmd_status buffer.
+ */
+static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
+{
+	int ret;
+
+	ret = pseudo_lock_region_init(plr);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * We do not yet support contiguous regions larger than
+	 * KMALLOC_MAX_SIZE.
+	 */
+	if (plr->size > KMALLOC_MAX_SIZE) {
+		rdt_last_cmd_puts("requested region exceeds maximum size\n");
+		return -E2BIG;
+	}
+
+	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
+	if (!plr->kmem) {
+		rdt_last_cmd_puts("unable to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
  * pseudo_lock_free - Free a pseudo-locked region
  * @rdtgrp: resource group to which pseudo-locked region belonged
  *
@@ -122,11 +232,143 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
  */
 static void pseudo_lock_free(struct rdtgroup *rdtgrp)
 {
+	pseudo_lock_region_clear(rdtgrp->plr);
 	kfree(rdtgrp->plr);
 	rdtgrp->plr = NULL;
 }
 
 /**
+ * pseudo_lock_fn - Load kernel memory into cache
+ * @_rdtgrp: resource group to which pseudo-lock region belongs
+ *
+ * This is the core pseudo-locking flow.
+ *
+ * First we ensure that the kernel memory cannot be found in the cache.
+ * Then, while taking care that there will be as little interference as
+ * possible, the memory to be loaded is accessed while core is running
+ * with class of service set to the bitmask of the pseudo-locked region.
+ * After this is complete no future CAT allocations will be allowed to
+ * overlap with this bitmask.
+ *
+ * Local register variables are utilized to ensure that the memory region
+ * to be locked is the only memory access made during the critical locking
+ * loop.
+ *
+ * Return: 0. Waiter on waitqueue will be woken on completion.
+ */
+static int pseudo_lock_fn(void *_rdtgrp)
+{
+	struct rdtgroup *rdtgrp = _rdtgrp;
+	struct pseudo_lock_region *plr = rdtgrp->plr;
+	u32 rmid_p, closid_p;
+	u64 i;
+#ifdef CONFIG_KASAN
+	/*
+	 * The registers used for local register variables are also used
+	 * when KASAN is active. When KASAN is active we use a regular
+	 * variable to ensure we always use a valid pointer, but the cost
+	 * is that this variable will enter the cache through evicting the
+	 * memory we are trying to lock into the cache. Thus expect lower
+	 * pseudo-locking success rate when KASAN is active.
+	 */
+	unsigned int line_size;
+	unsigned int size;
+	void *mem_r;
+#else
+	register unsigned int line_size asm("esi");
+	register unsigned int size asm("edi");
+#ifdef CONFIG_X86_64
+	register void *mem_r asm("rbx");
+#else
+	register void *mem_r asm("ebx");
+#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_KASAN */
+
+	/*
+	 * Make sure none of the allocated memory is cached. If it is we
+	 * will get a cache hit in below loop from outside of pseudo-locked
+	 * region.
+	 * wbinvd (as opposed to clflush/clflushopt) is required to
+	 * increase likelihood that allocated cache portion will be filled
+	 * with associated memory.
+	 */
+	native_wbinvd();
+
+	/*
+	 * Always called with interrupts enabled. By disabling interrupts
+	 * ensure that we will not be preempted during this critical section.
+	 */
+	local_irq_disable();
+
+	/*
+	 * Call wrmsr and rdmsr as directly as possible to avoid tracing
+	 * clobbering local register variables or affecting cache accesses.
+	 *
+	 * Disable the hardware prefetcher so that when the end of the memory
+	 * being pseudo-locked is reached the hardware will not read beyond
+	 * the buffer and evict pseudo-locked memory read earlier from the
+	 * cache.
+	 */
+	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	closid_p = this_cpu_read(pqr_state.cur_closid);
+	rmid_p = this_cpu_read(pqr_state.cur_rmid);
+	mem_r = plr->kmem;
+	size = plr->size;
+	line_size = plr->line_size;
+	/*
+	 * Critical section begin: start by writing the closid associated
+	 * with the capacity bitmask of the cache region being
+	 * pseudo-locked followed by reading of kernel memory to load it
+	 * into the cache.
+	 */
+	__wrmsr(IA32_PQR_ASSOC, rmid_p, rdtgrp->closid);
+	/*
+	 * Cache was flushed earlier. Now access kernel memory to read it
+	 * into cache region associated with just activated plr->closid.
+	 * Loop over data twice:
+	 * - In first loop the cache region is shared with the page walker
+	 *   as it populates the paging structure caches (including TLB).
+	 * - In the second loop the paging structure caches are used and
+	 *   cache region is populated with the memory being referenced.
+	 */
+	for (i = 0; i < size; i += PAGE_SIZE) {
+		/*
+		 * Add a barrier to prevent speculative execution of this
+		 * loop reading beyond the end of the buffer.
+		 */
+		rmb();
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			:
+			: "r" (mem_r), "r" (i)
+			: "%eax", "memory");
+	}
+	for (i = 0; i < size; i += line_size) {
+		/*
+		 * Add a barrier to prevent speculative execution of this
+		 * loop reading beyond the end of the buffer.
+		 */
+		rmb();
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			:
+			: "r" (mem_r), "r" (i)
+			: "%eax", "memory");
+	}
+	/*
+	 * Critical section end: restore closid with capacity bitmask that
+	 * does not overlap with pseudo-locked region.
+	 */
+	__wrmsr(IA32_PQR_ASSOC, rmid_p, closid_p);
+
+	/* Re-enable the hardware prefetcher(s) */
+	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	local_irq_enable();
+
+	plr->thread_done = 1;
+	wake_up_interruptible(&plr->lock_thread_wq);
+	return 0;
+}
+
+/**
  * rdtgroup_monitor_in_progress - Test if monitoring in progress
  * @r: resource group being queried
  *
@@ -437,3 +679,95 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	}
 	return false;
 }
+
+/**
+ * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
+ * @rdtgrp: resource group to which pseudo-lock region belongs
+ *
+ * Called when a resource group in the pseudo-locksetup mode receives a
+ * valid schemata that should be pseudo-locked. Since the resource group is
+ * in pseudo-locksetup mode the &struct pseudo_lock_region has already been
+ * allocated and initialized with the essential information. If a failure
+ * occurs the resource group remains in the pseudo-locksetup mode with the
+ * &struct pseudo_lock_region associated with it, but cleared from all
+ * information and ready for the user to re-attempt pseudo-locking by
+ * writing the schemata again.
+ *
+ * Return: 0 if the pseudo-locked region was successfully pseudo-locked, <0
+ * on failure. Descriptive error will be written to last_cmd_status buffer.
+ */
+int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
+{
+	struct pseudo_lock_region *plr = rdtgrp->plr;
+	struct task_struct *thread;
+	int ret;
+
+	ret = pseudo_lock_region_alloc(plr);
+	if (ret < 0)
+		return ret;
+
+	plr->thread_done = 0;
+
+	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
+					cpu_to_node(plr->cpu),
+					"pseudo_lock/%u", plr->cpu);
+	if (IS_ERR(thread)) {
+		ret = PTR_ERR(thread);
+		rdt_last_cmd_printf("locking thread returned error %d\n", ret);
+		goto out_region;
+	}
+
+	kthread_bind(thread, plr->cpu);
+	wake_up_process(thread);
+
+	ret = wait_event_interruptible(plr->lock_thread_wq,
+				       plr->thread_done == 1);
+	if (ret < 0) {
+		/*
+		 * If the thread does not get on the CPU for whatever
+		 * reason and the process which sets up the region is
+		 * interrupted then this will leave the thread in runnable
+		 * state and once it gets on the CPU it will derefence
+		 * the cleared, but not freed, plr struct resulting in an
+		 * empty pseudo-locking loop.
+		 */
+		rdt_last_cmd_puts("locking thread interrupted\n");
+		goto out_region;
+	}
+
+	rdtgrp->mode = RDT_MODE_PSEUDO_LOCKED;
+	closid_free(rdtgrp->closid);
+	ret = 0;
+	goto out;
+
+out_region:
+	pseudo_lock_region_clear(plr);
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_pseudo_lock_remove - Remove a pseudo-locked region
+ * @rdtgrp: resource group to which the pseudo-locked region belongs
+ *
+ * The removal of a pseudo-locked region can be initiated when the resource
+ * group is removed from user space via a "rmdir" from userspace or the
+ * unmount of the resctrl filesystem. On removal the resource group does
+ * not go back to pseudo-locksetup mode before it is removed, instead it is
+ * removed directly. There is thus assymmetry with the creation where the
+ * &struct pseudo_lock_region is removed here while it was not created in
+ * rdtgroup_pseudo_lock_create().
+ *
+ * Return: void
+ */
+void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
+{
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP)
+		/*
+		 * Default group cannot be a pseudo-locked region so we can
+		 * free closid here.
+		 */
+		closid_free(rdtgrp->closid);
+
+	pseudo_lock_free(rdtgrp);
+}
-- 
2.13.6
