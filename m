Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeEVVRv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:17:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbeEVVRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:17:49 -0400
Date: Tue, 22 May 2018 23:17:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: psodagud@codeaurora.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Eric Biggers <ebiggers@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, sherryy@android.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: write_lock_irq(&tasklist_lock)
Message-ID: <20180522211724.GR12217@hirez.programming.kicks-ass.net>
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <CA+55aFyGHhPvbqGaA0+tx7fbH+Uc6sbGKk2PLoFYCt-agCOgOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyGHhPvbqGaA0+tx7fbH+Uc6sbGKk2PLoFYCt-agCOgOw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 01:27:17PM -0700, Linus Torvalds wrote:

> It's usually not a huge problem because there are so few writers, but what
> you're seeing is the writer starvation issue because readers can be
> plentiful.

qrwlock is a fair lock and should not exhibit writer starvation. Write
acquire time is of course proportional to the number of CPUs in the
system because each can be holding a reader, but once there is a pending
writer there should not be new readers.

> > Do we need write_lock_irq(&tasklist_lock) in below portion of code ? Can
> > I use write_unlock instead of write_lock_irq in portion of code?
> 
> You absolutely need write_lock_irq(), because taking the tasklist_lock
> without disabling interrupts will deadlock very quickly due to an interrupt
> taking the tasklist_lock for reading.
> 
> That said, the write_lock_irq(&tasklist_lock) could possibly be replaced
> with something like
> 
>    static void tasklist_write_lock(void)
>    {
>          unsigned long flags;
>          local_irq_save(flags);
>          while (!write_trylock(&tasklist_lock)) {
>                  local_irq_restore(flags);
>                  do { cpu_relax(); } while (write_islocked(&tasklist_lock));
>                  local_irq_disable();
>          }
>    }
> 
> but we don't have that "write_islocked()" function.

You basically want to spin-wait with interrupts enabled, right? I think
there were problems with that, but I can't remember, my brain is
entirely shot for the day. But given how qrwlock is constructed, you'd
have to look at the arch spinlock implementation for that (qspinlock for
x86).

The obvious problem of course is:


	spin_lock_irq(&L)
	// contended
	local_irq_enable();
	while(...)
	  cpu_relax();
	   <IRQ>
	     spin_lock(&L);

Which because the spinlock is fair, is an instant deadlock.


You can do the IRQ enabled spin-wait for unfair locks, but by now all
our locks are fair (because we kept hitting starvation).
