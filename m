Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeECKRL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:17:11 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:33566 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeECKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:17:02 -0400
X-Google-Smtp-Source: AB8JxZrr0Sed9Mc1e0eHoorszlUE/VkpAgI0QHNkrVOGtN6j/J9NKq7Eauw2kDDdY/dLHz1dLRcGopDi64u1tZv/I3qpOA5Gw2aa
MIME-Version: 1.0
Date: Thu, 03 May 2018 03:17:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000283c37056b4a81a5@google.com>
Subject: INFO: task hung in __sb_start_write
From: syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    06dd3dfeea60 Merge tag 'char-misc-4.17-rc1' of  
git://git.k...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12911087800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=301513bac2f9fd9
dashboard link: https://syzkaller.appspot.com/bug?extid=7b2866454055e43c21e5
compiler:       gcc (GCC) 8.0.1 20180301 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com

kworker/dying (22) used greatest stack depth: 8440 bytes left
INFO: task syz-executor1:4457 blocked for more than 120 seconds.
       Not tainted 4.16.0+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D21448  4457   4449 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x807/0x1e40 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x400/0x6e0 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  __percpu_down_read+0x15d/0x200 kernel/locking/percpu-rwsem.c:85
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:49 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  __sb_start_write+0x2d7/0x300 fs/super.c:1340
  sb_start_write include/linux/fs.h:1548 [inline]
  mnt_want_write+0x3f/0xc0 fs/namespace.c:386
  do_unlinkat+0x2a3/0xa10 fs/namei.c:4027
  SYSC_unlink fs/namei.c:4092 [inline]
  SyS_unlink+0x26/0x30 fs/namei.c:4090
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x455027
RSP: 002b:00007ffe9645abc8 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000455027
RDX: 0000000001272983 RSI: 00007ffe9645ac60 RDI: 00007ffe9645ac60
RBP: 00007ffe9645c970 R08: 0000000000000000 R09: 0000000000000010
R10: 000000000000000a R11: 0000000000000202 R12: 0000000001272940
R13: 0000000000000000 R14: 000000000000041b R15: 000000000003297e

Showing all locks held in the system:
2 locks held by khungtaskd/878:
  #0: 00000000e417309b (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 00000000e417309b (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000a42a84b8 (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by rs:main Q:Reg/4288:
  #0: 00000000658bb541 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1a9/0x1e0  
fs/file.c:766
  #1: 0000000052aff78e (sb_writers#4){++++}, at: file_start_write  
include/linux/fs.h:2709 [inline]
  #1: 0000000052aff78e (sb_writers#4){++++}, at: vfs_write+0x452/0x560  
fs/read_write.c:548
2 locks held by getty/4381:
  #0: 00000000990269ba (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000009f1d2051 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4382:
  #0: 00000000ecd434e6 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000034d736c1 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4383:
  #0: 0000000013764982 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000202a6e1f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4384:
  #0: 00000000ba3d2e6d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000e3323037 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4385:
  #0: 00000000a3add0e7 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000081f7b524 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4386:
  #0: 00000000a73f06ea (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000002de50dc3 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4387:
  #0: 0000000087cccc64 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000000a3822a6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
1 lock held by syz-executor1/4457:
  #0: 0000000052aff78e (sb_writers#4){++++}, at: sb_start_write  
include/linux/fs.h:1548 [inline]
  #0: 0000000052aff78e (sb_writers#4){++++}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
1 lock held by syz-executor7/4459:
  #0: 0000000052aff78e (sb_writers#4){++++}, at: sb_start_write  
include/linux/fs.h:1548 [inline]
  #0: 0000000052aff78e (sb_writers#4){++++}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
1 lock held by syz-executor5/4460:
  #0: 0000000052aff78e (sb_writers#4){++++}, at: sb_start_write  
include/linux/fs.h:1548 [inline]
  #0: 0000000052aff78e (sb_writers#4){++++}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
1 lock held by syz-executor3/4462:
  #0: 0000000052aff78e (sb_writers#4){++++}, at: sb_start_write  
include/linux/fs.h:1548 [inline]
  #0: 0000000052aff78e (sb_writers#4){++++}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
2 locks held by syz-executor6/14836:
  #0: 00000000f86d1ee3 (&mm->mmap_sem){++++}, at:  
__do_page_fault+0x381/0xe40 arch/x86/mm/fault.c:1328
  #1: 0000000002ee4fbd (sb_pagefaults){++++}, at: sb_start_pagefault  
include/linux/fs.h:1577 [inline]
  #1: 0000000002ee4fbd (sb_pagefaults){++++}, at:  
ext4_page_mkwrite+0x1c8/0x1420 fs/ext4/inode.c:6074
1 lock held by syz-executor0/14842:
  #0: 0000000052aff78e (sb_writers#4){++++}, at: sb_start_write  
include/linux/fs.h:1548 [inline]
  #0: 0000000052aff78e (sb_writers#4){++++}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
1 lock held by syz-executor4/14843:
  #0: 0000000052aff78e (sb_writers#4){++++}, at: sb_start_write  
include/linux/fs.h:1548 [inline]
  #0: 0000000052aff78e (sb_writers#4){++++}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
1 lock held by syz-executor2/14849:
  #0: 0000000052aff78e (sb_writers#4){++++}, at: sb_start_write  
include/linux/fs.h:1548 [inline]
  #0: 0000000052aff78e (sb_writers#4){++++}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 878 Comm: khungtaskd Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
