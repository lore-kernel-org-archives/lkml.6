Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184762-2-16692690084054021021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184761; b=gaQaX0N8BvPjBIo5vTr+GWGp8sZ+C1G0BbhEheI2QYYktcc
    gul9b7pIX1o7ZOZI4vO9V7Tv1IPtl+nw1d6oqrFh1D9+rddh2cGXwfOop0QEuPgM
    Sol3tl/DwlbiulCXyax7/gAEZIx6z9V/fuyFV8wPbRoFXYn1530vU0R0WB6yXrBd
    2yztMKTBqk77KVsFoSFGmdH8qBrFc8Ptf/m/YY8ubVnLi8dD+qn6U4/YhgVKtMAY
    GybgrMW9mO8TN5rcIQ2ig56MMvz1hEyTIisltdiCjwRJlCm1S9Ui/ibhBtyN5u/p
    7MF7sd5jhSBWdJ0lbs4jtiTQ7uDo3Ensp5od6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184761; bh=HIB5WtU7fQDQ7He1g7pBzPKqwe
    MYm0WVcauWGoSDRCQ=; b=rFFAetyXhk5DM3y15q94FJHXqZLuYUPbrGwQoX4j+I
    s7duoJ3T6e21V218q3TDRgTzFm7rcwWTU9d0HdDA0CXsMmMOEOXfK9oGbWfobJhB
    tsqqVuAU/fNBst/ir0TW4EjGzdmpNktq8gQqJ8GUA1Xo39M1Y/t0zTSGmj7rnHOB
    cF3LEitWRoHHl6yl55yODVU3NsW6m62leWkDLo2Ptwwptaurgdb6BSyVQfAMVS0l
    G0nLjxWhgjX0bVwxqQkvjkxx333XCulbN6qL+X6mBKsVhlaN3DWGjyrx/nqG5Y3w
    5Zoh+zYSXtwcWpYhdJrpURhTYvepE91HfF1BL5dCcPVQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeBINod (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINoa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 55/92] x86/asm: Move status from thread_struct to thread_info
Date: Fri,  9 Feb 2018 14:39:24 +0100
Message-Id: <20180209133935.216280884@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>


(cherry picked from commit 37a8f7c38339b22b69876d6f5a0ab851565284e3)

The TS_COMPAT bit is very hot and is accessed from code paths that mostly
also touch thread_info::flags.  Move it into struct thread_info to improve
cache locality.

The only reason it was in thread_struct is that there was a brief period
during which arch-specific fields were not allowed in struct thread_info.

Linus suggested further changing:

  ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);

to:

  if (unlikely(ti->status & (TS_COMPAT|TS_I386_REGS_POKED)))
          ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);

on the theory that frequently dirtying the cacheline even in pure 64-bit
code that never needs to modify status hurts performance.  That could be a
reasonable followup patch, but I suspect it matters less on top of this
patch.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/03148bcc1b217100e6e8ecf6a5468c45cf4304b6.1517164461.git.luto@kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/common.c            |    4 ++--
 arch/x86/include/asm/processor.h   |    2 --
 arch/x86/include/asm/syscall.h     |    6 +++---
 arch/x86/include/asm/thread_info.h |    3 ++-
 arch/x86/kernel/process_64.c       |    4 ++--
 arch/x86/kernel/ptrace.c           |    2 +-
 arch/x86/kernel/signal.c           |    2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -201,7 +201,7 @@ __visible inline void prepare_exit_to_us
 	 * special case only applies after poking regs and before the
 	 * very next return to user mode.
 	 */
-	current->thread.status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
+	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
 #endif
 
 	user_enter_irqoff();
@@ -299,7 +299,7 @@ static __always_inline void do_syscall_3
 	unsigned int nr = (unsigned int)regs->orig_ax;
 
 #ifdef CONFIG_IA32_EMULATION
-	current->thread.status |= TS_COMPAT;
+	ti->status |= TS_COMPAT;
 #endif
 
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -391,8 +391,6 @@ struct thread_struct {
 	unsigned short		gsindex;
 #endif
 
-	u32			status;		/* thread synchronous flags */
-
 #ifdef CONFIG_X86_64
 	unsigned long		fsbase;
 	unsigned long		gsbase;
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -60,7 +60,7 @@ static inline long syscall_get_error(str
 	 * TS_COMPAT is set for 32-bit syscall entries and then
 	 * remains set until we return to user mode.
 	 */
-	if (task->thread.status & (TS_COMPAT|TS_I386_REGS_POKED))
+	if (task->thread_info.status & (TS_COMPAT|TS_I386_REGS_POKED))
 		/*
 		 * Sign-extend the value so (int)-EFOO becomes (long)-EFOO
 		 * and will match correctly in comparisons.
@@ -116,7 +116,7 @@ static inline void syscall_get_arguments
 					 unsigned long *args)
 {
 # ifdef CONFIG_IA32_EMULATION
-	if (task->thread.status & TS_COMPAT)
+	if (task->thread_info.status & TS_COMPAT)
 		switch (i) {
 		case 0:
 			if (!n--) break;
@@ -177,7 +177,7 @@ static inline void syscall_set_arguments
 					 const unsigned long *args)
 {
 # ifdef CONFIG_IA32_EMULATION
-	if (task->thread.status & TS_COMPAT)
+	if (task->thread_info.status & TS_COMPAT)
 		switch (i) {
 		case 0:
 			if (!n--) break;
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -54,6 +54,7 @@ struct task_struct;
 
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	u32			status;		/* thread synchronous flags */
 };
 
 #define INIT_THREAD_INFO(tsk)			\
@@ -213,7 +214,7 @@ static inline int arch_within_stack_fram
 #define in_ia32_syscall() true
 #else
 #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
-			   current->thread.status & TS_COMPAT)
+			   current_thread_info()->status & TS_COMPAT)
 #endif
 
 /*
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -538,7 +538,7 @@ void set_personality_ia32(bool x32)
 		current->personality &= ~READ_IMPLIES_EXEC;
 		/* in_compat_syscall() uses the presence of the x32
 		   syscall bit flag to determine compat status */
-		current->thread.status &= ~TS_COMPAT;
+		current_thread_info()->status &= ~TS_COMPAT;
 	} else {
 		set_thread_flag(TIF_IA32);
 		clear_thread_flag(TIF_X32);
@@ -546,7 +546,7 @@ void set_personality_ia32(bool x32)
 			current->mm->context.ia32_compat = TIF_IA32;
 		current->personality |= force_personality32;
 		/* Prepare the first "return" to user space */
-		current->thread.status |= TS_COMPAT;
+		current_thread_info()->status |= TS_COMPAT;
 	}
 }
 EXPORT_SYMBOL_GPL(set_personality_ia32);
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -934,7 +934,7 @@ static int putreg32(struct task_struct *
 		 */
 		regs->orig_ax = value;
 		if (syscall_get_nr(child, regs) >= 0)
-			child->thread.status |= TS_I386_REGS_POKED;
+			child->thread_info.status |= TS_I386_REGS_POKED;
 		break;
 
 	case offsetof(struct user32, regs.eflags):
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -785,7 +785,7 @@ static inline unsigned long get_nr_resta
 	 * than the tracee.
 	 */
 #ifdef CONFIG_IA32_EMULATION
-	if (current->thread.status & (TS_COMPAT|TS_I386_REGS_POKED))
+	if (current_thread_info()->status & (TS_COMPAT|TS_I386_REGS_POKED))
 		return __NR_ia32_restart_syscall;
 #endif
 #ifdef CONFIG_X86_X32_ABI
