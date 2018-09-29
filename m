Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D53C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F922087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F922087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeI3ESW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51563 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbeI3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000Gw-EI; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006p9-84; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Jon Masters" <jcm@redhat.com>, "Ingo Molnar" <mingo@kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.968064338@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 004/131] x86/bugs: Read SPEC_CTRL MSR during boot and
 re-use reserved bits
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 1b86883ccb8d5d9506529d42dbe1a5257cb30b18 upstream.

The 336996-Speculative-Execution-Side-Channel-Mitigations.pdf refers to all
the other bits as reserved. The Intel SDM glossary defines reserved as
implementation specific - aka unknown.

As such at bootup this must be taken it into account and proper masking for
the bits in use applied.

A copy of this document is available at
https://bugzilla.kernel.org/show_bug.cgi?id=199511

[ tglx: Made x86_spec_ctrl_base __ro_after_init ]

Suggested-by: Jon Masters <jcm@redhat.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - We don't have __ro_after_init
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 24 ++++++++++++++++++++----
 arch/x86/kernel/cpu/bugs.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -172,6 +172,17 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
+/*
+ * The Intel specification for the SPEC_CTRL MSR requires that we
+ * preserve any already set reserved bits at boot time (e.g. for
+ * future additions that this kernel is not currently aware of).
+ * We then set any additional mitigation bits that we want
+ * ourselves and always use this as the base for SPEC_CTRL.
+ * We also use this when handling guest entry/exit as below.
+ */
+extern void x86_spec_ctrl_set(u64);
+extern u64 x86_spec_ctrl_get_default(void);
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
@@ -208,8 +219,9 @@ void alternative_msr_write(unsigned int
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_msr_write(MSR_IA32_PRED_CMD, PRED_CMD_IBPB,
-			      X86_FEATURE_USE_IBPB);
+	u64 val = PRED_CMD_IBPB;
+
+	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
 /*
@@ -220,14 +232,18 @@ static inline void indirect_branch_predi
  */
 #define firmware_restrict_branch_speculation_start()			\
 do {									\
+	u64 val = x86_spec_ctrl_get_default() | SPEC_CTRL_IBRS;		\
+									\
 	preempt_disable();						\
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,	\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
 } while (0)
 
 #define firmware_restrict_branch_speculation_end()			\
 do {									\
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,			\
+	u64 val = x86_spec_ctrl_get_default();				\
+									\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
 	preempt_enable();						\
 } while (0)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,12 @@
 
 static void __init spectre_v2_select_mitigation(void);
 
+/*
+ * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
+ * writes to SPEC_CTRL contain whatever reserved bits have been set.
+ */
+static u64 x86_spec_ctrl_base;
+
 #ifdef CONFIG_X86_32
 
 static double __initdata x = 4195835.0;
@@ -94,6 +100,13 @@ void __init check_bugs(void)
 		print_cpu_info(&boot_cpu_data);
 	}
 
+	/*
+	 * Read the SPEC_CTRL MSR to account for reserved bits which may
+	 * have unknown values.
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBRS))
+		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
@@ -157,6 +170,21 @@ static const char *spectre_v2_strings[]
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
+void x86_spec_ctrl_set(u64 val)
+{
+	if (val & ~SPEC_CTRL_IBRS)
+		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
+	else
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
+
+u64 x86_spec_ctrl_get_default(void)
+{
+	return x86_spec_ctrl_base;
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 

