Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E9C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BC120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BC120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeJNXTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:19:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36746 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728153AbeJNXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:19:03 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cf-60; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000Ko-Ek; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "syzbot" <syzkaller@googlegroups.com>,
        "Yuchung Cheng" <ycheng@google.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.657800249@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 142/366] tcp: md5: reject TCP_MD5SIG or
 TCP_MD5SIG_EXT on established sockets
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 7212303268918b9a203aebeacfdbd83b5e87b20d upstream.

syzbot/KMSAN reported an uninit-value in tcp_parse_options() [1]

I believe this was caused by a TCP_MD5SIG being set on live
flow.

This is highly unexpected, since TCP option space is limited.

For instance, presence of TCP MD5 option automatically disables
TCP TimeStamp option at SYN/SYNACK time, which we can not do
once flow has been established.

Really, adding/deleting an MD5 key only makes sense on sockets
in CLOSE or LISTEN state.

[1]
BUG: KMSAN: uninit-value in tcp_parse_options+0xd74/0x1a30 net/ipv4/tcp_input.c:3720
CPU: 1 PID: 6177 Comm: syzkaller192004 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 tcp_parse_options+0xd74/0x1a30 net/ipv4/tcp_input.c:3720
 tcp_fast_parse_options net/ipv4/tcp_input.c:3858 [inline]
 tcp_validate_incoming+0x4f1/0x2790 net/ipv4/tcp_input.c:5184
 tcp_rcv_established+0xf60/0x2bb0 net/ipv4/tcp_input.c:5453
 tcp_v4_do_rcv+0x6cd/0xd90 net/ipv4/tcp_ipv4.c:1469
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __release_sock+0x2d6/0x680 net/core/sock.c:2271
 release_sock+0x97/0x2a0 net/core/sock.c:2786
 tcp_sendmsg+0xd6/0x100 net/ipv4/tcp.c:1464
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
 SyS_sendto+0x8a/0xb0 net/socket.c:1715
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x448fe9
RSP: 002b:00007fd472c64d38 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000006e5a30 RCX: 0000000000448fe9
RDX: 000000000000029f RSI: 0000000020a88f88 RDI: 0000000000000004
RBP: 00000000006e5a34 R08: 0000000020e68000 R09: 0000000000000010
R10: 00000000200007fd R11: 0000000000000216 R12: 0000000000000000
R13: 00007fff074899ef R14: 00007fd472c659c0 R15: 0000000000000009

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
 kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
 slab_post_alloc_hook mm/slab.h:445 [inline]
 slab_alloc_node mm/slub.c:2737 [inline]
 __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
 __kmalloc_reserve net/core/skbuff.c:138 [inline]
 __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
 alloc_skb include/linux/skbuff.h:984 [inline]
 tcp_send_ack+0x18c/0x910 net/ipv4/tcp_output.c:3624
 __tcp_ack_snd_check net/ipv4/tcp_input.c:5040 [inline]
 tcp_ack_snd_check net/ipv4/tcp_input.c:5053 [inline]
 tcp_rcv_established+0x2103/0x2bb0 net/ipv4/tcp_input.c:5469
 tcp_v4_do_rcv+0x6cd/0xd90 net/ipv4/tcp_ipv4.c:1469
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __release_sock+0x2d6/0x680 net/core/sock.c:2271
 release_sock+0x97/0x2a0 net/core/sock.c:2786
 tcp_sendmsg+0xd6/0x100 net/ipv4/tcp.c:1464
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
 SyS_sendto+0x8a/0xb0 net/socket.c:1715
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2683,8 +2683,10 @@ static int do_tcp_setsockopt(struct sock
 
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
-		/* Read the IP->Key mappings from userspace */
-		err = tp->af_specific->md5_parse(sk, optval, optlen);
+		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+			err = tp->af_specific->md5_parse(sk, optval, optlen);
+		else
+			err = -EINVAL;
 		break;
 #endif
 	case TCP_USER_TIMEOUT:

