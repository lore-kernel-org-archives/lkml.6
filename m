Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A39C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EED2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EED2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeK2BZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:25:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49009 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2BZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:25:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASENBIW2320981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:23:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASENBrH2320978;
        Wed, 28 Nov 2018 06:23:11 -0800
Date:   Wed, 28 Nov 2018 06:23:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-26c4d75b234040c11728a8acb796b3a85ba7507c@git.kernel.org>
Cc:     hpa@zytor.com, casey.schaufler@intel.com, arjan@linux.intel.com,
        longman9394@gmail.com, thomas.lendacky@amd.com,
        dave.hansen@intel.com, gregkh@linuxfoundation.org, jkosina@suse.cz,
        david.c.stewart@intel.com, tim.c.chen@linux.intel.com,
        keescook@chromium.org, jpoimboe@redhat.com, jcm@redhat.com,
        asit.k.mallick@intel.com, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, luto@kernel.org, dwmw@amazon.co.uk,
        torvalds@linux-foundation.org, ak@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org
Reply-To: hpa@zytor.com, arjan@linux.intel.com, casey.schaufler@intel.com,
          longman9394@gmail.com, thomas.lendacky@amd.com,
          dave.hansen@intel.com, gregkh@linuxfoundation.org,
          david.c.stewart@intel.com, jkosina@suse.cz,
          keescook@chromium.org, tim.c.chen@linux.intel.com,
          jpoimboe@redhat.com, jcm@redhat.com, asit.k.mallick@intel.com,
          linux-kernel@vger.kernel.org, aarcange@redhat.com,
          luto@kernel.org, dwmw@amazon.co.uk,
          torvalds@linux-foundation.org, ak@linux.intel.com,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20181125185004.058866968@linutronix.de>
References: <20181125185004.058866968@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Rename SSBD update functions
Git-Commit-ID: 26c4d75b234040c11728a8acb796b3a85ba7507c
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

Commit-ID:  26c4d75b234040c11728a8acb796b3a85ba7507c
Gitweb:     https://git.kernel.org/tip/26c4d75b234040c11728a8acb796b3a85ba7507c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:34 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:06 +0100

x86/speculation: Rename SSBD update functions

During context switch, the SSBD bit in SPEC_CTRL MSR is updated according
to changes of the TIF_SSBD flag in the current and next running task.

Currently, only the bit controlling speculative store bypass disable in
SPEC_CTRL MSR is updated and the related update functions all have
"speculative_store" or "ssb" in their names.

For enhanced mitigation control other bits in SPEC_CTRL MSR need to be
updated as well, which makes the SSB names inadequate.

Rename the "speculative_store*" functions to a more generic name. No
functional change.

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
Link: https://lkml.kernel.org/r/20181125185004.058866968@linutronix.de



---
 arch/x86/include/asm/spec-ctrl.h |  6 +++---
 arch/x86/kernel/cpu/bugs.c       |  4 ++--
 arch/x86/kernel/process.c        | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index ae7c2c5cd7f0..8e2f8411c7a7 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -70,11 +70,11 @@ extern void speculative_store_bypass_ht_init(void);
 static inline void speculative_store_bypass_ht_init(void) { }
 #endif
 
-extern void speculative_store_bypass_update(unsigned long tif);
+extern void speculation_ctrl_update(unsigned long tif);
 
-static inline void speculative_store_bypass_update_current(void)
+static inline void speculation_ctrl_update_current(void)
 {
-	speculative_store_bypass_update(current_thread_info()->flags);
+	speculation_ctrl_update(current_thread_info()->flags);
 }
 
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 924cd06dd43b..a723af0c4400 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -200,7 +200,7 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 		tif = setguest ? ssbd_spec_ctrl_to_tif(guestval) :
 				 ssbd_spec_ctrl_to_tif(hostval);
 
-		speculative_store_bypass_update(tif);
+		speculation_ctrl_update(tif);
 	}
 }
 EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
@@ -632,7 +632,7 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	 * mitigation until it is next scheduled.
 	 */
 	if (task == current && update)
-		speculative_store_bypass_update_current();
+		speculation_ctrl_update_current();
 
 	return 0;
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c93fcfdf1673..8aa49604f9ae 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -395,27 +395,27 @@ static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
 	wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
 }
 
-static __always_inline void intel_set_ssb_state(unsigned long tifn)
+static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 {
 	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
 
 	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
-static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+static __always_inline void __speculation_ctrl_update(unsigned long tifn)
 {
 	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
 		amd_set_ssb_virt_state(tifn);
 	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		amd_set_core_ssb_state(tifn);
 	else
-		intel_set_ssb_state(tifn);
+		spec_ctrl_update_msr(tifn);
 }
 
-void speculative_store_bypass_update(unsigned long tif)
+void speculation_ctrl_update(unsigned long tif)
 {
 	preempt_disable();
-	__speculative_store_bypass_update(tif);
+	__speculation_ctrl_update(tif);
 	preempt_enable();
 }
 
@@ -452,7 +452,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
 	if ((tifp ^ tifn) & _TIF_SSBD)
-		__speculative_store_bypass_update(tifn);
+		__speculation_ctrl_update(tifn);
 }
 
 /*
