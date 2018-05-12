Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeELDwE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 23:52:04 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:41552 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 23:52:03 -0400
X-Google-Smtp-Source: AB8JxZrZC6zbSVFSLo7rdlXaovt6/+bLHa1cDmkh14pI6cP9p57/ZwZivsMsuBdFatqHGQc9oB5ddhL/T8z2xSweKDQ=
MIME-Version: 1.0
In-Reply-To: <CAEAjamsd9_XmWbknpVeR7for8PYNrDHQKo=rZgR32PHFqQaKjw@mail.gmail.com>
References: <CAEAjamsd9_XmWbknpVeR7for8PYNrDHQKo=rZgR32PHFqQaKjw@mail.gmail.com>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Fri, 11 May 2018 23:52:02 -0400
Message-ID: <CAEAjamucQXi3Hr+hxuu3V8Ds7bABM=XUFiFpq7_b7-umyE6vXA@mail.gmail.com>
Subject: Fwd: KASAN: use-after-free Write in write_mem
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Kyungtae Kim <kt0755@gmail.com>
Date: Fri, May 11, 2018 at 11:38 AM
Subject: KASAN: use-after-free Write in write_mem
To: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeLyong Jeong
<threeearcat@gmail.com>


We report the crash:
"KASAN: use-after-free Write in write_mem"

This crash was found in v4.17-rc3. Specifically, memory access (write
operation) is invalid, and it is detected by KASAN.

C repro code:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-3c6e1.c
kernel config:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/kernel-config-v4.17-rc3

Crash log:
============================================================
Write of size 4096 at addr ffff880000010000 by task syz-executor1/3358

CPU: 0 PID: 3358 Comm: syz-executor1 Not tainted 4.17.0-rc3 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xc7/0x138 lib/dump_stack.c:113
 print_address_description+0x6a/0x280 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x22f/0x350 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x13b/0x1a0 mm/kasan/kasan.c:267
 kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
 _copy_from_user+0xb7/0x100 lib/usercopy.c:12
 copy_from_user include/linux/uaccess.h:147 [inline]
 write_mem+0x8f/0x190 drivers/char/mem.c:240
 __vfs_write+0x10d/0x610 fs/read_write.c:485
 vfs_write+0x187/0x500 fs/read_write.c:549
 ksys_write+0xd4/0x1a0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:607
 do_syscall_64+0xa4/0x460 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007f6f7f254c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6f7f2556cc RCX: 00000000004497b9
RDX: 00000000ffffffad RSI: 0000000020000000 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000009ee8 R14: 00000000006f0f88 R15: 00007f6f7f255700

The buggy address belongs to the page:
page:ffffea0000000400 count:0 mapcount:-127 mapping:0000000000000000 index:0x0
flags: 0x0()
raw: 0000000000000000 0000000000000000 0000000000000000 00000000ffffff80
raw: ffff88013fff91e0 ffffea0000002020 0000000000000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88000000ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88000000ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff880000010000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff880000010080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff880000010100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
============================================================

Thanks,
Kyungtae Kim
