Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD989C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887752082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE2P2I+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887752082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeLDLO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:14:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbeLDLG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:06:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C92C214DB;
        Tue,  4 Dec 2018 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921616;
        bh=KpVMDffQ08ENAvgHMpCqV4bRgS8kALFQ4WipFLqBXHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tE2P2I+5m8e/lQHqSZhFfiuWwaVLqZzWf5ETxJqILx48PMmYah++wUR9KJ/p/eyH3
         QLUFRy/FR3PftNkBJaOXbxHv8tu1be4yZeJ6vgmVive7hLK+AWvjAk2AynOj74FX00
         8MyUA6a49W7PVphDqmYOtX908ksR4fznWfqnWCjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 106/146] x86/speculation: Enable prctl mode for spectre_v2_user
Date:   Tue,  4 Dec 2018 11:49:52 +0100
Message-Id: <20181204103731.093638436@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit 7cc765a67d8e04ef7d772425ca5a2a1e2b894c15 upstream

Now that all prerequisites are in place:

 - Add the prctl command line option

 - Default the 'auto' mode to 'prctl'

 - When SMT state changes, update the static key which controls the
   conditional STIBP evaluation on context switch.

 - At init update the static key which controls the conditional IBPB
   evaluation on context switch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185005.958421388@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    7 +++-
 arch/x86/kernel/cpu/bugs.c                      |   41 ++++++++++++++++++------
 2 files changed, 38 insertions(+), 10 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4036,9 +4036,14 @@
 			off     - Unconditionally disable mitigations. Is
 				  enforced by spectre_v2=off
 
+			prctl   - Indirect branch speculation is enabled,
+				  but mitigation can be enabled via prctl
+				  per thread.  The mitigation control state
+				  is inherited on fork.
+
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
-				  Default is off.
+				  Default is prctl.
 
 			Not specifying this option is equivalent to
 			spectre_v2_user=auto.
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -254,11 +254,13 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
+	SPECTRE_V2_USER_CMD_PRCTL,
 };
 
 static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_NONE]		= "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]	= "User space: Mitigation: STIBP protection",
+	[SPECTRE_V2_USER_PRCTL]		= "User space: Mitigation: STIBP via prctl",
 };
 
 static const struct {
@@ -269,6 +271,7 @@ static const struct {
 	{ "auto",	SPECTRE_V2_USER_CMD_AUTO,	false },
 	{ "off",	SPECTRE_V2_USER_CMD_NONE,	false },
 	{ "on",		SPECTRE_V2_USER_CMD_FORCE,	true  },
+	{ "prctl",	SPECTRE_V2_USER_CMD_PRCTL,	false },
 };
 
 static void __init spec_v2_user_print_cond(const char *reason, bool secure)
@@ -323,12 +326,15 @@ spectre_v2_user_select_mitigation(enum s
 		smt_possible = false;
 
 	switch (spectre_v2_parse_user_cmdline(v2_cmd)) {
-	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_NONE:
 		goto set_mode;
 	case SPECTRE_V2_USER_CMD_FORCE:
 		mode = SPECTRE_V2_USER_STRICT;
 		break;
+	case SPECTRE_V2_USER_CMD_AUTO:
+	case SPECTRE_V2_USER_CMD_PRCTL:
+		mode = SPECTRE_V2_USER_PRCTL;
+		break;
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier */
@@ -339,6 +345,9 @@ spectre_v2_user_select_mitigation(enum s
 		case SPECTRE_V2_USER_STRICT:
 			static_branch_enable(&switch_mm_always_ibpb);
 			break;
+		case SPECTRE_V2_USER_PRCTL:
+			static_branch_enable(&switch_mm_cond_ibpb);
+			break;
 		default:
 			break;
 		}
@@ -351,6 +360,12 @@ spectre_v2_user_select_mitigation(enum s
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
+	/*
+	 * If SMT is not possible or STIBP is not available clear the STIPB
+	 * mode.
+	 */
+	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
+		mode = SPECTRE_V2_USER_NONE;
 set_mode:
 	spectre_v2_user = mode;
 	/* Only print the STIBP mode when SMT possible */
@@ -549,6 +564,15 @@ static void update_stibp_strict(void)
 	on_each_cpu(update_stibp_msr, NULL, 1);
 }
 
+/* Update the static key controlling the evaluation of TIF_SPEC_IB */
+static void update_indir_branch_cond(void)
+{
+	if (sched_smt_active())
+		static_branch_enable(&switch_to_cond_stibp);
+	else
+		static_branch_disable(&switch_to_cond_stibp);
+}
+
 void arch_smt_update(void)
 {
 	/* Enhanced IBRS implies STIBP. No update required. */
@@ -564,6 +588,7 @@ void arch_smt_update(void)
 		update_stibp_strict();
 		break;
 	case SPECTRE_V2_USER_PRCTL:
+		update_indir_branch_cond();
 		break;
 	}
 
@@ -1035,7 +1060,8 @@ static char *stibp_state(void)
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_USER_PRCTL:
-		return "";
+		if (static_key_enabled(&switch_to_cond_stibp))
+			return ", STIBP: conditional";
 	}
 	return "";
 }
@@ -1043,14 +1069,11 @@ static char *stibp_state(void)
 static char *ibpb_state(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		switch (spectre_v2_user) {
-		case SPECTRE_V2_USER_NONE:
-			return ", IBPB: disabled";
-		case SPECTRE_V2_USER_STRICT:
+		if (static_key_enabled(&switch_mm_always_ibpb))
 			return ", IBPB: always-on";
-		case SPECTRE_V2_USER_PRCTL:
-			return "";
-		}
+		if (static_key_enabled(&switch_mm_cond_ibpb))
+			return ", IBPB: conditional";
+		return ", IBPB: disabled";
 	}
 	return "";
 }


