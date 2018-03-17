Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbeCQRW0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:22:26 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35190 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753315AbeCQRVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:12 -0400
Date: Sat, 17 Mar 2018 18:13:51 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
Message-ID: <20180317171351.GE3351@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 10:02:04PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 8:04 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > Here is a re-spin of the first set of patches which reduce the number of
> > syscall invocations from within the kernel; the RFC may be found at
> >
> > The rationale for this change is described in patch 1 as follows:
> >
> >         The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
> >         and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
> >         through kernel entry points, but not from the kernel itself. This
> >         will allow cleanups and optimizations to the entry paths *and* to
> >         the parts of the kernel code which currently need to pretend to be
> >         userspace in order to make use of syscalls.
> >
> > The whole series can be found at
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-next
> >
> > and will be submitted for merging for the v4.17-rc1 cycle, probably together
> > with another batch of related patches I hope to send out tomorrow as a RFC.
> 
> Nice work!
> 
> I've already commented on a few patches that now have a kernel-internal
> helper function that takes a __user pointer. I think those are all only used
> in the early boot code (initramfs etc) that runs before we set_fs() to the
> user address space, but it also causes warnings with sparse. If we
> can change all of them to take kernel pointers, that would let us avoid
> the sparse warnings and start running with a normal user address space
> view. Unfortunately, some of the syscall seem to be harder to change to
> that than others, so not sure if it's worth the effort.

Thanks for your review -- on this issue, please see my other messages.

> Another open question are the declarations in include/linux/syscalls.h.
> These serve as a help for type-checking today, making sure that
> each syscall we refer to from either the syscall table or called
> by some kernel function uses the same prototype that matches
> the syscall definition, which raises the question of whether we want
> to keep the header around at all.

Well, we do not want to call syscalls from other kernel functions, so that
issue will go away by means of these patchsets anyway. With regard to
type-checking the syscall table, we might want to keep the definitions
around and/or generate prototypes from SYSCALL_DEFINEx() directly.

Thanks,
	Dominik
