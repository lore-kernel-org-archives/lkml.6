Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEDC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C394921019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfQkkJMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfAUTVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:21:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50383 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAUTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:21:45 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so17991272iti.0;
        Mon, 21 Jan 2019 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M9x3GxaFhiDClbO7O0fnQ/f2g1K0PgAJNnmsxhIwHdY=;
        b=AfQkkJMtuAc9uGOcSK/zAvFQVUhL2YwTwRN7geKNJPpNISYeR4LEnJYBpd/JBHpYod
         QRE3xQ3C0LphQqJInOXavMtHUJeoG3aNlvKNHuoPavaEVD6rLE9Ix1vK8+w6HGKzN4a4
         ZX/XmVG/v+AuJBb4+zl9vp80qD0oF9l0JLUzp5vWaaNnXhH/gWGLfKKlMWiAAr0+2Q0V
         WUQ0KCI5bpSRr5OWenuJrc9UVxA2g80locT35Bp+b7rUeqrKr8rcl+t+WMqEzv78iuuY
         J5+0R1XgBEHelBweT5r/zrwLG1/DX5xmGivDLiGjv6ow6Tx5yMHZxar+E9kNd13EtLCx
         Vpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M9x3GxaFhiDClbO7O0fnQ/f2g1K0PgAJNnmsxhIwHdY=;
        b=QJiFGhnF0G3fr0bo7TSW3GZTjUj4xFTDwXU0vuSAbozzoEeRvpI2LUrM2b6uCVM1o+
         4frxgaJfUoFHii4gN92gox2clIElnIcvVFZYbQHzuOBLo5iIXBvKnyptZYgYLZ1JCNlh
         P1ywqxqyb3xFWevive30sqRkJWCmMiFJQXCE6Izo7OXgnumymp5Ia+ZMIAemBpjYPsBu
         TFOaKuiQLwcs8Wg4CoJg7xZM+hvXifTQRKtp7BGgscsrg5V10u2AEjK67cXT1ZQP5bk2
         CQD3I9gMeDal+sEANZIDd5sVi9ueG78wzJdKudREt+s9CXpHVaJ/nNetrTklSgeYazvd
         ArWg==
X-Gm-Message-State: AJcUukcc4ieRNU+NDZEwa3626nuQxOEPR40iJqBj9KyFkYullEbPRHEs
        ekMR3JrdK4vWDPEdogNhdhSYwHxX3lRhtaIhpUo=
X-Google-Smtp-Source: ALg8bN4WgRX6SzSE8G4PvHvvglnsIDKpZIGZQwSXSMHE1BLuLs4dEsdNQWgVGrKi8jPcqIaUbYQ0OviBRaHaat03oTM=
X-Received: by 2002:a24:c705:: with SMTP id t5mr454309itg.60.1548098503809;
 Mon, 21 Jan 2019 11:21:43 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 21 Jan 2019 14:21:32 -0500
Message-ID: <CAEAjamsix7hdT7d3qvZ1mVEFJ+OV-pxCX4Xzc4gWFA4_7YKRQw@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in net/ipv4/ip_output.c
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting a bug in linux-5.0-rc2: "UBSAN: Undefined behaviour in
net/ipv4/ip_output.c"

kernel config: https://kt0755.github.io/etc/config-5.0-rc2
repro: https://kt0755.github.io/etc/repro.b6a11.c

Integer overflow happened in __ip_append_data() when 2 * sk->sk_sndbuf
(at line 1004)
is larger than the boundary of the destination (i.e., int).
Some sanity check code right before it would help.

=========================================
UBSAN: Undefined behaviour in net/ipv4/ip_output.c:1004:11
signed integer overflow:
1282607372 * 2 cannot be represented in type 'int'
CPU: 0 PID: 8465 Comm: syz-executor4 Not tainted 5.0.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xb1/0x118 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
 __ip_append_data+0x30ed/0x3350 net/ipv4/ip_output.c:1004
 ip_append_data.part.18+0xf3/0x170 net/ipv4/ip_output.c:1220
 ip_append_data+0x63/0x80 net/ipv4/ip_output.c:1209
 raw_sendmsg+0xd99/0x2b60 net/ipv4/raw.c:670
 inet_sendmsg+0xfc/0x620 net/ipv4/af_inet.c:798
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg+0xdd/0x130 net/socket.c:631
 ___sys_sendmsg+0x7b3/0x950 net/socket.c:2116
 __sys_sendmsg+0xfc/0x1d0 net/socket.c:2154
 __do_sys_sendmsg net/socket.c:2163 [inline]
 __se_sys_sendmsg net/socket.c:2161 [inline]
 __x64_sys_sendmsg+0x83/0xc0 net/socket.c:2161
 do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0d0100bc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0d0100c6cc RCX: 00000000004497b9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000089a0 R14: 00000000006f1a40 R15: 00007f0d0100c700
=========================================

Thanks,
Kyungtae
