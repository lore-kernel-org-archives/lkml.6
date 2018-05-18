Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeERHmF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:42:05 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:34402 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeERHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:42:03 -0400
X-Google-Smtp-Source: AB8JxZoriJvhfsiwg0Kvsdl8qGp4c9We1gx+nN76ok2x4/rN6ZwQo1z7NWmNBYFYZ6Ger0jVPirR2V/Rxt043CKyDG5kRb9YOHMR
MIME-Version: 1.0
Date: Fri, 18 May 2018 00:42:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dce01056c7616f7@google.com>
Subject: INFO: task hung in isig
From: syzbot <syzbot+904e84db8111c6b813a5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    305bb5521282 Merge tag 'selinux-pr-20180516' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a2e817800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
dashboard link: https://syzkaller.appspot.com/bug?extid=904e84db8111c6b813a5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+904e84db8111c6b813a5@syzkaller.appspotmail.com

QAT: Invalid ioctl
QAT: Invalid ioctl
INFO: task kworker/u4:1:22 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc5+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:1    D21192    22      2 0x80000000
Workqueue: events_unbound flush_to_ldisc
Call Trace:
  context_switch kernel/sched/core.c:2859 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3501
  schedule+0xef/0x430 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x919/0x15d0  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa2/0x120 kernel/locking/rwsem.c:72
  isig+0xcd/0x4e0 drivers/tty/n_tty.c:1098
  n_tty_receive_signal_char+0x22/0x120 drivers/tty/n_tty.c:1210
  n_tty_receive_char_special+0x1c27/0x31c0 drivers/tty/n_tty.c:1259
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1577 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x20ca/0x2c50 drivers/tty/n_tty.c:1709
  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
  tty_port_default_receive_buf+0x110/0x170 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:475 [inline]
  flush_to_ldisc+0x3e9/0x560 drivers/tty/tty_buffer.c:524
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Showing all locks held in the system:
5 locks held by kworker/u4:1/22:
  #0: 000000001dc3943a ((wq_completion)"events_unbound"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 000000001dc3943a ((wq_completion)"events_unbound"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000001dc3943a ((wq_completion)"events_unbound"){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000001dc3943a ((wq_completion)"events_unbound"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 000000001dc3943a ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 000000001dc3943a ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000001dc3943a ((wq_completion)"events_unbound"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 000000008f0b638f ((work_completion)(&buf->work)){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2: 00000000990bb5bf (&port->buf.lock/1){+.+.}, at:  
flush_to_ldisc+0xb7/0x560 drivers/tty/tty_buffer.c:496
  #3: 0000000099c45246 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x22/0x90  
drivers/tty/tty_ldisc.c:297
  #4: 00000000d30a93bc (&o_tty->termios_rwsem/1){++++}, at: isig+0xcd/0x4e0  
drivers/tty/n_tty.c:1098
2 locks held by khungtaskd/892:
  #0: 00000000e7f43964 (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 00000000e7f43964 (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000cf356aca (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4478:
  #0: 00000000af8d00b5 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000004c713777 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4479:
  #0: 00000000f491f9ae (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000967ef2ed (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4480:
  #0: 0000000081403dbf (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000006dbf434a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4481:
  #0: 00000000696ca64b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000f2186308 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4482:
  #0: 00000000134fe4ff (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000004c6b985f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4483:
  #0: 000000000ee5a4b2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000c14850c4 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4484:
  #0: 00000000a43f394c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000cae7e8e2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
1 lock held by syz-executor0/8568:
  #0: 00000000e5af04b3 (event_mutex){+.+.}, at:  
perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:235
3 locks held by syz-executor7/8584:
  #0: 000000002ac6d743 (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0x129f/0x2fa0 kernel/events/core.c:10475
  #1: 0000000015a5b817 (&pmus_srcu){....}, at:  
perf_event_alloc.part.91+0xfa4/0x3090 kernel/events/core.c:10034
  #2: 00000000e5af04b3 (event_mutex){+.+.}, at: perf_trace_init+0x50/0x250  
kernel/trace/trace_event_perf.c:217
1 lock held by syz-executor1/8583:
  #0: 000000008b65af1a (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1391

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 892 Comm: khungtaskd Not tainted 4.17.0-rc5+ #55
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
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8572 Comm: syz-executor3 Not tainted 4.17.0-rc5+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:write_comp_data+0x1/0x70 kernel/kcov.c:116
RSP: 0018:ffff8801871af7c0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 000000024ed0a4db RCX: ffffffff8397b25c
RDX: 0000000000000000 RSI: 00000000000000ff RDI: 0000000000000001
RBP: ffff8801871af7d0 R08: ffff880186026000 R09: 0000000000000006
R10: ffff880186026000 R11: 0000000000000000 R12: ffffc90012222000
R13: 0000000000000035 R14: 000000024ed0a4dc R15: 0000000000000000
FS:  00007f6471b67700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004daac4 CR3: 00000001c8cf7000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __process_echoes+0x2dc/0x8d0 drivers/tty/n_tty.c:732
  flush_echoes drivers/tty/n_tty.c:799 [inline]
  __receive_buf drivers/tty/n_tty.c:1615 [inline]
  n_tty_receive_buf_common+0x11d5/0x2c50 drivers/tty/n_tty.c:1709
  n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1738
  tiocsti drivers/tty/tty_io.c:2171 [inline]
  tty_ioctl+0x7e7/0x1870 drivers/tty/tty_io.c:2557
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a09
RSP: 002b:00007f6471b66c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6471b676d4 RCX: 0000000000455a09
RDX: 0000000020000000 RSI: 0000000000005412 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000363 R14: 00000000006f91e8 R15: 0000000000000000
Code: f7 e8 f4 6b 3c 00 e9 86 fd ff ff 48 8b bd d0 fe ff ff e8 83 6c 3c 00  
e9 bd fc ff ff 4c 89 ef e8 d6 6b 3c 00 e9 86 fc ff ff 90 55 <65> 4c 8b 04  
25 c0 ed 01 00 65 8b 05 bf be 88 7e 48 89 e5 a9 00


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
