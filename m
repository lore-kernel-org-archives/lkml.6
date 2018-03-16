Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeCPMBO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:01:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751064AbeCPMBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:01:13 -0400
Date: Fri, 16 Mar 2018 07:01:12 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316120112.mqjvkdgl27scds6p@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
 <20180316114849.GD5852@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316114849.GD5852@pd.tnic>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:48:49PM +0100, Borislav Petkov wrote:
> [   29.046500] sysrq: SysRq : Trigger a crash
> [   29.048605] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [   29.051639] PGD 79afd067 P4D 79afd067 PUD 7a1a2067 PMD 0 
> [   29.052557] Oops: 0002 [#1] PREEMPT SMP
> [   29.052557] CPU: 7 PID: 3693 Comm: bash Not tainted 4.16.0-rc5+ #8
> [   29.052557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   29.052557] RIP: 0010:sysrq_handle_crash+0x17/0x20
> [   29.052557] Code: d1 e8 6d 08 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 76 1f bd ff c7 05 a4 12 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 c6 1b c2 ff fb e9 80 
> [   29.052557] RSP: 0018:ffffc900007cbdf0 EFLAGS: 00010246
> [   29.052557] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
> [   29.052557] RDX: 0000000000000000 RSI: ffffffff81101e0a RDI: 0000000000000063
> [   29.052557] RBP: ffffffff822714c0 R08: 0000000000000185 R09: 000000000000b5a4
> [   29.052557] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
> [   29.052557] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   29.052557] FS:  00007ffff7fdb700(0000) GS:ffff88007edc0000(0000) knlGS:0000000000000000
> [   29.052557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.052557] CR2: 0000000000000000 CR3: 00000000799e1000 CR4: 00000000000406e0
> [   29.052557] Call Trace:
> [   29.052557]  __handle_sysrq+0x9e/0x160
> [   29.052557]  write_sysrq_trigger+0x2b/0x30
> [   29.052557]  proc_reg_write+0x38/0x70
> [   29.052557]  __vfs_write+0x36/0x160
> [   29.052557]  ? __fd_install+0x69/0x110
> [   29.052557]  ? preempt_count_add+0x74/0xb0
> [   29.052557]  ? _raw_spin_lock+0x13/0x30
> [   29.052557]  ? set_close_on_exec+0x41/0x80
> [   29.052557]  ? preempt_count_sub+0xa8/0x100
> [   29.052557]  vfs_write+0xc0/0x190
> [   29.052557]  SyS_write+0x64/0xe0
> [   29.052557]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [   29.052557]  do_syscall_64+0x70/0x130
> [   29.052557]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> [   29.052557] RIP: 0033:0x7ffff74b9620
> [   29.052557] Code: Bad RIP value.
> [   29.052557] RSP: 002b:00007fffffffe6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   29.052557] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
> [   29.052557] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
> [   29.052557] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
> [   29.052557] R10: 00007ffff77826a0 R11: 0000000000000246 R12: 00007ffff77842a0
> [   29.052557] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000

Hm, the "Code: Bad RIP value" will always be shown for syscall regs,
which will probably cause some unnecessary confusion/worry.  Should we
just skip printing it for the "regs->ip < PAGE_OFFSET" case?

-- 
Josh
