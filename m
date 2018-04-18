Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeDRVCG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 17:02:06 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:39851 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeDRVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 17:02:03 -0400
X-Google-Smtp-Source: AIpwx4/pZjFRokTH2b1IPffK/a7fKkvX+8pO36+tlHpWomy9XbB5Di9cmyf4TJ44gvgJ8uQQiFj+nDA0mdCw/7CUemyY4sHKLBe1
MIME-Version: 1.0
Date: Wed, 18 Apr 2018 14:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004366bc056a25c4f3@google.com>
Subject: WARNING: suspicious RCU usage in fib6_info_alloc
From: syzbot <syzbot+2add39b05179b31f912f@syzkaller.appspotmail.com>
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

syzbot hit the following crash on net-next commit
0565de29cbd65b378147d36f9642f93a046240dc (Wed Apr 18 03:41:18 2018 +0000)
Merge branch 'ipv6-Separate-data-structures-for-FIB-and-data-path'
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=2add39b05179b31f912f

So far this crash happened 2 times on net-next.
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4660613020123136
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5742127124316160
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2add39b05179b31f912f@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21

=============================
WARNING: suspicious RCU usage
4.16.0+ #5 Not tainted
-----------------------------
kernel/sched/core.c:6153 Illegal context switch in RCU-bh read-side  
critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by kworker/1:1/25:
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 000000007d88bc46 ((work_completion)(&(&ifa->dad_work)->work)){+.+.},  
at: process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2: 00000000943eaf98 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74
  #3: 00000000a39c89a4 (rcu_read_lock_bh){....}, at:  
ipv6_ifa_notify+0x0/0x210 net/ipv6/addrconf.c:5621

stack backtrace:
CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 4.16.0+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4592
  ___might_sleep+0x2e7/0x320 kernel/sched/core.c:6153
  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc_trace+0x2bc/0x780 mm/slab.c:3618
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  fib6_info_alloc+0xbb/0x280 net/ipv6/ip6_fib.c:152
  ip6_route_info_create+0x7bf/0x3240 net/ipv6/route.c:2891
  ip6_route_add+0x23/0xb0 net/ipv6/route.c:3030
  addrconf_prefix_route.isra.47+0x4f7/0x6f0 net/ipv6/addrconf.c:2347
  __ipv6_ifa_notify+0x591/0xa00 net/ipv6/addrconf.c:5620
  ipv6_ifa_notify+0xff/0x210 net/ipv6/addrconf.c:5650
  addrconf_dad_completed+0xeb/0xbf0 net/ipv6/addrconf.c:4083
  addrconf_dad_begin net/ipv6/addrconf.c:3889 [inline]
  addrconf_dad_work+0x873/0x1300 net/ipv6/addrconf.c:3991
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 0, pid: 25, name: kworker/1:1
4 locks held by kworker/1:1/25:
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 00000000df858653 ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 000000007d88bc46 ((work_completion)(&(&ifa->dad_work)->work)){+.+.},  
at: process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2: 00000000943eaf98 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:74
  #3: 00000000a39c89a4 (rcu_read_lock_bh){....}, at:  
ipv6_ifa_notify+0x0/0x210 net/ipv6/addrconf.c:5621
CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 4.16.0+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  ___might_sleep.cold.88+0x11f/0x13a kernel/sched/core.c:6188
  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc_trace+0x2bc/0x780 mm/slab.c:3618
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  fib6_info_alloc+0xbb/0x280 net/ipv6/ip6_fib.c:152
  ip6_route_info_create+0x7bf/0x3240 net/ipv6/route.c:2891
  ip6_route_add+0x23/0xb0 net/ipv6/route.c:3030
  addrconf_prefix_route.isra.47+0x4f7/0x6f0 net/ipv6/addrconf.c:2347
  __ipv6_ifa_notify+0x591/0xa00 net/ipv6/addrconf.c:5620
  ipv6_ifa_notify+0xff/0x210 net/ipv6/addrconf.c:5650
  addrconf_dad_completed+0xeb/0xbf0 net/ipv6/addrconf.c:4083
  addrconf_dad_begin net/ipv6/addrconf.c:3889 [inline]
  addrconf_dad_work+0x873/0x1300 net/ipv6/addrconf.c:3991
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
