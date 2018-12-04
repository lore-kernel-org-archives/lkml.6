Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9860C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC072087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIkpDqdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC072087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeLDLSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbeLDLEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A26214E0;
        Tue,  4 Dec 2018 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921477;
        bh=yfI85WmNX2+8gyKqBqOH7tYDANxTqbYGZWieQ7dVslY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIkpDqdtc+9wVH+uyVVOz7B4bj8Q/YJZ3E7ja+V7TYVoWGSP2NRfpM1d2jlA5aMog
         X4QsVqKI2/PGuHd7id93MXH8fsm3o7LTjqPj4//kwqSNQ6pTpfRAkVraFew0hjiVOf
         xrS23BbZK5DlqzTyrw6J9rcAVMxh3ypgGN89jbKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 086/146] x86/speculation: Reorganize speculation control MSRs update
Date:   Tue,  4 Dec 2018 11:49:32 +0100
Message-Id: <20181204103730.287801947@linuxfoundation.org>
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

From: Tim Chen tim.c.chen@linux.intel.com

commit 01daf56875ee0cd50ed496a09b20eb369b45dfa5 upstream

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/process.c |   42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -398,27 +398,40 @@ static __always_inline void amd_set_ssb_
 	wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
 }
 
-static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
+/*
+ * Update the MSRs managing speculation control, during context switch.
+ *
+ * tifp: Previous task's thread flags
+ * tifn: Next task's thread flags
+ */
+static __always_inline void __speculation_ctrl_update(unsigned long tifp,
+						      unsigned long tifn)
 {
-	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
+	u64 msr = x86_spec_ctrl_base;
+	bool updmsr = false;
 
-	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
-}
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
 
@@ -454,8 +467,7 @@ void __switch_to_xtra(struct task_struct
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
-	if ((tifp ^ tifn) & _TIF_SSBD)
-		__speculation_ctrl_update(tifn);
+	__speculation_ctrl_update(tifp, tifn);
 }
 
 /*


