Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDKMCF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:02:05 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:45126 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeDKMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:02:03 -0400
X-Google-Smtp-Source: AIpwx496N4irlNJybdi59VLxGLc7wM5SCHQzjFb9nQMW952/GRsGQHPYynWCoruX4M2vqHfaNAKq8LfJBDxGro9WpY30mNKNUF+D
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 05:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032a0c30569916870@google.com>
Subject: KASAN: stack-out-of-bounds Read in __free_filter
From: syzbot <syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
b284d4d5a6785f8cd07eda2646a95782373cd01e (Tue Apr 10 19:25:30 2018 +0000)
Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=dadcc936587643d7f568

So far this crash happened 6 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6547381214511104
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5485642750361600
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5352489637380096
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

RDX: 000000002099aff9 RSI: 0000000040082406 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe76420032
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: stack-out-of-bounds in __read_once_size  
include/linux/compiler.h:188 [inline]
BUG: KASAN: stack-out-of-bounds in free_prog  
kernel/trace/trace_events_filter.c:988 [inline]
BUG: KASAN: stack-out-of-bounds in __free_filter.part.6+0x1ac/0x1d0  
kernel/trace/trace_events_filter.c:1012
Read of size 8 at addr ffff8801b2cd7698 by task syzkaller788882/4452

CPU: 0 PID: 4452 Comm: syzkaller788882 Not tainted 4.16.0+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:188 [inline]
  free_prog kernel/trace/trace_events_filter.c:988 [inline]
  __free_filter.part.6+0x1ac/0x1d0 kernel/trace/trace_events_filter.c:1012
  __free_filter kernel/trace/trace_events_filter.c:1009 [inline]
  ftrace_profile_set_filter+0x159/0x2b0  
kernel/trace/trace_events_filter.c:2053
  perf_event_set_filter+0x248/0x1230 kernel/events/core.c:9064
  _perf_ioctl+0x84c/0x1650 kernel/events/core.c:5056
  perf_ioctl+0x59/0x80 kernel/events/core.c:5107
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x1650 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  SYSC_ioctl fs/ioctl.c:708 [inline]
  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x440519
RSP: 002b:00007ffe7642b3a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440519
RDX: 000000002099aff9 RSI: 0000000040082406 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe76420032
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0006cb35c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 ffffea0006cb0101 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b2cd7580: 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f3
  ffff8801b2cd7600: f3 f3 f3 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
> ffff8801b2cd7680: f1 00 f2 f2 f2 f3 f3 f3 f3 00 00 00 00 00 00 00
                             ^
  ffff8801b2cd7700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
  ffff8801b2cd7780: f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
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
