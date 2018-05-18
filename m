Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeERIDk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:03:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41639 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeERIDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:03:18 -0400
X-Google-Smtp-Source: AB8JxZrYlcmbUQxpjtRRbtbIApuCwwEsNYAuD8CPKXcNK6yp5s+Aix6GGKEBz0CItGzZTe8ZiOHINQ==
Date: Fri, 18 May 2018 17:03:11 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: WARNING in __static_key_slow_dec
Message-ID: <20180518080308.GA28587@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash: WARNING in __static_key_slow_dec

This crash has been found in v4.8 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report.
Even though v4.8 is the relatively old version, we did manual verification
and we think the bug still exists.
Our analysis shows that the race occurs when invoking two syscalls
concurrently, setsockopt() with optname SO_TIMESTAMPING and ioctl() with
cmd SIOCGSTAMPNS.


Diagnosis:
We think if timestamp was previously enabled with
SOCK_TIMESTAMPING_RX_SOFTWARE flag, the concurrent execution of
sock_disable_timestamp() and sock_enable_timestamp() causes the crash.


Thread interleaving:
(Assume sk->flag has the SOCK_TIMESTAMPING_RX_SOFTWARE flag by the
previous setsockopt() call with SO_TIMESTAMPING)

CPU0 (sock_disable_timestamp())			CPU1 (sock_enable_timestamp())
=====						=====
(flag == 1UL << SOCK_TIMESTAMPING_RX_SOFTWARE)	(flag == SOCK_TIMESTAMP)

						if (!sock_flag(sk, flag)) {
							unsigned long previous_flags = sk->sk_flags;

if (sk->sk_flags & flags) {
	sk->sk_flags &= ~flags;
	if (sock_needs_netstamp(sk) &&
	    !(sk->sk_flags & SK_FLAGS_TIMESTAMP))
		net_disable_timestamp();
							sock_set_flag(sk, flag);

							if (sock_needs_netstamp(sk) &&
							    !(previous_flags & SK_FLAGS_TIMESTAMP))
								net_enable_timestamp();
							/* Here, net_enable_timestamp() is not called because
							 * previous_flags has the SOCK_TIMESTAMPING_RX_SOFTWARE
							 * flag
							 */
/* After the race, sk->sk has the flag SOCK_TIMESTAMP, but
 * net_enable_timestamp() is not called one more time.
 * Consequently, when the socket is closed, __sk_destruct()
 * calls net_disable_timestamp() that leads WARNING.
 */


Call Sequence:
CPU0
=====
sock_setsockopt (SO_TIMESTAMPING)
	sock_disable_timestamp

CPU1
=====
inet_ioctl (SIOCGSTAMPNS)
	sock_get_timestampns
		sock_enable_timestamp


==================================================================
------------[ cut here ]------------
WARNING: CPU: 1 PID: 14465 at /home/blee/project/race-fuzzer/kernels/kernel_v4.8/kernel/jump_label.c:151 __static_key_slow_dec+0xc7/0xd0 kernel/jump_label.c:150
jump label: negative count!
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 14465 Comm: syz-executor0 Not tainted 4.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
 0000000000000000 ffff8801f2f5f608 ffffffff81694cc3 ffffffff82445d20
 ffff8801f2f5f6e0 ffffffff82498700 ffff8801f2f5f6e0 ffff8801f2f5f6d0
 ffffffff812534a0 0000000041b58ab3 ffffffff829cae04 ffffffff81253336
Call Trace:
 [<ffffffff81694cc3>] __dump_stack lib/dump_stack.c:15 [inline]
 [<ffffffff81694cc3>] dump_stack+0xb3/0x110 lib/dump_stack.c:51
 [<ffffffff812534a0>] panic+0x16a/0x336 kernel/panic.c:153
 [<ffffffff810a02d4>] __warn+0x164/0x170 kernel/panic.c:509
 [<ffffffff810a038c>] warn_slowpath_fmt+0xac/0xd0 kernel/panic.c:532
 [<ffffffff812525c7>] __static_key_slow_dec+0xc7/0xd0 kernel/jump_label.c:150
 [<ffffffff81252603>] static_key_slow_dec+0x33/0x60 kernel/jump_label.c:174
 [<ffffffff81e6252b>] net_disable_timestamp+0x3b/0x50 net/core/dev.c:1729
 [<ffffffff81e34d2e>] sock_disable_timestamp+0x6e/0x80 net/core/sock.c:403
 [<ffffffff81e36934>] __sk_destruct+0xd4/0x260 net/core/sock.c:1453
 [<ffffffff81e3b3b2>] sk_destruct+0x32/0x60 net/core/sock.c:1472
 [<ffffffff81e3b452>] __sk_free+0x72/0x140 net/core/sock.c:1480
 [<ffffffff81e3b543>] sk_free+0x23/0x30 net/core/sock.c:1491
 [<ffffffff81e3c3ac>] sock_put include/net/sock.h:1582 [inline]
 [<ffffffff81e3c3ac>] sk_common_release+0x1ac/0x250 net/core/sock.c:2766
 [<ffffffff81f7e101>] raw_close+0x21/0x30 net/ipv4/raw.c:687
 [<ffffffff81f9c010>] inet_release+0x80/0xd0 net/ipv4/af_inet.c:420
 [<ffffffff81e2da4e>] sock_release+0x4e/0xf0 net/socket.c:573
 [<ffffffff81e2db06>] sock_close+0x16/0x20 net/socket.c:1020
 [<ffffffff81312d82>] __fput+0x182/0x380 fs/file_table.c:208
 [<ffffffff81312fe5>] ____fput+0x15/0x20 fs/file_table.c:244
 [<ffffffff810de2ab>] task_work_run+0xcb/0x100 kernel/task_work.c:116
 [<ffffffff810a5bc1>] exit_task_work include/linux/task_work.h:21 [inline]
 [<ffffffff810a5bc1>] do_exit+0x5a1/0x17f0 kernel/exit.c:828
 [<ffffffff810a9787>] do_group_exit+0xa7/0x190 kernel/exit.c:953
 [<ffffffff810c03b5>] get_signal+0x465/0xdf0 kernel/signal.c:2307
 [<ffffffff8102fdd3>] do_signal+0x93/0xad0 arch/x86/kernel/signal.c:805
 [<ffffffff810025c0>] exit_to_usermode_loop+0xe0/0x110 arch/x86/entry/common.c:163
 [<ffffffff81003c26>] prepare_exit_to_usermode arch/x86/entry/common.c:198 [inline]
 [<ffffffff81003c26>] syscall_return_slowpath+0x146/0x150 arch/x86/entry/common.c:267
 [<ffffffff8230ded8>] entry_SYSCALL_64_fastpath+0xbb/0xbd
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
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
