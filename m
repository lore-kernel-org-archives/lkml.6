Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA7C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1C420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1C420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbeLIWJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37446 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbeLIWJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:39 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73E-0002ib-F6; Sun, 09 Dec 2018 21:55:48 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003O7-CW; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wei Wang" <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "Cong Wang" <xiyou.wangcong@gmail.com>,
        "Martin KaFai Lau" <kafai@fb.com>,
        "David Ahern" <dsahern@gmail.com>,
        syzbot+05f840f3b04f211bad55@syzkaller.appspotmail.com
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.831452617@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 135/328] l2tp: use sk_dst_check() to avoid race on
 sk->sk_dst_cache
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Wang <weiwan@google.com>

commit 6d37fa49da1e8db8fb1995be22ac837ca41ac8a8 upstream.

In l2tp code, if it is a L2TP_UDP_ENCAP tunnel, tunnel->sk points to a
UDP socket. User could call sendmsg() on both this tunnel and the UDP
socket itself concurrently. As l2tp_xmit_skb() holds socket lock and call
__sk_dst_check() to refresh sk->sk_dst_cache, while udpv6_sendmsg() is
lockless and call sk_dst_check() to refresh sk->sk_dst_cache, there
could be a race and cause the dst cache to be freed multiple times.
So we fix l2tp side code to always call sk_dst_check() to garantee
xchg() is called when refreshing sk->sk_dst_cache to avoid race
conditions.

Syzkaller reported stack trace:
BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: use-after-free in atomic_fetch_add_unless include/linux/atomic.h:575 [inline]
BUG: KASAN: use-after-free in atomic_add_unless include/linux/atomic.h:597 [inline]
BUG: KASAN: use-after-free in dst_hold_safe include/net/dst.h:308 [inline]
BUG: KASAN: use-after-free in ip6_hold_safe+0xe6/0x670 net/ipv6/route.c:1029
Read of size 4 at addr ffff8801aea9a880 by task syz-executor129/4829

CPU: 0 PID: 4829 Comm: syz-executor129 Not tainted 4.18.0-rc7-next-20180802+ #30
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
 kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
 atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
 atomic_fetch_add_unless include/linux/atomic.h:575 [inline]
 atomic_add_unless include/linux/atomic.h:597 [inline]
 dst_hold_safe include/net/dst.h:308 [inline]
 ip6_hold_safe+0xe6/0x670 net/ipv6/route.c:1029
 rt6_get_pcpu_route net/ipv6/route.c:1249 [inline]
 ip6_pol_route+0x354/0xd20 net/ipv6/route.c:1922
 ip6_pol_route_output+0x54/0x70 net/ipv6/route.c:2098
 fib6_rule_lookup+0x283/0x890 net/ipv6/fib6_rules.c:122
 ip6_route_output_flags+0x2c5/0x350 net/ipv6/route.c:2126
 ip6_dst_lookup_tail+0x1278/0x1da0 net/ipv6/ip6_output.c:978
 ip6_dst_lookup_flow+0xc8/0x270 net/ipv6/ip6_output.c:1079
 ip6_sk_dst_lookup_flow+0x5ed/0xc50 net/ipv6/ip6_output.c:1117
 udpv6_sendmsg+0x2163/0x36b0 net/ipv6/udp.c:1354
 inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
 sock_sendmsg_nosec net/socket.c:622 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:632
 ___sys_sendmsg+0x51d/0x930 net/socket.c:2115
 __sys_sendmmsg+0x240/0x6f0 net/socket.c:2210
 __do_sys_sendmmsg net/socket.c:2239 [inline]
 __se_sys_sendmmsg net/socket.c:2236 [inline]
 __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2236
 do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a29
Code: e8 ac b8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4de5532db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 0000000000446a29
RDX: 00000000000000b8 RSI: 0000000020001b00 RDI: 0000000000000003
RBP: 00000000006dcc30 R08: 00007f4de5533700 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffe2b830fdf R14: 00007f4de55339c0 R15: 0000000000000001

Fixes: 71b1391a4128 ("l2tp: ensure sk->dst is still valid")
Reported-by: syzbot+05f840f3b04f211bad55@syzkaller.appspotmail.com
Signed-off-by: Wei Wang <weiwan@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Cc: Guillaume Nault <g.nault@alphalink.fr>
Cc: David Ahern <dsahern@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1195,7 +1195,7 @@ int l2tp_xmit_skb(struct l2tp_session *s
 
 	/* Get routing info from the tunnel socket */
 	skb_dst_drop(skb);
-	skb_dst_set(skb, dst_clone(__sk_dst_check(sk, 0)));
+	skb_dst_set(skb, sk_dst_check(sk, 0));
 
 	inet = inet_sk(sk);
 	fl = &inet->cork.fl;

