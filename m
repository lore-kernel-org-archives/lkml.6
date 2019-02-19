Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC152147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfBRL1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:27:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:4212 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfBRL1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:27:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 03:27:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,384,1544515200"; 
   d="scan'208";a="275885445"
Received: from vmm.bj.intel.com ([10.240.192.123])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2019 03:26:55 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        konrad.wilk@oracle.com, Janakarajan.Natarajan@amd.com,
        mattst88@gmail.com, tim.c.chen@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v2 2/2] KVM: x86: Add support of clear Trace_ToPA_PMI status
Date:   Mon, 18 Feb 2019 19:26:08 -0500
Message-Id: <1550535968-7652-3-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550535968-7652-1-git-send-email-luwei.kang@intel.com>
References: <1550535968-7652-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of clear Intel PT ToPA PMI status for
KVM guest.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/kvm_host.h  | 1 +
 arch/x86/include/asm/msr-index.h | 4 ++++
 arch/x86/kvm/vmx/pmu_intel.c     | 8 +++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4660ce9..de95704 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -468,6 +468,7 @@ struct kvm_pmu {
 	u64 global_ovf_ctrl;
 	u64 counter_bitmask[2];
 	u64 global_ctrl_mask;
+	u64 global_ovf_ctrl_mask;
 	u64 reserved_bits;
 	u8 version;
 	struct kvm_pmc gp_counters[INTEL_PMC_MAX_GENERIC];
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ae01fb0..c0ea4aa 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -778,6 +778,10 @@
 /* PERF_GLOBAL_OVF_CTL bits */
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT		62
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF			(1ULL <<  MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT)
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT		63
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD			(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT)
 
 /* Geode defined MSRs */
 #define MSR_GEODE_BUSCONT_CONF0		0x00001900
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 5ab4a36..6dee7cf 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -227,7 +227,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		break;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-		if (!(data & (pmu->global_ctrl_mask & ~(3ull<<62)))) {
+		if (!(data & pmu->global_ovf_ctrl_mask)) {
 			if (!msr_info->host_initiated)
 				pmu->global_status &= ~data;
 			pmu->global_ovf_ctrl = data;
@@ -297,6 +297,12 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->global_ctrl = ((1ull << pmu->nr_arch_gp_counters) - 1) |
 		(((1ull << pmu->nr_arch_fixed_counters) - 1) << INTEL_PMC_IDX_FIXED);
 	pmu->global_ctrl_mask = ~pmu->global_ctrl;
+	pmu->global_ovf_ctrl_mask = ~(pmu->global_ctrl |
+				MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
+				MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
+	if (kvm_x86_ops->pt_supported())
+		pmu->global_ovf_ctrl_mask &=
+				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
 
 	entry = kvm_find_cpuid_entry(vcpu, 7, 0);
 	if (entry &&
-- 
1.8.3.1

