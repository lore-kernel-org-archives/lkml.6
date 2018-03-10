Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933784AbeCJAiH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:38:07 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11106 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933725AbeCJAVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:21:38 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 09 Mar 2018 16:21:37 -0800
Subject: Re: [PATCH v2 2/2] riscv/atomic: Strengthen implementations with
 fences
To: Palmer Dabbelt <palmer@sifive.com>, <parri.andrea@gmail.com>
CC: <albert@sifive.com>, <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        <paulmck@linux.vnet.ibm.com>, <akiyks@gmail.com>, <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <mhng-a5cc1e9d-00d5-49e7-8acd-173277f28381@palmer-si-x1c4>
From: Daniel Lustig <dlustig@nvidia.com>
Message-ID: <d7f08bbb-3afb-b745-640a-b720971c68d4@nvidia.com>
Date: Fri, 9 Mar 2018 16:21:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <mhng-a5cc1e9d-00d5-49e7-8acd-173277f28381@palmer-si-x1c4>
X-Originating-IP: [10.110.39.68]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2018 2:57 PM, Palmer Dabbelt wrote:
> On Fri, 09 Mar 2018 13:30:08 PST (-0800), parri.andrea@gmail.com wrote:
>> On Fri, Mar 09, 2018 at 10:54:27AM -0800, Palmer Dabbelt wrote:
>>> On Fri, 09 Mar 2018 10:36:44 PST (-0800), parri.andrea@gmail.com wrote:
>>
>> [...]
>>
>>> >This proposal relies on the generic definition,
>>> >
>>> >   include/linux/atomic.h ,
>>> >
>>> >and on the
>>> >
>>> >   __atomic_op_acquire()
>>> >   __atomic_op_release()
>>> >
>>> >above to build the acquire/release atomics (except for the xchg,cmpxchg,
>>> >where the ACQUIRE_BARRIER is inserted conditionally/on success).
>>>
>>> I thought we wanted to use the AQ and RL bits for AMOs, just not for LR/SC
>>> sequences.  IIRC the AMOs are safe with the current memory model, but I might
>>> just have some version mismatches in my head.
>>
>> AMO.aqrl are "safe" w.r.t. the LKMM (as they provide "full-ordering"); OTOH,
>> AMO.aq and AMO.rl present weaknesses that LKMM (and some kernel developers)
>> do not "expect".  I was probing this issue in:
>>
>>   https://marc.info/?l=linux-kernel&m=151930201102853&w=2
>>
>> (c.f., e.g., test "RISCV-unlock-lock-read-ordering" from that post).
>>
>> Quoting from the commit message of my patch 1/2:
>>
>>   "Referring to the "unlock-lock-read-ordering" test reported below,
>>    Daniel wrote:
>>
>>      I think an RCpc interpretation of .aq and .rl would in fact
>>      allow the two normal loads in P1 to be reordered [...]
>>
>>      [...]
>>
>>      Likewise even if the unlock()/lock() is between two stores.
>>      A control dependency might originate from the load part of
>>      the amoswap.w.aq, but there still would have to be something
>>      to ensure that this load part in fact performs after the store
>>      part of the amoswap.w.rl performs globally, and that's not
>>      automatic under RCpc.
>>
>>    Simulation of the RISC-V memory consistency model confirmed this
>>    expectation."
>>
>> I have just (re)checked these observations against the latest specification,
>> and my results _confirmed_ these verdicts.
> 
> Thanks, I must have just gotten confused about a draft spec or something.  I'm
> pulling these on top or your other memory model related patch.  I've renamed
> the branch "next-mm" to be a bit more descriptiove.

(Sorry for being out of the loop this week, I was out to deal with
a family matter.)

I assume you're using the herd model?  Luc's doing a great job with
that, but even so, nothing is officially confirmed until we ratify
the model.  In other words, the herd model may end up changing too.
If something is broken on our end, there's still time to fix it.

Regarding AMOs, let me copy from something I wrote in a previous
offline conversation:

> it seems to us that pairing a store-release of "amoswap.rl" with
> a "ld; fence r,rw" doesn't actually give us the RC semantics we've
> been discussing for LKMM.  For example:
> 
> (a) sd t0,0(s0)
> (b) amoswap.d.rl x0,t1,0(s1)
>     ...
> (c) ld a0,0(s1)
> (d) fence r,rw
> (e) sd t2,0(s2)
> 
> There, we won't get (a) ordered before (e) regardless of whether
> (b) is RCpc or RCsc.  Do you agree?

At the moment, only the load part of (b) is in the predecessor
set of (d), but the store part of (b) is not.  Likewise, the
.rl annotation applies only to the store part of (b), not the
load part.

This gets back to a question Linus asked last week about
whether the AMO is a single unit or whether it can be
considered to split into a load and a store part (which still
perform atomically).  For RISC-V, for right now at least, the
answer is the latter.  Is it still the latter for Linux too?

https://lkml.org/lkml/2018/2/26/606

> So I think we'll need to make sure we pair .rl with .aq, or that
> we pair fence-based mappings with fence-based mappings, in order
> to make the acquire/release operations work.

This assumes we'll say that .aq and .rl are RCsc, not RCpc.
But in this case, I think .aq and .rl could still be safe to use,
as long as you don't ever try to mix in a fence-based mapping
on the same data structure like in the example above.  That
might be important if we want to find the most compact legal
implementation, and hence do want to use .aq and .rl after all.

> And since we don't have native "ld.aq" today in RISC-V, that
> would mean smp_store_release would have to remain implemented
> as "fence rw,w; s{w|d}", rather than "amoswap.{w|d}.rl", for
> example.

Thoughts?

Thanks,
Dan

> 
> Thanks!
