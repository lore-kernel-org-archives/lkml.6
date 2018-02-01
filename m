Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeBAHN0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 02:13:26 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:45191 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAHNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 02:13:25 -0500
X-Google-Smtp-Source: AH8x225QB5XrN6gV7qQkqMlKoWmPCkDIjgkTIcQq5T8ezk6JqVExRvzjL6/qhy7hKSuXKAqfUnGwlQ==
Date: Wed, 31 Jan 2018 23:13:21 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+f62f0e8fec2f608fcdf31644e40f2b5ac4a362fe@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Subject: Re: KASAN: double-free or invalid-free in skb_free_head
Message-ID: <20180201071321.GC657@zzz.localdomain>
References: <001a11452568f9f3c6056096f215@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11452568f9f3c6056096f215@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2017 at 09:52:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> f3b5ad89de16f5d42e8ad36fbdf85f705c1ae051
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> ==================================================================
> BUG: KASAN: double-free or invalid-free in skb_free_head+0x74/0xb0
> net/core/skbuff.c:550
> 
> CPU: 0 PID: 3142 Comm: sshd Not tainted 4.15.0-rc3+ #225
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_double_free+0x55/0x80 mm/kasan/report.c:333
>  kasan_slab_free+0xa3/0xc0 mm/kasan/kasan.c:514
>  __cache_free mm/slab.c:3488 [inline]
>  kfree+0xca/0x250 mm/slab.c:3803
>  skb_free_head+0x74/0xb0 net/core/skbuff.c:550
>  skb_release_data+0x58c/0x790 net/core/skbuff.c:570
>  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
>  __kfree_skb net/core/skbuff.c:641 [inline]
>  consume_skb+0x153/0x490 net/core/skbuff.c:701
>  __dev_kfree_skb_any+0x85/0xa0 net/core/dev.c:2515
>  dev_consume_skb_any include/linux/netdevice.h:3276 [inline]
>  free_old_xmit_skbs.isra.28+0x15a/0x2c0 drivers/net/virtio_net.c:1167
>  start_xmit+0x1b9/0x1650 drivers/net/virtio_net.c:1314
>  __netdev_start_xmit include/linux/netdevice.h:4042 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4051 [inline]
>  xmit_one net/core/dev.c:2991 [inline]
>  dev_hard_start_xmit+0x248/0xac0 net/core/dev.c:3007
>  sch_direct_xmit+0x31d/0x6d0 net/sched/sch_generic.c:187
>  __dev_xmit_skb net/core/dev.c:3189 [inline]
>  __dev_queue_xmit+0x16f4/0x2070 net/core/dev.c:3456
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3521
>  neigh_hh_output include/net/neighbour.h:472 [inline]
>  neigh_output include/net/neighbour.h:480 [inline]
>  ip_finish_output2+0xece/0x1460 net/ipv4/ip_output.c:229
>  ip_finish_output+0x85e/0xd10 net/ipv4/ip_output.c:317
>  NF_HOOK_COND include/linux/netfilter.h:239 [inline]
>  ip_output+0x1cc/0x860 net/ipv4/ip_output.c:405
>  dst_output include/net/dst.h:460 [inline]
>  ip_local_out+0x95/0x160 net/ipv4/ip_output.c:124
>  ip_queue_xmit+0x8c6/0x18e0 net/ipv4/ip_output.c:504
>  tcp_transmit_skb+0x1b12/0x38b0 net/ipv4/tcp_output.c:1176
>  tcp_write_xmit+0x680/0x5190 net/ipv4/tcp_output.c:2367
>  __tcp_push_pending_frames+0xa0/0x250 net/ipv4/tcp_output.c:2543
>  tcp_push+0x538/0x770 net/ipv4/tcp.c:730
>  tcp_sendmsg_locked+0x2663/0x3b30 net/ipv4/tcp.c:1424
>  tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1461
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:646
>  sock_write_iter+0x31a/0x5d0 net/socket.c:915
>  call_write_iter include/linux/fs.h:1772 [inline]
>  new_sync_write fs/read_write.c:469 [inline]
>  __vfs_write+0x684/0x970 fs/read_write.c:482
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:581
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x7f7a61d22370
> RSP: 002b:00007ffc93b90b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000563815b397d0 RCX: 00007f7a61d22370
> RDX: 0000000000000038 RSI: 0000563815b2b460 RDI: 0000000000000003
> RBP: 00007ffc93b90b20 R08: 0000000000000001 R09: 0101010101010101
> R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000040
> R13: 000000000000005e R14: 0000563815b304e0 R15: 00007ffc93b90b70
> 
> Allocated by task 3142:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  __do_kmalloc_node mm/slab.c:3672 [inline]
>  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3686
>  __kmalloc_reserve.isra.41+0x41/0xd0 net/core/skbuff.c:137
>  __alloc_skb+0x13b/0x780 net/core/skbuff.c:205
>  alloc_skb_fclone include/linux/skbuff.h:1025 [inline]
>  sk_stream_alloc_skb+0x11d/0x900 net/ipv4/tcp.c:870
>  tcp_sendmsg_locked+0x1341/0x3b30 net/ipv4/tcp.c:1299
>  tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1461
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:646
>  sock_write_iter+0x31a/0x5d0 net/socket.c:915
>  call_write_iter include/linux/fs.h:1772 [inline]
>  new_sync_write fs/read_write.c:469 [inline]
>  __vfs_write+0x684/0x970 fs/read_write.c:482
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:581
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> 
> Freed by task 3142:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3488 [inline]
>  kfree+0xca/0x250 mm/slab.c:3803
>  skb_free_head+0x74/0xb0 net/core/skbuff.c:550
>  skb_release_data+0x58c/0x790 net/core/skbuff.c:570
>  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
>  __kfree_skb net/core/skbuff.c:641 [inline]
>  consume_skb+0x153/0x490 net/core/skbuff.c:701
>  __dev_kfree_skb_any+0x85/0xa0 net/core/dev.c:2515
>  dev_consume_skb_any include/linux/netdevice.h:3276 [inline]
>  free_old_xmit_skbs.isra.28+0x15a/0x2c0 drivers/net/virtio_net.c:1167
>  start_xmit+0x1b9/0x1650 drivers/net/virtio_net.c:1314
>  __netdev_start_xmit include/linux/netdevice.h:4042 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4051 [inline]
>  xmit_one net/core/dev.c:2991 [inline]
>  dev_hard_start_xmit+0x248/0xac0 net/core/dev.c:3007
>  sch_direct_xmit+0x31d/0x6d0 net/sched/sch_generic.c:187
>  __dev_xmit_skb net/core/dev.c:3189 [inline]
>  __dev_queue_xmit+0x16f4/0x2070 net/core/dev.c:3456
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3521
>  neigh_hh_output include/net/neighbour.h:472 [inline]
>  neigh_output include/net/neighbour.h:480 [inline]
>  ip_finish_output2+0xece/0x1460 net/ipv4/ip_output.c:229
>  ip_finish_output+0x85e/0xd10 net/ipv4/ip_output.c:317
>  NF_HOOK_COND include/linux/netfilter.h:239 [inline]
>  ip_output+0x1cc/0x860 net/ipv4/ip_output.c:405
>  dst_output include/net/dst.h:460 [inline]
>  ip_local_out+0x95/0x160 net/ipv4/ip_output.c:124
>  ip_queue_xmit+0x8c6/0x18e0 net/ipv4/ip_output.c:504
>  tcp_transmit_skb+0x1b12/0x38b0 net/ipv4/tcp_output.c:1176
>  tcp_write_xmit+0x680/0x5190 net/ipv4/tcp_output.c:2367
>  __tcp_push_pending_frames+0xa0/0x250 net/ipv4/tcp_output.c:2543
>  tcp_push+0x538/0x770 net/ipv4/tcp.c:730
>  tcp_sendmsg_locked+0x2663/0x3b30 net/ipv4/tcp.c:1424
>  tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1461
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:646
>  sock_write_iter+0x31a/0x5d0 net/socket.c:915
>  call_write_iter include/linux/fs.h:1772 [inline]
>  new_sync_write fs/read_write.c:469 [inline]
>  __vfs_write+0x684/0x970 fs/read_write.c:482
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:581
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> 
> The buggy address belongs to the object at ffff8801c719cdc0
>  which belongs to the cache kmalloc-1024 of size 1024
> The buggy address is located 0 bytes inside of
>  1024-byte region [ffff8801c719cdc0, ffff8801c719d1c0)
> The buggy address belongs to the page:
> page:0000000009b6561b count:1 mapcount:0 mapping:00000000749a03ca index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffff8801c719c040 0000000000000000 0000000100000007
> raw: ffffea00071edf20 ffffea00071c9220 ffff8801db000ac0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801c719cc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801c719cd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff8801c719cd80: fb fb fb fb fb fb fb fb fb fb fb fb 00 00 00 00
>                                            ^
>  ffff8801c719ce00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801c719ce80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
> 
> syzbot will keep track of this bug report.
> Once a fix for this bug is merged into any tree, reply to this email with:
> #syz fix: exact-commit-title

This crash is no longer occurring, and the reproducer actually used AF_ALG with
"pcrypt", so this was probably the slab corruption fixed by commit
d76c68109f37c:

#syz fix: crypto: pcrypt - fix freeing pcrypt instances

- Eric
