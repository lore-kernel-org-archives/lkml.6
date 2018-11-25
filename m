Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB53D2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB53D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeKZFtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeKZFtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:12 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzax-0003SQ-Uk; Sun, 25 Nov 2018 19:57:28 +0100
Message-Id: <20181125185005.374062201@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:48 +0100
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
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: [patch V2 20/28] x86/speculation: Avoid __switch_to_xtra() calls
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Avoid-switch-to-xtra-calls.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIF_SPEC_IB bit does not need to be evaluated in the decision to invoke
__switch_to_xtra() when:

 - CONFIG_SMP is disabled

 - The conditional STIPB mode is disabled

The TIF_SPEC_IB bit still controls IBPB in both cases so the TIF work mask
checks might invoke __switch_to_xtra() for nothing if TIF_SPEC_IB is the
only set bit in the work masks.

Optimize it out by masking the bit at compile time for CONFIG_SMP=n and at
run time when the static key controlling the conditional STIBP mode is
disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/thread_info.h |   13 +++++++++++--
 arch/x86/kernel/process.h          |   15 +++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

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
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -2,6 +2,8 @@
 //
 // Code shared between 32 and 64 bit
 
+#include <asm/spec-ctrl.h>
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
 
 /*
@@ -14,6 +16,19 @@ static inline void switch_to_extra(struc
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long prev_tif = task_thread_info(prev)->flags;
 
+	if (IS_ENABLED(CONFIG_SMP)) {
+		/*
+		 * Avoid __switch_to_xtra() invocation when conditional
+		 * STIPB is disabled and the only different bit is
+		 * TIF_SPEC_IB. For CONFIG_SMP=n TIF_SPEC_IB is not
+		 * in the TIF_WORK_CTXSW masks.
+		 */
+		if (!static_branch_likely(&switch_to_cond_stibp)) {
+			prev_tif &= ~_TIF_SPEC_IB;
+			next_tif &= ~_TIF_SPEC_IB;
+		}
+	}
+
 	/*
 	 * __switch_to_xtra() handles debug registers, i/o bitmaps,
 	 * speculation mitigations etc.


