Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C40C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4969B2174A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4969B2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbeHNHZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:25:30 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:34809 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbeHNHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:25:27 -0400
Received: by mail-it0-f71.google.com with SMTP id k204-v6so9458336ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 21:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kLoNNPfAKv6zbM4cOu2yPFMRYZUi+e1ZlqR6UuDqPzc=;
        b=UJxRW5n7kxZ21Rv/bhPcrqd/KqWu5uBA/HpYYCZFPAEpEx4sk7cGijnQXXv2Qk1k62
         mb2+Ozz/m10mv54qehYZ8AJRFCI3NmolOjKwHMNZcrPpPrHKQFequYXv4CvXxxnRjHnE
         CzKzp4ZSXtpYvZg8TAAstkp8c6nIPzX1JGXp9U25HOpxo5FwPkRgExxUMJAKV9Fdszaq
         SZCATvgcCgRf27L3pbM2WbE02K2kOZG3/bIUK4b8+oSu626AzDeDrEWoN1wBnC0RIanB
         KygVQenZ+qDQ2h3C48WSlMF2sf/FfUrbugJyR8DW3UirE0JiBxNxxQFR9ekctsT270Tb
         zU/w==
X-Gm-Message-State: AOUpUlG6JwQuP1KymcW2aKR4unUZcIpxXbuNx+xEqO3YO7YGNAOlUzXK
        pvv1OYkTnVF1KP98V2n8tOn2nOhSqw2QeHQ/tDVlOvvXTv6U
X-Google-Smtp-Source: AA+uWPy5+lX+9KyW8hUwjhHTCLRNfNriBeell5B3vFEgPa3j/nljQJapYcbkJvn6GWz999fE5VHQEUEpU6eRl3R7DnQLAE9YSWad
MIME-Version: 1.0
X-Received: by 2002:a6b:b0c2:: with SMTP id z185-v6mr9049853ioe.99.1534221603452;
 Mon, 13 Aug 2018 21:40:03 -0700 (PDT)
Date:   Mon, 13 Aug 2018 21:40:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae453e05735dcdb8@google.com>
Subject: inconsistent lock state in ila_xlat_nl_cmd_del_mapping
From:   syzbot <syzbot+3db64bd48b29a825d2db@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        keescook@chromium.org, ktkhai@virtuozzo.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pombredanne@nexb.com, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, tom@herbertland.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    36d2f761b5aa cxgb4: update 1.20.8.0 as the latest firmware..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f429c8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbf55ebfa6bfd517
dashboard link: https://syzkaller.appspot.com/bug?extid=3db64bd48b29a825d2db
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14ed8a3c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a4c622400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3db64bd48b29a825d2db@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0

================================
WARNING: inconsistent lock state
4.18.0-rc8+ #179 Not tainted
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
syz-executor551/4387 [HC0[0]:SC0[0]:HE1:SE1] takes:
(____ptrval____) (&(&tlocks[i])->rlock){+.?.}, at: spin_lock  
include/linux/spinlock.h:310 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.?.}, at: ila_del_mapping  
net/ipv6/ila/ila_xlat.c:290 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.?.}, at:  
ila_xlat_nl_cmd_del_mapping+0x46b/0xb00 net/ipv6/ila/ila_xlat.c:368
{IN-SOFTIRQ-W} state was registered at:
   lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
   _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168
   spin_lock_bh include/linux/spinlock.h:315 [inline]
   __rhashtable_insert_fast include/linux/rhashtable.h:596 [inline]
   rhashtable_lookup_insert_fast include/linux/rhashtable.h:784 [inline]
   fdb_create+0x5cc/0x1710 net/bridge/br_fdb.c:508
   br_fdb_update+0x4e7/0xd40 net/bridge/br_fdb.c:605
   br_handle_frame_finish+0xa23/0x1960 net/bridge/br_input.c:97
   br_nf_hook_thresh+0x48d/0x5f0 net/bridge/br_netfilter_hooks.c:1011
   br_nf_pre_routing_finish_ipv6+0x7bc/0xef0  
