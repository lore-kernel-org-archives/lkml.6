Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20984ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47A9208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47A9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJSAPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:15:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbeJSAPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:15:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9IGCs5L882770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Oct 2018 09:12:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9IGCsGY882767;
        Thu, 18 Oct 2018 09:12:54 -0700
Date:   Thu, 18 Oct 2018 09:12:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-c2712b858187f5bcd7b042fe4daa3ba3a12635c0@git.kernel.org>
Cc:     hpa@zytor.com, mhiramat@kernel.org, joel@joelfernandes.org,
        tglx@linutronix.de, bp@alien8.de, luto@amacapital.net,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        mingo@kernel.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: rostedt@goodmis.org, luto@amacapital.net, bp@alien8.de,
          tglx@linutronix.de, joel@joelfernandes.org, mhiramat@kernel.org,
          hpa@zytor.com, peterz@infradead.org, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <20181017165951.09119177@gandalf.local.home>
References: <20181017165951.09119177@gandalf.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes, x86/ptrace.h: Make
 regs_get_kernel_stack_nth() not fault on bad stack
Git-Commit-ID: c2712b858187f5bcd7b042fe4daa3ba3a12635c0
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

Commit-ID:  c2712b858187f5bcd7b042fe4daa3ba3a12635c0
Gitweb:     https://git.kernel.org/tip/c2712b858187f5bcd7b042fe4daa3ba3a12635c0
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Wed, 17 Oct 2018 16:59:51 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Oct 2018 08:28:35 +0200

kprobes, x86/ptrace.h: Make regs_get_kernel_stack_nth() not fault on bad stack

Andy had some concerns about using regs_get_kernel_stack_nth() in a new
function regs_get_kernel_argument() as if there's any error in the stack
code, it could cause a bad memory access. To be on the safe side, call
probe_kernel_read() on the stack address to be extra careful in accessing
the memory. A helper function, regs_get_kernel_stack_nth_addr(), was added
to just return the stack address (or NULL if not on the stack), that will be
used to find the address (and could be used by other functions) and read the
address with kernel_probe_read().

Requested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181017165951.09119177@gandalf.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/ptrace.h | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..ee696efec99f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -236,24 +236,52 @@ static inline int regs_within_kernel_stack(struct pt_regs *regs,
 		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
 }
 
+/**
+ * regs_get_kernel_stack_nth_addr() - get the address of the Nth entry on stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns the address of the @n th entry of the
+ * kernel stack which is specified by @regs. If the @n th entry is NOT in
+ * the kernel stack, this returns NULL.
+ */
+static inline unsigned long *regs_get_kernel_stack_nth_addr(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return addr;
+	else
+		return NULL;
+}
+
+/* To avoid include hell, we can't include uaccess.h */
+extern long probe_kernel_read(void *dst, const void *src, size_t size);
+
 /**
  * regs_get_kernel_stack_nth() - get Nth entry of the stack
  * @regs:	pt_regs which contains kernel stack pointer.
  * @n:		stack entry number.
  *
  * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
- * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack
  * this returns 0.
  */
 static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 						      unsigned int n)
 {
-	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
-	addr += n;
-	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
-	else
-		return 0;
+	unsigned long *addr;
+	unsigned long val;
+	long ret;
+
+	addr = regs_get_kernel_stack_nth_addr(regs, n);
+	if (addr) {
+		ret = probe_kernel_read(&val, addr, sizeof(val));
+		if (!ret)
+			return val;
+	}
+	return 0;
 }
 
 #define arch_has_single_step()	(1)
