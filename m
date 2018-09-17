Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61759ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040AB2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYQvA61K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040AB2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeIQPPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:15:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeIQPPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=06mVUdqy5UfXhscG7NiOdqeAwgjiipJLzpNlSMklW30=; b=kYQvA61KBF6Esh/CvIkqj1gwmu
        I6kuDO2u3LidUZ0kR3s4W86LMyNxf+GHxVw1DSkDSu42kIAgDbwVQaCfjg0xz5JnAEYxNaBlzxlHG
        tn/yAhSezxpUW0z8cFMpVnmy2AAxQJ2J3rfchmoa8jkbPggl1TR6gIvnRMj8Exnin1q7ldH+IJWdO
        Qr2g4a3w/cMENnxMz5KCBCDz9WYrF8VukxllfTtksmkWeR44jVbn89ejzzg0vtHMYoSh0mUCTvmwQ
        Q1PzTyvIJ/ZM5wpt8psNUnPm9zf7yeZTH/7aUglhUUjuSpGFFS3ySJxndPHNQfTS7aI09xyarwIOd
        mN43U8Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1q98-0003hk-PI; Mon, 17 Sep 2018 09:48:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3AF02058A20A; Mon, 17 Sep 2018 11:48:44 +0200 (CEST)
Date:   Mon, 17 Sep 2018 11:48:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
Message-ID: <20180917094844.GR24124@hirez.programming.kicks-ass.net>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 10:48:20AM +0200, Jan H. Schönherr wrote:
> On 09/14/2018 06:25 PM, Jan H. Schönherr wrote:
> > On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
> >>
> >> There are known scalability problems with the existing cgroup muck; you
> >> just made things a ton worse. The existing cgroup overhead is
> >> significant, you also made that many times worse.
> >>
> >> The cgroup stuff needs cleanups and optimization, not this.
> 
> [...]
> 
> > With respect to the need of cleanups and optimizations: I agree, that
> > task groups are a bit messy. For example, here's my current wish list
> > off the top of my head:
> > 
> > a) lazy scheduler operations; for example: when dequeuing a task, don't bother
> >    walking up the task group hierarchy to dequeue all the SEs -- do it lazily
> >    when encountering an empty CFS RQ during picking when we hold the lock anyway.

That sounds like it will wreck the runnable_weight accounting. Although,
if, as you write below, we do away with the hierarchical runqueues, that
isn't in fact needed anymore I think.

Still, even without runnable_weight, I suspect we need the 'runnable'
state, even for the other accounting.

> > b) ability to move CFS RQs between CPUs: someone changed the affinity of
> >    a cpuset? No problem, just attach the runqueue with all the tasks elsewhere.
> >    No need to touch each and every task.

Can't do that, tasks might have individual constraints that are tighter
than the cpuset. Also, changing affinities isn't really a hot path, so
who cares.

> > c) light-weight task groups: don't allocate a runqueue for every CPU in the
> >    system, when it is known that tasks in the task group will only ever run
> >    on at most two CPUs, or so. (And while there is of course a use case for
> >    VMs in this, another class of use cases are auxiliary tasks, see eg, [1-5].)

I have yet to go over your earlier email; but no. The scheduler is very
much per-cpu. And as I mentioned earlier, CFS as is doesn't work right
if you share the runqueue between multiple CPUs (and 'fixing' that is
non trivial).

> > Is this the level of optimizations, you're thinking about? Or do you want
> > to throw away the whole nested CFS RQ experience in the code?
> 
> I guess, it would be possible to flatten the task group hierarchy, that is usually
> created when nesting cgroups. That is, enqueue task group SEs always within the
> root task group.
> 
> That should take away much of the (runtime-)overhead, no?

Yes, Rik was going to look at trying this. Put all the tasks in the root
rq and adjust the vtime calculations. Facebook is seeing significant
overhead from cpu-cgroup and has to disable it because of that on at
least part of their setup IIUC.

> The calculation of shares would need to be a different kind of complex than it is
> now. But that might be manageable.

That is the hope; indeed. We'll still need to create the hierarchy for
accounting purposes, but it can be a smaller/simpler data structure.

So the weight computation would be the normalized product of the parents
etc.. and since PELT only updates the values on ~1ms scale, we can keep
a cache of the product -- that is, we don't have to recompute that
product and walk the hierarchy all the time either.

> CFS bandwidth control would also need to change significantly as we would now
> have to dequeue/enqueue nested cgroups below a throttled/unthrottled hierarchy.
> Unless *those* task groups don't participate in this flattening.

Right, so the whole bandwidth thing becomes a pain; the simplest
solution is to detect the throttle at task-pick time, dequeue and try
again. But that is indeed quite horrible.

I'm not quite sure how this will play out.

Anyway, if we pull off this flattening feat, then you can no longer use
the hierarchy for this co-scheduling stuff.

Now, let me go read your earlier email and reply to that (in parts).
