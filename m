Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCYIyB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 04:54:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36482 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeCYIx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 04:53:59 -0400
X-Google-Smtp-Source: AG47ELvBeWJyMYBC8NozHDUthu85y5DcYLmSFrgcO8cO68Sx/Ri1BLgKzU93kcPWGc6swCfk2Ado0A==
Date: Sun, 25 Mar 2018 10:53:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] perf fixes
Message-ID: <20180325085355.nu6a66wearbenof4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: c917e0f259908e75bd2a65877e25f9d90c22c848 perf/cgroup: Fix child event counting bug

Misc kernel side fixes:

 - a cgroup events counting fix
 - an x86 Intel PMU truncated-parameter fix
 - an x86 RDPMC fix
 - an x86 API naming fix/rename
 - an x86 uncore driver big-hardware PCI enumeration fix
 - an x86 uncore driver filter constraint fix

 Thanks,

	Ingo

------------------>
Dan Carpenter (1):
      perf/x86/intel: Don't accidentally clear high bits in bdw_limit_period()

Kan Liang (3):
      perf/x86/intel: Disable userspace RDPMC usage for large PEBS
      perf/x86/intel: Rename confusing 'freerunning PEBS' API and implementation to 'large PEBS'
      perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Skylake servers

Song Liu (1):
      perf/cgroup: Fix child event counting bug

Stephane Eranian (1):
      perf/x86/intel/uncore: Add missing filter constraint for SKX CHA event


 arch/x86/events/core.c               |  3 ++-
 arch/x86/events/intel/core.c         | 14 +++++++-------
 arch/x86/events/intel/ds.c           |  6 +++---
 arch/x86/events/intel/uncore_snbep.c | 32 ++++++++++++++++++--------------
 arch/x86/events/perf_event.h         |  6 +++---
 kernel/events/core.c                 | 21 ++++++++++++++++-----
 6 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 140d33288e78..88797c80b3e0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2118,7 +2118,8 @@ static int x86_pmu_event_init(struct perf_event *event)
 			event->destroy(event);
 	}
 
-	if (READ_ONCE(x86_pmu.attr_rdpmc))
+	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
+	    !(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
 		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
 
 	return err;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 56457cb73448..1e41d7508d99 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2952,9 +2952,9 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 	return intel_pebs_aliases_precdist(event);
 }
 
-static unsigned long intel_pmu_free_running_flags(struct perf_event *event)
+static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
-	unsigned long flags = x86_pmu.free_running_flags;
+	unsigned long flags = x86_pmu.large_pebs_flags;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
@@ -2976,8 +2976,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (!event->attr.freq) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
-			      ~intel_pmu_free_running_flags(event)))
-				event->hw.flags |= PERF_X86_EVENT_FREERUNNING;
+			      ~intel_pmu_large_pebs_flags(event)))
+				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
@@ -3194,7 +3194,7 @@ static unsigned bdw_limit_period(struct perf_event *event, unsigned left)
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
 		if (left < 128)
 			left = 128;
-		left &= ~0x3fu;
+		left &= ~0x3fULL;
 	}
 	return left;
 }
