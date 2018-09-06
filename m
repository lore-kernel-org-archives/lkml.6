Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2504FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56632075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56632075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeIFUeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:34:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730272AbeIFUeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:34:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3C407A9;
        Thu,  6 Sep 2018 08:57:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D828E3F557;
        Thu,  6 Sep 2018 08:57:49 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:57:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: tty locking issues? (v4.19-rc2)
Message-ID: <20180906155743.sylvax7uuhn7alkk@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While fuzzing arm64 v4.19-rc2 with Syzkaller, I'm seeing a number of
splats (e.g. use-after-frees) in tty ioctl handling, e.g.
n_tty_set_termios. I've included one such splat at the end of this email.

It looks like syzbot has been hitting these (e.g. [1]) for a number of months,
so I guess this isn't a new issue.

I started to take a look, and it seems like we may have a locking issue in the
tty layer.

The comment above n_tty_set_termios states:

  Locking: Caller holds tty->termios_rwsem

... is that still expected, or is the comment out-of-date?

Assuming it was accurate, I tried adding a corresponding lockdep assert:

  lockdep_assert_held(&tty->termios_rwsem);

... but this fires immediately at boot time:

[    3.672047] WARNING: CPU: 1 PID: 1 at drivers/tty/n_tty.c:1783 n_tty_set_termios+0xb8c/0xd80
[    3.673589] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc2-00001-g507d1a6f0b88-dirty #1
[    3.675542] Hardware name: linux,dummy-virt (DT)
[    3.676594] pstate: 80400005 (Nzcv daif +PAN -UAO)
[    3.677674] pc : n_tty_set_termios+0xb8c/0xd80
[    3.678678] lr : n_tty_set_termios+0xb8c/0xd80
[    3.679686] sp : ffff80006a44f630
[    3.680442] x29: ffff80006a44f630 x28: ffff20000d960780 
[    3.681636] x27: 00000000006000c0 x26: 0000000000000000 
[    3.682849] x25: ffff20000ca20f60 x24: 0000000000000000 
[    3.684042] x23: ffff800066aa5958 x22: ffff20000f43d820 
[    3.685248] x21: 0000000000000000 x20: ffff20000f9c7000 
[    3.686464] x19: ffff800066aa5500 x18: dfff200000000000 
[    3.687683] x17: cf3cf3cf3cf3cf3d x16: 0000000000000000 
[    3.688887] x15: ffff20000e02f000 x14: ffff20000d478000 
[    3.690106] x13: ffff20000d478ae0 x12: ffff20000ebc1000 
[    3.691378] x11: ffff20000ebc1b80 x10: dfff200000000000 
[    3.692587] x9 : 0000000000000000 x8 : 1ffff0000d489e9e 
[    3.693810] x7 : 00000000f1f1f1f1 x6 : 1fffe40001a8f15c 
[    3.695035] x5 : ffff80006a440000 x4 : 0000000000000000 
[    3.696262] x3 : ffff20000963f2a4 x2 : 0000000000000000 
[    3.697487] x1 : ffff80006a440000 x0 : 0000000000000000 
[    3.698713] Call trace:
[    3.699312]  n_tty_set_termios+0xb8c/0xd80
[    3.700257]  n_tty_open+0xfc/0x148
[    3.701041]  tty_ldisc_open.isra.3+0xd8/0x160
[    3.702030]  tty_ldisc_setup+0x44/0x100
[    3.702912]  tty_init_dev+0x180/0x3f8
[    3.703773]  tty_open+0x55c/0x8f0
[    3.704542]  chrdev_open+0x138/0x3e8
[    3.705368]  do_dentry_open+0x4b4/0xbc8
[    3.706247]  vfs_open+0x90/0xc0
[    3.706978]  path_openat+0xb78/0x27d0
[    3.707822]  do_filp_open+0x14c/0x208
[    3.708662]  do_sys_open+0x358/0x470
[    3.709484]  kernel_init_freeable+0xdb4/0xe58
[    3.710472]  kernel_init+0x14/0x1bc
[    3.711280]  ret_from_fork+0x10/0x18
[    3.712089] irq event stamp: 419648
[    3.712893] hardirqs last  enabled at (419647): [<ffff20000851b7e8>] get_page_from_freelist+0x1160/0x4190
[    3.714994] hardirqs last disabled at (419648): [<ffff20000808229c>] do_debug_exception+0x2dc/0x430
[    3.754992] softirqs last  enabled at (419544): [<ffff2000080833b4>] __do_softirq+0xa1c/0xf2c
[    3.757122] softirqs last disabled at (419537): [<ffff20000819ce14>] irq_exit+0x2a4/0x318
[    3.759573] ---[ end trace e5aa01f18f5a2204 ]---

