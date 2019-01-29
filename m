Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46EDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8255820869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PDvt1m3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfA2TmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:42:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37608 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2TmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mzfWUytuN0apIsyayIdZHPWjSvD6PZE2rLTgZPTDW9E=; b=PDvt1m3H8IelaC0/SuU49Mlhg
        dZ1ApQmALboJSGagPGoAyQmcoERZbfNum7XB17tVK9pp3uook4Ru6z4ZGWFHfpv8padp9xyolKTXf
        O2LztcXoxNXZ+yrmR/LJIVvgGvTLgcuVsiMzmKi66+TchjnNe5h0GBTAmRehO0uZKXt4RDrRjbnzx
        uxIzS2tDR6nW5PqQmkmgt2qJ8+QVHiOoWIcF8gbTZMXV/1GD3mYKcMo6zl2HQ6OYuEUiHwHlah0XY
        N5nb4Btz4+bF+wi+GuX7EHVUFjE2yuLEXX/ZSBrE9v5jY1wELAJMw2S0FvZMTJhoCaG3qmy9D1BWz
        t7R9I2kKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goZGy-0006U3-El; Tue, 29 Jan 2019 19:42:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04969202C6BE7; Tue, 29 Jan 2019 20:42:14 +0100 (CET)
Date:   Tue, 29 Jan 2019 20:42:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20190129194213.GA2979@hirez.programming.kicks-ass.net>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net>
 <20181128115336.GB23094@e110439-lin>
 <20181129125348.GL2131@hirez.programming.kicks-ass.net>
 <20181129151316.GG23094@e110439-lin>
 <20190124090755.GC13536@hirez.programming.kicks-ass.net>
 <20190124140432.2kiprlxzw2cpf35f@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124140432.2kiprlxzw2cpf35f@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:04:32PM +0000, Patrick Bellasi wrote:

> > So if I'm not mistaken we then have 3 cases:
> > 
> >  1) runnable == util <= capacity
> > 
> >     no contention, idle
> > 
> >  2) runnable == util > capacity
> > 
> >     no contention, no idle
> > 
> >  3) runnable > util
> > 
> >     contention, no idle
> > 
> > For 1) we can use: 'util'
> > For 2) we can use: 'capacity'
> > For 3) we can use: 'util * capacity >> 10'
> > 
> > (note that 2 is a special case of 3 when u=1)
> > 
> > This should work right?
> 
> I think there is a case, similar to 2, in which the new 'util' could
> potentially be used. That's the case for example of a 20% (estimated)
> utilization task running alone on a 15% capacity CPU, for a single
> activation. In that case such a task will complete and be dequeued
> with:
> 
>    runnable == util > capacity
> 
> The problem is that we need to be sure there was not contention... and
> that seems to be difficult to detect.

When there is contention runnable and util should diverge. Given this is
all discrete stuff, there's a few funnies, but who cares about those :-)

> > Now, instead of doing complicated things like that, you instead figure
> > that when there's no idle there's also no dequeue happening and we can
> > simply short-cut by skipping the entire thing, forgetting everything
> > about 2,3.
> > 
> > Did I get that right?
> 
> More or less... just saying that 1 is the only easy to detect scenario
> in which we are granted the utilization represents an actual bandwidth
> request and thus the only safe values to sample for estimated
> utilization. For the other cases, since anyway:
> 
>    util_est := max(max(ewma, last_util), util_avg)
> 
> util_est will just keep representing a safe and actually measured
> lower-bound for the expected utilization of a task, without
> side-affecting the EWMA which has a "slow" update dynamic.

Right, so maybe we should expound the comment here a bit; but otherwise
I'm inclined to merge that v9 Vincent posted.
