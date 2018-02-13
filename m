Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966305AbeBMXtv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:49:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:53401 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966228AbeBMXtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822348"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 16/22] x86/intel_rdt: Create debugfs files for pseudo-locking testing
Date: Tue, 13 Feb 2018 07:47:00 -0800
Message-Id: <fca13ab7b646bb6820b340312a205db4adce4ed0.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
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

The new debugfs file "measure_trigger" will, when the
pseudo_lock_mem_latency tracepoint is enabled, record the latency of
accessing each cache line twice.

Kernel tracepoints offer us histograms that is a simple way to visualize
the memory access latency and immediately see any cache misses. For
example, the hist trigger below before trigger of the measurement
will display the memory access latency and instances at each
latency:
echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/pseudo_lock/\
                           pseudo_lock_mem_latency/trigger

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/Kconfig                                  |  11 ++
 arch/x86/kernel/cpu/Makefile                      |   1 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 203 ++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h |  22 +++
 4 files changed, 237 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 20da391b5f32..640d212cecfd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -455,6 +455,17 @@ config INTEL_RDT
 
 	  Say N if unsure.
 
+config INTEL_RDT_DEBUGFS
+	bool "Intel RDT debugfs interface"
+	depends on INTEL_RDT
+	select HIST_TRIGGERS
+	select DEBUG_FS
+	---help---
+	  Enable the creation of Intel RDT debugfs files. In support of
+	  debugging and validation of Intel RDT sub-features that use it.
+
+	  Say N if unsure.
+
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
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
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index e9ab724432f8..c03413021f45 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -22,6 +22,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/kernfs.h>
 #include <linux/kref.h>
 #include <linux/kthread.h>
