Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbeCEB7h (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:59:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:39574 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932101AbeCEB4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:56:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,425,1515484800";
   d="scan'208";a="21986056"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v5 02/11] perf/x86/intel/pt: Change pt_cap_get() to a public function
Date: Sun,  4 Mar 2018 20:07:12 +0800
Message-Id: <1520165241-15819-3-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Change pt_cap_get() to a public function so that KVM can access it.
Introduce new capablility PT_CAP_output_subsys to support
of output to Trace Transport subsystem.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.c      |  4 +++-
 arch/x86/events/intel/pt.h      | 21 ---------------------
 arch/x86/include/asm/intel_pt.h | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 6d6dd4f..d89dd8c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -68,6 +68,7 @@
 	PT_CAP(topa_output,		0, CPUID_ECX, BIT(0)),
 	PT_CAP(topa_multiple_entries,	0, CPUID_ECX, BIT(1)),
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
+	PT_CAP(output_subsys,		0, CPUID_ECX, BIT(3)),
 	PT_CAP(payloads_lip,		0, CPUID_ECX, BIT(31)),
 	PT_CAP(num_address_ranges,	1, CPUID_EAX, 0x3),
 	PT_CAP(mtc_periods,		1, CPUID_EAX, 0xffff0000),
@@ -75,7 +76,7 @@
 	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
 };
 
-static u32 pt_cap_get(enum pt_capabilities cap)
+u32 pt_cap_get(enum pt_capabilities cap)
 {
 	struct pt_cap_desc *cd = &pt_caps[cap];
 	u32 c = pt_pmu.caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
@@ -83,6 +84,7 @@ static u32 pt_cap_get(enum pt_capabilities cap)
 
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
index b523f51..2de4db0 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -2,10 +2,34 @@
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
+	PT_CAP_output_subsys,
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
