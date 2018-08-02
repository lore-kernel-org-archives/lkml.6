Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FAEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2882208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2882208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeHBEev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeHBEev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:34:51 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91226208A3;
        Thu,  2 Aug 2018 02:45:57 +0000 (UTC)
Date:   Wed, 1 Aug 2018 22:45:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH V2] sched/deadline: Update rq_clock of later_rq when
 pushing a task
Message-ID: <20180801224556.2d0b9342@vmware.local.home>
In-Reply-To: <12b65bbb-e82a-7fa5-1225-5047096d48f8@virtuozzo.com>
References: <52d533238eb69a09fbf40b34765be312e0fd0296.1531490101.git.bristot@redhat.com>
        <12b65bbb-e82a-7fa5-1225-5047096d48f8@virtuozzo.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 13:45:21 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2090,8 +2090,16 @@ static int push_dl_task(struct rq *rq)
> >  	sub_rq_bw(&next_task->dl, &rq->dl);
> >  	set_task_cpu(next_task, later_rq->cpu);
> >  	add_rq_bw(&next_task->dl, &later_rq->dl);
> > +
> > +	/*
> > +	 * Update the later_rq clock here, because the clock is used
> > +	 * by the cpufreq_update_util() inside __add_running_bw().
> > +	 * Then, set ENQUEUE_NOCLOCK flag to avoid updating the rq_clock
> > +	 * again in the activate_task()->enqueue_task().  
> 
> Is the second sentence really needed? It seems everybody knows, what NOCLOCK
> flag does, and we does not have to paraphrase this in every place it's used :)

I would keep the mention, but change the comment:

	/*
	 * Update the later_rq clock before calling add_running_bw()
	 * because the clock is used by cpufreq_update_util() that is
	 * inside __add_running_bw(). As the later_rq clock is already
	 * updated, we need to set ENQUEUE_NOCLOCK to prevent
	 * activate_task() from updating it again.
	 */
Other than that...

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> 
> > +	 */
> > +	update_rq_clock(later_rq);
> >  	add_running_bw(&next_task->dl, &later_rq->dl);
> > -	activate_task(later_rq, next_task, 0);
> > +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> >  	ret = 1;
> >  
> >  	resched_curr(later_rq);
