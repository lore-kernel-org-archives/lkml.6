Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeDSQNE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:13:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:51841 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeDSQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:13:02 -0400
X-Google-Smtp-Source: AIpwx48QnoopbqgxociP5n1m29t871xSG7pLqbYYzokcsOHv9wH4Za/8KRfc2fXzyZE4rfBW5LXndNQG9KajnrhZ5sF59NPj9X/+
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 09:13:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083a5fd056a35d88d@google.com>
Subject: KASAN: use-after-free Read in __fput (2)
From: syzbot <syzbot+84182572be3bf4a0f9b9@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on net-next commit
17dec0a949153d9ac00760ba2f5b78cb583e995f (Wed Apr 4 02:15:32 2018 +0000)
Merge branch 'userns-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=84182572be3bf4a0f9b9

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6611189933015040
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2735707888269579554
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+84182572be3bf4a0f9b9@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KASAN: use-after-free in fsnotify_close include/linux/fsnotify.h:233  
[inline]
BUG: KASAN: use-after-free in __fput+0x807/0x890 fs/file_table.c:195
Read of size 8 at addr ffff8801c96aa1c8 by task syz-executor1/10565

CPU: 0 PID: 10565 Comm: syz-executor1 Not tainted 4.16.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  fsnotify_close include/linux/fsnotify.h:233 [inline]
  __fput+0x807/0x890 fs/file_table.c:195
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2469
  do_signal+0x90/0x2020 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x455259
RSP: 002b:00007efdb432bce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bf80 RCX: 0000000000455259
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bf80
RBP: 000000000072bf80 R08: 0000000000000000 R09: 000000000072bf58
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000a3e81f R14: 00007efdb432c9c0 R15: 0000000000000001

Allocated by task 10558:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:552
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
  slab_post_alloc_hook mm/slab.h:443 [inline]
  slab_alloc mm/slab.c:3380 [inline]
  kmem_cache_alloc+0x11b/0x760 mm/slab.c:3540
  __d_alloc+0xc1/0xc00 fs/dcache.c:1610
  d_alloc_pseudo+0x1d/0x30 fs/dcache.c:1732
  sock_alloc_file+0x157/0x4e0 net/socket.c:401
  __sys_accept4+0x28d/0x8a0 net/socket.c:1580
  SYSC_accept4 net/socket.c:1626 [inline]
  SyS_accept4+0x2c/0x40 net/socket.c:1623
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 10565:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3744
  __d_free fs/dcache.c:266 [inline]
  dentry_free+0xe9/0x170 fs/dcache.c:342
  __dentry_kill+0x516/0x770 fs/dcache.c:589
  dentry_kill fs/dcache.c:616 [inline]
  dput.part.25+0x7cb/0x9a0 fs/dcache.c:831
  dput+0x1f/0x30 fs/dcache.c:795
  path_put+0x31/0x70 fs/namei.c:481
  free_fs_struct+0x22/0x60 fs/fs_struct.c:90
  exit_fs+0xf3/0x130 fs/fs_struct.c:107
  do_exit+0xf58/0x2730 kernel/exit.c:861
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2469
  do_signal+0x90/0x2020 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the object at ffff8801c96aa170
  which belongs to the cache dentry(29:syz1) of size 288
The buggy address is located 88 bytes inside of
  288-byte region [ffff8801c96aa170, ffff8801c96aa290)
The buggy address belongs to the page:
page:ffffea000725aa80 count:1 mapcount:0 mapping:ffff8801c96aa000 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801c96aa000 0000000000000000 000000010000000b
raw: ffffea00072dee20 ffffea000725dda0 ffff8801d8328c00 ffff8801b45ba000
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801b45ba000

Memory state around the buggy address:
  ffff8801c96aa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c96aa100: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fb fb
> ffff8801c96aa180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff8801c96aa200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c96aa280: fb fb fc fc fc fc fc fc fc fc fc fc fb fb fb fb
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
