Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeDSDcL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:32:11 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:40463 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeDSDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:32:09 -0400
X-Google-Smtp-Source: AIpwx4+PGTT4XesngPAfhCsiBuES4Ulykg/zlYPM9WRH6AX/fEq3/9wSgE03xilKX61vmBDUUfnLiw==
Date: Wed, 18 Apr 2018 20:33:15 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+6dc95bddc6976b800b0b@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: KASAN: slab-out-of-bounds Write in tcp_v6_syn_recv_sock
Message-ID: <20180419033315.GB946@sol.localdomain>
References: <001a113ed0fc75c8770561d3de8c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113ed0fc75c8770561d3de8c@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2018 at 03:58:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 61233580f1f33c50e159c50e24d80ffd2ba2e06b
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6dc95bddc6976b800b0b@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending
> cookies.  Check SNMP counters.
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:344 [inline]
> BUG: KASAN: slab-out-of-bounds in tcp_v6_syn_recv_sock+0x628/0x23a0
> net/ipv6/tcp_ipv6.c:1144
> Write of size 160 at addr ffff8801cbdd7460 by task syzkaller545407/3196
> 
> CPU: 1 PID: 3196 Comm: syzkaller545407 Not tainted 4.15.0-rc5+ #241
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
>  memcpy+0x37/0x50 mm/kasan/kasan.c:303
>  memcpy include/linux/string.h:344 [inline]
>  tcp_v6_syn_recv_sock+0x628/0x23a0 net/ipv6/tcp_ipv6.c:1144
>  tcp_get_cookie_sock+0x102/0x540 net/ipv4/syncookies.c:213
>  cookie_v6_check+0x177d/0x2160 net/ipv6/syncookies.c:255
>  tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1008 [inline]
>  tcp_v6_do_rcv+0xe4d/0x11c0 net/ipv6/tcp_ipv6.c:1316
>  tcp_v6_rcv+0x22ee/0x2b40 net/ipv6/tcp_ipv6.c:1510
>  ip6_input_finish+0x36f/0x1700 net/ipv6/ip6_input.c:284
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ip6_input+0xe9/0x560 net/ipv6/ip6_input.c:327
>  dst_input include/net/dst.h:466 [inline]
>  ip6_rcv_finish+0x1a9/0x7a0 net/ipv6/ip6_input.c:71
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ipv6_rcv+0xf1f/0x1f80 net/ipv6/ip6_input.c:208
>  __netif_receive_skb_core+0x1a3e/0x3450 net/core/dev.c:4461
>  __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4526
>  process_backlog+0x203/0x740 net/core/dev.c:5205
>  napi_poll net/core/dev.c:5603 [inline]
>  net_rx_action+0x792/0x1910 net/core/dev.c:5669
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1115
>  </IRQ>
>  do_softirq.part.21+0x14d/0x190 kernel/softirq.c:329
>  do_softirq kernel/softirq.c:177 [inline]
>  __local_bh_enable_ip+0x1ee/0x230 kernel/softirq.c:182
>  local_bh_enable include/linux/bottom_half.h:32 [inline]
>  rcu_read_unlock_bh include/linux/rcupdate.h:727 [inline]
>  ip6_finish_output2+0xba6/0x2390 net/ipv6/ip6_output.c:121
>  ip6_finish_output+0x2f9/0x920 net/ipv6/ip6_output.c:146
>  NF_HOOK_COND include/linux/netfilter.h:239 [inline]
>  ip6_output+0x1eb/0x840 net/ipv6/ip6_output.c:163
>  dst_output include/net/dst.h:460 [inline]
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ip6_xmit+0xd75/0x2080 net/ipv6/ip6_output.c:269
>  inet6_csk_xmit+0x2fc/0x580 net/ipv6/inet6_connection_sock.c:139
>  tcp_transmit_skb+0x1b12/0x38b0 net/ipv4/tcp_output.c:1176
>  tcp_write_xmit+0x680/0x5190 net/ipv4/tcp_output.c:2367
>  __tcp_push_pending_frames+0xa0/0x250 net/ipv4/tcp_output.c:2543
>  tcp_send_fin+0x1b0/0xd20 net/ipv4/tcp_output.c:3087
>  tcp_close+0xbe0/0xfc0 net/ipv4/tcp.c:2234
>  inet_release+0xed/0x1c0 net/ipv4/af_inet.c:426
>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:432
>  sock_release+0x8d/0x1e0 net/socket.c:600
>  sock_close+0x16/0x20 net/socket.c:1129
>  __fput+0x327/0x7e0 fs/file_table.c:210
>  ____fput+0x15/0x20 fs/file_table.c:244
>  task_work_run+0x199/0x270 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  get_signal+0x73f/0x16c0 kernel/signal.c:2335
>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath+0x490/0x550 arch/x86/entry/common.c:264
>  entry_SYSCALL_64_fastpath+0x94/0x96
> RIP: 0033:0x4456e9
> RSP: 002b:00007fb4de631da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000006dac3c RCX: 00000000004456e9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000006dac3c
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac38
> R13: 0100000000000000 R14: 00007fb4de6329c0 R15: 0000000000000009
> 
> Allocated by task 3196:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:489
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3544
>  sk_prot_alloc+0x65/0x2a0 net/core/sock.c:1463
>  sk_clone_lock+0x152/0x1570 net/core/sock.c:1649
>  inet_csk_clone_lock+0x92/0x4f0 net/ipv4/inet_connection_sock.c:781
>  tcp_create_openreq_child+0x9b/0x1b70 net/ipv4/tcp_minisocks.c:449
>  tcp_v6_syn_recv_sock+0x22d/0x23a0 net/ipv6/tcp_ipv6.c:1123
>  tcp_get_cookie_sock+0x102/0x540 net/ipv4/syncookies.c:213
>  cookie_v6_check+0x177d/0x2160 net/ipv6/syncookies.c:255
>  tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1008 [inline]
>  tcp_v6_do_rcv+0xe4d/0x11c0 net/ipv6/tcp_ipv6.c:1316
>  tcp_v6_rcv+0x22ee/0x2b40 net/ipv6/tcp_ipv6.c:1510
>  ip6_input_finish+0x36f/0x1700 net/ipv6/ip6_input.c:284
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ip6_input+0xe9/0x560 net/ipv6/ip6_input.c:327
>  dst_input include/net/dst.h:466 [inline]
>  ip6_rcv_finish+0x1a9/0x7a0 net/ipv6/ip6_input.c:71
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ipv6_rcv+0xf1f/0x1f80 net/ipv6/ip6_input.c:208
>  __netif_receive_skb_core+0x1a3e/0x3450 net/core/dev.c:4461
>  __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4526
>  process_backlog+0x203/0x740 net/core/dev.c:5205
>  napi_poll net/core/dev.c:5603 [inline]
>  net_rx_action+0x792/0x1910 net/core/dev.c:5669
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
> 
> Freed by task 0:
> (stack is not available)
> 
> The buggy address belongs to the object at ffff8801cbdd6a80
>  which belongs to the cache TCP of size 2528
> The buggy address is located 0 bytes to the right of
>  2528-byte region [ffff8801cbdd6a80, ffff8801cbdd7460)
> The buggy address belongs to the page:
> page:000000006145927c count:1 mapcount:0 mapping:00000000d41dd7c1
> index:0xffff8801cbdd7ffd compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffff8801cbdd6000 ffff8801cbdd7ffd 0000000100000003
> raw: ffffea00074ef120 ffff8801d82b7248 ffff8801d798b640 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801cbdd7300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801cbdd7380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff8801cbdd7400: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>                                                        ^
>  ffff8801cbdd7480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801cbdd7500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

No longer occurring; last occurrence was on Jan 19 (commit dda3e15231b35).
The fix was commit d91c3e17f75f2:

#syz fix: net/tls: Only attach to sockets in ESTABLISHED state

- Eric
