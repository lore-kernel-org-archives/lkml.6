Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeEUJ0K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:26:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54243 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeEUJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:25:57 -0400
X-Google-Smtp-Source: AB8JxZpbQynbDkEQ91qFeUvtsu3UUjb9NExhCOTpfrt0aC0oBtGr8M7fEUW8ejeygpkebr5Y98jsXg==
From: Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [RFC] perf: Allow fine-grained PMU access control
Date: Mon, 21 May 2018 10:25:49 +0100
Message-Id: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

For situations where sysadmins might want to allow different level of
of access control for different PMUs, we start creating per-PMU
perf_event_paranoid controls in sysfs.

These work in equivalent fashion as the existing perf_event_paranoid
sysctl, which now becomes the parent control for each PMU.

On PMU registration the global/parent value will be inherited by each PMU,
as it will be propagated to all registered PMUs when the sysctl is
updated.

At any later point individual PMU access controls, located in
<sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
fine grained access control.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/events/intel/bts.c     |  2 +-
 arch/x86/events/intel/core.c    |  2 +-
 arch/x86/events/intel/p4.c      |  2 +-
 include/linux/perf_event.h      | 18 ++++--
 kernel/events/core.c            | 99 +++++++++++++++++++++++++++------
 kernel/sysctl.c                 |  4 +-
 kernel/trace/trace_event_perf.c |  6 +-
 7 files changed, 105 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 24ffa1e88cf9..e416c9e2400a 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -555,7 +555,7 @@ static int bts_event_init(struct perf_event *event)
 	 * Note that the default paranoia setting permits unprivileged
 	 * users to profile the kernel.
 	 */
-	if (event->attr.exclude_kernel && perf_paranoid_kernel() &&
+	if (event->attr.exclude_kernel && perf_paranoid_kernel(event->pmu) &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 707b2a96e516..6b126bdbd16c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3025,7 +3025,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (x86_pmu.version < 3)
 		return -EINVAL;
 
-	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
+	if (perf_paranoid_cpu(event->pmu) && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	event->hw.config |= ARCH_PERFMON_EVENTSEL_ANY;
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index d32c0eed38ca..878451ef1ace 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -776,7 +776,7 @@ static int p4_validate_raw_event(struct perf_event *event)
 	 * the user needs special permissions to be able to use it
 	 */
 	if (p4_ht_active() && p4_event_bind_map[v].shared) {
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_cpu(event->pmu) && !capable(CAP_SYS_ADMIN))
 			return -EACCES;
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e71e99eb9a4e..2d9e7b4bcfac 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -271,6 +271,9 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
+	/* fine grained access control */
+	int				perf_event_paranoid;
+
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
@@ -1159,6 +1162,9 @@ extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
+extern int perf_proc_paranoid_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp,
+		loff_t *ppos);
 extern int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos);
@@ -1169,19 +1175,19 @@ extern int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
 int perf_event_max_stack_handler(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp, loff_t *ppos);
 
-static inline bool perf_paranoid_tracepoint_raw(void)
+static inline bool perf_paranoid_tracepoint_raw(const struct pmu *pmu)
 {
-	return sysctl_perf_event_paranoid > -1;
+	return pmu->perf_event_paranoid > -1;
 }
 
-static inline bool perf_paranoid_cpu(void)
+static inline bool perf_paranoid_cpu(const struct pmu *pmu)
 {
-	return sysctl_perf_event_paranoid > 0;
+	return pmu->perf_event_paranoid > 0;
 }
 
-static inline bool perf_paranoid_kernel(void)
+static inline bool perf_paranoid_kernel(const struct pmu *pmu)
 {
-	return sysctl_perf_event_paranoid > 1;
+	return pmu->perf_event_paranoid > 1;
 }
 
 extern void perf_event_init(void);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 725d37d6e386..f20c41ff9c4b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -432,6 +432,24 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_context *cpuctx);
 
+int perf_proc_paranoid_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp,
+		loff_t *ppos)
+{
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	struct pmu *pmu;
+
+	if (ret || !write)
+		return ret;
+
+	mutex_lock(&pmus_lock);
+	list_for_each_entry(pmu, &pmus, entry)
+		pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
+	mutex_unlock(&pmus_lock);
+
+	return 0;
+}
+
 int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos)
