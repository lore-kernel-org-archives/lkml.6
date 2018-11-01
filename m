Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC23C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1180D2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1180D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeKATjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:39:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbeKATjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:39:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100602018"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:33 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 7/8] KVM/x86/vPMU: save/restore guest perf counters on vCPU switching
Date:   Thu,  1 Nov 2018 18:04:07 +0800
Message-Id: <1541066648-40690-8-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the vCPU is scheduled in, restore the assigned perf counter states
and register the guest pmi callback. When the vCPU is scheduled out,
save the assigned perf counter states and unregister the guest PMI
callback.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.c              | 12 ++++++++++++
 arch/x86/kvm/pmu.h              |  4 ++++
 arch/x86/kvm/pmu_intel.c        | 38 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  6 ++++++
 include/linux/kvm_host.h        |  1 +
 virt/kvm/kvm_main.c             |  3 +++
 7 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b66d164..cb1c0bf 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -474,6 +474,7 @@ struct kvm_pmu {
 	u64 counter_bitmask[2];
 	u64 global_ctrl_mask;
 	u64 assigned_pmc_bitmap;
+	u64 restore_pmc_bitmap;
 	u64 reserved_bits;
 	u8 version;
 	struct kvm_pmc gp_counters[INTEL_PMC_MAX_GENERIC];
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7f2f63e..4448a88 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -340,6 +340,18 @@ void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	kvm_x86_ops->pmu_ops->reset(vcpu);
 }
 
+void kvm_pmu_sched_in(struct kvm_vcpu *vcpu)
+{
+	if (kvm_x86_ops->pmu_ops->sched_in)
+		kvm_x86_ops->pmu_ops->sched_in(vcpu);
+}
+
+void kvm_pmu_sched_out(struct kvm_vcpu *vcpu)
+{
+	if (kvm_x86_ops->pmu_ops->sched_out)
+		kvm_x86_ops->pmu_ops->sched_out(vcpu);
+}
+
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 7ab85bf..77fc973 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -34,6 +34,8 @@ struct kvm_pmu_ops {
 	void (*refresh)(struct kvm_vcpu *vcpu);
 	void (*init)(struct kvm_vcpu *vcpu);
 	void (*reset)(struct kvm_vcpu *vcpu);
+	void (*sched_in)(struct kvm_vcpu *vcpu);
+	void (*sched_out)(struct kvm_vcpu *vcpu);
 };
 
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
@@ -118,6 +120,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu);
 void kvm_pmu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_init(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
+void kvm_pmu_sched_in(struct kvm_vcpu *vcpu);
+void kvm_pmu_sched_out(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 struct kvm_perf_switch_msr *intel_pmu_get_switch_msrs(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 66d7c09..9eb5230 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -427,6 +427,7 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 	pmu->global_status = 0;
 	pmu->global_ovf_ctrl = 0;
 	pmu->assigned_pmc_bitmap = 0;
+	pmu->restore_pmc_bitmap = 0;
 }
 
 struct kvm_perf_switch_msr *intel_pmu_get_switch_msrs(struct kvm_vcpu *vcpu,
@@ -448,6 +449,41 @@ struct kvm_perf_switch_msr *intel_pmu_get_switch_msrs(struct kvm_vcpu *vcpu,
 	return arr;
 }
 
+static void intel_pmu_inject_guest_pmi(void *opaque, u64 status)
+{
+	struct kvm_vcpu *vcpu = opaque;
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	pmu->global_status |= status;
+	kvm_make_request(KVM_REQ_PMI, vcpu);
+}
+
+static void intel_pmu_sched_out(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	u32 bit;
+
+	pmu->restore_pmc_bitmap = pmu->assigned_pmc_bitmap;
+	for_each_set_bit(bit, (unsigned long *)&pmu->restore_pmc_bitmap,
+			 X86_PMC_IDX_MAX)
+		intel_pmu_put_pmc(pmu, bit);
+
+	x86_perf_unregister_pmi_callback();
+}
+
+static void intel_pmu_sched_in(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	u32 bit;
+
+	for_each_set_bit(bit, (unsigned long *)&pmu->restore_pmc_bitmap,
+			 X86_PMC_IDX_MAX)
+		intel_pmu_get_pmc(pmu, bit);
+	pmu->restore_pmc_bitmap = 0;
+
+	x86_perf_register_pmi_callback(intel_pmu_inject_guest_pmi, vcpu);
+}
+
 struct kvm_pmu_ops intel_pmu_ops = {
 	.is_valid_msr_idx = intel_is_valid_msr_idx,
 	.is_valid_msr = intel_is_valid_msr,
@@ -457,4 +493,6 @@ struct kvm_pmu_ops intel_pmu_ops = {
 	.refresh = intel_pmu_refresh,
 	.init = intel_pmu_init,
 	.reset = intel_pmu_reset,
+	.sched_out = intel_pmu_sched_out,
+	.sched_in = intel_pmu_sched_in,
 };
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 66d66d7..47308bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8986,9 +8986,15 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	vcpu->arch.l1tf_flush_l1d = true;
+	kvm_pmu_sched_in(vcpu);
 	kvm_x86_ops->sched_in(vcpu, cpu);
 }
 
+void kvm_arch_sched_out(struct kvm_vcpu *vcpu)
+{
+	kvm_pmu_sched_out(vcpu);
+}
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	if (type)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c926698..478d602 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -795,6 +795,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu);
 
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu);
+void kvm_arch_sched_out(struct kvm_vcpu *vcpu);
 
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e47..24c2be2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3990,6 +3990,9 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 
 	if (current->state == TASK_RUNNING)
 		vcpu->preempted = true;
+
+	kvm_arch_sched_out(vcpu);
+
 	kvm_arch_vcpu_put(vcpu);
 }
 
-- 
2.7.4

