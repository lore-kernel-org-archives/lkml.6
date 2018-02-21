Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965880AbeBUNuB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:50:01 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35883 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965461AbeBUNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:49:57 -0500
X-Google-Smtp-Source: AH8x224HQAsnR9k1hyqOpw9hGuTQjq34ILIFBK1kRGty3WI/rAu6x3UOPT38dj3kjZTcf8cNS+/9pA==
Date: Wed, 21 Feb 2018 19:19:52 +0530
From: gaurav jindal <gauravjindal1104@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]sched: completion: use bool in try_wait_for_completion
Message-ID: <20180221134952.GA15980@gmail.com>
References: <20180221125407.GA14292@gmail.com>
 <20180221132854.GK25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221132854.GK25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 02:28:54PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 21, 2018 at 06:24:07PM +0530, gaurav jindal wrote:
> > Variable ret in try_wait_for_completion can have only true/false values. Since
> > the return type of the function is also bool, variable ret should have data
> > type as bool in place of int.
> 
> Fair enough.
> 
> > Moreover, the size of bool in many platforms is 1 byte whereas size of int is
> > 4 bytes(though architecture dependent). Modifying the data type reduces the 
> > size consumed for the stack.
> 
> Absolutely 0 difference in generated assembly here on x86_64-defconfig
> gcc Debian 7.2.0-20.
> 
> $ objdump -dr defconfig-build/kernel/sched/completion.o | awk '/^$/ {p=0} /<try_wait_for_completion>:$/ {p=1} {if (p) print $0}'
> 
> 0000000000000090 <try_wait_for_completion>:
>   90:   41 54                   push   %r12
>   92:   55                      push   %rbp
>   93:   31 ed                   xor    %ebp,%ebp
>   95:   53                      push   %rbx
>   96:   8b 07                   mov    (%rdi),%eax
>   98:   85 c0                   test   %eax,%eax
>   9a:   75 07                   jne    a3 <try_wait_for_completion+0x13>
>   9c:   89 e8                   mov    %ebp,%eax
>   9e:   5b                      pop    %rbx
>   9f:   5d                      pop    %rbp
>   a0:   41 5c                   pop    %r12
>   a2:   c3                      retq   
>   a3:   4c 8d 67 08             lea    0x8(%rdi),%r12
>   a7:   48 89 fb                mov    %rdi,%rbx
>   aa:   4c 89 e7                mov    %r12,%rdi
>   ad:   e8 00 00 00 00          callq  b2 <try_wait_for_completion+0x22>
>                         ae: R_X86_64_PC32       _raw_spin_lock_irqsave-0x4
>   b2:   8b 13                   mov    (%rbx),%edx
>   b4:   85 d2                   test   %edx,%edx
>   b6:   74 0f                   je     c7 <try_wait_for_completion+0x37>
>   b8:   83 fa ff                cmp    $0xffffffff,%edx
>   bb:   bd 01 00 00 00          mov    $0x1,%ebp
>   c0:   74 05                   je     c7 <try_wait_for_completion+0x37>
>   c2:   83 ea 01                sub    $0x1,%edx
>   c5:   89 13                   mov    %edx,(%rbx)
>   c7:   48 89 c6                mov    %rax,%rsi
>   ca:   4c 89 e7                mov    %r12,%rdi
>   cd:   e8 00 00 00 00          callq  d2 <try_wait_for_completion+0x42>
>                         ce: R_X86_64_PC32       _raw_spin_unlock_irqrestore-0x4
>   d2:   89 e8                   mov    %ebp,%eax
>   d4:   5b                      pop    %rbx
>   d5:   5d                      pop    %rbp
>   d6:   41 5c                   pop    %r12
>   d8:   c3                      retq   
>   d9:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)
> 
> Note how it keeps the return value in eax and doesn't spill to the
> stack. And I would expect this to be true for most architectures that
> have register based calling conventions, its an otherwise fairly trivial
> function.
>
I completely agree. I got carried away with sizeof(). Missed the case of using
the local registers.
Thanks a lot for guiding me again.
> I'll take the patch though, but I'll remove that last bit from the
> Changelog.
