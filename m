Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86070ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20535214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20535214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeIWBYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 21:24:44 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34085 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeIWBYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 21:24:44 -0400
Received: by mail-io1-f70.google.com with SMTP id z20-v6so31598244iol.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 12:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BU6tIqO9+Avm+flN5ZbOKunRi/60W3O9nX61xKvwIrA=;
        b=ZqeJjLgihwTiawwjUNkh8Oc0zabRcQ0GOY1nWquBXs4uKYjbxOM6q6YklsPsrvBxLn
         ep11PPqxqveWcV3NxgTLQiJfJCkisDxN58/az0jtwzXv+/+08TCyAFkwYNVQ8aWPQMCe
         WwuK9WNlhgPlKWtsthOUKVZUs4fA9SYbe7Dryf0EkAqzhkMFzKoUxyCOihqwGUtWjCJI
         WizUcq3lxajTULAPGEXZlFwUd9URZJD+pdt4mBUVbMZT3PYy0g3YNPCzATeacqXAruW7
         Z8/eWnk1xXoEprPca7kCBMmEasIr0AtntWZfgusKl3J/Mkh5u0hxmNwzWxDn1QDZWPd/
         ea8w==
X-Gm-Message-State: ABuFfojegkS3vjjIgYFY3xAaCdceIoUebI8rIR9wvm+f5jjqcJ609NdL
        dnS0El8EEN4BrTFaBcf4MnK74UBocg3x3rtajWBmf26fWqvr
X-Google-Smtp-Source: ACcGV62gDhsWvXgQiAzz+xQyW0iUYZtZOYnk/z8/hi5AsFUZ4RHFiCBwsYykkP+hMdd20C4j30h/KIK1V892oJ2xv+xB90Ze6uOP
MIME-Version: 1.0
X-Received: by 2002:a24:220d:: with SMTP id o13-v6mr2544723ito.28.1537644602931;
 Sat, 22 Sep 2018 12:30:02 -0700 (PDT)
Date:   Sat, 22 Sep 2018 12:30:02 -0700
In-Reply-To: <0000000000001e09780575bc189a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059484105767ac88f@google.com>
Subject: Re: KASAN: use-after-free Read in fuse_dev_do_read
From:   syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    10dc890d4228 Merge tag 'pinctrl-v4.19-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1631cfbe400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=4e975615ca01f2277bdd
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ffb766400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in constant_test_bit  
arch/x86/include/asm/bitops.h:328 [inline]
BUG: KASAN: use-after-free in fuse_dev_do_read.isra.27+0x1659/0x1920  
fs/fuse/dev.c:1318
Read of size 8 at addr ffff8801d8702630 by task syz-executor1/7794

CPU: 0 PID: 7794 Comm: syz-executor1 Not tainted 4.19.0-rc4+ #26
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
  call_read_iter include/linux/fs.h:1802 [inline]
  new_sync_read fs/read_write.c:406 [inline]
  __vfs_read+0x6ac/0x9b0 fs/read_write.c:418
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6a5aeedc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f6a5aeee6d4 RCX: 0000000000457679
RDX: 0000000000001000 RSI: 0000000020001000 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4ad0 R14: 00000000004c31e5 R15: 0000000000000000

Allocated by task 7801:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  __fuse_request_alloc+0x27/0xf0 fs/fuse/dev.c:58
  fuse_request_alloc+0x18/0x20 fs/fuse/dev.c:89
  fuse_fill_super+0x12bf/0x1ea0 fs/fuse/inode.c:1157
  mount_nodev+0x6b/0x110 fs/super.c:1204
  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1213
  mount_fs+0xae/0x31d fs/super.c:1261
  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
  vfs_kern_mount fs/namespace.c:951 [inline]
  do_new_mount fs/namespace.c:2457 [inline]
  do_mount+0x581/0x31f0 fs/namespace.c:2787
  ksys_mount+0x12d/0x140 fs/namespace.c:3003
  __do_sys_mount fs/namespace.c:3017 [inline]
  __se_sys_mount fs/namespace.c:3014 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3014
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7801:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  fuse_request_free+0x8b/0xa0 fs/fuse/dev.c:104
  fuse_put_request+0x2a6/0x350 fs/fuse/dev.c:304
  request_end+0xba/0xaa0 fs/fuse/dev.c:414
  fuse_dev_do_write+0x192e/0x36e0 fs/fuse/dev.c:1915
  fuse_dev_write+0x19a/0x240 fs/fuse/dev.c:1939
  call_write_iter include/linux/fs.h:1808 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d8702600
  which belongs to the cache fuse_request of size 448
The buggy address is located 48 bytes inside of
  448-byte region [ffff8801d8702600, ffff8801d87027c0)
The buggy address belongs to the page:
page:ffffea000761c080 count:1 mapcount:0 mapping:ffff8801d4a0e240 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006ec0e88 ffffea0006ee91c8 ffff8801d4a0e240
raw: 0000000000000000 ffff8801d8702000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d8702500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d8702580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8801d8702600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8801d8702680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801d8702700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

