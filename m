Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeCOAQO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:16:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37807 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCOAQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:16:13 -0400
X-Google-Smtp-Source: AG47ELuRO3S6e0cSjvvoriVMcPRr84Img7jsECxCCyBdRqfBnlNs50O6xKWbdJdoduTvsApx4W87sg==
Subject: Re: KASAN: use-after-free Read in pfifo_fast_enqueue
To: syzbot <syzbot+ed43b6903ab968b16f54@syzkaller.appspotmail.com>,
        davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <000000000000081c6a056767c154@google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a37dbc2c-2c43-2f71-7b36-275fcee83eb1@gmail.com>
Date: Wed, 14 Mar 2018 17:16:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000081c6a056767c154@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/14/2018 04:30 PM, syzbot wrote:
> syzbot has found reproducer for the following crash on net-next commit
> a870a02cc963de35452bbed932560ed69725c4f2 (Tue Mar 13 20:58:39 2018 +0000)
> pktgen: use dynamic allocation for debug print buffer
> 
> So far this crash happened 7 times on mmots, net-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ed43b6903ab968b16f54@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
> 
> ==================================================================
> BUG: KASAN: use-after-free in qdisc_pkt_len include/net/sch_generic.h:610 [inline]
> BUG: KASAN: use-after-free in qdisc_qstats_cpu_backlog_inc include/net/sch_generic.h:712 [inline]
> BUG: KASAN: use-after-free in pfifo_fast_enqueue+0x4bc/0x5e0 net/sched/sch_generic.c:639
> Read of size 4 at addr ffff8801cede37e8 by task syzkaller717588/5543
> 
> CPU: 1 PID: 5543 Comm: syzkaller717588 Not tainted 4.16.0-rc4+ #265
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23c/0x360 mm/kasan/report.c:412
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>  qdisc_pkt_len include/net/sch_generic.h:610 [inline]
>  qdisc_qstats_cpu_backlog_inc include/net/sch_generic.h:712 [inline]
>  pfifo_fast_enqueue+0x4bc/0x5e0 net/sched/sch_generic.c:639
>  __dev_xmit_skb net/core/dev.c:3216 [inline]
>  __dev_queue_xmit+0xd50/0x2f30 net/core/dev.c:3517
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3582
>  neigh_hh_output include/net/neighbour.h:472 [inline]
>  neigh_output include/net/neighbour.h:480 [inline]
>  ip6_finish_output2+0x1472/0x23d0 net/ipv6/ip6_output.c:120
>  ip6_finish_output+0x69b/0xaf0 net/ipv6/ip6_output.c:154
>  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
>  ip6_output+0x1eb/0x840 net/ipv6/ip6_output.c:171
>  dst_output include/net/dst.h:444 [inline]
>  ip6_local_out+0x95/0x160 net/ipv6/output_core.c:176
>  ip6_send_skb+0xa1/0x330 net/ipv6/ip6_output.c:1677
>  ip6_push_pending_frames+0xb3/0xe0 net/ipv6/ip6_output.c:1697
>  rawv6_push_pending_frames net/ipv6/raw.c:616 [inline]
>  rawv6_sendmsg+0x2f96/0x40c0 net/ipv6/raw.c:935
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:639
>  ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>  __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>  SYSC_sendmmsg net/socket.c:2168 [inline]
>  SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x447739
> RSP: 002b:00007fb444290d58 EFLAGS: 00000297 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 00000000006f0084 RCX: 0000000000447739
> RDX: 0000000000000249 RSI: 0000000020001300 RDI: 0000000000000353
> RBP: 0000000000000000 R08: 0000000020000000 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006f0080
> R13: 00000000007ffd8f R14: 00007fb4442919c0 R15: 000000000000000a
> 
> Allocated by task 5543:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
>  kmem_cache_alloc_node+0x144/0x760 mm/slab.c:3631
>  __alloc_skb+0xf1/0x780 net/core/skbuff.c:193
>  alloc_skb include/linux/skbuff.h:986 [inline]
>  sock_wmalloc+0x140/0x1d0 net/core/sock.c:1942
>  __ip6_append_data.isra.43+0x26b9/0x3390 net/ipv6/ip6_output.c:1416
>  ip6_append_data+0x189/0x290 net/ipv6/ip6_output.c:1571
>  rawv6_sendmsg+0x1e09/0x40c0 net/ipv6/raw.c:928
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:639
>  ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>  __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>  SYSC_sendmmsg net/socket.c:2168 [inline]
>  SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> Freed by task 5531:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>  __cache_free mm/slab.c:3485 [inline]
>  kmem_cache_free+0x83/0x2a0 mm/slab.c:3743
>  kfree_skbmem+0x1a1/0x1d0 net/core/skbuff.c:582
>  __kfree_skb net/core/skbuff.c:642 [inline]
>  kfree_skb+0x165/0x4c0 net/core/skbuff.c:659
>  ip_tunnel_xmit+0x710/0x3550 net/ipv4/ip_tunnel.c:778
>  __gre_xmit+0x546/0x8b0 net/ipv4/ip_gre.c:449
>  erspan_xmit+0x779/0x22a0 net/ipv4/ip_gre.c:731
>  __netdev_start_xmit include/linux/netdevice.h:4078 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4087 [inline]
>  xmit_one net/core/dev.c:3026 [inline]
>  dev_hard_start_xmit+0x24e/0xac0 net/core/dev.c:3042
>  sch_direct_xmit+0x40d/0x1140 net/sched/sch_generic.c:327
>  qdisc_restart net/sched/sch_generic.c:393 [inline]
>  __qdisc_run+0x57d/0x19c0 net/sched/sch_generic.c:401
>  __dev_xmit_skb net/core/dev.c:3217 [inline]
>  __dev_queue_xmit+0xd5e/0x2f30 net/core/dev.c:3517
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3582
>  neigh_hh_output include/net/neighbour.h:472 [inline]
>  neigh_output include/net/neighbour.h:480 [inline]
>  ip6_finish_output2+0x1472/0x23d0 net/ipv6/ip6_output.c:120
>  ip6_finish_output+0x69b/0xaf0 net/ipv6/ip6_output.c:154
>  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
>  ip6_output+0x1eb/0x840 net/ipv6/ip6_output.c:171
>  dst_output include/net/dst.h:444 [inline]
>  ip6_local_out+0x95/0x160 net/ipv6/output_core.c:176
>  ip6_send_skb+0xa1/0x330 net/ipv6/ip6_output.c:1677
>  ip6_push_pending_frames+0xb3/0xe0 net/ipv6/ip6_output.c:1697
>  rawv6_push_pending_frames net/ipv6/raw.c:616 [inline]
>  rawv6_sendmsg+0x2f96/0x40c0 net/ipv6/raw.c:935
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
>  sock_sendmsg_nosec net/socket.c:629 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:639
>  ___sys_sendmsg+0x320/0x8b0 net/socket.c:2047
>  __sys_sendmmsg+0x1ee/0x620 net/socket.c:2137
>  SYSC_sendmmsg net/socket.c:2168 [inline]
>  SyS_sendmmsg+0x35/0x60 net/socket.c:2163
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> The buggy address belongs to the object at ffff8801cede37c0
>  which belongs to the cache skbuff_head_cache of size 232
> The buggy address is located 40 bytes inside of
>  232-byte region [ffff8801cede37c0, ffff8801cede38a8)
> The buggy address belongs to the page:
> page:ffffea00073b78c0 count:1 mapcount:0 mapping:ffff8801cede3040 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801cede3040 0000000000000000 000000010000000c
> raw: ffffea00074946a0 ffffea00074c6d60 ffff8801d940fcc0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801cede3680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cede3700: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>> ffff8801cede3780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>                                                           ^
>  ffff8801cede3800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cede3880: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 

typical use after free...

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 190570f21b208d5a17943360a3a6f85e1c2a2187..663e016491773f40f81d9bbfeab3dd68e1c2fc5c 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -628,6 +628,7 @@ static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
        int band = prio2band[skb->priority & TC_PRIO_MAX];
        struct pfifo_fast_priv *priv = qdisc_priv(qdisc);
        struct skb_array *q = band2list(priv, band);
+       unsigned int pkt_len = qdisc_pkt_len(skb);
        int err;
 
        err = skb_array_produce(q, skb);
@@ -636,7 +637,7 @@ static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
                return qdisc_drop_cpu(skb, qdisc, to_free);
 
        qdisc_qstats_cpu_qlen_inc(qdisc);
-       qdisc_qstats_cpu_backlog_inc(qdisc, skb);
+       this_cpu_add(qdisc->cpu_qstats->backlog, pkt_len);
        return NET_XMIT_SUCCESS;
 }
