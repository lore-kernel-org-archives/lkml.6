Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B144C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250FC20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250FC20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeILGPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:15:02 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:55291 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeILGPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:15:00 -0400
Received: by mail-it0-f72.google.com with SMTP id r19-v6so1182814itc.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 18:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fQnNfgQHtxUu+01DeZpeJQHyJ40CAjCw7FiAJIEKFa0=;
        b=brFTVrl1K9YOwz9kQjxwAshYnwOJrjezq6/zQ+swVdfr75U3YtgfoiGls8FuPf6k/w
         pxu2yLbO+C+MM7rxtI5ctBbErR8AFQjfNVUEND2p2GYsGkLEQB9B0RGbNvMzHkP4zDkX
         NUj11U05MI7/3jknabaGSRir+gOlB8VymieqMjYIiOXbl2R7rfymfQQbJSSbPEU+Bw9f
         111vAv04liAN+tuRPZ+p+l6twxM8EDEzMV2tGmqdiD1BQ2rX5nPjpRpOZTDN+2LAYBye
         SoAeYGQwCIwNnT6ppD9NOm6J1Re3NTZ6w/tszbsvbPYDsvmnSb99ITESVet3pmiQqgAm
         DWzA==
X-Gm-Message-State: APzg51AlqQZd/Go5jodxlABAsObdWOz8FcbwPMJErq1Y3G0feWsw19o2
        sK6DLxpo4PQvZTH9RsCFbydmhcJyeB7kNEiDUfX5N/k9IlSa
X-Google-Smtp-Source: ANB0Vda4ekfhCdE6l0d5DoFA0H37X7CNn3F6k5LDvVE4SZkn/n0JlP1P3OTF9WJDDz0LtLVIODhG4N/mYASwDKcWyX1EkeRQSnlL
MIME-Version: 1.0
X-Received: by 2002:a24:364e:: with SMTP id l75-v6mr3659005itl.46.1536714782670;
 Tue, 11 Sep 2018 18:13:02 -0700 (PDT)
Date:   Tue, 11 Sep 2018 18:13:02 -0700
In-Reply-To: <000000000000fca96a057543ecea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be0a7a0575a24a7b@google.com>
Subject: Re: KASAN: use-after-free Read in cma_bind_port
From:   syzbot <syzbot+da2591e115d57a9cbb8b@syzkaller.appspotmail.com>
To:     danielj@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11766c69400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=da2591e115d57a9cbb8b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1686969e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+da2591e115d57a9cbb8b@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
hrtimer: interrupt took 34369 ns
==================================================================
BUG: KASAN: use-after-free in cma_bind_port+0x35d/0x420  
drivers/infiniband/core/cma.c:3059
Read of size 2 at addr ffff8801b7b056a0 by task syz-executor3/7271

CPU: 1 PID: 7271 Comm: syz-executor3 Not tainted 4.19.0-rc3+ #231
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:431
  cma_bind_port+0x35d/0x420 drivers/infiniband/core/cma.c:3059
  cma_alloc_port+0x115/0x180 drivers/infiniband/core/cma.c:3095
  cma_alloc_any_port drivers/infiniband/core/cma.c:3160 [inline]
  cma_get_port drivers/infiniband/core/cma.c:3314 [inline]
  rdma_bind_addr+0x1765/0x23d0 drivers/infiniband/core/cma.c:3434
  cma_bind_addr drivers/infiniband/core/cma.c:2963 [inline]
  rdma_resolve_addr+0x4e2/0x2770 drivers/infiniband/core/cma.c:2974
  ucma_resolve_ip+0x242/0x2a0 drivers/infiniband/core/ucma.c:711
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572d9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f71074b0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f71074b16d4 RCX: 00000000004572d9
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000008
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d83c0 R14: 00000000004c1e90 R15: 0000000000000000

Allocated by task 7285:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  __rdma_create_id+0xdf/0x790 drivers/infiniband/core/cma.c:782
  ucma_create_id+0x39b/0x990 drivers/infiniband/core/ucma.c:502
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7261:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  rdma_destroy_id+0x835/0xcc0 drivers/infiniband/core/cma.c:1737
  ucma_close+0x100/0x300 drivers/infiniband/core/ucma.c:1759
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801b7b05680
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 32 bytes inside of
  2048-byte region [ffff8801b7b05680, ffff8801b7b05e80)
The buggy address belongs to the page:
page:ffffea0006dec100 count:1 mapcount:0 mapping:ffff8801da800c40  
index:0xffff8801b7b04580 compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006debf88 ffffea0006deb708 ffff8801da800c40
raw: ffff8801b7b04580 ffff8801b7b04580 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b7b05580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b7b05600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801b7b05680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8801b7b05700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b7b05780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

