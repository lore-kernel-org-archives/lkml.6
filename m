Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeELNlp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 09:41:45 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35803 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 09:41:44 -0400
X-Google-Smtp-Source: AB8JxZoqUpqDFkBe1Xrj8hye/jrjmIIhzGoPdkVAT428RrT/C7yIDCbVN1H/NhZkInim8Rj09rxbSg/qAy+/AobtVQo=
MIME-Version: 1.0
In-Reply-To: <CAEAjamvki9pQ_T9uymdU4dBhU=eqbOQwdXkXJQ9fHWfTV0fcRQ@mail.gmail.com>
References: <CAEAjamvki9pQ_T9uymdU4dBhU=eqbOQwdXkXJQ9fHWfTV0fcRQ@mail.gmail.com>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Sat, 12 May 2018 09:41:42 -0400
Message-ID: <CAEAjamt_NAzx5tj6ZjTym1eq5ynjNoyh-1V2NXiXed+K_3ptbg@mail.gmail.com>
Subject: Fwd: BUG: unable to handle kernel paging request in write_port
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Kyungtae Kim <kt0755@gmail.com>
Date: Sat, May 12, 2018 at 9:40 AM
Subject: BUG: unable to handle kernel paging request in write_port
To: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
linux-kernel@vger.kernel.org
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong
<threeearcat@gmail.com>


We report the crash:
"BUG: unable to handle kernel paging request in write_port"

This crash was found in v4.17-rc3.

C repro code:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-0cc6c.c
kernel config:
 https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/kernel-config-v4.17-rc3

Crash log:

BUG: unable to handle kernel paging request at ffffc90001eb5f90
PGD 1150c2067 P4D 1150c2067 PUD 1150c3067 PMD 10cd1e067 PTE 0
Oops: 0002 [#1] SMP KASAN PTI
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 2925 Comm: syz-executor7 Not tainted 4.17.0-rc3 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
RIP: 0010:outb arch/x86/include/asm/io.h:333 [inline]
RIP: 0010:write_port+0xda/0x190 drivers/char/mem.c:640
RSP: 0018:ffff88011095fc40 EFLAGS: 00010286
RAX: 000000001095feaf RBX: 000000002000163f RCX: ffffffff8286ca77
RDX: 0000000000010000 RSI: ffffc90001eb6000 RDI: ffff880114403f58
RBP: ffff88011095fc78 R08: ffffffffa9c6c9a0 R09: 0000000000000000
R10: ffff880115622813 R11: ffffed0022ac4503 R12: 000000000000007f
R13: 000000000000000c R14: 0000000000000000 R15: ffff88011095feaf
FS:  00007f40dbe46700(0000) GS:ffff880115600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001eb5f90 CR3: 00000001117ca000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __vfs_write+0x10d/0x610 fs/read_write.c:485
 vfs_write+0x187/0x500 fs/read_write.c:549
 ksys_write+0xd4/0x1a0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:607
 do_syscall_64+0xa4/0x460 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007f40dbe45c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f40dbe466cc RCX: 00000000004497b9
RDX: 000000000000008c RSI: 00000000200015c0 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000009ee8 R14: 00000000006f0f88 R15: 00007f40dbe46700
Code: 49 81 fc ff ff 00 00 4c 8d 6b ff 0f 87 af 00 00 00 48 85 db 0f
84 a6 00 00 00 48 8b 5d d0 45 31 f6 eb 2c e8 59 00 b1 fe 44 89 f8 <44>
89 66 90 49 83 c4 01 48 83 c3 01 4d 85 ed 0f 95 c2 49 81 fc
RIP: outb arch/x86/include/asm/io.h:333 [inline] RSP: ffff88011095fc40
RIP: write_port+0xda/0x190 drivers/char/mem.c:640 RSP: ffff88011095fc40
CR2: ffffc90001eb5f90
---[ end trace 6917feb3b143574b ]---
Kernel panic - not syncing: Fatal exception
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: 0x27400000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000-0xffffffffbfffffff)

Thanks,
Kyungtae Kim
