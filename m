Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C4CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6526321841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeLRKeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:34:01 -0500
Received: from mail5.windriver.com ([192.103.53.11]:51056 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeLRKeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:34:00 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBIAUCpc019563
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Dec 2018 02:31:18 -0800
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 02:30:37 -0800
From:   <zhe.he@windriver.com>
To:     <acme@kernel.org>, <ak@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <jolsa@kernel.org>, <jolsa@redhat.com>,
        <kan.liang@linux.intel.com>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of memory allocated in cpu hotplug prepare state
Date:   Tue, 18 Dec 2018 18:30:33 +0800
Message-ID: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The memory of shared_regs excl_cntrs and constraint_list in struct cpu_hw_events
is currently allocated in hotplug prepare state and freed in dying state. The
memory can actually be reused across multiple cpu pluggings.

Besides, in preempt-rt full mode, the freeing can happen in atomic context and
thus cause the following BUG.

BUG: scheduling while atomic: migration/4/44/0x00000002
---- snip ----
Preemption disabled at:
[<ffffffffa1b282e1>] cpu_stopper_thread+0x71/0x100
CPU: 4 PID: 44 Comm: migration/4 Not tainted 4.19.8-rt6-preempt-rt #1
Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E1R1.86C.0100.R03.1411050121 11/05/2014
Call Trace:
 dump_stack+0x4f/0x6a
 ? cpu_stopper_thread+0x71/0x100
 __schedule_bug.cold.16+0x38/0x55
 __schedule+0x484/0x6c0
 schedule+0x3d/0xf0
 rt_spin_lock_slowlock_locked+0x11a/0x2a0
 rt_spin_lock_slowlock+0x57/0x90
 __rt_spin_lock+0x26/0x30
 __write_rt_lock+0x23/0x1a0
 ? intel_pmu_cpu_dying+0x67/0x70
 rt_write_lock+0x2a/0x30
 find_and_remove_object+0x1e/0x80
 delete_object_full+0x10/0x20
 kmemleak_free+0x32/0x50
 kfree+0x104/0x1f0
 intel_pmu_cpu_dying+0x67/0x70
 ? x86_pmu_starting_cpu+0x30/0x30
 x86_pmu_dying_cpu+0x1a/0x30
 cpuhp_invoke_callback+0x9c/0x770
 ? cpu_disable_common+0x241/0x250
 take_cpu_down+0x70/0xa0
 multi_cpu_stop+0x62/0xc0
 ? cpu_stop_queue_work+0x130/0x130
 cpu_stopper_thread+0x79/0x100
 smpboot_thread_fn+0x217/0x2e0
 kthread+0x121/0x140
 ? sort_range+0x30/0x30
 ? kthread_park+0x90/0x90
 ret_from_fork+0x35/0x40

This patch changes to allocate the memory only when it has not been allocated,
and fill it with all zero when it has already been allocated, and remove the
unnecessary freeings.

Credit to Sebastian Andrzej Siewior for his suggestion.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/x86/events/core.c       |  2 +-
 arch/x86/events/intel/core.c | 45 ++++++++++++++++++++------------------------
 arch/x86/events/perf_event.h |  5 ++---
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 374a197..f07d1b1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2010,7 +2010,7 @@ static struct cpu_hw_events *allocate_fake_cpuc(void)
 
 	/* only needed, if we have extra_regs */
 	if (x86_pmu.extra_regs) {
-		cpuc->shared_regs = allocate_shared_regs(cpu);
+		allocate_shared_regs(&cpuc->shared_regs, cpu);
 		if (!cpuc->shared_regs)
 			goto error;
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ecc3e34..a3c18de 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3398,13 +3398,16 @@ ssize_t intel_event_sysfs_show(char *page, u64 config)
 	return x86_event_sysfs_show(page, config, event);
 }
 
-struct intel_shared_regs *allocate_shared_regs(int cpu)
+void allocate_shared_regs(struct intel_shared_regs **pregs, int cpu)
 {
-	struct intel_shared_regs *regs;
+	struct intel_shared_regs *regs = *pregs;
 	int i;
 
-	regs = kzalloc_node(sizeof(struct intel_shared_regs),
-			    GFP_KERNEL, cpu_to_node(cpu));
+	if (regs)
+		memset(regs, 0, sizeof(struct intel_shared_regs));
+	else
+		regs = *pregs = kzalloc_node(sizeof(struct intel_shared_regs),
+					     GFP_KERNEL, cpu_to_node(cpu));
 	if (regs) {
 		/*
 		 * initialize the locks to keep lockdep happy
@@ -3414,20 +3417,21 @@ struct intel_shared_regs *allocate_shared_regs(int cpu)
 
 		regs->core_id = -1;
 	}
-	return regs;
 }
 
-static struct intel_excl_cntrs *allocate_excl_cntrs(int cpu)
+static void allocate_excl_cntrs(struct intel_excl_cntrs **pc, int cpu)
 {
-	struct intel_excl_cntrs *c;
+	struct intel_excl_cntrs *c = *pc;
 
-	c = kzalloc_node(sizeof(struct intel_excl_cntrs),
-			 GFP_KERNEL, cpu_to_node(cpu));
+	if (c)
+		memset(c, 0, sizeof(struct intel_excl_cntrs));
+	else
+		c = *pc = kzalloc_node(sizeof(struct intel_excl_cntrs),
+				       GFP_KERNEL, cpu_to_node(cpu));
 	if (c) {
 		raw_spin_lock_init(&c->lock);
 		c->core_id = -1;
 	}
-	return c;
 }
 
 static int intel_pmu_cpu_prepare(int cpu)
@@ -3435,7 +3439,7 @@ static int intel_pmu_cpu_prepare(int cpu)
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 
 	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
-		cpuc->shared_regs = allocate_shared_regs(cpu);
+		allocate_shared_regs(&cpuc->shared_regs, cpu);
 		if (!cpuc->shared_regs)
 			goto err;
 	}
@@ -3443,11 +3447,14 @@ static int intel_pmu_cpu_prepare(int cpu)
 	if (x86_pmu.flags & PMU_FL_EXCL_CNTRS) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
-		cpuc->constraint_list = kzalloc(sz, GFP_KERNEL);
+		if (cpuc->constraint_list)
+			memset(cpuc->constraint_list, 0, sz);
+		else
+			cpuc->constraint_list = kzalloc(sz, GFP_KERNEL);
 		if (!cpuc->constraint_list)
 			goto err_shared_regs;
 
-		cpuc->excl_cntrs = allocate_excl_cntrs(cpu);
+		allocate_excl_cntrs(&cpuc->excl_cntrs, cpu);
 		if (!cpuc->excl_cntrs)
 			goto err_constraint_list;
 
@@ -3559,18 +3566,6 @@ static void free_excl_cntrs(int cpu)
 
 static void intel_pmu_cpu_dying(int cpu)
 {
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
-	struct intel_shared_regs *pc;
-
-	pc = cpuc->shared_regs;
-	if (pc) {
-		if (pc->core_id == -1 || --pc->refcnt == 0)
-			kfree(pc);
-		cpuc->shared_regs = NULL;
-	}
-
-	free_excl_cntrs(cpu);
-
 	fini_debug_store_on_cpu(cpu);
 
 	if (x86_pmu.counter_freezing)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78d7b70..967bdb6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -877,7 +877,7 @@ struct event_constraint *
 x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event);
 
-struct intel_shared_regs *allocate_shared_regs(int cpu);
+void allocate_shared_regs(struct intel_shared_regs **pregs, int cpu);
 
 int intel_pmu_init(void);
 
@@ -1013,9 +1013,8 @@ static inline int intel_pmu_init(void)
 	return 0;
 }
 
-static inline struct intel_shared_regs *allocate_shared_regs(int cpu)
+static inline void allocate_shared_regs(struct intel_shared_regs **pregs, int cpu)
 {
-	return NULL;
 }
 
 static inline int is_ht_workaround_enabled(void)
-- 
2.7.4

