Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeCEB5A (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:57:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:39574 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932119AbeCEB45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:56:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,425,1515484800";
   d="scan'208";a="21986063"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v5 03/11] perf/x86/intel/pt: Introduce a new function to get the capability of Intel PT
Date: Sun,  4 Mar 2018 20:07:13 +0800
Message-Id: <1520165241-15819-4-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the guest CPUID information may diffrent with
with host(some bits may mask off in guest) so introduce a
new function pt_cap_get_ex() to get the capability of Intel PT.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.c      | 10 ++++++++++
 arch/x86/include/asm/intel_pt.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d89dd8c..817104e 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -86,6 +86,16 @@ u32 pt_cap_get(enum pt_capabilities cap)
 }
 EXPORT_SYMBOL_GPL(pt_cap_get);
 
+u32 pt_cap_get_ex(u32 *caps, enum pt_capabilities cap)
+{
+	struct pt_cap_desc *cd = &pt_caps[cap];
+	u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
+	unsigned int shift = __ffs(cd->mask);
+
+	return (c & cd->mask) >> shift;
+}
+EXPORT_SYMBOL_GPL(pt_cap_get_ex);
+
 static ssize_t pt_cap_show(struct device *cdev,
 			   struct device_attribute *attr,
 			   char *buf)
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 2de4db0..486e11f 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -27,9 +27,11 @@ enum pt_capabilities {
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 void cpu_emergency_stop_pt(void);
 extern u32 pt_cap_get(enum pt_capabilities cap);
+extern u32 pt_cap_get_ex(u32 *caps, enum pt_capabilities cap);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
 static inline u32 pt_cap_get(enum pt_capabilities cap) { return 0; }
+static u32 pt_cap_get_ex(u32 *caps, enum pt_capabilities cap) { return 0; }
 #endif
 
 #endif /* _ASM_X86_INTEL_PT_H */
-- 
1.8.3.1
