Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88157C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B10720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B10720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeKATi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:38:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbeKATi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:38:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100601994"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:30 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 5/8] KVM/x86/vPMU: intel_pmu_read_pmc
Date:   Thu,  1 Nov 2018 18:04:05 +0800
Message-Id: <1541066648-40690-6-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the handling of guest rdpmc. If the physical counter has
been assigned, directly reads the value from the hardware. Otherwise,
return to the guest the virtual counter value.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kvm/pmu.c       |  3 +++
 arch/x86/kvm/pmu.h       |  1 +
 arch/x86/kvm/pmu_intel.c | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 58ead7d..7f2f63e 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -284,6 +284,9 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	struct kvm_pmc *pmc;
 	u64 ctr_val;
 
+	if (kvm_x86_ops->pmu_ops->read_pmc)
+		return kvm_x86_ops->pmu_ops->read_pmc(vcpu, idx, data);
+
 	if (is_vmware_backdoor_pmc(idx))
 		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index b3b0238..7ab85bf 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -30,6 +30,7 @@ struct kvm_pmu_ops {
 	bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
 	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
+	int (*read_pmc)(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data);
 	void (*refresh)(struct kvm_vcpu *vcpu);
 	void (*init)(struct kvm_vcpu *vcpu);
 	void (*reset)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 2be31ad..4c6183b 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -20,6 +20,9 @@
 #include "lapic.h"
 #include "pmu.h"
 
+#define INTEL_PMU_RDPMC_FIXED_PMC (1ULL << 30)
+#define INTEL_PMU_RDPMC_COUNTER_MASK (INTEL_PMU_RDPMC_FIXED_PMC - 1)
+
 static struct kvm_event_hw_type_mapping intel_arch_events[] = {
 	/* Index must match CPUID 0x0A.EBX bit vector */
 	[0] = { 0x3c, 0x00, PERF_COUNT_HW_CPU_CYCLES },
@@ -409,6 +412,29 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
+static int intel_pmu_read_pmc(struct kvm_vcpu *vcpu, unsigned int idx,
+			      u64 *data)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	unsigned int pmc_idx;
+
+	if (idx & INTEL_PMU_RDPMC_FIXED_PMC)
+		pmc_idx = INTEL_PMC_IDX_FIXED +
+			  (idx & INTEL_PMU_RDPMC_COUNTER_MASK);
+	else
+		pmc_idx = idx & INTEL_PMU_RDPMC_COUNTER_MASK;
+
+	if (test_bit(pmc_idx,
+		(unsigned long *)&pmu->assigned_pmc_bitmap))
+		rdpmcl(idx, *data);
+	else {
+		struct kvm_pmc *pmc = intel_pmc_idx_to_pmc(pmu, pmc_idx);
+		*data = pmc->counter;
+	}
+
+	return 0;
+}
+
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -530,6 +556,7 @@ struct kvm_pmu_ops intel_pmu_ops = {
 	.is_valid_msr = intel_is_valid_msr,
 	.get_msr = intel_pmu_get_msr,
 	.set_msr = intel_pmu_set_msr,
+	.read_pmc = intel_pmu_read_pmc,
 	.refresh = intel_pmu_refresh,
 	.init = intel_pmu_init,
 	.reset = intel_pmu_reset,
-- 
2.7.4

