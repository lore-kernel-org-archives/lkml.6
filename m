Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB66C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7BC2172A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7BC2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeHNHZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:25:28 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:52060 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbeHNHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:25:27 -0400
Received: by mail-io0-f200.google.com with SMTP id w23-v6so15546137iob.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 21:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Bvn7gcXgApUzSChS/gqTDuUKo7yHlrjZzuy5y0QZ1m0=;
        b=a62scRdsI2gRhuN6hZ4pwcIM9c9XdvHr/pJ35l1zA5muHMX0WC1hI4VhLdBDJLu9jm
         LlmRPlJLzgVlAmcV3Hj3UGyUe5YrqxayofsivlB/ryBvcMor9VHFBcnKexEu87/7W8/s
         EfuNga2+btEZHcesf//ap7ZA5C1ah0MdBLfX/mUs0zioCdF8suShQDS1FL2RCo5oExWw
         wDCrD3LaxOnF2rXn8Y+fLRCCYkvZfxCZzpRcHgG3SXh7nTa9fKHfK6YZW1A9Z6H9lgoX
         1WbCBOkTEUN33NlkZtqKe35zwplqh5xYeCnpuXrpFOuZvflKNHZYao/RToNgp7aChKx4
         Xudg==
X-Gm-Message-State: AOUpUlH0hYRnKbhuIHa6pM7Vb5yG9QHjMDHvo9jIpe9m83GqwDxIwMyZ
        ixqpNsInyENJ1Hwa1lqyhPMmtg2vCtY+noOaiYHApJSrSPYd
X-Google-Smtp-Source: AA+uWPx5qgcBTnX3mkHiUcc/Vf3YB69jcjQsW1StYu7UzeVNCzo96vQu9E7p4O8LWusywtNBfeDdFUhWQlUg1OVpKAEOLCw/EhZn
MIME-Version: 1.0
X-Received: by 2002:a6b:1647:: with SMTP id 68-v6mr9593757iow.65.1534221603651;
 Mon, 13 Aug 2018 21:40:03 -0700 (PDT)
Date:   Mon, 13 Aug 2018 21:40:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b14d8c05735dcdf8@google.com>
Subject: inconsistent lock state in ila_xlat_nl_cmd_add_mapping
From:   syzbot <syzbot+eaaf6c4a6a8cb1869d86@syzkaller.appspotmail.com>
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

HEAD commit:    78cbac647e61 Merge branch 'ip-faster-in-order-IP-fragments'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14df4828400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9100338df26ab75
dashboard link: https://syzkaller.appspot.com/bug?extid=eaaf6c4a6a8cb1869d86
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13069ad2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eaaf6c4a6a8cb1869d86@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0

================================
WARNING: inconsistent lock state
4.18.0-rc8+ #183 Not tainted
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
syz-executor2/6403 [HC0[0]:SC0[0]:HE1:SE1] takes:
(____ptrval____) (&(&tlocks[i])->rlock){+.?.}, at: spin_lock  
include/linux/spinlock.h:310 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.?.}, at: ila_add_mapping  
net/ipv6/ila/ila_xlat.c:233 [inline]
(____ptrval____) (&(&tlocks[i])->rlock){+.?.}, at:  
ila_xlat_nl_cmd_add_mapping+0x6bb/0x17e0 net/ipv6/ila/ila_xlat.c:355
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
   do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1046
   do_softirq.part.18+0x155/0x1a0 kernel/softirq.c:336
   do_softirq arch/x86/include/asm/preempt.h:23 [inline]
   __local_bh_enable_ip+0x1ec/0x230 kernel/softirq.c:189
   local_bh_enable include/linux/bottom_half.h:32 [inline]
   rcu_read_unlock_bh include/linux/rcupdate.h:725 [inline]
   ip6_finish_output2+0xce8/0x2820 net/ipv6/ip6_output.c:121
   ip6_finish_output+0x5fe/0xbc0 net/ipv6/ip6_output.c:154
   NF_HOOK_COND include/linux/netfilter.h:276 [inline]
   ip6_output+0x234/0x9d0 net/ipv6/ip6_output.c:171
   dst_output include/net/dst.h:444 [inline]
   NF_HOOK include/linux/netfilter.h:287 [inline]
   ndisc_send_skb+0x100d/0x1570 net/ipv6/ndisc.c:491
   ndisc_send_ns+0x3c1/0x8d0 net/ipv6/ndisc.c:633
   addrconf_dad_work+0xbf2/0x1310 net/ipv6/addrconf.c:4060
   process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
   worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
   kthread+0x345/0x410 kernel/kthread.c:246
   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
irq event stamp: 113
hardirqs last  enabled at (113): [<ffffffff86b11fe4>]  
__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (113): [<ffffffff86b11fe4>]  
_raw_spin_unlock_irqrestore+0x74/0xc0 kernel/locking/spinlock.c:184
hardirqs last disabled at (112): [<ffffffff86b120a4>]  
__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (112): [<ffffffff86b120a4>]  
_raw_spin_lock_irqsave+0x74/0xc0 kernel/locking/spinlock.c:152
softirqs last  enabled at (64): [<ffffffff85079b7c>] spin_unlock_bh  
include/linux/spinlock.h:355 [inline]
softirqs last  enabled at (64): [<ffffffff85079b7c>]  
release_sock+0x1ec/0x2c0 net/core/sock.c:2860
softirqs last disabled at (62): [<ffffffff85079a0d>] spin_lock_bh  
include/linux/spinlock.h:315 [inline]
softirqs last disabled at (62): [<ffffffff85079a0d>]  
release_sock+0x7d/0x2c0 net/core/sock.c:2847

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(&tlocks[i])->rlock);
   <Interrupt>
     lock(&(&tlocks[i])->rlock);

  *** DEADLOCK ***

1 lock held by syz-executor2/6403:
  #0: (____ptrval____) (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636

stack backtrace:
CPU: 0 PID: 6403 Comm: syz-executor2 Not tainted 4.18.0-rc8+ #183
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
  ila_add_mapping net/ipv6/ila/ila_xlat.c:233 [inline]
  ila_xlat_nl_cmd_add_mapping+0x6bb/0x17e0 net/ipv6/ila/ila_xlat.c:355
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
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcc9357bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fcc9357c6d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d3c18 R14: 00000000004c88f5 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
