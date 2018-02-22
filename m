Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeBVOM7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:12:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40080 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932664AbeBVOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:12:57 -0500
X-Google-Smtp-Source: AH8x2272Uvn9TP5MRAkbjYtADJbChLP/hlk6qAr7ed8h6P3PN66uokqKz3lvx8xWzxgtsrVEt/8EOw==
Date: Thu, 22 Feb 2018 15:12:49 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>, Daniel Lustig <dlustig@nvidia.com>,
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
Message-ID: <20180222141249.GA14033@andrea>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222134004.GN25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 02:40:04PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 01:19:50PM +0100, Andrea Parri wrote:
> 
> > C unlock-lock-read-ordering
> > 
> > {}
> > /* s initially owned by P1 */
> > 
> > P0(int *x, int *y)
> > {
> > 	WRITE_ONCE(*x, 1);
> > 	smp_wmb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *x, int *y, spinlock_t *s)
> > {
> > 	int r0;
> > 	int r1;
> > 
> > 	r0 = READ_ONCE(*y);
> > 	spin_unlock(s);
> > 	spin_lock(s);
> > 	r1 = READ_ONCE(*y);
> > }
> > 
> > exists (1:r0=1 /\ 1:r1=0)
> > 
> > RISCV RISCV-unlock-lock-read-ordering
> > {
> > 0:x2=x; 0:x4=y;
> > 1:x2=y; 1:x4=x; 1:x6=s;
> > s=1;
> > }
> >  P0           |  P1                      ;
> >  ori x1,x0,1  | lw x1,0(x2)              ;
> >  sw x1,0(x2)  | amoswap.w.rl x0,x0,(x6)  ;
> >  fence w,w    | ori x5,x0,1              ;
> >  ori x3,x0,1  | amoswap.w.aq x0,x5,(x6)  ;
> >  sw x3,0(x4)  | lw x3,0(x4)              ;
> > exists
> > (1:x1=1 /\ 1:x3=0)
> 
> So I would indeed expect this to be forbidden. Could someone please
> explain how this could be allowed?

As mentioned in IRC, my understanding here is only based on the spec.
referred below and on its (available) formalizations.  I expect that
RISC-V people will be able to provide more information.


> 
> > C unlock-lock-write-ordering
> > 
> > {}
> > /* s initially owned by P0 */
> > 
> > P0(int *x, int *y, spinlock_t *s)
> > {
> > 	WRITE_ONCE(*x, 1);
> > 	spin_unlock(s);
> > 	spin_lock(s);
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	int r0;
> > 	int r1;
> > 
> > 	r0 = READ_ONCE(*y);
> > 	smp_rmb();
> > 	r1 = READ_ONCE(*y);
> > }
> > 
> > exists (1:r0=1 /\ 1:r1=0)
> > 
> > RISCV RISCV-unlock-lock-write-ordering
> > {
> > 0:x2=x; 0:x4=y; 0:x6=s;
> > 1:x2=y; 1:x4=x;
> > s=1;
> > }
> >  P0                       | P1           ;
> >  ori x1,x0,1              | lw x1,0(x2)  ;
> >  sw x1,0(x2)              | fence r,r    ;
> >  amoswap.w.rl x0,x0,(x6)  | lw x3,0(x4)  ;
> >  ori x5,x0,1              |              ;
> >  amoswap.w.aq x0,x5,(x6)  |              ;
> >  ori x3,x0,1              |              ;
> >  sw x3,0(x4)              |              ;
> > exists
> > (1:x1=1 /\ 1:x3=0)
> 
> And here I think the RISCV conversion is flawed, there should be a ctrl
> dependency. The second store-word in P0 should depend on the result of
> amoswap.w.aq being 0.

You're right: AFAICT, this can be remedied by inserting "beq x0,x5,FAIL00"
right after amoswap.w.aq (and this label at the end of P0); this does not
change the verdict of the available formalizations reported above however.

(So, AFAICT, the above question remains valid/open.)

  Andrea


> 
> (strictly speaking there should be a ctrl-dep in the read example too,
> except it'd be pointless for ordering reads, so I accept it being left
> out)
> 
> Again, I cannot see how this could be allowed.
> 
