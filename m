Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60926ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03FE208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03FE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeGPTqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:46:30 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45462 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeGPTqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:46:30 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff907-000411-Gj; Mon, 16 Jul 2018 13:17:39 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff906-00014o-NP; Mon, 16 Jul 2018 13:17:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-9-ebiederm@xmission.com>
        <20180716145540.GA20960@redhat.com> <87lgabrzfd.fsf@xmission.com>
        <CA+55aFxNMPgg3Y7m8hCjtaFVERPL6LaXPKcbBmz-6C=8_FMpKg@mail.gmail.com>
Date:   Mon, 16 Jul 2018 14:17:33 -0500
In-Reply-To: <CA+55aFxNMPgg3Y7m8hCjtaFVERPL6LaXPKcbBmz-6C=8_FMpKg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 16 Jul 2018 09:50:28 -0700")
Message-ID: <87pnznkn1u.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ff906-00014o-NP;;;mid=<87pnznkn1u.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+dIDm586apRjBh1y5xVeaE9bt8XQ1Excg=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK to forcibly kill tasks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jul 16, 2018 at 8:08 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The change for global init is it will now die if init is a member of the
>> session or init is using this tty as it's controlling tty.
>>
>> Semantically killing init with SAK is completely appropriate.
>
> No.
>
> Semtnaitcally killing init is completely wrong. Because it will kill
> the whole system.
>
> And I don't mean that in "now init won't spawn new things". I mean
> that in "now we don't have a child reaper any more, and the system
> will be dead because we'll panic on exit".
>
> So it's not about the controlling tty, it's about fundamental kernel
> internal consistency guarantees.
>
> See
>
>         write_unlock_irq(&tasklist_lock);
>         if (unlikely(pid_ns == &init_pid_ns)) {
>                 panic("Attempted to kill init! exitcode=0x%08x\n",
>                         father->signal->group_exit_code ?: father->exit_code);
>         }
>
> in kernel/exit.c.

I should have said it doesn't matter because init does not open ttys and
become a member of session groups.  Or at least it never has in my
experience.  The only way I know to get that behavior is to boot with
init=/bin/bash.

With the force_sig already in do_SAK today my change is not a
regression.  As force_sig in a completely different way forces the
signal to init.


Looking deeper, all of the silliness with SEND_SIG_FORCED and
force_sig_info is to guarantee delivery of synchronous exceptions even
to init.

So I think we want the patch below to clean that up.  Then we don't have
to worry about the wrong things sending signals to init by accident, and
SEND_SIG_FORCED becomes just SEND_SIG_PRIV that skips the unnecesary
allocation of a siginfo struct.

Thoughts?

Eric


From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 16 Jul 2018 13:29:04 -0500
Subject: [PATCH] signal: Cleanup delivery of exceptions to init

- Stop clearing SIGNAL_UNKILLABLE. It makes interaction by
  the process with other signals problematic, and exceptions
  are not necessarily fatal.

- Don't allow SIGKILL and SIGSTOP to the global init.
  It never helps and it it can only make things worse.

- Explicitly allow exceptions to any kind of init.  They are
  exceptions and synchronous and need to be handled somehow.
  Init can setup a handler or deal with the default action.

  This is not a change it is just code movement from
  force_sig_info into send_signal and get_signal.

- Treat all signals from the kernel as if they are from an ancestor
  pid namespace.

- Take out the overrides of SIGNAL_UNKILLABLE from force_sig_info
  The changes to send_signal and get_signal make them unnecessary.

- Take out the SEND_SIG_FORCED overrides from prepare_signal.
  The changes to send_signal makes it redundant.

- Rename force back to from_ancestor_ns as that makes the logic
  with respect to namespaces clearer and logically if the kernel
  is sending you a signal it is from your ancestor namespace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 94296afacf44..298f5c690681 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -72,20 +72,21 @@ static int sig_handler_ignored(void __user *handler, int sig)
 		(handler == SIG_DFL && sig_kernel_ignore(sig));
 }
 
