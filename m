Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2058920856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2058920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeGRFE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:04:57 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:44811 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeGRFE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:04:57 -0400
Received: by mail-it0-f71.google.com with SMTP id z8-v6so1423164itc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 21:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=L8NX5EQ2kqL4G1rHXEj8lHRWkQCGeKSC24Nyb+U+BwY=;
        b=lF/Mqs4LL7OqjutFdu0XXWi91hw4KdgppfLNa0EYXbm4kRaS6ARRKD9sBX0nfVd3HL
         hzz/vcd3EapDRjx2OFfbChEVlNRzs0je+05tOaKCisQ/6FNc4eheYF9m9kZH9IJ75Quz
         4KgsQXJ3EAphRkm02bKvqWiafuyoF8dpNXuN6EolrSiozEy29Nby8Cap0C8JfsTAjf//
         3hWjnAxPaKL2vf1zUyJoBDQl7h1qVBZ0MdzFbZS1bF+Yn3GaFyXhS6nJk3R/4o9OU2FE
         xvJOS9SufsC0PYQKuAW4F7n1bnn3EfuTDk1tVePtWxu60cLPuyOwyzQuPEhwedy1ugyY
         UCkw==
X-Gm-Message-State: AOUpUlGHWZMZfOCvs1iPoVRUgRcE7C/7ttQU8eBbgmuNqYaw9MKB43p4
        3P7mFEgKr0Cvx9ijEh1ivnZLSHjsLHpMsWiFZNIHJdxwFdFJ
X-Google-Smtp-Source: AAOMgpfeeDNlMjFnbpg7ix1fckGMTwzLkwxtjxA0Rk5lCtCLVsFOLDGsORNEHBUs7jan73JhZLIAsO9Sc8mdDDAydiufGBnOjpJr
MIME-Version: 1.0
X-Received: by 2002:a6b:fd10:: with SMTP id c16-v6mr1755342ioi.95.1531888142454;
 Tue, 17 Jul 2018 21:29:02 -0700 (PDT)
Date:   Tue, 17 Jul 2018 21:29:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091198305713e80fd@google.com>
Subject: KASAN: slab-out-of-bounds Read in corrupted
From:   syzbot <syzbot+a7429c9ff268823af453@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dc989d2ce2c2 tools: bpftool: don't pass FEATURES_DUMP to l..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14289578400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
dashboard link: https://syzkaller.appspot.com/bug?extid=a7429c9ff268823af453
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=106314c8400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1495b4c8400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a7429c9ff268823af453@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in do_error_trap+0x3b6/0x4d0  
arch/x86/kernel/traps.c:296
Read of size 8 at addr ffff8801c0ce3cb0 by task syz-executor113/9480

CPU: 1 PID: 9480 Comm: syz-executor113 Not tainted 4.18.0-rc3+ #57
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

Allocated by task 2164292896:
BUG: unable to handle kernel paging request at ffffffff8c433958
PGD 8e6d067 P4D 8e6d067 PUD 8e6e063 PMD 0
Thread overran stack, or stack corrupted
Oops: 0000 [#1] SMP KASAN
CPU: 1 PID: 9480 Comm: syz-executor113 Not tainted 4.18.0-rc3+ #57
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
Code: e8 c5 2e 47 fe e9 b3 fd ff ff e8 bb 2e 47 fe e9 55 fd ff ff 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 60  
39 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
RSP: 0018:ffff8801c0ce3a08 EFLAGS: 00010006
RAX: 00000000001fffff RBX: ffff8801c0ce3bc4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801c0ce3a10 RDI: 0000000000003ff0
RBP: ffff8801c0ce3a38 R08: ffff8801b2632440 R09: ffffed003b5e3ec2
R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: ffff8801c0ce2bc0
R13: ffff8801c0ce3cb0 R14: ffff8801da987dc0 R15: ffff8801c0ce3bc0
FS:  0000000000b43940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c433958 CR3: 00000001ae01a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffffff8c433958
---[ end trace 3b9527e7dfd4d0bc ]---
RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
Code: e8 c5 2e 47 fe e9 b3 fd ff ff e8 bb 2e 47 fe e9 55 fd ff ff 90 90 90  
90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 60  
39 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
RSP: 0018:ffff8801c0ce3a08 EFLAGS: 00010006
RAX: 00000000001fffff RBX: ffff8801c0ce3bc4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801c0ce3a10 RDI: 0000000000003ff0
RBP: ffff8801c0ce3a38 R08: ffff8801b2632440 R09: ffffed003b5e3ec2
R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: ffff8801c0ce2bc0
R13: ffff8801c0ce3cb0 R14: ffff8801da987dc0 R15: ffff8801c0ce3bc0
FS:  0000000000b43940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c433958 CR3: 00000001ae01a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
