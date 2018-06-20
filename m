Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62459C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100C420693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100C420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFTAb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:31:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeFTAbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:31:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0VJY83300295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:31:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0VJT13300292;
        Tue, 19 Jun 2018 17:31:19 -0700
Date:   Tue, 19 Jun 2018 17:31:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-1c1ae3e441636b3be7ed166b97a615dac7823ac3@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, reinette.chatre@intel.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          reinette.chatre@intel.com, tglx@linutronix.de
In-Reply-To: <a2bb234d1eb60957c9644ae1b8d9d95659a739e3.1527593971.git.reinette.chatre@intel.com>
References: <a2bb234d1eb60957c9644ae1b8d9d95659a739e3.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Create debugfs files for
 pseudo-locking testing
Git-Commit-ID: 1c1ae3e441636b3be7ed166b97a615dac7823ac3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1c1ae3e441636b3be7ed166b97a615dac7823ac3
Gitweb:     https://git.kernel.org/tip/1c1ae3e441636b3be7ed166b97a615dac7823ac3
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:59 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:39 +0200

x86/intel_rdt: Create debugfs files for pseudo-locking testing

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

Kernel tracepoints offer us histograms (when CONFIG_HIST_TRIGGERS is
enabled) that is a simple way to visualize the memory access latency
and immediately see any cache misses. For example, the hist trigger
below before trigger of the measurement will display the memory access
latency and instances at each latency:
echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/\
                           pseudo_lock_mem_latency/trigger
echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
echo 1 > /sys/kernel/debug/resctrl/<newlock>/pseudo_lock_measure
echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/a2bb234d1eb60957c9644ae1b8d9d95659a739e3.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/Makefile                      |   1 +
 arch/x86/kernel/cpu/intel_rdt.h                   |   3 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 176 +++++++++++++++++++++-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h |  23 +++
 4 files changed, 202 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index c4e02555563a..347137e80bf5 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 
 obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o
 obj-$(CONFIG_INTEL_RDT)	+= intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock.o
+CFLAGS_intel_rdt_pseudo_lock.o = -I$(src)
 
 obj-$(CONFIG_X86_MCE)			+= mcheck/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index bd3050c1ab6c..9112290f08fb 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -138,6 +138,8 @@ struct mongroup {
  * @line_size:		size of the cache lines
  * @size:		size of pseudo-locked region in bytes
  * @kmem:		the kernel memory associated with pseudo-locked region
+ * @debugfs_dir:	pointer to this region's directory in the debugfs
+ *			filesystem
  */
 struct pseudo_lock_region {
 	struct rdt_resource	*r;
@@ -149,6 +151,7 @@ struct pseudo_lock_region {
 	unsigned int		line_size;
 	unsigned int		size;
 	void			*kmem;
+	struct dentry		*debugfs_dir;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 7e1926748356..7b0ff5017455 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -14,6 +14,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
@@ -21,6 +22,9 @@
 #include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
+#define CREATE_TRACE_POINTS
+#include "intel_rdt_pseudo_lock_event.h"
+
 /*
  * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
  * prefetcher state. Details about this register can be found in the MSR
@@ -176,6 +180,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 		plr->d->plr = NULL;
 	plr->d = NULL;
 	plr->cbm = 0;
+	plr->debugfs_dir = NULL;
 }
 
 /**
@@ -692,6 +697,161 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	return ret;
 }
 
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
+		if (ret)
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
+
 /**
  * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
  * @rdtgrp: resource group to which pseudo-lock region belongs
@@ -747,6 +907,15 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		goto out_region;
 	}
 
+	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
+		plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
+						      debugfs_resctrl);
+		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
+			debugfs_create_file("pseudo_lock_measure", 0200,
+					    plr->debugfs_dir, rdtgrp,
+					    &pseudo_measure_fops);
+	}
+
 	rdtgrp->mode = RDT_MODE_PSEUDO_LOCKED;
 	closid_free(rdtgrp->closid);
 	ret = 0;
@@ -774,12 +943,17 @@ out:
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
+	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
 
+free:
 	pseudo_lock_free(rdtgrp);
 }
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
new file mode 100644
index 000000000000..3cd0fa27d5fe
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
