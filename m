Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F412AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3462075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3462075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbeGRJ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:26:53 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:44868 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbeGRJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:26:53 -0400
Received: by mail-io0-f200.google.com with SMTP id e8-v6so2859745ioq.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 01:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uMv1oIM6Mdq/vGXgnaHZTqjLPtgJ5vlloO2+4zr2mVs=;
        b=HegQp41GWXrX/xxmPaZPocmTd4uqCjbW8J/0IEm3lKN7jniV6IZiRAvrhW3Gus6lqz
         AmFmvVua+kdPO28UUdawDvYwISR7z2XiMj6FK67c9JNXHRA+rEZKsp1nZAFVssPX4zqf
         BdSc92+zbbBOEbeA6athFzSbRkb9Y6E87ccySoA0cFtzWd9EOwg/pjs+ZJZVIP7CGWLq
         3rv3uhltvr65NsvRC2BDN7NbQxBfQcewRY84BqDGXftcAPhJXM6SFNIxBqOU6C+VRWbq
         1UNa8Z7eMGyVDe/oe9mzOcBEXxnuEDlmsQ6m2hTVofyTs4szvpC8mm57whKBnAw4sVD9
         nNcA==
X-Gm-Message-State: AOUpUlH85oNKQcfD1Egy7q1kJZm0+FdPB4LQVvzE/gLs70OAnI4I4Iqs
        LfBt/sIDBO/TBmM2iXdDWRwCxbpSnnuotj7VxfsV2R6MuJio
X-Google-Smtp-Source: AAOMgpeaaOOZuN37330fZCPqCAQ52hGNtjd3Oi/l78BrHfu/FC3OsN709A0e3xlIgXwe/UklB5qBXJtGyhSkPM5tpSx5eBe7DHlp
MIME-Version: 1.0
X-Received: by 2002:a02:98eb:: with SMTP id c40-v6mr2169586jak.32.1531903801909;
 Wed, 18 Jul 2018 01:50:01 -0700 (PDT)
Date:   Wed, 18 Jul 2018 01:50:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f16b5e05714225b8@google.com>
Subject: KASAN: use-after-free Write in __xfrm_policy_unlink
From:   syzbot <syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fcaccc829382 liquidio: correct error msg text when removin..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c6b368400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
dashboard link: https://syzkaller.appspot.com/bug?extid=9d971dd21eb26567036b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __write_once_size  
include/linux/compiler.h:215 [inline]
BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:679 [inline]
BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:440  
[inline]
BUG: KASAN: use-after-free in __xfrm_policy_unlink+0x735/0x7e0  
net/xfrm/xfrm_policy.c:1222
Write of size 8 at addr ffff8801a94744c8 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc3+ #126
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
  __write_once_size include/linux/compiler.h:215 [inline]
  __hlist_del include/linux/list.h:679 [inline]
  hlist_del_rcu include/linux/rculist.h:440 [inline]
  __xfrm_policy_unlink+0x735/0x7e0 net/xfrm/xfrm_policy.c:1222
  xfrm_policy_delete+0x49/0x90 net/xfrm/xfrm_policy.c:1247
  xfrm_policy_timer+0x453/0x670 net/xfrm/xfrm_policy.c:247
  call_timer_fn+0x242/0x970 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x7a6/0xc70 kernel/time/timer.c:1666
  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
  invoke_softirq kernel/softirq.c:368 [inline]
  irq_exit+0x1d1/0x200 kernel/softirq.c:408
  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1052
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
Code: c7 48 89 45 d8 e8 8a 2d 23 fa 48 8b 45 d8 e9 d2 fe ff ff 48 89 df e8  
79 2d 23 fa eb 8a 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffffffff88e07bc0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffffffff11c0f7b RCX: ffffffff81667982
RDX: 1ffffffff11e3610 RSI: 0000000000000004 RDI: ffffffff88f1b080
RBP: ffffffff88e07bc0 R08: ffffed003b5c46d7 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: 0000000000000000
R13: ffffffff88e07c78 R14: ffffffff899ee920 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc7/0x450 arch/x86/kernel/process.c:500
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3aa/0x570 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  rest_init+0xe1/0xe4 init/main.c:442
  start_kernel+0x90e/0x949 init/main.c:738
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

Allocated by task 30004:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  xfrm_policy_alloc+0xd9/0x480 net/xfrm/xfrm_policy.c:260
  xfrm_policy_construct+0x2f/0x590 net/xfrm/xfrm_user.c:1545
  xfrm_add_policy+0x20f/0x750 net/xfrm/xfrm_user.c:1591
  xfrm_user_rcv_msg+0x455/0x8b0 net/xfrm/xfrm_user.c:2590
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  xfrm_netlink_rcv+0x6f/0x90 net/xfrm/xfrm_user.c:2598
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:641 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:651
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2125
  __sys_sendmsg+0x11d/0x290 net/socket.c:2163
  __do_sys_sendmsg net/socket.c:2172 [inline]
  __se_sys_sendmsg net/socket.c:2170 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2170
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 516:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  xfrm_policy_destroy_rcu+0x4a/0x60 net/xfrm/xfrm_policy.c:283
  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
  rcu_do_batch kernel/rcu/tree.c:2558 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
  rcu_process_callbacks+0xed5/0x1850 kernel/rcu/tree.c:2802
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288

The buggy address belongs to the object at ffff8801a94744c0
  which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 8 bytes inside of
  1024-byte region [ffff8801a94744c0, ffff8801a94748c0)
The buggy address belongs to the page:
page:ffffea0006a51d00 count:1 mapcount:0 mapping:ffff8801da800ac0  
index:0xffff8801a9475b40 compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006ae8a08 ffffea00075d3c08 ffff8801da800ac0
raw: ffff8801a9475b40 ffff8801a9474040 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801a9474380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801a9474400: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8801a9474480: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                               ^
  ffff8801a9474500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801a9474580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
