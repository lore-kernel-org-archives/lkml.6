Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162401AbeCAVyf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:54:35 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44184 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162136AbeCAVya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:54:30 -0500
X-Google-Smtp-Source: AG47ELtzOAJtH3bPtpKJ+8AWzgfqEmb3xiqPpwlXkb8GAEQKT+o7h1hpOaO3/6BZaSW2NfDWUrkeUQ==
Date: Thu, 01 Mar 2018 13:54:29 -0800 (PST)
X-Google-Original-Date: Thu, 01 Mar 2018 13:43:26 PST (-0800)
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and spin_unlock()
In-Reply-To: <20180301151141.GA6430@andrea>
CC: Daniel Lustig <dlustig@nvidia.com>, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        albert@sifive.com, stern@rowland.harvard.edu,
        Will Deacon <will.deacon@arm.com>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@sifive.com>
To: parri.andrea@gmail.com
Message-ID: <mhng-82f403f2-fa94-4fdd-8770-3ee6f79a6752@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Mar 2018 07:11:41 PST (-0800), parri.andrea@gmail.com wrote:
> Hi Daniel,
>
> On Thu, Feb 22, 2018 at 11:47:57AM -0800, Daniel Lustig wrote:
>> On 2/22/2018 10:27 AM, Peter Zijlstra wrote:
>> > On Thu, Feb 22, 2018 at 10:13:17AM -0800, Paul E. McKenney wrote:
>> >> So we have something that is not all that rare in the Linux kernel
>> >> community, namely two conflicting more-or-less concurrent changes.
>> >> This clearly needs to be resolved, either by us not strengthening the
>> >> Linux-kernel memory model in the way we were planning to or by you
>> >> strengthening RISC-V to be no weaker than PowerPC for these sorts of
>> >> externally viewed release-acquire situations.
>> >>
>> >> Other thoughts?
>> >
>> > Like said in the other email, I would _much_ prefer to not go weaker
>> > than PPC, I find that PPC is already painfully weak at times.
>>
>> Sure, and RISC-V could make this work too by using RCsc instructions
>> and/or by using lightweight fences instead.  It just wasn't clear at
>> first whether smp_load_acquire() and smp_store_release() were RCpc,
>> RCsc, or something else, and hence whether RISC-V would actually need
>> to use something stronger than pure RCpc there.  Likewise for
>> spin_unlock()/spin_lock() and everywhere else this comes up.
>
> while digging into riscv's locks and atomics to fix the issues discussed
> earlier in this thread, I became aware of another issue:
>
> Considering here the CMPXCHG primitives, for example, I noticed that the
> implementation currently provides the four variants
>
> 	ATOMIC_OPS(        , .aqrl)
> 	ATOMIC_OPS(_acquire,   .aq)
> 	ATOMIC_OPS(_release,   .rl)
> 	ATOMIC_OPS(_relaxed,      )
>
> (corresponding, resp., to
>
> 	atomic_cmpxchg()
> 	atomic_cmpxchg_acquire()
> 	atomic_cmpxchg_release()
> 	atomic_cmpxchg_relaxed()  )
>
> so that the first variant above ends up doing
>
> 	0:	lr.w.aqrl  %0, %addr
> 		bne        %0, %old, 1f
> 		sc.w.aqrl  %1, %new, %addr
> 		bnez       %1, 0b
>         1:
>
> From Sect. 2.3.5. ("Acquire/Release Ordering") of the Spec.,
>
>  "AMOs with both .aq and .rl set are fully-ordered operations.  Treating
>   the load part and the store part as independent RCsc operations is not
>   in and of itself sufficient to enforce full fencing behavior, but this
>   subtle weak behavior is counterintuitive and not much of an advantage
>   architecturally, especially with lr and sc also available [...]."
>
> I understand that
>
>         { x = y = u = v = 0 }
>
> 	P0()
>
> 	WRITE_ONCE(x, 1);		("relaxed" store, sw)
> 	atomic_cmpxchg(&u, 0, 1);
> 	r0 = READ_ONCE(y);		("relaxed" load, lw)
>
> 	P1()
>
> 	WRITE_ONCE(y, 1);
> 	atomic_cmpxchg(&v, 0, 1);
> 	r1 = READ_ONCE(x);
>
> could result in (u = v = 1 and r0 = r1 = 0) at the end; can you confirm?

cmpxchg isn't an AMO, it's an LR SC sequence, so that blurb doesn't apply.  I 
think "lr.w.aqrl" and "sc.w.aqrl" is not sufficient to perform a fully ordered 
operation (ie, it's an incorrect implementation of atomic_cmpxchg()), but I was 
hoping to get some time to actually internalize this part of the RISC-V memory 
model at some point to be sure.
