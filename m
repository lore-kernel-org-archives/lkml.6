Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4898AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03812083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Ghzqx51a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03812083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeFTQzi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:55:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:56574 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:55:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 048931A9E4C;
        Wed, 20 Jun 2018 12:55:36 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id maOdmjSxWo79; Wed, 20 Jun 2018 12:55:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 70B311A9E48;
        Wed, 20 Jun 2018 12:55:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 70B311A9E48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529513735;
        bh=I3PfK82MkcHE7EnhiraLAqll0qf0wm1EWUWzeqyOhOw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Ghzqx51aKdyuz7uNanRX0NqfDowKg/OvRV3YxBhbRs2ms3+rESlRC4MmIZQz1rDSJ
         hQeK5WP5r58exIup1jh+KvhUyINkyisAQSPuiik4vzy1n4JjZ+0e5Ldotaqlu6l2wF
         z9PJw15bkrQimROMNfxLxFF4EBXcDCwCDZSdpyXoY1OPR8DHG1CdALibQMLbA6vCaP
         2KfeYU1wAEKVUYu+YsDADfuVM/YBPptiA5ATH2m2oRVeAomMYVY1iwUOaxTfETtVxD
         OPioqT+XxbKP+Jy9HExslFftINBNNWseKIXsp0luhUU2TcY043cmgFDmZ1WFkGnPFs
         JdZNagnaiHhLg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id A9P4RLgdcn9q; Wed, 20 Jun 2018 12:55:35 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5C2A51A9E42;
        Wed, 20 Jun 2018 12:55:35 -0400 (EDT)
Date:   Wed, 20 Jun 2018 12:55:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Message-ID: <10453618.15.1529513735208.JavaMail.zimbra@efficios.com>
In-Reply-To: <1529512560-28007-1-git-send-email-will.deacon@arm.com>
References: <1529512560-28007-1-git-send-email-will.deacon@arm.com>
Subject: Re: [RFC PATCH] rseq: Avoid infinite recursion when delivering
 SIGSEGV
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: Avoid infinite recursion when delivering SIGSEGV
Thread-Index: k99nSYS/cn2LuEXA1At4wWDWA3b9fw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 20, 2018, at 12:36 PM, Will Deacon will.deacon@arm.com wrote:

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
> of a recursive fault.

Your approach looks good. One nit below implementation-wise:

> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Sending as an RFC since I only spotted this via code inspection and haven't
> tried to trigger it yet.
> 
> arch/arm/kernel/signal.c     |  2 +-
> arch/powerpc/kernel/signal.c |  2 +-
> arch/x86/kernel/signal.c     |  2 +-
> include/linux/sched.h        | 20 ++++++++++++++------
> kernel/rseq.c                |  7 ++++---
> 5 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index f09e9d66d605..6434a62591e8 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -544,7 +544,7 @@ static void handle_signal(struct ksignal *ksig, struct
> pt_regs *regs)
> 	 * Increment event counter and perform fixup for the pre-signal
> 	 * frame.
> 	 */
> -	rseq_signal_deliver(regs);
> +	rseq_signal_deliver(ksig, regs);
> 
> 	/*
> 	 * Set up the stack frame
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 17fe4339ba59..af822e764569 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -134,7 +134,7 @@ static void do_signal(struct task_struct *tsk)
> 	/* Re-enable the breakpoints for the signal stack */
> 	thread_change_pc(tsk, tsk->thread.regs);
> 
> -	rseq_signal_deliver(tsk->thread.regs);
> +	rseq_signal_deliver(&ksig, tsk->thread.regs);
> 
> 	if (is32) {
>         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 445ca11ff863..92a3b312a53c 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -692,7 +692,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> 	 * Increment event counter and perform fixup for the pre-signal
> 	 * frame.
> 	 */
> -	rseq_signal_deliver(regs);
> +	rseq_signal_deliver(ksig, regs);
> 
> 	/* Set up the stack frame */
> 	if (is_ia32_frame(ksig)) {
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 87bf02d93a27..277f8ccb0661 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1799,20 +1799,27 @@ static inline void rseq_set_notify_resume(struct
> task_struct *t)
> 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> }
> 
> -void __rseq_handle_notify_resume(struct pt_regs *regs);
> +void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
> 
> -static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> +static inline void _rseq_handle_notify_resume(struct ksignal *ksig,
> +					      struct pt_regs *regs)
> {
> 	if (current->rseq)
> -		__rseq_handle_notify_resume(regs);
> +		__rseq_handle_notify_resume(ksig, regs);
> +}
> +
> +static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> +{
> +	_rseq_handle_notify_resume(NULL, regs);
> }


If we add _rseq_handle_notify_resume() here, we'd need the CONFIG_RSEQ=n
code to also have an empty static inline for it.

So I'm not sure we want all 3 of:

void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);

static inline void _rseq_handle_notify_resume(struct ksignal *ksig,
				      struct pt_regs *regs)

static inline void rseq_handle_notify_resume(struct pt_regs *regs)

Instead, can we just have:

__rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);

static inline void rseq_handle_notify_resume(struct ksignal *ksig,
				      struct pt_regs *regs)

and change the callers to rseq_handle_notify_resume to pass a NULL
pointer when they are not within signal delivery ?

Thanks,

Mathieu

> 
> -static inline void rseq_signal_deliver(struct pt_regs *regs)
> +static inline void rseq_signal_deliver(struct ksignal *ksig,
> +				       struct pt_regs *regs)
> {
> 	preempt_disable();
> 	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> 	preempt_enable();
> -	rseq_handle_notify_resume(regs);
> +	_rseq_handle_notify_resume(ksig, regs);
> }
> 
> /* rseq_preempt() requires preemption to be disabled. */
> @@ -1867,7 +1874,8 @@ static inline void rseq_set_notify_resume(struct
> task_struct *t)
> static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> {
> }
> -static inline void rseq_signal_deliver(struct pt_regs *regs)
> +static inline void rseq_signal_deliver(struct ksignal *ksig,
> +				       struct pt_regs *regs)
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
