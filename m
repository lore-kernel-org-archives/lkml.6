Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF77214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF77214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbeKVGyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45193 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbeKVGyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:00 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYws-0000Fm-75; Wed, 21 Nov 2018 21:18:10 +0100
Message-Id: <20181121201722.813274992@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:36 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [patch 06/24] x86/speculation: Rename SSBD update functions
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Rename-SSBD-update-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

During context switch, the SSBD bit in SPEC_CTRL MSR is updated according
to changes of the TIF_SSBD flag in the current and next running task.

Currently, only the bit controlling speculative store bypass disable in
SPEC_CTRL MSR is updated and the related update functions all have
"speculative_store" or "ssb" in their names.

For enhanced mitigation control other bits in SPEC_CTRL MSR need to be
updated as well, which makes the SSB names inadequate.

Rename the "speculative_store*" functions to a more generic name.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/spec-ctrl.h |    6 +++---
 arch/x86/kernel/cpu/bugs.c       |    4 ++--
 arch/x86/kernel/process.c        |   12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -70,11 +70,11 @@ extern void speculative_store_bypass_ht_
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
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -200,7 +200,7 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
 		tif = setguest ? ssbd_spec_ctrl_to_tif(guestval) :
 				 ssbd_spec_ctrl_to_tif(hostval);
 
-		speculative_store_bypass_update(tif);
+		speculation_ctrl_update(tif);
 	}
 }
 EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
@@ -632,7 +632,7 @@ static int ssb_prctl_set(struct task_str
 	 * mitigation until it is next scheduled.
 	 */
 	if (task == current && update)
-		speculative_store_bypass_update_current();
+		speculation_ctrl_update_current();
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -395,27 +395,27 @@ static __always_inline void amd_set_ssb_
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
 
@@ -452,7 +452,7 @@ void __switch_to_xtra(struct task_struct
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
 	if ((tifp ^ tifn) & _TIF_SSBD)
-		__speculative_store_bypass_update(tifn);
+		__speculation_ctrl_update(tifn);
 }
 
 /*


