Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9BCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C5721A14
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BaxFcCjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C5721A14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeGCItl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:49:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52793 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933238AbeGCIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:49:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id w16-v6so1402550wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLJYWlZ5v4zMqbTtnYjx/oxAiTiQ9m+4N8+QtCaHfC8=;
        b=BaxFcCjOPzuDdRmfEtbH5z7cu+Ose35A/ZAjr0Ghi1Ymqp3vjWvgRDpS0kYOAbBP1Y
         DQot4St4K9KjWXUlDMfyP8ImdtN0w0fcyx/v5Hef5NLrsglyPCv30ogdZuGrjrMhE+JI
         PIen/iw+gxsR+FxCwl8mI24JubqdVlJzCdBSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLJYWlZ5v4zMqbTtnYjx/oxAiTiQ9m+4N8+QtCaHfC8=;
        b=QW5x/rg54WcVCbBdImMEUln52hlSmVF28797h2T6q2z7H5fTewxVAbQTD07DOpO7cz
         DYEbcZyxz622RENIoABVNRAHofTM4913G70UmNYQm6noHPQh1Cye5J1NL+8gayfAUfxR
         uJaR2vudpdm0u6H0NAmLLvnE8S2DxmSCy7nGlYGn1+PG0kRGY8Ugs/1eUW/BgIinFVBn
         ESSZWm4S9BqjDtuhmmjzNVxuAs/r1xp/WvBCAFCwG9tMSCuzkfTK0j2AGgXmLBy9PfBx
         Pf3hgZb67Z0QdO77DbubHwOaGWHY3aC3ti1NQ6VcNfdveoczTH+zEHYR92RpNrKmbea9
         Qy0A==
X-Gm-Message-State: APt69E0ObUIINGo9HVzNvYYuM1/XjHagrTtGNXm2DtqbWEsq+kOeRqWO
        Zg/aRuWPP8xK1Fwt0hV0vJjmqg==
X-Google-Smtp-Source: AAOMgpcaXYUeTShYywn2Sowz/57d4T2yJMkIS4Gb0Okbk+YGUBZOTt9QjS2mvrVttsqYlFttge5TIQ==
X-Received: by 2002:a1c:b004:: with SMTP id z4-v6mr10682872wme.70.1530607775760;
        Tue, 03 Jul 2018 01:49:35 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id 72-v6sm1036123wmo.26.2018.07.03.01.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 01:49:34 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:49:21 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180703084921.GA28324@andrea>
References: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
 <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180702153735.GQ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702153735.GQ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:37:35PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 05:11:55PM +0200, Andrea Parri wrote:
> >  /*
> > + * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
> > + * between program-order earlier lock acquisitions and program-order later
> > + * memory accesses.
> >   *
> > + * This guarantees that the following two properties hold:
> >   *
> > + *   1) Given the snippet:
> >   *
> > + *	  { X = 0;  Y = 0; }
> >   *
> > + *	  CPU0				CPU1
> >   *
> > + *	  WRITE_ONCE(X, 1);		WRITE_ONCE(Y, 1);
> > + *	  spin_lock(S);			smp_mb();
> > + *	  smp_mb__after_spinlock();	r1 = READ_ONCE(X);
> > + *	  r0 = READ_ONCE(Y);
> > + *	  spin_unlock(S);
> >   *
> > + *      it is forbidden that CPU0 does not observe CPU1's store to Y (r0 = 0)
> > + *      and CPU1 does not observe CPU0's store to X (r1 = 0); see the comments
> > + *      preceding the call to smp_mb__after_spinlock() in __schedule() and in
> > + *      try_to_wake_up().
> > + *
> > + *   2) Given the snippet:
> > + *
> > + *  { X = 0;  Y = 0; }
> > + *
> > + *  CPU0		CPU1				CPU2
> > + *
> > + *  spin_lock(S);	spin_lock(S);			r1 = READ_ONCE(Y);
> > + *  WRITE_ONCE(X, 1);	smp_mb__after_spinlock();	smp_rmb();
> > + *  spin_unlock(S);	r0 = READ_ONCE(X);		r2 = READ_ONCE(X);
> > + *			WRITE_ONCE(Y, 1);
> > + *			spin_unlock(S);
> > + *
> > + *      it is forbidden that CPU0's critical section executes before CPU1's
> > + *      critical section (r0 = 1), CPU2 observes CPU1's store to Y (r1 = 1)
> > + *      and CPU2 does not observe CPU0's store to X (r2 = 0); see the comments
> > + *      preceding the calls to smp_rmb() in try_to_wake_up() for similar
> > + *      snippets but "projected" onto two CPUs.
> 
> Maybe explicitly note that 2) is the RCsc lock upgrade.

Yes, I'll do a respin to add this note and the below Ack shortly.

Thanks,
  Andrea


> 
> 
> >   * Since most load-store architectures implement ACQUIRE with an smp_mb() after
> >   * the LL/SC loop, they need no further barriers. Similarly all our TSO
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index da8f12119a127..ec9ef0aec71ac 100644
> > +++ b/kernel/sched/core.c
> > @@ -1999,21 +1999,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
> >  	 * in smp_cond_load_acquire() below.
> >  	 *
> > +	 * sched_ttwu_pending()			try_to_wake_up()
> > +	 *   STORE p->on_rq = 1			  LOAD p->state
> > +	 *   UNLOCK rq->lock
> > +	 *
> > +	 * __schedule() (switch to task 'p')
> > +	 *   LOCK rq->lock			  smp_rmb();
> > +	 *   smp_mb__after_spinlock();
> > +	 *   UNLOCK rq->lock
> >  	 *
> >  	 * [task p]
> > +	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
> >  	 *
> > +	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> > +	 * __schedule().  See the comment for smp_mb__after_spinlock().
> >  	 */
> >  	smp_rmb();
> >  	if (p->on_rq && ttwu_remote(p, wake_flags))
> > @@ -2027,15 +2026,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	 * One must be running (->on_cpu == 1) in order to remove oneself
> >  	 * from the runqueue.
> >  	 *
> > +	 * __schedule() (switch to task 'p')	try_to_wake_up()
> > +	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
> > +	 *   UNLOCK rq->lock
> > +	 *
> > +	 * __schedule() (put 'p' to sleep)
> > +	 *   LOCK rq->lock			  smp_rmb();
> > +	 *   smp_mb__after_spinlock();
> > +	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
> >  	 *
> > +	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> > +	 * __schedule().  See the comment for smp_mb__after_spinlock().
> >  	 */
> >  	smp_rmb();
> 
> Ah yes, good.
> 
> Ack!
