Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92611C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653C82184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I9aCRh9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAWS7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:59:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAWS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dgfqcSanb6lp9vXdmjSxOrnt6Pt+KGuiUR8MqoSxjtE=; b=I9aCRh9NxXEkgaarWs8JkHsB2
        TMXVjUSy/Hy9/cXLp1VbmmzrZe1f5hkReu9jj0zg2LBmSSyjGnk0yngC3grF4incfpJpTJyKdIGoC
        lqYlLWvPM6ZwYYg49Ue10/qM+HZsduT+3xFZSH5bITQ4Z9J8qoMTE8TsVhlj6OZZqJxCZTKEIA/+Y
        onAhUUGqPzCZZu+qp5tEiXcEOorfzECaY/xg4lEA6zaWdnef7LObxH+Y/ymDjVjO8gJ8l+LEpliAF
        GsNitQuAT5I8kFwQXvYa5sxbBgXfHMQ8FzIk/omNNI46UI0IlmvwxkAduLNKAGPCZJKnfgdFIYBaL
        Gwoxb553w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmNkV-0000w4-0X; Wed, 23 Jan 2019 18:59:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BD1C201EC16E; Wed, 23 Jan 2019 19:59:40 +0100 (CET)
Date:   Wed, 23 Jan 2019 19:59:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 05/16] sched/core: uclamp: Update CPU's refcount on
 clamp changes
Message-ID: <20190123185940.GF17749@hirez.programming.kicks-ass.net>
References: <20190121153308.GL27931@hirez.programming.kicks-ass.net>
 <20190121154412.fak2t2iquj3aixtu@e110439-lin>
 <20190122093704.GM27931@hirez.programming.kicks-ass.net>
 <20190122104305.6vjx37muqsxm536t@e110439-lin>
 <20190122132817.GG13777@hirez.programming.kicks-ass.net>
 <20190122140115.twtx646vewm757ca@e110439-lin>
 <20190122145742.GQ27931@hirez.programming.kicks-ass.net>
 <20190122153315.dhjl67sgpu74hmqv@e110439-lin>
 <20190123091634.GT27931@hirez.programming.kicks-ass.net>
 <20190123141426.5samtr4hl6okdypu@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123141426.5samtr4hl6okdypu@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:14:26PM +0000, Patrick Bellasi wrote:

> > > Consider also that the uclamp_task_update_active() added by this patch
> > > not only has lower overhead but it will be use also by cgroups where
> > > we want to force update all the tasks on a cgroup's clamp change.
> > 
> > I haven't gotten that far; but I would prefer not to have two different
> > 'change' paths in __sched_setscheduler().
> 
> Yes, I agree that two paths in __sched_setscheduler() could be
> confusing. Still we have to consider that here we are adding
> "not class specific" attributes.

But that change thing is not class specific; the whole:


	rq = task_rq_lock(p, &rf);
	queued = task_on_rq_queued(p);
	running = task_current(rq, p);
	if (queued)
		dequeue_task(rq, p, queue_flags);
	if (running)
		put_prev_task(rq, p);


	/* @p is in it's invariant state; frob it's state */


	if (queued)
		enqueue_task(rq, p, queue_flags);
	if (running)
		set_curr_task(rq, p);
	task_rq_unlock(rq, p, &rf);


pattern is all over the place; it is just because C sucks that that
isn't more explicitly shared (do_set_cpus_allowed(), rt_mutex_setprio(),
set_user_nice(), __sched_setscheduler(), sched_setnuma(),
sched_move_task()).

This is _the_ pattern for changing state and is not class specific at
all.