... perhaps that expected at boot time, but never thereafter?

Are the locking comments in drivers/tty/n_tty.c accurate (at least in
intent)? If so, can we turn those into lockdep asserts so that they get
tested?

I'm not all that familiar with the tty layer, so I'm not sure how to
debug this much further.

Thanks,
Mark.

[1] https://syzkaller.appspot.com/bug?id=1e850009fca0b64ce49dc16499bda4f7de0ab1a5

--------
Syzkaller hit 'KASAN: user-memory-access Write in n_tty_set_termios' bug.

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
==================================================================
BUG: KASAN: user-memory-access in memset include/linux/string.h:330 [inline]
BUG: KASAN: user-memory-access in bitmap_zero include/linux/bitmap.h:216 [inline]
BUG: KASAN: user-memory-access in n_tty_set_termios+0xe4/0xd08 drivers/tty/n_tty.c:1784
Write of size 512 at addr 0000000000001060 by task syz-executor0/3007

CPU: 1 PID: 3007 Comm: syz-executor0 Not tainted 4.19.0-rc2-dirty #4
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x340 arch/arm64/include/asm/ptrace.h:270
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:152
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xec/0x150 lib/dump_stack.c:113
 kasan_report_error mm/kasan/report.c:352 [inline]
 kasan_report+0x228/0x360 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:253 [inline]
 check_memory_region+0x114/0x1c8 mm/kasan/kasan.c:267
 memset+0x2c/0x50 mm/kasan/kasan.c:285
 memset include/linux/string.h:330 [inline]
 bitmap_zero include/linux/bitmap.h:216 [inline]
 n_tty_set_termios+0xe4/0xd08 drivers/tty/n_tty.c:1784
 tty_set_termios+0x538/0x760 drivers/tty/tty_ioctl.c:341
 set_termios+0x348/0x968 drivers/tty/tty_ioctl.c:414
 tty_mode_ioctl+0x8f0/0xc60 drivers/tty/tty_ioctl.c:779
 n_tty_ioctl_helper+0x6c/0x390 drivers/tty/tty_ioctl.c:940
 n_tty_ioctl+0x6c/0x490 drivers/tty/n_tty.c:2450
 tty_ioctl+0x610/0x19a8 drivers/tty/tty_io.c:2655
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:501 [inline]
 do_vfs_ioctl+0x1bc/0x1618 fs/ioctl.c:685
 ksys_ioctl+0xbc/0x108 fs/ioctl.c:702
 __do_sys_ioctl fs/ioctl.c:709 [inline]
 __se_sys_ioctl fs/ioctl.c:707 [inline]
 __arm64_sys_ioctl+0x6c/0xa0 fs/ioctl.c:707
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common+0x150/0x288 arch/arm64/kernel/syscall.c:84
 el0_svc_handler+0x54/0xf0 arch/arm64/kernel/syscall.c:130
 el0_svc+0x8/0xc arch/arm64/kernel/entry.S:917
==================================================================


Syzkaller reproducer:
# {Threaded:true Collide:true Repeat:true RepeatTimes:0 Procs:1 Sandbox:none Fault:false FaultCall:-1 FaultNth:0 EnableTun:true UseTmpDir:true EnableCgroups:true EnableNetdev:true ResetNet:true HandleSegv:true Repro:false Trace:false}
r0 = openat$ptmx(0xffffffffffffff9c, &(0x7f0000000000)='/dev/ptmx\x00', 0x0, 0x0)
ioctl$TIOCGPTPEER(r0, 0x40045431, 0x6e0000)
r1 = syz_open_pts(r0, 0x0)
ioctl$TCXONC(r1, 0x5437, 0x0)
ioctl$TIOCGSOFTCAR(r0, 0x5419, &(0x7f00000000c0))
r2 = semget(0x0, 0x1, 0x1a)
semctl$IPC_INFO(r2, 0x0, 0x3, &(0x7f0000000100)=""/166)
syz_open_pts(r0, 0x2)
ioctl$TCSETAW(r0, 0x5407, &(0x7f0000000080))
