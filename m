Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD492084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UU050Tsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfA3NG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:06:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbfA3NGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xsibYzsw288/jaLgGlTVWV8LqzdWnUIW4Uoi17cICBo=; b=UU050Tsmo+qaY/nJ3p4gWp0CD
        gULX/LQchx4S+cTEsXWroBmIm4JKChbLGHUIyTTZ+56OtwnoyNtHoujm1+X80cJUBu/tRNOYyEoLw
        EF5hTiMU7NO/4usauRSbBeddLWzrnrQqg/kSVIKUGrxuTSpSFYhz8Lu+ErCOZ4TvqIpNrdeCkIkvf
        W9N4CJx84Tezl79ogRo/nobs+JCrJtSCvlCcEwB6yEPjgKMIoOnG9++M83IPElDOJRVwmVnG/XFd9
        FfHGnLdSbECnCXqfcnu6/ivjUGSACyYT7bkdqrBvRPTlcef8oDx+JgWF4YqTOXBRfESwarC281KCA
        vnICCTxag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gopZN-0001M0-Hk; Wed, 30 Jan 2019 13:06:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5455C21408885; Wed, 30 Jan 2019 14:06:20 +0100 (CET)
Date:   Wed, 30 Jan 2019 14:06:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
        sargun@sargun.me
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Message-ID: <20190130130620.GB3103@hirez.programming.kicks-ass.net>
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130130410.GG2278@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130130410.GG2278@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:04:10PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 30, 2019 at 06:22:47AM +0100, Vincent Guittot wrote:
> 
> > The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
> > it will walk down to root the 1st time a cfs_rq is used and we will finish
> > to add either a cfs_rq without parent or a cfs_rq with a parent that is
> > already on the list. But this is not always true in presence of throttling.
> > Because a cfs_rq can be throttled even if it has never been used but other CPUs
> > of the cgroup have already used all the bandwdith, we are not sure to go down to
> > the root and add all cfs_rq in the list.
> > 
> > Ensure that all cfs_rq will be added in the list even if they are throttled.
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e2ff4b6..826fbe5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -352,6 +352,20 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  	}
> >  }
> >  
> > +static inline void list_add_branch_cfs_rq(struct sched_entity *se, struct rq *rq)
> > +{
> > +	struct cfs_rq *cfs_rq;
> > +
> > +	for_each_sched_entity(se) {
> > +		cfs_rq = cfs_rq_of(se);
> > +		list_add_leaf_cfs_rq(cfs_rq);
> > +
> > +		/* If parent is already in the list, we can stop */
> > +		if (rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
> > +			break;
> > +	}
> > +}
> > +
> >  /* Iterate through all leaf cfs_rq's on a runqueue: */
> >  #define for_each_leaf_cfs_rq(rq, cfs_rq) \
> >  	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
> 
> > @@ -5179,6 +5197,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  
> >  	}
> >  
> > +	/* Ensure that all cfs_rq have been added to the list */
> > +	list_add_branch_cfs_rq(se, rq);
> > +
> >  	hrtick_update(rq);
> >  }
> 
> So I don't much like this; at all. But maybe I misunderstand, this is
> somewhat tricky stuff and I've not looked at it in a while.
> 
> So per normal we do:
> 
> 	enqueue_task_fair()
> 	  for_each_sched_entity() {
> 	    if (se->on_rq)
> 	      break;
> 	    enqueue_entity()
> 	      list_add_leaf_cfs_rq();
> 	  }
> 
> This ensures that all parents are already enqueued, right? because this
> is what enqueues those parents.
> 
> And in this case you add an unconditional second
> for_each_sched_entity(); even though it is completely redundant, afaict.

Ah, it doesn't do a second iteration; it continues where the previous
two left off.

Still, why isn't this in unthrottle?

> The problem seems to stem from the whole throttled crud; which (also)
> breaks the above enqueue loop on throttle state, and there the parent can
> go missing.
> 
> So why doesn't this live in unthrottle_cfs_rq() ?
> 
