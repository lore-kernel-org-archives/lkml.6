Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A270F20869
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jklx0Yts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbeLXKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 05:25:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39884 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLXKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 05:25:35 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so8741193iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 02:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hetFAfGJuCOQl97n8noYGHvYm/O2QoeflsnRDHofOjA=;
        b=Jklx0YtscBemfRZlmWj5OLWJQIsvKvTWSXHcMaIc5yotNHbIb6lPaAVkdJoxTv8EL2
         3cdcRI0cPD7nZPIKPZEwce1FNw+tnA66Hxdv52VP5SpohqCvbqiZ1s9YH/ifwXmZ+gGN
         7Eu+q7OUMpmKgsmjvfQKQyduisqNw8q62PP94MhfyvyjBpAkzTConA+c2QmmiO3Djrpw
         L+qGCXYAulTdKv1rcpRP2DdD/TImhnKuRJ5vKZASAT9hXgZLOh+2ksiYKc1CI1bV3nxh
         hmjIwYxMJhHNiWDK8hiMhPxxr+eq9YRdl62+GAFUt9rIbXHcIUnbnzSmM8hKO8VrgJn1
         mmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hetFAfGJuCOQl97n8noYGHvYm/O2QoeflsnRDHofOjA=;
        b=owuHkgVnD2MGczWCAHm4z+IIGtqcVY+GkoAygjEqPIpwhvfyjb4uT8dI043+ewSKt1
         CujdimL/CnhzjV4vd3K7TkV0HwZXkU4HLlTsD33iPvFshsEya1Bi/RqVxQAqbBIu32S8
         u0kqge9kXABfQ+Szubtp69IGGetJwTScfzrvJWiF95n7VnIoB/2PVQ5mTOiz7hqUGAkb
         0WH3odaP1AukGamo5G6xw+TR2yAHBU7lTRhO9UR0kzXJnGH96cBQdMIxOZyvAwTnZF38
         NiqVaGGBNfkuFKaOYOJ10T3d31MQGBg3CBmjw0NpmHqvZOoNVJAHQX9KpYs+gd50rx9w
         jAVQ==
X-Gm-Message-State: AJcUukcJd4hh6YBu/JWWPoGSHbfHr8zYTuznv3sNUWYNT5UYLOaA0aTj
        Q14HRDTJgwuQskMUi9kV3VtpobUzu7z74SmVKRw0MQ==
X-Google-Smtp-Source: ALg8bN59rMl8f3MKtD6IfVP3JPdxbL9vKWm7e78GzRaazIvd/XWXWdMjyV4h3fs3qX3nD0cF0gAkxbjna5aXKD/K1jk=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr7803779ioh.271.1545647133497;
 Mon, 24 Dec 2018 02:25:33 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Dec 2018 11:25:22 +0100
Message-ID: <CACT4Y+bDnO1dL+o6MJtT42ouhiZhvJEiW4eZCLB4dof261v6DA@mail.gmail.com>
Subject: net/rose: GPF in rose_route_frame
To:     ralf@linux-mips.org, David Miller <davem@davemloft.net>,
        linux-hams@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rose device crashes kernel after several seconds after up'ping. I am doing just:

# ip link set dev rose0 address 11:22:33:44:55
# ip link set dev rose0 up

Then after ~15 seconds or so:

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 2747 Comm: aoe_tx0 Not tainted 4.20.0-rc7-next-20181221 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RIP: 0010:ax25cmp+0x3e/0x180 net/ax25/ax25_addr.c:122
Code: f6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 10 48 89 7d d0 48
89 75 c8 e8 cf 73 6d fa 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 <42> 0f
b6 04 38 38 d0 7f 08 84 c0 0f 85 23 01 00 00 4c 89 e0 4c 89
RSP: 0018:ffff888069ec73c8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff888064ce8080 RCX: 0000000000000001
RDX: 0000000000000007 RSI: ffffffff8711cd61 RDI: 0000000000000017
RBP: ffff888069ec7400 R08: ffffed100d3d8e70 R09: ffffed100d3d8e6f
R10: ffffed100d3d8e6f R11: 0000000000000003 R12: ffff888064ce8088
R13: 0000000000000017 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88806c780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2a68767000 CR3: 0000000068f90003 CR4: 00000000001606e0
Call Trace:
 rose_route_frame+0x2d0/0x19a0 net/rose/rose_route.c:885
 rose_xmit+0x88/0x180 net/rose/rose_dev.c:110
 __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
 netdev_start_xmit include/linux/netdevice.h:4391 [inline]
 xmit_one net/core/dev.c:3278 [inline]
 dev_hard_start_xmit+0x286/0xc80 net/core/dev.c:3294
 __dev_queue_xmit+0x2efb/0x3940 net/core/dev.c:3864
 dev_queue_xmit+0x17/0x20 net/core/dev.c:3897
 tx+0x77/0xd0 drivers/block/aoe/aoenet.c:63
 kthread+0x296/0x4a0 drivers/block/aoe/aoecmd.c:1239
 kthread+0x35a/0x440 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 1e8c52d44c421a9f ]---
RIP: 0010:ax25cmp+0x3e/0x180 net/ax25/ax25_addr.c:122
Code: f6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 10 48 89 7d d0 48
89 75 c8 e8 cf 73 6d fa 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 <42> 0f
b6 04 38 38 d0 7f 08 84 c0 0f 85 23 01 00 00 4c 89 e0 4c 89
RSP: 0018:ffff888069ec73c8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff888064ce8080 RCX: 0000000000000001
RDX: 0000000000000007 RSI: ffffffff8711cd61 RDI: 0000000000000017
RBP: ffff888069ec7400 R08: ffffed100d3d8e70 R09: ffffed100d3d8e6f
R10: ffffed100d3d8e6f R11: 0000000000000003 R12: ffff888064ce8088
R13: 0000000000000017 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88806c780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2a68767000 CR3: 0000000068f90003 CR4: 00000000001606e0


Kernel is on today's linux-next head:

commit 340ae71f9dd421227a58c14a909b63033745dca4 (HEAD, tag:
next-20181221, next/master)
Date:   Fri Dec 21 19:27:46 2018 +1100
    Add linux-next specific files for 20181221

Kernel config:
https://gist.githubusercontent.com/dvyukov/fccf387306df8a1042949da46028302a/raw/f817219bdb8d5ef63fdd56f17e0cc13e620e1978/gistfile1.txt
