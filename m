Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDFAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C87208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C87208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbeGIRUK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:20:10 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:43248 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933710AbeGIRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:20:02 -0400
Received: by mail-it0-f72.google.com with SMTP id n68-v6so10571063ite.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KdF0QkKiD2ALmbp3/SsE1Q87rjOdyVVuw7rt22JZsBs=;
        b=rATPljYVZnbl/KD46Fxdc9a9nSZiiT868hXqIeB0qHMBCXBnIvV91wv0439NbcmARm
         Fy8/NmZpQr0PF0DHPhiGU3o9cOAA/QcTPo91QGzjIbhxvQh3Tcp4LprZMAgtmhAsnsY5
         sEaL2JrLUvJKn4tuEWRN/FRmY6quMZffgF4dlAcp8zb0awr3IbW5ynX0P5Qj9fdZ4Y0g
         wISVIoao59w7GZ4TIzw9oms3Rtevxbv/BqMXfSnihlJZUEs/7mp6fsila2FgDbFYJd2Y
         PwQ9vbN0+yUrQPp8VimrKpGZvEZ4yqE0VbrRKh1zdQOKfPqu8dsPZKibo+VfIXISrKD3
         xhPw==
X-Gm-Message-State: APt69E3Zc5h7IWsxxblKMny3K6N0YTMjEg0DSFXJHV3wnY28hTX6fe/I
        lLpW4nK/AqQ4fpF5I9aB8xY2Yk9Cvzv0xOf+EsLz6evkJfGG
X-Google-Smtp-Source: AAOMgpcVadcahtRAvMCbYr00iSxYxAwKQBtW1NVzMiMJT4xPJ8/S71AvZcx1UgHQRf2FUAJFosrmNZy+LpQ/sg9WDUo74LAvgdMP
MIME-Version: 1.0
X-Received: by 2002:a24:700a:: with SMTP id f10-v6mr6841985itc.40.1531156802226;
 Mon, 09 Jul 2018 10:20:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 10:20:02 -0700
In-Reply-To: <000000000000d13b2e05708a9ca0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ad7050570943900@google.com>
Subject: Re: KASAN: use-after-free Read in p9_conn_cancel
From:   syzbot <syzbot+f0fdc967350bd580a80b@syzkaller.appspotmail.com>
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

HEAD commit:    1e4b044d2251 Linux 4.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d5ba2c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=f0fdc967350bd580a80b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=179f4f48400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aba452400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f0fdc967350bd580a80b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in p9_conn_cancel+0x9de/0xd30  
net/9p/trans_fd.c:207
Read of size 4 at addr ffff8801b075c2e8 by task kworker/1:2/4574

CPU: 1 PID: 4574 Comm: kworker/1:2 Not tainted 4.18.0-rc4+ #41
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_poll_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  p9_conn_cancel+0x9de/0xd30 net/9p/trans_fd.c:207
  p9_poll_mux net/9p/trans_fd.c:620 [inline]
  p9_poll_workfn+0x4b2/0x6d0 net/9p/trans_fd.c:1107
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Allocated by task 4689:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  p9_fd_open net/9p/trans_fd.c:796 [inline]
  p9_fd_create+0x1a7/0x3f0 net/9p/trans_fd.c:1036
  p9_client_create+0x915/0x16c9 net/9p/client.c:1062
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  __do_compat_sys_mount fs/compat.c:125 [inline]
  __se_compat_sys_mount fs/compat.c:92 [inline]
  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 4689:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  __do_compat_sys_mount fs/compat.c:125 [inline]
  __se_compat_sys_mount fs/compat.c:92 [inline]
  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

The buggy address belongs to the object at ffff8801b075c2c0
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 40 bytes inside of
  512-byte region [ffff8801b075c2c0, ffff8801b075c4c0)
The buggy address belongs to the page:
page:ffffea0006c1d700 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006cc1c88 ffffea0006c48288 ffff8801da800940
raw: 0000000000000000 ffff8801b075c040 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b075c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b075c200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8801b075c280: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                           ^
  ffff8801b075c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b075c380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

