Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6EDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E7720871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E7720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389864AbeGKQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:44:12 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:49727 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389850AbeGKQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:44:11 -0400
Received: by mail-io0-f198.google.com with SMTP id k9-v6so10381020iob.16
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dKTUTqWPksmGblaKwdqa0HpFpkJQczEkhuMWvdl3Foc=;
        b=trTuuYNnV/S6VORWUkvCatxTkOkh+3Y9Sjp82pWa8YrcuqwmH26pO7hKSzdTHi6xm5
         Zjr2S/keN4mBYKI02U0fDzcdUKdYVc+Gxj9NCKScMlB1nyx+aU6Xtyiv9Ooqb3mcTghY
         NfTo/TLELgYDnH9to2P/ZS8/HcQ7YVzWUWNlKB7Q2nhAGqHjqRDIIFoNZBT30gJ5h8vW
         B0gCGYACf99y3be6rzspQYB/iitMUgsZTEAfoyBT8nPrC4ytR/xgczMh4PzGl/3/4RI4
         nDi5LbZY5sgdOVGk7S914zmBJLMmT2HDzWO7nQsWendsI3a8mkcDPYlxjQaNG7A8/aTz
         pRUw==
X-Gm-Message-State: AOUpUlGsDBXER9ghgowAiEJo1p4iAleJytJ126cPheYiHn91R6JxE/EZ
        /E1LsTVNo+JyvFkr+nfqOyBNJi4yCPFSjUAeMsRaZyb9mqnC
X-Google-Smtp-Source: AAOMgpcQLeWFPG3NZ4bAl3wNBl7jcz2btf6bMeWpTgZNFSEmPqdsROHimOCF5VC3PBTKMRUpWvKUu/DHX9N8ctsqXOWT+QE3dpQp
MIME-Version: 1.0
X-Received: by 2002:a6b:9386:: with SMTP id v128-v6mr13191599iod.27.1531327142568;
 Wed, 11 Jul 2018 09:39:02 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:39:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e2bf90570bbe2ab@google.com>
Subject: KASAN: use-after-free Read in ep_scan_ready_list
From:   syzbot <syzbot+78b902c73c69102cb767@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    98be45067040 Add linux-next specific files for 20180711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10de4efc400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f3b3673fec35d01
dashboard link: https://syzkaller.appspot.com/bug?extid=78b902c73c69102cb767
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13d5291c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed430c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+78b902c73c69102cb767@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: use-after-free in atomic64_read  
include/asm-generic/atomic-instrumented.h:27 [inline]
BUG: KASAN: use-after-free in atomic_long_read  
include/asm-generic/atomic-long.h:47 [inline]
BUG: KASAN: use-after-free in __mutex_trylock_or_owner  
kernel/locking/mutex.c:84 [inline]
BUG: KASAN: use-after-free in __mutex_trylock kernel/locking/mutex.c:125  
[inline]
BUG: KASAN: use-after-free in __mutex_lock_common  
kernel/locking/mutex.c:927 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0x185/0x1680  
kernel/locking/mutex.c:1073
Read of size 8 at addr ffff8801c62d85b8 by task kworker/0:2/2137

CPU: 0 PID: 2137 Comm: kworker/0:2 Not tainted 4.18.0-rc4-next-20180711+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic64_read include/asm-generic/atomic-instrumented.h:27 [inline]
  atomic_long_read include/asm-generic/atomic-long.h:47 [inline]
  __mutex_trylock_or_owner kernel/locking/mutex.c:84 [inline]
  __mutex_trylock kernel/locking/mutex.c:125 [inline]
  __mutex_lock_common kernel/locking/mutex.c:927 [inline]
  __mutex_lock+0x185/0x1680 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  ep_scan_ready_list+0xb77/0xf50 fs/eventpoll.c:681
  ep_eventpoll_poll+0x192/0x200 fs/eventpoll.c:937
  vfs_poll include/linux/poll.h:86 [inline]
  p9_fd_poll+0x1ce/0x2b0 net/9p/trans_fd.c:248
  p9_poll_mux net/9p/trans_fd.c:617 [inline]
  p9_poll_workfn+0x463/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415

Allocated by task 4472:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  ep_alloc fs/eventpoll.c:1016 [inline]
  do_epoll_create+0x170/0x5c0 fs/eventpoll.c:1952
  __do_sys_epoll_create1 fs/eventpoll.c:1983 [inline]
  __se_sys_epoll_create1 fs/eventpoll.c:1981 [inline]
  __x64_sys_epoll_create1+0x31/0x40 fs/eventpoll.c:1981
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4472:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  ep_free+0x273/0x310 fs/eventpoll.c:856
  ep_eventpoll_release+0x44/0x60 fs/eventpoll.c:864
  __fput+0x35d/0x930 fs/file_table.c:252
  ____fput+0x15/0x20 fs/file_table.c:288
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:869
  do_group_exit+0x177/0x440 kernel/exit.c:972
  get_signal+0x88e/0x1970 kernel/signal.c:2467
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801c62d8580
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 56 bytes inside of
  512-byte region [ffff8801c62d8580, ffff8801c62d8780)
The buggy address belongs to the page:
page:ffffea000718b600 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006b54dc8 ffffea000764a188 ffff8801da800940
raw: 0000000000000000 ffff8801c62d8080 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c62d8480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c62d8500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801c62d8580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                         ^
  ffff8801c62d8600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c62d8680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
