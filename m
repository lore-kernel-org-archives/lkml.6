Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256CAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A025A31
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C9t1WE0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7A025A31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934051AbeFYNQ4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:16:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40137 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934028AbeFYNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:16:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id g18-v6so13643300wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EcUAzLkjeygbDnazyFrM5IRX1QUq/Nrh6HgVKfYJ+14=;
        b=C9t1WE0J1nk5JuyewHqiHleyVlWldqdPxhJVnAUooDLOg6wdl1WYB3nZSQ8cExNSMO
         nVWxAjAyQRVJHOScfqb+dLzZa4/O0/prPlA7f8F2TGp2IGPyDE4QFWczrMtkMVCBPli7
         mkjXOQjYPNAYbwsFfbaUKeX42NUk7UZIjXXgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EcUAzLkjeygbDnazyFrM5IRX1QUq/Nrh6HgVKfYJ+14=;
        b=UoFr1Z6vo92czWvzE0nzl5FmAbFeQwygjDs9ccKPAr7y9mrPMkS9Kpp9qpyuLRSxfZ
         bwq/n/8e2cb2NPo91KkouUVJ1KEFH0/4wlekTgGx7wSy4b81uUnKhX5Q4b8cRWVZryyE
         7be9/tpQ+1NY0Gbtzni+NAmy/6ZC2GhlW4SvRT7fGQYx19bZp52hjJWZ7cQYQ9EWoiv1
         5fl35eN0wTJQhe+WJe+UEuWizhlRSSzz4PBP29Hp6l5HaYEG9YCFju8GIgnYYjB0pJJI
         v6wS3WuCDawu0F/z2nrIK8WyXf8Y7D6t2C1Gur99g6fgc3f9LNQOOOz3J83JurPCAiGf
         QPjg==
X-Gm-Message-State: APt69E2jZtIKk3rbQrdTk7gqQHz18emLEyBdKRfbG/3etQSsDMdWyVWz
        tB+symIX8ZcTtpcrs8TZGdaHwA==
X-Google-Smtp-Source: AAOMgpdOaPgFfMeMVZveUoqzBH5WOLlC5E9Z7+V2JDsTgW11uXk6SNOIORmb2tr7t3NeB5UxCfh+Ww==
X-Received: by 2002:adf:fa07:: with SMTP id m7-v6mr10704383wrr.228.1529932611495;
        Mon, 25 Jun 2018 06:16:51 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id t1-v6sm9374806wmt.40.2018.06.25.06.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:16:50 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:16:43 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180625131643.GA15126@andrea>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625123121.GY2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > A concrete example being the store-buffering pattern reported in [1].
> 
> Well, that example only needs a store->load barrier. It so happens
> smp_mb() is the only one actually doing that, but imagine we had a
> weaker barrier that did just that, one that did not imply the full
> transitivity smp_mb() does.
> 
> Then the example from [1] could use that weaker thing.

Absolutely (and that would be "fence w,r" on RISC-V, IIUC).


> 
> > > So yes, I suppose we're entirely suck with the full memory barrier
> > > semantics like that. But I still find it easier to think of it like a
> > > RELEASE that pairs with the ACQUIRE of waking up, such that the task
> > > is guaranteed to observe it's own wake condition.
> > > 
> > > And maybe that is the thing I'm missing here. These comments only state
> > > that it does in fact imply a full memory barrier, but do not explain
> > > why, should it?
> > 
> > "code (people) is relying on it" is really the only "why" I can think
> > of.  With this patch, that same/SB pattern is also reported in memory
> > -barriers.txt.  Other ideas?
> 
> So I'm not actually sure how many people rely on the RCsc transitive
> smp_mb() here. People certainly rely on the RELEASE semantics, and the
> code itself requires the store->load ordering, together that gives us
> the smp_mb() because that's simply the only barrier we have.
> 
> And looking at smp_mb__after_spinlock() again, we really only need the
> RCsc thing for rq->lock, not for the wakeups. The wakeups really only
> need that RCpc RELEASE + store->load thing (which we don't have).
> 
> So yes, smp_mb(), however the below still makes more sense to me, or am
> I just being obtuse again?
> 
> ---
>  kernel/sched/core.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a98d54cd5535..8374d01b2820 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1879,7 +1879,9 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>   *  C) LOCK of the rq(c1)->lock scheduling in task
>   *
>   * Transitivity guarantees that B happens after A and C after B.
> - * Note: we only require RCpc transitivity.
> + * Note: we only require RCpc transitivity for these cases,
> + *       but see smp_mb__after_spinlock() for why rq->lock is required
> + *       to be RCsc.
>   * Note: the CPU doing B need not be c0 or c1

FWIW, we discussed this pattern here:

  http://lkml.kernel.org/r/20171018010748.GA4017@andrea


>   *
>   * Example:
> @@ -1944,13 +1946,14 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>   * However; for wakeups there is a second guarantee we must provide, namely we
>   * must observe the state that lead to our wakeup. That is, not only must our
>   * task observe its own prior state, it must also observe the stores prior to
> - * its wakeup.
> + * its wakeup, see set_current_state().
>   *
>   * This means that any means of doing remote wakeups must order the CPU doing
> - * the wakeup against the CPU the task is going to end up running on. This,
> - * however, is already required for the regular Program-Order guarantee above,
> - * since the waking CPU is the one issueing the ACQUIRE (smp_cond_load_acquire).
> - *
> + * the wakeup against the CPU the task is going to end up running on. This
> + * means two things: firstly that try_to_wake_up() must (at least) imply a
> + * RELEASE (smp_mb__after_spinlock()), and secondly, as is already required
> + * for the regular Program-Order guarantee above, that waking implies an ACQUIRE
> + * (see smp_cond_load_acquire() above).
>   */
>  
>  /**
> @@ -1966,6 +1969,10 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>   * Atomic against schedule() which would dequeue a task, also see
>   * set_current_state().
>   *
> + * Implies at least a RELEASE such that the waking task is guaranteed to
> + * observe the stores to the wait-condition; see set_task_state() and the
> + * Program-Order constraints.

[s/set_task_task/set_current_state ?]

I'd stick to "Implies/Executes at least a full barrier"; this is in fact
already documented in the function body:

	/*
	 * If we are going to wake up a thread waiting for CONDITION we
	 * need to ensure that CONDITION=1 done by the caller can not be
	 * reordered with p->state check below. This pairs with mb() in
	 * set_current_state() the waiting thread does.
	 */

(this is, again, that "store->load barrier"/SB).

I'll try to integrate these changes in v2, if there is no objection.

  Andrea


> + *
>   * Return: %true if @p->state changes (an actual wakeup was done),
>   *	   %false otherwise.
>   */
