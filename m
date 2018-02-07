Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbeBGTKV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:10:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41152 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbeBGTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:10:20 -0500
Date: Wed, 7 Feb 2018 20:10:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180207191007.GD25235@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <cab93459-5c44-4049-ae7e-096e37d43737@infradead.org>
 <CA+55aFwV6qePNO9YbjN2ezXcGaF1dPcrcXyTq=1kOcABQ7+TaA@mail.gmail.com>
 <20180207190651.GB25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207190651.GB25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 08:06:51PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 07, 2018 at 11:01:29AM -0800, Linus Torvalds wrote:
> > On Wed, Feb 7, 2018 at 10:38 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 02/07/2018 10:13 AM, Linus Torvalds wrote:
> > >>
> > >> That said, intel only _documents_ UD2 (0f 0b).
> > >
> > > Intel Order Number: 325383-064US, October 2017, documents UD0, UD1, and UD2.
> > > Section A.2.5, Table A-1, says:
> > 
> > Ahh, I had an older version.
> > 
> > Looking at the latest one I can find (325462-065US), it does specify
> > that it has a modrm byte:
> > 
> >   0F FF /r   UD0 1 r32, r/m32
> > 
> > so I think that our opcode maps are wrong, and it's a bit dangerous to
> > put random constants right after the UD0.
> > 
> > Maybe we should make our use of UD0 have a third byte: add a harmless
> > modrm byte before the warning constants?
> > 
> > But yes, at least my objdump just thinks it's a bad 2-byte sequence,
> > and doesn't look at any modrm bytes at all.
> 
> Look what my objdump does:
> 
> $ objdump --version
> GNU objdump (GNU Binutils for Debian) 2.29.90.20180122
> 
> $ objdump -dr defconfig-build/kernel/sched/core.o | grep ud0
>     183a:       0f ff 65 48             ud0    0x48(%rbp),%esp
>     1881:       0f ff c3                ud0    %ebx,%eax
>     18b1:       0f ff 89 c0 48 0f a3    ud0    -0x5cf0b740(%rcx),%ecx
>     1940:       0f ff 89 c0 48 0f a3    ud0    -0x5cf0b740(%rcx),%ecx
>     19c2:       0f ff 89 c0 48 0f a3    ud0    -0x5cf0b740(%rcx),%ecx
> 
> So yeah, we're screwed :-(
> 
> Adding a harmless modr/m to our UD0 would grow the kernel image. ARGGH

PeterA, at the time there was talk of arranging a single byte UD
instruction. Any luck arranging that?
