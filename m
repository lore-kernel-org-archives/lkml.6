Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeCJOSf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 09:18:35 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35641 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeCJOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 09:18:31 -0500
X-Google-Smtp-Source: AG47ELtIdbuHLy2SQtU3U3wCwm0Zk2EM+CcVPLDZm9NihPHCk/ixe+Z6DOtsjYPLd5S134XEBVgD0w==
Date: Sat, 10 Mar 2018 15:18:23 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, albert@sifive.com,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv/atomic: Strengthen implementations with
 fences
Message-ID: <20180310141823.GA5420@andrea>
References: <mhng-a5cc1e9d-00d5-49e7-8acd-173277f28381@palmer-si-x1c4>
 <d7f08bbb-3afb-b745-640a-b720971c68d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7f08bbb-3afb-b745-640a-b720971c68d4@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 04:21:37PM -0800, Daniel Lustig wrote:
> On 3/9/2018 2:57 PM, Palmer Dabbelt wrote:
> > On Fri, 09 Mar 2018 13:30:08 PST (-0800), parri.andrea@gmail.com wrote:
> >> On Fri, Mar 09, 2018 at 10:54:27AM -0800, Palmer Dabbelt wrote:
> >>> On Fri, 09 Mar 2018 10:36:44 PST (-0800), parri.andrea@gmail.com wrote:
> >>
> >> [...]
> >>
> >>> >This proposal relies on the generic definition,
> >>> >
> >>> >   include/linux/atomic.h ,
> >>> >
> >>> >and on the
> >>> >
> >>> >   __atomic_op_acquire()
> >>> >   __atomic_op_release()
> >>> >
> >>> >above to build the acquire/release atomics (except for the xchg,cmpxchg,
> >>> >where the ACQUIRE_BARRIER is inserted conditionally/on success).
> >>>
> >>> I thought we wanted to use the AQ and RL bits for AMOs, just not for LR/SC
> >>> sequences.  IIRC the AMOs are safe with the current memory model, but I might
> >>> just have some version mismatches in my head.
> >>
> >> AMO.aqrl are "safe" w.r.t. the LKMM (as they provide "full-ordering"); OTOH,
> >> AMO.aq and AMO.rl present weaknesses that LKMM (and some kernel developers)
> >> do not "expect".  I was probing this issue in:
> >>
> >>   https://marc.info/?l=linux-kernel&m=151930201102853&w=2
> >>
> >> (c.f., e.g., test "RISCV-unlock-lock-read-ordering" from that post).
> >>
> >> Quoting from the commit message of my patch 1/2:
> >>
> >>   "Referring to the "unlock-lock-read-ordering" test reported below,
> >>    Daniel wrote:
> >>
> >>      I think an RCpc interpretation of .aq and .rl would in fact
> >>      allow the two normal loads in P1 to be reordered [...]
> >>
> >>      [...]
> >>
> >>      Likewise even if the unlock()/lock() is between two stores.
> >>      A control dependency might originate from the load part of
> >>      the amoswap.w.aq, but there still would have to be something
> >>      to ensure that this load part in fact performs after the store
> >>      part of the amoswap.w.rl performs globally, and that's not
> >>      automatic under RCpc.
> >>
> >>    Simulation of the RISC-V memory consistency model confirmed this
> >>    expectation."
> >>
> >> I have just (re)checked these observations against the latest specification,
> >> and my results _confirmed_ these verdicts.
> > 
> > Thanks, I must have just gotten confused about a draft spec or something.  I'm
> > pulling these on top or your other memory model related patch.  I've renamed
> > the branch "next-mm" to be a bit more descriptiove.
> 
> (Sorry for being out of the loop this week, I was out to deal with
> a family matter.)
> 
> I assume you're using the herd model?  Luc's doing a great job with
> that, but even so, nothing is officially confirmed until we ratify
> the model.  In other words, the herd model may end up changing too.
> If something is broken on our end, there's still time to fix it.

No need to say :) if you look back at the LKMM as from 2 years ago or as
presented last year in LWN, you won't recognize it as such ;-)  Spec. do
change/evolve, and so do implementations: if ratifications of the RISC-V
memory model (or of the LKMM) will enable optimizations/modifications to
these implementations (while preserving correctness), I'll be glad to do
or to help with them.

To answer your question: I used both the herd-based model from INRIA and
the operational model from the group in Cambridge (these are referred to
in the currently available RISC-V spec.).


> 
> Regarding AMOs, let me copy from something I wrote in a previous
> offline conversation:
> 
> > it seems to us that pairing a store-release of "amoswap.rl" with
> > a "ld; fence r,rw" doesn't actually give us the RC semantics we've
> > been discussing for LKMM.  For example:
> > 
> > (a) sd t0,0(s0)
> > (b) amoswap.d.rl x0,t1,0(s1)
> >     ...
> > (c) ld a0,0(s1)
> > (d) fence r,rw
> > (e) sd t2,0(s2)
> > 
> > There, we won't get (a) ordered before (e) regardless of whether
> > (b) is RCpc or RCsc.  Do you agree?
> 
> At the moment, only the load part of (b) is in the predecessor
> set of (d), but the store part of (b) is not.  Likewise, the
> .rl annotation applies only to the store part of (b), not the
> load part.

Indeed.  (If you want, this is one reason why, with these patches, ".rl"
and "fence r,rw" are never "mixed" as in your snipped above unless there
is also a "fence rw,rw" in between.)


> 
> This gets back to a question Linus asked last week about
> whether the AMO is a single unit or whether it can be
> considered to split into a load and a store part (which still
> perform atomically).  For RISC-V, for right now at least, the
> answer is the latter.  Is it still the latter for Linux too?

Yes: (successful) atomic RMWs all generate (at least) one load event and
one store event in LKMM.  (This same approach is taken by other hardware
models as well...)


> 
> https://lkml.org/lkml/2018/2/26/606
> 
> > So I think we'll need to make sure we pair .rl with .aq, or that
> > we pair fence-based mappings with fence-based mappings, in order
> > to make the acquire/release operations work.
> 
> This assumes we'll say that .aq and .rl are RCsc, not RCpc.
> But in this case, I think .aq and .rl could still be safe to use,
> as long as you don't ever try to mix in a fence-based mapping
> on the same data structure like in the example above.  That
> might be important if we want to find the most compact legal
> implementation, and hence do want to use .aq and .rl after all.
> 
> > And since we don't have native "ld.aq" today in RISC-V, that
> > would mean smp_store_release would have to remain implemented
> > as "fence rw,w; s{w|d}", rather than "amoswap.{w|d}.rl", for
> > example.

And these seem to be further valid/strong arguments for these patches ;)
(independently of how you'll end up ratifying .aq and .rl).

  Andrea


> 
> Thoughts?
> 
> Thanks,
> Dan
> 
> > 
> > Thanks!
