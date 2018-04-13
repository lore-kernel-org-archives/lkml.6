Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbeDMFKP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:10:15 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:57200 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeDMFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:10:02 -0400
X-Google-Smtp-Source: AIpwx48riNMKo9q/V8vmWC+bhfyDwNgIX2Jsrf3R9i531/7wE7RFPckfUhD+s6EdisRHLyvGKypwkb/RealPMRb8xPS4MCeY1Pju
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 22:10:01 -0700
In-Reply-To: <94eb2c059ce01f643c0569a228ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a11441b6c5cdc820569b3e2af@google.com>
Subject: Re: KMSAN: uninit-value in __netif_receive_skb_core
From: syzbot <syzbot+b202b7208664142954fa@syzkaller.appspotmail.com>
To: bpoirier@suse.com, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, elena.reshetova@intel.com, ishkamiel@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        makita.toshiaki@lab.ntt.co.jp, maloney@google.com,
        netdev@vger.kernel.org, rami.rosen@intel.com,
        syzkaller-bugs@googlegroups.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on  
https://github.com/google/kmsan.git/master commit
35ff515e4bda2646f6c881d33951c306ea9c282a (Tue Apr 10 08:59:43 2018 +0000)
Merge pull request #11 from parkerduckworth/readme
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=b202b7208664142954fa

So far this crash happened 3 times on  
https://github.com/google/kmsan.git/master.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4559916236800000
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4590273065648128
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4631921027973120
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6627248707860932248
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

==================================================================
BUG: KMSAN: uninit-value in __read_once_size include/linux/compiler.h:197  
[inline]
BUG: KMSAN: uninit-value in deliver_ptype_list_skb net/core/dev.c:1908  
[inline]
BUG: KMSAN: uninit-value in __netif_receive_skb_core+0x4630/0x4a80  
net/core/dev.c:4545
CPU: 0 PID: 3514 Comm: syzkaller031167 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  __read_once_size include/linux/compiler.h:197 [inline]
  deliver_ptype_list_skb net/core/dev.c:1908 [inline]
  __netif_receive_skb_core+0x4630/0x4a80 net/core/dev.c:4545
  __netif_receive_skb net/core/dev.c:4627 [inline]
  process_backlog+0x62d/0xe20 net/core/dev.c:5307
  napi_poll net/core/dev.c:5705 [inline]
  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
  __do_softirq+0x56d/0x93d kernel/softirq.c:285
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1040
  </IRQ>
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x114/0x140 kernel/softirq.c:182
  local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
  rcu_read_unlock_bh include/linux/rcupdate.h:726 [inline]
  __dev_queue_xmit+0x2a31/0x2b60 net/core/dev.c:3584
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3590
  packet_snd net/packet/af_packet.c:2944 [inline]
  packet_sendmsg+0x7c57/0x8a10 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  sock_write_iter+0x3b9/0x470 net/socket.c:909
  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
  do_iter_write+0x30d/0xd40 fs/read_write.c:932
  vfs_writev fs/read_write.c:977 [inline]
  do_writev+0x3c9/0x830 fs/read_write.c:1012
  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
  SyS_writev+0x56/0x80 fs/read_write.c:1082
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43ffb9
RSP: 002b:00007ffd42187708 EFLAGS: 00000217 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043ffb9
RDX: 0000000000000001 RSI: 00000000200010c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004018e0
R13: 0000000000401970 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
  kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
  __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
  skb_vlan_untag+0x950/0xee0 include/linux/if_vlan.h:597
  __netif_receive_skb_core+0x70a/0x4a80 net/core/dev.c:4460
  __netif_receive_skb net/core/dev.c:4627 [inline]
  process_backlog+0x62d/0xe20 net/core/dev.c:5307
  napi_poll net/core/dev.c:5705 [inline]
  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
  __do_softirq+0x56d/0x93d kernel/softirq.c:285
Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2737 [inline]
  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:984 [inline]
  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
  packet_snd net/packet/af_packet.c:2894 [inline]
  packet_sendmsg+0x6444/0x8a10 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  sock_write_iter+0x3b9/0x470 net/socket.c:909
  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
  do_iter_write+0x30d/0xd40 fs/read_write.c:932
  vfs_writev fs/read_write.c:977 [inline]
  do_writev+0x3c9/0x830 fs/read_write.c:1012
  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
  SyS_writev+0x56/0x80 fs/read_write.c:1082
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
==================================================================
