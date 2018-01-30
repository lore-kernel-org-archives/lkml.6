Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeA3WLO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:11:14 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34146 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbeA3WLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:11:10 -0500
X-Google-Smtp-Source: AH8x227sw6u1Mh1oq1z/w7yooXLUiDrngwQjeydDtSIYdvxP270gSNWHHR2u38BmOpDvbT5K1mfEBQ==
Date: Tue, 30 Jan 2018 14:11:07 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+259a072a0d23f377c591a43e4368fcf34b1cc7bc@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 tc_fill_qdisc
Message-ID: <20180130221107.kv55f7uypelwwy5s@gmail.com>
References: <001a113a78822c26ed0560b0e4ee@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113a78822c26ed0560b0e4ee@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 04:49:02AM -0800, syzbot wrote:
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
> IP: qdisc_dev include/net/sch_generic.h:379 [inline]
> IP: tc_fill_qdisc+0xc8/0x4b0 net/sched/sch_api.c:792
> PGD 1dc5d4067 P4D 1dc5d4067 PUD 1db5fa067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 7609 Comm: syz-executor4 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:qdisc_dev include/net/sch_generic.h:379 [inline]
> RIP: 0010:tc_fill_qdisc+0xc8/0x4b0 net/sched/sch_api.c:792
> RSP: 0018:ffffc90000ea38c8 EFLAGS: 00010212
> RAX: 0000000000000000 RBX: ffff880216ac3c00 RCX: ffffffff8212563c
> RDX: 0000000000000a02 RSI: ffffc90004f53000 RDI: ffff8801dc6a20b0
> RBP: ffffc90000ea3970 R08: 0000000000000014 R09: ffff8801dc6a20b0
> R10: ffffc90000ea37d8 R11: 0000000000000002 R12: ffff880214161b00
> R13: ffff8801dc6a208c R14: 0000000000000000 R15: 0000000000000002
> FS:  00007f6db5bc5700(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000001dc75a000 CR4: 00000000001426f0
> DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  tc_dump_qdisc_root+0x1f1/0x220 net/sched/sch_api.c:1474
>  tc_dump_qdisc+0x1a1/0x280 net/sched/sch_api.c:1540
>  netlink_dump+0x14e/0x360 net/netlink/af_netlink.c:2222
>  __netlink_dump_start+0x1bb/0x210 net/netlink/af_netlink.c:2319
>  netlink_dump_start include/linux/netlink.h:214 [inline]
>  rtnetlink_rcv_msg+0x44f/0x5d0 net/core/rtnetlink.c:4485
>  netlink_rcv_skb+0x92/0x160 net/netlink/af_netlink.c:2441
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4540
>  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
>  netlink_unicast+0x1d4/0x290 net/netlink/af_netlink.c:1334
>  netlink_sendmsg+0x345/0x470 net/netlink/af_netlink.c:1897
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0x51/0x70 net/socket.c:646
>  ___sys_sendmsg+0x35e/0x3b0 net/socket.c:2026
>  __sys_sendmsg+0x50/0x90 net/socket.c:2060
>  SYSC_sendmsg net/socket.c:2071 [inline]
>  SyS_sendmsg+0x2d/0x50 net/socket.c:2067
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007f6db5bc4c58 EFLAGS: 00000212 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 0000000000452a39
> RDX: 0000000000000000 RSI: 000000002061efc8 RDI: 000000000000001c
> RBP: 0000000000000343 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f2ee8
> R13: 00000000ffffffff R14: 00007f6db5bc56d4 R15: 0000000000000000
> Code: 41 b8 14 00 00 00 4c 89 e7 e8 05 17 01 00 48 85 c0 49 89 c5 0f 84 cb
> 02 00 00 e8 04 4d 19 ff 41 c7 45 10 00 00 00 00 48 8b 43 40 <48> 8b 00 8b 80
> 08 01 00 00 45 89 75 1c 41 89 45 14 8b 43 38 41
> RIP: qdisc_dev include/net/sch_generic.h:379 [inline] RSP: ffffc90000ea38c8
> RIP: tc_fill_qdisc+0xc8/0x4b0 net/sched/sch_api.c:792 RSP: ffffc90000ea38c8
> CR2: 0000000000000000
> ---[ end trace dffd1876816a33a6 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
