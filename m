Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeDAIVE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 04:21:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:48608 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeDAIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 04:21:02 -0400
X-Google-Smtp-Source: AIpwx48QAbCDTwUNdoY32Tvf6fRwqMkBgZYyWzSRwvZS9Ofy/9r1U9YIn+efSoi4QX/YuAUCN51FX41sEQY8ZJ6L9zJ/kJPRU8z+
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 01:21:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <94eb2c06406c59cccc0568c527c2@google.com>
Subject: KASAN: use-after-free Read in alloc_pid
From: syzbot <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dhowells@redhat.com, ebiederm@xmission.com,
        gs051095@gmail.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
        pasha.tatashin@oracle.com, riel@redhat.com, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
9dd2326890d89a5179967c947dab2bab34d7ddee (Fri Mar 30 17:29:47 2018 +0000)
Merge tag 'ceph-for-4.16-rc8' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=7a1cff37dbbef9e7ba4c

So far this crash happened 4 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6588786309857280
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

R10: 0000000020000900 R11: 0000000000000246 R12: 0000000000000015
R13: 0000000000000051 R14: 00000000006f2838 R15: 0000000000000028
==================================================================
BUG: KASAN: use-after-free in alloc_pid+0x9a6/0xa00 kernel/pid.c:236
Read of size 4 at addr ffff8801b56d0088 by task syz-executor4/3533

CPU: 1 PID: 3533 Comm: syz-executor4 Not tainted 4.16.0-rc7+ #372
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  alloc_pid+0x9a6/0xa00 kernel/pid.c:236
  copy_process.part.38+0x2516/0x4bd0 kernel/fork.c:1807
  copy_process kernel/fork.c:1606 [inline]
  _do_fork+0x1f7/0xf70 kernel/fork.c:2087
  SYSC_clone kernel/fork.c:2194 [inline]
  SyS_clone+0x37/0x50 kernel/fork.c:2188
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x454e79
RSP: 002b:00007f6165b9ac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f6165b9b6d4 RCX: 0000000000454e79
RDX: 00000000200008c0 RSI: 0000000020000800 RDI: 000000002000c100
RBP: 000000000072bea0 R08: 0000000020000940 R09: 0000000000000000
R10: 0000000020000900 R11: 0000000000000246 R12: 0000000000000015
R13: 0000000000000051 R14: 00000000006f2838 R15: 0000000000000028

Allocated by task 3533:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3542
  kmem_cache_zalloc include/linux/slab.h:691 [inline]
  create_pid_namespace kernel/pid_namespace.c:116 [inline]
  copy_pid_ns+0x257/0xc60 kernel/pid_namespace.c:175
  create_new_namespaces+0x307/0x880 kernel/nsproxy.c:94
  copy_namespaces+0x340/0x400 kernel/nsproxy.c:165
  copy_process.part.38+0x2380/0x4bd0 kernel/fork.c:1796
  copy_process kernel/fork.c:1606 [inline]
  _do_fork+0x1f7/0xf70 kernel/fork.c:2087
  SYSC_clone kernel/fork.c:2194 [inline]
  SyS_clone+0x37/0x50 kernel/fork.c:2188
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 3539:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kmem_cache_free+0x83/0x2a0 mm/slab.c:3744
  delayed_free_pidns+0x82/0xb0 kernel/pid_namespace.c:157
  __rcu_reclaim kernel/rcu/rcu.h:172 [inline]
  rcu_do_batch kernel/rcu/tree.c:2674 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2933 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2900 [inline]
  rcu_process_callbacks+0xd6c/0x17f0 kernel/rcu/tree.c:2917
  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285

The buggy address belongs to the object at ffff8801b56d0040
  which belongs to the cache pid_namespace of size 240
The buggy address is located 72 bytes inside of
  240-byte region [ffff8801b56d0040, ffff8801b56d0130)
The buggy address belongs to the page:
page:ffffea0006d5b400 count:1 mapcount:0 mapping:ffff8801b56d0040 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801b56d0040 0000000000000000 000000010000000d
raw: ffffea00074458a0 ffffea00073389e0 ffff8801d40b2c00 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b56cff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801b56d0000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8801b56d0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8801b56d0100: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fb fb
  ffff8801b56d0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
