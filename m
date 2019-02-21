Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746682083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lO4Z6pec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfBUQmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:42:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38380 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K+2GhtwjVhbgmHQVTJ8KD5yadggXH16mNhTyw8yZvog=; b=lO4Z6pecNqbbm67zklDg5SMXt
        kZlZA2vTp+uyumU/XijVxCoEaSly9BaX4flnAzQ275qMhizL4sBp39USqzOA/l4Fwv5CuSohk6HhA
        KqI9wZJfkI0XpqKAtT2meT737SsAuOYIC53ED08A8Pj9v/jPBU5NKNr0+6m1Q8xlqyVLttuE0kxsm
        PphialuzJkZJEAJUaT08slj53EHqY2fzjimG+5upEkftN0wB62+OIXJN2DkgxwW7DoNukKw3MmvBf
        O+5zd03IjETxsWpALKAz+iHxEbYgXXx94xxoWNUcZbHJ8pf/xskuAHPZQNZSkFtDrkBbIuhM5grT2
        UKYF5ecDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwrPw-0002iK-RP; Thu, 21 Feb 2019 16:41:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E7172030EE5E; Thu, 21 Feb 2019 17:41:46 +0100 (CET)
Date:   Thu, 21 Feb 2019 17:41:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com
Subject: Re: [RFC][PATCH 15/16] sched: Trivial forced-newidle balancer
Message-ID: <20190221164146.GV32494@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.796920915@infradead.org>
 <d7a408c0-b86a-da56-5440-d7cb380708c6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a408c0-b86a-da56-5440-d7cb380708c6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:19:46PM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 18/02/2019 16:56, Peter Zijlstra wrote:
> [...]
> > +static bool try_steal_cookie(int this, int that)
> > +{
> > +	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
> > +	struct task_struct *p;
> > +	unsigned long cookie;
> > +	bool success = false;
> > +
> > +	local_irq_disable();
> > +	double_rq_lock(dst, src);
> > +
> > +	cookie = dst->core->core_cookie;
> > +	if (!cookie)
> > +		goto unlock;
> > +
> > +	if (dst->curr != dst->idle)
> > +		goto unlock;
> > +
> > +	p = sched_core_find(src, cookie);
> > +	if (p == src->idle)
> > +		goto unlock;
> > +
> > +	do {
> > +		if (p == src->core_pick || p == src->curr)
> > +			goto next;
> > +
> > +		if (!cpumask_test_cpu(this, &p->cpus_allowed))
> > +			goto next;
> > +
> > +		if (p->core_occupation > dst->idle->core_occupation)
> > +			goto next;
> > +
> 
> IIUC, we're trying to find/steal tasks matching the core_cookie from other
> rqs because dst has been cookie-forced-idle.
> 
> If the p we find isn't running, what's the meaning of core_occupation?
> I would have expected it to be 0, but we don't seem to be clearing it when
> resetting the state in pick_next_task().

Indeed. We preserve the occupation from the last time around; it's not
perfect but its better than nothing.

Consider there's two groups; and we just happen to run the other group.
Then our occopation, being what it was last, is still accurate. When
next we run, we'll again get that many siblings together.

> If it is running, we prevent the stealing if the core it's on is running
> more matching tasks than the core of the pulling rq. It feels to me as if
> that's a balancing tweak to try to cram as many matching tasks as possible
> in a single core, so to me this reads as "don't steal my tasks if I'm
> running more than you are, but I will steal tasks from you if I'm given
> the chance". Is that correct?

Correct, otherwise an SMT4 with 5 tasks could end up ping-ponging the
one task forever.

Note that a further condition a little up the callchain from here only
does this stealing if the thread was forced-idle -- ie. it had something
to run anyway. So under the condition where there simple aren't enough
tasks to keep all siblings busy, we'll not compact just cause.
