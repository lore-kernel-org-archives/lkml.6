Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C67C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A064B219F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A064B219F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbeHFMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:25:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbeHFMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:25:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so11775213wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xoOpmCGdezQLtEap+G8bGbYhnVwmDyVb9dIRyiQeRd4=;
        b=fOcC1KI1Xeez2IRzQcULQBjgnPx+X7KKTzFrw7iMiGvXWJxX3Fy8AJw5SzQeaM/8CN
         lceMFMWQFiJN5HG8pyC9Dadw5ZXHv879LaMtDro2hXemcZcJRfQOrpt4tZD3Tao0a48w
         5bS/ex/xtI3OXhWGGIv+Zd3/+zKDVRcFK1fEaES0T6z1GJMWdPMcIIKcgdrkjqq8z1F4
         4TTqPDgJgmuDkXvkpftpU4Oi3tcoo3MvgkJJgzVTUoz0m9Tix3ein73aFlr+7yti2Vty
         iM0Bqo8BBc27+ythpR7yhbxvmQ4a4UX/BSl3kEouHkFV3NmEmBAR2ZD4kSdi7pX2/3vQ
         RNmw==
X-Gm-Message-State: AOUpUlHuj9i+lK1bueld2zyvG7WgTrUU+emIdZw0DPSFsrhNjuOK/JXJ
        afvskQ/0aZ2d9oXYJbpZZzPtxg==
X-Google-Smtp-Source: AAOMgpcSW7+ClA97rcCcLMDO7DTC7iZb4m02/HXI6xzUaHlIpsW6GepzDelOdh3EELPXxjHKDQyFRg==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr9207036wrd.253.1533550632709;
        Mon, 06 Aug 2018 03:17:12 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BC043E5D9DE83B849D6CE88.dip0.t-ipconnect.de. [2003:ef:2bc0:43e5:d9de:83b8:49d6:ce88])
        by smtp.gmail.com with ESMTPSA id f8-v6sm14103538wrj.9.2018.08.06.03.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 03:17:11 -0700 (PDT)
Date:   Mon, 6 Aug 2018 12:17:07 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, bristot@redhat.com
Subject: Re: [PATCH] sched/deadline: Fix switched_from_dl
Message-ID: <20180806101707.GD26470@localhost.localdomain>
References: <20180711072948.27061-1-juri.lelli@redhat.com>
 <20180801231953.151fdce6@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801231953.151fdce6@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/18 23:19, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 09:29:48 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > Mark noticed that syzkaller is able to reliably trigger the following
> > 
> >   dl_rq->running_bw > dl_rq->this_bw
> >   WARNING: CPU: 1 PID: 153 at kernel/sched/deadline.c:124 switched_from_dl+0x454/0x608
> >   Kernel panic - not syncing: panic_on_warn set ...
> > 
> >   CPU: 1 PID: 153 Comm: syz-executor253 Not tainted 4.18.0-rc3+ #29
> >   Hardware name: linux,dummy-virt (DT)
> >   Call trace:
> >    dump_backtrace+0x0/0x458
> >    show_stack+0x20/0x30
> >    dump_stack+0x180/0x250
> >    panic+0x2dc/0x4ec
> >    __warn_printk+0x0/0x150
> >    report_bug+0x228/0x2d8
> >    bug_handler+0xa0/0x1a0
> >    brk_handler+0x2f0/0x568
> >    do_debug_exception+0x1bc/0x5d0
> >    el1_dbg+0x18/0x78
> >    switched_from_dl+0x454/0x608
> >    __sched_setscheduler+0x8cc/0x2018
> >    sys_sched_setattr+0x340/0x758
> >    el0_svc_naked+0x30/0x34
> > 
> > syzkaller reproducer runs a bunch of threads that constantly switch
> > between DEADLINE and NORMAL classes while interacting through futexes.
> > 
> > The splat above is caused by the fact that if a DEADLINE task is setattr
> > back to NORMAL while in non_contending state (blocked on a futex -
> > inactive timer armed), its contribution to running_bw is not removed
> > before sub_rq_bw() gets called (!task_on_rq_queued() branch) and the
> > latter sees running_bw > this_bw.
> > 
> > Fix it by removing a task contribution from running_bw if the task is
> > not queued and in non_contending state while switched to a different
> > class.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/sched/deadline.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index fbfc3f1d368a..10c7b51c0d1f 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2290,8 +2290,17 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
> >  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
> >  		task_non_contending(p);
> >  
> > -	if (!task_on_rq_queued(p))
> > +	if (!task_on_rq_queued(p)) {
> > +		/*
> > +		 * Inactive timer is armed. However, p is leaving DEADLINE and
> > +		 * might migrate away from this rq while continuing to run on
> > +		 * some other class. We need to remove its contribution from
> > +		 * this rq running_bw now, or sub_rq_bw (below) will complain.
> > +		 */
> > +		if (p->dl.dl_non_contending)
> > +			sub_running_bw(&p->dl, &rq->dl);
> >  		sub_rq_bw(&p->dl, &rq->dl);
> > +	}
> >  
> >  	/*
> >  	 * We cannot use inactive_task_timer() to invoke sub_running_bw()
> 
> Looking at this code:
> 
> 	if (!task_on_rq_queued(p)) {
> 		/*
> 		 * Inactive timer is armed. However, p is leaving DEADLINE and
> 		 * might migrate away from this rq while continuing to run on
> 		 * some other class. We need to remove its contribution from
> 		 * this rq running_bw now, or sub_rq_bw (below) will complain.
> 		 */
> 		if (p->dl.dl_non_contending)
> 			sub_running_bw(&p->dl, &rq->dl);
> 		sub_rq_bw(&p->dl, &rq->dl);
> 	}
> 
> 	/*
> 	 * We cannot use inactive_task_timer() to invoke sub_running_bw()
> 	 * at the 0-lag time, because the task could have been migrated
> 	 * while SCHED_OTHER in the meanwhile.
> 	 */
> 	if (p->dl.dl_non_contending)
> 		p->dl.dl_non_contending = 0;
> 
> Question. Is the "dl_non_contending" only able to be set
> if !task_on_rq_queued(p) is true? In that case, we could just clear it
> in the first if block.

Code right before the if block does

	if (task_on_rq_queued(p) && p->dl.dl_runtime)
		task_non_contending(p);

So we can end up with dl_non_contending being set even if task_on_rq_
queued(p) is true.

> If it's not true, I would think the subtraction
> is needed regardless.

And if we do sub_running_bw unconditionally we might end up subtracting
twice if inactive timer fired (resetting dl_non_contending) before we
end up here, no?

Thanks,

- Juri