@@ -3460,7 +3460,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
-	.free_running_flags	= PEBS_FREERUNNING_FLAGS,
+	.large_pebs_flags	= LARGE_PEBS_FLAGS,
 
 	/*
 	 * Intel PMCs cannot be accessed sanely above 32-bit width,
@@ -3502,7 +3502,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
-	.free_running_flags	= PEBS_FREERUNNING_FLAGS,
+	.large_pebs_flags	= LARGE_PEBS_FLAGS,
 	/*
 	 * Intel PMCs cannot be accessed sanely above 32 bit width,
 	 * so we install an artificial 1<<31 period regardless of
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 18c25ab28557..d8015235ba76 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -935,7 +935,7 @@ void intel_pmu_pebs_add(struct perf_event *event)
 	bool needed_cb = pebs_needs_sched_cb(cpuc);
 
 	cpuc->n_pebs++;
-	if (hwc->flags & PERF_X86_EVENT_FREERUNNING)
+	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs++;
 
 	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
@@ -975,7 +975,7 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	bool needed_cb = pebs_needs_sched_cb(cpuc);
 
 	cpuc->n_pebs--;
-	if (hwc->flags & PERF_X86_EVENT_FREERUNNING)
+	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs--;
 
 	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
@@ -1530,7 +1530,7 @@ void __init intel_ds_init(void)
 			x86_pmu.pebs_record_size =
 						sizeof(struct pebs_record_skl);
 			x86_pmu.drain_pebs = intel_pmu_drain_pebs_nhm;
-			x86_pmu.free_running_flags |= PERF_SAMPLE_TIME;
+			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
 		default:
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 22ec65bc033a..c98b943e58b4 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3343,6 +3343,7 @@ static struct extra_reg skx_uncore_cha_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(0x9134, 0xffff, 0x4),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x35, 0xff, 0x8),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x36, 0xff, 0x8),
+	SNBEP_CBO_EVENT_EXTRA_REG(0x38, 0xff, 0x3),
 	EVENT_EXTRA_END
 };
 
@@ -3562,24 +3563,27 @@ static struct intel_uncore_type *skx_msr_uncores[] = {
 	NULL,
 };
 
+/*
+ * To determine the number of CHAs, it should read bits 27:0 in the CAPID6
+ * register which located at Device 30, Function 3, Offset 0x9C. PCI ID 0x2083.
+ */
+#define SKX_CAPID6		0x9c
+#define SKX_CHA_BIT_MASK	GENMASK(27, 0)
+
 static int skx_count_chabox(void)
 {
-	struct pci_dev *chabox_dev = NULL;
-	int bus, count = 0;
+	struct pci_dev *dev = NULL;
+	u32 val = 0;
 
-	while (1) {
-		chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d, chabox_dev);
-		if (!chabox_dev)
-			break;
-		if (count == 0)
-			bus = chabox_dev->bus->number;
-		if (bus != chabox_dev->bus->number)
-			break;
-		count++;
-	}
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
+	if (!dev)
+		goto out;
 
-	pci_dev_put(chabox_dev);
-	return count;
+	pci_read_config_dword(dev, SKX_CAPID6, &val);
+	val &= SKX_CHA_BIT_MASK;
+out:
+	pci_dev_put(dev);
+	return hweight32(val);
 }
 
 void skx_uncore_cpu_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78f91ec1056e..39cd0615f04f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -69,7 +69,7 @@ struct event_constraint {
 #define PERF_X86_EVENT_RDPMC_ALLOWED	0x0100 /* grant rdpmc permission */
 #define PERF_X86_EVENT_EXCL_ACCT	0x0200 /* accounted EXCL event */
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
-#define PERF_X86_EVENT_FREERUNNING	0x0800 /* use freerunning PEBS */
+#define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
 
 
 struct amd_nb {
@@ -88,7 +88,7 @@ struct amd_nb {
  * REGS_USER can be handled for events limited to ring 3.
  *
  */
-#define PEBS_FREERUNNING_FLAGS \
+#define LARGE_PEBS_FLAGS \
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_ADDR | \
 	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
@@ -608,7 +608,7 @@ struct x86_pmu {
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
 	int 		max_pebs_events;
-	unsigned long	free_running_flags;
+	unsigned long	large_pebs_flags;
 
 	/*
 	 * Intel LBR
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4b838470fac4..709a55b9ad97 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -724,9 +724,15 @@ static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
 
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
 {
-	struct perf_cgroup *cgrp_out = cpuctx->cgrp;
-	if (cgrp_out)
-		__update_cgrp_time(cgrp_out);
+	struct perf_cgroup *cgrp = cpuctx->cgrp;
+	struct cgroup_subsys_state *css;
+
+	if (cgrp) {
+		for (css = &cgrp->css; css; css = css->parent) {
+			cgrp = container_of(css, struct perf_cgroup, css);
+			__update_cgrp_time(cgrp);
+		}
+	}
 }
 
 static inline void update_cgrp_time_from_event(struct perf_event *event)
@@ -754,6 +760,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 {
 	struct perf_cgroup *cgrp;
 	struct perf_cgroup_info *info;
+	struct cgroup_subsys_state *css;
 
 	/*
 	 * ctx->lock held by caller
@@ -764,8 +771,12 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 		return;
 
 	cgrp = perf_cgroup_from_task(task, ctx);
-	info = this_cpu_ptr(cgrp->info);
-	info->timestamp = ctx->timestamp;
+
+	for (css = &cgrp->css; css; css = css->parent) {
+		cgrp = container_of(css, struct perf_cgroup, css);
+		info = this_cpu_ptr(cgrp->info);
+		info->timestamp = ctx->timestamp;
+	}
 }
 
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
