Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A6BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559B32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559B32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeIJNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:23:57 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:56121 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:23:57 -0400
Received: by mail-it0-f69.google.com with SMTP id m207-v6so40056704itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=M+qkXYg5KszHm2B4cc030LZ85XiIOzlEm4CryboVBhw=;
        b=b4ytGauL7DOxBi5t+qqh8ZmewxHyErDQMUjxseFERIsiZbuK98qOKeRG3ygVvN7PMb
         5+Q/gbi6Suwhjy/bJ5I81jKq3d8vbs/l/jcpesbolK4vQSqs4boB6fvzJXco3Kced9vy
         Br4pL+Wkz/p/E5jPGLsYTn8Abzgelp6dytPhodQ5Z4w5xAWd3A9Nj+0HSp46UogQrWI2
         LOQ9nC2rK3MS1VYXQ8khc64+RYbHrYX1DVevlhJCBwbj7x3Xyi58tHXGxtBA9ckr0vSS
         aEEs9Qby8o9cs5+QqAUm7E1tmUXLODIBMX0js/+1T0oQ6FVa/XKSt12vLXnzf5bh65vL
         8EDw==
X-Gm-Message-State: APzg51Cu+a20RfY0YQLyKF7NHu6m/HNck5gz00aC5qTT3ghOyg8A87Wb
        PZHUeJEQZ4pLNAap9axvTPT7X/ml3BGFL3abqQlwv6TiBi6z
X-Google-Smtp-Source: ANB0VdYBy4idN/3Rt4ny/hLdyy1f3ZTwiHChJXfQI29cb8R3Ci57g4bA2s5VQSUNbWnq3PrIq1sfUesq25aFdPMx8iDP6wJC31jk
MIME-Version: 1.0
X-Received: by 2002:a24:1382:: with SMTP id 124-v6mr18309823itz.30.1536568264013;
 Mon, 10 Sep 2018 01:31:04 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:31:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cc5260575802d0d@google.com>
Subject: KASAN: use-after-free Read in psock_map_pop
From:   syzbot <syzbot+5bbe234204453085d43e@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1442c149400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5bbe234204453085d43e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fb118e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169f48be400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5bbe234204453085d43e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x37c2/0x4ec0  
kernel/locking/lockdep.c:3291
Read of size 8 at addr ffff8801be270b88 by task syz-executor843/16792

CPU: 0 PID: 16792 Comm: syz-executor843 Not tainted 4.19.0-rc2+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x37c2/0x4ec0 kernel/locking/lockdep.c:3291
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  psock_map_pop.isra.22+0x93/0x3b0 kernel/bpf/sockmap.c:298
  bpf_tcp_close+0x6ca/0x10c0 kernel/bpf/sockmap.c:380
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:457
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1139
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4063c1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 b4 17 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffdfa87cf10 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000004063c1
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000003
RBP: 00000000006ddc30 R08: 00000000006ddc30 R09: 0000000000406c00
R10: 00007ffdfa87cf30 R11: 0000000000000293 R12: 00000000006ddc3c
R13: 00000000000003e8 R14: 0000000000000004 R15: 000000000000002d

Allocated by task 16796:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_node_trace+0x14c/0x740 mm/slab.c:3663
  kmalloc_node include/linux/slab.h:551 [inline]
  kzalloc_node include/linux/slab.h:718 [inline]
  smap_init_psock kernel/bpf/sockmap.c:1614 [inline]
  __sock_map_ctx_update_elem.isra.23+0x7a9/0x12f0 kernel/bpf/sockmap.c:1918
  sock_map_ctx_update_elem.isra.24+0x1a3/0xbe0 kernel/bpf/sockmap.c:1983
  sock_map_update_elem+0x22a/0x5a0 kernel/bpf/sockmap.c:2109
  map_update_elem+0x753/0xd50 kernel/bpf/syscall.c:799
  __do_sys_bpf kernel/bpf/syscall.c:2363 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2334 [inline]
  __x64_sys_bpf+0x32d/0x510 kernel/bpf/syscall.c:2334
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 14:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  smap_gc_work+0x910/0xc70 kernel/bpf/sockmap.c:1607
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

The buggy address belongs to the object at ffff8801be270940
  which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 584 bytes inside of
  1024-byte region [ffff8801be270940, ffff8801be270d40)
The buggy address belongs to the page:
page:ffffea0006f89c00 count:1 mapcount:0 mapping:ffff8801da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006fa1408 ffffea0006f8ea08 ffff8801da800ac0
raw: 0000000000000000 ffff8801be270040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801be270a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801be270b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801be270b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8801be270c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801be270c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
