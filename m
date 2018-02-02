Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeBBWLc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:11:32 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:54887 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeBBWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:11:26 -0500
X-Google-Smtp-Source: AH8x224hTfqf38m4Du02YAxuU7OFnrr9Pvfbvm/CKpqhUFJDXK/qT64Yrj/cR4PP7W7joWZOiRE/hQ==
Date: Fri, 2 Feb 2018 14:11:23 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+f528291d25f6c5c652a8294f7a14e65dd0bce596@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in register_lock_class
Message-ID: <20180202221123.6zrpnrqykl4qfv5o@gmail.com>
References: <94eb2c19de6097969a0561027949@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c19de6097969a0561027949@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2017 at 06:09:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> WARNING: CPU: 0 PID: 13098 at kernel/locking/lockdep.c:718
> arch_local_save_flags kernel/locking/lockdep.c:687 [inline]
> WARNING: CPU: 0 PID: 13098 at kernel/locking/lockdep.c:718
> look_up_lock_class kernel/locking/lockdep.c:709 [inline]
> WARNING: CPU: 0 PID: 13098 at kernel/locking/lockdep.c:718
> register_lock_class+0x5a2/0x5d0 kernel/locking/lockdep.c:740
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 13098 Comm: syzkaller182681 Not tainted
> 4.15.0-rc3-next-20171214+ #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0xe9/0x14b lib/dump_stack.c:53
>  panic+0x10e/0x2f8 kernel/panic.c:183
>  __warn+0x14e/0x150 kernel/panic.c:547
>  report_bug+0x11e/0x1a0 lib/bug.c:184
>  fixup_bug.part.11+0x17/0x30 arch/x86/kernel/traps.c:177
>  fixup_bug arch/x86/kernel/traps.c:246 [inline]
>  do_error_trap+0x14a/0x180 arch/x86/kernel/traps.c:295
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:314
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
> RIP: 0010:arch_local_save_flags kernel/locking/lockdep.c:687 [inline]
> RIP: 0010:look_up_lock_class kernel/locking/lockdep.c:709 [inline]
> RIP: 0010:register_lock_class+0x5a2/0x5d0 kernel/locking/lockdep.c:740
> RSP: 0018:ffffc90001e2fb38 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: ffffffff83b1e790 RCX: 0000000000000000
> RDX: ffffffff83ff0bb0 RSI: 00000000000002b0 RDI: 0000000000000000
> RBP: ffffc90001e2fba0 R08: 0000000000000000 R09: ffffffff8121b4f4
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff88021388a4b8 R15: 0000000000000000
>  __lock_acquire+0xb4/0x1430 kernel/locking/lockdep.c:3314
>  lock_acquire+0xbf/0x220 kernel/locking/lockdep.c:3914
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x56/0x70 kernel/locking/spinlock.c:152
>  remove_wait_queue+0x14/0x60 kernel/sched/wait.c:50
>  ep_remove_wait_queue fs/eventpoll.c:595 [inline]
>  ep_unregister_pollwait.isra.7+0x79/0x1f0 fs/eventpoll.c:613
>  ep_free+0x71/0x140 fs/eventpoll.c:830
>  ep_eventpoll_release+0x26/0x30 fs/eventpoll.c:862
>  __fput+0x120/0x270 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0xa3/0xe0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x3e6/0x1050 kernel/exit.c:869
>  do_group_exit+0x60/0x100 kernel/exit.c:972
>  SYSC_exit_group kernel/exit.c:983 [inline]
>  SyS_exit_group+0x18/0x20 kernel/exit.c:981
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x446259
> RSP: 002b:00000000007efa18 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 0000000000446259
> RDX: 0000000000446259 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000665e
> R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000026e9
> R13: 000000000000665e R14: 0000000000000000 R15: 0000000000000000
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
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
> 
> syzbot will keep track of this bug report.
> Once a fix for this bug is merged into any tree, reply to this email with:
> #syz fix: exact-commit-title

Fixed by commit f5cb779ba163:

#syz fix: ANDROID: binder: remove waitqueue when thread exits.

- Eric
