Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757390AbeD0FaF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:30:05 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:60099 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeD0FaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:30:03 -0400
X-Google-Smtp-Source: AB8JxZql8iFVnHva0sJNEgFaS9W1v9AqPMa7cH1BuEiZ/yst5bCihef05EW5QOxsAQBz0lt7KYznka7xPdxDH6mH+aQmCYBlunEv
MIME-Version: 1.0
Date: Thu, 26 Apr 2018 22:30:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bebc7d056acdcb7b@google.com>
Subject: KASAN: use-after-free Read in process_preds
From: syzbot <syzbot+b6fc33dcecb65cd8ff80@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on bpf-next commit
5d1365940a68dd57b031b6e3c07d7d451cd69daf (Thu Apr 12 18:09:05 2018 +0000)
Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=b6fc33dcecb65cd8ff80

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4606019153952768
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b6fc33dcecb65cd8ff80@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KASAN: use-after-free in predicate_parse  
kernel/trace/trace_events_filter.c:563 [inline]
BUG: KASAN: use-after-free in process_preds+0x197f/0x19b0  
kernel/trace/trace_events_filter.c:1505
Read of size 4 at addr ffff8801b9832ce4 by task syz-executor0/28463

CPU: 0 PID: 28463 Comm: syz-executor0 Not tainted 4.16.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  predicate_parse kernel/trace/trace_events_filter.c:563 [inline]
  process_preds+0x197f/0x19b0 kernel/trace/trace_events_filter.c:1505
  create_filter+0x1a8/0x370 kernel/trace/trace_events_filter.c:1714
  ftrace_profile_set_filter+0x109/0x2b0  
kernel/trace/trace_events_filter.c:2042
  perf_event_set_filter+0x248/0x1230 kernel/events/core.c:9064
  _perf_ioctl+0x84c/0x15e0 kernel/events/core.c:5056
  perf_ioctl+0x59/0x80 kernel/events/core.c:5107
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  SYSC_ioctl fs/ioctl.c:708 [inline]
  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x455329
RSP: 002b:00007f14b2c73c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f14b2c746d4 RCX: 0000000000455329
RDX: 0000000020000040 RSI: 0000000040082406 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000291 R14: 00000000006f6e38 R15: 0000000000000000

Allocated by task 2370:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  getname_flags+0xd0/0x5a0 fs/namei.c:140
  getname+0x19/0x20 fs/namei.c:211
  do_sys_open+0x39a/0x740 fs/open.c:1087
  SYSC_open fs/open.c:1111 [inline]
  SyS_open+0x2d/0x40 fs/open.c:1106
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 2370:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  putname+0xf2/0x130 fs/namei.c:261
  do_sys_open+0x554/0x740 fs/open.c:1102
  SYSC_open fs/open.c:1111 [inline]
  SyS_open+0x2d/0x40 fs/open.c:1106
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the object at ffff8801b9832340
  which belongs to the cache names_cache of size 4096
The buggy address is located 2468 bytes inside of
  4096-byte region [ffff8801b9832340, ffff8801b9833340)
The buggy address belongs to the page:
page:ffffea0006e60c80 count:1 mapcount:0 mapping:ffff8801b9832340 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801b9832340 0000000000000000 0000000100000001
raw: ffffea000743eca0 ffffea0006628f20 ffff8801dad86dc0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b9832b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b9832c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801b9832c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8801b9832d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b9832d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
