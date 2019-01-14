Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE98C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1BA2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prV/3fjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfANVT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:19:57 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36539 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfANVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:19:56 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so427153ioh.3;
        Mon, 14 Jan 2019 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u4pk6BSwGax4534NENoZRkqFuPVefVtLm3wSWuM9Flo=;
        b=prV/3fjLm0udo2cazQ1o8lx1hpNah/sGEXJmqqCYE7jipqs3ejOFxcityG0N3hnEn/
         Uu6UhwkojbrZ1lm/JoEKij5lcnxiuPaBqjerZArpLPKdvwesYPHUCfZni0KWEBLIuVHo
         ZH0TCf25qCxLoH6dEqI445d7+LcdHy6EJfsn4K3o3CZY3p35I/4gqZV9E/IPVYgwH2Tj
         lkhTbZvqfwBcUySyPkCPkFvZH+xhHQrdsNwAQB4ABOHVq/1AIBSnvqZPX13o9hd8TEPi
         9VgBUvIOrI+x6/Lx64YQRI29feqD+DvIMXoJ4h6nzs4DDbgi2Ig64Kq17raJCV4Wb4Je
         /Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u4pk6BSwGax4534NENoZRkqFuPVefVtLm3wSWuM9Flo=;
        b=WtIecOxQ+YkQwb41CRIKSSUXqqjwK2pEKRB7uUL3Ux0I6uQOQwZpGtZcmb8gRx5wFk
         5I11RkeyKorYd3htSFb7t/0ZPI/cIJMZPiEx3sKk/4C4GsHQ/cEYmnoGKY2QObPLrqnX
         yC5IWVsCk0lkQShxUmUi7gD+l3YE6buhipdeuXiEl5YffG9P3YeFM9a6EUxx4NMxNgLR
         7LoStyOiw5Js9M3+nZq31eRecflks+Ix7vDBdURi2gw1OKFCs/MUX0XNxRPRWETydEkw
         93cAa16eZOKfTla7oXZ1M0z5PRmIuCM+nQb9TM34UWVD3m9UuCWjaG399hmjTawbzXrW
         mmgg==
X-Gm-Message-State: AJcUukdBthroOLIy6s/59lv4DInccgU0PxfIhZVk0MC3Vz8gUNFHqRq0
        AblVb09vIDChHbZviNxnduWQPXfgPrnVsJqwFAo=
X-Google-Smtp-Source: ALg8bN7af9tABisBmv1DHscCdEgHed+rTYjGptTJAMkJVq375AB1xPHFoU3Vtm7DtYaA+pRQYv+URnc2MVvPSOnp1ws=
X-Received: by 2002:a6b:6111:: with SMTP id v17mr278993iob.107.1547500795516;
 Mon, 14 Jan 2019 13:19:55 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 14 Jan 2019 16:19:44 -0500
Message-ID: <CAEAjamv5mBAoZAcEc962v6VMCw27h6yBCt1OxCgzyZRgozfCjA@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in drivers/input/misc/uinput.c
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, rydberg@bitmath.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug in linux-4.19.13: "UBSAN: Undefined behaviour in
drivers/input/misc/uinput.c"

kernel config: https://kt0755.github.io/etc/config_4.19.13
repro: https://kt0755.github.io/etc/repro.c4925.c

An integer overflow arose  in uinput_validate_absinfo
(drivers/input/misc/uinput.c:420).
To be specific, "if (abs->flat > max - min)" cannot be represented in
type 'int'.
Thing is, in this case, abs->flat, max and min come from user supplied input.
To fix, an appropriate sanity check of that calculation should be
placed right before the usage.

=========================================
UBSAN: Undefined behaviour in drivers/input/misc/uinput.c:420:22
signed integer overflow:
841280591 - -1832774988 cannot be represented in type 'int'
CPU: 0 PID: 7372 Comm: syz-executor3 Not tainted 4.19.13 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_sub_overflow+0x2a/0x31 lib/ubsan.c:206
 uinput_validate_absinfo.isra.2+0x194/0x1a0 drivers/input/misc/uinput.c:420
 uinput_abs_setup drivers/input/misc/uinput.c:503 [inline]
 uinput_ioctl_handler+0xa57/0x1bf0 drivers/input/misc/uinput.c:1036
 uinput_ioctl+0x2d/0x40 drivers/input/misc/uinput.c:1048
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1aa/0x1160 fs/ioctl.c:690
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:705
 __do_sys_ioctl fs/ioctl.c:712 [inline]
 __se_sys_ioctl fs/ioctl.c:710 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:710
 do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7b273c3c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7b273c46cc RCX: 00000000004497b9
RDX: 0000000020000000 RSI: 0000004040105504 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000005ca0 R14: 00000000006eed40 R15: 00007f7b273c4700
=========================================

Thanks,
Kyungtae Kim
