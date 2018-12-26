Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851E22171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLZKBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:01:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:3453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbeLZKA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:00:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 02:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="112107149"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga008.fm.intel.com with ESMTP; 26 Dec 2018 02:00:53 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com
Subject: [PATCH v4 07/10] KVM/x86/vPMU: Add APIs to support host save/restore the guest lbr stack
Date:   Wed, 26 Dec 2018 17:25:35 +0800
Message-Id: <1545816338-1171-8-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <like.xu@intel.com>

This patch adds support to enable/disable the host side save/restore
for the guest lbr stack on vCPU switching. To enable that, the host
creates a perf event for the vCPU, and the event attributes are set
to the user callstack mode lbr so that all the conditions are meet in
the host perf subsystem to save the lbr stack on task switching.

The host side lbr perf event are created only for the purpose of saving
and restoring the lbr stack. There is no need to enable the lbr
functionality for this perf event, because the feature is essentially
used in the vCPU. So use "no_counter=true" to have the perf core not
allocate a counter for this event.

The vcpu_lbr field is added to cpuc, to indicate if the lbr perf event is
used by the vCPU only for context switching. When the perf subsystem
handles this event (e.g. lbr enable or read lbr stack on PMI) and finds
it's non-zero, it simply returns.

Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/intel/lbr.c     | 14 +++++++--
 arch/x86/events/perf_event.h    |  1 +
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.h              |  3 ++
 arch/x86/kvm/pmu_intel.c        | 66 +++++++++++++++++++++++++++++++++++++++++
 include/linux/perf_event.h      |  7 +++++
 kernel/events/core.c            |  7 -----
 7 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 594a91b..1d20051 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -462,6 +462,10 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
+	if (is_kernel_event(event) && event->attr.exclude_guest &&
+	    (current->flags & PF_VCPU))
+		cpuc->vcpu_lbr = 1;
+
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
 	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
@@ -507,6 +511,10 @@ void intel_pmu_lbr_del(struct perf_event *event)
 		task_ctx->lbr_callstack_users--;
 	}
 
+	if (is_kernel_event(event) && event->attr.exclude_guest &&
+	    (current->flags & PF_VCPU))
+		cpuc->vcpu_lbr = 0;
+
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	perf_sched_cb_dec(event->ctx->pmu);
@@ -516,7 +524,7 @@ void intel_pmu_lbr_enable_all(bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->lbr_users)
+	if (cpuc->lbr_users && !cpuc->vcpu_lbr)
 		__intel_pmu_lbr_enable(pmi);
 }
 
@@ -524,7 +532,7 @@ void intel_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->lbr_users)
+	if (cpuc->lbr_users && !cpuc->vcpu_lbr)
 		__intel_pmu_lbr_disable();
 }
 
@@ -658,7 +666,7 @@ void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (!cpuc->lbr_users)
+	if (!cpuc->lbr_users || cpuc->vcpu_lbr)
 		return;
 
 	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1f78d85..bbea559 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -210,6 +210,7 @@ struct cpu_hw_events {
 	/*
 	 * Intel LBR bits
 	 */
+	u8				vcpu_lbr;
 	int				lbr_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0831ac6..fac209b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -469,6 +469,7 @@ struct kvm_pmu {
 	struct kvm_pmc fixed_counters[INTEL_PMC_MAX_FIXED];
 	struct irq_work irq_work;
 	u64 reprogram_pmi;
+	struct perf_event *vcpu_lbr_event;
 };
 
 struct kvm_pmu_ops;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 5f3c7a4..efd8f16 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -122,6 +122,9 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
+extern int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu);
+extern void intel_pmu_disable_save_guest_lbr(struct kvm_vcpu *vcpu);
+
 extern struct kvm_pmu_ops intel_pmu_ops;
 extern struct kvm_pmu_ops amd_pmu_ops;
 #endif /* __KVM_X86_PMU_H */
diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index c04cb6d..6e46354 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -458,6 +458,72 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 		pmu->global_ovf_ctrl = 0;
 }
 
+int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct perf_event *event;
+
+	/*
+	 * The main purpose of this perf event is to have the host perf core
+	 * help save/restore the guest lbr stack on vcpu switching. There is
+	 * no perf counters allocated for the event.
+	 *
+	 * About the attr:
+	 * exclude_guest: set to true to indicate that the event runs on the
+	 *                host only.
+	 * no_counter:    set to true to tell the perf core that this event
+	 *                doesn't need a counter.
+	 * pinned:        set to false, so that the FLEXIBLE events will not
+	 *                be rescheduled for this event which actually doesn't
+	 *                need a perf counter.
+	 * config:        Actually this field won't be used by the perf core
+	 *                as this event doesn't have a perf counter.
+	 * sample_period: Same as above.
+	 * sample_type:   tells the perf core that it is an lbr event.
+	 * branch_sample_type: tells the perf core that the lbr event works in
+	 *                the user callstack mode so that the lbr stack will be
+	 *                saved/restored on vCPU switching.
+	 */
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_RAW,
+		.size = sizeof(attr),
+		.no_counter = true,
+		.exclude_guest = true,
+		.pinned = false,
+		.config = 0,
+		.sample_period = 0,
+		.sample_type = PERF_SAMPLE_BRANCH_STACK,
+		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK |
+				      PERF_SAMPLE_BRANCH_USER,
+	};
+
+	if (pmu->vcpu_lbr_event)
+		return 0;
+
+	event = perf_event_create_kernel_counter(&attr, -1, current, NULL,
+						 NULL);
+	if (IS_ERR(event)) {
+		pr_err("%s: failed %ld\n", __func__, PTR_ERR(event));
+		return -ENOENT;
+	}
+	pmu->vcpu_lbr_event = event;
+
+	return 0;
+}
+
+void intel_pmu_disable_save_guest_lbr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct perf_event *event = pmu->vcpu_lbr_event;
+
+	if (!event)
+		return;
+
+	perf_event_release_kernel(event);
+	pmu->vcpu_lbr_event = NULL;
+}
+
+
 struct kvm_pmu_ops intel_pmu_ops = {
 	.find_arch_event = intel_find_arch_event,
 	.find_fixed_event = intel_find_fixed_event,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e58a997..e2fed1b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1014,6 +1014,13 @@ static inline bool is_no_counter_event(struct perf_event *event)
 	return event->attr.no_counter;
 }
 
+#define TASK_TOMBSTONE ((void *)-1L)
+
+static inline bool is_kernel_event(struct perf_event *event)
+{
+	return READ_ONCE(event->owner) == TASK_TOMBSTONE;
+}
+
 /*
  * Return 1 for a software event, 0 for a hardware event
  */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84530ab..78b0550 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -165,13 +165,6 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 	raw_spin_unlock(&cpuctx->ctx.lock);
 }
 
-#define TASK_TOMBSTONE ((void *)-1L)
-
-static bool is_kernel_event(struct perf_event *event)
-{
-	return READ_ONCE(event->owner) == TASK_TOMBSTONE;
-}
-
 /*
  * On task ctx scheduling...
  *
-- 
2.7.4

