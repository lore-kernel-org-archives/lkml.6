Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeDEPTl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:19:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37482 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeDEPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:19:37 -0400
X-Google-Smtp-Source: AIpwx488JiuYTse0dK0Q0KtskgPjFBOOobu5uF0E1o0SgL1Xt6qr/zm+z/byZzR+lk4KA5UPCK9EYg==
Date: Thu, 5 Apr 2018 17:19:33 +0200
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
Message-ID: <20180405151933.egmt7ressx2ikdnr@gmail.com>
References: <20180405095307.3730-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405095307.3730-1-linux@dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Dominik Brodowski (7):
>   syscalls: introduce CONFIG_ARCH_HAS_SYSCALL_WRAPPER
>   syscalls/x86: use struct pt_regs based syscall calling for 64-bit
>     syscalls
>   syscalls: prepare ARCH_HAS_SYSCALL_WRAPPER for compat syscalls
>   syscalls/x86: use struct pt_regs based syscall calling for
>     IA32_EMULATION and x32
>   syscalls/x86: unconditionally enable struct pt_regs based syscalls on
>     x86_64
>   x86/entry/64: extend register clearing on syscall entry to lower
>     registers
>   syscalls/x86: rename struct pt_regs-based sys_*() to __sys_x86_*()
> 
> Linus Torvalds (1):
>   x86: don't pointlessly reload the system call number
> 
>  arch/x86/Kconfig                       |   1 +
>  arch/x86/entry/calling.h               |   2 +
>  arch/x86/entry/common.c                |  20 +-
>  arch/x86/entry/entry_64.S              |   3 +-
>  arch/x86/entry/entry_64_compat.S       |   6 +
>  arch/x86/entry/syscall_32.c            |  15 +-
>  arch/x86/entry/syscall_64.c            |   6 +-
>  arch/x86/entry/syscalls/syscall_32.tbl | 724 +++++++++++++++++----------------
>  arch/x86/entry/syscalls/syscall_64.tbl | 712 ++++++++++++++++----------------
>  arch/x86/entry/vsyscall/vsyscall_64.c  |  18 +-
>  arch/x86/include/asm/syscall.h         |   4 +
>  arch/x86/include/asm/syscall_wrapper.h | 197 +++++++++
>  arch/x86/include/asm/syscalls.h        |  17 +-
>  include/linux/compat.h                 |  22 +
>  include/linux/syscalls.h               |  25 +-
>  init/Kconfig                           |  10 +
>  kernel/sys_ni.c                        |  10 +
>  kernel/time/posix-stubs.c              |  10 +
>  18 files changed, 1054 insertions(+), 748 deletions(-)
>  create mode 100644 arch/x86/include/asm/syscall_wrapper.h

Ok, this series looks mostly good to me, but AFAICS this breaks the UML build:

 make[2]: *** No rule to make target 'archheaders'.  Stop.
 arch/um/Makefile:119: recipe for target 'archheaders' failed
 make[1]: *** [archheaders] Error 2
 make[1]: *** Waiting for unfinished jobs....

Thanks,

	Ingo
