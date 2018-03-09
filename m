Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeCIW6D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:58:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37568 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeCIW6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:58:01 -0500
X-Google-Smtp-Source: AG47ELvYAPeaOSTRlh8RzbZMGEJpztfqP2eIdaOhh9m61cwo6xdSuO0V34demZSS6+QNr5pP/x5IHw==
Date: Fri, 09 Mar 2018 14:57:59 -0800 (PST)
X-Google-Original-Date: Fri, 09 Mar 2018 14:57:57 PST (-0800)
Subject: Re: [PATCH v2 2/2] riscv/atomic: Strengthen implementations with fences
In-Reply-To: <20180309213008.GA3154@andrea>
CC: albert@sifive.com, Daniel Lustig <dlustig@nvidia.com>,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: parri.andrea@gmail.com
Message-ID: <mhng-a5cc1e9d-00d5-49e7-8acd-173277f28381@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Mar 2018 13:30:08 PST (-0800), parri.andrea@gmail.com wrote:
> On Fri, Mar 09, 2018 at 10:54:27AM -0800, Palmer Dabbelt wrote:
>> On Fri, 09 Mar 2018 10:36:44 PST (-0800), parri.andrea@gmail.com wrote:
>
> [...]
>
>
>> >This belongs to the "few style fixes" (in the specific, 80-chars lines)
>> >mentioned in the cover letter; I could not resist ;-), but I'll remove
>> >them in v3 if you like so.
>>
>> No problem, just next time it's a bit easier to not mix the really complicated
>> stuff (memory model changes) with the really simple stuff (whitespace changes).
>
> Got it.
>
>
>> >This proposal relies on the generic definition,
>> >
>> >   include/linux/atomic.h ,
>> >
>> >and on the
>> >
>> >   __atomic_op_acquire()
>> >   __atomic_op_release()
>> >
>> >above to build the acquire/release atomics (except for the xchg,cmpxchg,
>> >where the ACQUIRE_BARRIER is inserted conditionally/on success).
>>
>> I thought we wanted to use the AQ and RL bits for AMOs, just not for LR/SC
>> sequences.  IIRC the AMOs are safe with the current memory model, but I might
>> just have some version mismatches in my head.
>
> AMO.aqrl are "safe" w.r.t. the LKMM (as they provide "full-ordering"); OTOH,
> AMO.aq and AMO.rl present weaknesses that LKMM (and some kernel developers)
> do not "expect".  I was probing this issue in:
>
>   https://marc.info/?l=linux-kernel&m=151930201102853&w=2
>
> (c.f., e.g., test "RISCV-unlock-lock-read-ordering" from that post).
>
> Quoting from the commit message of my patch 1/2:
>
>   "Referring to the "unlock-lock-read-ordering" test reported below,
>    Daniel wrote:
>
>      I think an RCpc interpretation of .aq and .rl would in fact
>      allow the two normal loads in P1 to be reordered [...]
>
>      [...]
>
>      Likewise even if the unlock()/lock() is between two stores.
>      A control dependency might originate from the load part of
>      the amoswap.w.aq, but there still would have to be something
>      to ensure that this load part in fact performs after the store
>      part of the amoswap.w.rl performs globally, and that's not
>      automatic under RCpc.
>
>    Simulation of the RISC-V memory consistency model confirmed this
>    expectation."
>
> I have just (re)checked these observations against the latest specification,
> and my results _confirmed_ these verdicts.

Thanks, I must have just gotten confused about a draft spec or something.  I'm
pulling these on top or your other memory model related patch.  I've renamed
the branch "next-mm" to be a bit more descriptiove.

Thanks!
