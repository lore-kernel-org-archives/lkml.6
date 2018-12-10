Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72942084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72942084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeLJTLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:11:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:37453 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeLJTLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:11:05 -0500
Received: by mail-it1-f199.google.com with SMTP id y86so15576983ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=f5exFlhe2u5ytHDgPfIiNTVRKXunvqDBkrJG9dFJ4QY=;
        b=Q34r0aXdP4bLWn5jlUD38fJtHVfwnLovP1tBKMiW/v/ECkxQUX1aRzrkPrHn4XnuWC
         7zDRBDPHsatkvTNhwuxIxno0h42mpji/2YSonryjg0XxEt60RMI2hNSDZB2AB6/Vgt6f
         Vd/mbpFUnh5RvcxznXZx6j6P/k1cFmNg1bdCS68cIJkkhqCOStjPp70bAf/0xKZGDPsu
         AJuBb5s/Y+WSW/yGrspvS7GqfJxPZZtkSUJbT0e5Ru2ZtV+NbVVA6/RGA7KGv1OnyvLk
         DhXbxn5XtRYSmFSgdOSnhqh2epvDaGZABj00Lz9UWyVvbu40IUTAAHkP+nnjI50DPWJ8
         wbBA==
X-Gm-Message-State: AA+aEWYYkby224HyMN4KwjOujfOgIN4wL9kylZ7FYUuh/3mQrI+eMxaN
        9tEOJIOxGx6zfPr7S6x81Tir0SBLaiEjwY1YbdLLTigbT0kJ
X-Google-Smtp-Source: AFSGD/V+VOBti6xFGNm9Ajc7DKcij4zuPOOoJOHXdTAvVcEYSe8tnSINo4fmDOpVVILAGSJjiL5LZIAc6R07tbO3FMXWRsMmXJT0
MIME-Version: 1.0
X-Received: by 2002:a6b:e30f:: with SMTP id u15mr10313662ioc.28.1544469063391;
 Mon, 10 Dec 2018 11:11:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:11:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3e546057cafb90b@google.com>
Subject: KASAN: use-after-free Read in kfree_skb (2)
From:   syzbot <syzbot+eae585ba2cc2752d3704@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    40e020c129cf Linux 4.20-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1254ca7d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=eae585ba2cc2752d3704
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17473c15400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169af3f5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eae585ba2cc2752d3704@syzkaller.appspotmail.com

Started in network mode
Own node identity 00000000000000000000000000000001, cluster identity 4711
New replicast peer: fe80:0000:0000:0000:0000:0000:0000:00aa
==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in refcount_read include/linux/refcount.h:43  
[inline]
BUG: KASAN: use-after-free in skb_unref include/linux/skbuff.h:969 [inline]
BUG: KASAN: use-after-free in kfree_skb+0xb7/0x580 net/core/skbuff.c:655
Read of size 4 at addr ffff8881b387eae4 by task syz-executor306/5992

CPU: 1 PID: 5992 Comm: syz-executor306 Not tainted 4.20.0-rc6+ #370
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  refcount_read include/linux/refcount.h:43 [inline]
  skb_unref include/linux/skbuff.h:969 [inline]
  kfree_skb+0xb7/0x580 net/core/skbuff.c:655
  tipc_udp_send_msg+0x5a6/0x670 net/tipc/udp_media.c:249
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_enable_bearer+0xc5e/0xf10 net/tipc/bearer.c:327
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:897
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:905
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4446f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe705f7a98 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004446f9
RDX: 0000000000000000 RSI: 0000000020000700 RDI: 0000000000000003
RBP: 00000000006cf018 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004023a0
R13: 0000000000402430 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 5992:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc_node+0x144/0x730 mm/slab.c:3644
  __alloc_skb+0x119/0x770 net/core/skbuff.c:193
  __pskb_copy_fclone+0x16b/0xeb0 net/core/skbuff.c:1385
  __pskb_copy include/linux/skbuff.h:1053 [inline]
  pskb_copy include/linux/skbuff.h:2915 [inline]
  tipc_udp_send_msg+0x44e/0x670 net/tipc/udp_media.c:241
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_enable_bearer+0xc5e/0xf10 net/tipc/bearer.c:327
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:897
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:905
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5992:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  kfree_skbmem+0x154/0x230 net/core/skbuff.c:582
  __kfree_skb net/core/skbuff.c:642 [inline]
  kfree_skb+0x1c3/0x580 net/core/skbuff.c:659
  tipc_udp_xmit.isra.14+0x420/0xef0 net/tipc/udp_media.c:207
  tipc_udp_send_msg+0x398/0x670 net/tipc/udp_media.c:247
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_enable_bearer+0xc5e/0xf10 net/tipc/bearer.c:327
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:897
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:905
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881b387ea00
  which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 228 bytes inside of
  232-byte region [ffff8881b387ea00, ffff8881b387eae8)
