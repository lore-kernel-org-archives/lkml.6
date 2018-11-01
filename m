Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DDC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6409420820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeKATix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:38:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbeKATiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:38:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100601965"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:26 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 3/8] KVM/x86/vPMU: optimize intel vPMU
Date:   Thu,  1 Nov 2018 18:04:03 +0800
Message-Id: <1541066648-40690-4-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current vPMU relies on the host perf software stack to update the guest
change of the perf counter MSRs. The whole process includes releasing the
old perf event and re-creating a new one. This results in around 2500000ns
overhead to update a perf counter control MSR.

This can be avoided by having the vPMU layer directly sits on the hardware
perf counters, and in this case the guest accesses to the virtual perf
counters can be directly applied to the related hardware counter by vPMU.
The guest used counters are taken from the host perf core via
x86_perf_mask_perf_counters, which in most cases is a bit-setting of the
guest mask.

This patch implements the handling of guest accesses to the perf counter
MSRs. A host perf counter is assigned to the guest when the guest has the
vPMC enabled and returned to the host when the vPMC gets disabled.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/kvm_host.h |   1 +
 arch/x86/kvm/pmu_intel.c        | 257 ++++++++++++++++++++++++++++++++--------
 2 files changed, 209 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff..f8bc46d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -463,6 +463,7 @@ struct kvm_pmu {
 	u64 global_ovf_ctrl;
 	u64 counter_bitmask[2];
 	u64 global_ctrl_mask;
+	u64 assigned_pmc_bitmap;
 	u64 reserved_bits;
 	u8 version;
 	struct kvm_pmc gp_counters[INTEL_PMC_MAX_GENERIC];
diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 5ab4a36..8c2d37f 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -185,7 +185,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	default:
 		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
 		    (pmc = get_fixed_pmc(pmu, msr))) {
-			*data = pmc_read_counter(pmc);
+			if (test_bit(pmc->idx,
+				(unsigned long *)&pmu->assigned_pmc_bitmap))
+				rdmsrl(msr, *data);
+			else
+				*data = pmc->counter;
 			return 0;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
 			*data = pmc->eventsel;
@@ -196,59 +200,210 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	return 1;
 }
 
