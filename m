Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeC2XBS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 19:01:18 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:44979 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC2XBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 19:01:02 -0400
X-Google-Smtp-Source: AG47ELvUZaIvpQcI3UXFRrp7P+MerP9Zxm2U5ozwJT1pt05pEzSJlhv237YnyX0Whx+LBzHgKG2yWqixO0YiRgW8knKf3QTiEXMQ
MIME-Version: 1.0
Date: Thu, 29 Mar 2018 16:01:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a11427716f74ef40568951849@google.com>
Subject: KASAN: use-after-free Read in snd_pcm_timer_resolution
From: syzbot <syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
0b412605ef5f5c64b31f19e2910b1d5eba9929c3 (Thu Mar 29 01:07:23 2018 +0000)
Merge tag 'drm-fixes-for-v4.16-rc8' of  
git://people.freedesktop.org/~airlied/linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=8e62ff4e07aa2ce87826

So far this crash happened 3 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6219387178582016
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5176598244360192
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5815694612496384
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

==================================================================
BUG: KASAN: use-after-free in snd_pcm_timer_resolution+0xa3/0xc0  
sound/core/pcm_timer.c:72
Read of size 4 at addr ffff8801bdd58490 by task syzkaller702213/13238

CPU: 0 PID: 13238 Comm: syzkaller702213 Not tainted 4.16.0-rc7+ #370
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  print_address_description+0x73/0x250 mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  snd_pcm_timer_resolution+0xa3/0xc0 sound/core/pcm_timer.c:72
  snd_timer_resolution sound/core/timer.c:439 [inline]
  snd_timer_notify1+0x10f/0x400 sound/core/timer.c:462
  snd_timer_start1+0x586/0x8f0 sound/core/timer.c:522
  snd_timer_start+0x5d/0xa0 sound/core/timer.c:634
  snd_timer_user_start.isra.12+0xde/0x130 sound/core/timer.c:1878
  snd_timer_user_continue sound/core/timer.c:1902 [inline]
  __snd_timer_user_ioctl+0x1771/0x2c10 sound/core/timer.c:1977
  snd_timer_user_ioctl+0x5f/0x7d sound/core/timer.c:1992
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4453c9
RSP: 002b:00007ffd46abffe8 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004453c9
RDX: 00000000004453c9 RSI: 00000000000054a2 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000046ac0168 R09: 0000000046ac0168
R10: 0000000046ac0168 R11: 0000000000000217 R12: 00000000000142ea
R13: 0000000000402c90 R14: 00000000006d1440 R15: 0000000000000000

Allocated by task 13234:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
  kmem_cache_alloc_trace+0x136/0x740 mm/slab.c:3608
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  snd_pcm_attach_substream+0x3c5/0xb60 sound/core/pcm.c:1006
  snd_pcm_open_substream+0x95/0x3b0 sound/core/pcm_native.c:2372
  snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2309 [inline]
  snd_pcm_oss_open+0x7cf/0x1540 sound/core/oss/pcm_oss.c:2391
  soundcore_open+0x321/0x630 sound/sound_core.c:597
  chrdev_open+0x257/0x730 fs/char_dev.c:417
  do_dentry_open+0x667/0xd40 fs/open.c:752
  vfs_open+0x107/0x220 fs/open.c:866
  do_last fs/namei.c:3379 [inline]
  path_openat+0x1151/0x3530 fs/namei.c:3519
  do_filp_open+0x25b/0x3b0 fs/namei.c:3554
  do_sys_open+0x502/0x6d0 fs/open.c:1059
  SYSC_openat fs/open.c:1086 [inline]
  SyS_openat+0x30/0x40 fs/open.c:1080
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Freed by task 13234:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kfree+0xd9/0x260 mm/slab.c:3801
  snd_pcm_detach_substream+0x134/0x290 sound/core/pcm.c:1057
  snd_pcm_release_substream.part.44+0x23d/0x300 sound/core/pcm_native.c:2361
  snd_pcm_release_substream+0x59/0x70 sound/core/pcm_native.c:2362
  snd_pcm_oss_release_file.part.18+0x71/0xa0 sound/core/oss/pcm_oss.c:2268
  snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2263 [inline]
  snd_pcm_oss_release+0x104/0x280 sound/core/oss/pcm_oss.c:2448
  __fput+0x327/0x7e0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x199/0x270 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
  do_group_exit+0x149/0x400 kernel/exit.c:968
  SYSC_exit_group kernel/exit.c:979 [inline]
  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the object at ffff8801bdd58180
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 784 bytes inside of
  2048-byte region [ffff8801bdd58180, ffff8801bdd58980)
The buggy address belongs to the page:
page:ffffea0006f75600 count:1 mapcount:0 mapping:ffff8801bdd58180 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801bdd58180 0000000000000000 0000000100000003
raw: ffffea0007330d20 ffffea0007268aa0 ffff8801dac00c40 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801bdd58380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801bdd58400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801bdd58480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8801bdd58500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801bdd58580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
