Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453DCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0BA207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbfBMN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:56:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfBMN4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:56:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DA155945D;
        Wed, 13 Feb 2019 13:56:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id C95EC5C21F;
        Wed, 13 Feb 2019 13:55:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Feb 2019 14:56:00 +0100 (CET)
Date:   Wed, 13 Feb 2019 14:55:57 +0100
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
Subject: Re: [PATCH] signal: Restore the stop PTRACE_EVENT_EXIT
Message-ID: <20190213135557.GB9356@redhat.com>
References: <87o97q1cky.fsf_-_@xmission.com>
 <20190206180754.GA23476@redhat.com>
 <87imxwv9jp.fsf@xmission.com>
 <875ztwt7yy.fsf_-_@xmission.com>
 <87zhr8rtd6.fsf_-_@xmission.com>
 <20190211141340.GA21430@redhat.com>
 <87zhr1g7ls.fsf@xmission.com>
 <871s4dctci.fsf@xmission.com>
 <20190212165022.GA29263@redhat.com>
 <87ef8c5nyt.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef8c5nyt.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 13 Feb 2019 13:56:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12, Eric W. Biederman wrote:
>
> Oleg this looks like the most conservative regression fix I can manage.

This is what I tried to suggest.

Except I still think that __fatal_signal_pending() would look better.

Yes, yes, in the long term we can possibly even kill fatal_signal_pending()
by various reasons I am not going to discuss right now (although I'd prefer
to kill signal_group_exit() instead).

But then we will probably need to reconsider sigdelset(SIGKILL) added by
this patch too. And until then

	if (__fatal_signal_pending())
		sigdelset(SIGKILL);

looks much more clear and understandable to me.

But I am not going to argue, feel free to add my ack.

> 
>  kernel/signal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 99fa8ff06fd9..57b7771e20d7 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2436,9 +2436,12 @@ bool get_signal(struct ksignal *ksig)
>  	}
>  
>  	/* Has this task already been marked for death? */
> -	ksig->info.si_signo = signr = SIGKILL;
> -	if (signal_group_exit(signal))
> +	if (signal_group_exit(signal)) {
> +		ksig->info.si_signo = signr = SIGKILL;
> +		sigdelset(&current->pending.signal, SIGKILL);
> +		recalc_sigpending();
>  		goto fatal;
> +	}
>  
>  	for (;;) {
>  		struct k_sigaction *ka;
> -- 
> 2.17.1
> 

