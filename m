Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeCPQrz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:47:55 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40655 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeCPQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:47:53 -0400
X-Google-Smtp-Source: AG47ELsc7t1fLXd8PakLD9G96eg/9buk5Dgft7QnmGmvNTcxrIl4XJT90+UXOBETqH0Rw5HFNGbLM1HcikW3EdRksUc=
MIME-Version: 1.0
In-Reply-To: <20180316142043.GC30522@ZenIV.linux.org.uk>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
 <CALCETrX_1pxfB10k-uj7vSyXm7hH4MeJiEY=+A3FzViaozb+BA@mail.gmail.com>
 <CA+55aFyJBTaBuA1LjG5RjcD7ZCivYYQWqb3A+HbJZGUdZE9i6w@mail.gmail.com>
 <20180316085423.GH4151@infradead.org> <20180316142043.GC30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 09:47:52 -0700
X-Google-Sender-Auth: jREQBH2Pw2_BZ4OYpGBhX8o_YdE
Message-ID: <CA+55aFwCTRNCm26RKtBti9rYZghsrt4G8eeG=Byj4dZrzr-PEw@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 7:20 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Mar 16, 2018 at 01:54:23AM -0700, Christoph Hellwig wrote:
>>
>> A lot of the issues here is that the initramfs / do_mount code
>> is written as if it was user space code, but in kernel space.  E.g.
>> using file desriptors etc.

Yeah, some of it could probably pass a 'struct filp *' around instead.

So there are definitely things we could do once we no longer use the
raw system calls anyway.

> ... and I still wonder if it would make more sense to kick that crap
> out into userland.

Oh, no, let's not do that. Even if we were to still maintain control
of user space, it would mean yet another nasty special case for the
compiler and linker scripts and for our initrd generation.

And if we were to spin it out entirely (aka udevd and friends), it
would become one of those nasty situations where there's some *very*
odd code that we need to keep compatibility with because you might run
a new kernel and some old "pre-init user code" stuff.

I'd much rather just make it look more like kernel code.

And maybe remove some code entirely. Christ, we still have the logic
in there to change *floppies* if the ramdisk doesn't fit on a single
floppy disk.  Does it work? Probably not, since presumably it hasn't
been used in ages. But it's still there.

So some of the ioctl's etc are due to insanely old legacy cases.

                 Linus
