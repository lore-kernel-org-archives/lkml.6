Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeDERCE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:02:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:51756 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeDERCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:02:01 -0400
X-Google-Smtp-Source: AIpwx4/2Mx1qPN6VGlvV5HW+wJpT3drpg0wdOJUBjrJN8uS//aQauyO+qGqKp2f29fpl79D+6Vb65epAtqKBFGd3cvhhObwE73wg
MIME-Version: 1.0
Date: Thu, 05 Apr 2018 10:02:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec007c05691ce52c@google.com>
Subject: KASAN: slab-out-of-bounds Read in getname_kernel
From: syzbot <syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
06dd3dfeea60e2a6457a6aedf97afc8e6d2ba497 (Thu Apr 5 03:07:20 2018 +0000)
Merge tag 'char-misc-4.17-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=60c837b428dc84e83a93

So far this crash happened 2 times on upstream.
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4920703421775872
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5627492903682048
Kernel config: https://syzkaller.appspot.com/x/.config?id=216543573824217049
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: slab-out-of-bounds in strlen+0x91/0xa0 lib/string.c:482
Read of size 1 at addr ffff8801ac7eb680 by task syz-executor0/4520

CPU: 0 PID: 4520 Comm: syz-executor0 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  strlen+0x91/0xa0 lib/string.c:482
  strlen include/linux/string.h:267 [inline]
  getname_kernel+0x24/0x370 fs/namei.c:216
  kern_path+0x1e/0x40 fs/namei.c:2397
  create_local_trace_uprobe+0x96/0x6e0 kernel/trace/trace_uprobe.c:1357
  perf_uprobe_init+0x189/0x260 kernel/trace/trace_event_perf.c:310
  perf_uprobe_event_init+0xdb/0x160 kernel/events/core.c:8444
  perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9719
  perf_init_event kernel/events/core.c:9750 [inline]
  perf_event_alloc.part.91+0x1920/0x30a0 kernel/events/core.c:10022
  perf_event_alloc kernel/events/core.c:10376 [inline]
  SYSC_perf_event_open+0xa8a/0x2fa0 kernel/events/core.c:10477
  SyS_perf_event_open+0x35/0x40 kernel/events/core.c:10366
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4552d9
RSP: 002b:00007f1ec591fc68 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f1ec59206d4 RCX: 00000000004552d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000002000a000
RBP: 000000000072c010 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000458 R14: 00000000006f98e0 R15: 0000000000000002

Allocated by task 4520:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:552
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3608
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  perf_uprobe_init+0x97/0x260 kernel/trace/trace_event_perf.c:298
  perf_uprobe_event_init+0xdb/0x160 kernel/events/core.c:8444
  perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9719
  perf_init_event kernel/events/core.c:9750 [inline]
  perf_event_alloc.part.91+0x1920/0x30a0 kernel/events/core.c:10022
  perf_event_alloc kernel/events/core.c:10376 [inline]
  SYSC_perf_event_open+0xa8a/0x2fa0 kernel/events/core.c:10477
  SyS_perf_event_open+0x35/0x40 kernel/events/core.c:10366
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 2931:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kfree+0xd9/0x260 mm/slab.c:3801
  kvfree+0x61/0x70 mm/util.c:438
  seq_release fs/seq_file.c:368 [inline]
  single_release+0x78/0xb0 fs/seq_file.c:605
  close_pdeo.part.2+0x11e/0x420 fs/proc/inode.c:166
  close_pdeo+0x173/0x1e0 include/linux/spinlock.h:310
  proc_reg_release+0x11b/0x150 fs/proc/inode.c:377
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the object at ffff8801ac7ea680
  which belongs to the cache kmalloc-4096 of size 4096
The buggy address is located 0 bytes to the right of
  4096-byte region [ffff8801ac7ea680, ffff8801ac7eb680)
The buggy address belongs to the page:
page:ffffea0006b1fa80 count:1 mapcount:0 mapping:ffff8801ac7ea680 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801ac7ea680 0000000000000000 0000000100000001
raw: ffffea0006b04e20 ffff8801dac01a48 ffff8801dac00dc0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ac7eb580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801ac7eb600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801ac7eb680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff8801ac7eb700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801ac7eb780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
