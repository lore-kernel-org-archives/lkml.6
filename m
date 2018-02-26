Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeBZRKJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:10:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53176 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeBZRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:10:08 -0500
Date: Mon, 26 Feb 2018 17:10:08 +0000
From: Will Deacon <will.deacon@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
Message-ID: <20180226171008.GC30736@arm.com>
References: <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net>
 <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
 <20180226142107.uid5vtv5r7zbso33@yquem.inria.fr>
 <CA+55aFwu5jat5vV-d6RVaUFo=Bjeyv-7eXWUJySg6xFUTnfbWQ@mail.gmail.com>
 <20180226162426.GB17158@arm.com>
 <CA+55aFyT=+8m0mmpeegP8LOVtkCYv3O2vyO-ZcQdLAR=s309jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyT=+8m0mmpeegP8LOVtkCYv3O2vyO-ZcQdLAR=s309jg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 09:00:43AM -0800, Linus Torvalds wrote:
> On Mon, Feb 26, 2018 at 8:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > Strictly speaking, that's not what we've got implemented on arm64: only
> > the read part of the RmW has Acquire semantics, but there is a total
> > order on the lock/unlock operations for the lock.
> 
> Hmm.
> 
> I thought we had exactly that bug on some architecture with the queued
> spinlocks, and people decided it was wrong.
> 
> But it's possible that I mis-remember, and that we decided it was ok after all.
> 
> > spin_lock(&lock);
> > WRITE_ONCE(foo, 42);
> >
> > then another CPU could do:
> >
> > if (smp_load_acquire(&foo) == 42)
> >         BUG_ON(!spin_is_locked(&lock));
> >
> > and that could fire. Is that relied on somewhere?
> 
> I have a distinct memory that we said the spinlock write is seen in
> order, wrt the writes inside the spinlock, and the reason was
> something very similar to the above, except that "spin_is_locked()"
> was about our spin_unlock_wait().

Yes, we did run into problems with spin_unlock_wait and we ended up
strengthening the arm64 implementation to do an RmW, which puts it into
the total order of lock/unlock operations. However, we then went and
killed the thing because it was seldom used correctly and we struggled
to define what "correctly" even meant!

> Because we had something very much like the above in the exit path,
> where we would look at some state and do "spin_unlock_wait()" and
> expect to be guaranteed to be the last user after that.
> 
> But a few months ago we obviously got rid of spin_unlock_wait exactly
> because people were worried about the semantics.

Similarly for spin_can_lock.

> So maybe I just remember an older issue that simply became a non-issue
> with that.

I think so. If we need to, I could make spin_is_locked do an RmW on
arm64 so we can say that all successful spin_* operations are totally
ordered for a given lock, but spin_is_locked is normally only used as a
coarse debug check anyway where it's assumed that if it's held, it's
held by the current CPU. We should probably move most users over to
lockdep and see what we're left with.

Will
