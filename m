Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeA3WNJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:13:09 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:51420 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbeA3WNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:13:07 -0500
X-Google-Smtp-Source: AH8x225UMvm1TYcdQyTQEp4C9ZSaLUlSqLp9BBWusYNDibNkbMxQx3uGWwkwJc/IXpNZGbQpLRotTQ==
Date: Tue, 30 Jan 2018 14:13:03 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+18e1098407ba653653e058c0e72da8db5b362492@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in ip_mc_up
Message-ID: <20180130221303.uy2mzkqpwntyfb3u@gmail.com>
References: <001a113f890ea4331e0560ad6961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f890ea4331e0560ad6961@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 12:40:01AM -0800, syzbot wrote:
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
> netlink: 29 bytes leftover after parsing attributes in process
> `syz-executor2'.
> device eql entered promiscuous mode
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000578
> IP: read_pnet include/net/net_namespace.h:270 [inline]
> IP: dev_net include/linux/netdevice.h:2041 [inline]
> IP: ip_mc_up+0x15/0x170 net/ipv4/igmp.c:1736
> PGD 1df61f067 P4D 1df61f067 PUD 1de8fc067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 23740 Comm: syz-executor6 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> netlink: 29 bytes leftover after parsing attributes in process
> `syz-executor2'.
> RIP: 0010:read_pnet include/net/net_namespace.h:270 [inline]
> RIP: 0010:dev_net include/linux/netdevice.h:2041 [inline]
> RIP: 0010:ip_mc_up+0x15/0x170 net/ipv4/igmp.c:1736
> RSP: 0018:ffffc900010abb88 EFLAGS: 00010212
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff821dd421
> RDX: 000000000000235e RSI: ffffc900035dd000 RDI: ffff8801df56d000
> RBP: ffffc900010abba0 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffc900010abc20 R11: 0000000000000000 R12: ffff8801df56d000
> R13: ffff8801df652000 R14: 0000000000000000 R15: ffff8801df56d000
> FS:  00007f4c60214700(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000578 CR3: 00000001dc7f1000 CR4: 00000000001426f0
> Call Trace:
>  inetdev_event+0x224/0x5c0 net/ipv4/devinet.c:1504
>  notifier_call_chain+0x41/0xc0 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x32/0x60 net/core/dev.c:1679
>  call_netdevice_notifiers net/core/dev.c:1697 [inline]
>  __dev_notify_flags+0x75/0x130 net/core/dev.c:6874
>  dev_change_flags+0x5e/0x70 net/core/dev.c:6910
>  devinet_ioctl+0x77b/0x930 net/ipv4/devinet.c:1083
>  inet_ioctl+0xda/0x130 net/ipv4/af_inet.c:902
>  sock_do_ioctl+0x2c/0x60 net/socket.c:964
>  sock_ioctl+0x211/0x320 net/socket.c:1061
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0xaf/0x840 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007f4c60213c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 0000000000452a39
> RDX: 000000002062ffe0 RSI: 0000000000008914 RDI: 0000000000000016
> RBP: 000000000000026a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f1a90
> R13: 00000000ffffffff R14: 00007f4c602146d4 R15: 0000000000000000
> Code: c7 90 cf e5 82 e8 44 04 06 ff e8 dc e2 3c 00 e9 64 ff ff ff 66 90 55
> 48 89 e5 41 55 41 54 53 49 89 fc e8 1f cf 0d ff 49 8b 04 24 <48> 8b 98 78 05
> 00 00 e8 ff c6 f0 ff 85 c0 0f 84 17 01 00 00 e8
> RIP: read_pnet include/net/net_namespace.h:270 [inline] RSP:
> ffffc900010abb88
> RIP: dev_net include/linux/netdevice.h:2041 [inline] RSP: ffffc900010abb88
> RIP: ip_mc_up+0x15/0x170 net/ipv4/igmp.c:1736 RSP: ffffc900010abb88
> CR2: 0000000000000578
> ---[ end trace 41722ce46f86bba0 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
