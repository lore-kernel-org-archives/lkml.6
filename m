Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6670AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B2521527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B2521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbeKVGyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45202 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389265AbeKVGyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:01 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYwt-0000Fs-6n; Wed, 21 Nov 2018 21:18:11 +0100
Message-Id: <20181121201722.924191362@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:37 +0100
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
Subject: [patch 07/24] x86/speculation: Reorganize speculation control MSRs
 update
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Reorganize-speculation-control-MSRs-update.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

The logic to detect whether there's a change in the previous and next
task's flag relevant to update speculation control MSRs are spread out
across multiple functions.

Consolidate all checks needed for updating speculation control MSRs into
the new __speculation_ctrl_update() helper function.

This makes it easy to pick the right speculation control MSR and the bits
in the MSR that needs updating based on TIF flags changes.

Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/process.c |   42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -397,25 +397,48 @@ static __always_inline void amd_set_ssb_
 
 static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 {
-	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
+	u64 msr = x86_spec_ctrl_base;
+
+	/*
+	 * If X86_FEATURE_SSBD is not set, the SSBD bit is not to be
+	 * touched.
+	 */
+	if (static_cpu_has(X86_FEATURE_SSBD))
+		msr |= ssbd_tif_to_spec_ctrl(tifn);
 
 	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
-static __always_inline void __speculation_ctrl_update(unsigned long tifn)
+/*
+ * Update the MSRs managing speculation control, during context switch.
+ *
+ * tifp: Previous task's thread flags
+ * tifn: Next task's thread flags
+ */
+static __always_inline void __speculation_ctrl_update(unsigned long tifp,
+						      unsigned long tifn)
 {
-	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
-		amd_set_ssb_virt_state(tifn);
-	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
-		amd_set_core_ssb_state(tifn);
-	else
+	bool updmsr = false;
+
+	/* If TIF_SSBD is different, select the proper mitigation method */
+	if ((tifp ^ tifn) & _TIF_SSBD) {
+		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+			amd_set_ssb_virt_state(tifn);
+		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+			amd_set_core_ssb_state(tifn);
+		else if (static_cpu_has(X86_FEATURE_SSBD))
+			updmsr  = true;
+	}
+
+	if (updmsr)
 		spec_ctrl_update_msr(tifn);
 }
 
 void speculation_ctrl_update(unsigned long tif)
 {
+	/* Forced update. Make sure all relevant TIF flags are different */
 	preempt_disable();
-	__speculation_ctrl_update(tif);
+	__speculation_ctrl_update(~tif, tif);
 	preempt_enable();
 }
 
@@ -451,8 +474,7 @@ void __switch_to_xtra(struct task_struct
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
-	if ((tifp ^ tifn) & _TIF_SSBD)
-		__speculation_ctrl_update(tifn);
+	__speculation_ctrl_update(tifp, tifn);
 }
 
 /*


