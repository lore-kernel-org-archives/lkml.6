Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4B4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F94220846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vAWkw4ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F94220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeFUOol (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:44:41 -0400
Received: from mail.efficios.com ([167.114.142.138]:60084 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeFUOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:44:40 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3283E1BF403;
        Thu, 21 Jun 2018 10:44:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id vDrJwqkCIm3G; Thu, 21 Jun 2018 10:44:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1BAE81BF3F9;
        Thu, 21 Jun 2018 10:44:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1BAE81BF3F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529592278;
        bh=vQg6dTCK/9DmBg6vZqDuTBdjANAwW9kTHw04DdH8Rss=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vAWkw4hoSFp3tKCYVlDeHvk5KpAuALBWOsJINh30XMVdWWt+6WjgjMfTUGavJ2RsD
         L2Up1uZaN4PS7o/QIBcbv/t/Hcq1YBR+76TkdajZ+/ZTt+bgYHjGaToRgKuk8MR8sD
         SSjlvDl5rLXg2WUmY4R8RBbyEB5ZDgLJCq+KaFc84kkssU9kjyNiXKb+hf2zEbxLua
         QGWGJfkjs+x0xmJPL2wjXf+SK58NOjEfOS31LN8TDZgBri5Yr2nYdciZSZRsLnK0t0
         K77kYCNP7AxyasuhF+l/0C9cnaTzNqibz2Nf5KbhnCsoRU19bdYfu0RfgmOHET9M60
         AsMiYQcsTMtaQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id tMLwBLbJX5fa; Thu, 21 Jun 2018 10:44:38 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 065B61BF3EF;
        Thu, 21 Jun 2018 10:44:38 -0400 (EDT)
Date:   Thu, 21 Jun 2018 10:44:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
Message-ID: <92378910.863.1529592277773.JavaMail.zimbra@efficios.com>
In-Reply-To: <1529582080-31430-1-git-send-email-will.deacon@arm.com>
References: <1529582080-31430-1-git-send-email-will.deacon@arm.com>
Subject: Re: [PATCH v2] rseq: Avoid infinite recursion when delivering
 SIGSEGV
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: Avoid infinite recursion when delivering SIGSEGV
Thread-Index: oBA9WS678fzFpjFDNIc6zXsfsyZskw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 21, 2018, at 7:54 AM, Will Deacon will.deacon@arm.com wrote:

> When delivering a signal to a task that is using rseq, we call into
> __rseq_handle_notify_resume() so that the registers pushed in the
> sigframe are updated to reflect the state of the restartable sequence
> (for example, ensuring that the signal returns to the abort handler if
> necessary).
> 
> However, if the rseq management fails due to an unrecoverable fault when
> accessing userspace or certain combinations of RSEQ_CS_* flags, then we
> will attempt to deliver a SIGSEGV. This has the potential for infinite
> recursion if the rseq code continuously fails on signal delivery.
> 
> Avoid this problem by using force_sigsegv() instead of force_sig(), which
> is explicitly designed to reset the SEGV handler to SIG_DFL in the case
> of a recursive fault. In doing so, remove rseq_signal_deliver() from the
> internal rseq API and have an optional struct ksignal * parameter to
> rseq_handle_notify_resume() instead.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> RFC v1 -> v2: Kill rseq_signal_deliver()

I actually meant to kill _rseq_handle_notify_resume introduced by
your patch, not rseq_signal_deliver().

Please keep rseq_signal_deliver() as a static inline, and just remove
the _rseq_handle_notify_resume() by changing the signature of
rseq_handle_notify_resume to take an extra sig argument (which can
be NULL).

Thanks,

Mathieu

> 
> arch/arm/kernel/signal.c     |  4 ++--
> arch/powerpc/kernel/signal.c |  4 ++--
> arch/x86/entry/common.c      |  2 +-
> arch/x86/kernel/signal.c     |  2 +-
> include/linux/sched.h        | 27 ++++++++++++---------------
> kernel/rseq.c                |  7 ++++---
> 6 files changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index f09e9d66d605..184f69dcb9f2 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -544,7 +544,7 @@ static void handle_signal(struct ksignal *ksig, struct
> pt_regs *regs)
> 	 * Increment event counter and perform fixup for the pre-signal
> 	 * frame.
> 	 */
> -	rseq_signal_deliver(regs);
> +	rseq_handle_notify_resume(ksig, regs);
> 
> 	/*
> 	 * Set up the stack frame
> @@ -666,7 +666,7 @@ do_work_pending(struct pt_regs *regs, unsigned int
> thread_flags, int syscall)
> 			} else {
> 				clear_thread_flag(TIF_NOTIFY_RESUME);
> 				tracehook_notify_resume(regs);
> -				rseq_handle_notify_resume(regs);
> +				rseq_handle_notify_resume(NULL, regs);
> 			}
> 		}
> 		local_irq_disable();
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 17fe4339ba59..88bdf243a5bd 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -134,7 +134,7 @@ static void do_signal(struct task_struct *tsk)
> 	/* Re-enable the breakpoints for the signal stack */
> 	thread_change_pc(tsk, tsk->thread.regs);
> 
> -	rseq_signal_deliver(tsk->thread.regs);
> +	rseq_handle_notify_resume(&ksig, tsk->thread.regs);
> 
> 	if (is32) {
>         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> @@ -170,7 +170,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long
> thread_info_flags)
> 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> 		clear_thread_flag(TIF_NOTIFY_RESUME);
> 		tracehook_notify_resume(regs);
> -		rseq_handle_notify_resume(regs);
> +		rseq_handle_notify_resume(NULL, regs);
> 	}
> 
> 	user_enter();
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 92190879b228..3b2490b81918 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -164,7 +164,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32
> cached_flags)
> 		if (cached_flags & _TIF_NOTIFY_RESUME) {
> 			clear_thread_flag(TIF_NOTIFY_RESUME);
> 			tracehook_notify_resume(regs);
> -			rseq_handle_notify_resume(regs);
> +			rseq_handle_notify_resume(NULL, regs);
> 		}
> 
> 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 445ca11ff863..8affeeb74935 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -692,7 +692,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> 	 * Increment event counter and perform fixup for the pre-signal
> 	 * frame.
> 	 */
> -	rseq_signal_deliver(regs);
> +	rseq_handle_notify_resume(ksig, regs);
> 
> 	/* Set up the stack frame */
> 	if (is_ia32_frame(ksig)) {
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 87bf02d93a27..fd23a540cd8d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1799,20 +1799,19 @@ static inline void rseq_set_notify_resume(struct
> task_struct *t)
> 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> }
> 
> -void __rseq_handle_notify_resume(struct pt_regs *regs);
> +void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
> 
> -static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> +static inline void rseq_handle_notify_resume(struct ksignal *ksig,
> +					     struct pt_regs *regs)
> {
> -	if (current->rseq)
> -		__rseq_handle_notify_resume(regs);
> -}
> +	if (ksig) {
> +		preempt_disable();
> +		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> +		preempt_enable();
> +	}
> 
> -static inline void rseq_signal_deliver(struct pt_regs *regs)
> -{
> -	preempt_disable();
> -	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> -	preempt_enable();
> -	rseq_handle_notify_resume(regs);
> +	if (current->rseq)
> +		__rseq_handle_notify_resume(ksig, regs);
> }
> 
> /* rseq_preempt() requires preemption to be disabled. */
> @@ -1864,10 +1863,8 @@ static inline void rseq_execve(struct task_struct *t)
> static inline void rseq_set_notify_resume(struct task_struct *t)
> {
> }
> -static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> -{
> -}
> -static inline void rseq_signal_deliver(struct pt_regs *regs)
> +static inline void rseq_handle_notify_resume(struct ksignal *ksig,
> +					     struct pt_regs *regs)
> {
> }
> static inline void rseq_preempt(struct task_struct *t)
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index ae306f90c514..22b6acf1ad63 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -251,10 +251,10 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>  * respect to other threads scheduled on the same CPU, and with respect
>  * to signal handlers.
>  */
> -void __rseq_handle_notify_resume(struct pt_regs *regs)
> +void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> {
> 	struct task_struct *t = current;
> -	int ret;
> +	int ret, sig;
> 
> 	if (unlikely(t->flags & PF_EXITING))
> 		return;
> @@ -268,7 +268,8 @@ void __rseq_handle_notify_resume(struct pt_regs *regs)
> 	return;
> 
> error:
> -	force_sig(SIGSEGV, t);
> +	sig = ksig ? ksig->sig : 0;
> +	force_sigsegv(sig, t);
> }
> 
> #ifdef CONFIG_DEBUG_RSEQ
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
