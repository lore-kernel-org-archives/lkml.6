Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeCMItl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:49:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33394 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCMIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:49:38 -0400
X-Google-Smtp-Source: AG47ELtRRHyMpuPQecSV1Evwe/A8qlfGZ6AmBW5DxXBMtkYGEdnrsHwe36Gi93vEHMdr8JEwrNyeSbiko458qxHvx0Q=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
References: <201803122219.vHl3IwRo%fengguang.wu@intel.com> <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 13 Mar 2018 11:49:17 +0300
Message-ID: <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
Subject: Re: [tip:locking/core 9/11] include/asm-generic/atomic-instrumented.h:288:24:
 sparse: cast truncates bits from constant value (100 becomes 0)
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 6:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Mar 12, 2018 at 5:52 PM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
>> head:   ac605bee0bfab40fd5d11964705e907d2d5a32de
>> commit: 8bf705d130396e69c04cd8e6e010244ad2ce71f4 [9/11] locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
>> reproduce:
>>         # apt-get install sparse
>>         git checkout 8bf705d130396e69c04cd8e6e010244ad2ce71f4
>>         make ARCH=x86_64 allmodconfig
>>         make C=1 CF=-D__CHECK_ENDIAN__
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>    kernel/locking/qspinlock.c:418:22: sparse: incorrect type in assignment (different modifiers) @@    expected struct mcs_spinlock *prev @@    got struct struct mcs_spinlock *prev @@
>>    kernel/locking/qspinlock.c:418:22:    expected struct mcs_spinlock *prev
>>    kernel/locking/qspinlock.c:418:22:    got struct mcs_spinlock [pure] *
>>    kernel/locking/qspinlock_paravirt.h:519:1: sparse: symbol '__pv_queued_spin_unlock_slowpath' was not declared. Should it be static?
>>    kernel/locking/qspinlock.c:418:22: sparse: incorrect type in assignment (different modifiers) @@    expected struct mcs_spinlock *prev @@    got struct struct mcs_spinlock *prev @@
>>    kernel/locking/qspinlock.c:418:22:    expected struct mcs_spinlock *prev
>>    kernel/locking/qspinlock.c:418:22:    got struct mcs_spinlock [pure] *
>>>> include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates bits from constant value (100 becomes 0)
>>
>> vim +288 include/asm-generic/atomic-instrumented.h
>>
>> b06ed71a6 Dmitry Vyukov 2018-01-29  282
>> b06ed71a6 Dmitry Vyukov 2018-01-29  283  static __always_inline unsigned long
>> b06ed71a6 Dmitry Vyukov 2018-01-29  284  cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
>> b06ed71a6 Dmitry Vyukov 2018-01-29  285  {
>> b06ed71a6 Dmitry Vyukov 2018-01-29  286         switch (size) {
>> b06ed71a6 Dmitry Vyukov 2018-01-29  287         case 1:
>> b06ed71a6 Dmitry Vyukov 2018-01-29 @288                 return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
>> b06ed71a6 Dmitry Vyukov 2018-01-29  289         case 2:
>> b06ed71a6 Dmitry Vyukov 2018-01-29  290                 return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
>> b06ed71a6 Dmitry Vyukov 2018-01-29  291         case 4:
>> b06ed71a6 Dmitry Vyukov 2018-01-29  292                 return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
>> b06ed71a6 Dmitry Vyukov 2018-01-29  293         case 8:
>> b06ed71a6 Dmitry Vyukov 2018-01-29  294                 BUILD_BUG_ON(sizeof(unsigned long) != 8);
>> b06ed71a6 Dmitry Vyukov 2018-01-29  295                 return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
>> b06ed71a6 Dmitry Vyukov 2018-01-29  296         }
>> b06ed71a6 Dmitry Vyukov 2018-01-29  297         BUILD_BUG();
>> b06ed71a6 Dmitry Vyukov 2018-01-29  298         return 0;
>> b06ed71a6 Dmitry Vyukov 2018-01-29  299  }
>> b06ed71a6 Dmitry Vyukov 2018-01-29  300
>>
>> :::::: The code at line 288 was first introduced by commit
>> :::::: b06ed71a624ba088a3e3e3ac7d4185f48c7c1660 locking/atomic, asm-generic: Add asm-generic/atomic-instrumented.h
>>
>> :::::: TO: Dmitry Vyukov <dvyukov@google.com>
>> :::::: CC: Ingo Molnar <mingo@kernel.org>
>
>
> I will take a look tomorrow.

It seems that this is due to this guy:

static __always_inline int trylock_clear_pending(struct qspinlock *lock)
{
        struct __qspinlock *l = (void *)lock;

        return !READ_ONCE(l->locked) &&
               (cmpxchg_acquire(&l->locked_pending, _Q_PENDING_VAL,
                                _Q_LOCKED_VAL) == _Q_PENDING_VAL);
}

_Q_PENDING_VAL is 0x100. However, locked_pending is 2 bytes. So it
seems that compiler checks all switch cases, this inevitably will lead
to such warnings.

Any suggestion on how to resolve this? Leave as is?

Off the top of my head I can think of the following solution:

        switch (size) {
        case 1:
                return arch_cmpxchg((u8 *)ptr, (u8)(old * (size !=
1)), (u8)(new * (size != 1)));
        case 2:
                return arch_cmpxchg((u16 *)ptr, (u16)(old * (size !=
2)), (u16)(new * (size != 2)));

But it's too ugly.


FTR, the following was helpful to find invocations with particular size:

 #define cmpxchg(ptr, old, new)                                         \
 ({                                                                     \
+       BUILD_BUG_ON(sizeof(*(ptr)) == 1);                              \
        ((__typeof__(*(ptr)))cmpxchg_size((ptr), (unsigned long)(old),  \
                (unsigned long)(new), sizeof(*(ptr))));                 \
 })
