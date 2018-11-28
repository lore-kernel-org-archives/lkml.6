Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C872C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFB62081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFB62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeK2Bdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:33:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37513 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbeK2Bdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:33:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEVME82323659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:31:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEVM2f2323656;
        Wed, 28 Nov 2018 06:31:22 -0800
Date:   Wed, 28 Nov 2018 06:31:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-5635d99953f04b550738f6f4c1c532667c3fd872@git.kernel.org>
Cc:     aarcange@redhat.com, longman9394@gmail.com, mingo@kernel.org,
        torvalds@linux-foundation.org, dave.hansen@intel.com,
        peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
        luto@kernel.org, thomas.lendacky@amd.com, jcm@redhat.com,
        jpoimboe@redhat.com, hpa@zytor.com, arjan@linux.intel.com,
        asit.k.mallick@intel.com, casey.schaufler@intel.com,
        keescook@chromium.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dwmw@amazon.co.uk, tim.c.chen@linux.intel.com,
        david.c.stewart@intel.com
Reply-To: keescook@chromium.org, jkosina@suse.cz,
          linux-kernel@vger.kernel.org, asit.k.mallick@intel.com,
          casey.schaufler@intel.com, david.c.stewart@intel.com,
          gregkh@linuxfoundation.org, dwmw@amazon.co.uk,
          tim.c.chen@linux.intel.com, longman9394@gmail.com,
          mingo@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, dave.hansen@intel.com, aarcange@redhat.com,
          hpa@zytor.com, arjan@linux.intel.com, ak@linux.intel.com,
          tglx@linutronix.de, luto@kernel.org, thomas.lendacky@amd.com,
          jcm@redhat.com, jpoimboe@redhat.com
In-Reply-To: <20181125185005.374062201@linutronix.de>
References: <20181125185005.374062201@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Avoid __switch_to_xtra() calls
Git-Commit-ID: 5635d99953f04b550738f6f4c1c532667c3fd872
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

Commit-ID:  5635d99953f04b550738f6f4c1c532667c3fd872
Gitweb:     https://git.kernel.org/tip/5635d99953f04b550738f6f4c1c532667c3fd872
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:48 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:11 +0100

x86/speculation: Avoid __switch_to_xtra() calls

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
Link: https://lkml.kernel.org/r/20181125185005.374062201@linutronix.de


---
 arch/x86/include/asm/thread_info.h | 13 +++++++++++--
 arch/x86/kernel/process.h          | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index fa583ec99e3e..6d201699c651 100644
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
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 020fbfac3a27..898e97cf6629 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -2,6 +2,8 @@
 //
 // Code shared between 32 and 64 bit
 
+#include <asm/spec-ctrl.h>
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
 
 /*
@@ -14,6 +16,19 @@ static inline void switch_to_extra(struct task_struct *prev,
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
