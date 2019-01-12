Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE505C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7855E20836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD+RqRnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfALT0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:26:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:32847 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfALT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:26:04 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so4832364itk.0;
        Sat, 12 Jan 2019 11:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7DG8r/Vj8VaAWsvdK4erYlJIB2v8P2HJq2YxjP6oTYw=;
        b=VD+RqRnh6h4vcLeNhYrsxcl7izwW+krH2T9Z0jEeeDvyr+4G7zVS91M0qsX9aReBvH
         zDU/EnO98XaxWPSffzauGx8Re78OxGrnoPeUAcuIcgBkgwUZPjskms0VgbiRXXb9j/ov
         TP1Yjo1GVJ0wsq1ZfpgX1u6YCsYGMfRlfXTUhRblsVJVnZflozhQaXTnJtJ1W9A7KZLI
         6hz+B6ixIww3sZe192YwqyIGg3kYtWTN/KuZGnbkayZhdN8W7fCHjHt1yj0rhDUjyjPe
         7sEM0L060/9pIVp7QAxdC6IxI5KlO2LG0gvpa6zuC9xidZ/M9sQGIufbOiO3sgs3ELaY
         zcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7DG8r/Vj8VaAWsvdK4erYlJIB2v8P2HJq2YxjP6oTYw=;
        b=C1AcBCyEZTsC+JWMZyiQK5AX/AmVpRKaRFY0aTr/YBmOLzYkBTSko+Efradih0n4VZ
         +Q9iqeoreVkzE/GET9H7AZfGC3nAIFlUXKR8IX4nyFX34PT5cl0Kyv/cJ2DvYH96c+ux
         Ps+/ywWRTF/kl7BaMUGmbk+HnziCfrTaWcqcdbAfdn6Bqna2hpomEMojR1bdRh5USszg
         rw4+cw+krDwJbpGw1Vh0zz6UOBTGw6+EhPDBeINFybs+ZUi9Fn9bIOhNkijoy9GJtXjR
         759RnOjChRhJfde7+939cZ4SnLR+rewE8b2H6CY7ptGwuhEAiU2jAOvN85iicb1JpJrf
         bwRQ==
X-Gm-Message-State: AJcUukdqXvZniLLWv0OMs0EtY/it0tlnI/jjVIg76G0TYZGGouPNPWjk
        FtC9qC8TfhFQv2c1OiCGJlKpJ4vVJTqZvSQBeO6jVy+Y
X-Google-Smtp-Source: ALg8bN41kdn7EiAB+9hf11wrmBqezGxWD7bR0NJI3zQU+qkT/cPgCox0NkKIiMyu7msr93/s3DKKzrwxdyRSm3Z6Wzk=
X-Received: by 2002:a24:eb0f:: with SMTP id h15mr4624545itj.138.1547321162683;
 Sat, 12 Jan 2019 11:26:02 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sat, 12 Jan 2019 14:25:51 -0500
Message-ID: <CAEAjamvf8LzpRauFhxeh-EGY_ttqeds6_UQwikc5sm7ORKdjjw@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in net/can/bcm.c
To:     socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug in linux-4.19.13: "UBSAN: Undefined behaviour in net/can/bcm.c"

kernel config: https://kt0755.github.io/etc/config_4.19.13
repro: https://kt0755.github.io/etc/repro.296b5.c

An integer overflow arose in bcm_timeval_to_ktime() when
tv.tv_usec * NSEC_PER_USEC is larger than its boundary of the
destination (i.e., long).
To fix, an appropriate boundary check should be placed right before the usage.

=========================================
UBSAN: Undefined behaviour in net/can/bcm.c:140:41
signed integer overflow:
60870466536963773 * 1000 cannot be represented in type 'long int'
CPU: 0 PID: 7063 Comm: syz-executor3 Not tainted 4.19.13 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
 bcm_timeval_to_ktime net/can/bcm.c:140 [inline]
 bcm_rx_setup net/can/bcm.c:1190 [inline]
 bcm_sendmsg+0x3807/0x3fd0 net/can/bcm.c:1355
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg+0xdd/0x130 net/socket.c:631
 sock_write_iter+0x24b/0x3d0 net/socket.c:900
 call_write_iter include/linux/fs.h:1811 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x538/0x6e0 fs/read_write.c:487
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc2e6feac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc2e6feb6cc RCX: 00000000004497b9
RDX: 0000000000000048 RSI: 00000000200000c0 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000ba60 R14: 00000000006f4b00 R15: 00007fc2e6feb700
=========================================

Thanks,
Kyungtae Kim
