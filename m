Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeFAO7m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:59:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48654 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFAO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:59:37 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v1] AMD SSB bits.
Date: Fri,  1 Jun 2018 10:59:18 -0400
Message-Id: <20180601145921.9500-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.13.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8911 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was reading the AMD whitepaper on SSBD and noticed that they have added
two new bits in the 8000_0008 CPUID. EBX:
 1) Bit[26] - similar to Intel's SSB_NO not needed anymore.
 2) Bit[24] - use SPEC_CTRL MSR (0x48) instead of VIRT SPEC_CTRL MSR
    (0xC001_011f).

See 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
(A copy of this document is available at
    https://bugzilla.kernel.org/show_bug.cgi?id=199889)

Being that I don't have the hardware (not even sure if AMD has developed it yet)
I ended up cobbling up a DEBUG patch, the last one - which is well, debug
(see below).

QEMU patches will be sent in another patchset.

 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/kernel/cpu/bugs.c         | 13 +++++--------
 arch/x86/kernel/cpu/common.c       |  9 ++++++++-
 arch/x86/kvm/cpuid.c               | 10 ++++++++--
 arch/x86/kvm/svm.c                 |  8 +++++---
 5 files changed, 28 insertions(+), 14 deletions(-)
Konrad Rzeszutek Wilk (3):
      x86/bugs: Add AMD's variant of SSB_NO.
      x86/bugs: Add AMD's SPEC_CTRL MSR usage
      x86/bugs: Switch the selection of mitigation from CPU vendor to CPU features


>From 3d120f90731dae7e9a6f0c941c8bc228ed346baa Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Thu, 31 May 2018 20:56:08 -0400
Subject: [PATCH] DEBUG HACK DEBUG

Expose the two various Bits to the guest depending on the module
parameters.

Also show the various hidden flags in the /proc/cpuinfo.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/include/asm/cpufeatures.h | 14 +++++++-------
 arch/x86/kvm/cpuid.c               | 12 ++++++++++++
 arch/x86/kvm/svm.c                 | 13 -------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd31..05b74564089a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -206,15 +206,15 @@
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
-#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
+#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /*  MSR SPEC_CTRL is implemented */
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
 #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
-#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
-#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */
+#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /*  Disable Speculative Store Bypass. */
+#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /*  AMD SSBD implementation via LS_CFG MSR */
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
@@ -279,12 +279,12 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
-#define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
+#define X86_FEATURE_AMD_IBPB		(13*32+12) /*  Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
-#define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
+#define X86_FEATURE_AMD_STIBP		(13*32+15) /*  Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_SSBD		(13*32+24) /*  Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
-#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /*  Speculative Store Bypass is fixed in hardware. */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f4f30d0c25c4..67c5d4eb32ac 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -27,6 +27,12 @@
 #include "trace.h"
 #include "pmu.h"
 
+static bool __read_mostly expose_amd_ssb_no = 0;
+module_param(expose_amd_ssb_no, bool, S_IRUGO | S_IWUSR);
+
+static bool __read_mostly expose_amd_spec_ctrl = 0;
+module_param(expose_amd_spec_ctrl, bool, S_IRUGO | S_IWUSR);
+
 static u32 xstate_required_size(u64 xstate_bv, bool compacted)
 {
 	int feature_bit = 0;
@@ -672,6 +678,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
 		    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			entry->ebx |= F(VIRT_SSBD);
+
+		if (expose_amd_spec_ctrl && !boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			entry->ebx |= F(AMD_SSBD);
+
+		if (expose_amd_ssb_no && !boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			entry->ebx |= F(AMD_SSB_NO);
 		break;
 	}
 	case 0x80000019:
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 950ec50f77c3..a4c71b37df74 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -288,7 +288,6 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_CSTAR,				.always = true  },
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
-	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
@@ -4231,18 +4230,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (!data)
 			break;
 
-		/*
-		 * For non-nested:
-		 * When it's written (to non-zero) for the first time, pass
-		 * it through.
-		 *
-		 * For nested:
-		 * The handling of the MSR bitmap for L2 guests is done in
-		 * nested_svm_vmrun_msrpm.
-		 * We update the L1 MSR bit as well since it will end up
-		 * touching the MSR anyway now.
-		 */
-		set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
 		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr->host_initiated &&
-- 
2.13.4
