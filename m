Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeCFNBP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:01:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753487AbeCFNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:01:14 -0500
Date: Tue, 6 Mar 2018 14:00:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
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
Message-ID: <20180306130059.GE25201@hirez.programming.kicks-ass.net>
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
User-Agent: Mutt/1.9.2 (2017-12-15)
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

So ARM64 and Power have the acquire-on-load only thing, but qspinlock
has it per construction on anything that allowes reordering stores.

Given that unlock/lock are ordered, which covers about 99% of the users
out there, and fixing the issue would make things significantly slower
on the weak architectures we let it be.

But yes, its a pesky detail.
