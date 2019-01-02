Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CB6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374BB218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfABKfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:35:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:52385 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfABKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:35:03 -0500
Received: by mail-io1-f71.google.com with SMTP id h7so36343587iof.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mwQamXfHCeWlNyCK2NoSK4aDp93/0zsyIIQPFb6KFZU=;
        b=cPTvsXANQnA46jC2uU6yeyQe0glia/7GgwhEk6CoiaLoVVttqoyZ16krCS6ma3OIQm
         3PmuKcgn9bieicO0RgZet8zem4DDMLo+QbpLSAslSuWtC8Kqf21Wnp8o+AdxcXgcmG02
         zPsCIKU2kIJCJZJMAwtCh7VBBRbedbK+broOLmzjCUWf1Q1/wB8TLO9qzdLqieQBegN9
         HT9liL5prITUoU2OVaatVYTEvxPstMFC3qWUHJJDKQaI4KN3ZAk1jxqMJrknJ1J+h4Iy
         jz27T8LYqNeP3BXzj664TODWPYdPj6/4uq6IBhpZPBfU5Tl9B5ElJlBFNkAOB2EO4VXf
         oG2w==
X-Gm-Message-State: AJcUukfF0A0YIxIzpmYSNjNptXmBJFFg/OZmQ9KeOrdcJyD2heHsTFxQ
        sR9GKRcn35F0/PLz0yd+ZGeuNUIpv9tJGuqK+xmhyYnDypxD
X-Google-Smtp-Source: ALg8bN7e6ies2acBBiG8ktVye+d892LH/wPOx8M3elA9KL8jmbI6H9xGVS/hevoFfnie3TVzA91McMmhzp0S+0Mj1Hrp88ZPisuv
MIME-Version: 1.0
X-Received: by 2002:a6b:a10:: with SMTP id z16mr41382240ioi.13.1546425302745;
 Wed, 02 Jan 2019 02:35:02 -0800 (PST)
Date:   Wed, 02 Jan 2019 02:35:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d78798057e773261@google.com>
Subject: KASAN: use-after-free Read in refcount_inc_not_zero_checked
From:   syzbot <syzbot+defa700d16f1bd1b9a05@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a1d293238c1 Add linux-next specific files for 20181224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=100ff080c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af046212050aa3ac
dashboard link: https://syzkaller.appspot.com/bug?extid=defa700d16f1bd1b9a05
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+defa700d16f1bd1b9a05@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/generated/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in refcount_inc_not_zero_checked+0x90/0x2c0  
lib/refcount.c:120
Read of size 4 at addr ffff8880576b03c0 by task syz-executor0/12972

CPU: 1 PID: 12972 Comm: syz-executor0 Not tainted 4.20.0-rc7-next-20181224  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:100
  atomic_read include/generated/atomic-instrumented.h:26 [inline]
  refcount_inc_not_zero_checked+0x90/0x2c0 lib/refcount.c:120
  refcount_inc_checked+0x17/0x70 lib/refcount.c:153
  sock_hold include/net/sock.h:643 [inline]
  nr_release+0x62/0x3c0 net/netrom/af_netrom.c:523
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1141
  __fput+0x3cd/0xaa0 fs/file_table.c:279
  ____fput+0x16/0x20 fs/file_table.c:312
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411c91
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff4f364100 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411c91
RDX: 0000000000000000 RSI: 000000000000123b RDI: 0000000000000004
RBP: 0000000000000000 R08: 000000003436323b R09: 000000003436323f
R10: 00007fff4f364030 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00000000000014d3 R15: 0000000000000000

Allocated by task 12976:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  __do_kmalloc mm/slab.c:3709 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3718
  kmalloc include/linux/slab.h:550 [inline]
  sk_prot_alloc+0x19c/0x2e0 net/core/sock.c:1477
  sk_alloc+0xd7/0x1690 net/core/sock.c:1531
  nr_create+0xb9/0x5e0 net/netrom/af_netrom.c:436
  __sock_create+0x532/0x930 net/socket.c:1277
  sock_create net/socket.c:1317 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1347
  __do_sys_socket net/socket.c:1356 [inline]
  __se_sys_socket net/socket.c:1354 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1354
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 12972:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  sk_prot_free net/core/sock.c:1514 [inline]
  __sk_destruct+0x76d/0xa60 net/core/sock.c:1596
  sk_destruct+0x7b/0x90 net/core/sock.c:1604
  __sk_free+0xce/0x300 net/core/sock.c:1615
  sk_free+0x42/0x50 net/core/sock.c:1626
  sock_put include/net/sock.h:1703 [inline]
  nr_release+0x337/0x3c0 net/netrom/af_netrom.c:557
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1141
  __fput+0x3cd/0xaa0 fs/file_table.c:279
  ____fput+0x16/0x20 fs/file_table.c:312
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880576b0340
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
  2048-byte region [ffff8880576b0340, ffff8880576b0b40)
The buggy address belongs to the page:
page:ffffea00015dac00 count:1 mapcount:0 mapping:ffff88812c3f0c40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea000237cc88 ffffea0002528808 ffff88812c3f0c40
raw: 0000000000000000 ffff8880576b0340 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880576b0280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880576b0300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8880576b0380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8880576b0400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880576b0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
