Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqvdZhod/LdMJfQC5B4nkbgQ8qBmxftgg6pM7GUplVWEEdT0VmqsSxIDSvVoKhHEUyqBlo0
ARC-Seal: i=1; a=rsa-sha256; t=1526937980; cv=none;
        d=google.com; s=arc-20160816;
        b=RT+z8yW2JL+SA/2GzTTJ8e3QgHmaDDjJEmD0qV37Gwr9G/e+DsBWqQOopaWbcBar2J
         gv/b/ElrY0ebTCHB6dDaY7d9bad5sj2QgD6k7VjV5vv1dWVOghA11/9d+u+ztivtUlm1
         NETDzkuhH+jnAX/fBg90lOi/VeZvp3i+mAhVHHMo1glFL12lyz0WrKaFXecUnaxtCSys
         QMUYimxwd1cLY01Whe5Y52o+jZkk4ruDWgnok5VmAG5a9K5WklfYbpfyMEZxTFxg+JCT
         Vje91yKeF8bCXgtgrYKD57E67MXBQmf/PcPlqITi5vrqA+jojJMIYRZZziPoi8zy7vxM
         +kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=czPB3/rna/KLsSRRLyFttd7YLAqd6QuVr3mFA1wg0k0=;
        b=PNX0qMQ4pbz8g62xvsvDGJyhPyZ64nbGczuYfvyDLgm14ajVObS7tkntzKFEQ/bEmj
         K5qRMgE4Ks238QAd9Gkv6G7ol2BIsUAj6IkhLxba1IjuZK+jNVzWpTb50nOPJsM/oNDA
         cWV7gRYu9qi6HQvvQiGndLq5mwaT0Jl7mde39nO2n5NoGewo+ogxgxQkCWXq1kYuq46K
         fut7G1UvMUpw707O5jZgamn8huVJgj8rDgA9VcnwVKZO/jrIb1hS3mk047lny+NWfHWs
         YH+ZKAOZFKJbJIG4Tbe35bxGPI50SqZc4K2lo1UhtaJfqGhzvjq1P/xbQMXbl1dYkYIk
         L24Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CYhDKG2M;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CYhDKG2M;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?q?J=C3=B6rg=20Otte?= <jrg.otte@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4.16 095/110] x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP
Date: Mon, 21 May 2018 23:12:32 +0200
Message-Id: <20180521210514.197770588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109924308566298?=
X-GMAIL-MSGID: =?utf-8?q?1601110520046922775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit e7c587da125291db39ddf1f49b18e5970adbac17 upstream

Intel and AMD have different CPUID bits hence for those use synthetic bits
which get set on the respective vendor's in init_speculation_control(). So
that debacles like what the commit message of

  c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")

talks about don't happen anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Jörg Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/20180504161815.GG9257@pd.tnic
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |   10 ++++++----
 arch/x86/kernel/cpu/common.c       |   14 ++++++++++----
 arch/x86/kvm/cpuid.c               |   10 +++++-----
 arch/x86/kvm/svm.c                 |    6 +++---
 arch/x86/kvm/vmx.c                 |    9 ++-------
 5 files changed, 26 insertions(+), 23 deletions(-)

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
@@ -216,6 +215,9 @@
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
 #define X86_FEATURE_AMD_SSBD		( 7*32+24)  /* "" AMD SSBD implementation */
+#define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -276,9 +278,9 @@
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
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -757,17 +757,23 @@ static void init_speculation_control(str
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
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -374,7 +374,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(IBPB) | F(IBRS);
+		F(AMD_IBPB) | F(AMD_IBRS);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -643,10 +643,10 @@ static inline int __do_cpuid_ent(struct
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
 		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
-		if (boot_cpu_has(X86_FEATURE_IBPB))
-			entry->ebx |= F(IBPB);
-		if (boot_cpu_has(X86_FEATURE_IBRS))
-			entry->ebx |= F(IBRS);
+		if (boot_cpu_has(X86_FEATURE_AMD_IBPB))
+			entry->ebx |= F(AMD_IBPB);
+		if (boot_cpu_has(X86_FEATURE_AMD_IBRS))
+			entry->ebx |= F(AMD_IBRS);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
 		break;
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3959,7 +3959,7 @@ static int svm_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
 			return 1;
 
 		msr_info->data = svm->spec_ctrl;
@@ -4057,7 +4057,7 @@ static int svm_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
@@ -4084,7 +4084,7 @@ static int svm_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB))
 			return 1;
 
 		if (data & ~PRED_CMD_IBPB)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3275,9 +3275,7 @@ static int vmx_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_SSBD))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
 			return 1;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
@@ -3397,9 +3395,7 @@ static int vmx_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_SSBD))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
@@ -3429,7 +3425,6 @@ static int vmx_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
 			return 1;
 
