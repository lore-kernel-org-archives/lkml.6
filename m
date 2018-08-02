Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F104C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0228A2150D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0228A2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeHBOuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:50:08 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:51166 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732525AbeHBOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:50:07 -0400
Received: by mail-io0-f200.google.com with SMTP id v2-v6so1473474ioh.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 05:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=R4EPE4mBwlG3Lue5zvmcqhD2yWFzKtjgxgoY+pj9uws=;
        b=P6huUBmzHlBnX1JdF6ePMbkJIb0xR9Mo4TXoghlcpU6tJKUxkGzG3dLyMnBW7kmPg2
         C+Sn5Gf+xxQBkKnCjWuUAfJqHnwA1UnJqZ7UhwUYhcY7sQCZJr1lM9zSqumnZpj6ZwVN
         K815kBt4qt5QgwCOPKdqOEJuHjid4h+AdJtkPZLkSJ6s7M53ZAjQzTQBEggYBbznHuLD
         jcu+anwbPDTLjla5ycLnyhi/HwrDFmT0vWJp9j5i0YWb8ujzSfW7/XIN/XiOcYYtJyDV
         DPgqKYbq8XaJejcFojIyrYp1AE6NM6vnYi79Uq1DeABYpDLsuIwi87Hn/tnnYRykryLG
         NXfA==
X-Gm-Message-State: AOUpUlEDI3XeYGWJ+CT69Nb8h8/OUdqJA1/RBNY/56PweUmYmJx99WHs
        3B35GlhPk2MFNryVpf7tKNPeu/VRnmFEDS2nhxRy+oFUDQRx
X-Google-Smtp-Source: AAOMgpcLZd3dKX/OyIpBaf206smgmPiVBX/cJgrIP4LMZd3o8FZcLb6N/KZT04E8Wemw+Ym9bMAD5eCT9FeVVkjtJCwTmL2w1b3z
MIME-Version: 1.0
X-Received: by 2002:a24:2544:: with SMTP id g65-v6mr1283012itg.0.1533214741803;
 Thu, 02 Aug 2018 05:59:01 -0700 (PDT)
Date:   Thu, 02 Aug 2018 05:59:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cc0de0572736043@google.com>
Subject: KASAN: use-after-free Read in __schedule (2)
From:   syzbot <syzbot+ceded3495a1d59f2d244@syzkaller.appspotmail.com>
To:     hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a94c689e6c9e net: dsa: Do not suspend/resume closed slave_..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=140800e2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=ceded3495a1d59f2d244
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1627bbfc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e0cc8c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ceded3495a1d59f2d244@syzkaller.appspotmail.com

R10: 0000000000000040 R11: 0000000000000212 R12: 0000000000000005
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
page:ffffea000714e200 count:0 mapcount:-128 mapping:0000000000000000  
index:0x0
==================================================================
flags: 0x2fffc0000000000()
BUG: KASAN: use-after-free in schedule_debug kernel/sched/core.c:3313  
[inline]
BUG: KASAN: use-after-free in __schedule+0x1a18/0x1ec0  
kernel/sched/core.c:3423
Read of size 8 at addr ffff8801af280000 by task ip/6349
raw: 02fffc0000000000 ffffea0006cfa208 ffff88021fffac18 0000000000000000

CPU: 1 PID: 6349 Comm: ip Not tainted 4.18.0-rc7+ #37
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
------------[ cut here ]------------
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
kernel BUG at include/linux/mm.h:515!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 6338 Comm: syz-executor087 Not tainted 4.18.0-rc7+ #37
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
RIP: 0010:put_page_testzero include/linux/mm.h:515 [inline]
RIP: 0010:put_page include/linux/mm.h:938 [inline]
RIP: 0010:__skb_frag_unref include/linux/skbuff.h:2759 [inline]
RIP: 0010:skb_release_data+0x6bd/0x880 net/core/skbuff.c:564
  schedule_debug kernel/sched/core.c:3313 [inline]
  __schedule+0x1a18/0x1ec0 kernel/sched/core.c:3423
Code:
e8
58
09
73
fc
48
  schedule+0xfb/0x450 kernel/sched/core.c:3545
8b
bd
10
ff
ff
ff
e8
4c
e6
  exit_to_usermode_loop+0x22f/0x370 arch/x86/entry/common.c:152
fe
ff
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
e9
16
fb
ff
ff
e8
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
42
RIP: 0033:0x7fab7daf0210
09
Code:
73
31
fc
d2
48
48
c7
29
c6
c2
00
64
b9
89
6f
11
87
48
4c
83
89
c8
ef
ff
e8
eb
33
ea
c0
90
a0
90
fc
90
<0f>
90
0b
90
e8
90
2c
90
09
90
73
90
fc
90
4c
90
8d
90
6b
83
ff
3d
e9
e5
b0
d3
fc
2a
ff
00
ff
00
e8
75
1e
10
09
b8
73
2f
fc
00
4c
00
00
RSP: 0018:ffff8801ae95f578 EFLAGS: 00010246
0f
05
RAX: 0000000000000000 RBX: ffffea000714e234 RCX: 0000000000000000
<48>
RDX: 0000000000000000 RSI: ffffffff81a9e055 RDI: ffffed0035d2bea0
3d
RBP: ffff8801ae95f698 R08: ffff8801c6f66978 R09: 0000000000000006
01 f0
R10: ffff8801c6f66140 R11: 0000000000000000 R12: dffffc0000000000
ff
R13: ffffea000714e200 R14: ffff8801cfdc4c20 R15: 0000000000000003
ff 73
FS:  0000000000ae1880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
31
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
c3
CR2: 00007f07e03dea8c CR3: 00000001d752e000 CR4: 00000000001406f0
48
Call Trace:
83
ec
08
e8
6e
bb
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
00
  __kfree_skb+0x15/0x20 net/core/skbuff.c:641
00
  sk_wmem_free_skb include/net/sock.h:1430 [inline]
  tcp_write_queue_purge+0x2c1/0x8b0 net/ipv4/tcp.c:2527
48
89
04
24
  tcp_disconnect+0x49e/0x1550 net/ipv4/tcp.c:2567
RSP: 002b:00007fff8b328a78 EFLAGS: 00000246
  ORIG_RAX: 000000000000002f
RAX: 0000000000001b94 RBX: 00000000006395c0 RCX: 00007fab7daf0210
RDX: 0000000000000000 RSI: 00007fff8b328ac0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006395c0
  tcp_close+0x1026/0x12d0 net/ipv4/tcp.c:2363
R13: 0000000000000000 R14: 00007fff8b32cb98 R15: 00007fff8b32d3a0

The buggy address belongs to the page:
page:ffffea0006bca000 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
  tls_sk_proto_close+0x6fc/0xae0 net/tls/tls_main.c:303
raw: 02fffc0000000000 ffffea000743c288 ffff8801db030118 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801af27ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801af27ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801af280000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                    ^
  ffff8801af280080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801af280100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
