Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeDFRDW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:03:22 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35365 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDFRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:03:21 -0400
X-Google-Smtp-Source: AIpwx4+LjB00jfgpVQ7BRzWT15LY5dmPnUPXRsKdKLcz172dOJ2j8jDW9WW45fq2QmcOcMbm+z/FGw==
Date: Fri, 6 Apr 2018 19:03:16 +0200
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
Message-ID: <20180406170316.ch67wtduxd6hbecp@gmail.com>
References: <20180405095307.3730-1-linux@dominikbrodowski.net>
 <20180405151933.egmt7ressx2ikdnr@gmail.com>
 <20180405203121.GA27104@light.dominikbrodowski.net>
 <20180406082322.ud37sj3b5ldm7xxd@gmail.com>
 <20180406083436.GA17948@isilmar-4.linta.de>
 <20180406092046.2jqjdzvecmfm6sif@gmail.com>
 <20180406093424.GA908@isilmar-4.linta.de>
 <20180406123420.kf74tgiahaugl35x@gmail.com>
 <20180406130741.GA6087@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406130741.GA6087@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> > I.e. I'd generate the names like this:
> > 
> >     __{x64,x32,ia32}[_compat]_sys_waittid()
> > 
> > The fully consistent nomenclature would be someting like this:
> > 
> >  ffffffff8105f1e0 t            kernel_waitid    # common C function (64-bit kargs)
> >  ffffffff8105f2b0 t               SYS_waitid    # 64-bit uaddr args C function
> >  ffffffff8105f410 T         __x64_sys_waitid    # 64-bit-ptregs -> C stub
> >  ffffffff8105f430 T        __ia32_sys_waitid    # 32-bit-ptregs -> C stub
> >  ffffffff8105f450 t        COMPAT_SYS_waitid    # 32-bit uaddr args C function
> >  ffffffff8105f5e0 T __ia32_compat_sys_waitid    # 32-bit-ptregs -> C stub
> >  ffffffff8105f600 T  __x32_compat_sys_waitid    # 64-bit-ptregs -> C stub
> > 
> > Looks a lot tidier and a lot more logical, doesn't it?
> 
> Indeed. Want me to prepare a new patch 8/8 on top which does the renaming
> (for x86 and for the generic case), or will you do the re-naming while
> merging my patches yourself?

Please do an 8/8 patch that does the rename - I'll push out the first 7 patches so 
they get more testing.

Note, I have not checked the above name space for namespace collisions - but 
unless we are unlucky it should be fine.

BTW., is there any deep reason why some of these names are capitalized?

I.e. could we use:

  ffffffff8105f1e0 t            kernel_waitid    # common C function (64-bit kargs)
  ffffffff8105f2b0 t               sys_waitid    # 64-bit uaddr args C function
  ffffffff8105f410 T         __x64_sys_waitid    # 64-bit-ptregs -> C stub
  ffffffff8105f430 T        __ia32_sys_waitid    # 32-bit-ptregs -> C stub
  ffffffff8105f450 t        compat_sys_waitid    # 32-bit uaddr args C function
  ffffffff8105f5e0 T __ia32_compat_sys_waitid    # 32-bit-ptregs -> C stub
  ffffffff8105f600 T  __x32_compat_sys_waitid    # 64-bit-ptregs -> C stub

?

Note how this reduces naming complexity and increases the self-consistency even more.

Thanks,

	Ingo
