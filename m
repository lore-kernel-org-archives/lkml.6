Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B54C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458F5218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBKWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:03:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:34198 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfBKWDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:03:05 -0500
Received: by mail-it1-f198.google.com with SMTP id a3so1175288itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/kqlLrEbDdKTleMLkBf29hunJs7TuCx1ryWaMns/sKQ=;
        b=WkW/Pp9R+sKz45MVo1en1Sw8Swhc9M+Nnlp2T0OrbZ6/Kb5ZMa8GxSHeMASfTgwLo4
         LGdj1kRbuC/N+p1bFgdPw2NUnhFFk5KIKE8eWp/PzraCwvFcdwi72jpzS0AmF2WrP7YK
         amAd2taJXn3KzJlqqxZK4ECPpYyPlbeIQ+KBVQERr4nYYjkqQrchsZnM+t6gtMC/GJHW
         X7W5VT6crW38dGr9vbftzztxjvSQn3jHrv4KBnGpIqI0yZWAFph2c44yrYVJPSiks8UG
         x2En8on9cr+XNpNl88y7wVYf4cFoFQ8HoD8lLlVJ/UQiXf/XvNIgmBmk6s6LPW05PQ9m
         7jeA==
X-Gm-Message-State: AHQUAuZXaOrUDiHQOFB6J8p0Jd7a1CFP0vaJd0SXuz/cQ4kvjunR0gL+
        AoqreAAON2oJlPnZLVjsYnuw7CKdu1HrVBsDvZOnIrVVWPaW
X-Google-Smtp-Source: AHgI3IZP2nc6zXcI000r5sNv89XPY8i0HnvUwJM0HFXDFNy3mxQiolh6Nx5jJX0lT9D7es7RM1tsV3us9J0zFCkLz0rskssh5a2h
MIME-Version: 1.0
X-Received: by 2002:a5e:c80b:: with SMTP id y11mr329232iol.20.1549922584112;
 Mon, 11 Feb 2019 14:03:04 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:03:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e35f00581a579cd@google.com>
Subject: KMSAN: uninit-value in capi_write
From:   syzbot <syzbot+0849c524d9c634f5ae66@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, isdn@linux-pingi.de,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    11587f6ee534 kmsan: remove pr_err
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=120bd84f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a62a4eb8ea3e9f
dashboard link: https://syzkaller.appspot.com/bug?extid=0849c524d9c634f5ae66
compiler:       clang version 8.0.0 (trunk 350161)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c53cd3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e2794b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0849c524d9c634f5ae66@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in capi_write+0x791/0xa90  
drivers/isdn/capi/capi.c:700
CPU: 0 PID: 10025 Comm: syz-executor379 Not tainted 4.20.0-rc7+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
  capi_write+0x791/0xa90 drivers/isdn/capi/capi.c:700
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x83e/0xd80 fs/read_write.c:961
  vfs_writev fs/read_write.c:1004 [inline]
  do_writev+0x397/0x840 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev+0x9b/0xb0 fs/read_write.c:1109
  __x64_sys_writev+0x4a/0x70 fs/read_write.c:1109
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440079
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd84911358 EFLAGS: 00000207 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440079
RDX: 0000000000000001 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401900
R13: 0000000000401990 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:204 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:158
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2759 [inline]
  __kmalloc_node_track_caller+0xe18/0x1030 mm/slub.c:4383
  __kmalloc_reserve net/core/skbuff.c:137 [inline]
  __alloc_skb+0x309/0xa20 net/core/skbuff.c:205
  alloc_skb include/linux/skbuff.h:998 [inline]
  capi_write+0x12f/0xa90 drivers/isdn/capi/capi.c:691
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x83e/0xd80 fs/read_write.c:961
  vfs_writev fs/read_write.c:1004 [inline]
  do_writev+0x397/0x840 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev+0x9b/0xb0 fs/read_write.c:1109
  __x64_sys_writev+0x4a/0x70 fs/read_write.c:1109
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
