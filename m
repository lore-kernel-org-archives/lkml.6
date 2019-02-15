Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9CEC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F08F21B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfBOFZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:25:07 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:43124 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfBOFZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:25:04 -0500
Received: by mail-it1-f197.google.com with SMTP id i186so13221853ite.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hJdkFZ6qFZ6er5I7bR5BaOfqFCLXVJQcTaYE9MIUAgI=;
        b=Lw5ri4BhGABZ2+IWirO8ZKOZN8XtEfUxiOaAG3isOZw0qkj6hlrIjXYUMW4QQKDZZh
         p29jg3NGL0iWmU22zQrRM8ngjkGeKPy44yrYcE1wDonYfRm0gRSYfWbN9bdCYZoBIHh8
         9+bl9pIkVbAyomFgU+xOCzvoBoLPPUH2bd+OL4g3bdXq+BrfAzvW0g4xx/DiuPD+OwMv
         IyQQrlywvmFk+t1mby5u8F100MBCkhIe9GTKRul2ABXQoZQr9GnORnANwd3/DypNKSxk
         MN+IKkr+8VGFn/a6tzy40C1Lg536L6GDIigu+RgTUqvqgNRvXp4i30pFUwc4+o1d2Z9K
         Gg4A==
X-Gm-Message-State: AHQUAubhm3aGqtCpRjT2pobjal8fpQomfvbycMaSrWvLHoCk/PPPsCfx
        o05RJVvSdeBq50hT0T24M0dNjNd+2ulllGxMIGgPHVILSYkH
X-Google-Smtp-Source: AHgI3IYOvmtrTyq8pCJzAO0c/+ewuuC9QgFPmXkuSlM2xUbIHT0QlnPpY+Dn5zdgKIJCCH2nqOdnZSFPatxq8uC80kBto852/C9V
MIME-Version: 1.0
X-Received: by 2002:a24:244:: with SMTP id 65mr4740331itu.3.1550208303700;
 Thu, 14 Feb 2019 21:25:03 -0800 (PST)
Date:   Thu, 14 Feb 2019 21:25:03 -0800
In-Reply-To: <0000000000007a5aad057e7748c9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004527440581e7ff1a@google.com>
Subject: Re: KASAN: use-after-free Read in lock_sock_nested
From:   syzbot <syzbot+500c69d1e21d970e461b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b3418f8bddf4 Add linux-next specific files for 20190214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f63047400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a3a37525a677c71
dashboard link: https://syzkaller.appspot.com/bug?extid=500c69d1e21d970e461b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b08da7400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+500c69d1e21d970e461b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3150/0x4710  
kernel/locking/lockdep.c:3200
Read of size 8 at addr ffff8880195faa60 by task syz-executor.4/7495

CPU: 1 PID: 7495 Comm: syz-executor.4 Not tainted 5.0.0-rc6-next-20190214  
#35
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __lock_acquire+0x3150/0x4710 kernel/locking/lockdep.c:3200
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3833
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  lock_sock_nested+0x41/0x120 net/core/sock.c:2878
  lock_sock include/net/sock.h:1507 [inline]
  nr_accept+0x200/0x790 net/netrom/af_netrom.c:808
  __sys_accept4+0x350/0x6a0 net/socket.c:1610
  __do_sys_accept net/socket.c:1651 [inline]
  __se_sys_accept net/socket.c:1648 [inline]
  __x64_sys_accept+0x75/0xb0 net/socket.c:1648
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f16cb51ec78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f16cb51f6d4
R13: 00000000004bdbf0 R14: 00000000004cde80 R15: 00000000ffffffff

Allocated by task 7492:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc mm/slab.c:3721 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3730
  kmalloc include/linux/slab.h:553 [inline]
  sk_prot_alloc+0x19c/0x2e0 net/core/sock.c:1573
  sk_alloc+0x39/0xf70 net/core/sock.c:1627
  nr_create+0xb9/0x5e0 net/netrom/af_netrom.c:436
  __sock_create+0x3e6/0x750 net/socket.c:1297
  sock_create net/socket.c:1337 [inline]
  __sys_socket+0x103/0x220 net/socket.c:1367
  __do_sys_socket net/socket.c:1376 [inline]
  __se_sys_socket net/socket.c:1374 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1374
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7491:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3491 [inline]
  kfree+0xcf/0x230 mm/slab.c:3816
  sk_prot_free net/core/sock.c:1610 [inline]
  __sk_destruct+0x4f1/0x6d0 net/core/sock.c:1692
  sk_destruct+0x7b/0x90 net/core/sock.c:1700
  __sk_free+0xce/0x300 net/core/sock.c:1711
  sk_free+0x42/0x50 net/core/sock.c:1722
  sock_put include/net/sock.h:1708 [inline]
  nr_release+0x337/0x3c0 net/netrom/af_netrom.c:557
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1161
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880195fa9c0
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 160 bytes inside of
  2048-byte region [ffff8880195fa9c0, ffff8880195fb1c0)
The buggy address belongs to the page:
page:ffffea0000657e80 count:1 mapcount:0 mapping:ffff88812c3f0c40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00026f8a88 ffffea000220c888 ffff88812c3f0c40
raw: 0000000000000000 ffff8880195fa140 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880195fa900: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8880195fa980: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8880195faa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8880195faa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880195fab00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

