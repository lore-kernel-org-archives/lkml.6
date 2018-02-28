Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeB1K4c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:56:32 -0500
Received: from foss.arm.com ([217.140.101.70]:47656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbeB1K4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:56:30 -0500
Date: Wed, 28 Feb 2018 10:56:32 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] Documentation/locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180228105631.GA7681@arm.com>
References: <1519814372-19941-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519814372-19941-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:39:32AM +0100, Andrea Parri wrote:
> There appeared to be a certain, recurrent uncertainty concerning the
> semantics of spin_is_locked(), likely a consequence of the fact that
> this semantics remains undocumented or that it has been historically
> linked to the (likewise unclear) semantics of spin_unlock_wait().
> 
> Document this semantics.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> ---
>  include/linux/spinlock.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 4894d322d2584..2639fdc9a916c 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -380,6 +380,17 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
>  	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
>  })
>  
> +/**
> + * spin_is_locked() - Check whether a spinlock is locked.
> + * @lock: Pointer to the spinlock.
> + *
> + * This function is NOT required to provide any memory ordering
> + * guarantees; it could be used for debugging purposes or, when
> + * additional synchronization is needed, accompanied with other
> + * constructs (memory barriers) enforcing the synchronization.
> + *
> + * Return: 1, if @lock is (found to be) locked; 0, otherwise.
> + */

I also don't think this is quite right, since the spin_is_locked check
must be ordered after all prior lock acquisitions (to any lock) on the same
CPU. That's why we have an smp_mb() in there on arm64 (see 38b850a73034f).

So this is a change in semantics and we need to audit the users before
proceeding. We should also keep spin_is_locked consistent with the versions
for mutex, rwsem, bit_spin.

Will
