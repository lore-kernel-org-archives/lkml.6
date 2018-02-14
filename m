Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031622AbeBNPjc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:39:32 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45199 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031287AbeBNPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:39:29 -0500
X-Google-Smtp-Source: AH8x226kp3emQ5MGM8RD57ACbDxmAs782fKvpi6S2E/vdIAOhjNNfmysArazrqXMF3Isky1I+JdyBKGDLPss7V45ZS4=
MIME-Version: 1.0
In-Reply-To: <001a113f64ee97b27105649a7cb2@google.com>
References: <001a113f64ee97b27105649a7cb2@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 16:39:08 +0100
Message-ID: <CACT4Y+asg_NsnCsmP_7CmtL+RrTL=boazGM_mig2dhQnfsk70Q@mail.gmail.com>
Subject: Re: INFO: task hung in blk_freeze_queue
To: syzbot <syzbot+2ab52b8d94df5e2eaa01@syzkaller.appspotmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 8:46 AM, syzbot
<syzbot+2ab52b8d94df5e2eaa01@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> e237f98a9c134c3d600353f21e07db915516875b (Mon Feb 5 21:35:56 2018 +0000)
> Merge tag 'xfs-4.16-merge-5' of
> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>
> So far this crash happened 2 times on upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> user-space arch: i386


Looks similar to this one:

#syz dup: INFO: task hung in lo_ioctl


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2ab52b8d94df5e2eaa01@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> Buffer I/O error on dev loop0, logical block 0, lost async page write
> INFO: task syz-executor1:14117 blocked for more than 120 seconds.
>       Not tainted 4.15.0+ #210
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor1   D26432 14117   4227 0x20020004
> Call Trace:
>  context_switch kernel/sched/core.c:2845 [inline]
>  __schedule+0x8eb/0x2060 kernel/sched/core.c:3421
>  schedule+0xf5/0x430 kernel/sched/core.c:3480
>  blk_mq_freeze_queue_wait+0x1bb/0x400 block/blk-mq.c:136
>  blk_freeze_queue+0x4a/0x80 block/blk-mq.c:165
>  blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:174
>  loop_change_fd drivers/block/loop.c:667 [inline]
>  lo_ioctl+0x10ce/0x1b70 drivers/block/loop.c:1361
>  lo_compat_ioctl+0xab/0x140 drivers/block/loop.c:1556
>  compat_blkdev_ioctl+0x3ae/0x1840 block/compat_ioctl.c:406
>  C_SYSC_ioctl fs/compat_ioctl.c:1473 [inline]
>  compat_SyS_ioctl+0x151/0x2a30 fs/compat_ioctl.c:1419
>  do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
>  do_fast_syscall_32+0x3ee/0xfa1 arch/x86/entry/common.c:392
>  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129
> RIP: 0023:0xf7f44c79
> RSP: 002b:00000000f774008c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 0000000000004c06
> RDX: 0000000000000013 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> Showing all locks held in the system:
> 2 locks held by khungtaskd/759:
>  #0:  (rcu_read_lock){....}, at: [<00000000b3b533f6>]
> check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
>  #0:  (rcu_read_lock){....}, at: [<00000000b3b533f6>] watchdog+0x1c5/0xd60
> kernel/hung_task.c:249
>  #1:  (tasklist_lock){.+.+}, at: [<00000000440cd9e2>]
> debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> 1 lock held by rsyslogd/4029:
>  #0:  (&f->f_pos_lock){+.+.}, at: [<000000007729bd98>]
> __fdget_pos+0x12b/0x190 fs/file.c:765
> 2 locks held by getty/4151:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000903280c4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000fb09d1cd>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4152:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000903280c4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000fb09d1cd>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4153:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000903280c4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000fb09d1cd>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4154:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000903280c4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000fb09d1cd>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4155:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000903280c4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000fb09d1cd>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4156:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000903280c4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000fb09d1cd>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4157:
>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000903280c4>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000fb09d1cd>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 1 lock held by syz-executor1/14117:
>  #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<00000000b6589539>]
> lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 759 Comm: khungtaskd Not tainted 4.15.0+ #210
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x122/0x180 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
>  check_hung_task kernel/hung_task.c:132 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
>  watchdog+0x90c/0xd60 kernel/hung_task.c:249
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10
> arch/x86/include/asm/irqflags.h:54
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a113f64ee97b27105649a7cb2%40google.com.
> For more options, visit https://groups.google.com/d/optout.
