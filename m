Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id neQuAjBMGVt+YAAAmS7hNA
	; Thu, 07 Jun 2018 15:17:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5B9DC6074D; Thu,  7 Jun 2018 15:17:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC8FC60290;
	Thu,  7 Jun 2018 15:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC8FC60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935977AbeFGPRX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:17:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41326 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935468AbeFGPAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:00:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvby-0005hO-4c; Thu, 07 Jun 2018 15:09:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jy-Vd; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        tim.c.chen@linux.intel.com, pbonzini@redhat.com,
        torvalds@linux-foundation.org,
        "Thomas Gleixner" <tglx@linutronix.de>, karahmed@amazon.de,
        arjan@linux.intel.com, gregkh@linux-foundation.org,
        ak@linux.intel.com, dave.hansen@intel.com
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.105327656@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 048/410] x86/cpufeatures: Clean up Spectre v2 related
 CPUID flags
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2 upstream.

We want to expose the hardware features simply in /proc/cpuinfo as "ibrs",
"ibpb" and "stibp". Since AMD has separate CPUID bits for those, use them
as the user-visible bits.

When the Intel SPEC_CTRL bit is set which indicates both IBRS and IBPB
capability, set those (AMD) bits accordingly. Likewise if the Intel STIBP
bit is set, set the AMD STIBP that's used for the generic hardware
capability.

Hide the rest from /proc/cpuinfo by putting "" in the comments. Including
RETPOLINE and RETPOLINE_AMD which shouldn't be visible there. There are
patches to make the sysfs vulnerabilities information non-readable by
non-root, and the same should apply to all information about which
mitigations are actually in use. Those *shouldn't* appear in /proc/cpuinfo.

The feature bit for whether IBPB is actually used, which is needed for
ALTERNATIVEs, is renamed to X86_FEATURE_USE_IBPB.

Originally-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517070274-12128-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: Adjust context and numbering]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h    | 12 +++++------
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           |  7 +++----
 arch/x86/kernel/cpu/intel.c          | 31 +++++++++++++++++++---------
 4 files changed, 31 insertions(+), 21 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -189,7 +189,7 @@
 #define X86_FEATURE_INVPCID_SINGLE (7*32+10) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_RSB_CTXSW	(7*32+11) /* "" Fill RSB on context switches */
 
-#define X86_FEATURE_IBPB	(7*32+12) /* Indirect Branch Prediction Barrier enabled*/
+#define X86_FEATURE_USE_IBPB	(7*32+12) /* "" Indirect Branch Prediction Barrier enabled */
 
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
@@ -237,14 +237,14 @@
 #define X86_FEATURE_AVX512CD	(9*32+28) /* AVX-512 Conflict Detection */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 10 */
-#define X86_FEATURE_SPEC_CTRL		(10*32+26) /* Speculation Control (IBRS + IBPB) */
-#define X86_FEATURE_STIBP		(10*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_SPEC_CTRL		(10*32+26) /* "" Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_INTEL_STIBP		(10*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(10*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 11 */
-#define X86_FEATURE_AMD_PRED_CMD	(11*32+12) /* Prediction Command MSR (AMD) */
-#define X86_FEATURE_AMD_SPEC_CTRL	(11*32+14) /* Speculation Control MSR only (AMD) */
-#define X86_FEATURE_AMD_STIBP		(11*32+15) /* Single Thread Indirect Branch Predictors (AMD) */
+#define X86_FEATURE_IBPB		(11*32+12) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_IBRS		(11*32+14) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_STIBP		(11*32+15) /* Single Thread Indirect Branch Predictors */
 
 /*
  * BUG word(s)
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -201,7 +201,7 @@ static inline void indirect_branch_predi
 				 "movl %[val], %%eax\n\t"
 				 "movl $0, %%edx\n\t"
 				 "wrmsr",
-				 X86_FEATURE_IBPB)
+				 X86_FEATURE_USE_IBPB)
 		     : : [msr] "i" (MSR_IA32_PRED_CMD),
 			 [val] "i" (PRED_CMD_IBPB)
 		     : "eax", "ecx", "edx", "memory");
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -360,9 +360,8 @@ retpoline_auto:
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
-	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) ||
-	    boot_cpu_has(X86_FEATURE_AMD_PRED_CMD)) {
-		setup_force_cpu_cap(X86_FEATURE_IBPB);
+	if (boot_cpu_has(X86_FEATURE_IBPB)) {
+		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		pr_info("Enabling Indirect Branch Prediction Barrier\n");
 	}
 }
@@ -395,7 +394,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IPBP" : "",
+		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
 		       spectre_v2_module_string());
 }
 #endif
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -105,17 +105,28 @@ static void early_init_intel(struct cpui
 		rdmsr(MSR_IA32_UCODE_REV, lower_word, c->microcode);
 	}
 
-	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
-	     cpu_has(c, X86_FEATURE_STIBP) ||
-	     cpu_has(c, X86_FEATURE_AMD_SPEC_CTRL) ||
-	     cpu_has(c, X86_FEATURE_AMD_PRED_CMD) ||
-	     cpu_has(c, X86_FEATURE_AMD_STIBP)) && bad_spectre_microcode(c)) {
-		pr_warn("Intel Spectre v2 broken microcode detected; disabling SPEC_CTRL\n");
-		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
+	/*
+	 * The Intel SPEC_CTRL CPUID bit implies IBRS and IBPB support,
+	 * and they also have a different bit for STIBP support. Also,
+	 * a hypervisor might have set the individual AMD bits even on
+	 * Intel CPUs, for finer-grained selection of what's available.
+	 */
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
+		set_cpu_cap(c, X86_FEATURE_IBRS);
+		set_cpu_cap(c, X86_FEATURE_IBPB);
+	}
+	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
+		set_cpu_cap(c, X86_FEATURE_STIBP);
+
+	/* Now if any of them are set, check the blacklist and clear the lot */
+	if ((cpu_has(c, X86_FEATURE_IBRS) || cpu_has(c, X86_FEATURE_IBPB) ||
+	     cpu_has(c, X86_FEATURE_STIBP)) && bad_spectre_microcode(c)) {
+		pr_warn("Intel Spectre v2 broken microcode detected; disabling Speculation Control\n");
+		clear_cpu_cap(c, X86_FEATURE_IBRS);
+		clear_cpu_cap(c, X86_FEATURE_IBPB);
 		clear_cpu_cap(c, X86_FEATURE_STIBP);
-		clear_cpu_cap(c, X86_FEATURE_AMD_SPEC_CTRL);
-		clear_cpu_cap(c, X86_FEATURE_AMD_PRED_CMD);
-		clear_cpu_cap(c, X86_FEATURE_AMD_STIBP);
+		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_INTEL_STIBP);
 	}
 
 	/*