-static int sig_task_ignored(struct task_struct *t, int sig, bool force)
+static int sig_task_ignored(struct task_struct *t, int sig, bool from_ancestor_ns)
 {
 	void __user *handler;
 
 	handler = sig_handler(t, sig);
 
 	if (unlikely(t->signal->flags & SIGNAL_UNKILLABLE) &&
-	    handler == SIG_DFL && !(force && sig_kernel_only(sig)))
+	    handler == SIG_DFL &&
+	    (is_global_init(t) || !(from_ancestor_ns && sig_kernel_only(sig))))
 		return 1;
 
 	return sig_handler_ignored(handler, sig);
 }
 
-static int sig_ignored(struct task_struct *t, int sig, bool force)
+static int sig_ignored(struct task_struct *t, int sig, bool from_ancestor_ns)
 {
 	/*
 	 * Blocked signals are never ignored, since the
@@ -103,7 +104,7 @@ static int sig_ignored(struct task_struct *t, int sig, bool force)
 	if (t->ptrace && sig != SIGKILL)
 		return 0;
 
-	return sig_task_ignored(t, sig, force);
+	return sig_task_ignored(t, sig, from_ancestor_ns);
 }
 
 /*
@@ -809,7 +810,7 @@ static void ptrace_trap_notify(struct task_struct *t)
  * Returns true if the signal should be actually delivered, otherwise
  * it should be dropped.
  */
-static bool prepare_signal(int sig, struct task_struct *p, bool force)
+static bool prepare_signal(int sig, struct task_struct *p, bool from_ancestor_ns)
 {
 	struct signal_struct *signal = p->signal;
 	struct task_struct *t;
@@ -871,7 +872,7 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		}
 	}
 
-	return !sig_ignored(p, sig, force);
+	return !sig_ignored(p, sig, from_ancestor_ns);
 }
 
 /*
@@ -1008,8 +1009,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	assert_spin_locked(&t->sighand->siglock);
 
 	result = TRACE_SIGNAL_IGNORED;
-	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_FORCED)))
+	if (!prepare_signal(sig, t, from_ancestor_ns))
 		goto ret;
 
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
@@ -1107,12 +1107,8 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
 			enum pid_type type)
 {
-	int from_ancestor_ns = 0;
-
-#ifdef CONFIG_PID_NS
-	from_ancestor_ns = si_fromuser(info) &&
+	int from_ancestor_ns = !si_fromuser(info) ||
 			   !task_pid_nr_ns(current, task_active_pid_ns(t));
-#endif
 
 	return __send_signal(sig, info, t, type, from_ancestor_ns);
 }
@@ -1178,8 +1174,8 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
  * since we do not want to have a signal handler that was blocked
  * be invoked when user space had explicitly blocked it.
  *
- * We don't want to have recursive SIGSEGV's etc, for example,
- * that is why we also clear SIGNAL_UNKILLABLE.
+ * Exceptions are always delivered so we don't need to worry
+ * about init or other processes blocking exception signals.
  */
 int
 force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
@@ -1199,12 +1195,6 @@ force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
 			recalc_sigpending_and_wake(t);
 		}
 	}
-	/*
-	 * Don't clear SIGNAL_UNKILLABLE for traced tasks, users won't expect
-	 * debugging to leave init killable.
-	 */
-	if (action->sa.sa_handler == SIG_DFL && !t->ptrace)
-		t->signal->flags &= ~SIGNAL_UNKILLABLE;
 	ret = send_signal(sig, info, t, PIDTYPE_PID);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 
@@ -2536,9 +2526,10 @@ int get_signal(struct ksignal *ksig)
 			continue;
 
 		/*
-		 * Global init gets no signals it doesn't want.
-		 * Container-init gets no signals it doesn't want from same
-		 * container.
+		 * Except for synchronous exceptions (!SI_FROMUSER)
+		 * global init gets no signals it doesn't want, and
+		 * container-init gets no signals it doesn't want from
+		 * same container.
 		 *
 		 * Note that if global/container-init sees a sig_kernel_only()
 		 * signal here, the signal must have been generated internally
@@ -2546,7 +2537,7 @@ int get_signal(struct ksignal *ksig)
 		 * case, the signal cannot be dropped.
 		 */
 		if (unlikely(signal->flags & SIGNAL_UNKILLABLE) &&
-				!sig_kernel_only(signr))
+		    !sig_kernel_only(signr) && SI_FROMUSER(&ksig->info))
 			continue;
 
 		if (sig_kernel_stop(signr)) {
-- 
2.17.1

