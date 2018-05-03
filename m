Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeECKT1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:19:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:65500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbeECKTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:19:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36546511"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 07/13] KVM: x86: Add Intel Processor Trace cpuid emulation
Date: Thu,  3 May 2018 20:13:22 +0800
Message-Id: <1525349608-10352-8-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Expose Intel Processor Trace to guest only when PT work in
HOST_GUEST mode.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            | 22 ++++++++++++++++++++--
 arch/x86/kvm/svm.c              |  6 ++++++
 arch/x86/kvm/vmx.c              |  6 ++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c25775f..03875aa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1025,6 +1025,7 @@ struct kvm_x86_ops {
 	bool (*mpx_supported)(void);
 	bool (*xsaves_supported)(void);
 	bool (*umip_emulated)(void);
+	bool (*pt_supported)(void);
 
 	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 82055b9..e04bf67 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -336,6 +336,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
 	unsigned f_xsaves = kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
 	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
+	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
 
 	/* cpuid 1.edx */
 	const u32 kvm_cpuid_1_edx_x86_features =
@@ -393,7 +394,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | f_mpx | F(RDSEED) |
 		F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
 		F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
-		F(SHA_NI) | F(AVX512BW) | F(AVX512VL);
+		F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;
 
 	/* cpuid 0xD.1.eax */
 	const u32 kvm_cpuid_D_1_eax_x86_features =
@@ -423,7 +424,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	switch (function) {
 	case 0:
-		entry->eax = min(entry->eax, (u32)0xd);
+		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
 		break;
 	case 1:
 		entry->edx &= kvm_cpuid_1_edx_x86_features;
@@ -595,6 +596,23 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		}
 		break;
 	}
+	/* Intel PT */
+	case 0x14: {
+		int t, times = entry->eax;
+
+		if (!f_intel_pt)
+			break;
+
+		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+		for (t = 1; t <= times; ++t) {
+			if (*nent >= maxnent)
+				goto out;
+			do_cpuid_1_ent(&entry[t], function, t);
+			entry[t].flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+			++*nent;
+		}
+		break;
+	}
 	case KVM_CPUID_SIGNATURE: {
 		static const char signature[12] = "KVMKVMKVM\0\0";
 		const u32 *sigptr = (const u32 *)signature;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 80ea262..23a1ef9 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5877,6 +5877,11 @@ static bool svm_umip_emulated(void)
 	return false;
 }
 
+static bool svm_pt_supported(void)
+{
+	return false;
+}
+
 static bool svm_has_wbinvd_exit(void)
 {
 	return true;
@@ -7102,6 +7107,7 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	.mpx_supported = svm_mpx_supported,
 	.xsaves_supported = svm_xsaves_supported,
 	.umip_emulated = svm_umip_emulated,
+	.pt_supported = svm_pt_supported,
 
 	.set_supported_cpuid = svm_set_supported_cpuid,
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8680cd5..27cf417 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9563,6 +9563,11 @@ static bool vmx_umip_emulated(void)
 		SECONDARY_EXEC_DESC;
 }
 
+static bool vmx_pt_supported(void)
+{
+	return (pt_mode == PT_MODE_HOST_GUEST);
+}
+
 static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 {
 	u32 exit_intr_info;
@@ -12790,6 +12795,7 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 	.mpx_supported = vmx_mpx_supported,
 	.xsaves_supported = vmx_xsaves_supported,
 	.umip_emulated = vmx_umip_emulated,
+	.pt_supported = vmx_pt_supported,
 
 	.check_nested_events = vmx_check_nested_events,
 
-- 
1.8.3.1
