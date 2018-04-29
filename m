Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbeD2QbX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 12:31:23 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:52726 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbeD2QbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 12:31:02 -0400
X-Google-Smtp-Source: AB8JxZp+viGqnpSPrt4c1JFf758CbAi0roq4VhLXTJfmUT6mLn/TwNEJDJ9KtuNB7xKksBXo/3QwzMWQ9T0LBycSF47XUr8XZRx9
MIME-Version: 1.0
Date: Sun, 29 Apr 2018 09:31:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004949d1056aff43f0@google.com>
Subject: KASAN: use-after-free Read in path_init
From: syzbot <syzbot+ebb37fc8fd7a28c93dec@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
d8a332730e757129e70675679f2b2a03f1ecf65e (Fri Apr 27 17:39:38 2018 +0000)
Merge tag 'char-misc-4.17-rc3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=ebb37fc8fd7a28c93dec

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6333718402695168
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=7043958930931867332
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ebb37fc8fd7a28c93dec@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
==================================================================
BUG: KASAN: use-after-free in path_init+0x1675/0x2320 fs/namei.c:2132
Read of size 1 at addr ffff8801c907ae80 by task syz-executor7/4548

CPU: 1 PID: 4548 Comm: syz-executor7 Not tainted 4.17.0-rc2+ #20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  path_init+0x1675/0x2320 fs/namei.c:2132
  path_openat+0x1f1/0x4e20 fs/namei.c:3495
  do_filp_open+0x249/0x350 fs/namei.c:3535
  do_sys_open+0x56f/0x740 fs/open.c:1093
  __do_sys_open fs/open.c:1111 [inline]
  __se_sys_open fs/open.c:1106 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1106
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x453aa0
RSP: 002b:0000000000a3d940 EFLAGS: 00000202 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000000000000004a RCX: 0000000000453aa0
RDX: 000000000000000c RSI: 0000000000090800 RDI: 0000000000a3f790
RBP: 0000000000a3f790 R08: 0000000000000001 R09: 0000000000e25940
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000001e4
R13: 0000000000000000 R14: 00000000000001e4 R15: 000000000001b450

Allocated by task 4549:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  getname_flags+0xd0/0x5a0 fs/namei.c:140
  getname fs/namei.c:211 [inline]
  do_rmdir+0xe3/0x610 fs/namei.c:3878
  __do_sys_rmdir fs/namei.c:3929 [inline]
  __se_sys_rmdir fs/namei.c:3927 [inline]
  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3927
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4549:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  putname+0xf2/0x130 fs/namei.c:261
  do_rmdir+0x202/0x610 fs/namei.c:3919
  __do_sys_rmdir fs/namei.c:3929 [inline]
  __se_sys_rmdir fs/namei.c:3927 [inline]
  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3927
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801c907ae80
  which belongs to the cache names_cache of size 4096
The buggy address is located 0 bytes inside of
  4096-byte region [ffff8801c907ae80, ffff8801c907be80)
The buggy address belongs to the page:
page:ffffea0007241e80 count:1 mapcount:0 mapping:ffff8801c907ae80 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801c907ae80 0000000000000000 0000000100000001
raw: ffffea0007245ea0 ffffea0006bbc220 ffff8801da988dc0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c907ad80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801c907ae00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801c907ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8801c907af00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c907af80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
