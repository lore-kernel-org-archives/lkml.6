Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB0CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5CF2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bhhy0td9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfBELVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:21:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfBELVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JfHCyDcIIpAyWnnUH9D8vSoiA3ztjM/YIuU+gZI/cZs=; b=Bhhy0td9CcBSF7kB+aMJl8MPc
        HcexEmTmU0Tz6s8EmUq0MdqGN0ixL2R76j9yne+ALm6gQ7EnOIv4NxsPMRr/PbXNBvy2iI7GEJbT2
        D0fzs5LhOBRbf8Zj9lJSdx38B0XOBq95wknvCLncIE8YKIewwVTs24w5CYVGO0ENW++Fi7s+gLlnM
        eAVfkalu1cKXMTWzCwzus2ockOAl1Q3eJGXjQaagOjelTCUwtuL3gP20tpinJBltYo/jjqB7prMmf
        cABfPjb+RTPCRLFjK6vTN7AgKV5nloFSy7C/7EwHwB8PLgvIHAg2+Zq0Z9D4GVApStO1fgcI3jIw4
        uWSpLphJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqyma-000514-3Y; Tue, 05 Feb 2019 11:20:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44EDE2029F1D6; Tue,  5 Feb 2019 12:20:49 +0100 (CET)
Date:   Tue, 5 Feb 2019 12:20:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 4/5] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20190205112049.GO17528@hirez.programming.kicks-ass.net>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190117084739.17078-5-juri.lelli@redhat.com>
 <20190204121029.GD17550@hirez.programming.kicks-ass.net>
 <20190205095143.GG30905@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205095143.GG30905@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:51:43AM +0100, Juri Lelli wrote:
> On 04/02/19 13:10, Peter Zijlstra wrote:
> > On Thu, Jan 17, 2019 at 09:47:38AM +0100, Juri Lelli wrote:
> > > No synchronisation mechanism exists between the cpuset subsystem and calls
> > > to function __sched_setscheduler(). As such, it is possible that new root
> > > domains are created on the cpuset side while a deadline acceptance test
> > > is carried out in __sched_setscheduler(), leading to a potential oversell
> > > of CPU bandwidth.
> > > 
> > > Grab callback_lock from core scheduler, so to prevent situations such as
> > > the one described above from happening.
> > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index f5263383170e..d928a42b8852 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4224,6 +4224,13 @@ static int __sched_setscheduler(struct task_struct *p,
> > >  	rq = task_rq_lock(p, &rf);
> > >  	update_rq_clock(rq);
> > >  
> > > +	/*
> > > +	 * Make sure we don't race with the cpuset subsystem where root
> > > +	 * domains can be rebuilt or modified while operations like DL
> > > +	 * admission checks are carried out.
> > > +	 */
> > > +	cpuset_read_only_lock();
> > > +
> > >  	/*
> > >  	 * Changing the policy of the stop threads its a very bad idea:
> > >  	 */
> > > @@ -4285,6 +4292,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > >  	/* Re-check policy now with rq lock held: */
> > >  	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
> > >  		policy = oldpolicy = -1;
> > > +		cpuset_read_only_unlock();
> > >  		task_rq_unlock(rq, p, &rf);
> > >  		goto recheck;
> > >  	}
> > > @@ -4342,6 +4350,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > >  
> > >  	/* Avoid rq from going away on us: */
> > >  	preempt_disable();
> > > +	cpuset_read_only_unlock();
> > >  	task_rq_unlock(rq, p, &rf);
> > >  
> > >  	if (pi)
> > > @@ -4354,6 +4363,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > >  	return 0;
> > >  
> > >  unlock:
> > > +	cpuset_read_only_unlock();
> > >  	task_rq_unlock(rq, p, &rf);
> > >  	return retval;
> > >  }
> > 
> > Why take callback_lock inside rq->lock and not the other way around?
> > AFAICT there is no pre-existing order so we can pick one here.
> 
> I dediced to go for this order because if we do the other way around
> grabbing callback_lock should have to also disable irqs, no? And I
> didn't want to modify task_rq_lock; or at least this approach seemed
> less intrusive code-wide.

Ah, but this way around we add the wait-time of callback_lock to
rq_lock, which seems undesirable because rq_lock is a far hotter lock in
general, right?
