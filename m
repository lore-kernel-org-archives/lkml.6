Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeA3Wxp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:53:45 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:56275 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbeA3Wxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:53:43 -0500
X-Google-Smtp-Source: AH8x224qwGa9y8u3leUmsouE1YfPW/5I/peLbR2iP94jhtkoxM5sZbB0xbXMylasyUflyR/v5V0XxQ==
Date: Tue, 30 Jan 2018 14:53:39 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+9e421ebf68256405aaeeb50291a02149805094de@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: WARNING in inet_sock_destruct
Message-ID: <20180130225339.bjszgdyg2ipynyd4@gmail.com>
References: <94eb2c030a10008161055d38a2a4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c030a10008161055d38a2a4@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2017 at 01:05:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 7f9ad2ace17a3521a80831208d431170ef71591f
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> 
> 
> 
> refcount_t: underflow; use-after-free.
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 20526 at net/ipv4/af_inet.c:154
> inet_sock_destruct+0x729/0x950 net/ipv4/af_inet.c:154
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 1 PID: 20526 Comm: syz-executor3 Not tainted 4.14.0-rc4+ #85
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>  panic+0x1e4/0x417 kernel/panic.c:181
>  __warn+0x1c4/0x1d9 kernel/panic.c:542
>  report_bug+0x211/0x2d0 lib/bug.c:183
>  fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:178
>  do_trap_no_signal arch/x86/kernel/traps.c:212 [inline]
>  do_trap+0x260/0x390 arch/x86/kernel/traps.c:261
>  do_error_trap+0x120/0x390 arch/x86/kernel/traps.c:298
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:311
>  invalid_op+0x18/0x20 arch/x86/entry/entry_64.S:905
> RIP: 0010:inet_sock_destruct+0x729/0x950 net/ipv4/af_inet.c:154
> RSP: 0018:ffff8801a3d07220 EFLAGS: 00010212
> RAX: 0000000000010000 RBX: ffff8801c5935800 RCX: ffffc90002ef4000
> RDX: 000000000000093f RSI: ffffffff8417f5c9 RDI: ffff8801c5935a60
> RBP: ffff8801a3d07348 R08: 0000000000000000 R09: 1ffff100347a0e95
> R10: ffff8801d7a1c340 R11: 00000000b877b192 R12: 1ffff100347a0e54
> R13: 0000000000000000 R14: ffffffff847daa20 R15: ffff8801c5935950
>  sctp_destruct_sock+0x43/0x50 net/sctp/socket.c:4508
>  __sk_destruct+0xfd/0x910 net/core/sock.c:1560
>  sk_destruct+0x47/0x80 net/core/sock.c:1595
>  __sk_free+0x57/0x230 net/core/sock.c:1603
>  sk_free+0x2a/0x40 net/core/sock.c:1614
>  sock_put include/net/sock.h:1652 [inline]
>  sctp_close+0x487/0x980 net/sctp/socket.c:1560
>  inet_release+0xed/0x1c0 net/ipv4/af_inet.c:426
>  sock_release+0x8d/0x1e0 net/socket.c:597
>  sock_close+0x16/0x20 net/socket.c:1126
>  __fput+0x333/0x7f0 fs/file_table.c:210
>  ____fput+0x15/0x20 fs/file_table.c:244
>  task_work_run+0x199/0x270 kernel/task_work.c:112
>  get_signal+0x1343/0x16d0 kernel/signal.c:2164
>  do_signal+0x94/0x1ee0 arch/x86/kernel/signal.c:808
>  exit_to_usermode_loop+0x214/0x310 arch/x86/entry/common.c:158
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath+0x42f/0x510 arch/x86/entry/common.c:266
>  entry_SYSCALL_64_fastpath+0xbc/0xbe
> RIP: 0033:0x452719
> RSP: 002b:00007fcb6e910be8 EFLAGS: 00000212 ORIG_RAX: 000000000000002b
> RAX: fffffffffffffff2 RBX: 00000000007580d8 RCX: 0000000000452719
> RDX: 0000000020b51ffc RSI: 0000000020b52000 RDI: 0000000000000013
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006ee0a0
> R13: 00000000ffffffff R14: 00007fcb6e9116d4 R15: 000000000000000a
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

This hasn't occurred in a long time (last crash was Oct 21) so it presumably was
fixed around then -- I'm thinking maybe by 1cc276cec9ec ("sctp: add the missing
sock_owned_by_user check in sctp_icmp_redirect").  I'll just invalidate the bug:

#syz invalid
