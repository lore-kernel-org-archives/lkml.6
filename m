Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbeCaUtf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 16:49:35 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:57308 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeCaUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 16:47:07 -0400
X-Google-Smtp-Source: AIpwx49u6vXNmdNXEyO44SuHkW8V10YCt4JmFoGdnZI43miEbss3FqyTc1fVeAhMQfYAvUq6PjyRL/ziA8beUY6pXDexX6is2hgL
MIME-Version: 1.0
Date: Sat, 31 Mar 2018 13:47:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113ed49eb535d20568bb75ba@google.com>
Subject: KASAN: slab-out-of-bounds Read in find_first_zero_bit
From: syzbot <syzbot+a88c8270030dc5d71e4f@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
b5dbc28762fd3fd40ba76303be0c7f707826f982 (Sat Mar 31 04:53:57 2018 +0000)
Merge tag 'kbuild-fixes-v4.16-3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=a88c8270030dc5d71e4f

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6431707947335680
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6420485734662144
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6746019962290176
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a88c8270030dc5d71e4f@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KASAN: slab-out-of-bounds in find_first_zero_bit+0xc5/0xe0  
lib/find_bit.c:125
Read of size 8 at addr ffff8801d7480a00 by task syzkaller291450/4476

CPU: 1 PID: 4476 Comm: syzkaller291450 Not tainted 4.16.0-rc7+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  find_first_zero_bit+0xc5/0xe0 lib/find_bit.c:125
  bfs_create+0xf7/0x610 fs/bfs/dir.c:92
  lookup_open+0x1217/0x1970 fs/namei.c:3200
  do_last fs/namei.c:3291 [inline]
  path_openat+0xd76/0x3530 fs/namei.c:3519
  do_filp_open+0x25b/0x3b0 fs/namei.c:3554
  do_sys_open+0x502/0x6d0 fs/open.c:1059
  SYSC_open fs/open.c:1077 [inline]
  SyS_open+0x2d/0x40 fs/open.c:1072
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4404f9
RSP: 002b:00007ffd2305ebd8 EFLAGS: 00000207 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004404f9
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000020000340
RBP: 0000000000000003 R08: 000000000000000a R09: 6f6f6c2f7665642f
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000000004
R13: 0000000000401d70 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4476:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
  __do_kmalloc mm/slab.c:3706 [inline]
  __kmalloc+0x162/0x760 mm/slab.c:3715
  kmalloc include/linux/slab.h:517 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  bfs_fill_super+0x3d3/0xea0 fs/bfs/inode.c:362
  mount_bdev+0x2b7/0x370 fs/super.c:1119
  bfs_mount+0x34/0x40 fs/bfs/inode.c:465
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2509 [inline]
  do_new_mount fs/namespace.c:2512 [inline]
  do_mount+0xea4/0x2bb0 fs/namespace.c:2842
  SYSC_mount fs/namespace.c:3058 [inline]
  SyS_mount+0xab/0x120 fs/namespace.c:3035
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 2830:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kfree+0xd9/0x260 mm/slab.c:3801
  single_release+0x88/0xb0 fs/seq_file.c:606
  __fput+0x327/0x7e0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x199/0x270 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x275/0x2f0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the object at ffff8801d7480a00
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8801d7480a00, ffff8801d7480a20)
The buggy address belongs to the page:
page:ffffea00075d2000 count:1 mapcount:0 mapping:ffff8801d7480000  
index:0xffff8801d7480fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d7480000 ffff8801d7480fc1 000000010000003f
raw: ffffea00075d1ea0 ffffea00075d32a0 ffff8801dac001c0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d7480900: 00 02 fc fc fc fc fc fc 00 02 fc fc fc fc fc fc
  ffff8801d7480980: 00 02 fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
> ffff8801d7480a00: 07 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
                    ^
  ffff8801d7480a80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d7480b00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
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
