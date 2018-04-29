Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeD2RDE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 13:03:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:41315 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeD2RDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 13:03:02 -0400
X-Google-Smtp-Source: AB8JxZqiwGamMIwbYEhK6DTYHojnrSfl2hkHjRwZj0sqZrjpjSXKbOqkxB28ofZFQSdmmcyyoHPGQG/0b1+LDAFIw7UBUERsxZO7
MIME-Version: 1.0
Date: Sun, 29 Apr 2018 10:03:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c49e10056affb536@google.com>
Subject: INFO: task hung in fat_fallocate
From: syzbot <syzbot+cfa5d826b19395f1940e@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
bf8f5de17442bba5f811e7e724980730e079ee11 (Sat Apr 28 17:05:04 2018 +0000)
MAINTAINERS: add myself as maintainer of AFFS
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=cfa5d826b19395f1940e

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5087555854794752
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=7043958930931867332
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cfa5d826b19395f1940e@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: task syz-executor0:10251 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc2+ #22
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D25408 10251   7326 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  __rwsem_down_write_failed_common+0x919/0x15d0  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa2/0x120 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:713 [inline]
  fat_fallocate+0x12d/0x320 fs/fat/file.c:249
  vfs_fallocate+0x4b4/0x8d0 fs/open.c:319
  ksys_fallocate+0x56/0x90 fs/open.c:342
  __do_sys_fallocate fs/open.c:350 [inline]
  __se_sys_fallocate fs/open.c:348 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:348
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007fe1b4f97c68 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fe1b4f986d4 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000016
RBP: 000000000072bf50 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000001fffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000007e R14: 00000000006f3c70 R15: 0000000000000001

Showing all locks held in the system:
2 locks held by kworker/u4:2/40:
  #0: 0000000014018ef5 ((wq_completion)"writeback"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 0000000014018ef5 ((wq_completion)"writeback"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000014018ef5 ((wq_completion)"writeback"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000014018ef5 ((wq_completion)"writeback"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 0000000014018ef5 ((wq_completion)"writeback"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 0000000014018ef5 ((wq_completion)"writeback"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000014018ef5 ((wq_completion)"writeback"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 0000000042b710aa ((work_completion)(&(&wb->dwork)->work)){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
2 locks held by khungtaskd/892:
  #0: 0000000003100faf (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 0000000003100faf (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000110d22d7 (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4526:
  #0: 00000000a0a0ce51 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000031b704da (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4527:
  #0: 000000002be52f05 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000ddbf69c5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4528:
  #0: 000000006105deca (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000bd3b5b98 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4529:
  #0: 00000000d184409b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000d73f7bb9 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4530:
  #0: 00000000096b0714 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000915cba6f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4531:
  #0: 00000000aba38cd7 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000db8a6329 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4532:
  #0: 000000008ed47fa0 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000aeac4f11 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by syz-executor0/10251:
  #0: 00000000175b9bfc (sb_writers#17){.+.+}, at: file_start_write  
include/linux/fs.h:2718 [inline]
  #0: 00000000175b9bfc (sb_writers#17){.+.+}, at: vfs_fallocate+0x5be/0x8d0  
fs/open.c:318
  #1: 00000000ae4afbc4 (&sb->s_type->i_mutex_key#19){+.+.}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #1: 00000000ae4afbc4 (&sb->s_type->i_mutex_key#19){+.+.}, at:  
fat_fallocate+0x12d/0x320 fs/fat/file.c:249
2 locks held by syz-executor0/10255:
  #0: 00000000175b9bfc (sb_writers#17){.+.+}, at: sb_start_write  
include/linux/fs.h:1550 [inline]
  #0: 00000000175b9bfc (sb_writers#17){.+.+}, at:  
do_sys_ftruncate+0x290/0x560 fs/open.c:200
  #1: 00000000ae4afbc4 (&sb->s_type->i_mutex_key#19){+.+.}, at: inode_lock  
include/linux/fs.h:713 [inline]
  #1: 00000000ae4afbc4 (&sb->s_type->i_mutex_key#19){+.+.}, at:  
do_truncate+0x197/0x2a0 fs/open.c:61

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 892 Comm: khungtaskd Not tainted 4.17.0-rc2+ #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 10226 Comm: syz-executor0 Not tainted 4.17.0-rc2+ #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:lock_acquire+0x257/0x520 kernel/locking/lockdep.c:3923
RSP: 0018:ffff8801b3126a08 EFLAGS: 00000286
RAX: dffffc0000000000 RBX: 1ffff10036624d46 RCX: 0000000000000000
RDX: 1ffffffff11a315d RSI: ffff8801af0fe978 RDI: 0000000000000286
RBP: ffff8801b3126af8 R08: 0000000000000008 R09: 0000000000000003
R10: ffff8801af0fe9f0 R11: ffff8801af0fe140 R12: ffff8801af0fe140
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fe1b4fb9700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001af5f9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rcu_lock_acquire include/linux/rcupdate.h:246 [inline]
  rcu_read_lock include/linux/rcupdate.h:632 [inline]
  find_get_entry+0x11a/0xb90 mm/filemap.c:1428
  pagecache_get_page+0x116/0xe20 mm/filemap.c:1541
  find_or_create_page include/linux/pagemap.h:322 [inline]
  grow_dev_page fs/buffer.c:940 [inline]
  grow_buffers fs/buffer.c:1009 [inline]
  __getblk_slow fs/buffer.c:1036 [inline]
  __getblk_gfp+0x39e/0xaf0 fs/buffer.c:1313
  __bread_gfp+0x2d/0x310 fs/buffer.c:1347
  sb_bread include/linux/buffer_head.h:309 [inline]
  __fat_write_inode+0x33f/0xb40 fs/fat/inode.c:845
  fat_write_inode+0x97/0x180 fs/fat/inode.c:894
  write_inode fs/fs-writeback.c:1183 [inline]
  __writeback_single_inode+0xf18/0x15c0 fs/fs-writeback.c:1382
  writeback_single_inode+0x364/0x510 fs/fs-writeback.c:1436
  sync_inode fs/fs-writeback.c:2470 [inline]
  sync_inode_metadata+0x10b/0x160 fs/fs-writeback.c:2490
  __generic_file_fsync+0x16f/0x200 fs/libfs.c:988
  generic_file_fsync+0x77/0x120 fs/libfs.c:1018
  fat_file_fsync+0x77/0x180 fs/fat/file.c:165
  vfs_fsync_range+0x140/0x220 fs/sync.c:197
  generic_write_sync include/linux/fs.h:2689 [inline]
  generic_file_write_iter+0x5f1/0x850 mm/filemap.c:3296
  call_write_iter include/linux/fs.h:1784 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x64d/0x960 fs/read_write.c:487
  vfs_write+0x1f8/0x560 fs/read_write.c:549
  ksys_write+0xf9/0x250 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007fe1b4fb8c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe1b4fb96d4 RCX: 0000000000455979
RDX: 0000000000000022 RSI: 0000000020000100 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000006cc R14: 00000000006fd3c0 R15: 0000000000000000
Code: 00 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 5e 02 00 00 48 83 3d  
60 6e 74 07 00 0f 84 c8 01 00 00 48 8b bd 20 ff ff ff 57 9d <0f> 1f 44 00  
00 48 b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.207  
msecs


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

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