+static void intel_pmu_update_fixed_ctrl_msr(u64 new_ctrl, u8 idx)
+{
+	u64 host_ctrl, mask;
+
+	rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, host_ctrl);
+	mask = 0xfULL << (idx * 4);
+	host_ctrl &= ~mask;
+	new_ctrl <<= (idx * 4);
+	host_ctrl |= new_ctrl;
+	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, host_ctrl);
+}
+
+static void intel_pmu_save_pmc_counters(struct kvm_pmu *pmu, u32 idx)
+{
+	struct kvm_pmc *pmc;
+
+	pmc = intel_pmc_idx_to_pmc(pmu, idx);
+	/*
+	 * The control MSRs (pmc->eventsel and pmu->fixed_ctr_ctrl) always
+	 * store the updated value, so we only need to save the counter value.
+	 */
+	if (pmc->type == KVM_PMC_GP)
+		rdmsrl(MSR_IA32_PERFCTR0 + idx, pmc->counter);
+	else
+		rdmsrl(MSR_CORE_PERF_FIXED_CTR0 + idx - INTEL_PMC_IDX_FIXED,
+		       pmc->counter);
+}
+
+static void intel_pmu_restore_pmc_counters(struct kvm_pmu *pmu, u32 idx)
+{
+	struct kvm_pmc *pmc;
+
+	pmc = intel_pmc_idx_to_pmc(pmu, idx);
+
+	if (pmc->type == KVM_PMC_GP) {
+		wrmsrl(MSR_IA32_PERFCTR0 + idx, pmc->counter);
+		wrmsrl(MSR_ARCH_PERFMON_EVENTSEL0 + idx, pmc->eventsel);
+	} else {
+		u8 ctrl;
+
+		idx -= INTEL_PMC_IDX_FIXED;
+		ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, idx);
+
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR0 + idx, pmc->counter);
+		intel_pmu_update_fixed_ctrl_msr(ctrl, idx);
+	}
+}
+
+/* Get the physical PMC from host and restore the vPMC states. */
+static inline void intel_pmu_get_pmc(struct kvm_pmu *pmu, unsigned int idx)
+{
+	/* Already assigned? */
+	if (test_bit(idx, (unsigned long *)&pmu->assigned_pmc_bitmap))
+		return;
+
+	set_bit(idx, (unsigned long *)&pmu->assigned_pmc_bitmap);
+	x86_perf_mask_perf_counters(pmu->assigned_pmc_bitmap);
+	intel_pmu_restore_pmc_counters(pmu, idx);
+}
+
+/* Save the physical PMC state and return it to host. */
+static inline void intel_pmu_put_pmc(struct kvm_pmu *pmu, unsigned int idx)
+{
+	/* Already returned? */
+	if (!test_bit(idx, (unsigned long *)&pmu->assigned_pmc_bitmap))
+		return;
+
+	intel_pmu_save_pmc_counters(pmu, idx);
+	clear_bit(idx, (unsigned long *)&pmu->assigned_pmc_bitmap);
+	x86_perf_mask_perf_counters(pmu->assigned_pmc_bitmap);
+}
+
+static int intel_pmu_set_fixed_ctrl(struct kvm_pmu *pmu,
+				    struct msr_data *msr_info)
+{
+	u8 old_ctrl, new_ctrl, pmc_idx, i;
+	u64 data = msr_info->data;
+
+	if (pmu->fixed_ctr_ctrl == data)
+		return 0;
+	if (unlikely(data & 0xfffffffffffff444ull))
+		return 1;
+
+	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
+		old_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
+		new_ctrl = fixed_ctrl_field(data, i);
+		if (old_ctrl == new_ctrl)
+			continue;
+
+		pmc_idx = INTEL_PMC_IDX_FIXED + i;
+		if (new_ctrl) {
+			/* Set the control after we own the pmc */
+			intel_pmu_get_pmc(pmu, pmc_idx);
+			intel_pmu_update_fixed_ctrl_msr((u64)new_ctrl, i);
+		} else {
+			/* Zero the control before we return the pmc */
+			intel_pmu_update_fixed_ctrl_msr((u64)new_ctrl, i);
+			intel_pmu_put_pmc(pmu, pmc_idx);
+		}
+	}
+	pmu->fixed_ctr_ctrl = data;
+
+	return 0;
+}
+
+static int intel_pmu_set_global_status(struct kvm_pmu *pmu,
+				       struct msr_data *msr_info)
+{
+	/* RO to the guest */
+	if (!msr_info->host_initiated)
+		return 1;
+
+	pmu->global_status = msr_info->data;
+	return 0;
+}
+
+static int intel_pmu_set_global_ctrl(struct kvm_pmu *pmu,
+				     struct msr_data *msr_info)
+{
+	u64 data = msr_info->data;
+
+	if (unlikely(data & pmu->global_ctrl_mask))
+		return 1;
+
+	pmu->global_ctrl = data;
+
+	return 0;
+}
+
+static int intel_pmu_set_ovf_ctrl(struct kvm_pmu *pmu,
+				  struct msr_data *msr_info)
+{
+	u64 data = msr_info->data;
+
+	if (unlikely(data & (pmu->global_ctrl_mask & ~(3ull<<62))))
+		return 1;
+
+	if (!msr_info->host_initiated)
+		pmu->global_status &= ~data;
+
+	pmu->global_ovf_ctrl = data;
+
+	return 0;
+}
+
+static int intel_pmu_set_gp_eventsel(struct kvm_pmc *pmc,
+				     struct msr_data *msr_info)
+{
+	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
+	u64 data = msr_info->data;
+
+	if (pmc->eventsel == data)
+		return 0;
+
+	pmc->eventsel = data;
+
+	if (data & ARCH_PERFMON_EVENTSEL_ENABLE) {
+		intel_pmu_get_pmc(pmu, pmc->idx);
+		wrmsrl(msr_info->index, pmc->eventsel);
+	} else {
+		wrmsrl(msr_info->index, pmc->eventsel);
+		intel_pmu_put_pmc(pmu, pmc->idx);
+	}
+
+	return 0;
+}
+
+static int intel_pmu_set_pmc_counter(struct kvm_pmc *pmc,
+				     struct msr_data *msr_info)
+{
+	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
+
+	pmc->counter = msr_info->data;
+	if (test_bit(pmc->idx, (unsigned long *)&pmu->assigned_pmc_bitmap))
+		wrmsrl(msr_info->index, pmc->counter);
+
+	return 0;
+}
+
 static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 	u32 msr = msr_info->index;
