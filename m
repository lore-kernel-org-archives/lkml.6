Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B72C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB8C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfBLQu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:50:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730744AbfBLQu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:50:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4E3459453;
        Tue, 12 Feb 2019 16:50:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1ADA6600C6;
        Tue, 12 Feb 2019 16:50:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 Feb 2019 17:50:26 +0100 (CET)
Date:   Tue, 12 Feb 2019 17:50:23 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [PATCH 1/2] signal: Always notice exiting tasks
Message-ID: <20190212165022.GA29263@redhat.com>
References: <878syu7tcm.fsf@xmission.com>
 <87tvhi4vl7.fsf@xmission.com>
 <87o97q1cky.fsf_-_@xmission.com>
 <20190206180754.GA23476@redhat.com>
 <87imxwv9jp.fsf@xmission.com>
 <875ztwt7yy.fsf_-_@xmission.com>
 <87zhr8rtd6.fsf_-_@xmission.com>
 <20190211141340.GA21430@redhat.com>
 <87zhr1g7ls.fsf@xmission.com>
 <871s4dctci.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s4dctci.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 12 Feb 2019 16:50:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12, Eric W. Biederman wrote:
>
> > Here I was trying for the simple minimal change and I hit this landmine.
> > Which leaves me with the question of what should be semantics of signal
> > handling after exit.

Yes, currently it is undefined. Even signal_pending() is random.

> > I think from dim memory of previous conversations the desired semantics
> > look like:
> > a) Ignore all signal state except for SIGKILL.
> > b) Letting SIGKILL wake up the process should be sufficient.

signal_wake_up(true) to make fatal_signal_pending() == T, I think.

> Oleg any ideas on how to make PTRACE_EVENT_EXIT reliably killable?

My answer is very simple: PTRACE_EVENT_EXIT must not stop if the tracee was
killed by the "real" SIGKILL (not by group_exit/etc), that is all. But this
is another user-visible change, it can equally confuse, say, strace (albeit
not too much iiuc).

But this needs another discussion.

> diff --git a/kernel/signal.c b/kernel/signal.c
> index 99fa8ff06fd9..a1f154dca73c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2544,6 +2544,9 @@ bool get_signal(struct ksignal *ksig)
>                 }
>
>         fatal:
> +               /* No more signals can be pending past this point */
> +               sigdelset(&current->pending.signal, SIGKILL);

Well, this is very confusing. In fact, this is not really correct. Say, we should
not remove the pending SIGKILL if we are going to call do_coredump(). This is
possible if ptrace_signal() was called, or after is_current_pgrp_orphaned() returns
false.

> +               clear_tsk_thread_flag(current, TIF_SIGPENDING);

I don't understand this change, it looks irrelevant. Possibly makes sense, but
this connects to "semantics of signal handling after exit".

OK, we need a minimal incremental fix for now. I'd suggest to replace

	ksig->info.si_signo = signr = SIGKILL;
	if (signal_group_exit(signal))
		goto fatal;

added by this patch with

	if (__fatal_signal_pending(current)) {
		ksig->info.si_signo = signr = SIGKILL;
		sigdelset(&current->pending.signal, SIGKILL);
		goto fatal;
	}

__fatal_signal_pending() is cheaper and looks more understandable.

Oleg.

