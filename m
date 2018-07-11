Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8020020C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8020020C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbeGKQHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:07:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57802 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeGKQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:07:52 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdHZm-00024q-9p; Wed, 11 Jul 2018 10:02:49 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdHZY-0004DO-Tx; Wed, 11 Jul 2018 10:02:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-11-ebiederm@xmission.com>
        <20180711141456.GA6636@redhat.com>
Date:   Wed, 11 Jul 2018 11:02:29 -0500
In-Reply-To: <20180711141456.GA6636@redhat.com> (Oleg Nesterov's message of
        "Wed, 11 Jul 2018 16:14:56 +0200")
Message-ID: <87h8l5g3qi.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fdHZY-0004DO-Tx;;;mid=<87h8l5g3qi.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+VWnJJgPmrAD86VHWscAFru7CRdj/Vhds=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 11/11] signal: Ignore all but multi-process signals that come in during fork.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/10, Eric W. Biederman wrote:
>>
>> @@ -1602,6 +1603,20 @@ static __latent_entropy struct task_struct *copy_process(
>>  {
>>  	int retval;
>>  	struct task_struct *p;
>> +	unsigned seq;
>> +
>> +	/*
>> +	 * Signals that are delivered to multiple processes need to be
>> +	 * delivered to just the parent before the fork or both the
>> +	 * parent and the child after the fork.  Cache the multiple
>> +	 * process signal sequence number so we can detect any of
>> +	 * these signals that happen during the fork.  In the unlikely
>> +	 * event a signal comes in while fork is starting and restart
>> +	 * fork to handle the signal.
>> +	 */
>> +	seq = read_seqcount_begin(&current->signal->multi_process_seq);
>> +	if (signal_pending(current))
>> +		return ERR_PTR(-ERESTARTNOINTR);
>>
>>  	/*
>>  	 * Don't allow sharing the root directory with processes in a different
>> @@ -1930,8 +1945,8 @@ static __latent_entropy struct task_struct *copy_process(
>>  	 * A fatal signal pending means that current will exit, so the new
>>  	 * thread can't slip out of an OOM kill (or normal SIGKILL).
>>  	*/
>> -	recalc_sigpending();
>> -	if (signal_pending(current)) {
>> +	if (read_seqcount_retry(&current->signal->multi_process_seq, seq) ||
>> +	    fatal_signal_pending(current)) {
>>  		retval = -ERESTARTNOINTR;
>>  		goto bad_fork_cancel_cgroup;
>
> So once again, I think this is not right, see the discussion on
> bugzilla.

I am trying to dig through and understand your concerns.  I am having
difficulty understanding your concerns.

Do the previous patches look good to you?  Can we say that is a
sufficient method to get the information about signals that are sent to
multiple processes into __send_signal?

> If signal_pending() == T we simply can't know if copy_process() can succeed or not.
> I have already mentioned the races with stop/freeze, but I think there
> are more.

If I understand you correctly.  Your concern is that since we added the:

	recalc_sigpending();
        if (signal_pending(current))
        	return -ERESTARTNOINTR;

Other (non-signal) code such as the freezer has come to depend upon that
test.  Changing the test in the proposed way will allow the new child to
escape the freezer, as it is not guaranteed the new child will be
frozen.

It seems reasonable to look at other things that set TIF_SIGPENDING and
see if any of them are broken by the fork changes.

A quick look at exit_to_usermode_loop shows that TIF_SIGPENDING only
triggers signal handling.  In get_signal there is only task_work_run,
try_to_freeze, and burried there is ptrace_stop. 

Plus there is restart_syscall() that sets TIF_SIGPENDING.  Now that we
aren't guaranteed that TIF_SIGPENDING is set before we restart, the code
should be using "retval = restart_syscall();"  I will fix that.


I will dig in and see what attention those cases need in fork
signal_pending behavior.  I am hoping that it will be as simple as
adding:

        /* Have the child return to userspace slowly
	 * TIF_SIGPENDING was set during fork
         */
	if (test_tsk_thread_flag(current, TIF_SIGPENDING))
		set_tsk_thread_flag(p, TIF_SIGPENDING);
        	

> And in fact I think that the fact that signal_wake_up() helps to avoid the races
> with fork() is useful. Say, we could add signal_wake_up() into syscall_regfunc()
> and kill syscall_tracepoint_update(). Not that I think this particular change makes
> any sense, but it can work.
>
> That is why I tried to sugest another approach. copy_process() should always fail
> if signal_pending() == T, just the "real" signal should not disturb the forking
> thread unless the signal is fatal or multi-process.

So after seeing the report of periodic timers causing a 40ms fork to
stretch into a 1000ms fork because of restarts, I am not a fan of cases
where fork has to restart.  40ms is a lot of work to abandon.

A practical (and fixable) problem with your patch was that you modified
task->blocked which was then copied to the child.  So all children now
would start with all signals being blocked.

> This also makes another difference in multi-threaded case, a signal with a handler
> sent to a forking process will be re-targeted to another thread which can handle it;
> with your patch this signal will be "blocked" until fork() finishes or until another
> thread gets TIF_SIGPENDING. Not that I think this is that important,
> but still.

I would not object to wants_signal deciding that a task in the middle of
copy_process does not want signals.

Eric
