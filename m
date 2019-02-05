Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7230C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD052080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfBELtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:49:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55980 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfBELtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:49:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so3249943wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 03:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gDZxDFSfWTkr+lS6LUYByDQNMKy0cJHL0A7+onN9kQ=;
        b=GtKAIBv/DR+HjXRGWY50xVFXXcgUD6h52DtE1VkGcxKAUjHrUqE8jYsHlTigonq9Uz
         8kL6q6Br3trdyZxKLG0ToELsyKSDA6YNQLqO1qQ9tluSGkiJRCyTNjAuPfrLGR82lhak
         Y2mB0jiatbAWEUgu0K1P+jji+UATaJzClxrWQT8rJTVHPojbsJcNo/m3HyrJTQjAWW6N
         IUgZRQCEYYYTXBEpNiqiLnrd5P3r+Ni/fpL2/9HmEiJe4MgDY/G2h71VjCJNuhYGSovg
         Vc9XU5jX9CAGyoIWnoKsIIcEe7b/1t/d/7hysVh4gYqYAUqPvUC0v9Qx+K2J39RBaICo
         HJug==
X-Gm-Message-State: AHQUAubUBTZ8EFXVov1XwrulMzR+jJt3DZrIT26CkE/sdFu3ba2M89gu
        gsTnTkW0LGKswmQ3JjEmQ2cnBA==
X-Google-Smtp-Source: AHgI3IYm4FaifIHrb/iw/TnzrmqPWj5mL6lSkjvLDNWg6zBEanNVruF7EeAdQS8DQrAcb3yLaAcm4g==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr3167734wmj.93.1549367355373;
        Tue, 05 Feb 2019 03:49:15 -0800 (PST)
Received: from localhost.localdomain ([151.15.206.34])
        by smtp.gmail.com with ESMTPSA id a4sm4303105wmm.22.2019.02.05.03.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 03:49:14 -0800 (PST)
Date:   Tue, 5 Feb 2019 12:49:11 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 4/5] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20190205114911.GH30905@localhost.localdomain>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190117084739.17078-5-juri.lelli@redhat.com>
 <20190204121029.GD17550@hirez.programming.kicks-ass.net>
 <20190205095143.GG30905@localhost.localdomain>
 <20190205112049.GO17528@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205112049.GO17528@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/19 12:20, Peter Zijlstra wrote:
> On Tue, Feb 05, 2019 at 10:51:43AM +0100, Juri Lelli wrote:
> > On 04/02/19 13:10, Peter Zijlstra wrote:
> > > On Thu, Jan 17, 2019 at 09:47:38AM +0100, Juri Lelli wrote:
> > > > No synchronisation mechanism exists between the cpuset subsystem and calls
> > > > to function __sched_setscheduler(). As such, it is possible that new root
> > > > domains are created on the cpuset side while a deadline acceptance test
> > > > is carried out in __sched_setscheduler(), leading to a potential oversell
> > > > of CPU bandwidth.
> > > > 
> > > > Grab callback_lock from core scheduler, so to prevent situations such as
> > > > the one described above from happening.
> > > 
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index f5263383170e..d928a42b8852 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -4224,6 +4224,13 @@ static int __sched_setscheduler(struct task_struct *p,
> > > >  	rq = task_rq_lock(p, &rf);
> > > >  	update_rq_clock(rq);
> > > >  
> > > > +	/*
> > > > +	 * Make sure we don't race with the cpuset subsystem where root
> > > > +	 * domains can be rebuilt or modified while operations like DL
> > > > +	 * admission checks are carried out.
> > > > +	 */
> > > > +	cpuset_read_only_lock();
> > > > +
> > > >  	/*
> > > >  	 * Changing the policy of the stop threads its a very bad idea:
> > > >  	 */
> > > > @@ -4285,6 +4292,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > > >  	/* Re-check policy now with rq lock held: */
> > > >  	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
> > > >  		policy = oldpolicy = -1;
> > > > +		cpuset_read_only_unlock();
> > > >  		task_rq_unlock(rq, p, &rf);
> > > >  		goto recheck;
> > > >  	}
> > > > @@ -4342,6 +4350,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > > >  
> > > >  	/* Avoid rq from going away on us: */
> > > >  	preempt_disable();
> > > > +	cpuset_read_only_unlock();
> > > >  	task_rq_unlock(rq, p, &rf);
> > > >  
> > > >  	if (pi)
> > > > @@ -4354,6 +4363,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > > >  	return 0;
> > > >  
> > > >  unlock:
> > > > +	cpuset_read_only_unlock();
> > > >  	task_rq_unlock(rq, p, &rf);
> > > >  	return retval;
> > > >  }
> > > 
> > > Why take callback_lock inside rq->lock and not the other way around?
> > > AFAICT there is no pre-existing order so we can pick one here.
> > 
> > I dediced to go for this order because if we do the other way around
> > grabbing callback_lock should have to also disable irqs, no? And I
> > didn't want to modify task_rq_lock; or at least this approach seemed
> > less intrusive code-wide.
> 
> Ah, but this way around we add the wait-time of callback_lock to
> rq_lock, which seems undesirable because rq_lock is a far hotter lock in
> general, right?

Eh, indeed. OK, I'll work on it.
