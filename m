Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeDFJUx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:20:53 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45724 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeDFJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:20:50 -0400
X-Google-Smtp-Source: AIpwx48bcHZXeZyFDH87cWB839IO33QX/tZouq3IS4hnTjXqjBJ51MTD29FsTFjdxftQcQXL27vOXA==
Date: Fri, 6 Apr 2018 11:20:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
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
Message-ID: <20180406092046.2jqjdzvecmfm6sif@gmail.com>
References: <20180405095307.3730-1-linux@dominikbrodowski.net>
 <20180405151933.egmt7ressx2ikdnr@gmail.com>
 <20180405203121.GA27104@light.dominikbrodowski.net>
 <20180406082322.ud37sj3b5ldm7xxd@gmail.com>
 <20180406083436.GA17948@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406083436.GA17948@isilmar-4.linta.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Fri, Apr 06, 2018 at 10:23:22AM +0200, Ingo Molnar wrote:
> > 
> > * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > 
> > > On Thu, Apr 05, 2018 at 05:19:33PM +0200, Ingo Molnar wrote:
> > > > Ok, this series looks mostly good to me, but AFAICS this breaks the UML build:
> > > > 
> > > >  make[2]: *** No rule to make target 'archheaders'.  Stop.
> > > >  arch/um/Makefile:119: recipe for target 'archheaders' failed
> > > >  make[1]: *** [archheaders] Error 2
> > > >  make[1]: *** Waiting for unfinished jobs....
> > > 
> > > Ah, that's caused by patch 8/8 which I did and do not like all that much
> > > anyway: UML re-uses syscall_64.tbl which now has x86-specific entries like
> > > __sys_x86_pread64, but expects the generic syscall stub sys_pread64
> > > referenced there. Fixup patch below; could be folded with patch 8/8. Or
> > > patch 8/8 could simply be dropped from the series altogether...
> > 
> > I still like the 'truth in advertising' aspect. For example if I see this in the 
> > syscall table:
> > 
> >  10      common  mprotect                __sys_x86_mprotect
> > 
> > I can immediately find the _real_ syscall entry point:
> > 
> > ffffffff81180a10 <__sys_x86_mprotect>:
> > ffffffff81180a10:       48 8b 57 60             mov    0x60(%rdi),%rdx
> > ffffffff81180a14:       48 8b 77 68             mov    0x68(%rdi),%rsi
> > ffffffff81180a18:       b9 ff ff ff ff          mov    $0xffffffff,%ecx
> > ffffffff81180a1d:       48 8b 7f 70             mov    0x70(%rdi),%rdi
> > ffffffff81180a21:       e8 fa fc ff ff          callq  ffffffff81180720 <do_mprotect_pkey>
> > ffffffff81180a26:       48 98                   cltq   
> > ffffffff81180a28:       c3                      retq   
> > ffffffff81180a29:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)
> > 
> > If, on the other hand, I see this entry:
> > 
> >  10     common  mprotect                sys_mprotect
> > 
> > Then, as a first step, no symbol anywhere matches with this:
> > 
> >  triton:~/tip> grep sys_mprotect System.map 
> >  triton:~/tip> 
> > 
> > "sys_mprotect" does not exist in any easily discoverable sense. You have to *know* 
> > to replace the sys_ prefix with __sys_x86_ to find it.
> > 
> > Now arguably we could use a __sys_ prefix instead of the grep-barrier __sys_x86 
> > prefix - but that too would be somewhat confusing I think.
> 
> Well, if looking at the ARCH="um" kernel, you won't find the __sys_x86_mprotect 
> there in its System.map -- so we either have to disentangle um and plain x86, or 
> live with some cause for confusion.

I'm primarily concerned about everything making sense on x86 - UML is an entirely 
separate architecture with heavy tradeoffs and kludges.

> __sys_mprotect as prefix won't work by the way, as the double-underscore __sys_ 
> variant is already used in net/* for internal syscall helpers.

Ok - then triple underscore - but overall I think it's more confusing.

Btw., what was the problem with calling the x86 ptregs wrapper sys_mprotect?

The only reason I suggested the __sys_x86_ prefix was because you originally 
suggested that there's symbol name overlap, but I don't think that's the case 
within the same kernel build, as the regular non-ptregs prototype:

  asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot);

... will only exist on !CONFIG_ARCH_HAS_SYSCALL_WRAPPER kernels.

So maybe that's the simplest and least confusing solution.

Thanks,

	Ingo
