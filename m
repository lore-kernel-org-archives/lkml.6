Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE87C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371122081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371122081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeK2Ema (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:42:30 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:38543 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbeK2Em3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:42:29 -0500
Received: by mail-it1-f200.google.com with SMTP id m128so1313738itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5Sx+HW1+Xe+XwcohN/9Mdg1LyM5kBdQuqbkYiNUIaVY=;
        b=lLx05+05h3wxZZl2q7kPbukHTeH87fXMBfl8E4bIrgvRbNb/44pUTvfmmmJ7iDcNpa
         X5FUvj2k3p1OVrlJghA6faAhzrBUhhvlshawBLDFOv11QFW0jIZQoSI6dIz7dBWtCF1s
         N40kjA0OLBqrAp1P8F4QOLyhFwLmQhLq80EHDbpoCzRjoCEIC9sv00cT7hj+gdsY+9PZ
         DrAxm5Sj9t4FZbRjaoka1uaF1j2Np8E+0RK1GKoPcuyMVgPgqs0Cc6QCibybBDJtoQbK
         QvPBtUZISuwhlL3WEZfPa/xe0MzT74meq3EjlC1BEEw/WlJdKdlEAknH92ok2LMwcxwW
         0DFg==
X-Gm-Message-State: AA+aEWb7RmqP4YTkKDetEJHJ2wW9ZeOWjLgsdf2dYQe7n7l4x8PR2UQk
        3wcq7i0ULH+c44tkimKWAIExctl/qOD1dVR+5yjYTwpxzOAK
X-Google-Smtp-Source: AFSGD/VFb9Rn50cBKKrAPllCIcr0boRHv50V/vQbGuR18vmkd4Tl/60XiVliM3+IASTpXPrCB1cLHTHPX8Oe7HYRAyQYN+o5C7tR
MIME-Version: 1.0
X-Received: by 2002:a24:5f93:: with SMTP id r141mr3121941itb.4.1543426804574;
 Wed, 28 Nov 2018 09:40:04 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:40:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c6fee057bbd0ef3@google.com>
Subject: KASAN: use-after-free Read in trailing_symlink
From:   syzbot <syzbot+a13e5ead792d6df37818@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ef78e5ec9214 ia64: export node_distance function
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c7b08b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=a13e5ead792d6df37818
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13633e47400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a13e5ead792d6df37818@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in get_link fs/namei.c:1089 [inline]
BUG: KASAN: use-after-free in trailing_symlink+0x8ba/0x970 fs/namei.c:2263
Read of size 1 at addr ffff8881d8e4c180 by task syz-executor5/9576

CPU: 1 PID: 9576 Comm: syz-executor5 Not tainted 4.20.0-rc4+ #352
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  get_link fs/namei.c:1089 [inline]
  trailing_symlink+0x8ba/0x970 fs/namei.c:2263
  path_lookupat.isra.43+0x22e/0xc00 fs/namei.c:2319
  filename_lookup+0x26a/0x520 fs/namei.c:2348
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
  user_path include/linux/namei.h:62 [inline]
  do_mount+0x177/0x31f0 fs/namespace.c:2741
  ksys_mount+0x12d/0x140 fs/namespace.c:3017
  __do_sys_mount fs/namespace.c:3031 [inline]
  __se_sys_mount fs/namespace.c:3028 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3028
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff3eff6bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 000000000072bf00 R08: 0000000020000340 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000246 R12: 00007ff3eff6c6d4
R13: 00000000004c2c24 R14: 00000000004d4990 R15: 00000000ffffffff

Allocated by task 9578:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3722 [inline]
  __kmalloc_track_caller+0x157/0x760 mm/slab.c:3737
  kstrdup+0x39/0x70 mm/util.c:49
  bpf_symlink+0x26/0x140 kernel/bpf/inode.c:356
  vfs_symlink+0x37a/0x5d0 fs/namei.c:4127
  do_symlinkat+0x242/0x2d0 fs/namei.c:4154
  __do_sys_symlink fs/namei.c:4173 [inline]
  __se_sys_symlink fs/namei.c:4171 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9579:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  bpf_evict_inode+0x11f/0x150 kernel/bpf/inode.c:565
  evict+0x4b9/0x980 fs/inode.c:558
  iput_final fs/inode.c:1550 [inline]
  iput+0x679/0xa90 fs/inode.c:1576
  do_unlinkat+0x733/0xa30 fs/namei.c:4069
  __do_sys_unlink fs/namei.c:4110 [inline]
  __se_sys_unlink fs/namei.c:4108 [inline]
  __x64_sys_unlink+0x42/0x50 fs/namei.c:4108
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d8e4c180
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8881d8e4c180, ffff8881d8e4c1a0)
The buggy address belongs to the page:
page:ffffea0007639300 count:1 mapcount:0 mapping:ffff8881da8001c0  
index:0xffff8881d8e4cfc1
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0006e27188 ffffea0006d85688 ffff8881da8001c0
raw: ffff8881d8e4cfc1 ffff8881d8e4c000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d8e4c080: 05 fc fc fc fc fc fc fc 00 00 00 00 fc fc fc fc
  ffff8881d8e4c100: 00 00 00 00 fc fc fc fc 04 fc fc fc fc fc fc fc
> ffff8881d8e4c180: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                    ^
  ffff8881d8e4c200: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8881d8e4c280: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
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