net/bridge/br_netfilter_ipv6.c:209
   NF_HOOK include/linux/netfilter.h:287 [inline]
   br_nf_pre_routing_ipv6+0x4af/0xac0 net/bridge/br_netfilter_ipv6.c:237
   br_nf_pre_routing+0xb33/0x17d0 net/bridge/br_netfilter_hooks.c:494
   nf_hook_entry_hookfn include/linux/netfilter.h:119 [inline]
   nf_hook_slow+0xc2/0x1c0 net/netfilter/core.c:511
   nf_hook include/linux/netfilter.h:242 [inline]
   NF_HOOK include/linux/netfilter.h:285 [inline]
   br_handle_frame+0xc0d/0x1a20 net/bridge/br_input.c:303
   __netif_receive_skb_core+0x1455/0x3af0 net/core/dev.c:4821
   __netif_receive_skb_one_core+0xd0/0x200 net/core/dev.c:4890
   __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5002
   process_backlog+0x219/0x760 net/core/dev.c:5808
   napi_poll net/core/dev.c:6228 [inline]
   net_rx_action+0x7a5/0x1920 net/core/dev.c:6294
   __do_softirq+0x2e8/0xb17 kernel/softirq.c:292
   invoke_softirq kernel/softirq.c:372 [inline]
   irq_exit+0x1d4/0x210 kernel/softirq.c:412
   exiting_irq arch/x86/include/asm/apic.h:527 [inline]
   smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1055
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
   native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
   arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
   default_idle+0xc7/0x450 arch/x86/kernel/process.c:500
   arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
   default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
   cpuidle_idle_call kernel/sched/idle.c:153 [inline]
   do_idle+0x3aa/0x570 kernel/sched/idle.c:262
   cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
   start_secondary+0x433/0x5d0 arch/x86/kernel/smpboot.c:270
   secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
irq event stamp: 51111
hardirqs last  enabled at (51111): [<ffffffff814fca78>]  
queue_work_on+0xe8/0x1e0 kernel/workqueue.c:1490
hardirqs last disabled at (51110): [<ffffffff814fca2f>]  
queue_work_on+0x9f/0x1e0 kernel/workqueue.c:1483
softirqs last  enabled at (51088): [<ffffffff85079b7c>] spin_unlock_bh  
include/linux/spinlock.h:355 [inline]
softirqs last  enabled at (51088): [<ffffffff85079b7c>]  
release_sock+0x1ec/0x2c0 net/core/sock.c:2860
softirqs last disabled at (51086): [<ffffffff85079a0d>] spin_lock_bh  
include/linux/spinlock.h:315 [inline]
softirqs last disabled at (51086): [<ffffffff85079a0d>]  
release_sock+0x7d/0x2c0 net/core/sock.c:2847

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(&tlocks[i])->rlock);
   <Interrupt>
     lock(&(&tlocks[i])->rlock);

  *** DEADLOCK ***

1 lock held by syz-executor551/4387:
  #0: (____ptrval____) (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636

stack backtrace:
CPU: 0 PID: 4387 Comm: syz-executor551 Not tainted 4.18.0-rc8+ #179
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_usage_bug.cold.63+0x320/0x41a kernel/locking/lockdep.c:2546
  valid_state kernel/locking/lockdep.c:2559 [inline]
  mark_lock_irq kernel/locking/lockdep.c:2753 [inline]
  mark_lock+0x1048/0x19f0 kernel/locking/lockdep.c:3151
  mark_irqflags kernel/locking/lockdep.c:3047 [inline]
  __lock_acquire+0x7ca/0x5020 kernel/locking/lockdep.c:3392
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:310 [inline]
  ila_del_mapping net/ipv6/ila/ila_xlat.c:290 [inline]
  ila_xlat_nl_cmd_del_mapping+0x46b/0xb00 net/ipv6/ila/ila_xlat.c:368
  genl_family_rcv_msg+0x8a3/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:640 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:650
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2133
  __sys_sendmsg+0x11d/0x290 net/socket.c:2171
  __do_sys_sendmsg net/socket.c:2180 [inline]
  __se_sys_sendmsg net/socket.c:2178 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2178
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441109
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd2c44eb68 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000441109
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 00000000000001


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
