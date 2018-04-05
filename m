Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDEECC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 00:02:02 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:37848 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDEECB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 00:02:01 -0400
X-Google-Smtp-Source: AIpwx493rGcHXKXUD8TLkaQ2VjifeYCNEPQi3cjkNHe0riJwAO4RQ4rRhpSlcOeE25SUitREUwdtFScs33JYgXit/sCDAnTZ6AQz
MIME-Version: 1.0
Date: Wed, 04 Apr 2018 21:02:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a11441b6c6cb96c0569120042@google.com>
Subject: KASAN: use-after-free Read in ntfs_read_locked_inode
From: syzbot <syzbot+19b469021157c136116a@syzkaller.appspotmail.com>
To: anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
3e968c9f1401088abc9a19ae6ff571644d37a355 (Wed Apr 4 21:19:24 2018 +0000)
Merge tag 'ext4_for_linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=19b469021157c136116a

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5682455868604416
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5679121900240896
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5751565918928896
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=9118669095563550941
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+19b469021157c136116a@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

ntfs: volume version 3.1.
ntfs: volume version 3.1.
ntfs: volume version 3.1.
ntfs: volume version 3.1.
==================================================================
BUG: KASAN: use-after-free in ntfs_read_locked_inode+0x47fe/0x51b0  
fs/ntfs/inode.c:670
Read of size 8 at addr ffff8801becc42e8 by task syzkaller675411/4496

CPU: 0 PID: 4496 Comm: syzkaller675411 Not tainted 4.16.0+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load_n_noabort+0xf/0x20 mm/kasan/report.c:443
  ntfs_read_locked_inode+0x47fe/0x51b0 fs/ntfs/inode.c:670
  ntfs_iget+0x1ab/0x240 fs/ntfs/inode.c:190
  load_and_init_quota fs/ntfs/super.c:1406 [inline]
  load_system_files+0x5f06/0x6c80 fs/ntfs/super.c:2117
  ntfs_fill_super+0x1485/0x2fb0 fs/ntfs/super.c:2908
  mount_bdev+0x2b7/0x370 fs/super.c:1119
  ntfs_mount+0x34/0x40 fs/ntfs/super.c:3065
  mount_fs+0x66/0x2d0 fs/super.c:1222
  vfs_kern_mount.part.26+0xc6/0x4a0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:2514 [inline]
  do_new_mount fs/namespace.c:2517 [inline]
  do_mount+0xea4/0x2b90 fs/namespace.c:2847
  ksys_mount+0xab/0x120 fs/namespace.c:3063
  SYSC_mount fs/namespace.c:3077 [inline]
  SyS_mount+0x39/0x50 fs/namespace.c:3074
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x44597a
RSP: 002b:00007ffe9dfbd7d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000a80 RCX: 000000000044597a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe9dfbd850
RBP: 0000000000000003 R08: 0000000020077a00 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000004
R13: 000000000000ab33 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0006fb3100 count:0 mapcount:0 mapping:0000000000000000 index:0x1
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000001 00000000ffffffff
raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801becc4180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801becc4200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801becc4280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                           ^
  ffff8801becc4300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801becc4380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
