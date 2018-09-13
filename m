Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F03C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF13206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF13206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIMNIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:08:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55577 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeIMNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:08:22 -0400
Received: by mail-io1-f69.google.com with SMTP id m15-v6so3393698ioj.22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 01:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PO3uD1Fjcma/lg5H++QxakEIh54e+O9e0768eqsvji8=;
        b=rideW9hPpzDAFX2+AjQ93x3tXnb2i/8Hz7CoSjRZ+hlqu5tpr9Fb1XumvrCMHitBsq
         dxoIKxvvbUEHsBngGOrIHGWdSmv2Q41AEzHJyDjsfZFGfB9DqwpHJPW2LuX1sSXn6pnj
         GUINC0szzn3+C/ibJ7SgEp/JVl/EG6s9932RdMsL7XA46M+NNQXfJenjv3PxsXLAi6Ac
         2WUNZ1Wub+UNxluYqejCYdS6/GbNK/VSEUmCXTjpjj7GCoMwA2/PBmswe7kNHnRwfAKf
         r7cTH/6a0qAx0wrvSzvZ4BGtKvwRARrVC3ObP29fezsaXTajbis4zyaIaBvcZAZoUwlj
         sHrA==
X-Gm-Message-State: APzg51BDem0nou17xCqAbja4WvxrV2wcessSbMWpIQxEeBwN2Mvz5DIZ
        Vgzapih7R4BeqXpsrKjJXCxd1qGCLPYU5ZYbn0rZHmA27wTz
X-Google-Smtp-Source: ANB0VdZSuP11zhpvWCML4epSzbvYfrh7+Sl3M+4b3Za4jyKZJXx8i54My7pW6ocikkCHV2JxCDfLpQ2IsSdtigphLujaQiNgkzgy
MIME-Version: 1.0
X-Received: by 2002:a6b:4919:: with SMTP id u25-v6mr4788354iob.0.1536825602473;
 Thu, 13 Sep 2018 01:00:02 -0700 (PDT)
Date:   Thu, 13 Sep 2018 01:00:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e09780575bc189a@google.com>
Subject: KASAN: use-after-free Read in fuse_dev_do_read
From:   syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    54eda9df17f3 Merge tag 'pci-v4.19-fixes-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109a3d9e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8f349d23d3c4835
dashboard link: https://syzkaller.appspot.com/bug?extid=4e975615ca01f2277bdd
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in constant_test_bit  
arch/x86/include/asm/bitops.h:328 [inline]
BUG: KASAN: use-after-free in fuse_dev_do_read.isra.27+0x1659/0x1920  
fs/fuse/dev.c:1318
Read of size 8 at addr ffff8801cbd4ea30 by task syz-executor0/28821

CPU: 1 PID: 28821 Comm: syz-executor0 Not tainted 4.19.0-rc3+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
  fuse_dev_do_read.isra.27+0x1659/0x1920 fs/fuse/dev.c:1318
  fuse_dev_read+0x1a9/0x250 fs/fuse/dev.c:1360
  call_read_iter include/linux/fs.h:1801 [inline]
  new_sync_read fs/read_write.c:406 [inline]
  __vfs_read+0x6ac/0x9b0 fs/read_write.c:418
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572d9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007faaeefe4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007faaeefe56d4 RCX: 00000000004572d9
RDX: 0000000000001000 RSI: 00000000200040c0 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4508 R14: 00000000004c8d44 R15: 0000000000000000

Allocated by task 28825:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  __fuse_request_alloc+0x27/0xf0 fs/fuse/dev.c:58
  fuse_request_alloc fs/fuse/dev.c:89 [inline]
  __fuse_get_req+0x1f7/0x9e0 fs/fuse/dev.c:164
  fuse_get_req fs/fuse/dev.c:194 [inline]
  fuse_simple_request+0x28/0x730 fs/fuse/dev.c:549
  fuse_statfs+0x368/0x8a0 fs/fuse/inode.c:442
  statfs_by_dentry+0x136/0x210 fs/statfs.c:64
  vfs_statfs+0x47/0x2e0 fs/statfs.c:74
  user_statfs+0xbd/0x150 fs/statfs.c:89
  __do_sys_statfs+0x7f/0xf0 fs/statfs.c:179
  __se_sys_statfs fs/statfs.c:176 [inline]
  __x64_sys_statfs+0x54/0x80 fs/statfs.c:176
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 28825:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  fuse_request_free+0x8b/0xa0 fs/fuse/dev.c:104
  fuse_put_request+0x2a6/0x350 fs/fuse/dev.c:304
  fuse_simple_request+0x453/0x730 fs/fuse/dev.c:571
  fuse_statfs+0x368/0x8a0 fs/fuse/inode.c:442
  statfs_by_dentry+0x136/0x210 fs/statfs.c:64
  vfs_statfs+0x47/0x2e0 fs/statfs.c:74
  user_statfs+0xbd/0x150 fs/statfs.c:89
  __do_sys_statfs+0x7f/0xf0 fs/statfs.c:179
  __se_sys_statfs fs/statfs.c:176 [inline]
  __x64_sys_statfs+0x54/0x80 fs/statfs.c:176
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801cbd4ea00
  which belongs to the cache fuse_request of size 448
The buggy address is located 48 bytes inside of
  448-byte region [ffff8801cbd4ea00, ffff8801cbd4ebc0)
The buggy address belongs to the page:
page:ffffea00072f5380 count:1 mapcount:0 mapping:ffff8801d4ad4840 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000717eb48 ffff8801d4ad5c48 ffff8801d4ad4840
raw: 0000000000000000 ffff8801cbd4e000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801cbd4e900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801cbd4e980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801cbd4ea00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8801cbd4ea80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801cbd4eb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
