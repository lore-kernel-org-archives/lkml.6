Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeDFMe1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:34:27 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33342 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDFMeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:34:25 -0400
X-Google-Smtp-Source: AIpwx49Ekx1bgBl096hLPPjHonpaeZslmO0l7hy5cgBoMfEpEP8bB3edFVdphP1DxoFmVzdNTXi+ig==
Date: Fri, 6 Apr 2018 14:34:20 +0200
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
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/8] use struct pt_regs based syscall calling for x86-64
Message-ID: <20180406123420.kf74tgiahaugl35x@gmail.com>
References: <20180405095307.3730-1-linux@dominikbrodowski.net>
 <20180405151933.egmt7ressx2ikdnr@gmail.com>
 <20180405203121.GA27104@light.dominikbrodowski.net>
 <20180406082322.ud37sj3b5ldm7xxd@gmail.com>
 <20180406083436.GA17948@isilmar-4.linta.de>
 <20180406092046.2jqjdzvecmfm6sif@gmail.com>
 <20180406093424.GA908@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406093424.GA908@isilmar-4.linta.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> > > __sys_mprotect as prefix won't work by the way, as the double-underscore __sys_ 
> > > variant is already used in net/* for internal syscall helpers.
> > 
> > Ok - then triple underscore - but overall I think it's more confusing.
> > 
> > Btw., what was the problem with calling the x86 ptregs wrapper sys_mprotect?
> > 
> > The only reason I suggested the __sys_x86_ prefix was because you originally 
> > suggested that there's symbol name overlap, but I don't think that's the case 
> > within the same kernel build, as the regular non-ptregs prototype:
> 
> Indeed, there's no symbol name overlap within the same kernel build, but
> technically different stubs named the same. If that's fine, just drop patch
> 8/8 (including the UML fixup) and things should be fine, with the stub and
> the entry in the syscall table both named sys_mprotect.

Ok, I've dropped patch #8.

> For IA32_EMULATION, we have __sys_ia32_mprotect as stub for the same
> syscall, including this name as entry in syscall_32.tbl.
> 
> More problematic is the naming for the compat stubs for IA32_EMAULATION and
> X32, where we have
> 
> 	__compat_sys_ia32_waitid
> 	__compat_sys_x32_waitid
> 
> for example. We *could* rename one of those to compat_sys_waitid() and levae
> the other as-is, but actually I prefer it now how it is.

yeah, this is more symmetric I think.

So right now we have these symbols:

 triton:~/tip> grep waitid System.map 

 ffffffff8105f1e0 t kernel_waitid               # common C function (64-bit kargs)
 ffffffff8105f2b0 t SYSC_waitid                 # 64-bit uaddr args C function       352 bytes
 ffffffff8105f410 T sys_waitid                  # 64-bit-ptregs -> C stub,            32 bytes
 ffffffff8105f430 T __sys_ia32_waitid           # 32-bit-ptregs -> C stub,            32 bytes
 ffffffff8105f450 t C_SYSC_waitid               # 32-bit uaddr args C function,      400 bytes
 ffffffff8105f5e0 T __compat_sys_ia32_waitid    # 32-bit-ptregs -> C stub,            32 bytes
 ffffffff8105f600 T __compat_sys_x32_waitid     # 64-bit-ptregs -> C stub,            32 bytes

BTW., what is the role of generating __sys_ia32_waitid()? It seems unused when a 
syscall has a compat variant otherwise - like here.

Naming wise the odd thumb out is sys_waitid :-/

I'd argue that we should at minimum name it __sys_waitid:

 ffffffff8105f1e0 t kernel_waitid               # common C function (64-bit kargs)
 ffffffff8105f2b0 t SYSC_waitid                 # 64-bit uaddr args C function
 ffffffff8105f410 T __sys_waitid                # 64-bit-ptregs -> C stub
 ffffffff8105f430 T __sys_ia32_waitid           # 32-bit-ptregs -> C stub
 ffffffff8105f450 t C_SYSC_waitid               # 32-bit uaddr args C function
 ffffffff8105f5e0 T __compat_sys_ia32_waitid    # 32-bit-ptregs -> C stub
 ffffffff8105f600 T __compat_sys_x32_waitid     # 64-bit-ptregs -> C stub

because that makes it all organized based on the same principle:

    {__compat|_}_sys{_ia32|_x32|}_waittid

But arguably there are a whole lot more naming weirdnesses we could fix:

 - I find it somewhat confusing that that 'C' in C_SYSC stands not for a C callign 
   convention, but for 'COMPAT' - i.e. COMPAT_SYSC would be better.

 - Another detail is that why is it called 'SYSC', if the other functions use the 
   'sys' prefix? Wouldn't 'SYS' be more consistent?

 - If we introduced a prefix for the regular 64-bit system call format as well,
   we could have: x64, x32 and ia32.

 - And finally, I think the argument format modifiers should be consistently
   prefixes - right now they are a mixture of pre- and post-fixes.

I.e. I'd generate the names like this:

    __{x64,x32,ia32}[_compat]_sys_waittid()

The fully consistent nomenclature would be someting like this:

 ffffffff8105f1e0 t            kernel_waitid    # common C function (64-bit kargs)
 ffffffff8105f2b0 t               SYS_waitid    # 64-bit uaddr args C function
 ffffffff8105f410 T         __x64_sys_waitid    # 64-bit-ptregs -> C stub
 ffffffff8105f430 T        __ia32_sys_waitid    # 32-bit-ptregs -> C stub
 ffffffff8105f450 t        COMPAT_SYS_waitid    # 32-bit uaddr args C function
 ffffffff8105f5e0 T __ia32_compat_sys_waitid    # 32-bit-ptregs -> C stub
 ffffffff8105f600 T  __x32_compat_sys_waitid    # 64-bit-ptregs -> C stub

Looks a lot tidier and a lot more logical, doesn't it?

Makes grepping easier as well, because (case-insensitive) patterns like 
'sys_waittid' would identify all the variants.

Personally I'd also do a s/ia32/i32 rename:

 ffffffff8105f1e0 t            kernel_waitid    # common C function (64-bit kargs)
 ffffffff8105f2b0 t               SYS_waitid    # 64-bit uaddr args C function
 ffffffff8105f410 T         __x64_sys_waitid    # 64-bit-ptregs -> C stub
 ffffffff8105f430 T         __i32_sys_waitid    # 32-bit-ptregs -> C stub
 ffffffff8105f450 t        COMPAT_SYS_waitid    # 32-bit uaddr args C function
 ffffffff8105f5e0 T  __i32_compat_sys_waitid    # 32-bit-ptregs -> C stub
 ffffffff8105f600 T  __x32_compat_sys_waitid    # 64-bit-ptregs -> C stub

... but maybe that's too much ;-)

Thanks,

	Ingo
