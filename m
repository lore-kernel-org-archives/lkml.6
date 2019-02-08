Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C87DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED50720823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fa9zqut8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfBHQa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:30:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53524 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfBHQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m2Dct25zTnkxHlIXfUO7wxkzCiq1g/YByUe4e+kSzxA=; b=fa9zqut8SiseghIKmDJ+gdW8L
        7x6NPoGDmx+ZRlNnNv+8rUXz6ReDR55BnHm3cTlgsUjrHzmA0tXq5f8QdDQl8m9cTUizrNBqNVKqJ
        LXKgmgFpUYR6LWS5ifni3z4EVWJBmVZKpS5Tx5f3mM8tSCUJJBzfFDufKRWdknf+njjYJobyAhj7E
        GF5d5SA8aY1GJpla1ujfDQkTsdxLf5FHqbYVR22686UoOmuRsbdTLLQxV/TvuHOoA9KsBHUYn9VoF
        Q+scXgp3FrT6wt4vlAscrDdnrTVPnaEE+pwNn0k8cdp+6sprREYRjpvUANkxFxjPG3Z5ewyyMpCwg
        id9Jvo6rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs938-000540-Rr; Fri, 08 Feb 2019 16:30:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D87721441086; Fri,  8 Feb 2019 17:30:45 +0100 (CET)
Date:   Fri, 8 Feb 2019 17:30:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] sched/fair: optimization of update_blocked_averages()
Message-ID: <20190208163045.GD32494@hirez.programming.kicks-ass.net>
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
 <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
 <20190208154009.GK32511@hirez.programming.kicks-ass.net>
 <CAKfTPtB9EzuHQ+K56EbDSUV6ifkpj2OR12tXRBN6=NQDwC2OMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB9EzuHQ+K56EbDSUV6ifkpj2OR12tXRBN6=NQDwC2OMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:44:53PM +0100, Vincent Guittot wrote:
> On Fri, 8 Feb 2019 at 16:40, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > Argh head hurts!!
> >
> > On Wed, Feb 06, 2019 at 05:14:21PM +0100, Vincent Guittot wrote:
> > > @@ -4438,6 +4450,10 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
> > >               /* adjust cfs_rq_clock_task() */
> > >               cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
> > >                                            cfs_rq->throttled_clock_task;
> > > +
> > > +             /* Add cfs_rq with already running entity in the list */
> > > +             if (cfs_rq->nr_running >= 1)
> > > +                     list_add_leaf_cfs_rq(cfs_rq);
> > >       }
> > >
> > >       return 0;
> >
> > Do we want the below to go with the above change?
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 38d4669aa2ef..0bd80a891025 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4536,6 +4536,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >         /* update hierarchical throttle state */
> >         walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
> >
> > +       assert_list_leaf_cfs_rq(rq);
> > +
> 
> Good point but this should go after the for_each_sched_entity() loop

Indeed, but that loop does enqueue and can throttle again, should that
not also get that additinoal list_add_leaf_cfs_rq() loop we added to
enqueue_task_fair() to finish the add?
