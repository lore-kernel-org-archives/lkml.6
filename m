Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753711AbeCPLta (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:49:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753551AbeCPLt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:49:28 -0400
Date: Fri, 16 Mar 2018 12:48:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316114849.GD5852@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315190132.2d653yu7ezf2zplh@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:01:32PM -0500, Josh Poimboeuf wrote:
> no_context() has the following line, right before it calls oops_end():
> 
> 	/* Executive summary in case the body of the oops scrolled away */
> 	printk(KERN_DEFAULT "CR2: %016lx\n", address);
> 
> I think that line can now be removed, since the executive summary
> __show_regs() will include CR2.

Good idea. Done. It adds three more lines to the executive summary but I
think they're worth it.

[ 4020.804801] Modules linked in:
[ 4020.840092] ---[ end trace 13285dfd393b58bd ]---
[ 4020.840828] RIP: 0010:sysrq_handle_crash+0x17/0x20
[ 4020.841731] Code: d1 e8 6d 08 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 76 1f bd ff c7 05 a4 12 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 c6 1b c2 ff fb e9 80 
[ 4020.845056] RSP: 0018:ffffc9000085bdf0 EFLAGS: 00010246
[ 4020.845760] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[ 4020.846704] RDX: 0000000000000000 RSI: ffffffff81101e0a RDI: 0000000000000063
[ 4020.847630] RBP: ffffffff822714c0 R08: 0000000000000185 R09: 00000000000c303e
[ 4020.848658] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[ 4020.849678] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 4020.850644] FS:  00007ffff7fdb700(0000) GS:ffff88007ec40000(0000) knlGS:0000000000000000
[ 4020.851688] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4020.852994] CR2: 0000000000000000 CR3: 000000007a0f9000 CR4: 00000000000406e0
[ 4020.854018] Kernel panic - not syncing: Fatal exception
[ 4020.855256] Kernel Offset: disabled
[ 4020.855730] ---[ end Kernel panic - not syncing: Fatal exception ]---

> > @@ -352,26 +357,14 @@ int __die(const char *str, struct pt_regs *regs, long err)
> >  	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
> >  	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
> >  
> > +	show_regs(regs);
> > +
> >  	if (notify_die(DIE_OOPS, str, regs, err,
> >  			current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
> >  		return 1;
> >  
> >  	print_modules();
> > -	show_regs(regs);
> 
> Was moving the show_regs() call intentional?

Yes. It'd be prudent for registers to come out unconditionally and
not some of the notifiers to make us exit early. Which kinda needs
print_modules() to go up too. Fixed.

> I didn't see it mentioned in the changelog.

Fixed.

> Doesn't this hunk belong in the previous patch, which added the
> __show_regs -> show_ip() -> show_opcodes() call path?

Yeah, and the PAGE_OFFSET check needs to happen in show_ip() too.

Thanks for the detailed review, here's the current splat format:

[   29.046500] sysrq: SysRq : Trigger a crash
[   29.048605] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   29.051639] PGD 79afd067 P4D 79afd067 PUD 7a1a2067 PMD 0 
[   29.052557] Oops: 0002 [#1] PREEMPT SMP
[   29.052557] CPU: 7 PID: 3693 Comm: bash Not tainted 4.16.0-rc5+ #8
[   29.052557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   29.052557] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   29.052557] Code: d1 e8 6d 08 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 76 1f bd ff c7 05 a4 12 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 c6 1b c2 ff fb e9 80 
[   29.052557] RSP: 0018:ffffc900007cbdf0 EFLAGS: 00010246
[   29.052557] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   29.052557] RDX: 0000000000000000 RSI: ffffffff81101e0a RDI: 0000000000000063
[   29.052557] RBP: ffffffff822714c0 R08: 0000000000000185 R09: 000000000000b5a4
[   29.052557] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   29.052557] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   29.052557] FS:  00007ffff7fdb700(0000) GS:ffff88007edc0000(0000) knlGS:0000000000000000
[   29.052557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.052557] CR2: 0000000000000000 CR3: 00000000799e1000 CR4: 00000000000406e0
[   29.052557] Call Trace:
[   29.052557]  __handle_sysrq+0x9e/0x160
[   29.052557]  write_sysrq_trigger+0x2b/0x30
[   29.052557]  proc_reg_write+0x38/0x70
[   29.052557]  __vfs_write+0x36/0x160
[   29.052557]  ? __fd_install+0x69/0x110
[   29.052557]  ? preempt_count_add+0x74/0xb0
[   29.052557]  ? _raw_spin_lock+0x13/0x30
[   29.052557]  ? set_close_on_exec+0x41/0x80
[   29.052557]  ? preempt_count_sub+0xa8/0x100
[   29.052557]  vfs_write+0xc0/0x190
[   29.052557]  SyS_write+0x64/0xe0
[   29.052557]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   29.052557]  do_syscall_64+0x70/0x130
[   29.052557]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   29.052557] RIP: 0033:0x7ffff74b9620
[   29.052557] Code: Bad RIP value.
[   29.052557] RSP: 002b:00007fffffffe6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   29.052557] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
[   29.052557] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
[   29.052557] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
[   29.052557] R10: 00007ffff77826a0 R11: 0000000000000246 R12: 00007ffff77842a0
[   29.052557] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[   29.052557] Modules linked in:
[   29.085219] ---[ end trace c579921b8f40a393 ]---
[   29.085920] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   29.086704] Code: d1 e8 6d 08 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 76 1f bd ff c7 05 a4 12 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 c6 1b c2 ff fb e9 80 
[   29.089439] RSP: 0018:ffffc900007cbdf0 EFLAGS: 00010246
[   29.090117] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   29.091039] RDX: 0000000000000000 RSI: ffffffff81101e0a RDI: 0000000000000063
[   29.091959] RBP: ffffffff822714c0 R08: 0000000000000185 R09: 000000000000b5a4
[   29.092935] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   29.093948] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   29.094885] FS:  00007ffff7fdb700(0000) GS:ffff88007edc0000(0000) knlGS:0000000000000000
[   29.095925] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.096731] CR2: 0000000000000000 CR3: 00000000799e1000 CR4: 00000000000406e0
[   29.097784] Kernel panic - not syncing: Fatal exception
[   29.098882] Kernel Offset: disabled
[   29.099351] ---[ end Kernel panic - not syncing: Fatal exception ]---

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
