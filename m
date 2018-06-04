Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeFDUVE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:21:04 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:53026 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbeFDUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:21:02 -0400
X-Google-Smtp-Source: ADUXVKKVSYtTMFwKPAWofVd65PihksQks388VSPisb/+g0An2j+Q7JjLWjJgUWMaLx8yQLqzuBiECK7PurGAFWa2Sjc3l5FOZVVz
MIME-Version: 1.0
Date: Mon, 04 Jun 2018 13:21:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000271c83056dd6acc6@google.com>
Subject: bpf-next boot error: KASAN: use-after-free Write in call_usermodehelper_exec_work
From: syzbot <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69b450789136 Merge branch 'misc-BPF-improvements'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1080d1d7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
dashboard link: https://syzkaller.appspot.com/bug?extid=2c73319c406f1987d156
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com

kworker/u4:1 (36) used greatest stack depth: 23056 bytes left
cpuidle: using governor menu
ACPI: bus type PCI registered
PCI: Using configuration type 1 for base access
==================================================================
BUG: KASAN: use-after-free in call_usermodehelper_exec_work+0x2d3/0x310  
kernel/umh.c:195
Write of size 4 at addr ffff8801d9202370 by task kworker/u4:2/50

CPU: 0 PID: 50 Comm: kworker/u4:2 Not tainted 4.17.0-rc6+ #32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound call_usermodehelper_exec_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
  call_usermodehelper_exec_work+0x2d3/0x310 kernel/umh.c:195
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 1:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  call_usermodehelper_setup+0xe8/0x400 kernel/umh.c:382
  kobject_uevent_env+0xb21/0x1110 lib/kobject_uevent.c:608
  kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:636
  kernel_add_sysfs_param kernel/params.c:798 [inline]
  param_sysfs_builtin kernel/params.c:833 [inline]
  param_sysfs_init+0x3f9/0x486 kernel/params.c:954
  do_one_initcall+0x127/0x913 init/main.c:884
  do_initcall_level init/main.c:952 [inline]
  do_initcalls init/main.c:960 [inline]
  do_basic_setup init/main.c:978 [inline]
  kernel_init_freeable+0x49b/0x58e init/main.c:1135
  kernel_init+0x11/0x1b3 init/main.c:1061
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Freed by task 208:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  call_usermodehelper_freeinfo kernel/umh.c:45 [inline]
  umh_complete+0x7b/0x90 kernel/umh.c:59
  call_usermodehelper_exec_async+0x6e8/0x9e0 kernel/umh.c:116
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The buggy address belongs to the object at ffff8801d9202300
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 112 bytes inside of
  192-byte region [ffff8801d9202300, ffff8801d92023c0)
The buggy address belongs to the page:
page:ffffea0007648080 count:1 mapcount:0 mapping:ffff8801d9202000 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d9202000 0000000000000000 0000000100000010
raw: ffffea0007647f60 ffff8801da801148 ffff8801da800040 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d9202200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d9202280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d9202300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff8801d9202380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8801d9202400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
