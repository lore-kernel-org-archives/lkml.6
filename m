Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeBQPOW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 10:14:22 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36308 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeBQPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 10:14:21 -0500
X-Google-Smtp-Source: AH8x227EKj2DtfKTIyADL673C0Gt2uYPCdFpjVNhxESZCMWFLcdpLKaB+jOR2fKZ5fJBfrICsz2trQ==
Date: Sat, 17 Feb 2018 16:14:13 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Message-ID: <20180217151413.GA3785@andrea>
References: <20180216165301.GF3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802161707350.1402-100000@iolanthe.rowland.org>
 <20180217032535.GA1125@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217032535.GA1125@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 04:25:35AM +0100, Andrea Parri wrote:
> On Fri, Feb 16, 2018 at 05:22:55PM -0500, Alan Stern wrote:
> > Since commit 76ebbe78f739 ("locking/barriers: Add implicit
> > smp_read_barrier_depends() to READ_ONCE()") was merged for the 4.15
> > kernel, it has not been necessary to use smp_read_barrier_depends().
> > Similarly, commit 59ecbbe7b31c ("locking/barriers: Kill
> > lockless_dereference()") removed lockless_dereference() from the
> > kernel.
> > 
> > Since these primitives are no longer part of the kernel, they do not
> > belong in the Linux Kernel Memory Consistency Model.  This patch
> > removes them, along with the internal rb-dep relation, and updates the
> > revelant documentation.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > ---
> 
> [...]
> 
> 
> > Index: usb-4.x/tools/memory-model/linux-kernel.def
> > ===================================================================
> > --- usb-4.x/tools/memory-model.orig/linux-kernel.def
> > +++ usb-4.x/tools/memory-model/linux-kernel.def
> > @@ -13,14 +13,12 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
> >  smp_store_release(X,V) { __store{release}(*X,V); }
> >  smp_load_acquire(X) __load{acquire}(*X)
> >  rcu_assign_pointer(X,V) { __store{release}(X,V); }
> > -lockless_dereference(X) __load{lderef}(X)
> >  rcu_dereference(X) __load{deref}(X)
> 
> ^^^ __load{once}
> 
> 
> >  
> >  // Fences
> >  smp_mb() { __fence{mb} ; }
> >  smp_rmb() { __fence{rmb} ; }
> >  smp_wmb() { __fence{wmb} ; }
> > -smp_read_barrier_depends() { __fence{rb_dep}; }
> >  smp_mb__before_atomic() { __fence{before-atomic} ; }
> >  smp_mb__after_atomic() { __fence{after-atomic} ; }
> >  smp_mb__after_spinlock() { __fence{after-spinlock} ; }
> > Index: usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
> > ===================================================================
> > --- usb-4.x/tools/memory-model.orig/Documentation/cheatsheet.txt
> > +++ usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
> > @@ -6,8 +6,7 @@
> >  Store, e.g., WRITE_ONCE()            Y                                       Y
> >  Load, e.g., READ_ONCE()              Y                              Y        Y
> >  Unsuccessful RMW operation           Y                              Y        Y
> > -smp_read_barrier_depends()              Y                       Y   Y
> > -*_dereference()                      Y                          Y   Y        Y
> > +rcu_dereference()                    Y                          Y   Y        Y
> >  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> >  Successful *_release()         C        Y  Y    Y     W                      Y
> >  smp_rmb()                               Y       R        Y      Y        R
> 
> Akira's observation about READ_ONCE extends to all (annotated) loads.  In
> fact, it also applies to loads corresponding to unsuccessful RMW operations;
> consider, for example, the following variation of MP+onceassign+derefonce:
> 
> C T
> 
> {
> y=z;
> z=0;
> }
> 
> P0(int *x, int **y)
> {
> 	WRITE_ONCE(*x, 1);
> 	smp_store_release(y, x);
> }
> 
> P1(int **y, int *z)
> {
> 	int *r0;
> 	int r1;
> 
> 	r0 = cmpxchg_relaxed(y, z, z);
> 	r1 = READ_ONCE(*r0);
> }
> 
> exists (1:r0=x /\ 1:r1=0)
> 
> The final state is allowed w/o the patch, and forbidden w/ the patch.
> 
> This also reminds me of
> 
>    5a8897cc7631fa544d079c443800f4420d1b173f
>    ("locking/atomics/alpha: Add smp_read_barrier_depends() to _release()/_relaxed() atomics")
> 
> (that we probably want to mention in the commit message).

Please also notice that 5a8897cc7631f only touched alpha's atomic.h:
I see no corresponding commit/change on {,cmp}xchg.h (where the "mb"
is currently conditionally executed).

  Andrea


> 
>   Andrea
> 
> 
> > 
> > 
