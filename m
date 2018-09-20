Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D47C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92ED21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92ED21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbeITQUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:20:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:59584 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731787AbeITQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:19:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 03:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74796181"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 03:36:40 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host save/restore the guest lbr stack
Date:   Thu, 20 Sep 2018 18:05:58 +0800
Message-Id: <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <like.xu@intel.com>

This patch adds support to enable and disable the host side saving and
restoring the guest lbr stack on vCPU switching. To enable that, the
host creates a perf event for the vCPU, and the event attributes are set
to user callstack mode lbr so that all the conditions are meet in the host
perf subsystem to save the lbr stack on thread switching.

The host side lbr perf event are created only for the purpose of saving
and restoring the lbr stack. There is no need to enable the lbr
functionality for this perf event, because the feature is essentially used
in the vCPU.

So, a guest_lbr boolean control is added to cpuc, to indicate if the lbr
perf event is created for the guest. When the perf subsystem handles this
event (e.g. lbr enable or read lbr stack on PMI) and finds it is for the
guest, it simply returns, because all we need for the perf event is just
a context switch support for the lbr stack.

Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/lbr.c     | 10 +++++++---
 arch/x86/events/perf_event.h    |  1 +
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.h              |  3 +++
 arch/x86/kvm/pmu_intel.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c81f160..915fcc3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -462,6 +462,9 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
+	if (event->attr.exclude_host)
+		cpuc->guest_lbr = true;
+
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
 	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
@@ -507,6 +510,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
 		task_ctx->lbr_callstack_users--;
 	}
 
+	cpuc->guest_lbr = false;
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	perf_sched_cb_dec(event->ctx->pmu);
@@ -516,7 +520,7 @@ void intel_pmu_lbr_enable_all(bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->lbr_users)
+	if (cpuc->lbr_users && !cpuc->guest_lbr)
 		__intel_pmu_lbr_enable(pmi);
 }
 
@@ -524,7 +528,7 @@ void intel_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->lbr_users)
+	if (cpuc->lbr_users && !cpuc->guest_lbr)
 		__intel_pmu_lbr_disable();
 }
 
@@ -658,7 +662,7 @@ void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (!cpuc->lbr_users)
+	if (!cpuc->lbr_users || cpuc->guest_lbr)
 		return;
 
 	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1562863..a91fdef 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -223,6 +223,7 @@ struct cpu_hw_events {
 	 */
 	u64				intel_ctrl_guest_mask;
 	u64				intel_ctrl_host_mask;
+	bool				guest_lbr;
 	struct perf_guest_switch_msr	guest_switch_msrs[X86_PMC_IDX_MAX];
 
 	/*
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4a46e31..fdcac01 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -432,6 +432,7 @@ struct kvm_pmu {
 	struct kvm_pmc fixed_counters[INTEL_PMC_MAX_FIXED];
 	struct irq_work irq_work;
 	u64 reprogram_pmi;
+	struct perf_event *guest_lbr_event;
 };
 
 struct kvm_pmu_ops;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ba8898e..e872aed 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -120,6 +120,9 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
+extern int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu);
+extern void intel_pmu_disable_save_guest_lbr(struct kvm_vcpu *vcpu);
+
 extern struct kvm_pmu_ops intel_pmu_ops;
 extern struct kvm_pmu_ops amd_pmu_ops;
 #endif /* __KVM_X86_PMU_H */
diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 5ab4a36..97a29d7 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -342,6 +342,47 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 		pmu->global_ovf_ctrl = 0;
 }
 
+int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct perf_event *event;
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_RAW,
+		.size = sizeof(attr),
+		.pinned = true,
+		.exclude_host = true,
+		.sample_type = PERF_SAMPLE_BRANCH_STACK,
+		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK |
+				      PERF_SAMPLE_BRANCH_USER |
+				      PERF_SAMPLE_BRANCH_KERNEL,
+	};
+
+	if (pmu->guest_lbr_event)
+		return 0;
+
+	event = perf_event_create_kernel_counter(&attr, -1, current, NULL,
+						 NULL);
+	if (IS_ERR(event)) {
+		pr_err("%s: failed %ld\n", __func__, PTR_ERR(event));
+		return -ENOENT;
+	}
+	pmu->guest_lbr_event = event;
+
+	return 0;
+}
+
+void intel_pmu_disable_save_guest_lbr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct perf_event *event = pmu->guest_lbr_event;
+
+	if (!event)
+		return;
+
+	perf_event_release_kernel(event);
+	pmu->guest_lbr_event = NULL;
+}
+
 struct kvm_pmu_ops intel_pmu_ops = {
 	.find_arch_event = intel_find_arch_event,
 	.find_fixed_event = intel_find_fixed_event,
-- 
2.7.4

