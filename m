Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A87C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C47321934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfBMD7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:59:13 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52121 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfBMD7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:59:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtlhU-0004Cv-DJ; Tue, 12 Feb 2019 20:59:08 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtlhJ-0008Ap-2c; Tue, 12 Feb 2019 20:59:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Ivan Delalande <colona@arista.com>
References: <878syu7tcm.fsf@xmission.com> <87tvhi4vl7.fsf@xmission.com>
        <87o97q1cky.fsf_-_@xmission.com> <20190206180754.GA23476@redhat.com>
        <87imxwv9jp.fsf@xmission.com> <875ztwt7yy.fsf_-_@xmission.com>
        <87zhr8rtd6.fsf_-_@xmission.com> <20190211141340.GA21430@redhat.com>
        <87zhr1g7ls.fsf@xmission.com> <871s4dctci.fsf@xmission.com>
        <20190212165022.GA29263@redhat.com>
Date:   Tue, 12 Feb 2019 21:58:51 -0600
In-Reply-To: <20190212165022.GA29263@redhat.com> (Oleg Nesterov's message of
        "Tue, 12 Feb 2019 17:50:23 +0100")
Message-ID: <87mun05og4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gtlhJ-0008Ap-2c;;;mid=<87mun05og4.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19bxTii4t1DJXvgJf3FAuTv64DoCJfA598=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] signal: Always notice exiting tasks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 02/12, Eric W. Biederman wrote:
>>
>> > Here I was trying for the simple minimal change and I hit this landmine.
>> > Which leaves me with the question of what should be semantics of signal
>> > handling after exit.
>
> Yes, currently it is undefined. Even signal_pending() is random.
>
>> > I think from dim memory of previous conversations the desired semantics
>> > look like:
>> > a) Ignore all signal state except for SIGKILL.
>> > b) Letting SIGKILL wake up the process should be sufficient.
>
> signal_wake_up(true) to make fatal_signal_pending() == T, I think.
>
>> Oleg any ideas on how to make PTRACE_EVENT_EXIT reliably killable?
>
> My answer is very simple: PTRACE_EVENT_EXIT must not stop if the tracee was
> killed by the "real" SIGKILL (not by group_exit/etc), that is all. But this
> is another user-visible change, it can equally confuse, say, strace (albeit
> not too much iiuc).
>
> But this needs another discussion.

Yes.  Quite.

I will just point out that as described that logic will rebreak Ivan's
program.

>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 99fa8ff06fd9..a1f154dca73c 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2544,6 +2544,9 @@ bool get_signal(struct ksignal *ksig)
>>                 }
>>
>>         fatal:
>> +               /* No more signals can be pending past this point */
>> +               sigdelset(&current->pending.signal, SIGKILL);
>
> Well, this is very confusing. In fact, this is not really correct. Say, we should
> not remove the pending SIGKILL if we are going to call do_coredump(). This is
> possible if ptrace_signal() was called, or after is_current_pgrp_orphaned() returns
> false.

I don't see bugs in it.  But it is certainly subtle and that is not what
is needed right now.

The subtlety is that we will never have a per thread SIGKILL pending
unless signal_group_exit is true.  So removing when it is not there is harmless.

>> +               clear_tsk_thread_flag(current, TIF_SIGPENDING);
>
> I don't understand this change, it looks irrelevant. Possibly makes sense, but
> this connects to "semantics of signal handling after exit".

As on the other the location is too subtle for the regression fix.

The primary motivation is that dequeue_signal calls recalc_sigpending.
And in the common case that will result clearing the TIF_SIGPENDING
which will result in signal_pending being false.

I have not found a location that cares enough to cause a misbehavior
if we don't clear TIF_SIGPENDING but it is a practical change and there
might be.  So if the word of the day is be very conservative and
avoid landminds I expect we need the clearing of TIF_SIGPENDING.

Hmm.  Probably using recalc_sigpending() now that I think about it.

> OK, we need a minimal incremental fix for now. I'd suggest to replace
>
> 	ksig->info.si_signo = signr = SIGKILL;
> 	if (signal_group_exit(signal))
> 		goto fatal;
>
> added by this patch with
>
> 	if (__fatal_signal_pending(current)) {
> 		ksig->info.si_signo = signr = SIGKILL;
> 		sigdelset(&current->pending.signal, SIGKILL);
> 		goto fatal;
> 	}
>
> __fatal_signal_pending() is cheaper and looks more understandable.


I definitely agree that it is much less likely to cause a problem
if we move all of the work before jumping to fatal.

The cost of both __fatal_signal_pending and signal_group_exit is just
a cache line read.  So not a big deal wither way.

On the other hand __fatal_signal_pending as currently implemented is
insanely subtle and arguably a bit confusing.  It tests for a SIGKILL in
the current pending sigset, to discover the signal group property of if
a process as started exiting.

In the long run we need our data structures not to be subtle and
tricky to use.  To do that we need a test of something in signal_struct
because it is a per signal group property.  Further we need to remove
the abuse of the per thread SIGKILL.

Since signal_group_exit always implies __fatal_signal_pending in this
case and the reverse.  I see no reason to use a function that requires
we maintain a huge amount of confusing and unnecessary machinery to keep
working.

All of that plus the signal_group_exit test has been tested and shown to
fix an ignored SIGKILL and the only practical problem is it doesn't do
one or two little things that dequeue_signal has done that made it
impossible to stop in PTRACE_EVENT_EXIT.

So for the regression fix let's just do the few little things that
dequeue_signal used to do.  That gives us a strong guarantee that
nothing else was missed.

Eric
