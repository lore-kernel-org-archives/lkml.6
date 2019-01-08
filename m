Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7180C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DBB20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vg7h82xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfAHNhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:37:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34963 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfAHNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:37:49 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so5968714itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+vtvXi/AF3uGMIGzxHpWmRmtXtWc5UOkdkgrZJyivlg=;
        b=vg7h82xfmR3yGZArbZVQLM9+1TOC2JRIbgzJD/GMS/mwLioOXkg5HY95mO8l8D4nH2
         eJyWyFzaaLKPai7IjmZHy70piv2M5oIUX5BaHV102+FubItwYQyBx0/620D0jlAqY7to
         7CqIAiO4pg+BtKgXZP2Yj2HmtK5E/bbj3IMddqcHh6RmWo/Wf0I6jt2FGrrmc+/S6rLt
         rQYjM1WQV77xl7f9lfpmjy+7/fPnM0WaoeHfIuzZxhAGdxlmU3dnKqCR2Tdo7W14GMhE
         CB0m4kaZPlcDAH7kffhjvrlM3h7+T7HRrSEZFdg4AfQQQPMm9HSblBS0b1qDn2B/Wob8
         J24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+vtvXi/AF3uGMIGzxHpWmRmtXtWc5UOkdkgrZJyivlg=;
        b=PqZmu5f1VonzSPdPe6ZdbcaYHdjpT/Oz4cpd30QrhTQoTYJ17uBA9c/cYJlWBGdUE0
         iU2sDehkM4lT/kdEVHz6wvpxIStz3J0hpwUZRwqH7dFG4JLoTNyWfTvbE+l9feuY//Ka
         6pErfvxdYu35091ft2rolL0k8hLgF5M+gFtmLV1J8oqOtcWBFdJ1ciQgCTqRE6PWxGT/
         2sf59qbK33RWkAhBfpMqtIN1f2II4/2ZlaBYHif4PTHOPp9sEEKkcvgzO3LUqqh4BVtb
         tf9NyOprhmhAX7lq5TPlRIcF8zizyei5fSHU8856aIOfmqeWGZYv9Tl56LCcrLullMqe
         mvcQ==
X-Gm-Message-State: AJcUukcSuPokhbboNWbO2xv9vbp9/HxrGb7BN0KozQxEdHxedRBtF4f6
        BvJCQSaOwE1FgP/qZI+mey3nD2OzJl97M198G+U=
X-Google-Smtp-Source: ALg8bN6ERUT7Wb9pBXpFLlisplPc/biY8FGj8cKjvNYHR7NGGRLRB3IOSrM63B5gjs6BRG0nQmzk42SjZdy/M3vY+as=
X-Received: by 2002:a24:6e14:: with SMTP id w20mr1235341itc.69.1546954667932;
 Tue, 08 Jan 2019 05:37:47 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 8 Jan 2019 08:37:37 -0500
Message-ID: <CAEAjamunJjFFJ8Yd-DQAv64MxYiiktsTUWex=boAOdc0+7h+uQ@mail.gmail.com>
Subject: general protection fault in spk_ttyio_ldisc_close
To:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug in linux-4.20: "general protection fault in
spk_ttyio_ldisc_close"

kernel config: https://kt0755.github.io/etc/config_v4.20_stable
repro: https://kt0755.github.io/etc/repro.a670e.c

This occurs when the function kfree is about to execute
(driver/staging/speakup/spk_ttyio.c:68).
Particularly, kfree takes the argument like speakup_tty->disc_data.
But speakup_tty is invalid, so the pointer dereference causes GPF.
At a glance, it seems that speakup_tty was deallocated somewhere ahead of kfree.

=========================================
general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 13246 Comm: syz-executor7 Not tainted 4.20.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
RIP: 0010:spk_ttyio_ldisc_close+0x3f/0x80 drivers/staging/speakup/spk_ttyio.c:68
Code: 35 95 8c e8 43 03 60 01 48 8b 1d dc 2e 3f 07 48 ba 00 00 00 00
00 fc ff df 48 8d bb 70 05 00 00 48 89 f8 48 c1 e8 03 48 01 d0 <80> 38
00 75 26 48 8b bb 70 05 00 00 e8 a0 68 4f fa 48 c7 c7 c0 35
RSP: 0018:ffff88810e6f7960 EFLAGS: 00010282
RAX: dffffc00000000ae RBX: 0000000000000000 RCX: 1ffff11021cdef00
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000570
RBP: ffff88810e6f7968 R08: fffffbfff192a6b9 R09: fffffbfff192a6b9
R10: ffff88810e6f7950 R11: fffffbfff192a6b8 R12: ffff8881063ee6b0
R13: ffffffff87471020 R14: ffff8881063eeea8 R15: ffff888116ec7b80
FS:  00007f607f746700(0000) GS:ffff88811a000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006fb2e0 CR3: 000000010f186000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tty_ldisc_close drivers/tty/tty_ldisc.c:477 [inline]
 tty_ldisc_kill+0xef/0x1a0 drivers/tty/tty_ldisc.c:623
 tty_ldisc_release+0x111/0x230 drivers/tty/tty_ldisc.c:790
 tty_release_struct+0x1f/0x60 drivers/tty/tty_io.c:1595
 tty_release+0xb80/0x11c0 drivers/tty/tty_io.c:1768
 __fput+0x2b8/0x7a0 fs/file_table.c:278
 ____fput+0x1a/0x20 fs/file_table.c:309
 task_work_run+0x15b/0x1e0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x8d6/0x30d0 kernel/exit.c:867
 do_group_exit+0x13d/0x370 kernel/exit.c:970
 get_signal+0x6bb/0x1890 kernel/signal.c:2517
 do_signal+0x8c/0x1a10 arch/x86/kernel/signal.c:816
 exit_to_usermode_loop+0x186/0x1d0 arch/x86/entry/common.c:162
 prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
 do_syscall_64+0x445/0x4f0 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f607f745ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000071bf80 RCX: 00000000004497b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000071bf80
RBP: 000000000071bf80 R08: 0000000000000000 R09: 000000000071bf58
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f607f7469c0 R15: 00007f607f746700
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
=========================================

Thanks,
Kyungtae Kim
