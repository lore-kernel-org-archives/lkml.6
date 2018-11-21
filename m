Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E030C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA0E21707
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA0E21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbeKVGyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389369AbeKVGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:12 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYx4-0000Ij-RO; Wed, 21 Nov 2018 21:18:23 +0100
Message-Id: <20181121201724.041653473@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:48 +0100
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
        Kees Cook <keescook@chromium.org>
Subject: [patch 18/24] x86/speculation: Avoid __switch_to_xtra() calls
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation--Avoid-switch_to_xtra---calls.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIF_SPEC_IB bit does not need to be evaluated in the decision to invoke
__switch_to_xtra() when:

 - CONFIG_SMP is disabled

 - The conditional STIPB mode is disabled

The TIF_SPEC_IB bit still controls IBPB in both cases.

Optimize it out by masking the bit at compile time for CONFIG_SMP=n and at
run time when the static key controlling the conditional STIBP mode is
disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/spec-ctrl.h   |    5 +++++
 arch/x86/include/asm/thread_info.h |   13 +++++++++++--
 arch/x86/kernel/process_32.c       |    9 +++++++++
 arch/x86/kernel/process_64.c       |    9 +++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -115,8 +115,13 @@ static inline void switch_to_ibpb(struct
 }
 
 #ifdef CONFIG_SMP
+static __always_inline bool switch_to_xtra_needs_spec_ib(void)
+{
+	return static_branch_likely(&switch_to_cond_stibp);
+}
 extern void speculative_store_bypass_ht_init(void);
 #else
+static inline bool switch_to_xtra_needs_spec_ib(void) { return false; }
 static inline void speculative_store_bypass_ht_init(void) { }
 #endif
 
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -147,9 +147,18 @@ struct thread_info {
 	 _TIF_FSCHECK)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW							\
+#define _TIF_WORK_CTXSW_BASE						\
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
-	 _TIF_SSBD|_TIF_SPEC_IB)
+	 _TIF_SSBD)
+
+/*
+ * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
+ */
+#ifdef CONFIG_SMP
+# define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE | _TIF_SPEC_IB)
+#else
+# define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE)
+#endif
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -272,6 +272,15 @@ EXPORT_SYMBOL_GPL(start_thread);
 	switch_to_ibpb(next_p, prev_tif, next_tif);
 
 	/*
+	 * Avoid __switch_to_xtra() invocation when conditional stpib is
+	 * disabled.
+	 */
+	if (!switch_to_xtra_needs_spec_ib()) {
+		prev_tif &= ~_TIF_SPEC_IB;
+		next_tif &= ~_TIF_SPEC_IB;
+	}
+
+	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
 	if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -625,6 +625,15 @@ void compat_start_thread(struct pt_regs
 	switch_to_ibpb(next_p, prev_tif, next_tif);
 
 	/*
+	 * Avoid __switch_to_xtra() invocation when conditional stpib is
+	 * disabled.
+	 */
+	if (!switch_to_xtra_needs_spec_ib()) {
+		prev_tif &= ~_TIF_SPEC_IB;
+		next_tif &= ~_TIF_SPEC_IB;
+	}
+
+	/*
 	 * Now maybe reload the debug registers and handle I/O bitmaps
 	 */
 	if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||


