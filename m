Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202BC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287C9206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287C9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeILSNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:13:30 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40507 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeILSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:13:30 -0400
Received: by mail-io1-f71.google.com with SMTP id p22-v6so131290ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Up1ZBFj9ZHsnOaXG/rleKS0SS55ES9QHndldr5sx1FM=;
        b=WbN82v3aGQzZKR0Bf4w0GnmxrcB7aXcwSQG8RfezJIC40JtEKmGQ6NScQAZeSPRCeu
         FnNsakkOGfC2DLXzw90qirDIREtl6E5ak1OZyQIE+owX8GZXwUrtyBefHi+9vdKoYkw3
         FD055y+YCaY4z2LtNZWVlBERs1op0AErYuWQyzUWOHSHV8jxLOh4s28VDEBsXLcbH+t5
         uWAVQrXpK1dTdop69dPu/iNmU1M8geWtO2BzaistgGUwDDSTdp0D7CavoMWo6KMFXP31
         54o1TflGSFu7pOzeN6zilnAQOaBwa7WUMgNN4LImFJpS3n4mHpULVTkZ46V3bOvNgyyW
         fSgA==
X-Gm-Message-State: APzg51AOmycCxJgkmttu9hPj2/6Pp5r5xm/+czWjUrJyLXPzxbqJUpDC
        25HY8pxIvhTuz0+NDfvPP0HPjPtEHwVCJJVS7MK3KdXkQ3hU
X-Google-Smtp-Source: ANB0VdZ+GhPVWiGIdsvIioKVxPcJ1A4Jjh7et6eiYXEmz+nDhMa+64JHIvgo5dqqhmMlPAPHNkJdEUWSGxPV/J0pP4UR/UPaltzZ
MIME-Version: 1.0
X-Received: by 2002:a6b:4511:: with SMTP id s17-v6mr1403687ioa.29.1536757743119;
 Wed, 12 Sep 2018 06:09:03 -0700 (PDT)
Date:   Wed, 12 Sep 2018 06:09:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062763f0575ac4b2f@google.com>
Subject: KASAN: slab-out-of-bounds Read in mqueue_get_tree
From:   syzbot <syzbot+fc036355de0dd1b312b1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, dhowells@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ce5081400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=fc036355de0dd1b312b1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1167ea56400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110b36ae400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fc036355de0dd1b312b1@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: slab-out-of-bounds in mqueue_get_tree+0x2ac/0x2e0  
ipc/mqueue.c:362
Read of size 8 at addr ffff8801d8bce3e0 by task syz-executor656/5564

CPU: 0 PID: 5564 Comm: syz-executor656 Not tainted  
4.19.0-rc3-next-20180912+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  mqueue_get_tree+0x2ac/0x2e0 ipc/mqueue.c:362
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1787
  mq_create_mount+0xe3/0x190 ipc/mqueue.c:415
  mq_init_ns+0x15a/0x210 ipc/mqueue.c:1621
  create_ipc_ns ipc/namespace.c:58 [inline]
  copy_ipcs+0x3d2/0x580 ipc/namespace.c:84
  create_new_namespaces+0x376/0x900 kernel/nsproxy.c:87
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x79c/0x10b0 kernel/fork.c:2535
  __do_sys_unshare kernel/fork.c:2603 [inline]
  __se_sys_unshare kernel/fork.c:2601 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2601
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4447f7
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ed df fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cd df fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe5aa7e2a8 EFLAGS: 00000217 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004447f7
RDX: 0000000000000000 RSI: 00007ffe5aa7e2b0 RDI: 0000000008000000
RBP: 00000000006cc018 R08: 0000000000000000 R09: 00000000019a3880
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000402c50
R13: 0000000000402ce0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 3455:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  kernfs_iop_get_link+0x6d/0x660 fs/kernfs/symlink.c:133
  vfs_readlink+0x2ac/0x4c0 fs/namei.c:4736
  do_readlinkat+0x359/0x410 fs/stat.c:409
  __do_sys_readlink fs/stat.c:430 [inline]
  __se_sys_readlink fs/stat.c:427 [inline]
  __x64_sys_readlink+0x78/0xb0 fs/stat.c:427
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3455:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  kfree_link+0x15/0x20 fs/libfs.c:1123
  do_delayed_call include/linux/delayed_call.h:28 [inline]
  vfs_readlink+0x207/0x4c0 fs/namei.c:4741
  do_readlinkat+0x359/0x410 fs/stat.c:409
  __do_sys_readlink fs/stat.c:430 [inline]
  __se_sys_readlink fs/stat.c:427 [inline]
  __x64_sys_readlink+0x78/0xb0 fs/stat.c:427
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d8bce740
  which belongs to the cache kmalloc-4096 of size 4096
The buggy address is located 864 bytes to the left of
  4096-byte region [ffff8801d8bce740, ffff8801d8bcf740)
The buggy address belongs to the page:
page:ffffea000762f380 count:1 mapcount:0 mapping:ffff8801da800dc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0007628988 ffffea0007623008 ffff8801da800dc0
raw: 0000000000000000 ffff8801d8bce740 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d8bce280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d8bce300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801d8bce380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                        ^
  ffff8801d8bce400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d8bce480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
