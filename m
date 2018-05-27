Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbeE0Fk5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 01:40:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42758 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeE0Fk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 01:40:56 -0400
X-Google-Smtp-Source: AB8JxZpX5HoBt/FiaDOerJfMCQ1UovkqpYIBvkUAQF8l/W7COzUSgtI+FjrJvraqzR18DaO6SDDR3my01Ct8MkG3fAc=
MIME-Version: 1.0
In-Reply-To: <000000000000424989056d295959@google.com>
References: <000000000000424989056d295959@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 27 May 2018 07:40:34 +0200
Message-ID: <CACT4Y+Z-+Rw9GfX4Q0HJxJtpMcRGO5EFj15cqOhJiEGkntcOMg@mail.gmail.com>
Subject: Re: net-next boot error: KASAN: use-after-free Write in call_usermodehelper_exec_work
To: syzbot <syzbot+9269ae80345087b898d0@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, mcgrof@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 7:34 AM, syzbot
<syzbot+9269ae80345087b898d0@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    5b79c2af667c Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16087fa7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
> dashboard link: https://syzkaller.appspot.com/bug?extid=9269ae80345087b898d0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9269ae80345087b898d0@syzkaller.appspotmail.com


This first happened just now on net-next, so +net maintainers.
This happened during boot, so no separate reproducer.


> FS-Cache: Loaded
> CacheFiles: Loaded
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 7 devices
> ==================================================================
> BUG: KASAN: use-after-free in call_usermodehelper_exec_work+0x2d3/0x310
> kernel/umh.c:195
> Write of size 4 at addr ffff8801d63bd370 by task kworker/u4:0/6
>
> CPU: 0 PID: 6 Comm: kworker/u4:0 Not tainted 4.17.0-rc6+ #65
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events_unbound call_usermodehelper_exec_work
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
>  call_usermodehelper_exec_work+0x2d3/0x310 kernel/umh.c:195
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> Allocated by task 1:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  call_usermodehelper_setup+0xe8/0x400 kernel/umh.c:382
> clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns:
> 2085701024 ns
>  kobject_uevent_env+0xb21/0x1110 lib/kobject_uevent.c:608
>  kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:636
>  device_add+0xb01/0x16d0 drivers/base/core.c:1843
>  device_create_groups_vargs+0x1ff/0x270 drivers/base/core.c:2439
>  device_create_vargs drivers/base/core.c:2479 [inline]
>  device_create+0xd3/0x100 drivers/base/core.c:2515
>  chr_dev_init+0x120/0x158 drivers/char/mem.c:938
>  do_one_initcall+0x127/0x913 init/main.c:884
>  do_initcall_level init/main.c:952 [inline]
>  do_initcalls init/main.c:960 [inline]
>  do_basic_setup init/main.c:978 [inline]
>  kernel_init_freeable+0x49b/0x58e init/main.c:1135
>  kernel_init+0x11/0x1b3 init/main.c:1061
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> Freed by task 1296:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> NET: Registered protocol family 2
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  call_usermodehelper_freeinfo kernel/umh.c:45 [inline]
>  umh_complete+0x7b/0x90 kernel/umh.c:59
>  call_usermodehelper_exec_async+0x6e8/0x9e0 kernel/umh.c:116
> tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes)
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> The buggy address belongs to the object at ffff8801d63bd300
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 112 bytes inside of
>  192-byte region [ffff8801d63bd300, ffff8801d63bd3c0)
> The buggy address belongs to the page:
> TCP established hash table entries: 65536 (order: 7, 524288 bytes)
> page:ffffea000758ef40 count:1 mapcount:0 mapping:ffff8801d63bd000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801d63bd000 0000000000000000 0000000100000010
> TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
> raw: ffffea000759c2e0 ffffea0007521be0 ffff8801da800040 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d63bd200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d63bd280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>
>> ffff8801d63bd300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
> TCP: Hash tables configured (established 65536 bind 65536)
>                                                              ^
>  ffff8801d63bd380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801d63bd400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> UDP hash table entries: 4096 (order: 7, 655360 bytes)
> UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes)
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000424989056d295959%40google.com.
> For more options, visit https://groups.google.com/d/optout.
