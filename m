Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB198C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FF520864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FF520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeK2Emb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:42:31 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52827 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbeK2Em3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:42:29 -0500
Received: by mail-io1-f70.google.com with SMTP id h7so26451379iof.19
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FQUsAdUS7QGzoPpoTSYPl+uHCYFuM5gPba+Gw3Z9JdY=;
        b=SZ3wJbkUiTBvIRPl3OBEcB7vnK9XT7yeXv4edR3tHYcLw02Nqnq2utT4g0WqpZhOaf
         oaYYI1bnAJeniDfj+le66c0fjbAHAEElSNUOyGJN2iQwzYz8d7HY/ESFqAIfyEyvcarJ
         n2IbUP2mBIHigQhb8Xf1mYMYa+nEbQ1ntrUln7eHx5xxEmenRB7SSAEOWZfBDDAPuDeI
         eJSB8vVJhY8AVV6WOEhzLeSE6H5IPO+k+GkAkND0HHLFnYfXQlBgtyA7O0mw7ichbNFB
         +W46negRXKWtu1qL6eCuIRXKJsESKCkbA3XRlYrl+XcyqMfiXewsZ4KDFY+9iJoEWAP5
         xyzQ==
X-Gm-Message-State: AA+aEWYsN42I9wZS5t3Mp95TKhsHZuz+Vav0BlQmu1HugyyJgSTPBrIW
        gdXSswHYLb944EUrIB7AZs1ZLXz+fchq1VSN4ulXuYBL6IuT
X-Google-Smtp-Source: AFSGD/XpYM9KNj92DWYm212Cf0Ph/w+WeuCy4dVvRkxqai5hy/v4hpfD5M1eW/7F9u6XAXG7f+AiR106GlY1iGxjKeJplIsHP3gu
MIME-Version: 1.0
X-Received: by 2002:a5d:8347:: with SMTP id q7mr4359538ior.21.1543426804366;
 Wed, 28 Nov 2018 09:40:04 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:40:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006946d2057bbd0eef@google.com>
Subject: KASAN: use-after-free Read in path_lookupat
From:   syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129574db400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=7a8ba368b47fdefca61e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132815f5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in lookup_last fs/namei.c:2269 [inline]
BUG: KASAN: use-after-free in path_lookupat.isra.43+0x9f8/0xc00  
fs/namei.c:2318
Read of size 1 at addr ffff8801c4865c47 by task syz-executor2/9423

CPU: 0 PID: 9423 Comm: syz-executor2 Not tainted 4.20.0-rc1-next-20181109+  
#110
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  lookup_last fs/namei.c:2269 [inline]
  path_lookupat.isra.43+0x9f8/0xc00 fs/namei.c:2318
  filename_lookup+0x26a/0x520 fs/namei.c:2348
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
  user_path include/linux/namei.h:62 [inline]
  do_mount+0x180/0x1ff0 fs/namespace.c:2980
  ksys_mount+0x12d/0x140 fs/namespace.c:3258
  __do_sys_mount fs/namespace.c:3272 [inline]
  __se_sys_mount fs/namespace.c:3269 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3269
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fde6ed96c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 000000000072bf00 R08: 0000000020000340 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000246 R12: 00007fde6ed976d4
R13: 00000000004c2c24 R14: 00000000004d4990 R15: 00000000ffffffff

Allocated by task 9424:
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

Freed by task 9425:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  bpf_evict_inode+0x11f/0x150 kernel/bpf/inode.c:565
  evict+0x4b9/0x980 fs/inode.c:558
  iput_final fs/inode.c:1550 [inline]
  iput+0x674/0xa90 fs/inode.c:1576
  do_unlinkat+0x733/0xa30 fs/namei.c:4069
  __do_sys_unlink fs/namei.c:4110 [inline]
  __se_sys_unlink fs/namei.c:4108 [inline]
  __x64_sys_unlink+0x42/0x50 fs/namei.c:4108
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801c4865c40
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 7 bytes inside of
  32-byte region [ffff8801c4865c40, ffff8801c4865c60)
The buggy address belongs to the page:
page:ffffea0007121940 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff8801c4865fc1
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea000763c048 ffffea000762cf08 ffff8801da8001c0
raw: ffff8801c4865fc1 ffff8801c4865000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801c4865b00: fb fb fb fb fc fc fc fc 05 fc fc fc fc fc fc fc
  ffff8801c4865b80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801c4865c00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                            ^
  ffff8801c4865c80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801c4865d00: fb fb fb fb fc fc fc fc 05 fc fc fc fc fc fc fc
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
