Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9107C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739392083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfBEGHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:07:34 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46546 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBEGHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:07:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gqttE-0003g3-J3; Mon, 04 Feb 2019 23:07:24 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gqttC-0005fY-SD; Mon, 04 Feb 2019 23:07:24 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
        <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
        <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
        <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
        <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
        <8736p37xcn.fsf@xmission.com> <878syu7tcm.fsf@xmission.com>
Date:   Tue, 05 Feb 2019 00:07:16 -0600
In-Reply-To: <878syu7tcm.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 04 Feb 2019 22:27:21 -0600")
Message-ID: <87tvhi4vl7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gqttC-0005fY-SD;;;mid=<87tvhi4vl7.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18hAmi9I7B6DMxdy1DLHhNBg/MiZMcRpg8=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: perf_event_open+clone = unkillable process
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>
>>> On Mon, 4 Feb 2019, Dmitry Vyukov wrote:
>>>
>>>> On Mon, Feb 4, 2019 at 10:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>> >
>>>> > On Fri, 1 Feb 2019, Dmitry Vyukov wrote:
>>>> >
>>>> > > On Fri, Feb 1, 2019 at 5:48 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>> > > >
>>>> > > > Hello,
>>>> > > >
>>>> > > > The following program creates an unkillable process that eats CPU.
>>>> > > > /proc/pid/stack is empty, I am not sure what other info I can provide.
>>>> > > >
>>>> > > > Tested is on upstream commit 4aa9fc2a435abe95a1e8d7f8c7b3d6356514b37a.
>>>> > > > Config is attached.
>>>> > >
>>>> > > Looking through other reproducers that create unkillable processes, I
>>>> > > think I found a much simpler reproducer (below). It's single threaded
>>>> > > and just setups SIGBUS handler and does timer_create+timer_settime to
>>>> > > send repeated SIGBUS. The resulting process can't be killed with
>>>> > > SIGKILL.
>>>> > > +Thomas for timers.
>>>> >
>>>> > +Oleg, Eric
>>>> >
>>>> > That's odd. With some tracing I can see that SIGKILL is generated and
>>>> > queued, but its not delivered by some weird reason. I'm traveling in the
>>>> > next days, so I won't be able to do much about it. Will look later this
>>>> > week.
>>>> 
>>>> Just a random though looking at the repro: can constant SIGBUS
>>>> delivery starve delivery of all other signals (incl SIGKILL)?
>>>
>>> Indeed. SIGBUS is 7, SIGKILL is 9 and next_signal() delivers the lowest
>>> number first....
>>
>> We do have the special case in complete_signal that causes most of the
>> signal delivery work of SIGKILL to happen when SIGKILL is queued.
>>
>> I need to look at your reproducer.  It would require being a per-thread
>> signal to cause problems in next_signal.
>>
>> It is definitely worth fixing if there is any way for userspace to block
>> SIGKILL.
>
> Ugh.
>
> The practical problem appears much worse.
>
> Tracing the code I see that we attempt to deliver SIGBUS, I presume in a
> per thread way.
>
> At some point the delivery of SIGBUS fails.  Then the kernel attempts
> to synchronously force SIGSEGV.  Which should be the end of it.
>
> Unfortunately at that point our heuristic for dealing with syncrhonous
> signals fails in next_signal and we attempt to deliver the timers
> SIGBUS instead.
>
> I suspect it is time to byte the bullet and handle the synchronous
> unblockable signals differently.  I will see if I can cook up an
> appropriate patch.

Playing with this some more what I see happening is:


SIGHUP and SIGSEGV get directed at sighup_handler.
Timer delivers SIGHUP
sighup_handler starts.
timer delivers SIGHUP (before sighup_handler finishes)
sighup_handler starts.
timer delivers SIGHUP (before sighup_handler finishes)
sighup_handler starts.
timer delivers SIGHUP (before sighup_handler finishes)
sighup_handler starts.
....
Up until the stack is full.
Then:
timer delivers SIGHUP
sighup_handler won't start
Attempt force_sigsegv
Confused kernel attempts to deliver SIGHUP (instead of a synchronous SIGSEGV)

If you unconfuse the kernel there is an attempt to deliver SIGSEGV
(the stack is full)
Then the kernel changes the SIGSEGV handler to SIG_DFL
Then SIGSEGV is successfully delivered terminating the application

Which suggests 2 fixes.
1) making SIGKILL something that can't get hidden behind other signals.
2) Having a 3rd queue of signals for the synchronous signals.
   So that the synchronous signals can't be blocked by per thread signals.

I have prototyped the 2nd one and it is enough to stop the infinite spin
that causes problems here when the process stack fills up.

Fixing SIGKILL will probably bring more benefits.

Eric