The buggy address belongs to the page:
page:ffffea0006ce1f80 count:1 mapcount:0 mapping:ffff8881d9be8780 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea000744d908 ffff8881d9bda048 ffff8881d9be8780
raw: 0000000000000000 ffff8881b387e000 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b387e980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881b387ea00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881b387ea80: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
                                                        ^
  ffff8881b387eb00: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
  ffff8881b387eb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
==================================================================
BUG: KASAN: double-free or invalid-free in skb_free_head+0x99/0xc0  
net/core/skbuff.c:550

CPU: 1 PID: 5992 Comm: syz-executor306 Tainted: G    B              
4.20.0-rc6+ #370
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
  __kasan_slab_free+0x13a/0x150 mm/kasan/kasan.c:501
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x70c/0x9a0 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  kfree_skb+0x1bb/0x580 net/core/skbuff.c:659
  tipc_udp_send_msg+0x5a6/0x670 net/tipc/udp_media.c:249
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_disc_timeout+0xb2b/0xfc0 net/tipc/discover.c:332
  call_timer_fn+0x272/0x920 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1682
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:761  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xaf/0xd0  
kernel/locking/spinlock.c:184
Code: f0 00 52 89 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c  
02 00 75 28 48 83 3d 18 ef 76 01 00 74 15 48 89 df 57 9d <0f> 1f 44 00 00  
eb ad e8 1c 6b 25 f9 eb bb 0f 0b 0f 0b e8 9a d7 e7
RSP: 0018:ffff8881b2ae6de8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 0000000000000286 RCX: ffffffff8185acea
RDX: 1ffffffff12a401e RSI: ffffffff8185ad04 RDI: 0000000000000286
RBP: ffff8881b2ae6df8 R08: ffff8881b3888240 R09: fffffbfff12c7248
R10: fffffbfff12c7248 R11: ffffffff89639243 R12: ffffffff89639240
R13: 0000000000000000 R14: ffff8881b387eae4 R15: ffff8881b387eae4
  spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
  kasan_end_report+0x32/0x4f mm/kasan/report.c:178
  kasan_report_error mm/kasan/report.c:359 [inline]
  kasan_report.cold.8+0x76/0x309 mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  refcount_read include/linux/refcount.h:43 [inline]
  skb_unref include/linux/skbuff.h:969 [inline]
  kfree_skb+0xb7/0x580 net/core/skbuff.c:655
  tipc_udp_send_msg+0x5a6/0x670 net/tipc/udp_media.c:249
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_enable_bearer+0xc5e/0xf10 net/tipc/bearer.c:327
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:897
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:905
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4446f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe705f7a98 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004446f9
RDX: 0000000000000000 RSI: 0000000020000700 RDI: 0000000000000003
RBP: 00000000006cf018 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004023a0
R13: 0000000000402430 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 5992:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node_track_caller+0x50/0x70 mm/slab.c:3698
  __kmalloc_reserve.isra.40+0x41/0xe0 net/core/skbuff.c:137
  __alloc_skb+0x155/0x770 net/core/skbuff.c:205
  __pskb_copy_fclone+0x16b/0xeb0 net/core/skbuff.c:1385
  __pskb_copy include/linux/skbuff.h:1053 [inline]
  pskb_copy include/linux/skbuff.h:2915 [inline]
  tipc_udp_send_msg+0x44e/0x670 net/tipc/udp_media.c:241
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_disc_timeout+0xb2b/0xfc0 net/tipc/discover.c:332
  call_timer_fn+0x272/0x920 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1682
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

Freed by task 5992:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x70c/0x9a0 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  kfree_skb+0x1bb/0x580 net/core/skbuff.c:659
  tipc_udp_xmit.isra.14+0x420/0xef0 net/tipc/udp_media.c:207
  tipc_udp_send_msg+0x398/0x670 net/tipc/udp_media.c:247
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_disc_timeout+0xb2b/0xfc0 net/tipc/discover.c:332
  call_timer_fn+0x272/0x920 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1682
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
  __do_softirq+0x308/0xb7e kernel/softirq.c:292

The buggy address belongs to the object at ffff8881c393e480
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
  1024-byte region [ffff8881c393e480, ffff8881c393e880)
The buggy address belongs to the page:
page:ffffea00070e4f80 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea00070f3b88 ffffea000709b388 ffff8881da800ac0
raw: 0000000000000000 ffff8881c393e000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c393e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c393e400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881c393e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8881c393e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c393e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
