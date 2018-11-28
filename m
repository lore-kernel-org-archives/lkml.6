Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD526C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8057F20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8057F20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeK2B0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:26:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeK2B0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:26:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASENjln2321014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:23:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASENjrJ2321010;
        Wed, 28 Nov 2018 06:23:45 -0800
Date:   Wed, 28 Nov 2018 06:23:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tim Chen <tipbot@zytor.com>
Message-ID: <tip-01daf56875ee0cd50ed496a09b20eb369b45dfa5@git.kernel.org>
Cc:     peterz@infradead.org, arjan@linux.intel.com,
        asit.k.mallick@intel.com, keescook@chromium.org,
        ak@linux.intel.com, casey.schaufler@intel.com,
        tim.c.chen@linux.intel.com, aarcange@redhat.com,
        longman9394@gmail.com, Thomas.Lendacky@amd.com,
        thomas.lendacky@amd.com, jpoimboe@redhat.com, luto@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dwmw@amazon.co.uk, torvalds@linux-foundation.org, jkosina@suse.cz,
        tglx@linutronix.de, jcm@redhat.com, gregkh@linuxfoundation.org,
        mingo@kernel.org, david.c.stewart@intel.com
Reply-To: linux-kernel@vger.kernel.org, dave.hansen@intel.com,
          jkosina@suse.cz, torvalds@linux-foundation.org,
          dwmw@amazon.co.uk, mingo@kernel.org, david.c.stewart@intel.com,
          gregkh@linuxfoundation.org, tglx@linutronix.de, jcm@redhat.com,
          ak@linux.intel.com, casey.schaufler@intel.com,
          keescook@chromium.org, peterz@infradead.org,
          asit.k.mallick@intel.com, arjan@linux.intel.com,
          thomas.lendacky@amd.com, hpa@zytor.com, luto@kernel.org,
          jpoimboe@redhat.com, aarcange@redhat.com,
          tim.c.chen@linux.intel.com, Thomas.Lendacky@amd.com,
          longman9394@gmail.com
In-Reply-To: <20181125185004.151077005@linutronix.de>
References: <20181125185004.151077005@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Reorganize speculation control MSRs
 update
Git-Commit-ID: 01daf56875ee0cd50ed496a09b20eb369b45dfa5
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

Commit-ID:  01daf56875ee0cd50ed496a09b20eb369b45dfa5
Gitweb:     https://git.kernel.org/tip/01daf56875ee0cd50ed496a09b20eb369b45dfa5
Author:     Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate: Sun, 25 Nov 2018 19:33:35 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:06 +0100

x86/speculation: Reorganize speculation control MSRs update

The logic to detect whether there's a change in the previous and next
task's flag relevant to update speculation control MSRs is spread out
across multiple functions.

Consolidate all checks needed for updating speculation control MSRs into
the new __speculation_ctrl_update() helper function.

This makes it easy to pick the right speculation control MSR and the bits
in MSR_IA32_SPEC_CTRL that need updating based on TIF flags changes.

Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
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
Link: https://lkml.kernel.org/r/20181125185004.151077005@linutronix.de


---
 arch/x86/kernel/process.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 8aa49604f9ae..70e9832379e1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -395,27 +395,40 @@ static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
 	wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
 }
 
-static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
-{
-	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
-
-	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
-}
+/*
+ * Update the MSRs managing speculation control, during context switch.
+ *
+ * tifp: Previous task's thread flags
+ * tifn: Next task's thread flags
+ */
+static __always_inline void __speculation_ctrl_update(unsigned long tifp,
+						      unsigned long tifn)
+{
+	u64 msr = x86_spec_ctrl_base;
+	bool updmsr = false;
+
+	/* If TIF_SSBD is different, select the proper mitigation method */
+	if ((tifp ^ tifn) & _TIF_SSBD) {
+		if (static_cpu_has(X86_FEATURE_VIRT_SSBD)) {
+			amd_set_ssb_virt_state(tifn);
+		} else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
+			amd_set_core_ssb_state(tifn);
+		} else if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+			   static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+			msr |= ssbd_tif_to_spec_ctrl(tifn);
+			updmsr  = true;
+		}
+	}
 
-static __always_inline void __speculation_ctrl_update(unsigned long tifn)
-{
-	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
-		amd_set_ssb_virt_state(tifn);
-	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
-		amd_set_core_ssb_state(tifn);
-	else
-		spec_ctrl_update_msr(tifn);
+	if (updmsr)
+		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
 void speculation_ctrl_update(unsigned long tif)
 {
+	/* Forced update. Make sure all relevant TIF flags are different */
 	preempt_disable();
-	__speculation_ctrl_update(tif);
+	__speculation_ctrl_update(~tif, tif);
 	preempt_enable();
 }
 
@@ -451,8 +464,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
-	if ((tifp ^ tifn) & _TIF_SSBD)
-		__speculation_ctrl_update(tifn);
+	__speculation_ctrl_update(tifp, tifn);
 }
 
 /*
