Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeDJI7X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:59:23 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:39949 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeDJI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:59:21 -0400
X-Google-Smtp-Source: AIpwx49j+wYrWtyh/dUOAzSFOV1yreT6nyKh4tqrepzQd+5jUarGelsd7JGUrvY6vEooLusLrEttbQ==
Date: Tue, 10 Apr 2018 10:59:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: x86-tip.today (4cdf573)  early instaboot
Message-ID: <20180410085917.bo526ueprf7zfare@gmail.com>
References: <1523347959.4724.2.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523347959.4724.2.camel@gmx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> Hi Ingo,
> 
> FYI, my i4790 box reboots immediately.. or close enough to it that you
> see nothing at all before again meeting the bios splash.  Master with
> the ~same config works fine.  I haven't poked around yet (work).

Hm, so there's been a few 'dangerous' pieces of work merged yesterday-ish.

Prime suspects would be:

 triton:~/tip> gll linus..x86/pti

 0564258fb2cf: x86/pti: Leave kernel text global for !PCID
 a5df4f1f0d78: x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image
 e0bb456e3250: x86/pti: Enable global pages for shared areas
 efad2b415152: x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init
 4ddee6efdcd0: x86/mm: Comment _PAGE_GLOBAL mystery
 e71e836f463d: x86/mm: Remove extra filtering in pageattr code
 64c80759408f: x86/mm: Do not auto-massage page protections
 6baf4bec02db: x86/espfix: Document use of _PAGE_GLOBAL
 8a57f4849f4f: x86/mm: Introduce "default" kernel PTE mask
 606c7193d5fb: x86/mm: Undo double _PAGE_PSE clearing
 d1440b23c922: x86/mm: Factor out pageattr _PAGE_GLOBAL setting
 ee1400dda318: Merge branch 'linus' into x86/pti to pick up upstream changes
 071ccc966ba5: x86/entry/64: Drop idtentry's manual stack switch for user entries
 9820e1c3376c: x86/uapi: Fix asm/bootparam.h userspace compilation errors

... which you could test via 0564258fb2cf: if that insta-reboots too then 
9820e1c3376c^1 is expected to work and 4 bisection steps should pinpoint the 
guilty commit ...

But there's also the syscall rework:

 triton:~/tip> gll linus..x86/asm
 c76fc9826075: syscalls/x86: Adapt syscall_wrapper.h to the new syscall stub naming convention
 d5a00528b58c: syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()
 5ac9efa3c50d: syscalls/core, syscalls/x86: Clean up compat syscall stub naming convention
 e145242ea0df: syscalls/core, syscalls/x86: Clean up syscall stub naming convention
 6dc936f175cc: syscalls/x86: Extend register clearing on syscall entry to lower registers
 f8781c4a2263: syscalls/x86: Unconditionally enable 'struct pt_regs' based syscalls on x86_64
 ebeb8c82ffaf: syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32
 7303e30ec1d8: syscalls/core: Prepare CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y for compat syscalls
 fa697140f9a2: syscalls/x86: Use 'struct pt_regs' based syscall calling convention for 64-bit syscalls
 1bd21c6c21e8: syscalls/core: Introduce CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
 dfe64506c01e: x86/syscalls: Don't pointlessly reload the system call number

... which you could test via c76fc9826075: if that insta-reboots then 
dfe64506c01e^1 should be good and 4 bisection steps should suffice.

Thanks,

	Ingo
