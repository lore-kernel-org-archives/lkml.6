Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321242087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321242087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJLQBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:01:37 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44795 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeJLQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:01:37 -0400
Received: by mail-ed1-f48.google.com with SMTP id z21-v6so10713410edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0uFJzDeiKzDpzpa+RpZEwszDt2nMNJOOP32gfeVX2u8=;
        b=r+qS19Fla735P/Zj4CQL1r8/wwaYp5Y1EdEQPVmVaPTX7P7F+lUonhUjbHNCUvKJOZ
         lEkHepDwrr/zJxBdkJIeGoRrbQ+WighJ2+aAHdNbO7h8Jw0yHeLUULEkARYjQmcEamu6
         ksol2cN89xEgw01noxKPxVJLgRmkfCOlnyU2bwHHtXQ8GoYXGEqsWxa9e2BN2cjQB+JD
         qGArMNtgfnTcvpo0xZCRZ8QhsvK8T+PrZWMrDr6zpsPGvVfH7ddw/J6aKUVqrsPxCfiW
         2+0Qc/+S2h9CfLr9mtFZFrtYnfiYYgdzF5BzhH0ccxmt296vDMwsTONX+nY3LcE0EgQi
         Z79Q==
X-Gm-Message-State: ABuFfohRgwhoR3ae+nWn2e96rxGnD3s/3cbh3CFmtnU6bUOgCIRoQxs2
        SgUEI7BgsV8N4jupLv1r+yVs5A==
X-Google-Smtp-Source: ACcGV62HdrST8+GM8Q9ohyzKEGdgw+piE2Wws5t0ykuOI4tGk1/ygKqLL6KeUX8sI98l0e3EvbQCUw==
X-Received: by 2002:a17:906:70c3:: with SMTP id g3-v6mr6029253ejk.194.1539333016000;
        Fri, 12 Oct 2018 01:30:16 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id s46-v6sm413233edb.49.2018.10.12.01.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 01:30:14 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:30:10 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Message-ID: <20181012083010.GV9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009092434.26221-6-juri.lelli@redhat.com>
 <20181010131048.54afd1b6@luca64>
 <20181011123448.GS9130@localhost.localdomain>
 <20181011125325.GA9867@hirez.programming.kicks-ass.net>
 <20181012092231.0bdb5cf7@sweethome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012092231.0bdb5cf7@sweethome>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 09:22, luca abeni wrote:
> On Thu, 11 Oct 2018 14:53:25 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> [...]
> > > > > +	if (rq->curr != rq->idle) {
> > > > > +		rq->proxy = rq->idle;
> > > > > +		set_tsk_need_resched(rq->idle);
> > > > > +		/*
> > > > > +		 * XXX [juril] don't we still need to migrate
> > > > > @next to
> > > > > +		 * @owner's CPU?
> > > > > +		 */
> > > > > +		return rq->idle;
> > > > > +	}  
> > > > 
> > > > If I understand well, this code ends up migrating the task only
> > > > if the CPU was previously idle? (scheduling the idle task if the
> > > > CPU was not previously idle)
> > > > 
> > > > Out of curiosity (I admit this is my ignorance), why is this
> > > > needed? If I understand well, after scheduling the idle task the
> > > > scheduler will be invoked again (because of the
> > > > set_tsk_need_resched(rq->idle)) but I do not understand why it is
> > > > not possible to migrate task "p" immediately (I would just check
> > > > "rq->curr != p", to avoid migrating the currently scheduled
> > > > task).  
> [...]
> > I think it was the safe and simple choice; note that we're not
> > migrating just a single @p, but a whole chain of @p.
> 
> Ah, that's the point I was missing... Thanks for explaining, now
> everything looks more clear!
> 
> 
> But... Here is my next dumb question: once the tasks are migrated to
> the other runqueue, what prevents the scheduler from migrating them
> back? In particular, task p: if it is (for example) a fixed priority
> task an is on this runqueue, it is probably because the FP invariant
> wants this... So, the push mechanism might end up migrating p back to
> this runqueue soon... No?

Not if p is going to be proxying for owner on owner's rq.
OTOH, I guess we might have counter-migrations generated by push/pull
decisions. Maybe we should remove potential proxies from pushable?
We'd still have the same problem for FAIR though.
In general it seems to make sense to me the fact that potential proxies
shouldn't participate to load balancing while waiting to be activated by
the mutex owner; they are basically sleeping, even if they are not.

> Another doubt: if I understand well, when a task p "blocks" on a mutex
> the proxy mechanism migrates it (and the whole chain of blocked tasks)
> to the owner's core... Right?
> Now, I understand why this is simpler to implement, but from the
> schedulability point of view shouldn't we migrate the owner to p's core
> instead?

Guess the most important reason is that we need to respect owner's
affinity, p (and the rest of the list) might have affinity mask that
doesn't work well with owner's.
