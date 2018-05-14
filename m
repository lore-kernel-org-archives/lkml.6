Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZp+U55Pbebg1keX31ml25EiphybIq2bmSEQ/ax9udh64wF/BBvwpNyBvXRjhfWb8z+BomXh
ARC-Seal: i=1; a=rsa-sha256; t=1526288604; cv=none;
        d=google.com; s=arc-20160816;
        b=Ejhv9gabMjYE9iszUon0jw4yXa66FZDzqaF1zvMqxja6EheZBQKVB8IVfxuel8Hk26
         sRgpTA+spKTsLL/IYfwZYFCslfC547v6x/VFH2loAG/tvQbf22mNcEUyOe2jisDLvj+z
         AWjhHEWy/6FqsluOimIRqcG9lUhA8rr2gRf6SSVcCdcXTdeIQEKZcfhEkfi+eGfpE6Dq
         pFUf6ge8oB2aIuyYWIUhQZNyIm9WVfIZn5ctAbou5nbDQmrln4nM3ixouGT+a787nHDs
         o/O7Ucy9TVSzToubvrznB9j/csObusrDakmszVqGOAehdOGw+zzB7qWPVmN/Y0tIuHYh
         uUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+SqhpsXsA9iCAcWyCNRLWz9HjUALDJL5lv7d7Sf9lAA=;
        b=wBGkVbzVLZFJcBE8ytQ8NCnJf2ACToV/11NXfpkcDc/S0zKPxmFtOZL51Hqqnn8q95
         uIv624wVtPkfQxavV6mB1VAEzZ6F4wUtYHo/zfzwApp+xF9HqArhFD1+N2sryp3ThX7g
         E568KOepdWac0dX7i0TofKbWGMy+ck/G7Ixae/9uQC5IWNJzbjCArVglY3G23TDVluol
         bfi5MSXPHg39EJ0bfk81KJM/ltiq3ERTNBAPxXj4hBTqK+1Xb5UrYtNxkg1F+EnjmY5r
         AavO66tp31KFVjpi96EZS7WccrQ2qPX+K2FBVFRH1HML3X6VOQsqjHE5xs+OsZ7JD4L9
         Mlkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701919"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	thomas.lendacky@amd.com,
	bp@suse.de,
	Kan.liang@intel.com,
	Janakarajan.Natarajan@amd.com,
	dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mathieu.poirier@linaro.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	david@redhat.com,
	bsd@redhat.com,
	yu.c.zhang@linux.intel.com,
	joro@8bytes.org,
	Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v8 07/12] KVM: x86: Add Intel Processor Trace cpuid emulation
Date: Mon, 14 May 2018 18:57:07 +0800
Message-Id: <1526295432-20640-8-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429600451187475?=
X-GMAIL-MSGID: =?utf-8?q?1600429600451187475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index 8cb8461..e9acd8b 100644
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
index 1fc05e4..21b2441 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5876,6 +5876,11 @@ static bool svm_umip_emulated(void)
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
@@ -7101,6 +7106,7 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 	.mpx_supported = svm_mpx_supported,
 	.xsaves_supported = svm_xsaves_supported,
 	.umip_emulated = svm_umip_emulated,
+	.pt_supported = svm_pt_supported,
 
 	.set_supported_cpuid = svm_set_supported_cpuid,
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ede5abf..f9b701a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9590,6 +9590,11 @@ static bool vmx_xsaves_supported(void)
 		SECONDARY_EXEC_XSAVES;
 }
 
+static bool vmx_pt_supported(void)
+{
+	return (pt_mode == PT_MODE_HOST_GUEST);
+}
+
 static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 {
 	u32 exit_intr_info;
@@ -12817,6 +12822,7 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 	.mpx_supported = vmx_mpx_supported,
 	.xsaves_supported = vmx_xsaves_supported,
 	.umip_emulated = vmx_umip_emulated,
+	.pt_supported = vmx_pt_supported,
 
 	.check_nested_events = vmx_check_nested_events,
 
-- 
1.8.3.1
