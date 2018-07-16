Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D7BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B148E208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B148E208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeGPP1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:27:04 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:33619 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeGPP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:26:52 -0400
Received: by mail-it0-f69.google.com with SMTP id s40-v6so298925ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=A/VrmFLVYBlbJWLFxYFc33vo/HpQvSes0CBwmQAzCII=;
        b=W2WqrUsCJcREVkOjGmr7PzfmhtuBQgfMWLgurEVRdPJGrE/ujL9IBCAFfZ0uyzyjul
         xwL67p7xdrfpO5xjqtXGvjokP+rNrEhilwJw+F2H2mcWkyOWdkO8qJGK7DMK6dcg5sDq
         +n7ntVCE8nVVuv3JNBLSct/BXGzXa3lXlBxzQyBZwQJkoobt8C8yuPwt85ZD4LU0wvaj
         17CfnkugJ3gbsJrDLwBjMcBMEv/5vn5Kh8P0kyJDTYDB8kKvr0oP52XPGhBIZKqyusN8
         sDxi2RXV+z87eHPkAdU45/BlzTcuqvxqCFQq2oY3+X8opNbyCSfaOXz1Nfs8hmkX25da
         upbA==
X-Gm-Message-State: AOUpUlELJHFSoYWD6c/IZZFqhIN08uWM3Qejhv+TqVDY9OKCP+UR1zUJ
        XygwkLQo8Xf7up+FUCBeLTvzALJucAeOt3tfs2TnLrh1PAbg
X-Google-Smtp-Source: AAOMgpf2/4e0uVfMBLoNVSdwBKZ++gPr8rmTZDggCO8Vcf6wxCDecz4pMdJ1+hBKqhGiFz3Kcr3MsckDS9sXQEANR4dIdY3AStws
MIME-Version: 1.0
X-Received: by 2002:a6b:3384:: with SMTP id z126-v6mr7564528ioz.61.1531753143182;
 Mon, 16 Jul 2018 07:59:03 -0700 (PDT)
Date:   Mon, 16 Jul 2018 07:59:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbad1405711f113c@google.com>
Subject: KASAN: use-after-free Read in kernel_accept
From:   syzbot <syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6bed5e260709 Merge branch 'fix-DCTCP-delayed-ACK'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=176b25d0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b88de6eac8694da6
dashboard link: https://syzkaller.appspot.com/bug?extid=0bf2e01269f1274b4b03
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=159dd178400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b76d62400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kernel_accept+0x2a4/0x310 net/socket.c:3251
Read of size 8 at addr ffff8801a772c5e8 by task kworker/1:3/4569

CPU: 1 PID: 4569 Comm: kworker/1:3 Not tainted 4.18.0-rc3+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events smc_tcp_listen_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  kernel_accept+0x2a4/0x310 net/socket.c:3251
  smc_clcsock_accept net/smc/af_smc.c:701 [inline]
  smc_tcp_listen_work+0x222/0xef0 net/smc/af_smc.c:1114
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 4568:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  sock_alloc_inode+0x78/0x320 net/socket.c:243
  alloc_inode+0x63/0x190 fs/inode.c:210
  new_inode_pseudo+0x71/0x1a0 fs/inode.c:895
  sock_alloc+0x41/0x270 net/socket.c:567
  __sock_create+0x175/0x940 net/socket.c:1250
  sock_create_kern+0x3b/0x50 net/socket.c:1332
  smc_create+0x141/0x360 net/smc/af_smc.c:1701
  __sock_create+0x53c/0x940 net/socket.c:1286
  sock_create net/socket.c:1326 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1356
  __do_sys_socket net/socket.c:1365 [inline]
  __se_sys_socket net/socket.c:1363 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1363
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4568:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  sock_destroy_inode+0x56/0x70 net/socket.c:273
  destroy_inode+0x159/0x200 fs/inode.c:267
  evict+0x5d5/0x990 fs/inode.c:575
  iput_final fs/inode.c:1506 [inline]
  iput+0x635/0xaa0 fs/inode.c:1532
  __sock_release+0x1f1/0x260 net/socket.c:610
  sock_release+0x17/0x20 net/socket.c:618
  smc_release+0x1a8/0x720 net/smc/af_smc.c:146
  __sock_release+0xd7/0x260 net/socket.c:599
  sock_close+0x19/0x20 net/socket.c:1150
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801a772c5c0
  which belongs to the cache sock_inode_cache of size 992
The buggy address is located 40 bytes inside of
  992-byte region [ffff8801a772c5c0, ffff8801a772c9a0)
The buggy address belongs to the page:
page:ffffea00069dcb00 count:1 mapcount:0 mapping:ffff8801d9be93c0  
index:0xffff8801a772cffd
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00069dcac8 ffffea00069dd408 ffff8801d9be93c0
raw: ffff8801a772cffd ffff8801a772c140 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801a772c480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801a772c500: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801a772c580: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                           ^
  ffff8801a772c600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801a772c680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
