Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeBASH0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:07:26 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:49906 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752988AbeBASHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:07:23 -0500
Date: Thu, 1 Feb 2018 19:04:27 +0100
From: Florian Westphal <fw@strlen.de>
To: syzbot <syzbot+c6ac05d30245e21f783b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in do_ip_getsockopt
Message-ID: <20180201180427.GA11048@breakpoint.cc>
References: <001a114099b0f606e80563db15d3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a114099b0f606e80563db15d3@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+c6ac05d30245e21f783b@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> c4e0ca7fa24137e372d6135fe16e8df8e123f116 (Fri Jan 26 23:10:50 2018 +0000)
> Merge tag 'riscv-for-linus-4.15-maintainers' of
> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux
> 
> So far this crash happened 3 times on net-next, upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c6ac05d30245e21f783b@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.15.0-rc9+ #283 Not tainted
> ------------------------------------------------------
> syz-executor7/5121 is trying to acquire lock:
>  (sk_lock-AF_INET){+.+.}, at: [<00000000fe4e3d75>] lock_sock
> include/net/sock.h:1461 [inline]
>  (sk_lock-AF_INET){+.+.}, at: [<00000000fe4e3d75>]
> do_ip_getsockopt+0x1b3/0x2170 net/ipv4/ip_sockglue.c:1331
> 
> but task is already holding lock:
>  (rtnl_mutex){+.+.}, at: [<000000008db87953>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:72
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (rtnl_mutex){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        rtnl_lock+0x17/0x20 net/core/rtnetlink.c:72
>        register_netdevice_notifier+0xad/0x860 net/core/dev.c:1590
>        clusterip_config_init net/ipv4/netfilter/ipt_CLUSTERIP.c:261 [inline]
>        clusterip_tg_check+0xeb9/0x1570
> net/ipv4/netfilter/ipt_CLUSTERIP.c:478
>        xt_check_target+0x22c/0x7d0 net/netfilter/x_tables.c:845
>        check_target net/ipv4/netfilter/ip_tables.c:518 [inline]
>        find_check_entry.isra.8+0x8c8/0xcb0
> net/ipv4/netfilter/ip_tables.c:559
>        translate_table+0xed1/0x1610 net/ipv4/netfilter/ip_tables.c:730
>        do_replace net/ipv4/netfilter/ip_tables.c:1148 [inline]
>        do_ipt_set_ctl+0x370/0x5f0 net/ipv4/netfilter/ip_tables.c:1682
>        nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
>        nf_setsockopt+0x67/0xc0 net/netfilter/nf_sockopt.c:115
>        ip_setsockopt+0xa1/0xb0 net/ipv4/ip_sockglue.c:1256
>        raw_setsockopt+0xb7/0xd0 net/ipv4/raw.c:857
>        sock_common_setsockopt+0x95/0xd0 net/core/sock.c:2968
>        SYSC_setsockopt net/socket.c:1831 [inline]
>        SyS_setsockopt+0x189/0x360 net/socket.c:1810
>        entry_SYSCALL_64_fastpath+0x29/0xa0
> 
> -> #0 (sk_lock-AF_INET){+.+.}:
>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3914
>        lock_sock_nested+0xc2/0x110 net/core/sock.c:2770
>        lock_sock include/net/sock.h:1461 [inline]
>        do_ip_getsockopt+0x1b3/0x2170 net/ipv4/ip_sockglue.c:1331
>        ip_getsockopt+0x90/0x220 net/ipv4/ip_sockglue.c:1562
>        tcp_getsockopt+0x82/0xd0 net/ipv4/tcp.c:3329
>        sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2927
>        SYSC_getsockopt net/socket.c:1862 [inline]
>        SyS_getsockopt+0x178/0x340 net/socket.c:1844
>        entry_SYSCALL_64_fastpath+0x29/0xa0
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(rtnl_mutex);
>                                lock(sk_lock-AF_INET);
>                                lock(rtnl_mutex);
>   lock(sk_lock-AF_INET);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz-executor7/5121:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000008db87953>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:72
> 
> stack backtrace:
> CPU: 1 PID: 5121 Comm: syz-executor7 Not tainted 4.15.0-rc9+ #283
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_circular_bug.isra.37+0x2cd/0x2dc kernel/locking/lockdep.c:1218
>  check_prev_add kernel/locking/lockdep.c:1858 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1971 [inline]
>  validate_chain kernel/locking/lockdep.c:2412 [inline]
>  __lock_acquire+0x30a8/0x3e00 kernel/locking/lockdep.c:3426
>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3914
>  lock_sock_nested+0xc2/0x110 net/core/sock.c:2770
>  lock_sock include/net/sock.h:1461 [inline]
>  do_ip_getsockopt+0x1b3/0x2170 net/ipv4/ip_sockglue.c:1331
>  ip_getsockopt+0x90/0x220 net/ipv4/ip_sockglue.c:1562
>  tcp_getsockopt+0x82/0xd0 net/ipv4/tcp.c:3329
>  sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2927
>  SYSC_getsockopt net/socket.c:1862 [inline]
>  SyS_getsockopt+0x178/0x340 net/socket.c:1844
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x453299
> RSP: 002b:00007f7b1de2dc58 EFLAGS: 00000212 ORIG_RAX: 0000000000000037
> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000453299
> RDX: 0000000000000029 RSI: 0000000000000000 RDI: 0000000000000013
> RBP: 0000000000000431 R08: 0000000020fae000 R09: 0000000000000000
> R10: 0000000020000000 R11: 0000000000000212 R12: 00000000006f5538
> R13: 00000000ffffffff R14: 00007f7b1de2e6d4 R15: 0000000000000000
> SELinux:  policydb magic number 0x0 does not match expected magic number
> 0xf97cff8c
> SELinux: failed to load policy
> SELinux:  policydb magic number 0x0 does not match expected magic number
> 0xf97cff8c
> SELinux: failed to load policy
> IPVS: ftp: loaded support on port[0] = 21
> IPv6: ADDRCONF(NETDEV_UP): bridge0: link is not ready
> SELinux:  policydb magic number 0x0 does not match expected magic number
> 0xf97cff8c
> SELinux: failed to load policy
> SELinux:  policydb magic number 0x0 does not match expected magic number
> 0xf97cff8c
> SELinux: failed to load policy
> SELinux:  policydb string length -381979344 does not match expected length 8
> Protocol error: SET target dimension is over the limit!
> Protocol error: SET target dimension is over the limit!
> SELinux: failed to load policy
> kauditd_printk_skb: 49 callbacks suppressed
> audit: type=1400 audit(1517139002.008:75): avc:  denied  { prog_load } for
> pid=5614 comm="syz-executor6"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=bpf
> permissive=1
> mmap: syz-executor6 (5616) uses deprecated remap_file_pages() syscall. See
> Documentation/vm/remap_file_pages.txt.
> audit: type=1400 audit(1517139002.234:76): avc:  denied  { map_create } for
> pid=5649 comm="syz-executor4"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=bpf
> permissive=1
> binder: 5640:5651 transaction failed 29189/-22, size 0-0 line 2788
> binder: undelivered TRANSACTION_ERROR: 29189
> binder: 5640:5656 transaction failed 29189/-22, size 0-0 line 2788
> binder: undelivered TRANSACTION_ERROR: 29189
> audit: type=1400 audit(1517139002.234:77): avc:  denied  { map_read
> map_write } for  pid=5649 comm="syz-executor4"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=bpf
> permissive=1
> IPv6: RTM_NEWROUTE with no NLM_F_CREATE or NLM_F_REPLACE
> IPv6: NLM_F_CREATE should be set when creating new route
> audit: type=1400 audit(1517139002.525:78): avc:  denied  { create } for
> pid=5699 comm="syz-executor6"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_crypto_socket permissive=1
> binder: BINDER_SET_CONTEXT_MGR already set
> binder: 5897:5899 ioctl 40046207 0 returned -16
> binder_alloc: 5897: binder_alloc_buf, no vma
> binder: 5897:5899 transaction failed 29189/-3, size 40-8 line 2903
> binder: undelivered TRANSACTION_ERROR: 29189
> binder: release 5897:5899 transaction 9 out, still active
> binder: send failed reply for transaction 9, target dead
> audit: type=1400 audit(1517139003.251:79): avc:  denied  { accept } for
> pid=5916 comm="syz-executor5"
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_generic_socket permissive=1
> audit: type=1326 audit(1517139003.358:80): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=5943
> comm="syz-executor2" exe="/root/syz-executor2" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139003.358:81): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=5943
> comm="syz-executor2" exe="/root/syz-executor2" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> rdma_op 00000000a76f99d6 conn xmit_rdma           (null)
> tc_dump_action: action bad kind
> rdma_op 00000000015d0ed8 conn xmit_rdma           (null)
> tc_dump_action: action bad kind
> audit: type=1326 audit(1517139003.360:82): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=5943
> comm="syz-executor2" exe="/root/syz-executor2" sig=0 arch=c000003e
> syscall=24 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139003.360:83): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=5943
> comm="syz-executor2" exe="/root/syz-executor2" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139003.361:84): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=5943
> comm="syz-executor2" exe="/root/syz-executor2" sig=0 arch=c000003e
> syscall=22 compat=0 ip=0x453299 code=0x7ffc0000
> IPv4: Oversized IP packet from 127.0.0.1
> IPv4: Oversized IP packet from 127.0.0.1
> netlink: 'syz-executor5': attribute type 21 has an invalid length.
> netlink: 'syz-executor5': attribute type 21 has an invalid length.
> sctp: [Deprecated]: syz-executor2 (pid 6331) Use of int in maxseg socket
> option.
> Use struct sctp_assoc_value instead
> sock: sock_set_timeout: `syz-executor5' (pid 6482) tries to set negative
> timeout
> sock: sock_set_timeout: `syz-executor5' (pid 6482) tries to set negative
> timeout
> netlink: 3 bytes leftover after parsing attributes in process
> `syz-executor0'.
> netlink: 3 bytes leftover after parsing attributes in process
> `syz-executor0'.
> binder: 6612:6614 BC_FREE_BUFFER u0000000000000000 no match
> binder: 6612:6614 BC_CLEAR_DEATH_NOTIFICATION invalid ref 4
> binder: BINDER_SET_CONTEXT_MGR already set
> binder: 6612:6624 ioctl 40046207 0 returned -16
> binder_alloc: 6612: binder_alloc_buf, no vma
> binder: 6612:6624 BC_FREE_BUFFER u0000000000000000 no match
> binder: 6612:6624 BC_CLEAR_DEATH_NOTIFICATION invalid ref 4
> binder: 6612:6614 transaction failed 29189/-3, size 40-8 line 2903
> binder: undelivered TRANSACTION_ERROR: 29189
> binder: release 6612:6614 transaction 14 out, still active
> binder: unexpected work type, 4, not freed
> binder: undelivered TRANSACTION_COMPLETE
> binder: send failed reply for transaction 14, target dead
> rfkill: input handler disabled
> binder: 6674:6689 transaction failed 29189/-22, size 0-0 line 2788
> binder: 6674:6689 ioctl c0306201 20008fd0 returned -14
> binder: 6674:6695 transaction failed 29189/-22, size 0-0 line 2788
> binder: 6674:6689 ioctl c0306201 20008fd0 returned -14
> sock: sock_set_timeout: `syz-executor0' (pid 6711) tries to set negative
> timeout
> binder: undelivered TRANSACTION_ERROR: 29189
> rfkill: input handler enabled
> sock: sock_set_timeout: `syz-executor0' (pid 6724) tries to set negative
> timeout
> binder: 6773:6775 unknown command 0
> binder: 6773:6788 got transaction with invalid offset (0, min 56 max 56) or
> object.
> binder: 6773:6788 transaction failed 29201/-22, size 56-808 line 2966
> binder: 6773:6775 ioctl c0306201 2000a000 returned -22
> binder: BINDER_SET_CONTEXT_MGR already set
> binder: 6773:6775 ioctl 40046207 0 returned -16
> binder: 6773:6788 unknown command 0
> binder: 6773:6788 ioctl c0306201 2000a000 returned -22
> binder: undelivered TRANSACTION_ERROR: 29201
> openvswitch: netlink: Message has 4 unknown bytes.
> dccp_close: ABORT with 2 bytes unread
> openvswitch: netlink: Message has 4 unknown bytes.
> kauditd_printk_skb: 129 callbacks suppressed
> audit: type=1326 audit(1517139007.048:207): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.053:208): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e syscall=2
> compat=0 ip=0x40d591 code=0x7ffc0000
> audit: type=1326 audit(1517139007.054:209): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.061:210): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e syscall=1
> compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.062:211): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.062:212): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e
> syscall=134 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.062:213): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.065:214): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e
> syscall=52 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.065:215): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e
> syscall=202 compat=0 ip=0x453299 code=0x7ffc0000
> audit: type=1326 audit(1517139007.071:216): auid=4294967295 uid=0 gid=0
> ses=4294967295 subj=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 pid=6983
> comm="syz-executor0" exe="/root/syz-executor0" sig=0 arch=c000003e syscall=9
> compat=0 ip=0x453299 code=0x7ffc0000
> TCP: request_sock_TCPv6: Possible SYN flooding on port 20030. Sending
> cookies.  Check SNMP counters.
> binder: 7172:7180 ioctl 4018aee1 20c47000 returned -22
> binder: 7172:7180 BC_CLEAR_DEATH_NOTIFICATION death notification cookie
> mismatch 0000000000000000 != 0000000000000003
> binder: 7172:7180 ERROR: BC_REGISTER_LOOPER called after BC_ENTER_LOOPER
> binder: 7180 RLIMIT_NICE not set
> binder: 7172:7203 ioctl 4018aee1 20c47000 returned -22
> binder: 7172:7203 BC_REQUEST_DEATH_NOTIFICATION invalid ref 0
> binder: 7172:7208 BC_CLEAR_DEATH_NOTIFICATION invalid ref 0
> binder: 7172:7208 ERROR: BC_REGISTER_LOOPER called after BC_ENTER_LOOPER
> binder: 7208 RLIMIT_NICE not set
> sctp: [Deprecated]: syz-executor1 (pid 7270) Use of int in maxseg socket
> option.
> Use struct sctp_assoc_value instead
> sctp: [Deprecated]: syz-executor1 (pid 7280) Use of int in maxseg socket
> option.
> Use struct sctp_assoc_value instead
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
#syz fix: netfilter: on sockopt() acquire sock lock only in the required scope
