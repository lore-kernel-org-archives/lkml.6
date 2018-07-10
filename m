Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52620C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A82208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A82208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934357AbeGJQBX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:01:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45776 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934062AbeGJQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:01:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fcv4q-0006vJ-GE; Tue, 10 Jul 2018 10:01:20 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fcv4a-0002V4-Sc; Tue, 10 Jul 2018 10:01:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <bug-200447-5873-b2kAsSyE1X@https.bugzilla.kernel.org/>
        <CA+55aFyOaEGc_wjRuAxYZH7D4zi4xUQTqUwMmUzxFJQ__2pXuQ@mail.gmail.com>
        <87h8l9p7bg.fsf@xmission.com> <20180709104158.GA23796@redhat.com>
        <87sh4so5jv.fsf@xmission.com> <20180709145726.GA26149@redhat.com>
        <877em4nxo0.fsf@xmission.com>
        <CA+55aFwq90_KeRUesktap7L_4Hp3gatKZ28RYw1jXBYeOqUoeA@mail.gmail.com>
        <87lgakm4ol.fsf@xmission.com>
        <CA+55aFz1XFvOgJySKVNQD9VS4hys0J7rozxqd3s5ND0z80tfVw@mail.gmail.com>
        <20180710134639.GA2453@redhat.com>
Date:   Tue, 10 Jul 2018 11:00:55 -0500
In-Reply-To: <20180710134639.GA2453@redhat.com> (Oleg Nesterov's message of
        "Tue, 10 Jul 2018 15:46:39 +0200")
Message-ID: <878t6jkrm0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fcv4a-0002V4-Sc;;;mid=<878t6jkrm0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/yGH40tB9MY4+yXTQf4/t2kLsLrrbyYsU=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [Bug 200447] infinite loop in fork syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/09, Linus Torvalds wrote:
>>
>> But the patch was written for testing and feedback more than anything
>> else. Comments?
>
> see my reply on bugzilla. Can't we add lkml?
Done.

> Perhaps we can do another change? Not sure it is actually better, but I think
> it is always good to discuss the alternatives.
>
> 1. Once again, we turn "int group" argument into thread/process/pgid enum, and
>    change kill_pgrp/tty_signal_session_leader to pass "group = pgid", imo this
>    makes sense in any case.

I agree.  There are a lot more multi-process signals cases than handled
in Linus's patch.   I believe this will clean that up.

> 2. To simplify, lets suppose we add the new PF_INFORK flag. Yes, this is bad,
>    we can do better. I think we can simply add "struct hlist_head forking_threads"
>    into signal_struct, so complete_signal() can just do hlist_for_each_entry()
>    rather than for_each_thread() + PF_INFORK check. We don't even need a new
>    member in task_struct.

We still need the distinction between multi-process signals and single
process signals (which is the hard part).  For good performance of
signal delivery to multi-threaded tasks we still need a new member in
signal_struct.  Plus it is a bit more work to update the list or even
walk the list than a sequence counter.

So I think adding a sequence counter to let us know about multiprocess
signals is the local optimum.

If we ever need to remove the restart case entirely from fork and queue
all new multi-process signals for the newly created task.  Going through
the list of forking

>
> 3. copy_process() can simply block/unblock all signals (except KILL/STOP), see
>    the "patch" below.

All signals are effectively blocked for the duration of the fork for the
calling task.    Where we get into trouble and where we need a fix for
correctness is that another thread can dequeue the signal.   Blocking
signals of the forking task does not change that.

I think that reveals another bug in our current logic.  For blocked
multi-process signals we don't ensure they get delivered to both the
parent and the child if the signal logically comes in after the fork.

Multi-threaded b0rked ness and blocked signal b0rkenness, plus periodic
timers making for take forever for no good reason.  This business of
ensuring a signal is logically delvered before or after a fork is
tricky.

Eric


> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9440d61..652ef09 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1591,6 +1591,23 @@ static __latent_entropy struct task_struct *copy_process(
>  	int retval;
>  	struct task_struct *p;
>  
> +	spin_lock_irq(&current->sighand->siglock);
> +	recalc_sigpending_tsk(current);
> +	if (signal_pending(current)) {
> +		retval = -ERESTARTNOINTR;
> +	} else {
> +		// Yes, yes, this is wrong, just to explain the idea.
> +		// We should not block SIGKILL, we need to clear PF_INFORK
> +		// and restore ->blocked in error paths, we need helper(s).
> +		retval = 0;
> +		current->flags |= PF_INFORK;
> +		current->saved_sigmask = current->blocked;
> +		sigfillset(&current->blocked);
> +	}
> +	spin_unlock_irq(&current->sighand->siglock);
> +	if (retval)
> +		return retval;
> +
>  	/*
>  	 * Don't allow sharing the root directory with processes in a different
>  	 * namespace
> @@ -1918,8 +1935,14 @@ static __latent_entropy struct task_struct *copy_process(
>  	 * A fatal signal pending means that current will exit, so the new
>  	 * thread can't slip out of an OOM kill (or normal SIGKILL).
>  	*/
> -	recalc_sigpending();
> -	if (signal_pending(current)) {
> +	// check signal_pending() before __set_task_blocked() which does
> +	// recalc_sigpending(). Again, this is just to explain the idea,
> +	// __set_task_blocked() is not exported, it is suboptimal, we can
> +	// do better.
> +	bool eintr = signal_pending();
> +	current->flags &= ~PF_INFORK;
> +	__set_task_blocked(current, &current->saved_sigmask);
> +	if (eintr) {
>  		retval = -ERESTARTNOINTR;
>  		goto bad_fork_cancel_cgroup;
>  	}
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8d8a940..3433e66 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -900,6 +900,14 @@ static void complete_signal(int sig, struct task_struct *p, int group)
>  	struct signal_struct *signal = p->signal;
>  	struct task_struct *t;
>  
> +	// kill_pgrp/etc.
> +	if (group == 2) {
> +		for_each_thread(p, t) {
> +			if (p->flags & PF_INFORK && !sigismember(&p->saved_sigmask, sig))
> +				signal_wake_up(t, 0);
> +		}
> +	}
> +
>  	/*
>  	 * Now find a thread we can wake up to take the signal off the queue.
>  	 *
