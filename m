Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeCPUEf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:04:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36119 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeCPUEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:04:32 -0400
X-Google-Smtp-Source: AG47ELv9x9crRyzQs9SO23OfaqSq4IRuiuUm46gnya26C4gJ40IyWb+nBUJrhaPcxS4in5J+atjJ0h0NN8L5Gd1HP2E=
MIME-Version: 1.0
In-Reply-To: <20180316.143021.1158193720540239477.davem@davemloft.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net> <20180316.143021.1158193720540239477.davem@davemloft.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 12:42:16 -0700
X-Google-Sender-Auth: ZwyMOSYYK5NYwExQ8BgLSlbeXHo
Message-ID: <CA+55aFwo7yA1gm8AUYMEQA8ZNY-9GGF8Oup09jJFvEa4J7C+jA@mail.gmail.com>
Subject: Re: [PATCH -next 00/22] remove in-kernel syscall invocations (part 2
 == netdev)
To: David Miller <davem@davemloft.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:30 AM, David Miller <davem@davemloft.net> wrote:
>
> I imagine one of the things you'd like to do is declare that syscall
> entries use a different (better) argument passing scheme.  For
> example, passing values in registers instead of on the stack.

Actually, it's almost exactly the reverse.

On x86-64, we'd like to just pass the 'struct pt_regs *' pointer, and
have the sys_xyz() function itself just pick out the arguments it
needs from there.

That has a few reasons for it:

 - we can clear all registers at system call entry, which helps defeat
some of the "pass seldom used register with user-controlled value that
survives deep into the callchain" things that people used to leak
information

 - we can streamline the low-level system call code, which needs to
pass around 'struct pt_regs *' anyway, and the system call only picks
up the values it actually needs

 - it's really quite easy(*) to just make the SYSCALL_DEFINEx() macros
just do it all with a wrapper inline function

but it fundamentally means that you *cannot* call 'sys_xyz()' from
within the kernel, unless you then do it with something crazy like

    struct pt_regs myregs;
    ... fill in the right registers for this architecture _if_ this
architecture uses ptregs ..
    sys_xyz(&regs);

which I somehow really doubt you want to do in the networking code.

Now, I did do one version that just created two entrypoints for every
single system call - the "kernel version" and the "real" system call
version. That sucks, because you have two choices:

 - either pointlessly generate extra code for the 200+ system calls
that are *not* used by the kernel

 - or let gcc just merge the two, and make code generation suck where
the real system call just loads the registers and jumps to the common
code.

That second option really does suck, because if you let the compiler
just generate the _single_ system call, it will do the "load actual
value from ptregs" much more nicely, and only when it needs it, and
schedules it all into the system call code.

So just making the rule be: "you mustn't call the SYSCALL_DEFINEx()
functions from anything but the system call code" really makes
everything better.

Then you only need to fix up the *handful* of so system calls that
actually have in-kernel callers.

Many of them end up being things that could be improved on further
anyway (ie there's discussion about further cleanup and trying to
avoid using "set_fs()" for arguments etc, because there already exists
helper functions that take the kernel-space versions, and the
sys_xyz() version is actually just going through stupid extra work for
a kernel user).

                    Linus

(*) The "really quite easy" is only true on 64-bit architectures.
32-bit architectures have issues with packing 64-bit values into two
registers, so using macro expansion with just the number of arguments
doesn't work.
