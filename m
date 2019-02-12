Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F82C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FAF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBLABv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:01:51 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47022 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfBLABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:01:50 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtLWG-00060B-By; Mon, 11 Feb 2019 17:01:48 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtLWC-0004Yt-ID; Mon, 11 Feb 2019 17:01:48 -0700
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
        syzkaller <syzkaller@googlegroups.com>
References: <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
        <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
        <8736p37xcn.fsf@xmission.com> <878syu7tcm.fsf@xmission.com>
        <87tvhi4vl7.fsf@xmission.com> <87o97q1cky.fsf_-_@xmission.com>
        <20190206180754.GA23476@redhat.com> <87imxwv9jp.fsf@xmission.com>
        <875ztwt7yy.fsf_-_@xmission.com> <87tvhgrtce.fsf_-_@xmission.com>
        <20190211151840.GB21430@redhat.com>
Date:   Mon, 11 Feb 2019 18:01:39 -0600
In-Reply-To: <20190211151840.GB21430@redhat.com> (Oleg Nesterov's message of
        "Mon, 11 Feb 2019 16:18:40 +0100")
Message-ID: <87va1pj2n0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gtLWC-0004Yt-ID;;;mid=<87va1pj2n0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+LSxelErDFqe9xQRRgcZfnokwiIlw/wS8=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/2] signal: Better detection of synchronous signals
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Eric, I'll try to finally read the whole thread later, probably I missed
> something, but...
>
> On 02/07, Eric W. Biederman wrote:
>>
>> Recently syzkaller was able to create unkillablle processes by
>> creating a timer that is delivered as a thread local signal on SIGHUP,
>> and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop failing
>> to deliver SIGHUP but always trying.
>>
>> When the stack overflows delivery of SIGHUP fails and force_sigsegv is
>> called.  Unfortunately because SIGSEGV is numerically higher than
>> SIGHUP next_signal tries again to deliver a SIGHUP.
>
> Confused... In this particular case next_signal() should return SIGSEGV
> because it must be pending too and SYNCHRONOUS_MASK doesn't include SIGHUP.
>
> Not that it really matters, the timer can deliver another SYNCHRONOUS_MASK
> signal < SIGSEGV, just I am trying to understand what have I missed...

Bah. It was SIGBUS.  My brain kept thinking SIGHUP. My apologies this
mental error slipped into the patch description.

>> +	/*
>> +	 * Check if there is another siginfo for the same signal.
>> +	 */
>> +	list_for_each_entry_continue(q, &pending->list, list) {
>> +		if (q->info.si_signo == sync->info.si_signo)
>> +			goto still_pending;
>> +	}
>
> But this must not be possible? SYNCHRONOUS_MASK doesn't include real-time
> signals, we can't have 2 siginfo's for the same signal < SIGRTMIN.

Yes for that reason it should be safe to strip that logic out at the
moment.  I overlooked that when writing the code.

However.  I am not certain that is a limit we actually want to honor
with synchronous signals.  As it results in a louzy quality of
implementation.

We start with an instruction in the program being debugged.  In
principle before that instruction starts we know that no signals
are pending because they were not delivered to that process.

If we for some reason send signal A to the process and at the same time
hit a fault that is reported as signal A.  It is currently a race which
one wins.  I think we could legitimately say that the fault happened
before signal A was enqueued, and deliver both. It is a bit murkier if
signal A was blocked.

If we let the enqueued signal A win (as we do today) we have SA_SIGNFO
that is not useful for describing the fault the instruction generated.
Which is a really lousy quality of implementation.

Which is a long way of saying I think that hunk of code is useful as it
allows us the possibility of fixing a lousy quality of implementation in
our code today.

Eric
