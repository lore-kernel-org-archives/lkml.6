Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E558BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6112543C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ku5dO+RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6112543C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeGBPiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:38:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeGBPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WgdSB/pzlU7x3tjbiX8BR3Lqs/IbJ3UHK8OR38voySM=; b=ku5dO+RDE198G5UiU/aBahier
        6rBeIrsUbBaDLG64NcgTNa3Fm8xpoWOeZDgk+qwdpbKMgTlS1j7XaA5jEheEdD2qzkoS8ZRfMm7m2
        5gPejhBrMESRKrCQXaIiEGJNCxMjxWtZX1reZgUSugTPJGzAioZblDe5vtEwdAlExy9OpKVkpGaNU
        ApvwekS2gjzETO3OgBRlYbHquxvIq/Zg29IHGqsmOYnsdkdfGbGyNgb5K+0l68Ltl/6zu9jEkJsvh
        QlNt/2gDI75QXTV+YBjYp5igC1kdnP6nzOpVTYTEJbmtn6Srqg+GEO31hTlXTSdIkFJFKEeUCNxLb
        kOkzHCyJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa0tV-0000i9-Jo; Mon, 02 Jul 2018 15:37:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4B452029F1DB; Mon,  2 Jul 2018 17:37:35 +0200 (CEST)
Date:   Mon, 2 Jul 2018 17:37:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
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
Message-ID: <20180702153735.GQ2494@hirez.programming.kicks-ass.net>
References: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
 <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:11:55PM +0200, Andrea Parri wrote:
>  /*
> + * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
> + * between program-order earlier lock acquisitions and program-order later
> + * memory accesses.
>   *
> + * This guarantees that the following two properties hold:
>   *
> + *   1) Given the snippet:
>   *
> + *	  { X = 0;  Y = 0; }
>   *
> + *	  CPU0				CPU1
>   *
> + *	  WRITE_ONCE(X, 1);		WRITE_ONCE(Y, 1);
> + *	  spin_lock(S);			smp_mb();
> + *	  smp_mb__after_spinlock();	r1 = READ_ONCE(X);
> + *	  r0 = READ_ONCE(Y);
> + *	  spin_unlock(S);
>   *
> + *      it is forbidden that CPU0 does not observe CPU1's store to Y (r0 = 0)
> + *      and CPU1 does not observe CPU0's store to X (r1 = 0); see the comments
> + *      preceding the call to smp_mb__after_spinlock() in __schedule() and in
> + *      try_to_wake_up().
> + *
> + *   2) Given the snippet:
> + *
> + *  { X = 0;  Y = 0; }
> + *
> + *  CPU0		CPU1				CPU2
> + *
> + *  spin_lock(S);	spin_lock(S);			r1 = READ_ONCE(Y);
> + *  WRITE_ONCE(X, 1);	smp_mb__after_spinlock();	smp_rmb();
> + *  spin_unlock(S);	r0 = READ_ONCE(X);		r2 = READ_ONCE(X);
> + *			WRITE_ONCE(Y, 1);
> + *			spin_unlock(S);
> + *
> + *      it is forbidden that CPU0's critical section executes before CPU1's
> + *      critical section (r0 = 1), CPU2 observes CPU1's store to Y (r1 = 1)
> + *      and CPU2 does not observe CPU0's store to X (r2 = 0); see the comments
> + *      preceding the calls to smp_rmb() in try_to_wake_up() for similar
> + *      snippets but "projected" onto two CPUs.

Maybe explicitly note that 2) is the RCsc lock upgrade.


>   * Since most load-store architectures implement ACQUIRE with an smp_mb() after
>   * the LL/SC loop, they need no further barriers. Similarly all our TSO
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da8f12119a127..ec9ef0aec71ac 100644
> +++ b/kernel/sched/core.c
> @@ -1999,21 +1999,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
>  	 * in smp_cond_load_acquire() below.
>  	 *
> +	 * sched_ttwu_pending()			try_to_wake_up()
> +	 *   STORE p->on_rq = 1			  LOAD p->state
> +	 *   UNLOCK rq->lock
> +	 *
> +	 * __schedule() (switch to task 'p')
> +	 *   LOCK rq->lock			  smp_rmb();
> +	 *   smp_mb__after_spinlock();
> +	 *   UNLOCK rq->lock
>  	 *
>  	 * [task p]
> +	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
>  	 *
> +	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> +	 * __schedule().  See the comment for smp_mb__after_spinlock().
>  	 */
>  	smp_rmb();
>  	if (p->on_rq && ttwu_remote(p, wake_flags))
> @@ -2027,15 +2026,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 * One must be running (->on_cpu == 1) in order to remove oneself
>  	 * from the runqueue.
>  	 *
> +	 * __schedule() (switch to task 'p')	try_to_wake_up()
> +	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
> +	 *   UNLOCK rq->lock
> +	 *
> +	 * __schedule() (put 'p' to sleep)
> +	 *   LOCK rq->lock			  smp_rmb();
> +	 *   smp_mb__after_spinlock();
> +	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
>  	 *
> +	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> +	 * __schedule().  See the comment for smp_mb__after_spinlock().
>  	 */
>  	smp_rmb();

Ah yes, good.

Ack!
