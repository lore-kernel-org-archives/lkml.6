Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeEXEfL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 00:35:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51906 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeEXEfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 00:35:08 -0400
X-Google-Smtp-Source: AB8JxZpL7YebvRLszmkkV8jly9ZvnB6bT45VenVGnOlg/NKHxTqFLbi4/DG94YlOQpuZ/R/NCwKNHzjo0yHU4YLU46s=
MIME-Version: 1.0
In-Reply-To: <CAEAjamsig0egTubLKMo8ds1STm8ORsXqrjyz1LHycZrdh_qH-Q@mail.gmail.com>
References: <CAEAjamsig0egTubLKMo8ds1STm8ORsXqrjyz1LHycZrdh_qH-Q@mail.gmail.com>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Thu, 24 May 2018 00:35:07 -0400
Message-ID: <CAEAjamtH0-=BG+v4b6tFLBoMzEZCkfArnbsQwpFRbcE-jdQYCw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in vgacon_invert_region
To: b.zolnierkie@samsung.com
Cc: Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(We analyzed the crash and added the result below.)

We report the crash:
"KASAN: use-after-free Read in vgacon_invert_region"

This crash was found in v4.17-rc3. Specifically, memory access (read
operation) is invalid and which is detected by KASAN.

Analysis:
The function "vt_do_resize" basically allows for resizing the screen
buffer (i.e., vc_data) beyond memory address 0x100000
(i.e., 0xffff880000100000 in this case).
We think, however, a certain memory area starting from 0x100000 is protected.
So subsequent memory access beyond this address (by
"vgacon_invert_region") causes memory access violation.

C repro code:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-ba6c1.c
kernel config:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/kernel-config-v4.17-rc3

Crash log:
==============================================================
BUG: KASAN: use-after-free in vgacon_invert_region+0xf9/0x100
drivers/video/console/vgacon.c:663
Read of size 2 at addr ffff880000100000 by task syz-executor3/525

CPU: 0 PID: 525 Comm: syz-executor3 Not tainted 4.17.0-rc3 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xc7/0x138 lib/dump_stack.c:113
 print_address_description+0x78/0x290 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x234/0x350 mm/kasan/report.c:412
 __asan_report_load2_noabort+0x19/0x20 mm/kasan/report.c:431
 vgacon_invert_region+0xf9/0x100 drivers/video/console/vgacon.c:663
 invert_screen+0x197/0x630 drivers/tty/vt/vt.c:461
 highlight drivers/tty/vt/selection.c:51 [inline]
 set_selection+0x6b7/0xf60 drivers/tty/vt/selection.c:276
 tioclinux+0x126/0x410 drivers/tty/vt/vt.c:2691
 vt_ioctl+0x1036/0x2580 drivers/tty/vt/vt_ioctl.c:362
 tty_ioctl+0x288/0x14c0 drivers/tty/tty_io.c:2646
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x191/0xfe0 fs/ioctl.c:686
 ksys_ioctl+0x99/0xb0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x78/0xb0 fs/ioctl.c:706
 do_syscall_64+0xb0/0x460 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007f720c4bec68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f720c4bf6cc RCX: 00000000004497b9
RDX: 0000000020000040 RSI: 000200000000541c RDI: 0000000000000013
RBP: 000000000071bf58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000005aa8 R14: 00000000006ecb48 R15: 00007f720c4bf700

The buggy address belongs to the page:
page:ffffea0000004000 count:0 mapcount:-127 mapping:0000000000000000 index:0x0
flags: 0x0()
raw: 0000000000000000 0000000000000000 0000000000000000 00000000ffffff80
raw: ffff88013fff9300 ffff88013fff9300 0000000000000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8800000fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8800000fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff880000100000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff880000100080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff880000100100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==============================================================


Thanks,
Kyungtae Kim

On Thu, May 17, 2018 at 2:04 PM, Kyungtae Kim <kt0755@gmail.com> wrote:
> We report the crash:
> "KASAN: use-after-free Read in vgacon_invert_region"
>
> This crash was found in v4.17-rc3. Specifically, memory access (read
> operation) is invalid, and it is detected by KASAN.
>
> C repro code:
>  https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-ba6c1.c
> kernel config:
>  https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/kernel-config-v4.17-rc3
>
> Crash log:
> ==============================================================
> BUG: KASAN: use-after-free in vgacon_invert_region+0xf9/0x100
> drivers/video/console/vgacon.c:663
> Read of size 2 at addr ffff880000100000 by task syz-executor3/525
>
> CPU: 0 PID: 525 Comm: syz-executor3 Not tainted 4.17.0-rc3 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xc7/0x138 lib/dump_stack.c:113
>  print_address_description+0x78/0x290 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x234/0x350 mm/kasan/report.c:412
>  __asan_report_load2_noabort+0x19/0x20 mm/kasan/report.c:431
>  vgacon_invert_region+0xf9/0x100 drivers/video/console/vgacon.c:663
>  invert_screen+0x197/0x630 drivers/tty/vt/vt.c:461
>  highlight drivers/tty/vt/selection.c:51 [inline]
>  set_selection+0x6b7/0xf60 drivers/tty/vt/selection.c:276
>  tioclinux+0x126/0x410 drivers/tty/vt/vt.c:2691
>  vt_ioctl+0x1036/0x2580 drivers/tty/vt/vt_ioctl.c:362
>  tty_ioctl+0x288/0x14c0 drivers/tty/tty_io.c:2646
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x191/0xfe0 fs/ioctl.c:686
>  ksys_ioctl+0x99/0xb0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x78/0xb0 fs/ioctl.c:706
>  do_syscall_64+0xb0/0x460 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4497b9
> RSP: 002b:00007f720c4bec68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f720c4bf6cc RCX: 00000000004497b9
> RDX: 0000000020000040 RSI: 000200000000541c RDI: 0000000000000013
> RBP: 000000000071bf58 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000005aa8 R14: 00000000006ecb48 R15: 00007f720c4bf700
>
> The buggy address belongs to the page:
> page:ffffea0000004000 count:0 mapcount:-127 mapping:0000000000000000 index:0x0
> flags: 0x0()
> raw: 0000000000000000 0000000000000000 0000000000000000 00000000ffffff80
> raw: ffff88013fff9300 ffff88013fff9300 0000000000000008 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8800000fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8800000fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>ffff880000100000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff880000100080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff880000100100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==============================================================
>
>
> Thanks,
> Kyungtae Kim
