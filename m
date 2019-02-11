Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7CDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34487222B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfBKONq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:13:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfBKONq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:13:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63805C0B0233;
        Mon, 11 Feb 2019 14:13:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 70FDE746E5;
        Mon, 11 Feb 2019 14:13:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Feb 2019 15:13:44 +0100 (CET)
Date:   Mon, 11 Feb 2019 15:13:40 +0100
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
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH 1/2] signal: Always notice exiting tasks
Message-ID: <20190211141340.GA21430@redhat.com>
References: <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
 <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
 <8736p37xcn.fsf@xmission.com>
 <878syu7tcm.fsf@xmission.com>
 <87tvhi4vl7.fsf@xmission.com>
 <87o97q1cky.fsf_-_@xmission.com>
 <20190206180754.GA23476@redhat.com>
 <87imxwv9jp.fsf@xmission.com>
 <875ztwt7yy.fsf_-_@xmission.com>
 <87zhr8rtd6.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhr8rtd6.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 11 Feb 2019 14:13:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry again for delay...

On 02/07, Eric W. Biederman wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
>  		goto relock;
>  	}
>  
> +	/* Has this task already been marked for death? */
> +	ksig->info.si_signo = signr = SIGKILL;
> +	if (signal_group_exit(signal))
> +		goto fatal;
> +
>  	for (;;) {
>  		struct k_sigaction *ka;
>  
> @@ -2488,6 +2493,7 @@ bool get_signal(struct ksignal *ksig)
>  			continue;
>  		}
>  
> +	fatal:
>  		spin_unlock_irq(&sighand->siglock);

Eric, but this is wrong. At least this is the serious user-visible change.

Afaics, with this patch the tracee will never stop in PTRACE_EVENT_EXIT in case
of group_exit/exec, because schedule() in TASK_TRACED state won't block due to
__fatal_signal_pending().

Yes, yes, as I said many times the semantics of PTRACE_EVENT_EXIT was never really
defined, it depends on /dev/random, but still I don't think we should break it even
more.

Oleg.

