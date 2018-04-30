Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeD3NCF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:02:05 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:36628 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeD3NCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:02:03 -0400
X-Google-Smtp-Source: AB8JxZrUcTJYrx7KqfX+e0BpXf5u+fpt3uCGao1VXtG37ElsWO3HIGsvOZo7XKLcFUGAyUpPBmNPGSlfoc00qlieKhdhOQrIlFfD
MIME-Version: 1.0
Date: Mon, 30 Apr 2018 06:02:03 -0700
In-Reply-To: <000000000000ec007c05691ce52c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c589a8056b1075ef@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in getname_kernel
From: syzbot <syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
6da6c0db5316275015e8cc2959f12a17584aeb64 (Sun Apr 29 21:17:42 2018 +0000)
Linux v4.17-rc3
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=60c837b428dc84e83a93

So far this crash happened 3 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4822021112332288
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6750125347045376
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5785333421572096
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6493557782959164711
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: slab-out-of-bounds in strlen+0x83/0xa0 lib/string.c:482
Read of size 1 at addr ffff8801d91937d8 by task syz-executor934/4547

CPU: 0 PID: 4547 Comm: syz-executor934 Not tainted 4.17.0-rc3+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  strlen+0x83/0xa0 lib/string.c:482
  strlen include/linux/string.h:267 [inline]
  getname_kernel+0x24/0x370 fs/namei.c:218
  kern_path_mountpoint+0x23/0x40 fs/namei.c:2706
  find_autofs_mount.isra.5+0x8c/0x2b0 fs/autofs4/dev-ioctl.c:212
  autofs_dev_ioctl_open_mountpoint fs/autofs4/dev-ioctl.c:257 [inline]
  autofs_dev_ioctl_openmount+0x183/0x340 fs/autofs4/dev-ioctl.c:297
  _autofs_dev_ioctl+0x67a/0x890 fs/autofs4/dev-ioctl.c:697
  autofs_dev_ioctl+0x1b/0x30 fs/autofs4/dev-ioctl.c:713
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fe09
RSP: 002b:00007ffc2e327e78 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fe09
RDX: 0000000020000040 RSI: 8000000000009374 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401730
R13: 00000000004017c0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4547:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc_track_caller+0x14a/0x760 mm/slab.c:3733
  memdup_user+0x2c/0xa0 mm/util.c:160
  copy_dev_ioctl fs/autofs4/dev-ioctl.c:109 [inline]
  _autofs_dev_ioctl+0x1a8/0x890 fs/autofs4/dev-ioctl.c:643
  autofs_dev_ioctl+0x1b/0x30 fs/autofs4/dev-ioctl.c:713
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2860:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  single_release+0x8f/0xb0 fs/seq_file.c:609
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d91937c0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
  32-byte region [ffff8801d91937c0, ffff8801d91937e0)
The buggy address belongs to the page:
page:ffffea00076464c0 count:1 mapcount:0 mapping:ffff8801d9193000  
index:0xffff8801d9193fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d9193000 ffff8801d9193fc1 0000000100000016
raw: ffffea0007646060 ffffea00076449a0 ffff8801da8001c0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d9193680: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d9193700: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801d9193780: fb fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
                                                     ^
  ffff8801d9193800: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d9193880: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================
