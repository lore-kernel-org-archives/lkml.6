Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeA3WJz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:09:55 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:41229 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeA3WJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:09:53 -0500
X-Google-Smtp-Source: AH8x226oOeiFd6brEgIMkP+EEPu773b/ghWo92yIgTf4xl4/BpGXjL6e853Pgd0PxN7RteyURKJPFA==
Date: Tue, 30 Jan 2018 14:09:49 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+2c3959274ff5a21153107dbc62fc278a83482e41@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 qdisc_match_from_root
Message-ID: <20180130220949.rjnfhcgroomf3s65@gmail.com>
References: <001a113ed0fc389ca50560b1a597@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113ed0fc389ca50560b1a597@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 05:43:00AM -0800, syzbot wrote:
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
> netlink: 1 bytes leftover after parsing attributes in process
> `syz-executor6'.
> BUG: unable to handle kernel NULL pointer dereference at           (null)
> IP: qdisc_dev include/net/sch_generic.h:379 [inline]
> IP: qdisc_match_from_root+0x19/0xd0 net/sched/sch_api.c:266
> PGD 1db153067 P4D 1db153067 PUD 1da621067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 15445 Comm: syz-executor5 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:qdisc_dev include/net/sch_generic.h:379 [inline]
> RIP: 0010:qdisc_match_from_root+0x19/0xd0 net/sched/sch_api.c:266
> RSP: 0018:ffffc90000dafac8 EFLAGS: 00010216
> RAX: 0000000000000000 RBX: ffff8801de311c00 RCX: ffffffff82123f94
> RDX: 000000000000027f RSI: ffffc90004086000 RDI: ffff8801db4de400
> RBP: ffffc90000dafae0 R08: 0000000000000000 R09: ffffc90000dafb30
> R10: ffffc90000dafbb8 R11: 0000000000000004 R12: ffff8801db4de400
> R13: 0000000005000000 R14: ffff8801dfa1e1c0 R15: 0000000005000000
> FS:  00007f98eef31700(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000001da7ef000 CR4: 00000000001406f0
> DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  qdisc_lookup+0x2d/0x140 net/sched/sch_api.c:306
>  tc_get_qdisc+0xe2/0x380 net/sched/sch_api.c:1259
>  rtnetlink_rcv_msg+0x333/0x5d0 net/core/rtnetlink.c:4522
>  netlink_rcv_skb+0x92/0x160 net/netlink/af_netlink.c:2441
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4540
>  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
>  netlink_unicast+0x1d4/0x290 net/netlink/af_netlink.c:1334
>  netlink_sendmsg+0x345/0x470 net/netlink/af_netlink.c:1897
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0x51/0x70 net/socket.c:646
>  sock_write_iter+0xa4/0x100 net/socket.c:915
>  call_write_iter include/linux/fs.h:1776 [inline]
>  new_sync_write fs/read_write.c:469 [inline]
>  __vfs_write+0x15b/0x1e0 fs/read_write.c:482
>  vfs_write+0xf0/0x230 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0x57/0xd0 fs/read_write.c:581
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007f98eef30c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 0000000000452a39
> RDX: 000000000000005e RSI: 0000000020fab000 RDI: 0000000000000013
> RBP: 000000000000039b R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f3728
> R13: 00000000ffffffff R14: 00007f98eef316d4 R15: 0000000000000000
> Code: 49 c7 c4 28 76 ff 83 eb dd 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41
> 55 41 54 53 49 89 fc 41 89 f5 e8 ac 63 19 ff 49 8b 44 24 40 <48> 8b 18 48 85
> db 0f 84 8b 00 00 00 e8 96 63 19 ff 41 f6 44 24
> RIP: qdisc_dev include/net/sch_generic.h:379 [inline] RSP: ffffc90000dafac8
> RIP: qdisc_match_from_root+0x19/0xd0 net/sched/sch_api.c:266 RSP:
> ffffc90000dafac8
> CR2: 0000000000000000
> ---[ end trace c23e90bc7d735c44 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
