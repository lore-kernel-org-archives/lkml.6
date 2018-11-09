Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1973C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7C520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7C520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeKJFaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:30:07 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:38948 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJFaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:30:07 -0500
Received: by mail-it1-f197.google.com with SMTP id l15-v6so2032113ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b3FKCWE+tVE/Stv/jUo/8dLNiEX9rrvASawzR05C09M=;
        b=Ae0PWQkiovBKADg87Fk9qp66S/C+Nl52VQPtzr5qKHqkypWky/TbxCtQe8Qjpwrcd3
         ShpwBzujvnDrI+ejLSkWI2S+Httzqqsis8ZOzvSC+hbQq3I6dqxRKDGS7bwPvQT48E1L
         r8Yzl82ZLBLVgqb8dBVXbjfDr/2zZwt6/oxKa/3AdynR/XTnd1oNBqpp2Yx7XpeNncMw
         fy19FB2cMSiOnDSQpYE2qE7cYT3YPGb1z8EBlTzKnQhOMxtLKwSWW1WGIf3xRonB18Ud
         UKYDPb5jmRs7eubMl4tllqGSaL0LyEdSv6hPV5ISjoycXpN8qKzfu4FNkKJVqIoiz/Fi
         zq3w==
X-Gm-Message-State: AGRZ1gL6+Gpn1m2juoizLhpIaemPYsBWFoi9Z17Io8fgVyLzS5XEr/gu
        eBgp3+WVS63GaanxsQsHeevhkOr02Cfen54ha+G3vxDUA02y
X-Google-Smtp-Source: AJdET5eeclSvdu5CKJkQ67OfLfmnsc6Br0h0B1dGCFZsgA8sNmw8m8uhVyOl+ov6Wq/e+PE6oFJqiXc8RSPNc9Zmqbsl4uBBMrfA
MIME-Version: 1.0
X-Received: by 2002:a24:610e:: with SMTP id s14-v6mr2976404itc.38.1541792883704;
 Fri, 09 Nov 2018 11:48:03 -0800 (PST)
Date:   Fri, 09 Nov 2018 11:48:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026aaac057a40a183@google.com>
Subject: WARNING: locking bug in loop_control_ioctl
From:   syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14790f7b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66046c6bfaf1f24d
dashboard link: https://syzkaller.appspot.com/bug?extid=c0138741c2290fc5e63f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ef394d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111cfb83400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(depth <= 0)
WARNING: CPU: 1 PID: 5795 at kernel/locking/lockdep.c:3595 __lock_release  
kernel/locking/lockdep.c:3595 [inline]
WARNING: CPU: 1 PID: 5795 at kernel/locking/lockdep.c:3595  
lock_release+0x740/0xa10 kernel/locking/lockdep.c:3863
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 5795 Comm: syz-executor569 Not tainted  
4.20.0-rc1-next-20181109+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:__lock_release kernel/locking/lockdep.c:3595 [inline]
RIP: 0010:lock_release+0x740/0xa10 kernel/locking/lockdep.c:3863
Code: 03 38 d0 7c 08 84 d2 0f 85 da 02 00 00 8b 35 a7 82 b3 08 85 f6 75 15  
48 c7 c6 20 66 2b 88 48 c7 c7 c0 33 2b 88 e8 10 36 e7 ff <0f> 0b 48 8b 95  
e8 fe ff ff 4c 89 f7 48 8b b5 f0 fe ff ff e8 e8 58
RSP: 0018:ffff8801b9867868 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 1ffff1003730cf12 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165ba15 RDI: 0000000000000006
RBP: ffff8801b9867998 R08: ffff8801d24940c0 R09: fffffbfff12b2254
R10: fffffbfff12b2254 R11: ffffffff895912a3 R12: ffffffff8b0e17a0
R13: ffff8801b9867970 R14: ffff8801d24940c0 R15: ffff8801b98678b0
  __mutex_unlock_slowpath+0x102/0x8c0 kernel/locking/mutex.c:1197
  mutex_unlock+0xd/0x10 kernel/locking/mutex.c:713
  loop_control_ioctl+0xf5/0x4e0 drivers/block/loop.c:2095
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x447009
Code: e8 0c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fba6d10bda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006e19e8 RCX: 0000000000447009
RDX: 0000000000000000 RSI: 0000000000004c81 RDI: 0000000000000003
RBP: 00000000006e19e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e19ec
R13: 6f72746e6f632d70 R14: 6f6f6c2f7665642f R15: 00000000006e19e0
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
