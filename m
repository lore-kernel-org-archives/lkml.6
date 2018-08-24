Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96975C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF73208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dVAmzhFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF73208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeHXNPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:15:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeHXNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mHjfe6ePOzeu/zAZ2YTDEOCQl2tp6RrHIKyH1ePFm74=; b=dVAmzhFA0Sfmj6BIjFHym8e2h
        hPC6DsYPc5SpnePuID1udAScniOl67BEkoLg6nUcWBJEscOo5zQZE/A4o2EkA5h1VSX2H0zI5hPpN
        3blC/Kh8d3crd4/0WWh/Ua7fguwjtX3lsiNcOrK3LTxqOtoNtZiICQusDoaP3lj6nKaHE/g2k9AXI
        lBUPebwrvXVeKWymzfSKsUR1HpRZZIuoNVSu0219R/GVWXIHej9w1CSP6oHCJAncUEo3tYuqp6hVh
        y6XyzAvQhWe8uN/cSyh6dRx5BdwvYOxtCJIrwJAHXFhrZM9UR4cpr0u0UbhwP4yxXe4dbSrO0esm1
        8wkfNMahQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ft8SK-0006vc-I9; Fri, 24 Aug 2018 09:35:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2363E2024D70A; Fri, 24 Aug 2018 11:32:27 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:32:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miguel de Dios <migueldedios@google.com>
Cc:     Steve Muckle <smuckle@google.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching
 from fair
Message-ID: <20180824093227.GN24124@hirez.programming.kicks-ass.net>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 04:54:25PM -0700, Miguel de Dios wrote:
> On 08/17/2018 11:27 AM, Steve Muckle wrote:
> > From: John Dias <joaodias@google.com>
> > 
> > When rt_mutex_setprio changes a task's scheduling class to RT,
> > we're seeing cases where the task's vruntime is not updated
> > correctly upon return to the fair class.
> > Specifically, the following is being observed:
> > - task is deactivated while still in the fair class
> > - task is boosted to RT via rt_mutex_setprio, which changes
> >    the task to RT and calls check_class_changed.
> > - check_class_changed leads to detach_task_cfs_rq, at which point
> >    the vruntime_normalized check sees that the task's state is TASK_WAKING,
> >    which results in skipping the subtraction of the rq's min_vruntime
> >    from the task's vruntime
> > - later, when the prio is deboosted and the task is moved back
> >    to the fair class, the fair rq's min_vruntime is added to
> >    the task's vruntime, even though it wasn't subtracted earlier.
> > The immediate result is inflation of the task's vruntime, giving
> > it lower priority (starving it if there's enough available work).
> > The longer-term effect is inflation of all vruntimes because the
> > task's vruntime becomes the rq's min_vruntime when the higher
> > priority tasks go idle. That leads to a vicious cycle, where
> > the vruntime inflation repeatedly doubled.
> > 
> > The change here is to detect when vruntime_normalized is being
> > called when the task is waking but is waking in another class,
> > and to conclude that this is a case where vruntime has not
> > been normalized.
> > 
> > Signed-off-by: John Dias <joaodias@google.com>
> > Signed-off-by: Steve Muckle <smuckle@google.com>
> > ---
> >   kernel/sched/fair.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index b39fb596f6c1..14011d7929d8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
> >   	 * - A task which has been woken up by try_to_wake_up() and
> >   	 *   waiting for actually being woken up by sched_ttwu_pending().
> >   	 */
> > -	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
> > +	if (!se->sum_exec_runtime ||
> > +	    (p->state == TASK_WAKING && p->sched_class == &fair_sched_class))
> >   		return true;
> >   	return false;

> The normalization of vruntime used to exist in task_waking but it was
> removed and the normalization was moved into migrate_task_rq_fair. The
> reasoning being that task_waking_fair was only hit when a task is queued
> onto a different core and migrate_task_rq_fair should do the same work.
> 
> However, we're finding that there's one case which migrate_task_rq_fair
> doesn't hit: that being the case where rt_mutex_setprio changes a task's
> scheduling class to RT when its scheduled out. The task never hits
> migrate_task_rq_fair because it is switched to RT and migrates as an RT
> task. Because of this we're getting an unbounded addition of min_vruntime
> when the task is re-attached to the CFS runqueue when it loses the inherited
> priority. The patch above works because now the kernel specifically checks
> for this case and normalizes accordingly.
> 
> Here's the patch I was talking about:
> https://lore.kernel.org/patchwork/patch/677689/. In our testing we were
> seeing vruntimes nearly double every time after rt_mutex_setprio boosts the
> task to RT.

Bah, patchwork is such shit... how do you get to the previus patch from
there? Because I think 2/3 is the actual commit that changed things, 3/3
just cleans up a bit.

That would be commit:

  b5179ac70de8 ("sched/fair: Prepare to fix fairness problems on migration")

But I'm still somewhat confused; how would task_waking_fair() have
helped if we're already changed to a different class?


