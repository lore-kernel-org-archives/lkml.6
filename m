Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C231DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6488A21748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6488A21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeHCMuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:50:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHCMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:50:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73Astlq3859138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:54:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73AstKn3859135;
        Fri, 3 Aug 2018 03:54:55 -0700
Date:   Fri, 3 Aug 2018 03:54:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth <tipbot@zytor.com>
Message-ID: <tip-706d51681d636a0c4a5ef53395ec3b803e45ed4d@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        sai.praneeth.prakhya@intel.com, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, tim.c.chen@intel.com, ravi.v.shankar@intel.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
          sai.praneeth.prakhya@intel.com, linux-kernel@vger.kernel.org,
          tim.c.chen@intel.com, dwmw@amazon.co.uk, tglx@linutronix.de,
          ravi.v.shankar@intel.com
In-Reply-To: <1533148945-24095-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1533148945-24095-1-git-send-email-sai.praneeth.prakhya@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Support Enhanced IBRS on future CPUs
Git-Commit-ID: 706d51681d636a0c4a5ef53395ec3b803e45ed4d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  706d51681d636a0c4a5ef53395ec3b803e45ed4d
Gitweb:     https://git.kernel.org/tip/706d51681d636a0c4a5ef53395ec3b803e45ed4d
Author:     Sai Praneeth <sai.praneeth.prakhya@intel.com>
AuthorDate: Wed, 1 Aug 2018 11:42:25 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:50:34 +0200

x86/speculation: Support Enhanced IBRS on future CPUs

Future Intel processors will support "Enhanced IBRS" which is an "always
on" mode i.e. IBRS bit in SPEC_CTRL MSR is enabled once and never
disabled.

From the specification [1]:

 "With enhanced IBRS, the predicted targets of indirect branches
  executed cannot be controlled by software that was executed in a less
  privileged predictor mode or on another logical processor. As a
  result, software operating on a processor with enhanced IBRS need not
  use WRMSR to set IA32_SPEC_CTRL.IBRS after every transition to a more
  privileged predictor mode. Software can isolate predictor modes
  effectively simply by setting the bit once. Software need not disable
  enhanced IBRS prior to entering a sleep state such as MWAIT or HLT."

If Enhanced IBRS is supported by the processor then use it as the
preferred spectre v2 mitigation mechanism instead of Retpoline. Intel's
Retpoline white paper [2] states:

 "Retpoline is known to be an effective branch target injection (Spectre
  variant 2) mitigation on Intel processors belonging to family 6
  (enumerated by the CPUID instruction) that do not have support for
  enhanced IBRS. On processors that support enhanced IBRS, it should be
  used for mitigation instead of retpoline."

The reason why Enhanced IBRS is the recommended mitigation on processors
which support it is that these processors also support CET which
provides a defense against ROP attacks. Retpoline is very similar to ROP
techniques and might trigger false positives in the CET defense.

If Enhanced IBRS is selected as the mitigation technique for spectre v2,
the IBRS bit in SPEC_CTRL MSR is set once at boot time and never
cleared. Kernel also has to make sure that IBRS bit remains set after
VMEXIT because the guest might have cleared the bit. This is already
covered by the existing x86_spec_ctrl_set_guest() and
x86_spec_ctrl_restore_host() speculation control functions.

Enhanced IBRS still requires IBPB for full mitigation.

[1] Speculative-Execution-Side-Channel-Mitigations.pdf
[2] Retpoline-A-Branch-Target-Injection-Mitigation.pdf
Both documents are available at:
https://bugzilla.kernel.org/show_bug.cgi?id=199511

Originally-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim C Chen <tim.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/1533148945-24095-1-git-send-email-sai.praneeth.prakhya@intel.com

---
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/nospec-branch.h |  1 +
 arch/x86/kernel/cpu/bugs.c           | 20 ++++++++++++++++++--
 arch/x86/kernel/cpu/common.c         |  3 +++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd31..2687cd8e8d58 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,6 +219,7 @@
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_IBRS_ENHANCED	( 7*32+29) /* Enhanced IBRS */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c99082e2ef13..fd2a8c1b88bc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -214,6 +214,7 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
 	SPECTRE_V2_RETPOLINE_GENERIC,
 	SPECTRE_V2_RETPOLINE_AMD,
+	SPECTRE_V2_IBRS_ENHANCED,
 };
 
 /* The Speculative Store Bypass disable variants */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bc8c43b22460..405a9a61bb89 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -130,6 +130,7 @@ static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
 	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
 };
 
 #undef pr_fmt
@@ -332,6 +333,13 @@ static void __init spectre_v2_select_mitigation(void)
 
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
+			mode = SPECTRE_V2_IBRS_ENHANCED;
+			/* Force it so VMEXIT will restore correctly */
+			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
+			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+			goto specv2_set_mode;
+		}
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_auto;
 		break;
@@ -369,6 +377,7 @@ retpoline_auto:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}
 
+specv2_set_mode:
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -391,9 +400,16 @@ retpoline_auto:
 
 	/*
 	 * Retpoline means the kernel is safe because it has no indirect
-	 * branches. But firmware isn't, so use IBRS to protect that.
+	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
+	 * speculation around firmware calls only when Enhanced IBRS isn't
+	 * supported.
+	 *
+	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
+	 * the user might select retpoline on the kernel command line and if
+	 * the CPU supports Enhanced IBRS, kernel might un-intentionally not
+	 * enable IBRS around firmware calls.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS)) {
+	if (boot_cpu_has(X86_FEATURE_IBRS) && mode != SPECTRE_V2_IBRS_ENHANCED) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 43a927eb9c09..df28e931d732 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1005,6 +1005,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
+	if (ia32_cap & ARCH_CAP_IBRS_ALL)
+		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
+
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
