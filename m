Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C4820661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t5+6jMA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C4820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeHaTSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:18:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbeHaTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x7XKefPp0yZEPHew0hkE/Su8saN2whDlOBe1AShJvo4=; b=t5+6jMA8NFqETp1xVdFrNtNZy
        wYpVTQOiZ4RPW7wapplGryS5VlTE88S12gzQZrv5t2D/OBEz/lQ9bXPp3ysNJhswoVR8+Z5F2mfYt
        Hw+gXYtKnSsknFjVrwT7+guZQxL/tu+e/NmlJFndTGMWbVpJX6s9WkKvEtU0wBGGU5f1/HEC8LS0C
        5rYv8jRoM26WZwDelrMgC0awL2KqhPrCB9WgFvJ8d7jptUZcX4SseegJ5pzX5TNqZAydG609jZUO8
        7GL5zY9br7yqgouqyemrXE8zx7cQhBgclTJoCSjAWF+xHxMNyMdKwJPICMVUc+mXcF4XqBa3L9XGB
        zkr5MzzxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvl4b-0004d8-9p; Fri, 31 Aug 2018 15:10:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D48582024D72E; Fri, 31 Aug 2018 17:10:49 +0200 (CEST)
Date:   Fri, 31 Aug 2018 17:10:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/pelt: fix update_blocked_averages() for dl and
 rt
Message-ID: <20180831151049.GB24142@hirez.programming.kicks-ass.net>
References: <1535727379-17133-1-git-send-email-vincent.guittot@linaro.org>
 <20180831150721.GP24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831150721.GP24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:07:21PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 31, 2018 at 04:56:19PM +0200, Vincent Guittot wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 309c93f..bc1de21 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7262,6 +7262,7 @@ static void update_blocked_averages(int cpu)
> >  {
> >  	struct rq *rq = cpu_rq(cpu);
> >  	struct cfs_rq *cfs_rq, *pos;
> > +	const struct sched_class *curr_class = rq->curr->sched_class;
> >  	struct rq_flags rf;
> >  	bool done = true;
> 
> Can you do me a v3 where you move that rq->curr dereference under the
> rq->lock?
> 
> I _think_ it is actually OK, but it is really dodgy. Moving it under
> rq->lock makes it obvious correct.

Ah, it is not correct. I only checked to see if preemption was disabled
and if we're calling this on the local CPU (which I think is true),
which would guarantee rq->curr's existence.

But that is not sufficient to make rq->curr->sched_class stable.

> > @@ -7298,8 +7299,8 @@ static void update_blocked_averages(int cpu)
> >  		if (cfs_rq_has_blocked(cfs_rq))
> >  			done = false;
> >  	}
> > -	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> > -	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> > +	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
> > +	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
> >  	update_irq_load_avg(rq, 0);
> >  	/* Don't need periodic decay once load/util_avg are null */
> >  	if (others_have_blocked(rq))
