Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4F2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076A720881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076A720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbeGIL7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:59:05 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:41353 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeGIL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:59:03 -0400
Received: by mail-io0-f197.google.com with SMTP id p12-v6so2044664iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vUm6LxZKh/LrMTpTfTnSdNraQluPBiTC3LgfezHFdQU=;
        b=NKzvZI/ZOLu7KPqwpgcv7hEajewojbGUD9Eu8a9jjWm5snApBxf4zriVF6vPbrxsoO
         aXlG0IW4FJ4L2F+eUFixwbQS1qr/wd1LuiiaXDsQiE3iLZu+NHzM1B8S9kAzhVsd21Vf
         jpFBWssI1kRZZdom0RnTgCebf7wosBPaUXMWtCk3eNF/6lLU4Iu51eyf/xJ4JbaVubzG
         BEBXeRJPxN9BAPY46wPjzaR2ACXC7oDz6qPD5bOvbkKf77dg2qFqXsrMlW5AprzKEu91
         6iOwTmBV0/UE+PXVXTTE1SqVTRnAWl5QWhALMm68u0kD7QsLvRlAS71uWPGPMCalRQJj
         cE5w==
X-Gm-Message-State: AOUpUlEGqMpr+C9spAhtsnzxuqyPxpAbhY6Z5qiZ8cHlBFWAZtC+ytZn
        5I3Hex07ULkIqPiT0IojBh+Ow0KIQvwLLrfz2JgD3yntcJIm
X-Google-Smtp-Source: AAOMgpd3DBvl4xQwSqjtsZ/ImFYKlU4EBknBYZPl4fMhotY14nvakr8GqGuuKU1oIGxyo+fKFPIg93rBnvXE5QTkob1mBiKY7WMr
MIME-Version: 1.0
X-Received: by 2002:a6b:7e07:: with SMTP id i7-v6mr1570744iom.55.1531137542599;
 Mon, 09 Jul 2018 04:59:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 04:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054395605708fbd13@google.com>
Subject: BUG: corrupted list in p9_conn_cancel
From:   syzbot <syzbot+ad0832746849421bba05@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132bb168400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=ad0832746849421bba05
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16c4c2c2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165c81b2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ad0832746849421bba05@syzkaller.appspotmail.com

list_del corruption, ffff880045022ee8->next is LIST_POISON1  
(dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:47!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 26 Comm: kworker/0:2 Not tainted 4.18.0-rc3+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: 02 fe 0f 0b 4c 89 e2 48 89 de 48 c7 c7 a0 65 1a 88 e8 4a 6e 02 fe 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 40 65 1a 88 e8 36 6e 02 fe <0f> 0b 48 89 de  
48 c7 c7 60 66 1a 88 e8 25 6e 02 fe 0f 0b 48 89 de
RSP: 0018:ffff8801d9467318 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff880045022ee8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801d9467330 R08: ffff8801d94346c0 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: dead000000000200
R13: dead000000000100 R14: ffff8801d9467388 R15: 1ffff1003b28ce9e
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000008064ed0 CR3: 0000000008e6a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  p9_conn_cancel+0x8d6/0xd30 net/9p/trans_fd.c:224
  p9_poll_mux net/9p/trans_fd.c:620 [inline]
  p9_poll_workfn+0x4b2/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 13d6ed0983a959b1 ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: 02 fe 0f 0b 4c 89 e2 48 89 de 48 c7 c7 a0 65 1a 88 e8 4a 6e 02 fe 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 40 65 1a 88 e8 36 6e 02 fe <0f> 0b 48 89 de  
48 c7 c7 60 66 1a 88 e8 25 6e 02 fe 0f 0b 48 89 de
RSP: 0018:ffff8801d9467318 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff880045022ee8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801d9467330 R08: ffff8801d94346c0 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: dead000000000200
R13: dead000000000100 R14: ffff8801d9467388 R15: 1ffff1003b28ce9e
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000008064ed0 CR3: 0000000008e6a000 CR4: 00000000001406f0
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
