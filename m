Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755508AbeEaPf6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:35:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38849 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755369AbeEaPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:35:56 -0400
X-Google-Smtp-Source: ADUXVKIY8RLf3GwHauZWr4exq+THVnharkjgnlDu5ig+RowmgLcuEhVKC0IA5Kz3+CiDjZAu176wEg==
Date: Thu, 31 May 2018 17:35:54 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: yamada.masahiro@socionext.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        albert@sifive.com, michal.lkml@markovi.net
Subject: Re: [PATCH] riscv: pass machine size to sparse
Message-ID: <20180531153553.kex32gupopdq2nqh@ltop.local>
References: <CAK7LNAT_dnO9Enr+Dg11YTux8JAV3K=k4r_5VP3moUCG8s5XHg@mail.gmail.com>
 <mhng-a4f5b769-8271-4b99-ae61-bbc49fa2286f@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-a4f5b769-8271-4b99-ae61-bbc49fa2286f@palmer-si-x1c4>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 05:09:21AM -0700, Palmer Dabbelt wrote:
> On Mon, 28 May 2018 23:14:20 PDT (-0700), yamada.masahiro@socionext.com wrote:
> > 2018-05-29 15:11 GMT+09:00 Christoph Hellwig <hch@infradead.org>:
> > > On Mon, May 28, 2018 at 06:35:05PM +0200, Luc Van Oostenryck wrote:
> > > > By default, sparse assumes a 64bit machine when compiled on x86-64
> > > > and 32bit when compiled on anything else.
> > > > 
> > > > This can of course create all sort of problems when this doesn't
> > > > correspond to the target's machine size, like issuing false
> > > > warnings like: 'shift too big (32) for type unsigned long' or
> > > > is 64bit while sparse was compiled on a 32bit machine, or worse,
> > > > to not emit legitimate warnings.
> > > > 
> > > > Fix this by passing the appropriate -m32/-m64 flag to sparse.
> > > 
> > > Can we please move this to the common Kbuild code using the
> > > CONFIG_64BIT syombol?  This really should not need boiler plate in
> > > every architecture.
> > 
> > 
> > I agree.
> > 
> > Luc did so for -mbig/little-endian:
> > https://patchwork.kernel.org/patch/10433957/
> > 
> > We should do likewise for -m32/64.
> 
> Sorry for being a bit slow here, but I like the idea of making the
> 32/64-bit issue generic as it seems like it'll be necessary for
> every port.

Sure, Christophe asked it too.
I've sent a new version doing it once and for all for all archs
but I forgot to CC you:
	https://lkml.org/lkml/2018/5/30/948

> Looking through the patch for big/little-endian I did
> notice:
> 
> * RISC-V compilers set "__riscv_xlen" to the length of an X
> (integer) register  in bits.
> * RISC-V compilers define "__riscv", and it doesn't appear we inform
> sparse  about that.
> 
> These two might not be that interesting, but we do already have some
> cases where we're checking for __riscv_xlen in Linux.  I've yet to
> successfully use sparse, but adding at least
> 
>    CHECKFLAGS += -D__riscv
> 
> seems reasonable,

Sure (but I don't see a dependency in the kernel (yet)).

> and possibly also some sort of
> 
>    ifeq ($(CONFIG_ARCH_RV64I),y)
>            CHECKFLAGS += -D__riscv_xlen=64
>    else
>            CHECKFLAGS += -D__riscv_xlen=32
>    fi
> 
> might be necessary.

Yes, this one is really needed.
I'll send a patch for this one and __riscv.

> We strive to follow the generic rules for
> ABI-related stuff like __LP64__ but I don't think there's any
> generic mapping for XLEN.  Similarly there's "__riscv_flen" and
> "__riscv_float_abi_*", but those are less likely to be used by the
> kernel so they're probably not worth worrying about for now.

Yes, I agree.
Note that sparse will define __LP64__ (and _LP64) when in -m64 mode.

> There's also a bunch of other RISC-V macros, the only one of which
> we're currently using is "__riscv_muldiv" (and that's in a manner
> that's unlikely to trigger any sort of static analysis).  Between a
> lack of Kconfig options and a glibc port we're essentially mandating
> IMA right now, so these probably don't matter.

Yes, I just saw. I think also it's better to leave it so for now.
And if it becomes more used, then better to infer it from the compiler
than harcoding it.

Regards,
-- Luc
