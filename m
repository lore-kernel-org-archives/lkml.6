Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeFEWl4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:41:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38153 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeFEWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:41:54 -0400
X-Google-Smtp-Source: ADUXVKIPU0Z47SJ6oiyc1wzAHHTQg/ChX3/vy/wmCRRcRtlBB+dYv0vyoKM0QFuvqmc0HWMph2xaCg==
Date: Wed, 6 Jun 2018 01:41:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: x86/asm: __clear_user() micro-optimization (was: "Re: [GIT PULL]
 x86/asm changes for v4.18")
Message-ID: <20180605224150.GA2051@avx2>
References: <20180604122132.GA3337@gmail.com>
 <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
 <20180605150514.GA31065@gmail.com>
 <20180605172243.GA2059@avx2>
 <CA+55aFxTve6FxLuvWyyD88ACOg+3eHKbpWUeuvNZMSB=AFfuqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxTve6FxLuvWyyD88ACOg+3eHKbpWUeuvNZMSB=AFfuqg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:32:55AM -0700, Linus Torvalds wrote:
> On Tue, Jun 5, 2018 at 10:22 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Tested? :^) I had P4 maybe ~15(?) years ago.
> 
> Did you EVEN test it on what you have today?
> 
> Do you have any numbers at all, in other words?
> 
> Micro-optimizations need numbers. Otherwise they aren't
> micro-optimizations, they are just "change code randomly".

On my potato performance increase is 33%, sheesh.
And CPU starts doing 3 instructions per cycle vs 2.

benchmark is "clear_user(p + 4096 - 4068, 4068)"
4068 comes from booting Debian 8 with printk.

f0(4068) (old clear_user)
--------
$ taskset -c 15 perf stat -r 16 ./a.out

 Performance counter stats for './a.out' (16 runs):

       2033.189084      task-clock (msec)         #    1.000 CPUs utilized            ( +-  0.41% )
                 2      context-switches          #    0.001 K/sec                    ( +- 11.11% )
                 0      cpu-migrations            #    0.000 K/sec
                46      page-faults               #    0.023 K/sec                    ( +-  0.91% )
     4,268,425,486      cycles                    #    2.099 GHz                      ( +-  0.41% )
     8,672,326,256      instructions              #    2.03  insn per cycle           ( +-  0.00% )
     2,169,900,710      branches                  # 1067.240 M/sec                    ( +-  0.00% )
         4,226,258      branch-misses             #    0.19% of all branches          ( +-  0.01% )

       2.033700109 seconds time elapsed                                          ( +-  0.41% )

f1(4068) (new clear_user)
$ taskset -c 15 perf stat -r 16 ./a.out

 Performance counter stats for './a.out' (16 runs):

       1345.149992      task-clock (msec)         #    1.000 CPUs utilized            ( +-  0.01% )
                 2      context-switches          #    0.002 K/sec                    ( +-  8.35% )
                 0      cpu-migrations            #    0.000 K/sec
                46      page-faults               #    0.034 K/sec                    ( +-  0.82% )
     2,823,965,728      cycles                    #    2.099 GHz                      ( +-  0.01% )
     8,661,733,733      instructions              #    3.07  insn per cycle           ( +-  0.00% )
     2,169,437,410      branches                  # 1612.785 M/sec                    ( +-  0.00% )
         4,216,469      branch-misses             #    0.19% of all branches          ( +-  0.01% )

       1.345375114 seconds time elapsed                                          ( +-  0.01% )

-------------------------------------
CFLAGS = -Wall -fno-strict-aliasing -fno-common -fshort-wchar -std=gnu89 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -funit-at-a-time -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -O2 --param=allow-store-data-races=0 -fno-stack-protector -fomit-frame-pointer -fno-var-tracking-assignments -g -femit-struct-debug-baseonly -fno-var-tracking -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack


0000000000000780 <f0>:
 780:	mov    rax,rsi
 783:	mov    rcx,rsi
 786:	xor    edx,edx
 788:	and    eax,0x7
 78b:	shr    rcx,0x3
 78f:	mov    esi,0x8
 794:	test   rcx,rcx
 797:	je     7a3 <f0+0x23>
 799:	mov    QWORD PTR [rdi],rdx
 79c:	add    rdi,rsi
 79f:	dec    ecx
 7a1:	jne    799 <f0+0x19>
 7a3:	mov    rcx,rax
 7a6:	test   ecx,ecx
 7a8:	je     7b3 <f0+0x33>
 7aa:	mov    BYTE PTR [rdi],dl
 7ac:	inc    rdi
 7af:	dec    ecx
 7b1:	jne    7aa <f0+0x2a>
 7b3:	mov    rax,rcx
 7b6:	ret    

00000000000007c0 <f1>:
 7c0:	mov    rax,rsi
 7c3:	shr    rsi,0x3
 7c7:	and    eax,0x7
 7ca:	mov    rcx,rsi
 7cd:	test   rcx,rcx
 7d0:	je     7e1 <f1+0x21>
 7d2:	mov    QWORD PTR [rdi],0x0
 7d9:	add    rdi,0x8
 7dd:	dec    ecx
 7df:	jne    7d2 <f1+0x12>
 7e1:	mov    rcx,rax
 7e4:	test   ecx,ecx
 7e6:	je     7f2 <f1+0x32>
 7e8:	mov    BYTE PTR [rdi],0x0
 7eb:	inc    rdi
 7ee:	dec    ecx
 7f0:	jne    7e8 <f1+0x28>
 7f2:	mov    rax,rcx
 7f5:	ret    
