Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeBHJrs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:47:48 -0500
Received: from smtp-out6.electric.net ([192.162.217.184]:52476 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeBHJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:47:13 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Peter Zijlstra'" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: RE: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Thread-Topic: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Thread-Index: AQHToL03icJf9dEsh0CUsXZRWYp/2aOaQUaA
Date: Thu, 8 Feb 2018 09:47:53 +0000
Message-ID: <c636fea6531b4c579f86e39c557b4c0d@AcuMS.aculab.com>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net>
In-Reply-To: <20180208091302.GD25201@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 08 February 2018 09:13
...
> > > Yeah, note says UD0 didn't eat a ModRM byte on old CPUs. But then that
> > > changed too. Fun stuff changing insn encoding underway.
> > >
> > > So if we opt for adding a ModRM byte, could a 0x90 NOP work so that it
> > > doesn't shit itself on those old CPUs?
> >
> > We could just also decide that the only thing that the modrm bytes of
> > UD0 actually *affect* is how the CPU might act for a page-crossing
> > instruction.
> >
> > Because I think that's the only semantic difference: if it's a
> > page-crosser, the instruction could take a page fault before raising
> > the #UD.
> >
> > Is there any other decode issue we might want to look out for?
> 
> _The_ problem is that new binutils cannot sanely decode any function
> that has a WARN in (this very much includes perf annotate):
> 
> old:
> 
> 00000000000016a0 <copy_overflow>:
>     16a0:       48 89 f2                mov    %rsi,%rdx
>     16a3:       89 fe                   mov    %edi,%esi
>     16a5:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
>                         16a8: R_X86_64_32S      .rodata.str1.8+0x288
>     16ac:       e8 00 00 00 00          callq  16b1 <copy_overflow+0x11>
>                         16ad: R_X86_64_PC32     __warn_printk-0x4
>     16b1:       0f ff                   (bad)
>     16b3:       c3                      retq
>     16b4:       66 90                   xchg   %ax,%ax
>     16b6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>     16bd:       00 00 00
> 
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
> 
> 
> I went through the register opcodes and matched it against the ModR/M
> encoding, and the best option I've found so far is using 0xd6 as the
> next byte.

Wouldn't 0xc3 work as well.
A retq is probably better than an extra (bad).

Actually objdump ought to be more explicit than (bad) for the explicit UD0/1

	David
