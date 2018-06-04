Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeFDJEP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:04:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51484 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:04:14 -0400
X-Google-Smtp-Source: ADUXVKKIPb2JXa7iWAKU3ERazEGr4tjQofHobJk4x8LcSWWO1sN/7ghkcpkLhwBmO0wqMpF2yGi2nw==
Date: Mon, 4 Jun 2018 11:04:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20180604090409.GA18667@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 4e9ae0d3d5bf4e2f1b466ba451bd18f2c5b69845 Merge tag 'perf-urgent-for-mingo-4.17-20180602' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Leftover perf tooling fixes from the v4.17 cycle: they sync up updated ABI headers 
with their tooling versions.

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (4):
      perf trace beauty prctl: Default header_dir to cwd to work without parms
      tools headers: Synchronize prctl.h ABI header
      tools headers: Sync x86 cpufeatures.h with the kernel sources
      perf tools intel-pt-decoder: Update insn.h from the kernel sources


 tools/arch/x86/include/asm/cpufeatures.h | 20 ++++++++++++++------
 tools/include/uapi/linux/prctl.h         | 12 ++++++++++++
 tools/perf/trace/beauty/prctl_option.sh  |  2 +-
 tools/perf/util/intel-pt-decoder/insn.h  | 18 ++++++++++++++++++
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 578793e97431..fb00a2fca990 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -198,7 +198,6 @@
 #define X86_FEATURE_CAT_L2		( 7*32+ 5) /* Cache Allocation Technology L2 */
 #define X86_FEATURE_CDP_L3		( 7*32+ 6) /* Code and Data Prioritization L3 */
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
-
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_SME			( 7*32+10) /* AMD Secure Memory Encryption */
@@ -207,13 +206,19 @@
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
-
+#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
+#define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
 #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
-
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
+#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
+#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */
+#define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -274,9 +279,10 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
-#define X86_FEATURE_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
-#define X86_FEATURE_IBRS		(13*32+14) /* Indirect Branch Restricted Speculation */
-#define X86_FEATURE_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
+#define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
+#define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
@@ -334,6 +340,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
 /*
  * BUG word(s)
@@ -363,5 +370,6 @@
 #define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown attack and needs kernel page table isolation */
 #define X86_BUG_SPECTRE_V1		X86_BUG(15) /* CPU is affected by Spectre variant 1 attack with conditional branches */
 #define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
+#define X86_BUG_SPEC_STORE_BYPASS	X86_BUG(17) /* CPU is affected by speculative store bypass attack */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index af5f8c2df87a..db9f15f5db04 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -207,4 +207,16 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Per task speculation control */
+#define PR_GET_SPECULATION_CTRL		52
+#define PR_SET_SPECULATION_CTRL		53
+/* Speculation control variants */
+# define PR_SPEC_STORE_BYPASS		0
+/* Return and control values for PR_SET/GET_SPECULATION_CTRL */
+# define PR_SPEC_NOT_AFFECTED		0
+# define PR_SPEC_PRCTL			(1UL << 0)
+# define PR_SPEC_ENABLE			(1UL << 1)
+# define PR_SPEC_DISABLE		(1UL << 2)
+# define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index 0be4138fbe71..f24722146ebe 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
 regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
diff --git a/tools/perf/util/intel-pt-decoder/insn.h b/tools/perf/util/intel-pt-decoder/insn.h
index e23578c7b1be..2669c9f748e4 100644
--- a/tools/perf/util/intel-pt-decoder/insn.h
+++ b/tools/perf/util/intel-pt-decoder/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
