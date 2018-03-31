Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeCaPnD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 11:43:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:33115 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbeCaPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 11:43:01 -0400
X-Google-Smtp-Source: AIpwx4+BsUAcVEba/ThgrjYvj+hSXyHBXRatYAZ7kwvXnAW2b2sKtnzVOM69trOdOOZzQUgXMMOFy5C8nGi8s+jenjv304vYdiBd
MIME-Version: 1.0
Date: Sat, 31 Mar 2018 08:43:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003324f20568b7363f@google.com>
Subject: INFO: task hung in tunnel_key_exit_net
From: syzbot <syzbot+5093dde0c59c3c1f74e8@syzkaller.appspotmail.com>
To: christian.brauner@ubuntu.com, davem@davemloft.net, dsahern@gmail.com,
        fw@strlen.de, jbenc@redhat.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on net-next commit
18845557fd6fc1998f2d0d8c30467f86db587529 (Thu Mar 29 20:24:06 2018 +0000)
Merge tag 'wireless-drivers-next-for-davem-2018-03-29' of  
git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=5093dde0c59c3c1f74e8

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5957616438083584
Kernel config: https://syzkaller.appspot.com/x/.config?id=-37309782588693906
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5093dde0c59c3c1f74e8@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: sync thread started: state = BACKUP, mcast_ifn = lo, syncid = 4, id =  
0
IPVS: stopping backup sync thread 24307 ...
INFO: task kworker/u4:10:9047 blocked for more than 120 seconds.
       Not tainted 4.16.0-rc6+ #286
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:10   D21104  9047      2 0x80000000
Workqueue: netns cleanup_net
Call Trace:
  context_switch kernel/sched/core.c:2862 [inline]
  __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
  schedule+0xf5/0x430 kernel/sched/core.c:3499
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3557
  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
  __mutex_lock+0xaad/0x1a80 kernel/locking/mutex.c:893
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
  tc_action_net_exit include/net/act_api.h:132 [inline]
  tunnel_key_exit_net+0x7a/0x3b0 net/sched/act_tunnel_key.c:334
  ops_exit_list.isra.6+0x100/0x150 net/core/net_namespace.c:154
  cleanup_net+0x4d8/0xa90 net/core/net_namespace.c:522
  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 869 Comm: khungtaskd Not tainted 4.16.0-rc6+ #286
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x123/0x180 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0x90c/0xd60 kernel/hung_task.c:249
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54
Kernel panic - not syncing: hung_task: blocked tasks
CPU: 0 PID: 869 Comm: khungtaskd Not tainted 4.16.0-rc6+ #286
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  check_hung_task kernel/hung_task.c:133 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0x91d/0xd60 kernel/hung_task.c:249
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
