Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeAaCFn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:05:43 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35796 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeAaCFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:05:41 -0500
X-Google-Smtp-Source: AH8x225tmt8ePAoG8XAxMZxO6gCl3r1Pz2TPW3LFFVRw9ONRyYGMnlmwOvUL/3x7ozR0SZQz7/oubQ==
Date: Tue, 30 Jan 2018 18:05:37 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+c5b4138ce94ed34698659e1f70566b4ecaac6120@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        Florian Westphal <fw@strlen.de>
Subject: Re: KASAN: use-after-free Read in __xfrm_state_lookup
Message-ID: <20180131020537.sdptwvz6okho4kef@gmail.com>
References: <94eb2c05815016ca9c055cef9236@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c05815016ca9c055cef9236@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2017 at 10:55:01AM -0700, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 33ad61d0f799656e8987e9c80e6e15151bb857f3
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> ==================================================================
> BUG: KASAN: use-after-free in __xfrm_state_lookup+0x695/0x6b0
> net/xfrm/xfrm_state.c:833
> Read of size 4 at addr ffff8801d434e538 by task syzkaller647520/2991
> 
> CPU: 1 PID: 2991 Comm: syzkaller647520 Not tainted 4.14.0-rc5+ #89
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:429
>  __xfrm_state_lookup+0x695/0x6b0 net/xfrm/xfrm_state.c:833
>  xfrm_state_lookup+0x8a/0x160 net/xfrm/xfrm_state.c:1592
>  xfrm_input+0x8e5/0x22f0 net/xfrm/xfrm_input.c:302
>  xfrm6_rcv_spi net/ipv6/xfrm6_input.c:30 [inline]
>  xfrm6_rcv_tnl+0x168/0x1d0 net/ipv6/xfrm6_input.c:64
>  xfrm6_rcv+0x17/0x20 net/ipv6/xfrm6_input.c:71
>  xfrm6_ah_rcv+0x166/0x300 net/ipv6/xfrm6_protocol.c:101
>  ip6_input_finish+0x36f/0x1700 net/ipv6/ip6_input.c:284
>  NF_HOOK include/linux/netfilter.h:249 [inline]
>  ip6_input+0xe9/0x560 net/ipv6/ip6_input.c:327
>  dst_input include/net/dst.h:465 [inline]
>  ip6_rcv_finish+0x1a9/0x7a0 net/ipv6/ip6_input.c:71
>  NF_HOOK include/linux/netfilter.h:249 [inline]
>  ipv6_rcv+0xf28/0x1f80 net/ipv6/ip6_input.c:208
>  __netif_receive_skb_core+0x1a3e/0x34b0 net/core/dev.c:4477
>  __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4542
>  process_backlog+0x203/0x740 net/core/dev.c:5221
>  napi_poll net/core/dev.c:5619 [inline]
>  net_rx_action+0x792/0x1910 net/core/dev.c:5685
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:284
>  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:957
>  </IRQ>
>  do_softirq.part.22+0x14d/0x190 kernel/softirq.c:328
>  do_softirq kernel/softirq.c:176 [inline]
>  __local_bh_enable_ip+0x135/0x160 kernel/softirq.c:181
>  local_bh_enable include/linux/bottom_half.h:31 [inline]
>  rcu_read_unlock_bh include/linux/rcupdate.h:727 [inline]
>  ip6_finish_output2+0xb26/0x22a0 net/ipv6/ip6_output.c:121
>  ip6_finish_output+0x2f9/0x920 net/ipv6/ip6_output.c:146
>  NF_HOOK_COND include/linux/netfilter.h:238 [inline]
>  ip6_output+0x1f4/0x850 net/ipv6/ip6_output.c:163
>  dst_output include/net/dst.h:459 [inline]
>  ip6_local_out+0x95/0x160 net/ipv6/output_core.c:176
>  ip6_send_skb+0xa1/0x330 net/ipv6/ip6_output.c:1658
>  ip6_push_pending_frames+0xb3/0xe0 net/ipv6/ip6_output.c:1678
>  rawv6_push_pending_frames net/ipv6/raw.c:616 [inline]
>  rawv6_sendmsg+0x2eb9/0x3e40 net/ipv6/raw.c:935
>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:763
>  sock_sendmsg_nosec net/socket.c:633 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:643
>  SYSC_sendto+0x352/0x5a0 net/socket.c:1750
>  SyS_sendto+0x40/0x50 net/socket.c:1718
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
[...]
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title

Crash is no longer occurring, thanks Florian!

#syz fix: xfrm: defer daddr pointer assignment after spi parsing
