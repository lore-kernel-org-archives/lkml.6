Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeECKTH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:19:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:65500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751652AbeECKTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:19:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36546431"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 02/13] perf/x86/intel/pt: Change pt_cap_get() to a public function
Date: Thu,  3 May 2018 20:13:17 +0800
Message-Id: <1525349608-10352-3-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Change pt_cap_get() to a public function that KVM
can access this function to check if specific
feature is supported on hardware.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.c      |  3 ++-
 arch/x86/events/intel/pt.h      | 21 ---------------------
 arch/x86/include/asm/intel_pt.h | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 81fd41d..a5a7e44 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -75,7 +75,7 @@
 	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
 };
 
-static u32 pt_cap_get(enum pt_capabilities cap)
+u32 pt_cap_get(enum pt_capabilities cap)
 {
 	struct pt_cap_desc *cd = &pt_caps[cap];
 	u32 c = pt_pmu.caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
@@ -83,6 +83,7 @@ static u32 pt_cap_get(enum pt_capabilities cap)
 
 	return (c & cd->mask) >> shift;
 }
+EXPORT_SYMBOL_GPL(pt_cap_get);
 
 static ssize_t pt_cap_show(struct device *cdev,
 			   struct device_attribute *attr,
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 0050ca1..269e15a 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -45,30 +45,9 @@ struct topa_entry {
 	u64	rsvd4	: 16;
 };
 
-#define PT_CPUID_LEAVES		2
-#define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
-
 /* TSC to Core Crystal Clock Ratio */
 #define CPUID_TSC_LEAF		0x15
 
-enum pt_capabilities {
-	PT_CAP_max_subleaf = 0,
-	PT_CAP_cr3_filtering,
-	PT_CAP_psb_cyc,
-	PT_CAP_ip_filtering,
-	PT_CAP_mtc,
-	PT_CAP_ptwrite,
-	PT_CAP_power_event_trace,
-	PT_CAP_topa_output,
-	PT_CAP_topa_multiple_entries,
-	PT_CAP_single_range_output,
-	PT_CAP_payloads_lip,
-	PT_CAP_num_address_ranges,
-	PT_CAP_mtc_periods,
-	PT_CAP_cycle_thresholds,
-	PT_CAP_psb_periods,
-};
-
 struct pt_pmu {
 	struct pmu		pmu;
 	u32			caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index b523f51..4270421 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -2,10 +2,33 @@
 #ifndef _ASM_X86_INTEL_PT_H
 #define _ASM_X86_INTEL_PT_H
 
+#define PT_CPUID_LEAVES		2
+#define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
+
+enum pt_capabilities {
+	PT_CAP_max_subleaf = 0,
+	PT_CAP_cr3_filtering,
+	PT_CAP_psb_cyc,
+	PT_CAP_ip_filtering,
+	PT_CAP_mtc,
+	PT_CAP_ptwrite,
+	PT_CAP_power_event_trace,
+	PT_CAP_topa_output,
+	PT_CAP_topa_multiple_entries,
+	PT_CAP_single_range_output,
+	PT_CAP_payloads_lip,
+	PT_CAP_num_address_ranges,
+	PT_CAP_mtc_periods,
+	PT_CAP_cycle_thresholds,
+	PT_CAP_psb_periods,
+};
+
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 void cpu_emergency_stop_pt(void);
+extern u32 pt_cap_get(enum pt_capabilities cap);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
+static inline u32 pt_cap_get(enum pt_capabilities cap) { return 0; }
 #endif
 
 #endif /* _ASM_X86_INTEL_PT_H */
-- 
1.8.3.1
