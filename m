Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeDBRBX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:01:23 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:49098 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753035AbeDBRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:01:03 -0400
X-Google-Smtp-Source: AIpwx4+aTH8HpZKdmIhth7McEgVhQjzfTYPJEHsdEBOVY4NZMIANLCy+reujy78qaA71CwJ/kiFvYGT4u3AARg691yI2K+wdnlPk
MIME-Version: 1.0
Date: Mon, 02 Apr 2018 10:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113fd904ee846d0568e088b9@google.com>
Subject: KASAN: use-after-free Write in __ext4_expand_extra_isize
From: syzbot <syzbot+f584efa0ac7213c226b7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
0adb32858b0bddf4ada5f364a84ed60b196dbcda (Sun Apr 1 21:20:27 2018 +0000)
Linux 4.16
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=f584efa0ac7213c226b7

C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6513385206185984
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5304036769136640
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5041749693038592
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2374466361298166459
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f584efa0ac7213c226b7@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: ftp: loaded support on port[0] = 21
EXT4-fs (sda1): re-mounted. Opts: debug_want_extra_isize=7632
==================================================================
BUG: KASAN: use-after-free in memset include/linux/string.h:330 [inline]
BUG: KASAN: use-after-free in __ext4_expand_extra_isize+0x157/0x230  
fs/ext4/inode.c:5779
Write of size 7600 at addr ffff8801c7ee86a0 by task syzkaller547255/4428

CPU: 0 PID: 4428 Comm: syzkaller547255 Not tainted 4.16.0+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
  memset+0x23/0x40 mm/kasan/kasan.c:285
  memset include/linux/string.h:330 [inline]
  __ext4_expand_extra_isize+0x157/0x230 fs/ext4/inode.c:5779
  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5831 [inline]
  ext4_mark_inode_dirty+0x7a9/0xa10 fs/ext4/inode.c:5907
  ext4_unlink+0xc6f/0x1100 fs/ext4/namei.c:3038
  vfs_unlink+0x283/0x480 fs/namei.c:3978
  do_unlinkat+0x731/0x940 fs/namei.c:4041
  SYSC_unlink fs/namei.c:4088 [inline]
  SyS_unlink+0x26/0x30 fs/namei.c:4086
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x447b77
RSP: 002b:00007ffc704d9d88 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000447b77
RDX: 00007ffc704d9d90 RSI: 00007ffc704d9d90 RDI: 00007ffc704d9e20
RBP: 00007ffc704db5a0 R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000006 R11: 0000000000000206 R12: 0000000001c648a0
R13: 0000000000000000 R14: 0000000000007384 R15: 00007ffc704daf98

The buggy address belongs to the page:
page:ffffea00071fba00 count:2 mapcount:0 mapping:ffff8801d52ef660  
index:0x4a7
flags: 0x2fffc0000001064(referenced|lru|active|private)
raw: 02fffc0000001064 ffff8801d52ef660 00000000000004a7 00000002ffffffff
raw: ffffea0006e70c20 ffffea0006d9a5a0 ffff8801a99933f0 ffff8801d9a96b40
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801d9a96b40

Memory state around the buggy address:
  ffff8801c7ee9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801c7ee9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801c7eea000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                    ^
  ffff8801c7eea080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801c7eea100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
