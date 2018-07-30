Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2D913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0B620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0B620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbeG3PyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:54:19 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:53912 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeG3PyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:54:18 -0400
Received: by mail-it0-f72.google.com with SMTP id e5-v6so12689597itf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gXVCbZb//gaJgQDy/SOHndy+B0izI8gS/8WFL3TVC9s=;
        b=LMzhx7zWU80IS7I7TCRWIcvHWW/3D12ZBG0Z39Adt+VWOvm8SOz4KPFXuu2gXw25EE
         Aco4DINMHDTN5PdpGdxaOOLSzwv2g1thPW1lh+nKQd4t28sAWBeMbXoxqbVJt14WrmkV
         nueZLnGfNuXmvzpweZb77zNhuDHLysLQnbImXakLQJxVBF26BfaywxZqKmZh+AOGUgsG
         gaX8fc9jXjRKXRQYjIoCFEDNUptnJmQgLhUP67F8BqkVbTU5eyUp+4hkd/dds/DzP6sy
         ZJrYBARS06KswN+ltI7aydrYwkWHZ4a+ksmODyVG2lYXKUwocUCQZRSUjnZ/Z28obp3H
         5vaA==
X-Gm-Message-State: AOUpUlFqZHAOrS90lTfmJBcLeN49eKY1WOf4ajk0wevg+H1abutf8ZNY
        m3zdUAsGP7gkAQm+cRlee/OJROXTrusITYKWXY7O0gVY2cad
X-Google-Smtp-Source: AAOMgpdr97+QTfHoNNv+IsBggkBjrLeFzX/+HhAlmLTQiAoRdMxfiP3/Lr2shxe4iDGr/f7sHTr1Y4UQQRoNFeBexjqAVZs8V3mZ
MIME-Version: 1.0
X-Received: by 2002:a24:5a14:: with SMTP id v20-v6mr7969913ita.41.1532960344669;
 Mon, 30 Jul 2018 07:19:04 -0700 (PDT)
Date:   Mon, 30 Jul 2018 07:19:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc883b05723824b2@google.com>
Subject: KASAN: slab-out-of-bounds Read in sock_hash_ctx_update_elem
From:   syzbot <syzbot+4207b2e0c72d65cc775d@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a26fb01c2879 Merge tag 'random_for_linus_stable' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10200bb2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
dashboard link: https://syzkaller.appspot.com/bug?extid=4207b2e0c72d65cc775d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1545ed62400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10307368400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4207b2e0c72d65cc775d@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
nf_conntrack: default automatic helper assignment has been turned off for  
security reasons and CT-based  firewall rule not found. Use the iptables CT  
target to attach helpers instead.
==================================================================
BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x3829/0x5020  
kernel/locking/lockdep.c:3314
Read of size 8 at addr ffff8801ad925e08 by task syz-executor884/4438

CPU: 0 PID: 4438 Comm: syz-executor884 Not tainted 4.18.0-rc6+ #167
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __lock_acquire+0x3829/0x5020 kernel/locking/lockdep.c:3314
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:315 [inline]
  sock_hash_ctx_update_elem.isra.26+0xbef/0x14d0 kernel/bpf/sockmap.c:2381
  sock_hash_update_elem+0x1e2/0x510 kernel/bpf/sockmap.c:2428
  map_update_elem+0x72d/0xcb0 kernel/bpf/syscall.c:741
  __do_sys_bpf kernel/bpf/syscall.c:2298 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2269 [inline]
  __x64_sys_bpf+0x32d/0x510 kernel/bpf/syscall.c:2269
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440449
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd721a7e58 EFLAGS: 00000203 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440449
RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000203 R12: 0000000000401cd0
R13: 0000000000401d60 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4438:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  kcm_attach net/kcm/kcmsock.c:1405 [inline]
  kcm_attach_ioctl net/kcm/kcmsock.c:1490 [inline]
  kcm_ioctl+0xd10/0x1930 net/kcm/kcmsock.c:1696
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:969
  sock_ioctl+0x30d/0x680 net/socket.c:1093
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801ad925bc0
  which belongs to the cache kcm_psock_cache of size 544
The buggy address is located 40 bytes to the right of
  544-byte region [ffff8801ad925bc0, ffff8801ad925de0)
The buggy address belongs to the page:
page:ffffea0006b64900 count:1 mapcount:0 mapping:ffff8801cde561c0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffff8801cdf31448 ffff8801cdf31448 ffff8801cde561c0
raw: 0000000000000000 ffff8801ad924040 000000010000000b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ad925d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801ad925d80: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> ffff8801ad925e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                       ^
  ffff8801ad925e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801ad925f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
