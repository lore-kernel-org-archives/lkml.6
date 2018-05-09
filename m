Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeEIEgu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:36:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43951 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbeEIEgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:36:47 -0400
X-Google-Smtp-Source: AB8JxZq2vVxE4qDPsqFWMKL+XELwhBWyT4qQ3h3Nll4kkfCBAChKvtf+MeMe6QqXFErKYk1UxE5dUg==
Date: Tue, 8 May 2018 21:38:41 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+56029fd3642567f395f0@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org,
        Boris Pismenny <borisp@mellanox.com>
Subject: Re: KASAN: use-after-free Read in ip6_xmit
Message-ID: <20180509043841.GC711@sol.localdomain>
References: <001a113ee06a9a5d3b0561f1342d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113ee06a9a5d3b0561f1342d@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2018 at 02:58:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 0e08c463db387a2adcb0243b15ab868a73f87807
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+56029fd3642567f395f0@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1514737122.010:7): avc:  denied  { map } for
> pid=3153 comm="syzkaller920384" path="/root/syzkaller920384627" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> ==================================================================
> BUG: KASAN: use-after-free in ip6_dst_idev include/net/ip6_fib.h:189
> [inline]
> BUG: KASAN: use-after-free in ip6_xmit+0x1f92/0x1fc0
> net/ipv6/ip6_output.c:248
> Read of size 8 at addr ffff8801ca6f9f18 by task syzkaller920384/3153
> 
> CPU: 1 PID: 3153 Comm: syzkaller920384 Not tainted 4.15.0-rc4-next-20171221+
> #78
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>  ip6_dst_idev include/net/ip6_fib.h:189 [inline]
>  ip6_xmit+0x1f92/0x1fc0 net/ipv6/ip6_output.c:248
>  inet6_csk_xmit+0x2fc/0x580 net/ipv6/inet6_connection_sock.c:139
>  tcp_transmit_skb+0x1b12/0x38b0 net/ipv4/tcp_output.c:1176
>  tcp_send_syn_data net/ipv4/tcp_output.c:3456 [inline]
>  tcp_connect+0x1ed5/0x4090 net/ipv4/tcp_output.c:3495
>  tcp_v4_connect+0x15ef/0x1e70 net/ipv4/tcp_ipv4.c:257
>  __inet_stream_connect+0x2d4/0xf00 net/ipv4/af_inet.c:620
>  tcp_sendmsg_fastopen net/ipv4/tcp.c:1167 [inline]
>  tcp_sendmsg_locked+0x27e4/0x3b30 net/ipv4/tcp.c:1212
>  tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1459
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:764
>  sock_sendmsg_nosec net/socket.c:628 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:638
>  SYSC_sendto+0x361/0x5c0 net/socket.c:1719
>  SyS_sendto+0x40/0x50 net/socket.c:1687
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x43fda9
> RSP: 002b:00007ffc9b8bd818 EFLAGS: 00000217 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 000000000043fda9
> RDX: 0000000000000000 RSI: 0000000020aa1000 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000020aa1000 R09: 0000000000000010
> R10: 0000000023ffffff R11: 0000000000000217 R12: 0000000000401710
> R13: 00000000004017a0 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 3140:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3545
>  dst_alloc+0x11f/0x1a0 net/core/dst.c:104
>  rt_dst_alloc+0xe9/0x520 net/ipv4/route.c:1500
>  __mkroute_output net/ipv4/route.c:2242 [inline]
>  ip_route_output_key_hash_rcu+0xa40/0x2c10 net/ipv4/route.c:2470
>  ip_route_output_key_hash+0x20b/0x370 net/ipv4/route.c:2299
>  __ip_route_output_key include/net/route.h:125 [inline]
>  ip_route_connect include/net/route.h:300 [inline]
>  __ip4_datagram_connect+0xa67/0x1240 net/ipv4/datagram.c:51
>  __ip6_datagram_connect+0x709/0xf90 net/ipv6/datagram.c:157
>  ip6_datagram_connect+0x2f/0x50 net/ipv6/datagram.c:274
>  inet_dgram_connect+0x16b/0x1f0 net/ipv4/af_inet.c:542
>  SYSC_connect+0x213/0x4a0 net/socket.c:1611
>  SyS_connect+0x24/0x30 net/socket.c:1592
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> 
> Freed by task 0:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3489 [inline]
>  kmem_cache_free+0x83/0x2a0 mm/slab.c:3747
>  dst_destroy+0x219/0x310 net/core/dst.c:140
>  dst_destroy_rcu+0x16/0x20 net/core/dst.c:153
>  __rcu_reclaim kernel/rcu/rcu.h:172 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:2934 [inline]
>  __rcu_process_callbacks kernel/rcu/tree.c:2901 [inline]
>  rcu_process_callbacks+0xd6c/0x17f0 kernel/rcu/tree.c:2918
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
> 
> The buggy address belongs to the object at ffff8801ca6f9f00
>  which belongs to the cache ip_dst_cache of size 168
> The buggy address is located 24 bytes inside of
>  168-byte region [ffff8801ca6f9f00, ffff8801ca6f9fa8)
> The buggy address belongs to the page:
> page:00000000637e5443 count:1 mapcount:0 mapping:0000000000ddf2d5
> index:0xffff8801ca6f9000
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801ca6f9000 ffff8801ca6f9000 000000010000000a
> raw: ffff8801d794f138 ffffea0007515320 ffff8801d6d724c0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801ca6f9e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801ca6f9e80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> > ffff8801ca6f9f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                             ^
>  ffff8801ca6f9f80: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801ca6fa000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

No longer reproducible, seems to have first fixed by commit d91c3e17f75f21
("net/tls: Only attach to sockets in ESTABLISHED state"), but commit
c113187d38ff85d ("tls: Use correct sk->sk_prot for IPV6") also appears related.
That fixes it too if I revert the first commit, and the KASAN report indicates
that an 'struct rtable' (IPv4-related) was accessed as if it were an
'struct rt6_info' (IPv6-related).  So telling syzbot:

#syz fix: tls: Use correct sk->sk_prot for IPV6

I also had simplified this reproducer a bit, so I'm pasting it below in case
anyone still wants it:

	#include <netinet/in.h>
	#include <unistd.h>

	#define SOL_TCP 6
	#define TCP_ULP 31

	int main()
	{
		int tcp_fd;
		struct sockaddr_in addr = {
			.sin_family = AF_INET,
			.sin_port = htobe16(0x4e22),
			.sin_addr = { htobe32(0x7f000001) }
		};

		tcp_fd = socket(AF_INET6, SOCK_STREAM, 0);
		setsockopt(tcp_fd, SOL_TCP, TCP_ULP, "tls", 4);
		sendto(tcp_fd, NULL, 0, MSG_FASTOPEN, (void *)&addr, sizeof(addr));
	}

- Eric
