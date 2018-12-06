Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C762BC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CB220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CB220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLFPAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:00:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:43821 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbeLFOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUupd-0005ao-H5; Thu, 06 Dec 2018 07:40:49 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUupZ-0006M5-8H; Thu, 06 Dec 2018 07:40:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
        <20181112185538.GK3645@cisco> <20181112192443.GL3645@cisco>
        <20181127232126.GA23658@cisco>
        <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
        <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
        <87zhtthkuy.fsf@xmission.com>
        <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
        <87k1ktqoe5.fsf@xmission.com>
        <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
Date:   Thu, 06 Dec 2018 08:40:34 -0600
In-Reply-To: <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
        (Kees Cook's message of "Wed, 5 Dec 2018 17:00:34 -0800")
Message-ID: <87r2euiuql.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gUupZ-0006M5-8H;;;mid=<87r2euiuql.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/NpyzcGyTUuZwdNv3rUGdARisMuWITK8w=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: siginfo pid not populated from ptrace?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Sat, Dec 1, 2018 at 7:04 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Kees Cook <keescook@chromium.org> writes:
>>
>> > On Tue, Nov 27, 2018 at 8:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >>
>> >> Kees Cook <keescook@chromium.org> writes:
>> >>
>> >> > On Tue, Nov 27, 2018 at 4:38 PM, Kees Cook <keescook@chromium.org> wrote:
>> >> >> On Tue, Nov 27, 2018 at 3:21 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>> >> >>> On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
>> >> >>>> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
>> >> >>>> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
>> >> >>>>
>> >> >>>> Ok, now I have,
>> >> >>>>
>> >> >>>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
>> >> >>>> global.syscall_restart: Test failed at step #22
>> >> >>>
>> >> >>> Seems like this is still happening on v4.20-rc4,
>> >> >>>
>> >> >>> [ RUN      ] global.syscall_restart
>> >> >>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
>> >> >>> global.syscall_restart: Test failed at step #22
>> >> >>
>> >> >> This fails every time for me -- is it still racey for you?
>> >> >>
>> >> >> I'm attempting a bisect, hoping it doesn't _become_ racey for me. ;)
>> >> >
>> >> > This bisects to here for me:
>> >> >
>> >> > commit f149b31557446aff9ca96d4be7e39cc266f6e7cc
>> >> > Author: Eric W. Biederman <ebiederm@xmission.com>
>> >> > Date:   Mon Sep 3 09:50:36 2018 +0200
>> >> >
>> >> >     signal: Never allocate siginfo for SIGKILL or SIGSTOP
>> >> >
>> >> >     The SIGKILL and SIGSTOP signals are never delivered to userspace so
>> >> >     queued siginfo for these signals can never be observed.  Therefore
>> >> >     remove the chance of failure by never even attempting to allocate
>> >> >     siginfo in those cases.
>> >> >
>> >> >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> >> >     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> >> >
>> >> > They are certainly visible via seccomp ;)
>> >>
>> >> Well SIGSTOP is visible via PTRACE_GETSIGINFO.
>> >>
>> >> I see what is happening now.  Since we don't have queued siginfo
>> >> we generate some as:
>> >>                 /*
>> >>                  * Ok, it wasn't in the queue.  This must be
>> >>                  * a fast-pathed signal or we must have been
>> >>                  * out of queue space.  So zero out the info.
>> >>                  */
>> >>                 clear_siginfo(info);
>> >>                 info->si_signo = sig;
>> >>                 info->si_errno = 0;
>> >>                 info->si_code = SI_USER;
>> >>                 info->si_pid = 0;
>> >>                 info->si_uid = 0;
>> >>
>> >> Which allows last_signfo to be set,
>> >> so despite not really having any siginfo PTRACE_GET_SIGINFO
>> >> has something to return so does not return -EINVAL.
>> >>
>> >> Reconstructing my context that was part of removing SEND_SIG_FORCED
>> >> so this looks like it will take a little more than a revert to fix
>> >> this.
>> >>
>> >> This is definitely a change that is visible to user space.  The logic in
>> >> my patch was definitely wrong with respect to SIGSTOP and
>> >> PTRACE_GETSIGINFO.  Is there something in userspace that actually cares?
>> >> AKA is the idiom that the test seccomp_bpf.c is using something that
>> >> non-test code does?
>> >
>> > I think this would be needed by any ptracer that handled multiple
>> > threads. It needs to figure out which pid stopped. I think it's worth
>> > fixing, yes.
>> >
>> >> The change below should restore the old behavior.  I am just wondering
>> >> if this is something we want to do.  siginfo is allocated with
>> >> GFP_ATOMIC so if your machine is under memory pressure there is a real
>> >> chance the allocation can fail.  Which would cause whatever is breaking
>> >> now to break less deterministically then.
>> >
>> > I think memory pressure that would block a 128 byte GFP_ATOMIC
>> > allocation would mean the system was about to seriously fall over.
>> > Given the user-facing behavior change and that an existing test was
>> > already checking for this means we need to fix it.
>>
>> That sounds good but it is all rubbish.
>> A) It doesn't matter for tracing multiple processes because ptrace
>>    only works on a single signal at a time.  AKA if by the time you
>>    are calling PTRACE_GETSIGINFO you already know which process you are
>>    working against.
>> B) Not every signal includes si_pid so even if you didn't know who you
>>    were talking to this would be an issue.
>> C) For a non-rt signal we only every try and queue up a signal signal.
>>    We don't even attempt to queue siginfo otherwise.
>
> Fair enough, all true.
>
>> So what is the real world use case?
>
> A quick search didn't show anything I could find (looking for
> combinations of PTRACE_GETSIGINFO and si_pid use around a SIGSTOP).
> That doesn't mean it doesn't exist, though. The reason seccomp's
> selftests are so extensive is because we've had some very
> corner-case[1] bugs in real-world software.

