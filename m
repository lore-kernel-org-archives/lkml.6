Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeEFRhJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 13:37:09 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:45748 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeEFRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 13:37:03 -0400
X-Google-Smtp-Source: AB8JxZqjG5juaGpKRbKGH7Ladcp8R0zGmU5P2ulntm4JzqBP5/poadAtJEf6jUmaPPydnz22aimEnzLNwOMmOues/pxRWo97iq3d
MIME-Version: 1.0
Date: Sun, 06 May 2018 10:37:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f064056b8d004d@google.com>
Subject: INFO: task hung in tls_push_record
From: syzbot <syzbot+4006516aae0b06e7050f@syzkaller.appspotmail.com>
To: aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fb11a9a8d51 net/ipv6: rename rt6_next to fib6_next
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=108e9237800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c416c61f3cd96be
dashboard link: https://syzkaller.appspot.com/bug?extid=4006516aae0b06e7050f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4006516aae0b06e7050f@syzkaller.appspotmail.com

INFO: task syz-executor7:20304 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc3+ #33
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D24680 20304   4547 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x1b5/0x240 kernel/time/timer.c:1777
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x3e7/0x870 kernel/sched/completion.c:136
  crypto_wait_req include/linux/crypto.h:512 [inline]
  tls_do_encryption net/tls/tls_sw.c:217 [inline]
  tls_push_record+0xedc/0x13e0 net/tls/tls_sw.c:248
  tls_sw_sendmsg+0x8d7/0x12b0 net/tls/tls_sw.c:440
  inet_sendmsg+0x19f/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  sock_write_iter+0x35a/0x5a0 net/socket.c:908
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
RSP: 002b:00007fad08582c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fad085836d4 RCX: 0000000000455979
RDX: 0000000000000050 RSI: 0000000020000280 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000713 R14: 00000000006fea68 R15: 0000000000000000

Showing all locks held in the system:
2 locks held by khungtaskd/892:
  #0: 000000003f978916 (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 000000003f978916 (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000a6e1e84d (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4466:
  #0: 00000000bb90ee4c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000005c64e739 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4467:
  #0: 00000000a703ee54 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000c6bc54dc (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4468:
  #0: 000000007e39712e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000003afa8b0a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4469:
  #0: 000000004a2f1f14 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000a9bb6673 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4470:
  #0: 000000005c9ac5a5 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000e940f7ee (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4471:
  #0: 00000000b0318201 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000faa92852 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4472:
  #0: 000000002f556699 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000c5b4fb47 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
1 lock held by syz-executor7/20304:
  #0: 000000001da4f4a9 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1474 [inline]
  #0: 000000001da4f4a9 (sk_lock-AF_INET6){+.+.}, at:  
tls_sw_sendmsg+0x1b9/0x12b0 net/tls/tls_sw.c:384
1 lock held by syz-executor7/20375:
  #0: 00000000286d2e23 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1474 [inline]
  #0: 00000000286d2e23 (sk_lock-AF_INET6){+.+.}, at:  
tls_sw_sendmsg+0x1b9/0x12b0 net/tls/tls_sw.c:384

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 892 Comm: khungtaskd Not tainted 4.17.0-rc3+ #33
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
