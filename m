Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeEQQ2k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:28:40 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45874 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeEQQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:28:38 -0400
X-Google-Smtp-Source: AB8JxZoLlN+dnWS3LFn3Y7tzrrHVUGv53R873YUTs6c9LT5rqzZci1zgN7JD1RTbYpNvePXDWidRmD59re4v53JG6H4=
MIME-Version: 1.0
From: Kyungtae Kim <kt0755@gmail.com>
Date: Thu, 17 May 2018 12:28:37 -0400
Message-ID: <CAEAjamtSCGOao-0spN7XuD9j4aRx41Q6jZA7+uySHNKqeRy4cA@mail.gmail.com>
Subject: KASAN: use-after-free Write in do_con_write
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, linux-kernel@vger.kernel.org,
        DaeRyong Jeong <threeearcat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash:
"KASAN: use-after-free Write in do_con_write"

This crash was found in v4.17-rc3. Specifically, memory access (write
operation) is invalid, and it is detected by KASAN.

C repro code:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-c4a1f8.c
kernel config:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/kernel-config-v4.17-rc3

Crash log:

==============================================================
BUG: KASAN: use-after-free in do_con_write.part.20+0x1a14/0x1b70
drivers/tty/vt/vt.c:2397
Write of size 2 at addr ffff880000139042 by task getty/2803

CPU: 0 PID: 2803 Comm: getty Not tainted 4.17.0-rc3 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xc7/0x138 lib/dump_stack.c:113
 print_address_description+0x6a/0x280 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x22f/0x350 mm/kasan/report.c:412
 __asan_report_store2_noabort+0x17/0x20 mm/kasan/report.c:436
 do_con_write.part.20+0x1a14/0x1b70 drivers/tty/vt/vt.c:2397
 do_con_write drivers/tty/vt/vt.c:2790 [inline]
 con_write+0xb2/0xc0 drivers/tty/vt/vt.c:2786
 n_tty_write+0x763/0xea0 drivers/tty/n_tty.c:2331
 do_tty_write drivers/tty/tty_io.c:958 [inline]
 tty_write+0x48c/0x870 drivers/tty/tty_io.c:1042
 __vfs_write+0x10d/0x610 fs/read_write.c:485
 vfs_write+0x187/0x500 fs/read_write.c:549
 ksys_write+0xd4/0x1a0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:607
 do_syscall_64+0xa4/0x460 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7ffa6267ac00
RSP: 002b:00007ffee1ff7538 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000607340 RCX: 00007ffa6267ac00
RDX: 0000000000000002 RSI: 00000000004059fb RDI: 0000000000000001
RBP: 0000000000000002 R08: 000000000000000a R09: 00007ffa62944670
R10: 00007ffee1ff7620 R11: 0000000000000246 R12: 00007ffee1ff8090
R13: 00007ffa62d65690 R14: 00000000004059fb R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0000004e40 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x0()
raw: 0000000000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: ffffea0000004e60 ffffea0000004e60 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880000138f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff880000138f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff880000139000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           ^
 ffff880000139080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff880000139100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==============================================================

Thanks,
Kyungtae Kim
