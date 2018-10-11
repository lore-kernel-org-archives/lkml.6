Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BCDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8573020652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="afFx6zYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8573020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeJKUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:20:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d7kUvClJk9a1qLmbDb6z/rc/iwaRRwzNOJEyYatQmeM=; b=afFx6zYwhx3ArFHtf8gD6120F
        IGfBmBzRviNZmZvNiju4sZatyZU3roZroReCIZNYmtpw6LVxsCJbxcD0Hz3UryGzmdwXdZ6YcF2Tw
        N1YOHi5K6NfMcwXMMIMJwHD7CrCV36g6hpbj313DDuFK9GHLwU3VjpsG2ES+RqiNXZDAerdYFzR9m
        l9xPkWSlFqP5Vpz+YtQ5stqLMjUo0xneg7a38nOg3ADj02lVJ+IuQyQUZlyUco2R7jMcid5P5mP7k
        jAFyWzVRWSpCwjOKQgix44GJRwEBw/FeboQpXZupy+5XMcCIlkGnM7VMcE76ezLbQKa/d3q7WgOzJ
        IYt6TKqlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAaT2-0004Ai-29; Thu, 11 Oct 2018 12:53:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC85020298568; Thu, 11 Oct 2018 14:53:25 +0200 (CEST)
Date:   Thu, 11 Oct 2018 14:53:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Message-ID: <20181011125325.GA9867@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-6-juri.lelli@redhat.com>
 <20181010131048.54afd1b6@luca64>
 <20181011123448.GS9130@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011123448.GS9130@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 02:34:48PM +0200, Juri Lelli wrote:
> Hi Luca,
> 
> On 10/10/18 13:10, luca abeni wrote:
> > Hi,
> > 
> > On Tue,  9 Oct 2018 11:24:31 +0200
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> > [...]
> > > +migrate_task:
> > [...]
> > > +	put_prev_task(rq, next);
> > > +	if (rq->curr != rq->idle) {
> > > +		rq->proxy = rq->idle;
> > > +		set_tsk_need_resched(rq->idle);
> > > +		/*
> > > +		 * XXX [juril] don't we still need to migrate @next
> > > to
> > > +		 * @owner's CPU?
> > > +		 */
> > > +		return rq->idle;
> > > +	}
> > 
> > If I understand well, this code ends up migrating the task only if the
> > CPU was previously idle? (scheduling the idle task if the CPU was not
> > previously idle)
> > 
> > Out of curiosity (I admit this is my ignorance), why is this needed?
> > If I understand well, after scheduling the idle task the scheduler will
> > be invoked again (because of the set_tsk_need_resched(rq->idle)) but I
> > do not understand why it is not possible to migrate task "p" immediately
> > (I would just check "rq->curr != p", to avoid migrating the currently
> > scheduled task).
> 
> As the comment suggests, I was also puzzled by this bit.
> 
> I'd be inclined to agree with you, it seems that the only case in which
> we want to "temporarily" schedule the idle task is if the proxy was
> executing (so it just blocked on the mutex and being scheduled out).
> 
> If it wasn't we should be able to let the current "curr" continue
> executing, in this case returning it as next will mean that schedule
> takes the else branch and there isn't an actual context switch.
> 
> > > +	rq->proxy = &fake_task;
> 
> [...]
> 
> We can maybe also rq->proxy = rq->curr and return rq->curr in such a
> case, instead of the below?
> 
> > > +	return NULL; /* Retry task selection on _this_ CPU. */
> 
> Peter, what are we missing? :-)

I think it was the safe and simple choice; note that we're not migrating
just a single @p, but a whole chain of @p. rq->curr must not be any of the
possible @p's. rq->idle, is per definition not one of the @p's.

Does that make sense?
