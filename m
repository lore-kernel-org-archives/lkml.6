Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEDQPE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:15:04 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:39813 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEDQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:15:02 -0400
X-Google-Smtp-Source: AB8JxZok32+bNTvrHz6l+ftfBeLR042LCIL2XQk77yNJDrIjjg1oT0Bm4H0MjUo21A5CdODqVMWfsAT4F8M8vW2+6oaRNEMjgzA0
MIME-Version: 1.0
Date: Fri, 04 May 2018 09:15:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e82ff056b639fde@google.com>
Subject: KASAN: use-after-free Read in fuse_kill_sb_anon
From: syzbot <syzbot+4bb3ee1dd0bd632f21d7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    150426981426 Merge tag 'linux-kselftest-4.17-rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f7b3e7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=4bb3ee1dd0bd632f21d7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4bb3ee1dd0bd632f21d7@syzkaller.appspotmail.com

binder: 8993:8995 transaction failed 29189/-22, size 0-0 line 2856
R13: 0000000020000100 R14: 0000000000000000 R15: 0000000000000000
netlink: 743 bytes leftover after parsing attributes in process  
`syz-executor3'.
binder: undelivered TRANSACTION_ERROR: 29189
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3888/0x5140  
kernel/locking/lockdep.c:3310
Read of size 8 at addr ffff8801d74d4308 by task syz-executor2/8985

CPU: 1 PID: 8985 Comm: syz-executor2 Not tainted 4.17.0-rc3+ #32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x3888/0x5140 kernel/locking/lockdep.c:3310
binder: 8998:8999 transaction failed 29189/-22, size 0-0 line 2856
binder: undelivered TRANSACTION_ERROR: 29189
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
binder: 8998:8999 transaction failed 29189/-22, size 0-0 line 2856
binder: undelivered TRANSACTION_ERROR: 29189
  down_write+0x87/0x120 kernel/locking/rwsem.c:70
  fuse_kill_sb_anon+0x50/0xb0 fs/fuse/inode.c:1200
  deactivate_locked_super+0x97/0x100 fs/super.c:316
  mount_nodev+0xfa/0x110 fs/super.c:1212
  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1192
  mount_fs+0xae/0x328 fs/super.c:1267
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2848
binder: 9002:9003 transaction failed 29189/-22, size 0-0 line 2856
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007fb75655d808 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000015 RCX: 0000000000455979
RDX: 00000000004c15cc RSI: 0000000020000100 RDI: 00000000004dd5c5
RBP: 0000000000000000 R08: 00007fb75655d820 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000020000100 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 8985:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:512 [inline]
  fuse_fill_super+0xc92/0x1e20 fs/fuse/inode.c:1096
  mount_nodev+0x6b/0x110 fs/super.c:1210
  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1192
  mount_fs+0xae/0x328 fs/super.c:1267
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8997:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  __rcu_reclaim kernel/rcu/rcu.h:173 [inline]
  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2930 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2897 [inline]
  rcu_process_callbacks+0xa69/0x15f0 kernel/rcu/tree.c:2914
  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285

The buggy address belongs to the object at ffff8801d74d4040
  which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 712 bytes inside of
  1024-byte region [ffff8801d74d4040, ffff8801d74d4440)
The buggy address belongs to the page:
page:ffffea00075d3500 count:1 mapcount:0 mapping:ffff8801d74d4040 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801d74d4040 0000000000000000 0000000100000007
raw: ffffea00075a0fa0 ffffea0006c712a0 ffff8801da800ac0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d74d4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d74d4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d74d4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8801d74d4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d74d4400: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


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
