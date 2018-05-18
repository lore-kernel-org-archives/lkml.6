Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeERMIl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:08:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37224 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:08:36 -0400
X-Google-Smtp-Source: AB8JxZpsqncLgxQcqHZvy6lJjCLmOwQkufgV6XlLs4smJcnroCfop8IPRALfMWyhb3/lhVvLS61IKA==
Date: Fri, 18 May 2018 21:08:30 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: WARNING in ip_recv_error
Message-ID: <20180518120826.GA19515@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash: WARNING in ip_recv_error
(I resend the email since I mistakenly missed the subject in my previous
email. I'm sorry.)


This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report. Our analysis shows that the race occurs when invoking two
syscalls concurrently, setsockopt$inet6_IPV6_ADDRFORM and recvmsg.


Diagnosis:
We think the concurrent execution of do_ipv6_setsockopt() with optname
IPV6_ADDRFORM and inet_recvmsg() causes the crash. do_ipv6_setsockopt()
can update sk->prot to &udp_prot and sk->sk_family to PF_INET. But
inet_recvmsg() can execute sk->sk_prot->recvmsg() right after that
sk->prot is updated and sk->sk_family is not updated by
do_ipv6_setsockopt(). This will lead WARN_ON in ip_recv_error().


Thread interleaving:
CPU0 (do_ipv6_setsockopt)			CPU1 (inet_recvmsg)
=====						=====
struct proto *prot = &udp_prot;
...
sk->sk_prot = prot;
sk->sk_socket->ops = &inet_dgram_ops;
						err = sk->sk_prot->recvmsg(sk, msg, size, flags & MSG_DONTWAIT,
									flags & ~MSG_DONTWAIT, &addr_len);

						(in udp_recvmsg)
						if (flags & MSG_ERRQUEUE)
							return ip_recv_error(sk, msg, len, addr_len);
	
						(in ip_recv_error)
						WARN_ON_ONCE(sk->sk_family == AF_INET6);
sk->sk_family = PF_INET;


Call Sequence:
CPU0
=====
udpv6_setsockopt
	ipv6_setsockopt
		do_ipv6_setsockopt

CPU1
=====
sock_recvmsg
	sock_recvmsg_nosec
		inet_recvmsg
			udp_recvmsg


==================================================================
WARNING: CPU: 1 PID: 32600 at /home/daeryong/workspace/new-race-fuzzer/kernels_repo/kernel_v4.17-rc1/net/ipv4/ip_sockglue.c:508 ip_recv_error+0x6f2/0x720 net/ipv4/ip_sockglue.c:508
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 32600 Comm: syz-executor0 Not tainted 4.17.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x166/0x21c lib/dump_stack.c:113
 panic+0x1a0/0x3a7 kernel/panic.c:184
 __warn+0x191/0x1a0 kernel/panic.c:536
 report_bug+0x132/0x1b0 lib/bug.c:186
 fixup_bug.part.11+0x28/0x50 arch/x86/kernel/traps.c:178
 fixup_bug arch/x86/kernel/traps.c:247 [inline]
 do_error_trap+0x28b/0x2d0 arch/x86/kernel/traps.c:296
 do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:ip_recv_error+0x6f2/0x720 net/ipv4/ip_sockglue.c:508
RSP: 0018:ffff8801dadff630 EFLAGS: 00010212
RAX: 0000000000040000 RBX: 0000000000002002 RCX: ffffffff8327de12
RDX: 000000000000008a RSI: ffffc90001a0c000 RDI: ffff8801be615010
RBP: ffff8801dadff720 R08: 0000000000002002 R09: ffff8801dadff918
R10: ffff8801dadff738 R11: ffff8801dadffaff R12: ffff8801be615000
R13: ffff8801dadffd50 R14: 1ffff1003b5bfece R15: ffff8801dadffb90
 udp_recvmsg+0x834/0xa10 net/ipv4/udp.c:1571
 inet_recvmsg+0x121/0x420 net/ipv4/af_inet.c:830
 sock_recvmsg_nosec net/socket.c:802 [inline]
 sock_recvmsg+0x7f/0xa0 net/socket.c:809
 ___sys_recvmsg+0x1f0/0x430 net/socket.c:2279
 __sys_recvmsg+0xfc/0x1c0 net/socket.c:2328
 __do_sys_recvmsg net/socket.c:2338 [inline]
 __se_sys_recvmsg net/socket.c:2335 [inline]
 __x64_sys_recvmsg+0x48/0x50 net/socket.c:2335
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4563f9
RSP: 002b:00007f24f6927b28 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 000000000072bfa0 RCX: 00000000004563f9
RDX: 0000000000002002 RSI: 0000000020000240 RDI: 0000000000000016
RBP: 00000000000004e4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f24f69286d4
R13: 00000000ffffffff R14: 00000000006fc600 R15: 0000000000000000
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
==================================================================


= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).

RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
repro's scheduling synchronization should be performed at the user
space, its reproducibility is limited (reproduction may take from 1
second to 10 minutes (or even more), depending on a bug). This is
because, while RaceFuzzer precisely interleaves the scheduling at the
kernel's instruction level when finding this bug, C repro cannot fully
utilize such a feature. Please disregard all code related to
"should_hypercall" in the C repro, as this is only for our debugging
purposes using our own hypervisor.
