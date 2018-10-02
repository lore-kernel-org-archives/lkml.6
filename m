Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DCFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EC4206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EC4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeJBUDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:03:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37254 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeJBUDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:03:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4091596;
        Tue,  2 Oct 2018 06:19:41 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F3BA3F5B3;
        Tue,  2 Oct 2018 06:19:41 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 92CB81AE2DE4; Tue,  2 Oct 2018 14:20:05 +0100 (BST)
Date:   Tue, 2 Oct 2018 14:20:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/3] locking/qspinlock: Rework some comments
Message-ID: <20181002132005.GE16422@arm.com>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.457488877@infradead.org>
 <20181001171707.GE13918@arm.com>
 <20181001191022.GN3439@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001191022.GN3439@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Oct 01, 2018 at 09:10:22PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 01, 2018 at 06:17:08PM +0100, Will Deacon wrote:
> > On Wed, Sep 26, 2018 at 01:01:19PM +0200, Peter Zijlstra wrote:
> > > +
> > >  	/*
> > > -	 * If we observe any contention; undo and queue.
> > > +	 * If we observe contention, there was a concurrent lock.
> > 
> > Nit: I think "concurrent lock" is confusing here, because that implies to
> > me that the lock was actually taken behind our back, which isn't necessarily
> > the case. How about "there is a concurrent locker"?
> 
> Yes, that's better.

Thanks.

> > > +	 *
> > > +	 * Undo and queue; our setting of PENDING might have made the
> > > +	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
> > > +	 * on @next to become !NULL.
> > >  	 */
> > 
> > Hmm, but it could also fail another concurrent set of PENDING (and the lock
> > could just be held the entire time).
> 
> Right. What I wanted to convey was that is we observe _any_ contention,
> we must abort and queue, because of that above condition failing and
> waiting on @next.
> 
> The other cases weren't as critical, but that one really does require us
> to queue in order to make forward progress.
> 
> Or did I misunderstand your concern?

See below, since I think my comments are related.

> > >  	if (unlikely(val & ~_Q_LOCKED_MASK)) {
> > > +
> > > +		/* Undo PENDING if we set it. */
> > >  		if (!(val & _Q_PENDING_MASK))
> > >  			clear_pending(lock);
> > > +
> > >  		goto queue;
> > >  	}
> > >  
> > > @@ -466,7 +473,7 @@ void queued_spin_lock_slowpath(struct qs
> > >  	 * claim the lock:
> > >  	 *
> > >  	 * n,0,0 -> 0,0,1 : lock, uncontended
> > > -	 * *,*,0 -> *,*,1 : lock, contended
> > > +	 * *,0,0 -> *,0,1 : lock, contended
> > 
> > Pending can be set behind our back in the contended case, in which case
> > we take the lock with a single byte store and don't clear pending. You
> > mention this in the updated comment below, but I think we should leave this
> > comment alone.
> 
> Ah, so the reason I write it like so is because when we get here,
> val.locked_pending == 0, per the atomic_cond_read_acquire() condition.

Ah, and I vaguely remember discussing this before. The way I read these
transition diagrams, I find it most useful if they correspond to the lock
word in memory. That way, it makes it clear about exactly which fields are
stable, and which can be concurrently modified. So in the comment above,
saying:

	 *,*,0 -> *,*,1 : lock, contended

is really helpful, because it clearly says "we're taking the lock, but the
rest of the lock word could be modified by others at the same time", whereas
saying:

	 *,0,0 -> *,0,1 : lock, contended

implies to me that pending is stable and cannot be set concurrently.

Will
