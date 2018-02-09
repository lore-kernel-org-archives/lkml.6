Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184836-2-5832525444978512098
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184834; b=XuqlQ2ojQTbS3/YlAP3IVwtJAN5FmMn3BS1mSHez1O0c1t4
    f+Dmuey2lynPQkrNa5X8rCAAmAQRg9WVBD8tqJE6uZ5C+21iDJuK7F/Neyo7Z0Ka
    kx1G6NJGaIOwnBhtgMgnr1IPJrVNwiz04XUHkCWSvgefF4dErbZetszub89SFJ7c
    Rhn4FltP0QM3TKDZ7wBkLUs++2KzzZgQA14aXwd6tav/W2tWka9/k0HopqgpnPz6
    aanQCEAoE6ghA4hhy2MBzy8IEDSBO0kefmOw7i67l1Kyws9nW7EV42oJJ1S0dHUV
    hR23Ag8l3jhJHYJuafrN9+KuhBr+3F4zaDgP2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184834; bh=7V5bqnsq+o8AW2129NiXRMeQqN
    v2tSuf3M9jHYQgB1I=; b=LVzzN4KH/0BVdTOahEjMOeXd+kKL8bomt7UsfGHDCd
    3EGPjrlbqZisB2eMF433XpzSy1/u2prTvg22MxC9ttrG9UX1L1oeMAfePKbaso0d
    G7qdM9n0l0GnxGTfkEp0FbJl+qAAkOIH3/TP3hdQNkhagQlRCT2A9zz8CjqogLfM
    EPCrOwpuyawj/VUnrqyo4LLb9Zw6WUwLCnq82jZa+aCJHxK2ufv8GURseNn6Nfgf
    sfi49v/1IQdiwToDb2RRS00A6uk9fQWi33V0wDy6N5f1teR3HnE/ujE0VHbEW4H/
    7N6IiNVBYaWvw/3C22U+FnkL9gBjDgTOQtZNo60E4YbQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBIOAN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:00:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeBINoP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, ak@linux.intel.com,
        dave.hansen@intel.com, karahmed@amazon.de, arjan@linux.intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        gregkh@linux-foundation.org
Subject: [PATCH 4.9 50/92] x86/cpufeatures: Clean up Spectre v2 related CPUID flags
Date: Fri,  9 Feb 2018 14:39:19 +0100
Message-Id: <20180209133934.786300537@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit 2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2)

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
---
 arch/x86/include/asm/cpufeatures.h   |   18 +++++++++---------
 arch/x86/include/asm/nospec-branch.h |    2 +-
 arch/x86/kernel/cpu/bugs.c           |    7 +++----
 arch/x86/kernel/cpu/intel.c          |   31 +++++++++++++++++++++----------
 4 files changed, 34 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -194,15 +194,15 @@
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
 
-#define X86_FEATURE_RETPOLINE	( 7*32+12) /* Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* AMD Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE	( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 
-#define X86_FEATURE_RSB_CTXSW	( 7*32+19) /* Fill RSB on context switches */
+#define X86_FEATURE_RSB_CTXSW	( 7*32+19) /* "" Fill RSB on context switches */
 
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
 #define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
 
-#define X86_FEATURE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled*/
+#define X86_FEATURE_USE_IBPB	( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
@@ -260,9 +260,9 @@
 /* AMD-defined CPU features, CPUID level 0x80000008 (ebx), word 13 */
 #define X86_FEATURE_CLZERO	(13*32+0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF	(13*32+1) /* Instructions Retired Count */
-#define X86_FEATURE_AMD_PRED_CMD (13*32+12) /* Prediction Command MSR (AMD) */
-#define X86_FEATURE_AMD_SPEC_CTRL (13*32+14) /* Speculation Control MSR only (AMD) */
-#define X86_FEATURE_AMD_STIBP	(13*32+15) /* Single Thread Indirect Branch Predictors (AMD) */
+#define X86_FEATURE_IBPB	(13*32+12) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_IBRS	(13*32+14) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_STIBP	(13*32+15) /* Single Thread Indirect Branch Predictors */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (eax), word 14 */
 #define X86_FEATURE_DTHERM	(14*32+ 0) /* Digital Thermal Sensor */
@@ -301,8 +301,8 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
-#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* Speculation Control (IBRS + IBPB) */
-#define X86_FEATURE_STIBP		(18*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
 
 /*
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -225,7 +225,7 @@ static inline void indirect_branch_predi
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
@@ -272,9 +272,8 @@ retpoline_auto:
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
@@ -307,7 +306,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 		return sprintf(buf, "Not affected\n");
 
 	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IBPB" : "",
+		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
 		       spectre_v2_module_string());
 }
 #endif
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -140,17 +140,28 @@ static void early_init_intel(struct cpui
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
