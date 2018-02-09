Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeBIT3j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:29:39 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44725 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeBIT3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:29:34 -0500
X-Google-Smtp-Source: AH8x2254n3mhM1R2xxGeeYqCwCxtQ1pKGOrixBYMlcEhfinjt3cb7xYofOAm0OidjC4y/7Pu1Lg1HJGD8zNuuYWnmTA=
MIME-Version: 1.0
In-Reply-To: <94eb2c1984003ba8ef0564cc8333@google.com>
References: <94eb2c1984003ba8ef0564cc8333@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 9 Feb 2018 20:29:12 +0100
Message-ID: <CACT4Y+YFLj9c35XiNxZBrmZmbOn6OR6Yk=DSaRY0_c147H9vSQ@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in tipc_bearer_find
To: syzbot <syzbot+b743957adcee51f5e0e3@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>, Jon Maloy <jon.maloy@ericsson.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        Ying Xue <ying.xue@windriver.com>, Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 8:27 PM, syzbot
<syzbot+b743957adcee51f5e0e3@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on net-next commit
> 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
> Merge tag 'usercopy-v4.16-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
>
> So far this crash happened 4 times on net-next.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.


For the record, from Eric in
https://groups.google.com/d/msg/syzkaller-bugs/s0qdtBtcJb8/6CrnEixcAgAJ

> This is still happening; looks like a missing lock in tipc_nl_compat_link_set().
> Note that the reproducer isn't guaranteed to work as-is because the message it
> sends to the netlink socket assumes that the "TIPC" generic netlink family was
> assigned ID 31, when actually it is a dynamically assigned ID.  But it will
> trigger if you adjust the message's ->nlmsg_type accordingly.



> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b743957adcee51f5e0e3@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> netlink: 'syz-executor6': attribute type 1 has an invalid length.
> sctp: [Deprecated]: syz-executor3 (pid 6217) Use of int in max_burst socket
> option.
> Use struct sctp_assoc_value instead
>
> =============================
> WARNING: suspicious RCU usage
> 4.15.0+ #221 Not tainted
> sctp: [Deprecated]: syz-executor3 (pid 6225) Use of int in max_burst socket
> option.
> Use struct sctp_assoc_value instead
> -----------------------------
> net/tipc/bearer.c:177 suspicious rcu_dereference_protected() usage!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by syz-executor6/6218:
>  #0:  (
> syz-executor5 (6213) used greatest stack depth: 14576 bytes left
> cb_lock){++++}, at: [<000000004bdfcf78>] genl_rcv+0x19/0x40
> net/netlink/genetlink.c:634
>  #1:  (genl_mutex){+.+.}, at: [<00000000482c2989>] genl_lock
> net/netlink/genetlink.c:33 [inline]
>  #1:  (genl_mutex){+.+.}, at: [<00000000482c2989>] genl_rcv_msg+0x115/0x140
> net/netlink/genetlink.c:622
>
> stack backtrace:
> CPU: 1 PID: 6218 Comm: syz-executor6 Not tainted 4.15.0+ #221
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  lockdep_rcu_suspicious+0x123/0x170 kernel/locking/lockdep.c:4592
>  tipc_bearer_find+0x2b4/0x3b0 net/tipc/bearer.c:177
>  tipc_nl_compat_link_set+0x329/0x9f0 net/tipc/netlink_compat.c:729
> sock: sock_set_timeout: `syz-executor4' (pid 6237) tries to set negative
> timeout
>  __tipc_nl_compat_doit net/tipc/netlink_compat.c:288 [inline]
>  tipc_nl_compat_doit+0x15b/0x670 net/tipc/netlink_compat.c:335
>  tipc_nl_compat_handle net/tipc/netlink_compat.c:1119 [inline]
>  tipc_nl_compat_recv+0x1135/0x18f0 net/tipc/netlink_compat.c:1201
>  genl_family_rcv_msg+0x7b7/0xfb0 net/netlink/genetlink.c:599
>  genl_rcv_msg+0xb2/0x140 net/netlink/genetlink.c:624
>  netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2442
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
>  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
>  netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1334
>  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1897
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:640
>  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
>  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
>  SYSC_sendmsg net/socket.c:2091 [inline]
>  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x4537d9
> RSP: 002b:00007fa225171c58 EFLAGS: 00000212 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fa225172700 RCX: 00000000004537d9
> RDX: 0000000000000000 RSI: 0000000020003000 RDI: 0000000000000013
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
> R13: 0000000000a2f09f R14: 00007fa2251729c0 R15: 0000000000000000
> sctp: [Deprecated]: syz-executor1 (pid 6246) Use of struct sctp_assoc_value
> in delayed_ack socket option.
> Use struct sctp_sack_info instead
> netlink: 'syz-executor2': attribute type 11 has an invalid length.
> netlink: 'syz-executor2': attribute type 11 has an invalid length.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor0'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor0'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor5'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor5'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor5'.
> netlink: 8 bytes leftover after parsing attributes in process
> `syz-executor5'.
> raw_sendmsg: syz-executor3 forgot to set AF_INET. Fix it!
> kauditd_printk_skb: 13 callbacks suppressed
> audit: type=1400 audit(1518204148.200:35): avc:  denied  { shutdown } for
> pid=6517 comm="syz-executor5"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_generic_socket permissive=1
> syz0: Invalid MTU -2 requested, hw min 68
> syz0: Invalid MTU -2 requested, hw min 68
> Cannot find set identified by id 32769 to match
> TCP: request_sock_TCPv6: Possible SYN flooding on port 20010. Sending
> cookies.  Check SNMP counters.
> audit: type=1400 audit(1518204148.699:36): avc:  denied  { prog_run } for
> pid=6645 comm="syz-executor2"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=bpf
> permissive=1
> Cannot find set identified by id 32769 to match
> audit: type=1400 audit(1518204148.973:37): avc:  denied  { getattr } for
> pid=6698 comm="syz-executor1"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_netfilter_socket permissive=1
> audit: type=1400 audit(1518204149.035:38): avc:  denied  { write } for
> pid=6705 comm="syz-executor7"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_crypto_socket permissive=1
> audit: type=1400 audit(1518204149.050:39): avc:  denied  { listen } for
> pid=6705 comm="syz-executor7"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_crypto_socket permissive=1
> netlink: 'syz-executor5': attribute type 1 has an invalid length.
> netlink: 'syz-executor5': attribute type 1 has an invalid length.
> audit: type=1400 audit(1518204149.909:40): avc:  denied  { read } for
> pid=6952 comm="syz-executor5"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_netfilter_socket permissive=1
> audit: type=1400 audit(1518204149.943:41): avc:  denied  { connect } for
> pid=6952 comm="syz-executor5"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_netfilter_socket permissive=1
> ipt_CLUSTERIP: Please specify an interface name
> netlink: 'syz-executor6': attribute type 3 has an invalid length.
> netlink: 'syz-executor6': attribute type 3 has an invalid length.
> validate_nla: 1 callbacks suppressed
> netlink: 'syz-executor3': attribute type 33 has an invalid length.
> A link change request failed with some changes committed already. Interface
> syz3 may have been left with an inconsistent configuration, please check.
> audit: type=1400 audit(1518204151.702:42): avc:  denied  { setopt } for
> pid=7436 comm="syz-executor5"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_generic_socket permissive=1
> NFQUEUE: number of total queues is 0
> NFQUEUE: number of total queues is 0
> netlink: 'syz-executor3': attribute type 33 has an invalid length.
> A link change request failed with some changes committed already. Interface
> syz3 may have been left with an inconsistent configuration, please check.
> netlink: 'syz-executor6': attribute type 1 has an invalid length.
> netlink: 'syz-executor6': attribute type 1 has an invalid length.
> audit: type=1400 audit(1518204152.463:43): avc:  denied  { map } for
> pid=7639 comm="syz-executor3"
> path=2F616E6F6E5F6875676570616765202864656C6574656429 dev="hugetlbfs"
> ino=19879 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:hugetlbfs_t:s0 tclass=file permissive=1
> atomic_op 00000000e4d3062f conn xmit_atomic           (null)
> atomic_op 0000000045f50105 conn xmit_atomic           (null)
> atomic_op 00000000272ad12c conn xmit_atomic           (null)
> atomic_op 0000000003371d71 conn xmit_atomic           (null)
> device syz6 entered promiscuous mode
> device syz6 left promiscuous mode
> atomic_op 000000002579eed8 conn xmit_atomic           (null)
> atomic_op 00000000a306f3e1 conn xmit_atomic           (null)
> FAULT_INJECTION: forcing a failure.
> name fail_page_alloc, interval 1, probability 0, space 0, times 1
> CPU: 0 PID: 7836 Comm: syz-executor4 Not tainted 4.15.0+ #221
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
> nla_parse: 3 callbacks suppressed
> netlink: 15 bytes leftover after parsing attributes in process
> `syz-executor0'.
>  should_fail_alloc_page mm/page_alloc.c:2955 [inline]
>  prepare_alloc_pages mm/page_alloc.c:4194 [inline]
>  __alloc_pages_nodemask+0x338/0xd80 mm/page_alloc.c:4233
> audit: type=1400 audit(1518204153.249:44): avc:  denied  { bind } for
> pid=7842 comm="syz-executor0"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_crypto_socket permissive=1
> netlink: 15 bytes leftover after parsing attributes in process
> `syz-executor0'.
>  alloc_pages_current+0xb6/0x1e0 mm/mempolicy.c:2055
>  alloc_pages include/linux/gfp.h:492 [inline]
>  skb_page_frag_refill+0x358/0x5f0 net/core/sock.c:2208
>  tun_build_skb.isra.50+0x2f0/0x1810 drivers/net/tun.c:1630
>  tun_get_user+0x17d0/0x3940 drivers/net/tun.c:1800
>  tun_chr_write_iter+0xb9/0x160 drivers/net/tun.c:1986
>  call_write_iter include/linux/fs.h:1781 [inline]
>  do_iter_readv_writev+0x55c/0x830 fs/read_write.c:653
>  do_iter_write+0x154/0x540 fs/read_write.c:932
>  vfs_writev+0x18a/0x340 fs/read_write.c:977
>  do_writev+0xfc/0x2a0 fs/read_write.c:1012
>  SYSC_writev fs/read_write.c:1085 [inline]
>  SyS_writev+0x27/0x30 fs/read_write.c:1082
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x4536b1
> RSP: 002b:00007f3d41762b80 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 000000000000005f RCX: 00000000004536b1
> RDX: 0000000000000001 RSI: 00007f3d41762bd0 RDI: 0000000000000012
> RBP: 00000000200f805f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000066 R11: 0000000000000293 R12: 0000000000000066
> R13: 0000000000000014 R14: 00007f3d417636d4 R15: ffffffffffffffff
> atomic_op 00000000f4b2bda9 conn xmit_atomic           (null)
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 1
> CPU: 1 PID: 7886 Comm: syz-executor4 Not tainted 4.15.0+ #221
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
>  should_failslab+0xec/0x120 mm/failslab.c:32
>  slab_pre_alloc_hook mm/slab.h:422 [inline]
>  slab_alloc mm/slab.c:3365 [inline]
>  kmem_cache_alloc+0x47/0x760 mm/slab.c:3539
>  __build_skb+0x9d/0x450 net/core/skbuff.c:281
>  build_skb+0x6f/0x2a0 net/core/skbuff.c:312
>  tun_build_skb.isra.50+0x9cb/0x1810 drivers/net/tun.c:1690
> atomic_op 000000002be437ac conn xmit_atomic           (null)
>  tun_get_user+0x17d0/0x3940 drivers/net/tun.c:1800
>  tun_chr_write_iter+0xb9/0x160 drivers/net/tun.c:1986
>  call_write_iter include/linux/fs.h:1781 [inline]
>  do_iter_readv_writev+0x55c/0x830 fs/read_write.c:653
>  do_iter_write+0x154/0x540 fs/read_write.c:932
>  vfs_writev+0x18a/0x340 fs/read_write.c:977
>  do_writev+0xfc/0x2a0 fs/read_write.c:1012
>  SYSC_writev fs/read_write.c:1085 [inline]
>  SyS_writev+0x27/0x30 fs/read_write.c:1082
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x4536b1
> RSP: 002b:00007f3d41762b80 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 00007f3d41762aa0 RCX: 00000000004536b1
> RDX: 0000000000000001 RSI: 00007f3d41762bd0 RDI: 0000000000000012
> RBP: 00007f3d41762a90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000066 R11: 0000000000000293 R12: 00000000004b863a
> R13: 00007f3d41762bc8 R14: 00000000004b863a R15: 0000000000000000
> atomic_op 00000000e2fa1a71 conn xmit_atomic           (null)
> atomic_op 000000003a952aff conn xmit_atomic           (null)
> netlink: 'syz-executor6': attribute type 33 has an invalid length.
> A link change request failed with some changes committed already. Interface
> syz6 may have been left with an inconsistent configuration, please check.
> netlink: 'syz-executor6': attribute type 33 has an invalid length.
> A link change request failed with some changes committed already. Interface
> syz6 may have been left with an inconsistent configuration, please check.
> netlink: 40 bytes leftover after parsing attributes in process
> `syz-executor5'.
> audit: type=1400 audit(1518204155.198:45): avc:  denied  { connect } for
> pid=8195 comm="syz-executor6"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_generic_socket permissive=1
> audit: type=1400 audit(1518204156.127:46): avc:  denied  { net_bind_service
> } for  pid=8464 comm="syz-executor7" capability=10
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=cap_userns
> permissive=1
> audit: type=1400 audit(1518204156.257:47): avc:  denied  { create } for
> pid=8493 comm="syz-executor5"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_fib_lookup_socket permissive=1
> audit: type=1400 audit(1518204156.286:48): avc:  denied  { write } for
> pid=8493 comm="syz-executor5" path="socket:[20676]" dev="sockfs" ino=20676
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_fib_lookup_socket permissive=1
> netlink: 'syz-executor0': attribute type 2 has an invalid length.
> audit: type=1400 audit(1518204156.414:49): avc:  denied  { read } for
> pid=8523 comm="syz-executor6"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_crypto_socket permissive=1
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 8533 Comm: syz-executor3 Not tainted 4.15.0+ #221
> netlink: 'syz-executor6': attribute type 2 has an invalid length.
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  fail_dump lib/fault-inject.c:51 [inline]
>  should_fail+0x8c0/0xa40 lib/fault-inject.c:149
>  should_failslab+0xec/0x120 mm/failslab.c:32
>  slab_pre_alloc_hook mm/slab.h:422 [inline]
>  slab_alloc mm/slab.c:3365 [inline]
>  __do_kmalloc mm/slab.c:3703 [inline]
>  __kmalloc+0x63/0x760 mm/slab.c:3714
>  kmalloc include/linux/slab.h:517 [inline]
>  sock_kmalloc+0x112/0x190 net/core/sock.c:1986
> netlink: 'syz-executor6': attribute type 2 has an invalid length.
>  ___sys_sendmsg+0x458/0x8b0 net/socket.c:2013
>  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
>  SYSC_sendmsg net/socket.c:2091 [inline]
>  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x4537d9
> RSP: 002b:00007faabf0e4c58 EFLAGS: 00000212 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007faabf0e4aa0 RCX: 00000000004537d9
> RDX: 0000000000000000 RSI: 0000000020019fc8 RDI: 0000000000000013
> RBP: 00007faabf0e4a90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004b863a
> R13: 00007faabf0e4bc8 R14: 00000000004b863a R15: 0000000000000000
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
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/94eb2c1984003ba8ef0564cc8333%40google.com.
> For more options, visit https://groups.google.com/d/optout.
