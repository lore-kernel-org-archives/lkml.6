Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeFDPDb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:03:31 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:42958 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:03:28 -0400
X-Google-Smtp-Source: ADUXVKLBYl+c4qs9nAv7ugG+mT8pg+FlLQQcJ+Gzc0sKGvpYk52/KUsbvZMfPYOgO7zF5mZHBFsQ3rJrG8j+krkK4za8lROe9phJ
MIME-Version: 1.0
Date: Mon, 04 Jun 2018 08:03:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e4595056dd23c16@google.com>
Subject: INFO: task hung in ip6gre_exit_batch_net
From: syzbot <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com>
To: christian.brauner@ubuntu.com, davem@davemloft.net, dsahern@gmail.com,
        fw@strlen.de, jbenc@redhat.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        mschiffer@universe-factory.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com

INFO: task kworker/u4:1:22 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc6+ #68
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:1    D13944    22      2 0x80000000
Workqueue: netns cleanup_net
Call Trace:
  context_switch kernel/sched/core.c:2859 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3501
  schedule+0xef/0x430 kernel/sched/core.c:3545
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3603
  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
  __mutex_lock+0xe38/0x17f0 kernel/locking/mutex.c:893
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
  ip6gre_exit_batch_net+0xd5/0x7d0 net/ipv6/ip6_gre.c:1585
  ops_exit_list.isra.7+0x105/0x160 net/core/net_namespace.c:155
  cleanup_net+0x51d/0xb20 net/core/net_namespace.c:523
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Showing all locks held in the system:
4 locks held by kworker/u4:1/22:
  #0: 0000000049a7b590 ((wq_completion)"%s""netns"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 0000000049a7b590 ((wq_completion)"%s""netns"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000049a7b590 ((wq_completion)"%s""netns"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000049a7b590 ((wq_completion)"%s""netns"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 0000000049a7b590 ((wq_completion)"%s""netns"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 0000000049a7b590 ((wq_completion)"%s""netns"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000049a7b590 ((wq_completion)"%s""netns"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 0000000030a00b6b (net_cleanup_work){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2: 000000007eb35e65 (pernet_ops_rwsem){++++}, at: cleanup_net+0x11a/0xb20  
net/core/net_namespace.c:490
  #3: 000000007eb32c75 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74
3 locks held by kworker/1:1/24:
  #0: 000000001c9e6580 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 000000001c9e6580 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000001c9e6580 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000001c9e6580 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 000000001c9e6580 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 000000001c9e6580 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000001c9e6580 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 000000009edcfbe7 ((addr_chk_work).work){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2: 000000007eb32c75 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74
2 locks held by khungtaskd/893:
  #0: 000000007eeb621a (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 000000007eeb621a (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000239f1b5e (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4481:
  #0: 00000000cc114025 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000006ad1f3fc (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4482:
  #0: 00000000226a16cc (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000008cee8cdc (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4483:
  #0: 0000000067bd3c39 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000005d8bc81d (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4484:
  #0: 00000000f0f8d839 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000a9d5f091 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4485:
  #0: 000000002c96ee9a (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000033338ac7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4486:
  #0: 00000000f6db39b5 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000bb7c6099 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4487:
  #0: 000000006be9659d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000e2edd3d0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
3 locks held by kworker/1:3/27147:
  #0: 00000000c208aa7f ((wq_completion)"events"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 00000000c208aa7f ((wq_completion)"events"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000c208aa7f ((wq_completion)"events"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 00000000c208aa7f ((wq_completion)"events"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:57 [inline]
  #0: 00000000c208aa7f ((wq_completion)"events"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 00000000c208aa7f ((wq_completion)"events"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 00000000c208aa7f ((wq_completion)"events"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 00000000fa87e61f (deferred_process_work){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2: 000000007eb32c75 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74
1 lock held by syz-executor7/29665:
  #0: 000000006e20d618 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1469 [inline]
  #0: 000000006e20d618 (sk_lock-AF_INET6){+.+.}, at:  
tls_sw_sendmsg+0x1b9/0x12e0 net/tls/tls_sw.c:384
1 lock held by syz-executor7/29689:
  #0: 000000007eb32c75 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 893 Comm: khungtaskd Not tainted 4.17.0-rc6+ #68
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
