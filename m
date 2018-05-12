Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeELNpc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 09:45:32 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:39096 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbeELNpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 09:45:30 -0400
X-Google-Smtp-Source: AB8JxZr6UUFf+BwFeUyphi1J7rkOOl3zI6oFjnasacdCXURf+kFRhgMaZXfYfjd6gnHOOMBUcK/DwRvTutcM4HLR0yY=
MIME-Version: 1.0
In-Reply-To: <CAEAjams1MkmoVwHNZ9gOKCq8m=umN5BZ+mSnnw3_kXeXn5ZgmA@mail.gmail.com>
References: <CAEAjams1MkmoVwHNZ9gOKCq8m=umN5BZ+mSnnw3_kXeXn5ZgmA@mail.gmail.com>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Sat, 12 May 2018 09:45:28 -0400
Message-ID: <CAEAjamsJnG-=TSOwgRbbb3B9Z-PA63oWmNPoKYWQ=Z=+X49akg@mail.gmail.com>
Subject: Fwd: KASAN: use-after-free Write in vgacon_scroll
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Kyungtae Kim <kt0755@gmail.com>
Date: Sat, May 12, 2018 at 9:44 AM
Subject: KASAN: use-after-free Write in vgacon_scroll
To: b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong
<threeearcat@gmail.com>


We report the crash:
"KASAN: use-after-free Write in vgacon_scroll"

This crash was found in v4.17-rc3. Specifically, memory access (write
operation) is invalid, and it is detected by KASAN.

C repro code:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-bd11a.c
kernel config:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/kernel-config-v4.17-rc3

Crash log:
==============================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:345 [inline]
BUG: KASAN: use-after-free in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: use-after-free in vgacon_scrollback_update
drivers/video/console/vgacon.c:249 [inline]
BUG: KASAN: use-after-free in vgacon_scroll+0x684/0x890
drivers/video/console/vgacon.c:1374
Write of size 3758 at addr ffff88011a8bf98e by task syz-executor1/3226

CPU: 0 PID: 3226 Comm: syz-executor1 Not tainted 4.17.0-rc3 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xc7/0x138 lib/dump_stack.c:113
 print_address_description+0x6a/0x280 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x22f/0x350 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x13b/0x1a0 mm/kasan/kasan.c:267
 memcpy+0x37/0x50 mm/kasan/kasan.c:303
 memcpy include/linux/string.h:345 [inline]
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 vgacon_scrollback_update drivers/video/console/vgacon.c:249 [inline]
 vgacon_scroll+0x684/0x890 drivers/video/console/vgacon.c:1374
 con_scroll+0x2cc/0x330 drivers/tty/vt/vt.c:329
 lf+0x247/0x290 drivers/tty/vt/vt.c:1122
 do_con_trol+0x14f/0x5310 drivers/tty/vt/vt.c:1785
 do_con_write.part.20+0x597/0x1b70 drivers/tty/vt/vt.c:2433
 do_con_write drivers/tty/vt/vt.c:2790 [inline]
 con_write+0xb2/0xc0 drivers/tty/vt/vt.c:2786
 n_tty_write+0x763/0xea0 drivers/tty/n_tty.c:2331
 do_tty_write drivers/tty/tty_io.c:958 [inline]
 tty_write+0x48c/0x870 drivers/tty/tty_io.c:1042
 redirected_tty_write+0xaf/0xc0 drivers/tty/tty_io.c:1063
 __vfs_write+0x10d/0x610 fs/read_write.c:485
 vfs_write+0x187/0x500 fs/read_write.c:549
 ksys_write+0xd4/0x1a0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:607
 do_syscall_64+0xa4/0x460 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007fc0af9acc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc0af9ad6cc RCX: 00000000004497b9
RDX: 0000000000001000 RSI: 0000000020000080 RDI: 0000000000000013
RBP: 000000000071bf58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000009ee8 R14: 00000000006f0f88 R15: 00007fc0af9ad700

The buggy address belongs to the page:
page:ffffea00046a2c00 count:1 mapcount:0 mapping:0000000000000000
index:0x0 compound_mapcount: 0
flags: 0x200000000008000(head)
raw: 0200000000008000 0000000000000000 0000000000000000 00000001ffffffff
raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88011a8bff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88011a8bff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88011a8c0000: fb fb fb fc fc fb fb fb fc fc 00 00 00 fc fc fc
                   ^
 ffff88011a8c0080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88011a8c0100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==============================================================

Thanks,
Kyungtae Kim
