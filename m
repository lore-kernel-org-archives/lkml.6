Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeCMKq5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:46:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeCMKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:46:56 -0400
Date: Tue, 13 Mar 2018 11:46:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:locking/core 9/11]
 include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates
 bits from constant value (100 becomes 0)
Message-ID: <20180313104652.GK4043@hirez.programming.kicks-ass.net>
References: <201803122219.vHl3IwRo%fengguang.wu@intel.com>
 <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
 <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:49:17AM +0300, Dmitry Vyukov wrote:
> On Mon, Mar 12, 2018 at 6:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Mar 12, 2018 at 5:52 PM, kbuild test robot
> >>    kernel/locking/qspinlock.c:418:22: sparse: incorrect type in assignment (different modifiers) @@    expected struct mcs_spinlock *prev @@    got struct struct mcs_spinlock *prev @@
> >>    kernel/locking/qspinlock.c:418:22:    expected struct mcs_spinlock *prev
> >>    kernel/locking/qspinlock.c:418:22:    got struct mcs_spinlock [pure] *

> >> b06ed71a6 Dmitry Vyukov 2018-01-29  283  static __always_inline unsigned long
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  284  cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  285  {
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  286         switch (size) {
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  287         case 1:
> >> b06ed71a6 Dmitry Vyukov 2018-01-29 @288                 return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  289         case 2:
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  290                 return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  291         case 4:
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  292                 return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  293         case 8:
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  294                 BUILD_BUG_ON(sizeof(unsigned long) != 8);
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  295                 return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  296         }
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  297         BUILD_BUG();
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  298         return 0;
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  299  }
> >> b06ed71a6 Dmitry Vyukov 2018-01-29  300

> It seems that this is due to this guy:
> 
> static __always_inline int trylock_clear_pending(struct qspinlock *lock)
> {
>         struct __qspinlock *l = (void *)lock;
> 
>         return !READ_ONCE(l->locked) &&
>                (cmpxchg_acquire(&l->locked_pending, _Q_PENDING_VAL,
>                                 _Q_LOCKED_VAL) == _Q_PENDING_VAL);
> }
> 
> _Q_PENDING_VAL is 0x100. However, locked_pending is 2 bytes. So it
> seems that compiler checks all switch cases, this inevitably will lead
> to such warnings.
> 
> Any suggestion on how to resolve this? Leave as is?

I'm not sure I understand what it thinks is wrong. Can't we fix sparse
to not be stupid? The actual compilers don't seem to a have a problem
with this.

> Off the top of my head I can think of the following solution:
> 
>         switch (size) {
>         case 1:
>                 return arch_cmpxchg((u8 *)ptr, (u8)(old * (size !=
> 1)), (u8)(new * (size != 1)));
>         case 2:
>                 return arch_cmpxchg((u16 *)ptr, (u16)(old * (size !=
> 2)), (u16)(new * (size != 2)));
> 
> But it's too ugly.

Yes agreed, that's horrendous.
