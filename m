Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2235C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CF220844
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfBLAm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:42:57 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:60667 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbfBLAm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:42:56 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtMA2-0006fH-KI; Mon, 11 Feb 2019 17:42:54 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtM9s-0001Qz-0E; Mon, 11 Feb 2019 17:42:54 -0700
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
        <875ztwt7yy.fsf_-_@xmission.com> <87zhr8rtd6.fsf_-_@xmission.com>
        <20190211141340.GA21430@redhat.com>
Date:   Mon, 11 Feb 2019 18:42:39 -0600
In-Reply-To: <20190211141340.GA21430@redhat.com> (Oleg Nesterov's message of
        "Mon, 11 Feb 2019 15:13:40 +0100")
Message-ID: <87zhr1g7ls.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gtM9s-0001Qz-0E;;;mid=<87zhr1g7ls.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hBHkbM8iRU+eB6uN27rihvsQkezNpLQ8=
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

> sorry again for delay...
>
> On 02/07, Eric W. Biederman wrote:
>>
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
>>  		goto relock;
>>  	}
>>  
>> +	/* Has this task already been marked for death? */
>> +	ksig->info.si_signo = signr = SIGKILL;
>> +	if (signal_group_exit(signal))
>> +		goto fatal;
>> +
>>  	for (;;) {
>>  		struct k_sigaction *ka;
>>  
>> @@ -2488,6 +2493,7 @@ bool get_signal(struct ksignal *ksig)
>>  			continue;
>>  		}
>>  
>> +	fatal:
>>  		spin_unlock_irq(&sighand->siglock);
>
> Eric, but this is wrong. At least this is the serious user-visible
> change.
>
> Afaics, with this patch the tracee will never stop in PTRACE_EVENT_EXIT in case
> of group_exit/exec, because schedule() in TASK_TRACED state won't block due to
> __fatal_signal_pending().
>
> Yes, yes, as I said many times the semantics of PTRACE_EVENT_EXIT was never really
> defined, it depends on /dev/random, but still I don't think we should break it even
> more.

Well it changes PTRACE_EVENT_EXIT I grant that.  It looks like that
changes makes PTRACE_EVENT_EXIT is less than useful.

The only way to perfectly preserve the previous semantics is probably to
do something like my JOBCTL_TASK_EXIT proposal.

That said I don't think even adding a JOBCTL_TASK_EXIT is enough to have
a reliable stop of ptrace_event_exit after a process has exited.  As any
other pending signal can cause problems there as well.

I have received a report that strace -f in some cases is not noticing
children before they die and it looks like a stop in PTRACE_EVENT_EXIT
would fix that strace behavior.

Sigh.

Here I was trying for the simple minimal change and I hit this landmine.
Which leaves me with the question of what should be semantics of signal
handling after exit.

I think from dim memory of previous conversations the desired semantics
look like:
a) Ignore all signal state except for SIGKILL.
b) Letting SIGKILL wake up the process should be sufficient.

I will see if I can reproduce the strace failure and see if I can cook
up something minimal that addresses just that.  If you have suggestions
I would love to hear them.

As this was a minimal fix for SIGKILL being broken I have already sent
the fix to Linus.  So we are looking at an incremental fix at this point.

Eric
