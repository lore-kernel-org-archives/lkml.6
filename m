Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeBUId0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:33:26 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:42906 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeBUIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:33:23 -0500
X-Google-Smtp-Source: AH8x225xafpI3n0ztWv/MKjERt2oWAnSFUi6Wi11SMjkwiTr/NRzyV2Sd5Oc/YHhcFpIIe2qVGTYwKKuBXo9bRWjyPQ=
MIME-Version: 1.0
In-Reply-To: <94eb2c0564b0dbde550565ae6eb0@google.com>
References: <94eb2c0564b0dbde550565ae6eb0@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 21 Feb 2018 09:33:01 +0100
Message-ID: <CACT4Y+bjEKd1NCWLkj_UoRQ5RA2XkSVfFcLz4C1P_iFnF=sNzw@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in __queue_work
To: syzbot <syzbot+8288e492017b059ff014@syzkaller.appspotmail.com>
Cc: coreteam@netfilter.org, David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 1:59 AM, syzbot
<syzbot+8288e492017b059ff014@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 1a2a7d3ee659e477e0768ac3fc7579794f89071b (Fri Feb 16 17:11:30 2018 +0000)
> Merge tag 'sound-4.16-rc2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>
> So far this crash happened 2 times on upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.


This is already fixed:

#syz fix: netfilter: IDLETIMER: be syzkaller friendly



> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8288e492017b059ff014@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> x_tables: ip6_tables: TCPMSS target: only valid for protocol 6
> x_tables: ip6_tables: TCPMSS target: only valid for protocol 6
> x_tables: ip6_tables: TCPMSS target: only valid for protocol 6
> ------------[ cut here ]------------
> ODEBUG: activate not available (active state 0) object type: work_struct
> hint: 0x8
> WARNING: CPU: 0 PID: 4178 at lib/debugobjects.c:291
> debug_print_object+0x166/0x220 lib/debugobjects.c:288
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 4178 Comm: syzkaller885166 Not tainted 4.16.0-rc1+ #315
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x58/0x80 arch/x86/entry/entry_64.S:957
> RIP: 0010:debug_print_object+0x166/0x220 lib/debugobjects.c:288
> RSP: 0018:ffff8801db407400 EFLAGS: 00010082
> RAX: dffffc0000000008 RBX: 0000000000000005 RCX: ffffffff815abdbe
> RDX: 0000000000000100 RSI: 1ffff1003b680e30 RDI: 1ffff1003b680e05
> RBP: ffff8801db407440 R08: 0000000000000000 R09: 1ffff1003b680dd7
> R10: ffff8801db407300 R11: 0000000000000002 R12: 0000000000000001
> R13: ffffffff86b14d80 R14: ffffffff86007d60 R15: ffffffff8147ac00
>  debug_object_activate+0x390/0x730 lib/debugobjects.c:475
>  debug_work_activate kernel/workqueue.c:493 [inline]
>  __queue_work+0x163/0x1230 kernel/workqueue.c:1382
>  queue_work_on+0x16a/0x1c0 kernel/workqueue.c:1488
>  queue_work include/linux/workqueue.h:488 [inline]
>  schedule_work include/linux/workqueue.h:546 [inline]
>  idletimer_tg_expired+0x44/0x60 net/netfilter/xt_IDLETIMER.c:116
>  call_timer_fn+0x228/0x820 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x7ee/0xb70 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>  invoke_softirq kernel/softirq.c:365 [inline]
>  irq_exit+0x1cc/0x200 kernel/softirq.c:405
>  exiting_irq arch/x86/include/asm/apic.h:541 [inline]
>  smp_apic_timer_interrupt+0x16b/0x700 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0x8e/0xa0 arch/x86/entry/entry_64.S:796
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:777
> [inline]
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160
> [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x5e/0xba
> kernel/locking/spinlock.c:184
> RSP: 0018:ffff8801b1a7f3c8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff12
> RAX: dffffc0000000000 RBX: 0000000000000282 RCX: 0000000000000006
> RDX: 1ffffffff0d592d5 RSI: 1ffff10035eb5d5b RDI: 0000000000000282
> RBP: ffff8801b1a7f3d8 R08: 1ffff1003634fe47 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff86cfcbe0
> R13: 0000000000000282 R14: ffffed003634fe8b R15: ffff8801b33f25e8
>  fill_pool lib/debugobjects.c:119 [inline]
>  __debug_object_init+0xa7a/0x1040 lib/debugobjects.c:339
>  debug_object_init+0x17/0x20 lib/debugobjects.c:391
>  __init_work+0x2b/0x60 kernel/workqueue.c:506
>  idletimer_tg_create net/netfilter/xt_IDLETIMER.c:152 [inline]
>  idletimer_tg_checkentry+0x691/0xb00 net/netfilter/xt_IDLETIMER.c:213
>  xt_check_target+0x22c/0x7d0 net/netfilter/x_tables.c:850
>  check_target net/ipv6/netfilter/ip6_tables.c:533 [inline]
>  find_check_entry.isra.7+0x935/0xcf0 net/ipv6/netfilter/ip6_tables.c:575
>  translate_table+0xf52/0x1690 net/ipv6/netfilter/ip6_tables.c:744
>  do_replace net/ipv6/netfilter/ip6_tables.c:1160 [inline]
>  do_ip6t_set_ctl+0x370/0x5f0 net/ipv6/netfilter/ip6_tables.c:1686
>  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>  nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
>  ipv6_setsockopt+0x10b/0x130 net/ipv6/ipv6_sockglue.c:927
>  udpv6_setsockopt+0x45/0x80 net/ipv6/udp.c:1422
>  sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2975
>  SYSC_setsockopt net/socket.c:1849 [inline]
>  SyS_setsockopt+0x189/0x360 net/socket.c:1828
>  do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x4468a9
> RSP: 002b:00007fe91311cda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00000000006dbc24 RCX: 00000000004468a9
> RDX: 0000000000000040 RSI: 0000000000000029 RDI: 00000000000002fb
> RBP: 0000000000000000 R08: 0000000000000460 R09: 0000000000000000
> R10: 0000000020103ba0 R11: 0000000000000246 R12: 00000000006dbc20
> R13: 4292e4cc04c17464 R14: 372e72b5132b6474 R15: 0000000000000001
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/94eb2c0564b0dbde550565ae6eb0%40google.com.
> For more options, visit https://groups.google.com/d/optout.
