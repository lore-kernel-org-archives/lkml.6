Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBTUou (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:44:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeBTUot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:44:49 -0500
Date: Tue, 20 Feb 2018 21:44:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code:
 section
Message-ID: <20180220204435.GC24320@pd.tnic>
References: <20180219202826.19797-1-bp@alien8.de>
 <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
 <20180220192956.si2a6m3ckskexvte@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180220192956.si2a6m3ckskexvte@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 01:29:56PM -0600, Josh Poimboeuf wrote:
> > Maybe this series already has this side-effect, but I'd really love to
> > see oopses show the code bytes for each kernel entry, not just the
> > innermode one.  We already dump full regs including RIP -- adding
> > Code: should be easy and would be very helpful.
> 
> Just to clarify, I think you want to show the Code: around regs->ip
> every time we show the registers?

It is an easy change to always dump Code: section when we dump RIP:.
I.e., something like this:

[   33.192733] BUG: unable to handle kernel NULL pointer dereference at           (null)
[   33.196510] IP: sysrq_handle_crash+0x17/0x20
[   33.196691] PGD 78b12067 P4D 78b12067 PUD 78b7f067 PMD 0 
[   33.196691] Oops: 0002 [#1] PREEMPT SMP
[   33.196691] Modules linked in:
[   33.196691] CPU: 6 PID: 3686 Comm: bash Not tainted 4.16.0-rc1+ #5
[   33.196691] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   33.196691] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   33.196691] RSP: 0018:ffffc9000054bdf0 EFLAGS: 00010246
[   33.196691] Code: eb d1 e8 5d 17 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 c6 24 bd ff c7 05 24 a2 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 21 c2 ff fb e9 
[   33.196691] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   33.196691] RDX: 0000000000000000 RSI: ffffffff8110145a RDI: 0000000000000063
[   33.196691] RBP: ffffffff82271400 R08: 0000000000000183 R09: 000000000002e771
[   33.196691] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   33.196691] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   33.196691] FS:  00007ffff7fdb700(0000) GS:ffff88007ed80000(0000) knlGS:0000000000000000
[   33.196691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.196691] CR2: 0000000000000000 CR3: 000000007aa9e000 CR4: 00000000000406e0
[   33.196691] Call Trace:
[   33.196691]  __handle_sysrq+0x9e/0x160
[   33.196691]  write_sysrq_trigger+0x2b/0x30
[   33.196691]  proc_reg_write+0x38/0x70
[   33.196691]  __vfs_write+0x36/0x160
[   33.196691]  ? __fd_install+0x69/0x110
[   33.196691]  ? preempt_count_add+0x74/0xb0
[   33.196691]  ? _raw_spin_lock+0x13/0x30
[   33.196691]  ? set_close_on_exec+0x41/0x80
[   33.196691]  ? preempt_count_sub+0xa8/0x100
[   33.196691]  vfs_write+0xc0/0x190
[   33.196691]  SyS_write+0x64/0xe0
[   33.196691]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   33.196691]  do_syscall_64+0x70/0x130
[   33.196691]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   33.196691] RIP: 0033:0x7ffff74b9620
[   33.196691] RSP: 002b:00007fffffffe7a8 EFLAGS: 00000246
[   33.196691] Code: ff 73 01 c3 48 8b 0d 68 98 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd f1 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 
[   33.196691]  ORIG_RAX: 0000000000000001
[   33.196691] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
[   33.196691] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
[   33.196691] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
[   33.196691] R10: 00007ffff77826a0 R11: 0000000000000246 R12: 00007ffff77842a0
[   33.196691] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[   33.196691] Code: eb d1 e8 5d 17 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 c6 24 bd ff c7 05 24 a2 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 21 c2 ff fb e9 
[   33.196691] RIP: sysrq_handle_crash+0x17/0x20 RSP: ffffc9000054bdf0
[   33.196691] CR2: 0000000000000000
[   33.301033] ---[ end trace b97275941de8c6f4 ]---
[   33.302600] Kernel panic - not syncing: Fatal exception
[   33.304529] Kernel Offset: disabled
[   33.304973] ---[ end Kernel panic - not syncing: Fatal exception

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
