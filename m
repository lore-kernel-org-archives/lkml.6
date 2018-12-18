Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B3F21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeLRNTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:19:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeLRNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:19:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDIs262842117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:18:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDIrUb2842114;
        Tue, 18 Dec 2018 05:18:53 -0800
Date:   Tue, 18 Dec 2018 05:18:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Lendacky <tipbot@zytor.com>
Message-ID: <tip-20c3a2c33e9fdc82e9e8e8d2a6445b3256d20191@git.kernel.org>
Cc:     dwmw@amazon.co.uk, tglx@linutronix.de, tim.c.chen@linux.intel.com,
        mingo@kernel.org, Thomas.Lendacky@amd.com, jkosina@suse.cz,
        aarcange@redhat.com, thomas.lendacky@amd.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, konrad.wilk@oracle.com
Reply-To: tglx@linutronix.de, dwmw@amazon.co.uk,
          tim.c.chen@linux.intel.com, mingo@kernel.org,
          Thomas.Lendacky@amd.com, aarcange@redhat.com, jkosina@suse.cz,
          thomas.lendacky@amd.com, bp@alien8.de, konrad.wilk@oracle.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20181213230352.6937.74943.stgit@tlendack-t1.amdoffice.net>
References: <20181213230352.6937.74943.stgit@tlendack-t1.amdoffice.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Add support for STIBP always-on
 preferred mode
Git-Commit-ID: 20c3a2c33e9fdc82e9e8e8d2a6445b3256d20191
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

Commit-ID:  20c3a2c33e9fdc82e9e8e8d2a6445b3256d20191
Gitweb:     https://git.kernel.org/tip/20c3a2c33e9fdc82e9e8e8d2a6445b3256d20191
Author:     Thomas Lendacky <Thomas.Lendacky@amd.com>
AuthorDate: Thu, 13 Dec 2018 23:03:54 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Dec 2018 14:13:33 +0100

x86/speculation: Add support for STIBP always-on preferred mode

Different AMD processors may have different implementations of STIBP.
When STIBP is conditionally enabled, some implementations would benefit
from having STIBP always on instead of toggling the STIBP bit through MSR
writes. This preference is advertised through a CPUID feature bit.

When conditional STIBP support is requested at boot and the CPU advertises
STIBP always-on mode as preferred, switch to STIBP "on" support. To show
that this transition has occurred, create a new spectre_v2_user_mitigation
value and a new spectre_v2_user_strings message. The new mitigation value
is used in spectre_v2_user_select_mitigation() to print the new mitigation
message as well as to return a new string from stibp_state().

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20181213230352.6937.74943.stgit@tlendack-t1.amdoffice.net

---
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/nospec-branch.h |  1 +
 arch/x86/kernel/cpu/bugs.c           | 28 ++++++++++++++++++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 28c4a502b419..df8e94e2f7be 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -284,6 +284,7 @@
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 032b6009baab..dad12b767ba0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -232,6 +232,7 @@ enum spectre_v2_mitigation {
 enum spectre_v2_user_mitigation {
 	SPECTRE_V2_USER_NONE,
 	SPECTRE_V2_USER_STRICT,
+	SPECTRE_V2_USER_STRICT_PREFERRED,
 	SPECTRE_V2_USER_PRCTL,
 	SPECTRE_V2_USER_SECCOMP,
 };
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 58689ac64440..77bf22546ddd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -262,10 +262,11 @@ enum spectre_v2_user_cmd {
 };
 
 static const char * const spectre_v2_user_strings[] = {
-	[SPECTRE_V2_USER_NONE]		= "User space: Vulnerable",
-	[SPECTRE_V2_USER_STRICT]	= "User space: Mitigation: STIBP protection",
-	[SPECTRE_V2_USER_PRCTL]		= "User space: Mitigation: STIBP via prctl",
-	[SPECTRE_V2_USER_SECCOMP]	= "User space: Mitigation: STIBP via seccomp and prctl",
+	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
+	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
+	[SPECTRE_V2_USER_STRICT_PREFERRED]	= "User space: Mitigation: STIBP always-on protection",
+	[SPECTRE_V2_USER_PRCTL]			= "User space: Mitigation: STIBP via prctl",
+	[SPECTRE_V2_USER_SECCOMP]		= "User space: Mitigation: STIBP via seccomp and prctl",
 };
 
 static const struct {
@@ -355,6 +356,15 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		break;
 	}
 
+	/*
+	 * At this point, an STIBP mode other than "off" has been set.
+	 * If STIBP support is not being forced, check if STIBP always-on
+	 * is preferred.
+	 */
+	if (mode != SPECTRE_V2_USER_STRICT &&
+	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
+		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
+
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
@@ -610,6 +620,7 @@ void arch_smt_update(void)
 	case SPECTRE_V2_USER_NONE:
 		break;
 	case SPECTRE_V2_USER_STRICT:
+	case SPECTRE_V2_USER_STRICT_PREFERRED:
 		update_stibp_strict();
 		break;
 	case SPECTRE_V2_USER_PRCTL:
@@ -812,7 +823,8 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		 * Indirect branch speculation is always disabled in strict
 		 * mode.
 		 */
-		if (spectre_v2_user == SPECTRE_V2_USER_STRICT)
+		if (spectre_v2_user == SPECTRE_V2_USER_STRICT ||
+		    spectre_v2_user == SPECTRE_V2_USER_STRICT_PREFERRED)
 			return -EPERM;
 		task_clear_spec_ib_disable(task);
 		task_update_spec_tif(task);
@@ -825,7 +837,8 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		 */
 		if (spectre_v2_user == SPECTRE_V2_USER_NONE)
 			return -EPERM;
-		if (spectre_v2_user == SPECTRE_V2_USER_STRICT)
+		if (spectre_v2_user == SPECTRE_V2_USER_STRICT ||
+		    spectre_v2_user == SPECTRE_V2_USER_STRICT_PREFERRED)
 			return 0;
 		task_set_spec_ib_disable(task);
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
@@ -896,6 +909,7 @@ static int ib_prctl_get(struct task_struct *task)
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
 	case SPECTRE_V2_USER_STRICT:
+	case SPECTRE_V2_USER_STRICT_PREFERRED:
 		return PR_SPEC_DISABLE;
 	default:
 		return PR_SPEC_NOT_AFFECTED;
@@ -1089,6 +1103,8 @@ static char *stibp_state(void)
 		return ", STIBP: disabled";
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
+	case SPECTRE_V2_USER_STRICT_PREFERRED:
+		return ", STIBP: always-on";
 	case SPECTRE_V2_USER_PRCTL:
 	case SPECTRE_V2_USER_SECCOMP:
 		if (static_key_enabled(&switch_to_cond_stibp))
