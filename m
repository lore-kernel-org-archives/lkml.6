Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FE520820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FE520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeKATi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:38:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbeKATi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:38:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100602007"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:32 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 6/8] KVM/x86/vPMU: remove some unused functions
Date:   Thu,  1 Nov 2018 18:04:06 +0800
Message-Id: <1541066648-40690-7-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those functions are used in the old intel vPMU implementation and are not
needed now.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kvm/pmu_intel.c | 103 -----------------------------------------------
 1 file changed, 103 deletions(-)

diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 4c6183b..66d7c09 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -23,87 +23,6 @@
 #define INTEL_PMU_RDPMC_FIXED_PMC (1ULL << 30)
 #define INTEL_PMU_RDPMC_COUNTER_MASK (INTEL_PMU_RDPMC_FIXED_PMC - 1)
 
-static struct kvm_event_hw_type_mapping intel_arch_events[] = {
-	/* Index must match CPUID 0x0A.EBX bit vector */
-	[0] = { 0x3c, 0x00, PERF_COUNT_HW_CPU_CYCLES },
-	[1] = { 0xc0, 0x00, PERF_COUNT_HW_INSTRUCTIONS },
-	[2] = { 0x3c, 0x01, PERF_COUNT_HW_BUS_CYCLES  },
-	[3] = { 0x2e, 0x4f, PERF_COUNT_HW_CACHE_REFERENCES },
-	[4] = { 0x2e, 0x41, PERF_COUNT_HW_CACHE_MISSES },
-	[5] = { 0xc4, 0x00, PERF_COUNT_HW_BRANCH_INSTRUCTIONS },
-	[6] = { 0xc5, 0x00, PERF_COUNT_HW_BRANCH_MISSES },
-	[7] = { 0x00, 0x30, PERF_COUNT_HW_REF_CPU_CYCLES },
-};
-
-/* mapping between fixed pmc index and intel_arch_events array */
-static int fixed_pmc_events[] = {1, 0, 7};
-
-static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
-{
-	int i;
-
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
-		u8 new_ctrl = fixed_ctrl_field(data, i);
-		u8 old_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
-		struct kvm_pmc *pmc;
-
-		pmc = get_fixed_pmc(pmu, MSR_CORE_PERF_FIXED_CTR0 + i);
-
-		if (old_ctrl == new_ctrl)
-			continue;
-
-		reprogram_fixed_counter(pmc, new_ctrl, i);
-	}
-
-	pmu->fixed_ctr_ctrl = data;
-}
-
-/* function is called when global control register has been updated. */
-static void global_ctrl_changed(struct kvm_pmu *pmu, u64 data)
-{
-	int bit;
-	u64 diff = pmu->global_ctrl ^ data;
-
-	pmu->global_ctrl = data;
-
-	for_each_set_bit(bit, (unsigned long *)&diff, X86_PMC_IDX_MAX)
-		reprogram_counter(pmu, bit);
-}
-
-static unsigned intel_find_arch_event(struct kvm_pmu *pmu,
-				      u8 event_select,
-				      u8 unit_mask)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(intel_arch_events); i++)
-		if (intel_arch_events[i].eventsel == event_select
-		    && intel_arch_events[i].unit_mask == unit_mask
-		    && (pmu->available_event_types & (1 << i)))
-			break;
-
-	if (i == ARRAY_SIZE(intel_arch_events))
-		return PERF_COUNT_HW_MAX;
-
-	return intel_arch_events[i].event_type;
-}
-
-static unsigned intel_find_fixed_event(int idx)
-{
-	if (idx >= ARRAY_SIZE(fixed_pmc_events))
-		return PERF_COUNT_HW_MAX;
-
-	return intel_arch_events[fixed_pmc_events[idx]].event_type;
-}
-
-/* check if a PMC is enabled by comparing it with globl_ctrl bits. */
-static bool intel_pmc_is_enabled(struct kvm_pmc *pmc)
-{
-	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
-
-	return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
-}
-
 static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 {
 	if (pmc_idx < INTEL_PMC_IDX_FIXED)
@@ -128,23 +47,6 @@ static int intel_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx)
 		(fixed && idx >= pmu->nr_arch_fixed_counters);
 }
 
-static struct kvm_pmc *intel_msr_idx_to_pmc(struct kvm_vcpu *vcpu,
-					    unsigned idx)
-{
-	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	bool fixed = idx & (1u << 30);
-	struct kvm_pmc *counters;
-
-	idx &= ~(3u << 30);
-	if (!fixed && idx >= pmu->nr_arch_gp_counters)
-		return NULL;
-	if (fixed && idx >= pmu->nr_arch_fixed_counters)
-		return NULL;
-	counters = fixed ? pmu->fixed_counters : pmu->gp_counters;
-
-	return &counters[idx];
-}
-
 static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -547,11 +449,6 @@ struct kvm_perf_switch_msr *intel_pmu_get_switch_msrs(struct kvm_vcpu *vcpu,
 }
 
 struct kvm_pmu_ops intel_pmu_ops = {
-	.find_arch_event = intel_find_arch_event,
-	.find_fixed_event = intel_find_fixed_event,
-	.pmc_is_enabled = intel_pmc_is_enabled,
-	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
-	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
 	.is_valid_msr_idx = intel_is_valid_msr_idx,
 	.is_valid_msr = intel_is_valid_msr,
 	.get_msr = intel_pmu_get_msr,
-- 
2.7.4

