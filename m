Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeFEPkJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:40:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:51542 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeFEPkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:40:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="205516815"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/lbr: Optimizing context switch for LBR call stack
Date: Tue,  5 Jun 2018 08:38:46 -0700
Message-Id: <1528213126-4312-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528213126-4312-1-git-send-email-kan.liang@linux.intel.com>
References: <1528213126-4312-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Context switches with perf LBR call stack context are fairly expensive
because they do a lot of MSR writes. Currently we unconditionally do the
expensive operation when LBR call stack is enabled. It's not necessary
for some common cases, e.g task -> other kernel thread -> same task.
The LBR registers are not changed, hence they don't need to be
rewritten/restored.

Introducing per-cpu variables to track the last LBR call stack context.
If the same context is scheduled in, the rewrite/restore is not
required, with the following two exceptions:
- The LBR registers may be modified by a normal LBR event, i.e., adding
  a new LBR event or scheduling an existing LBR event. In both cases,
  the LBR registers are reset first. The last LBR call stack information
  is cleared in intel_pmu_lbr_reset(). Restoring the LBR registers is
  required.
- The LBR registers are initialized to zero in C6.
  If the LBR registers which TOS points is cleared, C6 must be entered
  while swapped out. Restoring the LBR registers is required as well.
These exceptions are not common.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 24 +++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index a417004..f3e006b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -216,6 +216,8 @@ static void intel_pmu_lbr_reset_64(void)
 
 void intel_pmu_lbr_reset(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
 	if (!x86_pmu.lbr_nr)
 		return;
 
@@ -223,6 +225,9 @@ void intel_pmu_lbr_reset(void)
 		intel_pmu_lbr_reset_32();
 	else
 		intel_pmu_lbr_reset_64();
+
+	cpuc->last_task_ctx = NULL;
+	cpuc->last_log_id = 0;
 }
 
 /*
@@ -334,6 +339,7 @@ static inline u64 rdlbr_to(unsigned int idx)
 
 static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int i;
 	unsigned lbr_idx, mask;
 	u64 tos;
@@ -344,8 +350,20 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 		return;
 	}
 
-	mask = x86_pmu.lbr_nr - 1;
 	tos = task_ctx->tos;
+	/*
+	 * Does not restore the LBR registers, if
+	 * - No one else touched them, and
+	 * - Did not enter C6
+	 */
+	if ((task_ctx == cpuc->last_task_ctx) &&
+	    (task_ctx->log_id == cpuc->last_log_id) &&
+	    rdlbr_from(tos)) {
+		task_ctx->lbr_stack_state = LBR_NONE;
+		return;
+	}
+
+	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
 		lbr_idx = (tos - i) & mask;
 		wrlbr_from(lbr_idx, task_ctx->lbr_from[i]);
@@ -369,6 +387,7 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 
 static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	unsigned lbr_idx, mask;
 	u64 tos, from;
 	int i;
@@ -393,6 +412,9 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
 	task_ctx->lbr_stack_state = LBR_VALID;
+
+	cpuc->last_task_ctx = task_ctx;
+	cpuc->last_log_id = ++task_ctx->log_id;
 }
 
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6b72a92..2430398 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -163,6 +163,7 @@ struct intel_excl_cntrs {
 	unsigned	core_id;	/* per-core: core id */
 };
 
+struct x86_perf_task_context;
 #define MAX_LBR_ENTRIES		32
 
 enum {
@@ -214,6 +215,8 @@ struct cpu_hw_events {
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	struct er_account		*lbr_sel;
 	u64				br_sel;
+	struct x86_perf_task_context	*last_task_ctx;
+	int				last_log_id;
 
 	/*
 	 * Intel host/guest exclude bits
@@ -651,6 +654,7 @@ struct x86_perf_task_context {
 	int valid_lbrs;
 	int lbr_callstack_users;
 	int lbr_stack_state;
+	int log_id;
 };
 
 #define x86_add_quirk(func_)						\
-- 
2.7.4
