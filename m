Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeBXIiO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 03:38:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeBXIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 03:38:13 -0500
Date: Sat, 24 Feb 2018 09:38:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180224083807.GB25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-5-boqun.feng@gmail.com>
 <20180223115520.GV25181@hirez.programming.kicks-ass.net>
 <20180223123732.acxbavnf2ktd4lzl@tardis>
 <20180224053250.ketrlbq4gtx573qo@tardis>
 <20180224063005.efbowkoq2v4qndan@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224063005.efbowkoq2v4qndan@tardis>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 02:30:05PM +0800, Boqun Feng wrote:
> On Sat, Feb 24, 2018 at 01:32:50PM +0800, Boqun Feng wrote:

> > 	/*
> > 	 * DEP_*_BIT in lock_list::dep
> > 	 *
> > 	 * For dependency @prev -> @next:
> > 	 *
> > 	 *   RR: both @prev and @next are recursive read locks, i.e. ->read == 2.
> > 	 *   RN: @prev is recursive and @next is non-recursive.
> > 	 *   NR: @prev is a not recursive and @next is recursive.
> > 	 *   NN: both @prev and @next are non-recursive.
> > 	 * 
> > 	 * Note that we define the value of DEP_*_BITs so that:
> > 	 * 	bit0 is prev->read != 2
> > 	 * 	bit1 is next->read != 2
> > 	 */
> > 	#define DEP_RR_BIT 0
> > 	#define DEP_RN_BIT 1
> > 	#define DEP_NR_BIT 2
> > 	#define DEP_NN_BIT 3
> > 
> > 	#define DEP_RR_MASK (1U << (DEP_RR_BIT))
> > 	#define DEP_RN_MASK (1U << (DEP_RN_BIT))
> > 	#define DEP_NR_MASK (1U << (DEP_NR_BIT))
> > 	#define DEP_NN_MASK (1U << (DEP_NN_BIT))
> > 
> > 	static inline unsigned int
> > 	__calc_dep_bit(struct held_lock *prev, struct held_lock *next)
> > 	{
> > 		return (prev->read != 2) + ((next->read != 2) << 1)
> > 	}
> > 
> > 	static inline u8 calc_dep(struct held_lock *prev, struct held_lock *next)
> > 	{
> > 		return 1U << __calc_dep_bit(prev, next);
> > 	}
> > 
> >  	static inline bool only_rx(u8 dep)
> >  	{
> >  		return !(dep & (DEP_NR_MASK | DEP_NN_MASK));
> >  	}
> > 
> >  	static inline bool only_xr(u8 dep)
> >  	{
> >  		return !(dep & (DEP_NR_MASK | DEP_NN_MASK));
> >  	}
> > 

> > > > 	if (have_xr && is_rx(entry->dep))
> > > > 		continue;
> > > > 
> > > > 	entry->have_xr = is_xr(entry->dep);
> > > > 
> 
> Hmm.. I think this part also needs some tweak:
> 
> 	/* if -> prev is *R, and we only have R* for prev -> this, * skip*/
> 	if (have_xr && only_rx(entry->dep))
> 		continue;
> 	
> 	/*
> 	 * we pick a *R for prev -> this only if:
> 	 *     prev -> this dependencies are all *R 
> 	 * or
> 	 *     -> prev is *R, and we don't have NN for prev -> this
> 	 */
> 	entry->have_xr = only_xr(entry->dep) || (have_xr && !is_nn(entry->dep));
> 
> otherwise, we will wrongly set entry->have_xr to false if have_xr is
> true and we have RN for prev -> this.

OK, so its saturday morning and such, but what? Why should we set
have_xr true when we have RN? Note that if we only had RN we'd already
have bailed on the continue due to only_rx().

So can you elaborate a bit?
