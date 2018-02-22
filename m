Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933690AbeBVSVV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:21:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933460AbeBVSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:21:19 -0500
Date: Thu, 22 Feb 2018 19:21:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
Message-ID: <20180222182107.GR25181@hirez.programming.kicks-ass.net>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 09:27:09AM -0800, Daniel Lustig wrote:
> On 2/22/2018 6:12 AM, Andrea Parri wrote:
> > On Thu, Feb 22, 2018 at 02:40:04PM +0100, Peter Zijlstra wrote:
> >> On Thu, Feb 22, 2018 at 01:19:50PM +0100, Andrea Parri wrote:
> >>
> >>> C unlock-lock-read-ordering
> >>>
> >>> {}
> >>> /* s initially owned by P1 */
> >>>
> >>> P0(int *x, int *y)
> >>> {
> >>> 	WRITE_ONCE(*x, 1);
> >>> 	smp_wmb();
> >>> 	WRITE_ONCE(*y, 1);
> >>> }
> >>>
> >>> P1(int *x, int *y, spinlock_t *s)
> >>> {
> >>> 	int r0;
> >>> 	int r1;
> >>>
> >>> 	r0 = READ_ONCE(*y);
> >>> 	spin_unlock(s);
> >>> 	spin_lock(s);
> >>> 	r1 = READ_ONCE(*y);
> >>> }

> >> So I would indeed expect this to be forbidden. Could someone please
> >> explain how this could be allowed?

> I think an RCpc interpretation of .aq and .rl would in fact allow
> the two normal loads in P1 to be reordered.  Wouldn't it?  Does that
> go against what the LKMM requires?
> 
> The intuition would be that the amoswap.w.aq can forward from the
> amoswap.w.rl while that's still in the store buffer, and then the
> lw x3,0(x4) can also perform while the amoswap.w.rl is still in
> the store buffer, all before the l1 x1,0(x2) executes.  That's
> not forbidden unless the amoswaps are RCsc, unless I'm missing
> something.

So here you're equating flushing the store buffer to RCsc. Is that
entirely fair? Can't a local store-buffer flush still not mean global
visibility, similarly, could not a store-buffer have internal ordering,
such that it guarantees to flush writes in-order? Employing for example
multiple stages / generations.

That is, I think there's quite a bit of gray area here.

But even with the store buffer, the STORE-RELEASE could 'wait' for all
prior LOADs to complete before issuing the STORE. It could also
increment a store-buffer generation before issuing, such that it would,
once it gets about flushing things, issue the STOREs in the 'promised'
order.

> Likewise even if the unlock()/lock() is between two stores.  A
> control dependency might originate from the load part of the
> amoswap.w.aq, but there still would have to be something to
> ensure that this load part in fact performs after the store
> part of the amoswap.w.rl performs globally, and that's not
> automatic under RCpc.

Right, so I think we have different definitions of what RCpc means, and
I suspect I might be the odd one out. And its not just spinlocks.

> >>
> >>> C unlock-lock-write-ordering
> >>>
> >>> {}
> >>> /* s initially owned by P0 */
> >>>
> >>> P0(int *x, int *y, spinlock_t *s)
> >>> {
> >>> 	WRITE_ONCE(*x, 1);
> >>> 	spin_unlock(s);
> >>> 	spin_lock(s);
> >>> 	WRITE_ONCE(*y, 1);
> >>> }
> >>>
> >>> P1(int *x, int *y)
> >>> {
> >>> 	int r0;
> >>> 	int r1;
> >>>
> >>> 	r0 = READ_ONCE(*y);
> >>> 	smp_rmb();
> >>> 	r1 = READ_ONCE(*y);
> >>> }
> >>>
> >>> exists (1:r0=1 /\ 1:r1=0)
> >>>
> >>> RISCV RISCV-unlock-lock-write-ordering
> >>> {
> >>> 0:x2=x; 0:x4=y; 0:x6=s;
> >>> 1:x2=y; 1:x4=x;
> >>> s=1;
> >>> }
> >>>  P0                       | P1           ;
> >>>  ori x1,x0,1              | lw x1,0(x2)  ;
> >>>  sw x1,0(x2)              | fence r,r    ;
> >>>  amoswap.w.rl x0,x0,(x6)  | lw x3,0(x4)  ;
> >>>  ori x5,x0,1              |              ;
> >>>  amoswap.w.aq x0,x5,(x6)  |              ;
> >>>  ori x3,x0,1              |              ;
> >>>  sw x3,0(x4)              |              ;
> >>> exists
> >>> (1:x1=1 /\ 1:x3=0)
> >>
> >> And here I think the RISCV conversion is flawed, there should be a ctrl
> >> dependency. The second store-word in P0 should depend on the result of
> >> amoswap.w.aq being 0.
> > 
> > You're right: AFAICT, this can be remedied by inserting "beq x0,x5,FAIL00"
> > right after amoswap.w.aq (and this label at the end of P0); this does not
> > change the verdict of the available formalizations reported above however.
> > 
> > (So, AFAICT, the above question remains valid/open.)
> 
> This makes sense, but one other question: Paul mentioned earlier in the
> thread that
> 
> > The PowerPC lock implementation's unlock-lock pair does not order writes
> > from the previous critical section against reads from the later critical
> > section, but it does order other combinations of reads and writes.
> 
> My understanding is that the same logic about control dependencies applies
> here too, right?  In other words, in spite of Peter's claim, the control
> dependency doesn't automatically fix this for RISC-V or for PowerPC?

So what Paul says is that earlier STOREs and later LOADs can reorder
(the TSO reordering) over the RELEASE+ACQUIRE. And that is right, LWSYNC
allows just that one reorder.

The ctrl-dep cannot fix that, ctrl-dep is a LOAD->STORE order, later
STOREs will happen after the earlier LOAD.

But the above example is a STORE->STORE, which LWSYNC _will_ order.

But yes, I remember being confused by that example.

> Peter, in this test you mentioned earlier:
> 
> P0()
> {
> 	WRITE_ONCE(x, 1);
> 	smp_store_release(&y, 1);
> 	r0 = smp_load_acquire(&y);
> 	WRITE_ONCE(z, 1);
> }
> 
> P1()
> {
> 	r1 = READ_ONCE(z);
> 	smp_rmb();
> 	r2 = READ_ONCE(x);
> }
> 
> exists: r0 == 1 /\ r1==1 /\ r2==0
> 
> You expect this to be forbidden too, even if the release and acquire
> are RCpc?  This part I don't follow.  There's no conditional branch
> here to enforce a control dependency.  I get and I agree that
> smp_store_release/smp_load_acquire are different than spin_unlock/
> spin_lock, but isn't that even more reason to allow this one if
> smp_store_release/smp_load_acquire are RCpc without question?

Yes, I was expecting that to be forbidden. My definition of RCpc is such
that ACQUIRE and RELEASE are 'locally' respected.

The TSO archs forbid the above by ordering STOREs, then the only
architectures that implement ACQUIRE/RELEASE are PPC and ARM64 (the rest
uses smp_mb()), ARM64 has globally consistent RELEASE/ACQUIRE and PPC
has their LWSYNC which imposes a local TSO order.

In particular I'm not a great fan of weakening the LKMM further. PPC
is already painfully weak (more so than ARM64), but the proposed RISC-V
would be weaker still.

Of course, I come from x86 so I could be biased, but history has shown
that the weaker this stuff becomes the more painful this all becomes.
Not to mention that we'd have to go audit all existant code for
constructs no longer allowed, which is incredibly painful.

Linus too has expressed his preference for stronger models.