@@ -33,6 +34,11 @@
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
@@ -69,6 +75,17 @@ static int thread_done;
  */
 static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+/*
+ * Pointers to debugfs directories. @debugfs_resctrl points to the top-level
+ * directory named resctrl. This can be moved to a central area when other
+ * RDT components start using it.
+ * @debugfs_pseudo points to the pseudo_lock directory under resctrl.
+ */
+static struct dentry *debugfs_resctrl;
+static struct dentry *debugfs_pseudo;
+#endif
+
 /**
  * struct pseudo_lock_region - pseudo-lock region information
  * @kn:			kernfs node representing this region in the resctrl
@@ -91,6 +108,8 @@ static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
  *			region via kernfs
  * @deleted:		user requested removal of region via rmdir on kernfs
  * @kmem:		the kernel memory associated with pseudo-locked region
+ * @debugfs_dir:	pointer to this region's directory in the debugfs
+ *			filesystem
  */
 struct pseudo_lock_region {
 	struct kernfs_node	*kn;
@@ -106,6 +125,9 @@ struct pseudo_lock_region {
 	struct kref		refcount;
 	bool			deleted;
 	void			*kmem;
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	struct dentry		*debugfs_dir;
+#endif
 };
 
 /*
@@ -192,6 +214,9 @@ static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
 					     plr->d->ctrl_val[0] | plr->cbm);
 		pseudo_lock_region_clear(plr);
 	}
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	debugfs_remove_recursive(plr->debugfs_dir);
+#endif
 	kfree(plr);
 	if (is_new_plr)
 		new_plr = NULL;
@@ -291,6 +316,135 @@ bool cbm_pseudo_locked(unsigned long cbm, struct rdt_domain *d)
 	return false;
 }
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+static int measure_cycles_fn(void *_plr)
+{
+	struct pseudo_lock_region *plr = _plr;
+	unsigned long flags;
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
+	preempt_disable();
+	local_irq_save(flags);
+	/*
+	 * The wrmsr call may be reordered with the assignment below it.
+	 * Call wrmsr as directly as possible to avoid tracing clobbering
+	 * local register variable used for memory pointer.
+	 */
+	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	mem_r = plr->kmem;
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
+	local_irq_restore(flags);
+	preempt_enable();
+	thread_done = 1;
+	wake_up_interruptible(&wq);
+	return 0;
+}
+
+static int pseudo_measure_cycles(struct pseudo_lock_region *plr)
+{
+	struct task_struct *thread;
+	unsigned int cpu;
+	int ret;
+
+	cpus_read_lock();
+	mutex_lock(&rdt_pseudo_lock_mutex);
+
+	if (!plr->locked || plr->deleted) {
+		ret = 0;
+		goto out;
+	}
+
+	thread_done = 0;
+	cpu = cpumask_first(&plr->d->cpu_mask);
+	if (!cpu_online(cpu)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	thread = kthread_create_on_node(measure_cycles_fn, plr,
+					cpu_to_node(cpu),
+					"pseudo_lock_measure/%u", cpu);
+	if (IS_ERR(thread)) {
+		ret = PTR_ERR(thread);
+		goto out;
+	}
+	kthread_bind(thread, cpu);
+	wake_up_process(thread);
+
+	ret = wait_event_interruptible(wq, thread_done == 1);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	mutex_unlock(&rdt_pseudo_lock_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+static ssize_t pseudo_measure_trigger(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct pseudo_lock_region *plr = file->private_data;
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
+	if (ret == 0) {
+		ret = debugfs_file_get(file->f_path.dentry);
+		if (ret == 0 && bv) {
+			ret = pseudo_measure_cycles(plr);
+			if (ret == 0)
+				ret = count;
+		}
+		debugfs_file_put(file->f_path.dentry);
+	}
+
+	return ret;
+}
+
+static const struct file_operations pseudo_measure_fops = {
+	.write = pseudo_measure_trigger,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+#endif /* CONFIG_INTEL_RDT_DEBUGFS */
+
 /**
  * pseudo_lock_avail_get - return bitmask of cache available for locking
  * @r: resource to which this cache instance belongs
@@ -858,6 +1012,9 @@ int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
 {
 	struct pseudo_lock_region *plr;
 	struct kernfs_node *kn;
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	struct dentry *entry;
+#endif
 	int ret = 0;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -889,12 +1046,32 @@ int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
 	if (ret)
 		goto out_remove;
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	plr->debugfs_dir = debugfs_create_dir(plr->kn->name, debugfs_pseudo);
+	if (IS_ERR(plr->debugfs_dir)) {
+		ret = PTR_ERR(plr->debugfs_dir);
+		plr->debugfs_dir = NULL;
+		goto out_remove;
+	}
+
+	entry = debugfs_create_file("measure_trigger", 0200, plr->debugfs_dir,
+				    plr, &pseudo_measure_fops);
+	if (IS_ERR(entry)) {
+		ret = PTR_ERR(entry);
+		goto out_debugfs;
+	}
+#endif
+
 	kref_init(&plr->refcount);
 	kernfs_activate(kn);
 	new_plr = plr;
 	ret = 0;
 	goto out;
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+out_debugfs:
+	debugfs_remove_recursive(plr->debugfs_dir);
+#endif
 out_remove:
 	kernfs_remove(kn);
 out_free:
@@ -990,6 +1167,23 @@ static u64 get_prefetch_disable_bits(void)
 	return 0;
 }
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+static int pseudo_lock_debugfs_create(void)
+{
+	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
+	if (IS_ERR(debugfs_resctrl))
+		return PTR_ERR(debugfs_resctrl);
+
+	debugfs_pseudo = debugfs_create_dir("pseudo_lock", debugfs_resctrl);
+	if (IS_ERR(debugfs_pseudo)) {
+		debugfs_remove_recursive(debugfs_resctrl);
+		return PTR_ERR(debugfs_pseudo);
+	}
+
+	return 0;
+}
+#endif
+
 /**
  * rdt_pseudo_lock_fs_init - Create and initialize pseudo-locking files
  * @root: location in kernfs where directory and files should be created
@@ -1068,6 +1262,12 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
 	if (ret)
 		goto error;
 
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	ret = pseudo_lock_debugfs_create();
+	if (ret < 0)
+		goto error;
+#endif
+
 	kernfs_activate(pseudo_lock_kn);
 
 	ret = 0;
@@ -1116,6 +1316,9 @@ void rdt_pseudo_lock_fs_remove(void)
 			}
 		}
 	}
+#ifdef CONFIG_INTEL_RDT_DEBUGFS
+	debugfs_remove_recursive(debugfs_resctrl);
+#endif
 	kernfs_remove(pseudo_lock_kn);
 	pseudo_lock_kn = NULL;
 	mutex_unlock(&rdt_pseudo_lock_mutex);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
new file mode 100644
index 000000000000..cd74d1a0f592
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
@@ -0,0 +1,22 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pseudo_lock
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
