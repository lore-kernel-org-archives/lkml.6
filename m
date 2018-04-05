Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDEJze (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:55:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbeDEJzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:55:32 -0400
Date: Thu, 5 Apr 2018 10:55:45 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] locking/mutex: Optimize __mutex_trylock_fast
Message-ID: <20180405095544.GB23485@arm.com>
References: <20180405093716.GR4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405093716.GR4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Apr 05, 2018 at 11:37:16AM +0200, Peter Zijlstra wrote:
> Subject: locking/mutex: Optimize __mutex_trylock_fast()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Apr  5 11:05:35 CEST 2018
> 
> Use try_cmpxchg to avoid the pointless TEST instruction..
> And add the (missing) atomic_long_try_cmpxchg*() wrappery.
> 
> On x86_64 this gives:
> 
> 0000000000000710 <mutex_lock>:						0000000000000710 <mutex_lock>:
>  710:   65 48 8b 14 25 00 00    mov    %gs:0x0,%rdx                      710:   65 48 8b 14 25 00 00    mov    %gs:0x0,%rdx
>  717:   00 00                                                            717:   00 00
>                         715: R_X86_64_32S       current_task                                    715: R_X86_64_32S       current_task
>  719:   31 c0                   xor    %eax,%eax                         719:   31 c0                   xor    %eax,%eax
>  71b:   f0 48 0f b1 17          lock cmpxchg %rdx,(%rdi)                 71b:   f0 48 0f b1 17          lock cmpxchg %rdx,(%rdi)
>  720:   48 85 c0                test   %rax,%rax                         720:   75 02                   jne    724 <mutex_lock+0x14>
>  723:   75 02                   jne    727 <mutex_lock+0x17>             722:   f3 c3                   repz retq
>  725:   f3 c3                   repz retq                                724:   eb da                   jmp    700 <__mutex_lock_slowpath>
>  727:   eb d7                   jmp    700 <__mutex_lock_slowpath>
> 
> On ARM64 this gives:
> 
> 000000000000638 <mutex_lock>:						0000000000000638 <mutex_lock>:
>      638:       d5384101        mrs     x1, sp_el0                           638:       d5384101        mrs     x1, sp_el0
>      63c:       d2800002        mov     x2, #0x0                             63c:       d2800002        mov     x2, #0x0
>      640:       f9800011        prfm    pstl1strm, [x0]                      640:       f9800011        prfm    pstl1strm, [x0]
>      644:       c85ffc03        ldaxr   x3, [x0]                             644:       c85ffc03        ldaxr   x3, [x0]
>      648:       ca020064        eor     x4, x3, x2                           648:       ca020064        eor     x4, x3, x2
>      64c:       b5000064        cbnz    x4, 658 <mutex_lock+0x20>            64c:       b5000064        cbnz    x4, 658 <mutex_lock+0x20>
>      650:       c8047c01        stxr    w4, x1, [x0]                         650:       c8047c01        stxr    w4, x1, [x0]
>      654:       35ffff84        cbnz    w4, 644 <mutex_lock+0xc>             654:       35ffff84        cbnz    w4, 644 <mutex_lock+0xc>
>      658:       b40000c3        cbz     x3, 670 <mutex_lock+0x38>            658:       b5000043        cbnz    x3, 660 <mutex_lock+0x28>
>      65c:       a9bf7bfd        stp     x29, x30, [sp,#-16]!                 65c:       d65f03c0        ret
>      660:       910003fd        mov     x29, sp                              660:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
>      664:       97ffffef        bl      620 <__mutex_lock_slowpath>          664:       910003fd        mov     x29, sp
>      668:       a8c17bfd        ldp     x29, x30, [sp],#16                   668:       97ffffee        bl      620 <__mutex_lock_slowpath>
>      66c:       d65f03c0        ret                                          66c:       a8c17bfd        ldp     x29, x30, [sp],#16
>      670:       d65f03c0        ret                                          670:       d65f03c0        ret
> 
> Which to my untrained eye just looks different, not worse. Will?

Yeah, looks fine. The compiler has just decided to move the slowpath out of
line. One comment on the patch:

> 
> Reported-by: Matthew Wilcox <mawilcox@microsoft.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/atomic-long.h |   17 +++++++++++++++++
>  kernel/locking/mutex.c            |    3 ++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> --- a/include/asm-generic/atomic-long.h
> +++ b/include/asm-generic/atomic-long.h
> @@ -25,6 +25,7 @@ typedef atomic64_t atomic_long_t;
>  
>  #define ATOMIC_LONG_INIT(i)	ATOMIC64_INIT(i)
>  #define ATOMIC_LONG_PFX(x)	atomic64 ## x
> +#define ATOMIC_LONG_TYPE	s64
>  
>  #else
>  
> @@ -32,6 +33,7 @@ typedef atomic_t atomic_long_t;
>  
>  #define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
>  #define ATOMIC_LONG_PFX(x)	atomic ## x
> +#define ATOMIC_LONG_TYPE	int
>  
>  #endif
>  
> @@ -90,6 +92,21 @@ ATOMIC_LONG_ADD_SUB_OP(sub, _release)
>  #define atomic_long_cmpxchg(l, old, new) \
>  	(ATOMIC_LONG_PFX(_cmpxchg)((ATOMIC_LONG_PFX(_t) *)(l), (old), (new)))
>  
> +
> +#define atomic_long_try_cmpxchg_relaxed(l, old, new) \
> +	(ATOMIC_LONG_PFX(_try_cmpxchg_relaxed)((ATOMIC_LONG_PFX(_t) *)(l), \
> +					   (ATOMIC_LONG_TYPE *)(old), (ATOMIC_LONG_TYPE)(new)))

Are the casts on old and new strictly needed? We don't have them for the
non-try versions...

Will
