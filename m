Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293B4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00770218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfBFW0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:26:00 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:56054 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBFW0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:26:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grVdm-0003lx-5X; Wed, 06 Feb 2019 15:25:58 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grVdj-0005o0-9y; Wed, 06 Feb 2019 15:25:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
        <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
        <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
        <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
        <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
        <8736p37xcn.fsf@xmission.com> <878syu7tcm.fsf@xmission.com>
        <87tvhi4vl7.fsf@xmission.com> <87o97q1cky.fsf_-_@xmission.com>
        <20190206180754.GA23476@redhat.com>
Date:   Wed, 06 Feb 2019 16:25:46 -0600
In-Reply-To: <20190206180754.GA23476@redhat.com> (Oleg Nesterov's message of
        "Wed, 6 Feb 2019 19:07:54 +0100")
Message-ID: <87imxwv9jp.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1grVdj-0005o0-9y;;;mid=<87imxwv9jp.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/s0v0HF0ijodtt9R6IBbauGq13M/jSvXM=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] signal: Store pending signal exit in tsk.jobctl not in tsk.pending
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Eric, at al,
>
> Sorry, I am on on vacation, can't even read this thread right now,
> so I am not sure I understand the problem correctly...

That is fair.  Please don't let me mess up your vacation.

The problem is an infinite stream of SIGHUP from a timer, making
processes unkillable.

Looking into that I see two bugs.
a) We handle fatal signals (esp SIGKILL) early in complete_signal and
   this SIGHUP stream is messing up our handling.
b) We don't properly distinguish between synchronous and asynchrous
   signals.

I am only aiming to fix the fatal signal issue with this change.

> On 02/05, Eric W. Biederman wrote:
>>
>> @@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
>>  		goto relock;
>>  	}
>>
>> +	/* Has this task already been flagged for death? */
>> +	ksig->info.si_signo = signr = SIGKILL;
>> +	if (current->jobctl & JOBCTL_TASK_EXIT)
>> +		goto fatal;
>> +
>
> Can't we simply change, say, next_signal() to return SIGKILL if it is
> pending?

We could.  But since this isn't necessarily SIGKILL we are dealing with,
it could just as easily be an unhandled SIGINT, so having SIGKILL in the
per task signal queue could still lead to other problems.  I am afraid
that if continue abusing the per task signal queue other bugs of
confusion will occur.

> In any case, I am not sure we need JOBCTL_TASK_EXIT. Can't we rely on
> signal_group_exit() ?

Looking more closely yes I believe we can.

I thought de_thread would be a problem but signal_group_exit handles
that case and the core dump cases just fine.

It is a bit of a surprise but that would make:

> static inline int __fatal_signal_pending(struct task_struct *p)
> {
> 	return signal_group_exit(p->signal);
> }

I will respin and see if we can the change just depend on
signal_group_exit.  One less abstraction to have to keep
in sync sounds more robust in the long run.

Eric

