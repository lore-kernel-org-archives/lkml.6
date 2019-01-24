Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088B62184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLIGOLYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfAXMic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:38:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53952 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfAXMic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RAaay9A+2828Oigi4YlwejmDwHUlVQqtb2GPPHMohlY=; b=TLIGOLYp4d2xowe0kZKd9bzRM
        oy4rlhAE1EnGNfZOaa5yv+BMzGejjp2y63HL+/SFOVacoP/k6C+FYVx9sB01R5RPVBA09f/lGLX4Z
        eekSzSLg7qWCDm/zHktvA/VBPnuvFK9UWrOrcnTZ5mNpWoijMBkp7gjRQ9y3glNw0ng3KyUTH8cDd
        TNMZEWfqdfBChkrIZCx505sF3c2CTMukaLjO2bjimgPo7nqUQ0ytA9Ub0eb9qD3Ks1vX/Pbw0KJGq
        +3d7ohVVzzWEXX0Xut/uG91Kmv7vEXM3AQyjW8/W9w1SPNRfM6pMM0w0m+Bg9uFZjl+9NWhZ2Ib1D
        AtCLC+dtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmeGw-0002HP-Pr; Thu, 24 Jan 2019 12:38:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2A2F20F51B0C; Thu, 24 Jan 2019 13:38:14 +0100 (CET)
Date:   Thu, 24 Jan 2019 13:38:14 +0100
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
Message-ID: <20190124123814.GM13777@hirez.programming.kicks-ass.net>
References: <20190122093704.GM27931@hirez.programming.kicks-ass.net>
 <20190122104305.6vjx37muqsxm536t@e110439-lin>
 <20190122132817.GG13777@hirez.programming.kicks-ass.net>
 <20190122140115.twtx646vewm757ca@e110439-lin>
 <20190122145742.GQ27931@hirez.programming.kicks-ass.net>
 <20190122153315.dhjl67sgpu74hmqv@e110439-lin>
 <20190123091634.GT27931@hirez.programming.kicks-ass.net>
 <20190123141426.5samtr4hl6okdypu@e110439-lin>
 <20190123185940.GF17749@hirez.programming.kicks-ass.net>
 <20190124112153.pwdsbxjynq6chmvl@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124112153.pwdsbxjynq6chmvl@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:21:53AM +0000, Patrick Bellasi wrote:

> When a task-specific uclamp value is changed for a task, instead, a
> dequeue/enqueue is not needed. As long as we are doing a lazy update,
> that sounds just like not necessary overhead.

When that overhead is shown to be a problem, is when we'll look at that
:-)

> However, there could still be value in keeping code consistent and if
> you prefer it this way what should I do?
> 
> ---8<---
>     __sched_setscheduler()
>         ...
>         if (policy < 0)
>             policy = oldpolicy = p->policy;
>         ...
>         if (unlikely(policy == p->policy)) {
>             ...
>             if (uclamp_changed())         // Force dequeue/enqueue
>                 goto change;
>         }
>     change:
>         ...
> 
>         if (queued)
> 	    dequeue_task(rq, p, queue_flags);
> 	if (running)
> 	    put_prev_task(rq, p);
> 
>         __setscheduler_uclamp();
> 	__setscheduler(rq, p, attr, pi);
> 
> 	if (queued)
> 	    enqueue_task(rq, p, queue_flags);
> 	if (running)
> 	    set_curr_task(rq, p);
>         ...
> ---8<---
> 
> Could be something like that ok with you?

Yes, that's about what I was expecting.

> Not sure about side-effects on p->prio(): for CFS seems to be reset to
> NORMAL in this case :/

That's what we need KEEP_PARAM for, right?