@@ -4113,7 +4131,7 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_cpu(pmu) && !capable(CAP_SYS_ADMIN))
 			return ERR_PTR(-EACCES);
 
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
@@ -5679,7 +5697,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	lock_limit >>= PAGE_SHIFT;
 	locked = vma->vm_mm->pinned_vm + extra;
 
-	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
+	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw(event->pmu) &&
 		!capable(CAP_IPC_LOCK)) {
 		ret = -EPERM;
 		goto unlock;
@@ -9426,6 +9444,41 @@ static void free_pmu_context(struct pmu *pmu)
 	mutex_unlock(&pmus_lock);
 }
 
+/*
+ * Fine-grained access control:
+ */
+static ssize_t
+perf_event_paranoid_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *page)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->perf_event_paranoid);
+}
+
+static ssize_t
+perf_event_paranoid_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	int ret, val;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val < -1 || val > 2)
+		return -EINVAL;
+
+	pmu->perf_event_paranoid = val;
+
+	return count;
+}
+
+DEVICE_ATTR_RW(perf_event_paranoid);
+
 /*
  * Let userspace know that this PMU supports address range filtering:
  */
@@ -9540,6 +9593,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto free_dev;
 
+	/* Add fine-grained access control attribute. */
+	ret = device_create_file(pmu->dev, &dev_attr_perf_event_paranoid);
+	if (ret)
+		goto del_dev;
+
 	/* For PMUs with address filters, throw in an extra attribute: */
 	if (pmu->nr_addr_filters)
 		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -9571,6 +9629,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->pmu_disable_count)
 		goto unlock;
 
+	pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
 	pmu->type = -1;
 	if (!name)
 		goto skip_type;
@@ -10190,10 +10249,6 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			 */
 			attr->branch_sample_type = mask;
 		}
-		/* privileged levels capture (kernel, hv): check permissions */
-		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
-		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
@@ -10410,11 +10465,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
-		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
-	}
-
 	if (attr.namespaces) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -10428,11 +10478,6 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
-	/* Only privileged users can get physical addresses */
-	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
-	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
@@ -10502,6 +10547,28 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_cred;
 	}
 
+	if (!attr.exclude_kernel) {
+		if (perf_paranoid_kernel(event->pmu) &&
+		    !capable(CAP_SYS_ADMIN)) {
+			err = -EACCES;
+			goto err_alloc;
+		}
+	}
+
+	/* Only privileged users can get physical addresses */
+	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
+	    perf_paranoid_kernel(event->pmu) && !capable(CAP_SYS_ADMIN)) {
+		err = -EACCES;
+		goto err_alloc;
+	}
+
+	/* privileged levels capture (kernel, hv): check permissions */
+	if ((attr.branch_sample_type & PERF_SAMPLE_BRANCH_PERM_PLM) &&
+	    perf_paranoid_kernel(event->pmu) && !capable(CAP_SYS_ADMIN)) {
+		err = -EACCES;
+		goto err_alloc;
+	}
+
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6a78cf70761d..aeec3ac5405e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1142,7 +1142,9 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_perf_event_paranoid,
 		.maxlen		= sizeof(sysctl_perf_event_paranoid),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= perf_proc_paranoid_handler,
+		.extra1		= &neg_one,
+		.extra2		= &two,
 	},
 	{
 		.procname	= "perf_event_mlock_kb",
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index c79193e598f5..545a7ef9bfe1 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -45,7 +45,8 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 
 	/* The ftrace function trace is allowed only for root. */
 	if (ftrace_event_is_function(tp_event)) {
-		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_tracepoint_raw(p_event->pmu) &&
+		    !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
 		if (!is_sampling_event(p_event))
@@ -81,7 +82,8 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	 * ...otherwise raw tracepoint data can be a severe data leak,
 	 * only allow root to have these.
 	 */
-	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
+	if (perf_paranoid_tracepoint_raw(p_event->pmu) &&
+	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	return 0;
-- 
2.17.0
