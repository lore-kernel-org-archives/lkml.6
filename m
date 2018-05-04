Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEDQSo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:18:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeEDQSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:18:39 -0400
Date: Fri, 4 May 2018 18:18:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO2cmc=?= Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
Message-ID: <20180504161815.GG9257@pd.tnic>
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com>
 <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
 <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
 <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
 <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com>
 <CADDKRnC1V3KUR__PAo_JhMVdaWknQ9x1_XAQNewUWuO3cqFFFg@mail.gmail.com>
 <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
 <CADDKRnBn7rNN9UrwtYvNDPeJxqNQ-WHQVyHXAV7RwcVxX7jSDw@mail.gmail.com>
 <alpine.DEB.2.21.1805021418550.1560@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1805021418550.1560@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 02:20:52PM +0200, Thomas Gleixner wrote:
> Thanks for confirming. Still need to find a way which is less fragile, but
> that's probably too much of churn for rc4....
> 
> At least I know exactly what's happening, so I can write a better changelog.
> 
> Thanks for testing!

Jörg, can you pls also test this one ontop of Thomas' patch to make
sure it doesn't break your box.

Thx.

---
>From 6857c2ac8e31f4f9b350cfad4f6b6eb831bf57f1 Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Wed, 2 May 2018 18:15:14 +0200
Subject: [PATCH] x86/CPU: Use synthetic bits for IBRS/IBPB/STIBP

Intel and AMD have different CPUID bits for those so use synthetic bits
which get set on the respective vendor in init_speculation_control(). So
that debacles like the commit message of

  c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")

talks about don't happen anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpufeatures.h | 12 ++++++------
 arch/x86/kernel/cpu/common.c       | 14 ++++++++++----
 arch/x86/kvm/svm.c                 |  6 +++---
 arch/x86/kvm/vmx.c                 |  3 ---
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 578793e97431..0482da6d7d6f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -198,7 +198,6 @@
 #define X86_FEATURE_CAT_L2		( 7*32+ 5) /* Cache Allocation Technology L2 */
 #define X86_FEATURE_CDP_L3		( 7*32+ 6) /* Code and Data Prioritization L3 */
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
-
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_SME			( 7*32+10) /* AMD Secure Memory Encryption */
@@ -207,13 +206,14 @@
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
-
+#define X86_FEATURE_IBRS		( 7*32+16) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_IBPB		( 7*32+17) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
 #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
-
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
+#define X86_FEATURE_STIBP		( 7*32+23) /* Single Thread Indirect Branch Predictors */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -274,9 +274,9 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
-#define X86_FEATURE_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
-#define X86_FEATURE_IBRS		(13*32+14) /* Indirect Branch Restricted Speculation */
-#define X86_FEATURE_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
+#define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
+#define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ce243f7d2d4e..1831203800d3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -757,17 +757,23 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	 * and they also have a different bit for STIBP support. Also,
 	 * a hypervisor might have set the individual AMD bits even on
 	 * Intel CPUs, for finer-grained selection of what's available.
-	 *
-	 * We use the AMD bits in 0x8000_0008 EBX as the generic hardware
-	 * features, which are visible in /proc/cpuinfo and used by the
-	 * kernel. So set those accordingly from the Intel bits.
 	 */
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 	}
+
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
+
+	if (cpu_has(c, X86_FEATURE_AMD_IBRS))
+		set_cpu_cap(c, X86_FEATURE_IBRS);
+
+	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
+		set_cpu_cap(c, X86_FEATURE_IBPB);
+
+	if (cpu_has(c, X86_FEATURE_AMD_STIBP))
+		set_cpu_cap(c, X86_FEATURE_STIBP);
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1fc05e428aba..71e1d6334f7d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4108,7 +4108,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
 			return 1;
 
 		msr_info->data = svm->spec_ctrl;
@@ -4203,7 +4203,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
@@ -4230,7 +4230,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB))
 			return 1;
 
 		if (data & ~PRED_CMD_IBPB)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c7668806163f..dca7e8b8597b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3523,7 +3523,6 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		return kvm_get_msr_common(vcpu, msr_info);
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
 			return 1;
 
@@ -3642,7 +3641,6 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
 			return 1;
 
@@ -3673,7 +3671,6 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
 			return 1;
 
-- 
2.17.0.391.g1f1cddd558b5

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
