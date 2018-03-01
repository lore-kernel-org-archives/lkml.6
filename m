Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031695AbeCAPL5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:11:57 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46537 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031631AbeCAPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:11:56 -0500
X-Google-Smtp-Source: AG47ELsDAVcVmo4/dyl9atNS/WAj03Lczo5IFcshL3lMDiAg0a2ktejzD3vfW2zqYrL/pG7u5/ho+A==
Date: Thu, 1 Mar 2018 16:11:41 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
Message-ID: <20180301151141.GA6430@andrea>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net>
 <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Feb 22, 2018 at 11:47:57AM -0800, Daniel Lustig wrote:
> On 2/22/2018 10:27 AM, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 10:13:17AM -0800, Paul E. McKenney wrote:
> >> So we have something that is not all that rare in the Linux kernel
> >> community, namely two conflicting more-or-less concurrent changes.
> >> This clearly needs to be resolved, either by us not strengthening the
> >> Linux-kernel memory model in the way we were planning to or by you
> >> strengthening RISC-V to be no weaker than PowerPC for these sorts of
> >> externally viewed release-acquire situations.
> >>
> >> Other thoughts?
> > 
> > Like said in the other email, I would _much_ prefer to not go weaker
> > than PPC, I find that PPC is already painfully weak at times.
> 
> Sure, and RISC-V could make this work too by using RCsc instructions
> and/or by using lightweight fences instead.  It just wasn't clear at
> first whether smp_load_acquire() and smp_store_release() were RCpc,
> RCsc, or something else, and hence whether RISC-V would actually need
> to use something stronger than pure RCpc there.  Likewise for
> spin_unlock()/spin_lock() and everywhere else this comes up.

while digging into riscv's locks and atomics to fix the issues discussed
earlier in this thread, I became aware of another issue:

Considering here the CMPXCHG primitives, for example, I noticed that the
implementation currently provides the four variants

	ATOMIC_OPS(        , .aqrl)
	ATOMIC_OPS(_acquire,   .aq)
	ATOMIC_OPS(_release,   .rl)
	ATOMIC_OPS(_relaxed,      )

(corresponding, resp., to

	atomic_cmpxchg()
	atomic_cmpxchg_acquire()
	atomic_cmpxchg_release()
	atomic_cmpxchg_relaxed()  )

so that the first variant above ends up doing

	0:	lr.w.aqrl  %0, %addr
		bne        %0, %old, 1f
		sc.w.aqrl  %1, %new, %addr
		bnez       %1, 0b
        1:                   

>From Sect. 2.3.5. ("Acquire/Release Ordering") of the Spec.,

 "AMOs with both .aq and .rl set are fully-ordered operations.  Treating
  the load part and the store part as independent RCsc operations is not
  in and of itself sufficient to enforce full fencing behavior, but this
  subtle weak behavior is counterintuitive and not much of an advantage
  architecturally, especially with lr and sc also available [...]."

I understand that

        { x = y = u = v = 0 }

	P0()

	WRITE_ONCE(x, 1);		("relaxed" store, sw)
	atomic_cmpxchg(&u, 0, 1);
	r0 = READ_ONCE(y);		("relaxed" load, lw)

	P1()

	WRITE_ONCE(y, 1);
	atomic_cmpxchg(&v, 0, 1);
	r1 = READ_ONCE(x);

could result in (u = v = 1 and r0 = r1 = 0) at the end; can you confirm?

Thanks,
  Andrea
