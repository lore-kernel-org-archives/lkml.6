Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeDTQzG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:55:06 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:37991 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeDTQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:55:03 -0400
X-Google-Smtp-Source: AIpwx49QIQV1DA0RBwwyajg23tCqejWAwaO7+fKhPXqUDw4MVifgs2ycIICwXhp1mPOl2+wgDGPlYm1/RLI35Dko/FqL2h8zt3oL
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 09:55:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f4e8e056a4a8cc3@google.com>
Subject: KASAN: use-after-free Read in build_segment_manager
From: syzbot <syzbot+7d6d31d3bc702f566ce3@syzkaller.appspotmail.com>
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
87ef12027b9b1dd0e0b12cf311fbcb19f9d92539 (Wed Apr 18 19:48:17 2018 +0000)
Merge tag 'ceph-for-4.17-rc2' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=7d6d31d3bc702f566ce3

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5889325317226496
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5793527682301952
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5487272690450432
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7d6d31d3bc702f566ce3@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
==================================================================
BUG: KASAN: use-after-free in build_sit_entries fs/f2fs/segment.c:3653  
[inline]
BUG: KASAN: use-after-free in build_segment_manager+0xb92d/0xbf70  
fs/f2fs/segment.c:3852
Read of size 4 at addr ffff8801d8dc2740 by task syzkaller723534/4535

CPU: 1 PID: 4535 Comm: syzkaller723534 Not tainted 4.17.0-rc1+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  build_sit_entries fs/f2fs/segment.c:3653 [inline]
  build_segment_manager+0xb92d/0xbf70 fs/f2fs/segment.c:3852
  f2fs_fill_super+0x4095/0x7bf0 fs/f2fs/super.c:2803
  mount_bdev+0x30c/0x3e0 fs/super.c:1165
  f2fs_mount+0x34/0x40 fs/f2fs/super.c:3020
  mount_fs+0xae/0x328 fs/super.c:1268
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2847
  ksys_mount+0x12d/0x140 fs/namespace.c:3063
  __do_sys_mount fs/namespace.c:3077 [inline]
  __se_sys_mount fs/namespace.c:3074 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3074
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443daa
RSP: 002b:00007ffc697a8218 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000c00 RCX: 0000000000443daa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc697a8220
RBP: 0000000000000003 R08: 0000000020016a00 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000004
R13: 0000000000402ca0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 2838:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node+0x47/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:554 [inline]
  kvmalloc_node+0x6b/0x100 mm/util.c:421
  kvmalloc include/linux/mm.h:550 [inline]
  seq_buf_alloc fs/seq_file.c:32 [inline]
  seq_read+0xa33/0x1520 fs/seq_file.c:211
  __vfs_read+0x10f/0xa50 fs/read_write.c:416
  vfs_read+0x17f/0x3d0 fs/read_write.c:452
  ksys_read+0xf9/0x250 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2838:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  kvfree+0x61/0x70 mm/util.c:440
  seq_release fs/seq_file.c:371 [inline]
  single_release+0x78/0xb0 fs/seq_file.c:608
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d8dc23c0
  which belongs to the cache kmalloc-4096 of size 4096
The buggy address is located 896 bytes inside of
  4096-byte region [ffff8801d8dc23c0, ffff8801d8dc33c0)
The buggy address belongs to the page:
page:ffffea0007637080 count:1 mapcount:0 mapping:ffff8801d8dc23c0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801d8dc23c0 0000000000000000 0000000100000001
raw: ffffea0007637020 ffffea000763a120 ffff8801da800dc0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d8dc2600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d8dc2680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801d8dc2700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8801d8dc2780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d8dc2800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
