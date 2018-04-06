Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeDFIbF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:31:05 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54540 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeDFIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:31:02 -0400
Date: Fri, 6 Apr 2018 10:31:00 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 0/8] use struct pt_regs based syscall calling for x86-64
Message-ID: <20180406083100.GA11279@isilmar-4.linta.de>
References: <20180405095307.3730-1-linux@dominikbrodowski.net>
 <20180405151933.egmt7ressx2ikdnr@gmail.com>
 <20180405203121.GA27104@light.dominikbrodowski.net>
 <20180406082322.ud37sj3b5ldm7xxd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406082322.ud37sj3b5ldm7xxd@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 10:23:22AM +0200, Ingo Molnar wrote:
> 
> * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > On Thu, Apr 05, 2018 at 05:19:33PM +0200, Ingo Molnar wrote:
> > > Ok, this series looks mostly good to me, but AFAICS this breaks the UML build:
> > > 
> > >  make[2]: *** No rule to make target 'archheaders'.  Stop.
> > >  arch/um/Makefile:119: recipe for target 'archheaders' failed
> > >  make[1]: *** [archheaders] Error 2
> > >  make[1]: *** Waiting for unfinished jobs....
> > 
> > Ah, that's caused by patch 8/8 which I did and do not like all that much
> > anyway: UML re-uses syscall_64.tbl which now has x86-specific entries like
> > __sys_x86_pread64, but expects the generic syscall stub sys_pread64
> > referenced there. Fixup patch below; could be folded with patch 8/8. Or
> > patch 8/8 could simply be dropped from the series altogether...
> 
> I still like the 'truth in advertising' aspect. For example if I see this in the 
> syscall table:
> 
>  10      common  mprotect                __sys_x86_mprotect
> 
> I can immediately find the _real_ syscall entry point:
> 
> ffffffff81180a10 <__sys_x86_mprotect>:
> ffffffff81180a10:       48 8b 57 60             mov    0x60(%rdi),%rdx
> ffffffff81180a14:       48 8b 77 68             mov    0x68(%rdi),%rsi
> ffffffff81180a18:       b9 ff ff ff ff          mov    $0xffffffff,%ecx
> ffffffff81180a1d:       48 8b 7f 70             mov    0x70(%rdi),%rdi
> ffffffff81180a21:       e8 fa fc ff ff          callq  ffffffff81180720 <do_mprotect_pkey>
> ffffffff81180a26:       48 98                   cltq   
> ffffffff81180a28:       c3                      retq   
> ffffffff81180a29:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)
> 
> If, on the other hand, I see this entry:
> 
>  10     common  mprotect                sys_mprotect
> 
> Then, as a first step, no symbol anywhere matches with this:
> 
>  triton:~/tip> grep sys_mprotect System.map 
>  triton:~/tip> 
> 
> "sys_mprotect" does not exist in any easily discoverable sense. You have to *know* 
> to replace the sys_ prefix with __sys_x86_ to find it.
> 
> Now arguably we could use a __sys_ prefix instead of the grep-barrier __sys_x86 
> prefix - but that too would be somewhat confusing I think.
> 
> I mean, the fact that we are passing in a ptregs pointer is a complexity of the 
> x86 kernel that *exists*, why hide it and make it harder to discover what's 
> happening, for something as important as system calls?
> 
> In terms of UML breakage, UML arguably is tightly coupled to its host 
> architecture:
> 
> > Subject: [PATCH] syscalls/x86: fix UML syscall table
> 
> Even with your patch applied I still see build failures:
> 
>   $ make ARCH=um defconfig
>   $ make ARCH=um linux
>   ...
>   arch/um/os-Linux/signal.c: In function ‘hard_handler’:
>   arch/um/os-Linux/signal.c:163:22: error: dereferencing pointer to incomplete type 
>   ‘struct ucontext’
>     mcontext_t *mc = &uc->uc_mcontext;
>                         ^~
>   scripts/Makefile.build:324: recipe for target 'arch/um/os-Linux/signal.o' failed
>   make[1]: *** [arch/um/os-Linux/signal.o] Error 1

That build failure is already present in mainline as of 38c23685b273
(when building on Arch / gcc-7.3.1; building on Debian oldstable / gcc-4.9
works fine). And -- just checked -- this build failure also exists for
plain v4.16.

Thanks,
	Dominik
