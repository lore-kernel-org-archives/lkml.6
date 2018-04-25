Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756258AbeDYSSM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:18:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:34634 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932258AbeDYSM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243766"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 34/39] x86/intel_rdt: Create debugfs files for pseudo-locking testing
Date: Wed, 25 Apr 2018 03:10:10 -0700
Message-Id: <23bbbbc1ad871f24356edd950972e288d8af2f35.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no simple yes/no test to determine if pseudo-locking was
successful. In order to test pseudo-locking we expose a debugfs file for
each pseudo-locked region that will record the latency of reading the
pseudo-locked memory at a stride of 32 bytes (hardcoded). These numbers
will give us an idea of locking was successful or not since they will
reflect cache hits and cache misses (hardware prefetching is disabled
during the test).

The new debugfs file "pseudo_lock_measure" will, when the
pseudo_lock_mem_latency tracepoint is enabled, record the latency of
accessing each cache line twice.

Kernel tracepoints offer us histograms that is a simple way to visualize
the memory access latency and immediately see any cache misses. For
example, the hist trigger below before trigger of the measurement
will display the memory access latency and instances at each
latency:
echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/\
                           pseudo_lock_mem_latency/trigger
echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
echo 1 > /sys/kernel/debug/resctrl/<newlock>/pseudo_lock_measure
echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/Kconfig                                  |   1 +
 arch/x86/kernel/cpu/Makefile                      |   1 +
 arch/x86/kernel/cpu/intel_rdt.h                   |   5 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 200 +++++++++++++++++++++-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h |  22 +++
 5 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9c1dc17e7a46..640d212cecfd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,6 +458,7 @@ config INTEL_RDT
 config INTEL_RDT_DEBUGFS
 	bool "Intel RDT debugfs interface"
 	depends on INTEL_RDT
+	select HIST_TRIGGERS
 	select DEBUG_FS
 	---help---
 	  Enable the creation of Intel RDT debugfs files. In support of
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 53022c2413e0..9ca7b1625a4a 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 
 obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o
 obj-$(CONFIG_INTEL_RDT)	+= intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock.o
