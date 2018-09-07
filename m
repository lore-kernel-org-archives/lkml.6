Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FEA206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FEA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeIGMks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:40:48 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:42563 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeIGMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:40:48 -0400
Received: by mail-it0-f70.google.com with SMTP id 20-v6so18524722itb.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YEHfSTvo/vh2qJRRH4n/isWeHSWV0tCwMxJT9pn/imQ=;
        b=uiMOZhZSRS0bWuu9SLpYX5BN4+rNzVuF3I0qumJO6PNgmoqIZPz8KF/U7gbQDBdgwX
         Y4GswQ96GP4NVc9UPgOcJszAm1HlqZ48useXIRl823Ju84AnhQbh69QVXeIAF7p2xZ6q
         QxZ3hgxHq7sOSpaOFcpr9Kdu6bZ85I/F5NRtwHWJ4pIHlgNj7m220LZ44ipvH63gOSiA
         awhiruVbMs5BxCwQkJ7oFZWRTAYrtom2yaQ+9sxtztreoVEkMromNXKeJaG/w6/XtV9j
         Psxsz9aWXmMeWMa/tjPFkIHm5u222TzDo92y1/1KjcFPbThOv9DByBSAT2bQpwZMxJXm
         D2UA==
X-Gm-Message-State: APzg51AHRixvEhsMKOEnPH4Ref2QX3+2T9jracGTxYlrG4mWujaB5oeL
        yt27j5oBD2ZmfEFBU+ScfSiAUfackUXYOSrBddkjoNmNps2u
X-Google-Smtp-Source: ANB0VdaoTbqDHtdsgs5kj3Kdi982SlSATL+9XI/QVETRdgaa0tbAflW/ZmGHieNTK38XSCsW72xtxKf6ZMI7CB25u5V0CZak22v9
MIME-Version: 1.0
X-Received: by 2002:a24:9f84:: with SMTP id c126-v6mr5753623ite.29.1536307263273;
 Fri, 07 Sep 2018 01:01:03 -0700 (PDT)
Date:   Fri, 07 Sep 2018 01:01:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b18a4605754368bd@google.com>
Subject: KASAN: use-after-free Write in ucma_put_ctx
From:   syzbot <syzbot+cfe3c1e8ef634ba8964b@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, roland@purestorage.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a18421400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c9564cd177daf0c
dashboard link: https://syzkaller.appspot.com/bug?extid=cfe3c1e8ef634ba8964b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154f2056400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cfe3c1e8ef634ba8964b@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
hrtimer: interrupt took 27351 ns
==================================================================
BUG: KASAN: use-after-free in atomic_dec_and_test  
include/asm-generic/atomic-instrumented.h:259 [inline]
BUG: KASAN: use-after-free in ucma_put_ctx+0x1d/0x60  
drivers/infiniband/core/ucma.c:158
Write of size 4 at addr ffff8801d9193858 by task syz-executor0/5348

CPU: 1 PID: 5348 Comm: syz-executor0 Not tainted 4.19.0-rc2+ #224
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_dec_and_test include/asm-generic/atomic-instrumented.h:259 [inline]
  ucma_put_ctx+0x1d/0x60 drivers/infiniband/core/ucma.c:158
  ucma_resolve_ip+0x24d/0x2a0 drivers/infiniband/core/ucma.c:713
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f95c9f42c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f95c9f436d4 RCX: 0000000000457099
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d8100 R14: 00000000004c1c28 R15: 0000000000000001

Allocated by task 5348:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x730 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  ucma_alloc_ctx+0xd5/0x670 drivers/infiniband/core/ucma.c:205
  ucma_create_id+0x276/0x9d0 drivers/infiniband/core/ucma.c:496
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5344:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  ucma_free_ctx+0x9e2/0xe20 drivers/infiniband/core/ucma.c:595
  ucma_close+0x10d/0x300 drivers/infiniband/core/ucma.c:1764
  __fput+0x38a/0xa40 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d9193800
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 88 bytes inside of
  256-byte region [ffff8801d9193800, ffff8801d9193900)
The buggy address belongs to the page:
page:ffffea00076464c0 count:1 mapcount:0 mapping:ffff8801dac007c0 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007658488 ffffea000766a688 ffff8801dac007c0
raw: 0000000000000000 ffff8801d9193080 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d9193700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801d9193780: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d9193800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                     ^
  ffff8801d9193880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d9193900: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
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
