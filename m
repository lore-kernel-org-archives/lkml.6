Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeCOVCH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:02:07 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34240 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeCOVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:02:06 -0400
X-Google-Smtp-Source: AG47ELvZzZKJ6CAkU4WfXL1d/7kB3kb2b7oH14v3n3Ze1SlfXLNL9J41BVENvg3CYnOm3uDahwUxXoHO9FcvCjMBj48=
MIME-Version: 1.0
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 22:02:04 +0100
X-Google-Sender-Auth: hXd0YqxNgnUZh1JLEtstgT_D9cc
Message-ID: <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 8:04 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Here is a re-spin of the first set of patches which reduce the number of
> syscall invocations from within the kernel; the RFC may be found at
>
> The rationale for this change is described in patch 1 as follows:
>
>         The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
>         and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
>         through kernel entry points, but not from the kernel itself. This
>         will allow cleanups and optimizations to the entry paths *and* to
>         the parts of the kernel code which currently need to pretend to be
>         userspace in order to make use of syscalls.
>
> The whole series can be found at
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-next
>
> and will be submitted for merging for the v4.17-rc1 cycle, probably together
> with another batch of related patches I hope to send out tomorrow as a RFC.

Nice work!

I've already commented on a few patches that now have a kernel-internal
helper function that takes a __user pointer. I think those are all only used
in the early boot code (initramfs etc) that runs before we set_fs() to the
user address space, but it also causes warnings with sparse. If we
can change all of them to take kernel pointers, that would let us avoid
the sparse warnings and start running with a normal user address space
view. Unfortunately, some of the syscall seem to be harder to change to
that than others, so not sure if it's worth the effort.

Another open question are the declarations in include/linux/syscalls.h.
These serve as a help for type-checking today, making sure that
each syscall we refer to from either the syscall table or called
by some kernel function uses the same prototype that matches
the syscall definition, which raises the question of whether we want
to keep the header around at all.

        Arnd
