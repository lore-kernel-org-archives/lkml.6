Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbeBVR1N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:27:13 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12027 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbeBVR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:27:11 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 22 Feb 2018 09:27:10 -0800
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
To: Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-riscv@lists.infradead.org>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
From: Daniel Lustig <dlustig@nvidia.com>
Message-ID: <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
Date: Thu, 22 Feb 2018 09:27:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222141249.GA14033@andrea>
X-Originating-IP: [10.110.39.68]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2018 6:12 AM, Andrea Parri wrote:
> On Thu, Feb 22, 2018 at 02:40:04PM +0100, Peter Zijlstra wrote:
>> On Thu, Feb 22, 2018 at 01:19:50PM +0100, Andrea Parri wrote:
>>
>>> C unlock-lock-read-ordering
>>>
>>> {}
>>> /* s initially owned by P1 */
>>>
>>> P0(int *x, int *y)
>>> {
>>> 	WRITE_ONCE(*x, 1);
>>> 	smp_wmb();
>>> 	WRITE_ONCE(*y, 1);
>>> }
>>>
>>> P1(int *x, int *y, spinlock_t *s)
>>> {
>>> 	int r0;
>>> 	int r1;
>>>
>>> 	r0 = READ_ONCE(*y);
>>> 	spin_unlock(s);
>>> 	spin_lock(s);
>>> 	r1 = READ_ONCE(*y);
>>> }
>>>
>>> exists (1:r0=1 /\ 1:r1=0)
>>>
>>> RISCV RISCV-unlock-lock-read-ordering
>>> {
>>> 0:x2=x; 0:x4=y;
>>> 1:x2=y; 1:x4=x; 1:x6=s;
>>> s=1;
>>> }
>>>  P0           |  P1                      ;
>>>  ori x1,x0,1  | lw x1,0(x2)              ;
>>>  sw x1,0(x2)  | amoswap.w.rl x0,x0,(x6)  ;
>>>  fence w,w    | ori x5,x0,1              ;
>>>  ori x3,x0,1  | amoswap.w.aq x0,x5,(x6)  ;
>>>  sw x3,0(x4)  | lw x3,0(x4)              ;
>>> exists
>>> (1:x1=1 /\ 1:x3=0)
>>
>> So I would indeed expect this to be forbidden. Could someone please
>> explain how this could be allowed?
> 
> As mentioned in IRC, my understanding here is only based on the spec.
> referred below and on its (available) formalizations.  I expect that
> RISC-V people will be able to provide more information.

I think an RCpc interpretation of .aq and .rl would in fact allow
the two normal loads in P1 to be reordered.  Wouldn't it?  Does that
go against what the LKMM requires?

The intuition would be that the amoswap.w.aq can forward from the
amoswap.w.rl while that's still in the store buffer, and then the
lw x3,0(x4) can also perform while the amoswap.w.rl is still in
the store buffer, all before the l1 x1,0(x2) executes.  That's
not forbidden unless the amoswaps are RCsc, unless I'm missing
something.

Likewise even if the unlock()/lock() is between two stores.  A
control dependency might originate from the load part of the
amoswap.w.aq, but there still would have to be something to
ensure that this load part in fact performs after the store
part of the amoswap.w.rl performs globally, and that's not
automatic under RCpc.

In any case, our concern that amoswap.w.rl and amoswap.w.aq might
not actually be sufficient for spin_unlock() and spin_lock() was
what prompted us to start our own internal discussion on this.

FWIW we have made a few clarifications to our spec that haven't
propagated to the public upstream yet, but that should be happening
soon.  In any case as it relates to the questions here, it's
more a matter of us deciding what we should put into the spec in
the end than it is a matter of checking the current text.  In
other words, we're still finalizing things, and there's still
some time to tweak as necessary.

>>
>>> C unlock-lock-write-ordering
>>>
>>> {}
>>> /* s initially owned by P0 */
>>>
>>> P0(int *x, int *y, spinlock_t *s)
>>> {
>>> 	WRITE_ONCE(*x, 1);
>>> 	spin_unlock(s);
>>> 	spin_lock(s);
>>> 	WRITE_ONCE(*y, 1);
>>> }
>>>
>>> P1(int *x, int *y)
>>> {
>>> 	int r0;
>>> 	int r1;
>>>
>>> 	r0 = READ_ONCE(*y);
>>> 	smp_rmb();
>>> 	r1 = READ_ONCE(*y);
>>> }
>>>
>>> exists (1:r0=1 /\ 1:r1=0)
>>>
>>> RISCV RISCV-unlock-lock-write-ordering
>>> {
>>> 0:x2=x; 0:x4=y; 0:x6=s;
>>> 1:x2=y; 1:x4=x;
>>> s=1;
>>> }
>>>  P0                       | P1           ;
>>>  ori x1,x0,1              | lw x1,0(x2)  ;
>>>  sw x1,0(x2)              | fence r,r    ;
>>>  amoswap.w.rl x0,x0,(x6)  | lw x3,0(x4)  ;
>>>  ori x5,x0,1              |              ;
>>>  amoswap.w.aq x0,x5,(x6)  |              ;
>>>  ori x3,x0,1              |              ;
>>>  sw x3,0(x4)              |              ;
>>> exists
>>> (1:x1=1 /\ 1:x3=0)
>>
>> And here I think the RISCV conversion is flawed, there should be a ctrl
>> dependency. The second store-word in P0 should depend on the result of
>> amoswap.w.aq being 0.
> 
> You're right: AFAICT, this can be remedied by inserting "beq x0,x5,FAIL00"
> right after amoswap.w.aq (and this label at the end of P0); this does not
> change the verdict of the available formalizations reported above however.
> 
> (So, AFAICT, the above question remains valid/open.)

This makes sense, but one other question: Paul mentioned earlier in the
thread that

> The PowerPC lock implementation's unlock-lock pair does not order writes
> from the previous critical section against reads from the later critical
> section, but it does order other combinations of reads and writes.

My understanding is that the same logic about control dependencies applies
here too, right?  In other words, in spite of Peter's claim, the control
dependency doesn't automatically fix this for RISC-V or for PowerPC?

> 
>   Andrea
> 
> 
>>
>> (strictly speaking there should be a ctrl-dep in the read example too,
>> except it'd be pointless for ordering reads, so I accept it being left
>> out)
>>
>> Again, I cannot see how this could be allowed.
>>

Peter, in this test you mentioned earlier:

P0()
{
	WRITE_ONCE(x, 1);
	smp_store_release(&y, 1);
	r0 = smp_load_acquire(&y);
	WRITE_ONCE(z, 1);
}

P1()
{
	r1 = READ_ONCE(z);
	smp_rmb();
	r2 = READ_ONCE(x);
}

exists: r0 == 1 /\ r1==1 /\ r2==0

You expect this to be forbidden too, even if the release and acquire
are RCpc?  This part I don't follow.  There's no conditional branch
here to enforce a control dependency.  I get and I agree that
smp_store_release/smp_load_acquire are different than spin_unlock/
spin_lock, but isn't that even more reason to allow this one if
smp_store_release/smp_load_acquire are RCpc without question?

Thanks,
Dan
