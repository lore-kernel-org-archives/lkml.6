Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeA3WPy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:15:54 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:54764 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeA3WPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:15:51 -0500
X-Google-Smtp-Source: AH8x2266Xh/kQZNu20kJ26R1S4gJgkiS1un1KlqcSLahKfsEGOqABR0Mm/8ZGbteWOfuE52eLjs0ig==
Date: Tue, 30 Jan 2018 14:15:46 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+ab9e73b97e9844a785a757eca96e6990a101a00d@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 snmp6_unregister_dev
Message-ID: <20180130221546.n4fy54qfwydj7zuh@gmail.com>
References: <001a113f861ed0a2a50560ad576a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f861ed0a2a50560ad576a@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 12:35:02AM -0800, syzbot wrote:
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
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000578
> IP: read_pnet include/net/net_namespace.h:270 [inline]
> IP: dev_net include/linux/netdevice.h:2041 [inline]
> IP: snmp6_unregister_dev+0x12/0x70 net/ipv6/proc.c:308
> PGD 1e261e067 P4D 1e261e067 PUD 1dc92e067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 1259 Comm: kworker/u4:3 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: netns cleanup_net
> RIP: 0010:read_pnet include/net/net_namespace.h:270 [inline]
> RIP: 0010:dev_net include/linux/netdevice.h:2041 [inline]
> RIP: 0010:snmp6_unregister_dev+0x12/0x70 net/ipv6/proc.c:308
> RSP: 0018:ffffc90002cd3b28 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8801e0a90800 RCX: ffffffff822a18ef
> RDX: 0000000000000000 RSI: ffffffff83164ac0 RDI: ffff8801e0a90800
> RBP: ffffc90002cd3b38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff8801e0a90800
> R13: ffff8801e0a90800 R14: ffffc90002cd3ce8 R15: ffff8801dc936000
> FS:  0000000000000000(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000578 CR3: 00000001dc8f1000 CR4: 00000000001426e0
> Call Trace:
>  addrconf_ifdown+0x70e/0x780 net/ipv6/addrconf.c:3607
>  addrconf_notify+0x86/0xd50 net/ipv6/addrconf.c:3514
>  notifier_call_chain+0x41/0xc0 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x32/0x60 net/core/dev.c:1679
>  call_netdevice_notifiers net/core/dev.c:1697 [inline]
>  rollback_registered_many+0x330/0x490 net/core/dev.c:7288
>  unregister_netdevice_many.part.117+0x17/0x90 net/core/dev.c:8330
>  unregister_netdevice_many+0x22/0x30 net/core/dev.c:8329
>  ip6_tnl_exit_batch_net+0x276/0x380 net/ipv6/ip6_tunnel.c:2240
>  ops_exit_list.isra.6+0x70/0x80 net/core/net_namespace.c:145
>  cleanup_net+0x210/0x350 net/core/net_namespace.c:484
>  process_one_work+0x288/0x7a0 kernel/workqueue.c:2112
>  worker_thread+0x43/0x4d0 kernel/workqueue.c:2246
>  kthread+0x149/0x170 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
> Code: fe ff ff ff eb e4 bb f4 ff ff ff eb dd 66 90 66 2e 0f 1f 84 00 00 00
> 00 00 55 48 89 e5 41 54 53 48 89 fb e8 51 8a 01 ff 48 8b 03 <48> 8b 80 78 05
> 00 00 48 83 b8 18 02 00 00 00 74 3e e8 38 8a 01
> RIP: read_pnet include/net/net_namespace.h:270 [inline] RSP:
> ffffc90002cd3b28
> RIP: dev_net include/linux/netdevice.h:2041 [inline] RSP: ffffc90002cd3b28
> RIP: snmp6_unregister_dev+0x12/0x70 net/ipv6/proc.c:308 RSP:
> ffffc90002cd3b28
> CR2: 0000000000000578
> ---[ end trace b3ddb42264b96238 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
