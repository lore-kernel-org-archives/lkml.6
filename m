Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeA3V4A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:56:00 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:51484 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeA3Vz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:55:58 -0500
X-Google-Smtp-Source: AH8x224+yU+zXAeNVEpjbaqn3ExM7V1gYlLYFyBrLJg6Zp2jUmltyxSVzpKxjMUfXR3nKgdKj6d7EA==
Date: Tue, 30 Jan 2018 13:55:55 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+a9914ff194543950ac61bfad830553bce6811af7@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 addrconf_ifdown
Message-ID: <20180130215555.mbxck2bpz6hswwtp@gmail.com>
References: <94eb2c07724aaa23b40560c0d4b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c07724aaa23b40560c0d4b5@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 11:50:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> BUG: unable to handle kernel NULL pointer dereference at           (null)
> IP: addrconf_ifdown+0x3a2/0x780 net/ipv6/addrconf.c:3674
> PGD 1df99c067 P4D 1df99c067 PUD 1dfbbe067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 28113 Comm: syz-executor0 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:addrconf_ifdown+0x3a2/0x780 net/ipv6/addrconf.c:3674
> RSP: 0018:ffffc900014bf928 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82251944
> RDX: ffff880216be6808 RSI: ffff880216be69b8 RDI: 0000000000000001
> RBP: ffffc900014bf980 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff880216be6800
> R13: ffff880216be6968 R14: 0000000000000000 R15: ffffffff831755a0
> FS:  00007f91d886d700(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000001df119000 CR4: 00000000001426f0
> DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  addrconf_notify+0x86/0xd50 net/ipv6/addrconf.c:3514
>  notifier_call_chain+0x41/0xc0 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x32/0x60 net/core/dev.c:1679
>  call_netdevice_notifiers net/core/dev.c:1697 [inline]
>  dev_close_many+0x121/0x190 net/core/dev.c:1492
>  rollback_registered_many+0x16f/0x490 net/core/dev.c:7265
>  rollback_registered+0x59/0x90 net/core/dev.c:7330
>  unregister_netdevice_queue+0xa5/0xf0 net/core/dev.c:8311
>  unregister_netdevice include/linux/netdevice.h:2464 [inline]
>  __tun_detach+0x618/0x680 drivers/net/tun.c:688
>  tun_detach drivers/net/tun.c:699 [inline]
>  tun_chr_close+0x26/0x30 drivers/net/tun.c:2955
>  __fput+0x120/0x270 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0xa3/0xe0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x3e6/0x1050 kernel/exit.c:869
>  do_group_exit+0x60/0x100 kernel/exit.c:972
>  get_signal+0x36c/0xad0 kernel/signal.c:2337
>  do_signal+0x23/0x670 arch/x86/kernel/signal.c:809
>  exit_to_usermode_loop+0x13c/0x160 arch/x86/entry/common.c:161
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath+0x1b4/0x1e0 arch/x86/entry/common.c:264
>  entry_SYSCALL_64_fastpath+0x94/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007f91d886cc58 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
> RAX: 0000000000000000 RBX: 00000000007580d8 RCX: 0000000000452a39
> RDX: 0000000000000000 RSI: 0000000000004c06 RDI: 000000000000001c
> RBP: 00000000000002dc R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f2540
> R13: 00000000ffffffff R14: 00007f91d886d6d4 R15: 0000000000000012
> Code: 17 e8 13 8a 06 ff 41 8b b4 24 50 02 00 00 31 c0 85 f6 0f 94 c0 89 45
> d0 e8 fc 89 06 ff 49 8b 44 24 08 49 8d 54 24 08 48 89 55 b8 <48> 8b 08 48 39
> d0 48 8d 98 c8 fe ff ff 48 89 45 c0 4c 8d b1 c8
> RIP: addrconf_ifdown+0x3a2/0x780 net/ipv6/addrconf.c:3674 RSP:
> ffffc900014bf928
> CR2: 0000000000000000
> ---[ end trace 36c3336430e0eeeb ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
