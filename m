Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC55C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D235A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D235A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeK0HdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:33:23 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:56297 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeK0HdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:33:23 -0500
Received: by mail-it1-f198.google.com with SMTP id j3so1242475itf.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OHcNSNk4rlVebSBrOulS4oMh/V/juCT+W2dSjillA9w=;
        b=laCW6rf/r8iA6E01T3ne7IRVJPrB0utAW7TcS9Qlls19dsGBthT3+SwmysOlf2EW2J
         9680+g1KJEfNLKskEVKSD0JRmV6L3bUnOQREDKSQ048VwGsKRPN1xIOyrtRgYPSzEKiO
         aUJfdIVtDzZq1TccXC8KzB/vWDoqsxqkfrtC0VjsNsIjsL52Ud0dnXmrSIOALKtd0abB
         ing8lhBuRNd4YbZDbQTVJSNkhusVrEMlVAeZtLx1Jjo7TtoMOQaBaVlr+3JmH/q7eUhH
         SbUjiQxWaJM0PARR9sFQQe2TOEXq/qT7fDb8mxVh8yyL6LEmwvMAKRI5sr+P0Vzs8iZV
         AO7Q==
X-Gm-Message-State: AGRZ1gL0ZlO4q11A6rI3eceLmERNbUjYbC44LctShtRKWtkyTABsWEnU
        fuT+VfUlAxnqnEw+Cm4BmGzba0ojQxYqnhoAQKsSCghsKV8E
X-Google-Smtp-Source: AJdET5eydn8rTC4smBMU8miKS1zbRvyUgvAXoFoHwT2Ax/X8LfBL5V1KsYirTQUNZgamC5z16/tFEqK9YoNqL9oG2V5YuJ3YpHp0
MIME-Version: 1.0
X-Received: by 2002:a02:12dc:: with SMTP id 89mr20000313jap.5.1543264683664;
 Mon, 26 Nov 2018 12:38:03 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:38:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043ae20057b974f14@google.com>
Subject: WARNING: locking bug in lock_downgrade
From:   syzbot <syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@dominikbrodowski.net, mhocko@suse.com, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12336ed5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=53383ae265fb161ef488
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com


------------[ cut here ]------------
downgrading a read lock
WARNING: CPU: 0 PID: 26202 at kernel/locking/lockdep.c:3556  
__lock_downgrade kernel/locking/lockdep.c:3556 [inline]
WARNING: CPU: 0 PID: 26202 at kernel/locking/lockdep.c:3556  
lock_downgrade+0x4d7/0x900 kernel/locking/lockdep.c:3819
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 26202 Comm: blkid Not tainted 4.20.0-rc3+ #127
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
RIP: 0010:__lock_downgrade kernel/locking/lockdep.c:3556 [inline]
RIP: 0010:lock_downgrade+0x4d7/0x900 kernel/locking/lockdep.c:3819
Code: 00 00 fc ff df 41 c6 44 05 00 f8 e9 1b ff ff ff 48 c7 c7 60 68 2b 88  
4c 89 9d 58 ff ff ff 48 89 85 60 ff ff ff e8 d9 1f e7 ff <0f> 0b 48 8b 85  
60 ff ff ff 4c 8d 4d d8 4c 89 e9 48 ba 00 00 00 00
RSP: 0018:ffff8881ba547b70 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 1ffff110374a8f74 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000006
RBP: ffff8881ba547c28 R08: ffff88817c0b2400 R09: fffffbfff12b2254
R10: fffffbfff12b2254 R11: ffffffff895912a3 R12: ffffffff8b0f67a0
R13: ffff8881ba547bc0 R14: 0000000000000001 R15: ffff88817c0b2400
  downgrade_write+0x76/0x270 kernel/locking/rwsem.c:147
  __do_munmap+0xcd8/0xf80 mm/mmap.c:2812
  __vm_munmap+0x138/0x1f0 mm/mmap.c:2837
  __do_sys_munmap mm/mmap.c:2862 [inline]
  __se_sys_munmap mm/mmap.c:2859 [inline]
  __x64_sys_munmap+0x65/0x80 mm/mmap.c:2859
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f237e5ce417
Code: f0 ff ff 73 01 c3 48 8d 0d 8a ad 20 00 31 d2 48 29 c2 89 11 48 83 c8  
ff eb eb 90 90 90 90 90 90 90 90 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8d 0d 5d ad 20 00 31 d2 48 29 c2 89
RSP: 002b:00007ffe61bed9d8 EFLAGS: 00000203 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 00007f237e7d91c8 RCX: 00007f237e5ce417
RDX: 000000000224ff00 RSI: 00000000000033ef RDI: 00007f237e7d1000
RBP: 00007ffe61bedb40 R08: 0000000000000001 R09: 0000000000000007
R10: 00007f237e5c8a0b R11: 0000000000000203 R12: 00000000b1f97d00
R13: 000004b2b1f97d00 R14: 000004b2afd5fdeb R15: 00007f237e7ce740
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
