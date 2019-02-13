Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D996C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4512A222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbfBMO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:58:37 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34834 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfBMO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:58:37 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtvzf-0000fv-Iu; Wed, 13 Feb 2019 07:58:35 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtvze-00022y-Lc; Wed, 13 Feb 2019 07:58:35 -0700
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
References: <87o97q1cky.fsf_-_@xmission.com>
        <20190206180754.GA23476@redhat.com> <87imxwv9jp.fsf@xmission.com>
        <875ztwt7yy.fsf_-_@xmission.com> <87zhr8rtd6.fsf_-_@xmission.com>
        <20190211141340.GA21430@redhat.com> <87zhr1g7ls.fsf@xmission.com>
        <871s4dctci.fsf@xmission.com> <20190212165022.GA29263@redhat.com>
        <87ef8c5nyt.fsf_-_@xmission.com> <20190213143852.GC9356@redhat.com>
Date:   Wed, 13 Feb 2019 08:58:28 -0600
In-Reply-To: <20190213143852.GC9356@redhat.com> (Oleg Nesterov's message of
        "Wed, 13 Feb 2019 15:38:52 +0100")
Message-ID: <87d0nv4twr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gtvze-00022y-Lc;;;mid=<87d0nv4twr.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+3wHEZ/vgF8/T8GizPXKTvENyUYpM1UYE=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: Restore the stop PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> sorry for noise, but after I read the changelog I have a minor nit,
> feel free to ignore...
>
> On 02/12, Eric W. Biederman wrote:
>>
>> Skipping past dequeue_signal when we know a fatal signal has already
>> been delivered resulted in SIGKILL remaining pending and
>> TIF_SIGPENDING remaining set.  This in turn caused the
>> scheduler to not sleep in PTACE_EVENT_EXIT as it figured
>> a fatal signal was pending.
>
> Yes, but the status of TIF_SIGPENDING doesn't matter. However I agree
> with recalc_sigpending() added by this patch, simply because this is what
> the "normal" dequeue_signal() paths do.
>
>> This also caused ptrace_freeze_traced
>> in ptrace_check_attach to fail because it left a per thread
>> SIGKILL pending which is what fatal_signal_pending tests for.
>
> this is possible too, but in the likely case ptrace_check_attach() won't
> be even called exactly because the tracee won't stop and thus waitpid()
> won't report WIFSTOPPED. And even if waitpid() "wins" the race and debugger
> calls ptrace(), most probably ptrace_freeze_traced() will fail because
> task_is_traced() will be false.
>
> I think this part of the changelog looks a bit confusing. It doesn't matter
> why ptrace_check_attach() fails, it must fail if the tracee didn't stop.
>
> PTACE_EVENT_EXIT won't stop and thus this event won't be reported, that is all.

There might be a better way to say it.  What I meant to convey is that
in my testing I could get PTRACE_EVENT_EXIT to stop by clearing
TIF_SIGPENDING (and leaving SIGKILL in pending).  That was insufficient
to fix the bug.  Without SIGKILL in pending ptrace_check_attach would
fail when the process was stopped in PTRACE_EVENT_EXIT.



Or in short it really bugs me that we have to have signal_group_exit
and fatal_signal_pending not in agreement after in do_exit to make the code
work.  It bothers me because fatal_signal_pending and signal_group_exit
are in all other cases just different ways to ask the same question.

Eric


