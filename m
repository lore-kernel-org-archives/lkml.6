Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB732C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F02720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F02720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeKATi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:38:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeKATiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:38:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100601974"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:28 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 4/8] KVM/x86/vPMU: support msr switch on vmx transitions
Date:   Thu,  1 Nov 2018 18:04:04 +0800
Message-Id: <1541066648-40690-5-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to intel vPMU to switch msrs on vmx transitions.
Currenly only 1 msr (global ctrl) is switched. The number can be
increased on demand in the future (e.g. pebs enable). The old method from
the host perf subsystem is also removed.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 60 ---------------------------------------
 arch/x86/events/perf_event.h      |  6 ----
 arch/x86/include/asm/kvm_host.h   | 11 +++++++
 arch/x86/include/asm/perf_event.h | 12 --------
 arch/x86/kvm/pmu.h                |  2 ++
 arch/x86/kvm/pmu_intel.c          | 19 +++++++++++++
 arch/x86/kvm/vmx.c                |  6 ++--
 7 files changed, 35 insertions(+), 81 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f5e5191..33c156f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3160,15 +3160,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	return 0;
 }
 
-struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
-{
-	if (x86_pmu.guest_get_msrs)
-		return x86_pmu.guest_get_msrs(nr);
-	*nr = 0;
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
-
 void x86_perf_register_pmi_callback(pmi_callback_t callback, void *opaque)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -3189,55 +3180,6 @@ void x86_perf_unregister_pmi_callback(void)
 }
 EXPORT_SYMBOL_GPL(x86_perf_unregister_pmi_callback);
 
-static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
-{
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
-
-	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
-	arr[0].host = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
-	arr[0].guest = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_host_mask;
-	/*
-	 * If PMU counter has PEBS enabled it is not enough to disable counter
-	 * on a guest entry since PEBS memory write can overshoot guest entry
-	 * and corrupt guest memory. Disabling PEBS solves the problem.
-	 */
-	arr[1].msr = MSR_IA32_PEBS_ENABLE;
-	arr[1].host = cpuc->pebs_enabled;
-	arr[1].guest = 0;
-
-	*nr = 2;
-	return arr;
-}
-
-static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr)
-{
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
-	int idx;
-
-	for (idx = 0; idx < x86_pmu.num_counters; idx++)  {
-		struct perf_event *event = cpuc->events[idx];
-
-		arr[idx].msr = x86_pmu_config_addr(idx);
-		arr[idx].host = arr[idx].guest = 0;
-
-		if (!test_bit(idx, cpuc->active_mask))
-			continue;
-
-		arr[idx].host = arr[idx].guest =
-			event->hw.config | ARCH_PERFMON_EVENTSEL_ENABLE;
-
-		if (event->attr.exclude_host)
-			arr[idx].host &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-		else if (event->attr.exclude_guest)
-			arr[idx].guest &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-	}
-
-	*nr = x86_pmu.num_counters;
-	return arr;
-}
-
 static void core_pmu_enable_event(struct perf_event *event)
 {
 	if (!event->attr.exclude_host)
@@ -3641,7 +3583,6 @@ static __initconst const struct x86_pmu core_pmu = {
 	.get_event_constraints	= intel_get_event_constraints,
 	.put_event_constraints	= intel_put_event_constraints,
 	.event_constraints	= intel_core_event_constraints,
-	.guest_get_msrs		= core_guest_get_msrs,
 	.format_attrs		= intel_arch_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
 
@@ -3694,7 +3635,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
-	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 06404eb..9f818d5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -227,7 +227,6 @@ struct cpu_hw_events {
 	 */
 	u64				intel_ctrl_guest_mask;
 	u64				intel_ctrl_host_mask;
-	struct perf_guest_switch_msr	guest_switch_msrs[X86_PMC_IDX_MAX];
 
 	/*
 	 * Intel checkpoint mask
@@ -645,11 +644,6 @@ struct x86_pmu {
 	 */
 	struct extra_reg *extra_regs;
 	unsigned int flags;
-
-	/*
-	 * Intel host/guest support (KVM)
-	 */
-	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr);
 };
 
 struct x86_perf_task_context {
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f8bc46d..b66d164 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -453,6 +453,16 @@ struct kvm_pmc {
 	struct kvm_vcpu *vcpu;
 };
 
+/*
+ * Below MSRs are currently switched on VMX transitions:
+ * - MSR_CORE_PERF_GLOBAL_CTRL
+ */
+#define KVM_PERF_SWITCH_MSR_NUM 1
+struct kvm_perf_switch_msr {
+	unsigned int msr;
+	u64 host, guest;
+};
+
 struct kvm_pmu {
 	unsigned nr_arch_gp_counters;
 	unsigned nr_arch_fixed_counters;
@@ -470,6 +480,7 @@ struct kvm_pmu {
 	struct kvm_pmc fixed_counters[INTEL_PMC_MAX_FIXED];
 	struct irq_work irq_work;
 	u64 reprogram_pmi;
+	struct kvm_perf_switch_msr switch_msrs[KVM_PERF_SWITCH_MSR_NUM];
 };
 
 struct kvm_pmu_ops;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fd33688..e9cff88 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -270,24 +270,12 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	);							\
 }
 
-struct perf_guest_switch_msr {
-	unsigned msr;
-	u64 host, guest;
-};
-
 typedef void (*pmi_callback_t)(void *opaque, u64 status);
 
-extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
 extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
-static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
-{
-	*nr = 0;
-	return NULL;
-}
-
 static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
 	memset(cap, 0, sizeof(*cap));
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ba8898e..b3b0238 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -119,6 +119,8 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
+struct kvm_perf_switch_msr *intel_pmu_get_switch_msrs(struct kvm_vcpu *vcpu,
+						      u32 *nr_msrs);
 
 extern struct kvm_pmu_ops intel_pmu_ops;
 extern struct kvm_pmu_ops amd_pmu_ops;
diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 8c2d37f..2be31ad 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -501,6 +501,25 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 	pmu->assigned_pmc_bitmap = 0;
 }
 
+struct kvm_perf_switch_msr *intel_pmu_get_switch_msrs(struct kvm_vcpu *vcpu,
+						      u32 *nr_msrs)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_perf_switch_msr *arr = pmu->switch_msrs;
+
+	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
+	rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, arr[0].host);
+	arr[0].host &= ~pmu->assigned_pmc_bitmap;
+	/*
+	 * The guest value will be written to the hardware msr when entering
+	 * the guest, and the bits of unassigned pmcs are not enabled.
+	 */
+	arr[0].guest = pmu->global_ctrl & pmu->assigned_pmc_bitmap;
+	*nr_msrs = KVM_PERF_SWITCH_MSR_NUM;
+
+	return arr;
+}
+
 struct kvm_pmu_ops intel_pmu_ops = {
 	.find_arch_event = intel_find_arch_event,
 	.find_fixed_event = intel_find_fixed_event,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4555077..714d1f3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11073,10 +11073,10 @@ static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
 
 static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 {
-	int i, nr_msrs;
-	struct perf_guest_switch_msr *msrs;
+	u32 i, nr_msrs;
+	struct kvm_perf_switch_msr *msrs;
 
-	msrs = perf_guest_get_msrs(&nr_msrs);
+	msrs = intel_pmu_get_switch_msrs(&vmx->vcpu, &nr_msrs);
 
 	if (!msrs)
 		return;
-- 
2.7.4

