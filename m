Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeEIEnd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:43:33 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36164 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeEIEnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:43:31 -0400
X-Google-Smtp-Source: AB8JxZrOUxRdna2Ihn0qgvVUChofVJ1QyKG2RC5YFj88jL7RywIYCdMavran3168i2bWTUONEX51nw==
Date: Tue, 8 May 2018 21:45:25 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+c8e66da874feb11aaca6@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: KASAN: out-of-bounds Read in ip6_xmit
Message-ID: <20180509044525.GD711@sol.localdomain>
References: <001a11433bee67ed4c0563db12f9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11433bee67ed4c0563db12f9@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2018 at 11:24:01AM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on net-next commit
> 6bb46bc57c8e9ce947cc605e555b7204b44d2b10 (Fri Jan 26 16:00:23 2018 +0000)
> Merge branch 'cxgb4-fix-dump-collection-when-firmware-crashed'
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c8e66da874feb11aaca6@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> ==================================================================
> BUG: KASAN: out-of-bounds in ip6_dst_idev include/net/ip6_fib.h:192 [inline]
> BUG: KASAN: out-of-bounds in ip6_xmit+0x1f76/0x2260
> net/ipv6/ip6_output.c:264
> Read of size 8 at addr ffff8801bcc8cc18 by task syz-executor2/11459
> 
> CPU: 0 PID: 11459 Comm: syz-executor2 Not tainted 4.15.0-rc9+ #212
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>  ip6_dst_idev include/net/ip6_fib.h:192 [inline]
>  ip6_xmit+0x1f76/0x2260 net/ipv6/ip6_output.c:264
>  inet6_csk_xmit+0x2fc/0x580 net/ipv6/inet6_connection_sock.c:139
>  l2tp_xmit_core net/l2tp/l2tp_core.c:1096 [inline]
>  l2tp_xmit_skb+0x105f/0x1410 net/l2tp/l2tp_core.c:1191
>  pppol2tp_sendmsg+0x470/0x670 net/l2tp/l2tp_ppp.c:341
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:640
>  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
>  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
>  SYSC_sendmsg net/socket.c:2091 [inline]
>  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x453299
> RSP: 002b:00007fcfef194c58 EFLAGS: 00000212 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000071bf58 RCX: 0000000000453299
> RDX: 0000000000000081 RSI: 000000002037ffc8 RDI: 0000000000000014
> RBP: 000000000000036f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f4308
> R13: 00000000ffffffff R14: 00007fcfef1956d4 R15: 000000000000000b
> 
> Allocated by task 11466:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3544
>  dst_alloc+0x11f/0x1a0 net/core/dst.c:104
>  rt_dst_alloc+0xe9/0x520 net/ipv4/route.c:1497
>  ip_route_input_slow net/ipv4/route.c:2006 [inline]
>  ip_route_input_rcu+0x1076/0x3200 net/ipv4/route.c:2137
>  ip_route_input_noref+0xf5/0x1e0 net/ipv4/route.c:2083
>  ip_rcv_finish+0x3a6/0x2040 net/ipv4/ip_input.c:348
>  NF_HOOK include/linux/netfilter.h:288 [inline]
>  ip_rcv+0xc5a/0x1840 net/ipv4/ip_input.c:493
>  __netif_receive_skb_core+0x1a41/0x3460 net/core/dev.c:4547
>  __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4612
>  netif_receive_skb_internal+0x10b/0x670 net/core/dev.c:4686
>  netif_receive_skb+0xae/0x390 net/core/dev.c:4710
>  tun_rx_batched.isra.53+0x5ee/0x870 drivers/net/tun.c:1558
>  tun_get_user+0x25de/0x3940 drivers/net/tun.c:1958
>  tun_chr_write_iter+0xb9/0x160 drivers/net/tun.c:1986
>  call_write_iter include/linux/fs.h:1772 [inline]
>  do_iter_readv_writev+0x525/0x7f0 fs/read_write.c:653
>  do_iter_write+0x154/0x540 fs/read_write.c:932
>  vfs_writev+0x18a/0x340 fs/read_write.c:977
>  do_writev+0xfc/0x2a0 fs/read_write.c:1012
>  SYSC_writev fs/read_write.c:1085 [inline]
>  SyS_writev+0x27/0x30 fs/read_write.c:1082
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> 
> Freed by task 7176:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3488 [inline]
>  kmem_cache_free+0x83/0x2a0 mm/slab.c:3746
>  dst_destroy+0x257/0x370 net/core/dst.c:140
>  dst_destroy_rcu+0x16/0x20 net/core/dst.c:153
>  __rcu_reclaim kernel/rcu/rcu.h:195 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2758 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:3012 [inline]
>  __rcu_process_callbacks kernel/rcu/tree.c:2979 [inline]
>  rcu_process_callbacks+0xd6c/0x17f0 kernel/rcu/tree.c:2996
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
> 
> The buggy address belongs to the object at ffff8801bcc8cc00
>  which belongs to the cache ip_dst_cache of size 168
> The buggy address is located 24 bytes inside of
>  168-byte region [ffff8801bcc8cc00, ffff8801bcc8cca8)
> The buggy address belongs to the page:
> page:ffffea0006f32300 count:1 mapcount:0 mapping:ffff8801bcc8c000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801bcc8c000 0000000000000000 0000000100000010
> raw: ffffea00074da720 ffffea000743cb20 ffff8801d6fe34c0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801bcc8cb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801bcc8cb80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> > ffff8801bcc8cc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>                                ^
>  ffff8801bcc8cc80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801bcc8cd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title

No reproducer and last occurred 58 days ago (on commit f44b1886a5f876c8).
Probably was fixed by commit b954f94023dcc61:

#syz fix: l2tp: fix races with ipv4-mapped ipv6 addresses

- Eric
