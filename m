Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBBMrF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:47:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBBMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:46:59 -0500
Date: Fri, 2 Feb 2018 13:46:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180202124647.GK2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <3838689.GpfBVtfPr0@aspire.rjw.lan>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <8930678.7E2iWGoJnn@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8930678.7E2iWGoJnn@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 12:42:29PM +0100, Rafael J. Wysocki wrote:
> > If you really care you can do async IPIs and do a custom serialization
> > that only waits when you do back-to-back things, which should be fairly
> > uncommon I'd think.
> 
> In this particular case we don't want to return to user space before the
> MSR is actually written with the new value.

Why not?

I was thinking of something like the below, which would in fact do
exactly that.

---
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 7edf7a0e5a96..f0caa5cc7adb 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -29,6 +29,7 @@
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
 #include <linux/vmalloc.h>
+#include <linux/smp.h>
 #include <trace/events/power.h>
 
 #include <asm/div64.h>
@@ -767,6 +768,40 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
+static void __intel_pstate_hwp_set_desired(int val)
+{
+	u64 value;
+
+	value = rdmsrl(MSR_HWP_REQUEST);
+	value &= ~GENMASK_ULL(23, 16);
+	value |= (val & 0xff) << 16;
+	wrmsrl(MSR_HWP_REQUEST, val);
+}
+
+static void __intel_pstate_hwp_func(void *data)
+{
+	__intel_pstate_hwp_set_desired((int)data);
+}
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct __call_single_data, csd_data);
+
+static void intel_pstate_hwp_set_desired(int cpu, int val)
+{
+	struct call_function_data *csd;
+
+	preempt_disable();
+	csd = this_cpu_ptr(&csd_data);
+	/* wait for previous invocation to complete */
+	csd_lock_wait(csd);
+
+	csd->func = __intel_pstate_hwp_func;
+	csd->info = (unsigned long)val;
+
+	smp_call_function_single_async(cpu, csd);
+	preempt_enable();
+}
+
+
 static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9fb239e12b82..2bc125ec6146 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -14,6 +14,11 @@
 #include <linux/init.h>
 #include <linux/llist.h>
 
+enum {
+	CSD_FLAG_LOCK		= 0x01,
+	CSD_FLAG_SYNCHRONOUS	= 0x02,
+};
+
 typedef void (*smp_call_func_t)(void *info);
 struct __call_single_data {
 	struct llist_node llist;
@@ -26,6 +31,11 @@ struct __call_single_data {
 typedef struct __call_single_data call_single_data_t
 	__aligned(sizeof(struct __call_single_data));
 
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
+{
+	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
+}
+
 /* total number of cpus in this system (may exceed NR_CPUS) */
 extern unsigned int total_cpus;
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 084c8b3a2681..af0ef9eb7679 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -22,11 +22,6 @@
 
 #include "smpboot.h"
 
-enum {
-	CSD_FLAG_LOCK		= 0x01,
-	CSD_FLAG_SYNCHRONOUS	= 0x02,
-};
-
 struct call_function_data {
 	call_single_data_t	__percpu *csd;
 	cpumask_var_t		cpumask;
@@ -103,11 +98,6 @@ void __init call_function_init(void)
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
-{
-	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
-}
-
 static __always_inline void csd_lock(call_single_data_t *csd)
 {
 	csd_lock_wait(csd);
