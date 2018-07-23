Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D606D20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D606D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbeGWUnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:43:45 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:34197 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeGWUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:43:45 -0400
Received: by mail-it0-f70.google.com with SMTP id k204-v6so9036742ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 12:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Oa9XU1EpT0UekDWqk3aPDGzuS/uTKHA9UwP3Ggp9ofI=;
        b=cGZ/wBhoyD4U1UxUt+VVGax+T4aA547Z3qFhx042lQJhrmgEoh2iNy9bal69qsBXvw
         NADEJQje5Sp9V1HEK0VbIdvbgNTElYWEmqleUJEyDsnG7QTJ0Jltn2BOz3tqHAWyhi8h
         7nMdSgGxcmgp447lhOL75tVqzPLzd2hYjtDFfqjtddX4VR9M9taWgZd+ZZu9HmvhLR+C
         MnY+8taMJNeGZ0O6LRjUNIn/10GV8ixyx+wy4XOkT8UKoD1oBiYg85LlIaGfkCAC8Lnq
         IQdZde0MpJnmigW03sJnKM3YQYjAIgSfji1GUeAIO5TuiifohMqeKUe8Lfin+fsvqsLJ
         2Okg==
X-Gm-Message-State: AOUpUlE8CFiuLt33CGYPJOVUNgf68IXPT4pWxEzSkmrBSrWH5EIn87O7
        jDyWRVi9mlF2wsRisMWCFFQ+1mbnmWsSsi6GHPaQo25w2scK
X-Google-Smtp-Source: AAOMgpeKfxm/kMbIk/NzzdHCaPI9ZamRxjtD7ODQVp18VO93FPWGI0uv7TuJibYL9MtpigxdOQ8a5f7pAUFOy5SFfuJfy+EH2tR9
MIME-Version: 1.0
X-Received: by 2002:a24:44c8:: with SMTP id o191-v6mr164174ita.1.1532374861993;
 Mon, 23 Jul 2018 12:41:01 -0700 (PDT)
Date:   Mon, 23 Jul 2018 12:41:01 -0700
In-Reply-To: <000000000000afbebb0570be9bf3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fe3d80571afd3b9@google.com>
Subject: Re: KASAN: use-after-free Read in p9_fd_poll
From:   syzbot <syzbot+0442e6e2f7e1e33b1037@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    d72e90f33aa4 Linux 4.18-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161894c8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
dashboard link: https://syzkaller.appspot.com/bug?extid=0442e6e2f7e1e33b1037
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1569b51c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e7a978400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0442e6e2f7e1e33b1037@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: use-after-free in p9_fd_poll+0x280/0x2b0 net/9p/trans_fd.c:238
Read of size 8 at addr ffff8801d6ddf340 by task kworker/0:2/26

CPU: 0 PID: 26 Comm: kworker/0:2 Not tainted 4.18.0-rc6+ #160
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  p9_fd_poll+0x280/0x2b0 net/9p/trans_fd.c:238
  p9_poll_mux net/9p/trans_fd.c:617 [inline]
  p9_poll_workfn+0x463/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 4581:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  p9_fd_open net/9p/trans_fd.c:796 [inline]
  p9_fd_create+0x1a7/0x3f0 net/9p/trans_fd.c:1036
  p9_client_create+0x8ed/0x1770 net/9p/client.c:1063
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4581:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xa9a/0x1770 net/9p/client.c:1077
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d6ddf340
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
  512-byte region [ffff8801d6ddf340, ffff8801d6ddf540)
The buggy address belongs to the page:
page:ffffea00075b77c0 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007398548 ffffea0006c59188 ffff8801da800940
raw: 0000000000000000 ffff8801d6ddf0c0 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d6ddf200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d6ddf280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8801d6ddf300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                            ^
  ffff8801d6ddf380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d6ddf400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