-	u64 data = msr_info->data;
 
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
-		if (pmu->fixed_ctr_ctrl == data)
-			return 0;
-		if (!(data & 0xfffffffffffff444ull)) {
-			reprogram_fixed_counters(pmu, data);
-			return 0;
-		}
-		break;
+		return intel_pmu_set_fixed_ctrl(pmu, msr_info);
 	case MSR_CORE_PERF_GLOBAL_STATUS:
-		if (msr_info->host_initiated) {
-			pmu->global_status = data;
-			return 0;
-		}
-		break; /* RO MSR */
+		return intel_pmu_set_global_status(pmu, msr_info);
 	case MSR_CORE_PERF_GLOBAL_CTRL:
-		if (pmu->global_ctrl == data)
-			return 0;
-		if (!(data & pmu->global_ctrl_mask)) {
-			global_ctrl_changed(pmu, data);
-			return 0;
-		}
-		break;
+		return intel_pmu_set_global_ctrl(pmu, msr_info);
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-		if (!(data & (pmu->global_ctrl_mask & ~(3ull<<62)))) {
-			if (!msr_info->host_initiated)
-				pmu->global_status &= ~data;
-			pmu->global_ovf_ctrl = data;
-			return 0;
-		}
-		break;
+		return intel_pmu_set_ovf_ctrl(pmu, msr_info);
 	default:
-		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
-		    (pmc = get_fixed_pmc(pmu, msr))) {
-			if (!msr_info->host_initiated)
-				data = (s64)(s32)data;
-			pmc->counter += data - pmc_read_counter(pmc);
-			return 0;
-		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
-			if (data == pmc->eventsel)
-				return 0;
-			if (!(data & pmu->reserved_bits)) {
-				reprogram_gp_counter(pmc, data);
-				return 0;
-			}
-		}
+		pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0);
+		if (pmc)
+			return intel_pmu_set_gp_eventsel(pmc, msr_info);
+		pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0);
+		if (pmc)
+			return intel_pmu_set_pmc_counter(pmc, msr_info);
+		pmc = get_fixed_pmc(pmu, msr);
+		if (pmc)
+			return intel_pmu_set_pmc_counter(pmc, msr_info);
 	}
 
 	return 1;
@@ -326,20 +481,24 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
 	int i;
 
 	for (i = 0; i < INTEL_PMC_MAX_GENERIC; i++) {
-		struct kvm_pmc *pmc = &pmu->gp_counters[i];
-
-		pmc_stop_counter(pmc);
+		pmc = &pmu->gp_counters[i];
 		pmc->counter = pmc->eventsel = 0;
 	}
 
-	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++)
-		pmc_stop_counter(&pmu->fixed_counters[i]);
+	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
+		pmc = &pmu->fixed_counters[i];
+		pmc->counter = 0;
+	}
 
-	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status =
-		pmu->global_ovf_ctrl = 0;
+	pmu->fixed_ctr_ctrl = 0;
+	pmu->global_ctrl = 0;
+	pmu->global_status = 0;
+	pmu->global_ovf_ctrl = 0;
+	pmu->assigned_pmc_bitmap = 0;
 }
 
 struct kvm_pmu_ops intel_pmu_ops = {
-- 
2.7.4

