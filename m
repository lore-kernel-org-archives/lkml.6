Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDFV6f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:58:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43214 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeDFV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:58:34 -0400
X-Google-Smtp-Source: AIpwx4+DAy32pEZb/Q53EIyb7CZ51Jf4e9Z/KruxMcv06Au34r0ig/WoNBFvJYBv+UyYyvEyTBXLvA==
Date: Fri, 6 Apr 2018 23:58:25 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 1/3] locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180406215825.GA3646@andrea>
References: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1523044060-5568-1-git-send-email-andrea.parri@amarulasolutions.com>
 <b0dbf383-6403-a408-047d-0dd0d2135a03@infradead.org>
 <20180406210741.GF3948@linux.vnet.ibm.com>
 <30d15756-1cb4-7123-b4d9-ce2e66861df3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30d15756-1cb4-7123-b4d9-ce2e66861df3@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 02:08:16PM -0700, Randy Dunlap wrote:
> On 04/06/2018 02:07 PM, Paul E. McKenney wrote:
> > On Fri, Apr 06, 2018 at 02:01:41PM -0700, Randy Dunlap wrote:
> >> On 04/06/2018 12:47 PM, Andrea Parri wrote:
> >>> There appeared to be a certain, recurrent uncertainty concerning the
> >>> semantics of spin_is_locked(), likely a consequence of the fact that
> >>> this semantics remains undocumented or that it has been historically
> >>> linked to the (likewise unclear) semantics of spin_unlock_wait().
> >>>
> >>> A recent auditing [1] of the callers of the primitive confirmed that
> >>> none of them are relying on particular ordering guarantees; document
> >>> this semantics by adding a docbook header to spin_is_locked(). Also,
> >>> describe behaviors specific to certain CONFIG_SMP=n builds.
> >>>
> >>> [1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> >>>     https://marc.info/?l=linux-kernel&m=152042843808540&w=2
> >>>     https://marc.info/?l=linux-kernel&m=152043346110262&w=2
> >>>
> >>> Co-Developed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> >>> Co-Developed-by: Alan Stern <stern@rowland.harvard.edu>
> >>> Co-Developed-by: David Howells <dhowells@redhat.com>
> >>> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> >>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >>> Signed-off-by: David Howells <dhowells@redhat.com>
> >>> Cc: Will Deacon <will.deacon@arm.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>> Cc: Nicholas Piggin <npiggin@gmail.com>
> >>> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> >>> Cc: Luc Maranget <luc.maranget@inria.fr>
> >>> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> >>> Cc: Akira Yokosawa <akiyks@gmail.com>
> >>> Cc: Ingo Molnar <mingo@kernel.org>
> >>> ---
> >>>  include/linux/spinlock.h | 18 ++++++++++++++++++
> >>>  1 file changed, 18 insertions(+)
> >>>
> >>> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> >>> index 4894d322d2584..1e8a464358384 100644
> >>> --- a/include/linux/spinlock.h
> >>> +++ b/include/linux/spinlock.h
> >>> @@ -380,6 +380,24 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
> >>>  	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
> >>>  })
> >>>  
> >>> +/**
> >>> + * spin_is_locked() - Check whether a spinlock is locked.
> >>> + * @lock: Pointer to the spinlock.
> >>> + *
> >>> + * This function is NOT required to provide any memory ordering
> >>> + * guarantees; it could be used for debugging purposes or, when
> >>> + * additional synchronization is needed, accompanied with other
> >>> + * constructs (memory barriers) enforcing the synchronization.
> >>> + *
> >>> + * Returns: 1 if @lock is locked, 0 otherwise.
> >>
> >> Sorry, minor nit:
> >> s/Returns:/Return:/
> >> (according to kernel-doc.rst)
> >>
> >> although I agree that "Returns:" is better.
> >> [I should have changed that years ago.]
> > 
> > Agreed, English grammar and templates often seem to conflict.
> > 
> > So should we change this comment, or are you instead proposing to add
> > "Returns:" as valid kernel-doc?
> 
> Please change this patch to current doc syntax.
> Any changes to kernel-doc syntax would come later.

Paul: I understand that you're going to do this change "in place"; please
let me know if I'm wrong/if you need a new submission.

Thanks,
  Andrea


> 
> Thanks.
> 
> > 							Thanx, Paul
> > 
> >>> + *
> >>> + * Note that the function only tells you that the spinlock is
> >>> + * seen to be locked, not that it is locked on your CPU.
> >>> + *
> >>> + * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n,
> >>> + * the return value is always 0 (see include/linux/spinlock_up.h).
> >>> + * Therefore you should not rely heavily on the return value.
> >>> + */
> >>>  static __always_inline int spin_is_locked(spinlock_t *lock)
> >>>  {
> >>>  	return raw_spin_is_locked(&lock->rlock);
> >>>
> >>
> >>
> >> -- 
> >> ~Randy
> >>
> > 
> 
> 
> -- 
> ~Randy
