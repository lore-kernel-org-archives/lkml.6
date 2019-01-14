Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD72070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfANR1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:27:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:40746 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:27:05 -0500
Received: by mail-it1-f198.google.com with SMTP id 135so250152itk.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n9eXPeh6fdyLYdAPXoceTkoK2KxS7kHyP43kOh8aCNI=;
        b=JAoIdOd0JJn+bKIg8vNbTEp/29SxEuDSwWRlIpCVg+97X1n2gXiBBhms+ud9V4Jots
         9nW7BcUxZpktZEZI/zDD1Q5lnghGQhpIYBZ3k+L9i1osK6QYoJa1oqDWVhLpU1H+c0T2
         MWj+6IcjN4OncjURdhG5LO3nhi2Du5Cl4J9fdxpfuGPG8YIAnhJO+r77xdSCD/Bt4ejo
         dg3cEs+pGee8akkyOY1j3R7ixS0dxBUxATbtFJVfc8bPeRENLMamJQALMS9+Fr0hWqIo
         P1Qjl4ORMEqIi1xT4ndl5l3HjisaxxybX46xOa5sEJclRAZUCGIO+eXByKuUPVU7++0M
         U33Q==
X-Gm-Message-State: AJcUukc6giJ4OYJngziztChyeYpTffGT4MKG88HH0J8uLmufBOhZxvhn
        E7tKd7Q5SmEH64S/VZ1zUEst08jIYBOF9LQKB1mm5AY78X2/
X-Google-Smtp-Source: ALg8bN7o6KrrjTyyVwImDRwdnDeSbXHOoDoP+unlvEk3gVB0ght26eMHQn77XGR0ZzgP6Bi3kErUto5h/C6ZYjjKl9atMDHMBq87
MIME-Version: 1.0
X-Received: by 2002:a6b:e519:: with SMTP id y25mr9902352ioc.36.1547486824334;
 Mon, 14 Jan 2019 09:27:04 -0800 (PST)
Date:   Mon, 14 Jan 2019 09:27:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075901d057f6e5a97@google.com>
Subject: KASAN: use-after-free Read in ip_tunnel_lookup
From:   syzbot <syzbot+4a0034797afb7e908ab4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0c928d878e7 tcp: fix a race in inet_diag_dump_icsk()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1732c797400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
dashboard link: https://syzkaller.appspot.com/bug?extid=4a0034797afb7e908ab4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a0034797afb7e908ab4@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
==================================================================
BUG: KASAN: use-after-free in ip_tunnel_lookup+0x108a/0x12b0  
net/ipv4/ip_tunnel.c:142
Read of size 4 at addr ffff8881cc0e32c4 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc7+ #243
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  ip_tunnel_lookup+0x108a/0x12b0 net/ipv4/ip_tunnel.c:142
  ipgre_err net/ipv4/ip_gre.c:188 [inline]
  gre_err+0xade/0x1460 net/ipv4/ip_gre.c:251
  gre_err+0x2b1/0x450 net/ipv4/gre_demux.c:166
  icmp_socket_deliver+0x2a1/0x470 net/ipv4/icmp.c:766
  icmp_unreach+0x3c8/0xca0 net/ipv4/icmp.c:883
  icmp_rcv+0x8dc/0x1570 net/ipv4/icmp.c:1065
  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
  napi_poll net/core/dev.c:6287 [inline]
  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:58
Code: e9 2c ff ff ff 48 89 c7 48 89 45 d8 e8 83 98 e7 f9 48 8b 45 d8 e9 ca  
fe ff ff 48 89 df e8 72 98 e7 f9 eb 82 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffffffff89407c10 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffffffff1280f86 RCX: 0000000000000000
RDX: 1ffffffff12a4021 RSI: 0000000000000001 RDI: ffffffff89520108
RBP: ffffffff89407c10 R08: ffffffff89476ec0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89407cd0
R13: ffffffff8a1640e0 R14: 0000000000000000 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:151 [inline]
  default_idle+0xbf/0x490 arch/x86/kernel/process.c:561
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:552
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x49b/0x5c0 kernel/sched/idle.c:262
  cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:353
  rest_init+0x243/0x372 init/main.c:443
  arch_call_rest_init+0xe/0x1b
  start_kernel+0x9f5/0xa30 init/main.c:745
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

Allocated by task 6066:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node+0x50/0x70 mm/slab.c:3691
  kmalloc_node include/linux/slab.h:589 [inline]
  kvmalloc_node+0x65/0xf0 mm/util.c:416
  kvmalloc include/linux/mm.h:577 [inline]
  kvzalloc include/linux/mm.h:585 [inline]
  alloc_netdev_mqs+0x17b/0xfe0 net/core/dev.c:8949
  __ip_tunnel_create+0x1d9/0x550 net/ipv4/ip_tunnel.c:269
  ip_tunnel_init_net+0x3fc/0xac0 net/ipv4/ip_tunnel.c:1029
  ipgre_tap_init_net+0x29/0x30 net/ipv4/ip_gre.c:1639
  ops_init+0x101/0x560 net/core/net_namespace.c:129
  setup_net+0x362/0x8d0 net/core/net_namespace.c:314
  copy_net_ns+0x2b1/0x4a0 net/core/net_namespace.c:437
  create_new_namespaces+0x6ad/0x900 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x79c/0x10b0 kernel/fork.c:2539
  __do_sys_unshare kernel/fork.c:2607 [inline]
  __se_sys_unshare kernel/fork.c:2605 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2605
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  kvfree+0x61/0x70 mm/util.c:445
  netdev_freemem+0x4c/0x60 net/core/dev.c:8903
  netdev_release+0x121/0x180 net/core/net-sysfs.c:1640
  device_release+0x7e/0x210 drivers/base/core.c:891
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:70 [inline]
  kobject_put.cold.9+0x287/0x2e4 lib/kobject.c:708
  netdev_run_todo+0x715/0xa60 net/core/dev.c:8808
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  ip_tunnel_delete_nets+0x4d7/0x6d0 net/ipv4/ip_tunnel.c:1083
  ipgre_tap_exit_batch_net+0x22/0x30 net/ipv4/ip_gre.c:1644
  ops_exit_list.isra.5+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x555/0xb10 net/core/net_namespace.c:551
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881cc0e2780
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2884 bytes inside of
  4096-byte region [ffff8881cc0e2780, ffff8881cc0e3780)
The buggy address belongs to the page:
page:ffffea0007303880 count:1 mapcount:0 mapping:ffff8881da800dc0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00070b3788 ffffea0007336808 ffff8881da800dc0
raw: 0000000000000000 ffff8881cc0e2780 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cc0e3180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cc0e3200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881cc0e3280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8881cc0e3300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cc0e3380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
