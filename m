Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeBGGrV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 01:47:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750729AbeBGGrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 01:47:20 -0500
Subject: Re: WARNING: kmalloc bug in tun_device_event
To: syzbot <syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com>,
        Linyu.Yuan@alcatel-sbell.com.cn, davem@davemloft.net,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, peterpenkov96@gmail.com,
        syzkaller-bugs@googlegroups.com, willemb@google.com,
        xiyou.wangcong@gmail.com
References: <089e082603c453a0730564931ce5@google.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7de8cd87-021a-5c8f-7df4-07be1ca651a5@redhat.com>
Date: Wed, 7 Feb 2018 14:47:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <089e082603c453a0730564931ce5@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月07日 06:58, syzbot wrote:
> Hello,
>
> syzbot hit the following crash on net-next commit
> 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
> Merge tag 'usercopy-v4.16-rc1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
>
> So far this crash happened 5 times on net-next, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
>
> IMPORTANT: if you fix the bug, please add the following tag to the 
> commit:
> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for 
> details.
> If you forward the report, please keep this part and the footer.
>
> WARNING: CPU: 1 PID: 4134 at mm/slab_common.c:1012 
> kmalloc_slab+0x5d/0x70 mm/slab_common.c:1012
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 4134 Comm: syzkaller993072 Not tainted 4.15.0+ #221
> Hardware name: Google Google Compute Engine/Google Compute Engine, 
> BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1097
> RIP: 0010:kmalloc_slab+0x5d/0x70 mm/slab_common.c:1012
> RSP: 0018:ffff8801ba7ceb20 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83b88bed
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000400000008
> RBP: ffff8801ba7ceb20 R08: 1ffff100374f9cd7 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000400000008
> R13: dffffc0000000000 R14: 00000000014080c0 R15: ffff8801b5d52080
>  __do_kmalloc mm/slab.c:3700 [inline]
>  __kmalloc+0x25/0x760 mm/slab.c:3714
>  kmalloc_array include/linux/slab.h:631 [inline]
>  kcalloc include/linux/slab.h:642 [inline]
>  __ptr_ring_init_queue_alloc include/linux/ptr_ring.h:469 [inline]
>  ptr_ring_resize_multiple include/linux/ptr_ring.h:629 [inline]
>  tun_queue_resize drivers/net/tun.c:3319 [inline]
>  tun_device_event+0x471/0xec0 drivers/net/tun.c:3338
>  notifier_call_chain+0x136/0x2c0 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x32/0x70 net/core/dev.c:1707
>  call_netdevice_notifiers net/core/dev.c:1725 [inline]
>  dev_change_tx_queue_len+0x117/0x220 net/core/dev.c:7065
>  do_setlink+0xba7/0x3bb0 net/core/rtnetlink.c:2341
>  rtnl_newlink+0xf1c/0x1a20 net/core/rtnetlink.c:2915
>  rtnetlink_rcv_msg+0x57f/0xb10 net/core/rtnetlink.c:4587
>  netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2442
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4605
>  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
>  netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1334
>  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1897
>  sock_sendmsg_nosec net/socket.c:630 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:640
>  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
>  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
>  SYSC_sendmsg net/socket.c:2091 [inline]
>  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x4463c9
> RSP: 002b:00007ffe63916e68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004a7af2 RCX: 00000000004463c9
> RDX: 0000000000000000 RSI: 0000000020504000 RDI: 0000000000000004
> RBP: 00007ffe63916f08 R08: 0000000000000000 R09: 00000000004a7af2
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe63916f08
> R13: 0000000000403890 R14: 0000000000000000 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is 
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug 
> report.
> Note: all commands must start from beginning of the line in the email 
> body.

Looks like we need cap the maximum size that ptr_ring could allocate.

Will post a patch soon.

Thanks