I support that.

>> The most useful I can think of is the whole check if this tracer was the
>> one who sent SIGSTOP.  But that is fundamentally unreliable because we
>> only queue a single signal anyway.  We must to that to preserve
>> compatibility for non-rt signals as otherwise there are cases we could
>> queue the same signal twice.  So with two simultaneous SIGSTOPs it is a
>> race condition which siginfo is made available.
>
> Understood. However, the point of the seccomp test is for making sure
> that the ordering of the controlled test gets us the right pattern of
> events across a syscall interruption when seccomp is filtering. This
> is about making sure nothing around the restart changes since this
> could impact seccomp filters in the wild.

That is fair.  Does the test fundamentally need to check the sender of
SIGSTOP to know everything you are sending is working for seccomp?

>> Right now we are on the edge of letting test cases for debug
>> infrastructure prevent obvious optimizations/improvements to the code.
>> So if we can find something other than our seccomp_bpf.c test case that
>> fails I am happy to go with the change I posted.  Otherwise I think we
>> just need to fix seccomp_bpf.c.
>
> I wouldn't call this "debug infrastructure": they are behavioral test
> cases for seccomp, syscall, and ptrace interaction, and even this one
> has found bugs (see the "FIXME" note a few lines down, that remains
> unsolved[2] in arm32).

I would call ptrace "debug infrastructure".

My concern is that there were a number of signal senders that were
setting SEND_SIG_FORCED.  They were setting SEND_SIG_FORCED to cause
the signal delivery process to work differently.  Ensuring the pid
namespace init was killed, to not allocate siginfo, etc.

This was very fragile code internal to the kernel and required much
to much knowledge from the signal senders of the signals.  So I updated
the code to apply the transformations whenever reasonably possible so
senders of those signals would not need to think about it.  Reducing
bugs overall and making the kernel more consistent.

The logic was that the siginfo from SIGSTOP and SIGKILL could not be
observed.  Except for PTRACE_GETSIGINFO for SIGSTOP is actually true.

> If this actually doesn't count as breaking userspace, then okay, sure,
> I'll drop the sanity check in the seccomp selftest. But it feels wrong
> to me.

With just a test showing this, this doesn't yet count as breaking
userspace.  At the same time this is on a funny edge.

If something that is not a test truly depends on this it would
definitely count as breaking userspace.   Equally if there is a case
where it can be shown that userspace can reasonably depend on this
behavior to achieve something userspace needs to do.  Then sure.

We have in the past had ptrace users that weren't just about debugging
so I don't know that it is fair to just dismiss it as debugging
infrastructure.

Right now I am trying to understand why seccomp bpf cares.  So that I
can figure out if I need to do something.

The optimization of not allocating siginfo for SIGSTOP is very
reasonable except when the process is being ptraced.  It even has the
possibility of making SIGSTOP working better for the common case.  So I
am reluctant to give up a kernel improvement until I understand what
reasonable case in userspace I am breaking.

What I am seeing is a case where for a multi-threaded process the
ptracer has to win the multi-threaded signal lottery to see
the siginfo.  Further no one else but the ptracer can send SIGSTOP
in the same window and generate an alternate SIGSTOP.

So my best analysis is that except under very controlled circumstances
si_pid for SIGSTOP will be unreliable.  Except in a test I don't know
how you could guarantee those controlled circumstances.  But please if
you can see a scenario that I don't please let me know.

Eric
