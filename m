Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBHJfr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:35:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:35:45 -0500
Date: Thu, 8 Feb 2018 10:35:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180208093535.GE25235@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208091302.GD25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 10:13:02AM +0100, Peter Zijlstra wrote:
> _The_ problem is that new binutils cannot sanely decode any function
> that has a WARN in (this very much includes perf annotate):

> new:
> 
> 00000000000016a0 <copy_overflow>:
>     16a0:       48 89 f2                mov    %rsi,%rdx
>     16a3:       89 fe                   mov    %edi,%esi
>     16a5:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
>                         16a8: R_X86_64_32S      .rodata.str1.8+0x288
>     16ac:       e8 00 00 00 00          callq  16b1 <copy_overflow+0x11>
>                         16ad: R_X86_64_PC32     __warn_printk-0x4
>     16b1:       0f ff c3                ud0    %ebx,%eax
>     16b4:       66 90                   xchg   %ax,%ax
>     16b6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>     16bd:       00 00 00 

And note that this example is fairly 'good' as far as things go, it only
eats the single byte ret instruction and is on an instruction boundary
again, so the rest is good.

There are examples where what it eats results in shifting the
instruction boundary and the rest is _complete_ crap.

Look what it does to sched_cpu_dying:


    7199:       48 39 c3                cmp    %rax,%rbx
    719c:       0f 84 cc 00 00 00       je     726e <sched_cpu_dying+0x1fe>
    71a2:       0f ff 41 c6             ud0    -0x3a(%rcx),%eax
    71a6:       87 3c 07                xchg   %edi,(%rdi,%rax,1)
    71a9:       00 00                   add    %al,(%rax)
    71ab:       00 8b 43 04 83 f8       add    %cl,-0x77cfbbd(%rbx)
    71b1:       01 0f                   add    %ecx,(%rdi)
    71b3:       85 4f ff                test   %ecx,-0x1(%rdi)
    71b6:       ff                      (bad)  
    71b7:       ff 48 8b                decl   -0x75(%rax)
    71ba:       44 24 08                rex.R and $0x8,%al


    7199:       48 39 c3                cmp    %rax,%rbx
    719c:       0f 84 cc 00 00 00       je     726e <sched_cpu_dying+0x1fe>
    71a2:       0f ff                   (bad)  
    71a4:       41 c6 87 3c 07 00 00    movb   $0x0,0x73c(%r15)
    71ab:       00 
    71ac:       8b 43 04                mov    0x4(%rbx),%eax
    71af:       83 f8 01                cmp    $0x1,%eax
    71b2:       0f 85 4f ff ff ff       jne    7107 <sched_cpu_dying+0x97>
    71b8:       48 8b 44 24 08          mov    0x8(%rsp),%rax
    71bd:       48 8b 74 24 10          mov    0x10(%rsp),%rsi