+CFLAGS_intel_rdt_pseudo_lock.o = -I$(src)
 
 obj-$(CONFIG_X86_MCE)			+= mcheck/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index e96ef28d7d42..be62c39e18f6 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -137,6 +137,8 @@ struct mongroup {
  * @line_size:		size of the cache lines
  * @size:		size of pseudo-locked region in bytes
  * @kmem:		the kernel memory associated with pseudo-locked region
+ * @debugfs_dir:	pointer to this region's directory in the debugfs
+ *			filesystem
  */
 struct pseudo_lock_region {
 	struct rdt_resource	*r;
@@ -148,6 +150,9 @@ struct pseudo_lock_region {
 	unsigned int		line_size;
 	unsigned int		size;
 	void			*kmem;
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	struct dentry		*debugfs_dir;
+#endif
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index a347f42010c8..8a52e5e61f3e 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -22,6 +22,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
@@ -29,6 +30,11 @@
 #include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+#define CREATE_TRACE_POINTS
+#include "intel_rdt_pseudo_lock_event.h"
+#endif
+
 /*
  * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
  * prefetcher state. Details about this register can be found in the MSR
@@ -182,6 +188,9 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 		plr->d->plr = NULL;
 	plr->d = NULL;
 	plr->cbm = 0;
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	plr->debugfs_dir = NULL;
+#endif
 }
 
 /**
@@ -680,6 +689,163 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	return false;
 }
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+/**
+ * measure_cycles_lat_fn - Measure cycle latency to read pseudo-locked memory
+ * @_plr: pseudo-lock region to measure
+ *
+ * There is no deterministic way to test if a memory region is cached. One
+ * way is to measure how long it takes to read the memory, the speed of
+ * access is a good way to learn how close to the cpu the data was. Even
+ * more, if the prefetcher is disabled and the memory is read at a stride
+ * of half the cache line, then a cache miss will be easy to spot since the
+ * read of the first half would be significantly slower than the read of
+ * the second half.
+ *
+ * Return: 0. Waiter on waitqueue will be woken on completion.
+ */
+static int measure_cycles_lat_fn(void *_plr)
+{
+	struct pseudo_lock_region *plr = _plr;
+	u64 start, end;
+	u64 i;
+#ifdef CONFIG_KASAN
+	/*
+	 * The registers used for local register variables are also used
+	 * when KASAN is active. When KASAN is active we use a regular
+	 * variable to ensure we always use a valid pointer to access memory.
+	 * The cost is that accessing this pointer, which could be in
+	 * cache, will be included in the measurement of memory read latency.
+	 */
+	void *mem_r;
+#else
+#ifdef CONFIG_X86_64
+	register void *mem_r asm("rbx");
+#else
+	register void *mem_r asm("ebx");
+#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_KASAN */
+
+	local_irq_disable();
+	/*
+	 * The wrmsr call may be reordered with the assignment below it.
+	 * Call wrmsr as directly as possible to avoid tracing clobbering
+	 * local register variable used for memory pointer.
+	 */
+	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	mem_r = plr->kmem;
+	/*
+	 * Dummy execute of the time measurement to load the needed
+	 * instructions into the L1 instruction cache.
+	 */
+	start = rdtsc_ordered();
+	for (i = 0; i < plr->size; i += 32) {
+		start = rdtsc_ordered();
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			     :
+			     : "r" (mem_r), "r" (i)
+			     : "%eax", "memory");
+		end = rdtsc_ordered();
+		trace_pseudo_lock_mem_latency((u32)(end - start));
+	}
+	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	local_irq_enable();
+	plr->thread_done = 1;
+	wake_up_interruptible(&plr->lock_thread_wq);
+	return 0;
+}
+
+/**
+ * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
+ *
+ * The measurement of latency to access a pseudo-locked region should be
+ * done from a cpu that is associated with that pseudo-locked region.
+ * Determine which cpu is associated with this region and start a thread on
+ * that cpu to perform the measurement, wait for that thread to complete.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp)
+{
+	struct pseudo_lock_region *plr = rdtgrp->plr;
+	struct task_struct *thread;
+	unsigned int cpu;
+	int ret;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	if (rdtgrp->flags & RDT_DELETED) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	plr->thread_done = 0;
+	cpu = cpumask_first(&plr->d->cpu_mask);
+	if (!cpu_online(cpu)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
+					cpu_to_node(cpu),
+					"pseudo_lock_measure/%u", cpu);
+	if (IS_ERR(thread)) {
+		ret = PTR_ERR(thread);
+		goto out;
+	}
+	kthread_bind(thread, cpu);
+	wake_up_process(thread);
+
+	ret = wait_event_interruptible(plr->lock_thread_wq,
+				       plr->thread_done == 1);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+static ssize_t pseudo_lock_measure_trigger(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct rdtgroup *rdtgrp = file->private_data;
+	size_t buf_size;
+	char buf[32];
+	int ret;
+	bool bv;
+
+	buf_size = min(count, (sizeof(buf) - 1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	ret = strtobool(buf, &bv);
+	if (ret == 0 && bv) {
+		ret = debugfs_file_get(file->f_path.dentry);
+		if (unlikely(ret))
+			return ret;
+		ret = pseudo_lock_measure_cycles(rdtgrp);
+		if (ret == 0)
+			ret = count;
+		debugfs_file_put(file->f_path.dentry);
+	}
+
+	return ret;
+}
+
+static const struct file_operations pseudo_measure_fops = {
+	.write = pseudo_lock_measure_trigger,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+#endif /* CONFIG_INTEL_RDT_DEBUGFS */
+
 /**
  * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
  * @rdtgrp: resource group to which pseudo-lock region belongs
@@ -700,6 +866,9 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 {
 	struct pseudo_lock_region *plr = rdtgrp->plr;
 	struct task_struct *thread;
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	struct dentry *entry;
+#endif
 	int ret;
 
 	ret = pseudo_lock_region_alloc(plr);
@@ -735,11 +904,33 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		goto out_region;
 	}
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
+					      debugfs_resctrl);
+	if (IS_ERR(plr->debugfs_dir)) {
+		ret = PTR_ERR(plr->debugfs_dir);
+		plr->debugfs_dir = NULL;
+		goto out_region;
+	}
+
+	entry = debugfs_create_file("pseudo_lock_measure", 0200,
+				    plr->debugfs_dir, rdtgrp,
+				    &pseudo_measure_fops);
+	if (IS_ERR(entry)) {
+		ret = PTR_ERR(entry);
+		goto out_debugfs;
+	}
+#endif
+
 	rdtgrp->mode = RDT_MODE_PSEUDO_LOCKED;
 	closid_free(rdtgrp->closid);
 	ret = 0;
 	goto out;
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+out_debugfs:
+	debugfs_remove_recursive(plr->debugfs_dir);
+#endif
 out_region:
 	pseudo_lock_region_clear(plr);
 out:
@@ -762,12 +953,19 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
  */
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 {
-	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP)
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 		/*
 		 * Default group cannot be a pseudo-locked region so we can
 		 * free closid here.
 		 */
 		closid_free(rdtgrp->closid);
+		goto free;
+	}
+
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
+#endif
 
+free:
 	pseudo_lock_free(rdtgrp);
 }
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
new file mode 100644
index 000000000000..19d5e08cffb5
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
@@ -0,0 +1,22 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM resctrl
+
+#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PSEUDO_LOCK_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(pseudo_lock_mem_latency,
+	    TP_PROTO(u32 latency),
+	    TP_ARGS(latency),
+	    TP_STRUCT__entry(__field(u32, latency)),
+	    TP_fast_assign(__entry->latency = latency),
+	    TP_printk("latency=%u", __entry->latency)
+	   );
+
+#endif /* _TRACE_PSEUDO_LOCK_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE intel_rdt_pseudo_lock_event
+#include <trace/define_trace.h>
-- 
2.13.6
