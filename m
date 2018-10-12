Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C7C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7470C21480
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7470C21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJMD2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeJMD2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:28:48 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC7521477;
        Fri, 12 Oct 2018 19:54:41 +0000 (UTC)
Date:   Fri, 12 Oct 2018 15:54:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH] x86: ptrace: Add function argument access API
Message-ID: <20181012155439.59f77556@gandalf.local.home>
In-Reply-To: <CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com>
References: <20181011230021.0a7604fa@vmware.local.home>
        <20181012122641.3d87ed29@gandalf.local.home>
        <CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 11:21:28 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> On Fri, Oct 12, 2018 at 9:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > Anyone have any issues with this patch?
> >  
> 
> I'm conceptually okay with it.  That being said,
> regs_within_kernel_stack(), which you're indirectly using, is
> off-by-a-few.  And updating it to use probe_kernel_read() might be
> nice for robustness.
> 

Something like this?

-- Steve

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Fri, 12 Oct 2018 15:44:20 -0400
Subject: [PATCH] x86: ptrace.h: Add regs_get_kernel_stack_nth_safe() function

Andy had some concerns about using regs_get_kernel_stack_nth() in a new
function regs_get_kernel_argument() as if there's any error in the stack
code, it could cause a bad memory access. Instead, add a new function called
regs_get_kernel_stack_nth_safe() that does a probe_kernel_read() on the
stack address to be extra careful in accessing the memory. To share the
code, regs_get_kernel_stack_nth_addr() was added to just return the stack
address (or NULL if not on the stack), that both regs_get_kernel_stack_nth()
and the _safe() version can use.

Link: http://lkml.kernel.org/r/CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com
Requested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/ptrace.h | 57 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index c2304b25e2fd..8df7ab6a17c5 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -237,6 +237,27 @@ static inline int regs_within_kernel_stack(struct pt_regs *regs,
 }
 
 /**
+ * regs_get_kernel_stack_nth_addr() - get the address of the Nth entry on stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns the address of the @n th entry of the
+ * kernel stack which is specified by @regs. If the @n th entry is NOT in
+ * the kernel stack, this returns NULL.
+ */
+static inline unsigned long *regs_get_kernel_stack_nth_addr(struct pt_regs *regs,
+							    unsigned int n)
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
+/**
  * regs_get_kernel_stack_nth() - get Nth entry of the stack
  * @regs:	pt_regs which contains kernel stack pointer.
  * @n:		stack entry number.
@@ -248,14 +269,44 @@ static inline int regs_within_kernel_stack(struct pt_regs *regs,
 static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 						      unsigned int n)
 {
-	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
-	addr += n;
-	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+	unsigned long *addr;
+
+	addr = regs_get_kernel_stack_nth_addr(regs, n);
+	if (addr)
 		return *addr;
 	else
 		return 0;
 }
 
+/* To avoid include hell, we can't include uaccess.h */
+extern long probe_kernel_read(void *dst, const void *src, size_t size);
+
+/**
+ * regs_get_kernel_stack_nth_safe() - safely get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * Same as regs_get_kernel_stack_nth(), but references the stack value
+ * with a probe_kernel_read() in case there's a bad stack pointer, it
+ * will not cause a bad memory access. If the @n is not on the stack,
+ * or a bad memory access happened, it returns zero.
+ */
+static inline unsigned long regs_get_kernel_stack_nth_safe(struct pt_regs *regs,
+							   unsigned int n)
+{
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
+}
+
 /**
  * regs_get_kernel_argument() - get Nth function argument in kernel
  * @regs:	pt_regs of that context
-- 
2.13.6

