Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbeCIVaS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:30:18 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38815 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeCIVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:30:16 -0500
X-Google-Smtp-Source: AG47ELsm61bbLiKi0VDPEudvr773Z1fy6ebk7Kcuum85udX6wd5OkE/PGzE3fPICFg3V/yeTkXDbmA==
Date: Fri, 9 Mar 2018 22:30:08 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: albert@sifive.com, Daniel Lustig <dlustig@nvidia.com>,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv/atomic: Strengthen implementations with
 fences
Message-ID: <20180309213008.GA3154@andrea>
References: <20180309183644.GA3092@andrea>
 <mhng-1247409a-cf3c-465c-8ce1-007e5342c380@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-1247409a-cf3c-465c-8ce1-007e5342c380@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 10:54:27AM -0800, Palmer Dabbelt wrote:
> On Fri, 09 Mar 2018 10:36:44 PST (-0800), parri.andrea@gmail.com wrote:

[...]


> >This belongs to the "few style fixes" (in the specific, 80-chars lines)
> >mentioned in the cover letter; I could not resist ;-), but I'll remove
> >them in v3 if you like so.
> 
> No problem, just next time it's a bit easier to not mix the really complicated
> stuff (memory model changes) with the really simple stuff (whitespace changes).

Got it.


> >This proposal relies on the generic definition,
> >
> >   include/linux/atomic.h ,
> >
> >and on the
> >
> >   __atomic_op_acquire()
> >   __atomic_op_release()
> >
> >above to build the acquire/release atomics (except for the xchg,cmpxchg,
> >where the ACQUIRE_BARRIER is inserted conditionally/on success).
> 
> I thought we wanted to use the AQ and RL bits for AMOs, just not for LR/SC
> sequences.  IIRC the AMOs are safe with the current memory model, but I might
> just have some version mismatches in my head.

AMO.aqrl are "safe" w.r.t. the LKMM (as they provide "full-ordering"); OTOH,
AMO.aq and AMO.rl present weaknesses that LKMM (and some kernel developers)
do not "expect".  I was probing this issue in:

  https://marc.info/?l=linux-kernel&m=151930201102853&w=2

(c.f., e.g., test "RISCV-unlock-lock-read-ordering" from that post).

Quoting from the commit message of my patch 1/2:

  "Referring to the "unlock-lock-read-ordering" test reported below,
   Daniel wrote:

     I think an RCpc interpretation of .aq and .rl would in fact
     allow the two normal loads in P1 to be reordered [...]

     [...]

     Likewise even if the unlock()/lock() is between two stores.
     A control dependency might originate from the load part of
     the amoswap.w.aq, but there still would have to be something
     to ensure that this load part in fact performs after the store
     part of the amoswap.w.rl performs globally, and that's not
     automatic under RCpc.

   Simulation of the RISC-V memory consistency model confirmed this
   expectation."

I have just (re)checked these observations against the latest specification,
and my results _confirmed_ these verdicts.

  Andrea
