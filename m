Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE81C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7823F2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOPMsPIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7823F2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbeKMSVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:21:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40598 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbeKMSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:21:16 -0500
Received: by mail-it1-f193.google.com with SMTP id e11so17179121itl.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bZx1ZwO8l4Dmj3OmCZc8iGLGXg/ClXP/36Lh4NXZmdg=;
        b=mOPMsPIOBQETVER+LJXYcmpIJd00Tqk4UHM1ghcJv0RaDe9JbhmlJKNoTmJez9alxj
         1z5Rpns3sPdNp+p7sTd9WsbNUabOCklleLafvnLY9k4t5NKih5Rpid7kO1s4IBaH/DAH
         0g+xXsudtSsIfGteDmNcusvAZx8oNsYebX8cwinFjCd/g3tZTkPJ0PMVhOB82ZssgooB
         9q+n7l1tcqPyblPiEdjqM8oRM2XuPZvte99cjdLcTxyM2qzNUzeyMT3IwhB34Xrtf3YC
         JkoNQPMwThhzhJI0DDjDSpzZbAmpc5Kq6mbGEooIPjFBSqc9iIMtBrxAa/mf6Ih1oaGf
         RsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bZx1ZwO8l4Dmj3OmCZc8iGLGXg/ClXP/36Lh4NXZmdg=;
        b=paqJdDhB6csoU231+AcNM7dn/ETzGGOlbfMtM8Uz2zcpb2WmBkYvNrAsDmlQ8hao7x
         nqgu/e5YG43kC0KNDzdUCzQrKAlgKMrdhAdxCg/KggZ2i9s+6+riehLocXtDXLtobM5g
         27r48xyHEzpK1O8aNHz63qb7D7eU7L3MtZa6/Df5xm5NaHU4v6nF2thHLv0jnM5hEncg
         4kgrZ+Omih2XIFlFky89eRMsn862k96cMpOYskbzusOHtGN5P+Bjd7Dxv+8RorxAZPwP
         Yapzu2Gs3WqAolTmz8jXF6f+jgBRPkUlaO+CYSO1I9jjj+SICElqzEi7nuuoCKjjVV+U
         tR5A==
X-Gm-Message-State: AGRZ1gKvnwKPL05wzhyIeAADqDlm1LD9GPf6zHaOoYb7UVpLeVPs4Bpu
        VhRUoDkbVi9ZuwZCYM9+OlGLjeVsFXNgTv+riAE=
X-Google-Smtp-Source: AJdET5cBwCKwu5+Cu5e8E2b2+9nAjrU8Xz0+giFcGeNfwXXRnVmCuVhYnkjBwMGgu1cCCjogu9EHC0N20M7DTpteJTE=
X-Received: by 2002:a02:9b74:: with SMTP id g49mr3797278jal.76.1542097456412;
 Tue, 13 Nov 2018 00:24:16 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 13 Nov 2018 03:24:04 -0500
Message-ID: <CAEAjamud-6uX8EmOZy7s6ubWNg=0E1YQZSGK2-SnfsomK8VnGw@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in write_port
To:     Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug in v4.19-rc8 (4.20-rc1 as well):

kernel config: https://kt0755.github.io/etc/config-4.19-rc2.kmsan
repro: https://kt0755.github.io/etc/repro.e3752.c

This happens during data transition from user-supplied buffer to port
(using outb) pointed by ppos. (driver/mem/char.c:640)
Although there is a strict bound 65536 (driver/mem/char.c:632), user
buffer copy still causes crashes within the strict bound.
(In the experiment, the crash arose when loop count is beyond 0x7f )
To stop it, it probably needs a little tight bound check.

I think this is a little bit related to the crash I reported before
(https://lkml.org/lkml/2018/5/12/91)

Crash log
=========================================
BUG: unable to handle kernel NULL pointer dereference at 00000000000000af
PGD 8000000092c1a067 P4D 8000000092c1a067 PUD 93a74067 PMD 0
Oops: 0002 [#1] SMP PTI
CPU: 0 PID: 6651 Comm: syz-executor0 Not tainted 4.19.0-rc8+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
RIP: 0010:outb arch/x86/include/asm/io.h:333 [inline]
RIP: 0010:write_port+0x25b/0x420 drivers/char/mem.c:640
Code: 4c 8b 75 c8 4c 89 e7 e8 93 9f 5c fe 85 db 75 7d 48 8b 18 44 8b
22 e8 a4 de f8 fd 84 db 75 5a 48 8b 5d b0 85 db 75 5c 44 89 f0 <44> 89
66 90 49 83 c7 01 4d 89 ee 49 83 c6 01 31 c0 31 ff 45 31 e4
RSP: 0018:ffff88009312fbf0 EFLAGS: 00010246
RAX: 00000000200001e4 RBX: 0000000000000000 RCX: 0000000000010000
RDX: ffffc90003f89000 RSI: 000000000000011f RDI: 0000000000000120
RBP: ffff88009312fc98 R08: ffffffff7fffffff R09: ffff88009277fc60
R10: 0000000000000000 R11: ffffffff83772a30 R12: 0000000000000000
R13: 000000002000017f R14: 00000000200001e4 R15: 000000000000007f
FS:  00007f5c84a4d700(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000714fe4 CR3: 000000009498a000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __vfs_write+0x1f4/0xa50 fs/read_write.c:485
 vfs_write+0x495/0x8e0 fs/read_write.c:549
 ksys_write fs/read_write.c:598 [inline]
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write+0x17a/0x370 fs/read_write.c:607
 __x64_sys_write+0x4a/0x70 fs/read_write.c:607
 do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5c84a4cc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5c84a4d6cc RCX: 00000000004497b9
RDX: 00000000000000cc RSI: 0000000020000100 RDI: 0000000000000014
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000b250 R14: 00000000006f32f0 R15: 00007f5c84a4d700
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 00000000000000af
---[ end trace 5b28bfcf889ce399 ]---
=========================================

Crash log (reported before)
=========================================
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
=========================================

Thanks,
Kyungtae Kim
