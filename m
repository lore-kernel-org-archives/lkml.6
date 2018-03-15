Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeCOUyW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:54:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46026 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeCOUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:54:20 -0400
X-Google-Smtp-Source: AG47ELtTtZiDNj1x5T1K9BGOKrzeeOxKqvofoy4UaK3AkQ9Ch9xwkeA6mFwlto5fYNfYWs5kzJdgf8G9c8JwQScjCAE=
MIME-Version: 1.0
In-Reply-To: <20180315190529.20943-22-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net> <20180315190529.20943-22-linux@dominikbrodowski.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 21:54:19 +0100
X-Google-Sender-Auth: XuQOzAkQPI2JHSY_x5vIcVfoark
Message-ID: <CAK8P3a0Bfp+KOTgCRLGFMxh-yBu0H_wd-SvJzDbBVvg42QOgVg@mail.gmail.com>
Subject: Re: [PATCH v2 21/36] mm: add ksys_mmap_pgoff() helper; remove
 in-kernel calls to sys_mmap_pgoff()
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 8:05 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Using this helper allows us to avoid the in-kernel calls to the
> sys_mmap_pgoff() syscall.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

It might be a good idea to clean up the sys_mmap2()/sys_mmap_pgoff()
distinction as well: From what I understand (I'm sure Al will correct me
if this is wrong), all 32-bit architectures have a sys_mmap2() syscall
that has a fixed bit shift value, possibly always 12.
sys_mmap_pgoff() is defined to have a shift of PAGE_SHIFT, which
may or may not depend on the kernel configuration.

If we replace the

+SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
+               unsigned long, prot, unsigned long, flags,
+               unsigned long, fd, unsigned long, pgoff)
+{
+       return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
+}

with a corresponding sys_mmap2() definition, it seems we can
simplify a number of architectures that today need to define
sys_mmap2() as a wrapper around sys_mmap_pgoff().

        Arnd
