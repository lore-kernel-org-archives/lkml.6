Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeFAPAH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:00:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54506 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeFAPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:00:02 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v1 2/3] x86/bugs: Add AMD's SPEC_CTRL MSR usage
Date: Fri,  1 Jun 2018 10:59:20 -0400
Message-Id: <20180601145921.9500-3-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20180601145921.9500-1-konrad.wilk@oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8911 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51F0XUI011390

The AMD document outlining the SSBD handling
124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
mentions that if CPUID 8000_0008.EBX[24] is set we should be using
the SPEC_CTRL MSR (0x48) over the VIRT SPEC_CTRL MSR (0xC001_011f)
for speculative store bypass disable.

This in effect means we should clear the X86_FEATURE_VIRT_SSBD
flag so that we would prefer the SPEC_CTRL MSR.

See the document titled:
124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf

A copy of this document is available at
   https://bugzilla.kernel.org/show_bug.cgi?id=199889

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/bugs.c         | 12 +++++++-----
 arch/x86/kernel/cpu/common.c       |  6 ++++++
 arch/x86/kvm/cpuid.c               | 10 ++++++++--
 arch/x86/kvm/svm.c                 |  8 +++++---
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b6d7ce32927a..5701f5cecd31 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -282,6 +282,7 @@
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7416fc206b4a..6bea81855cdd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -529,18 +529,20 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 	if (mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
-		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
-		 * a completely different MSR and bit dependent on family.
+		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
+		 * use a completely different MSR and bit dependent on family.
 		 */
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
+		case X86_VENDOR_AMD:
+			if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+				x86_amd_ssb_disable();
+				break;
+			}
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
-		case X86_VENDOR_AMD:
-			x86_amd_ssb_disable();
-			break;
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 494735cf63f5..d08a29bd0385 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -783,6 +783,12 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 	}
+
+	if (cpu_has(c, X86_FEATURE_AMD_SSBD)) {
+		set_cpu_cap(c, X86_FEATURE_SSBD);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
+	}
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 132f8a58692e..f4f30d0c25c4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -379,7 +379,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD) | F(AMD_SSB_NO);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
+		F(AMD_SSB_NO);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -664,7 +665,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			entry->ebx |= F(VIRT_SSBD);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
-		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+		/*
+		 * The preference is to use SPEC CTRL MSR instead of the
+		 * VIRT_SPEC MSR.
+		 */
+		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
+		    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			entry->ebx |= F(VIRT_SSBD);
 		break;
 	}
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 26110c202b19..950ec50f77c3 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4115,7 +4115,8 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
 			return 1;
 
 		msr_info->data = svm->spec_ctrl;
@@ -4217,11 +4218,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
 			return 1;
 
 		svm->spec_ctrl = data;
-- 
2.13.4
