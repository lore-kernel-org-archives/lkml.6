Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB57C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EB42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EB42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIKRPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:15:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeIKRPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:15:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C6307A9;
        Tue, 11 Sep 2018 05:16:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAB743F71F;
        Tue, 11 Sep 2018 05:16:04 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:16:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Subject: Re: [PATCHv3 0/6] tty: Hold write ldisc sem in tty_reopen()
Message-ID: <20180911121602.bskg32oqkluhwdbg@lakrids.cambridge.arm.com>
References: <20180911014821.26286-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911014821.26286-1-dima@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:48:15AM +0100, Dmitry Safonov wrote:
> Hi all,

Hi,

> Three fixes that worth to have in the @stable, as we've hit them on v4.9
> stable.
> 
> And for linux-next - adding lockdep asserts for line discipline changing
> code, verifying that write ldisc sem will be held forthwith.
> 
> The last patch is optional and probably, timeout can be dropped for
> read_lock(). I'll do it if everyone agrees.
> 
> Rong Chen, could you kindly re-run this version to see if the lockup
> from v1 still happens? I wasn't able to reproduce it..

These patches seem to fix issues I've been seeing on arm64 for a while
but hadn't managed to track down.

For patches 1, 3, and 5, feel free to add:

Tested-by: Mark Rutland <mark.rutland@arm.com>

On vanilla v4.19-rc2, the below reproducer would fire in seconds,
whereas with those patches applied, I have not seen issues after 10s of
minutes of testing.

Thanks,
Mark.

Syzkaller hit 'KASAN: user-memory-access Write in n_tty_set_termios' bug.

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
ipV6: ADDRCONF(NETDEV_UP): veth1: link is not ready
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

