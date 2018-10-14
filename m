Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D62C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAB72077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAB72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJNXqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:46:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35640 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbeJNXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:41 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cU-8j; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000M5-UI; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.162410555@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 158/366] net: af_packet: fix race in PACKET_{R|T}X_RING
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

commit 5171b37d959641bbc619781caf62e61f7b940871 upstream.

In order to remove the race caught by syzbot [1], we need
to lock the socket before using po->tp_version as this could
change under us otherwise.

This means lock_sock() and release_sock() must be done by
packet_set_ring() callers.

[1] :
BUG: KMSAN: uninit-value in packet_set_ring+0x1254/0x3870 net/packet/af_packet.c:4249
CPU: 0 PID: 20195 Comm: syzkaller707632 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 packet_set_ring+0x1254/0x3870 net/packet/af_packet.c:4249
 packet_setsockopt+0x12c6/0x5a90 net/packet/af_packet.c:3662
 SYSC_setsockopt+0x4b8/0x570 net/socket.c:1849
 SyS_setsockopt+0x76/0xa0 net/socket.c:1828
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x449099
RSP: 002b:00007f42b5307ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000000000070003c RCX: 0000000000449099
RDX: 0000000000000005 RSI: 0000000000000107 RDI: 0000000000000003
RBP: 0000000000700038 R08: 000000000000001c R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000080eecf R14: 00007f42b53089c0 R15: 0000000000000001

Local variable description: ----req_u@packet_setsockopt
Variable was created at:
 packet_setsockopt+0x13f/0x5a90 net/packet/af_packet.c:3612
 SYSC_setsockopt+0x4b8/0x570 net/socket.c:1849

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: PACKET_VNET_HDR is incompatible with
 PACKET_{TX,RX}_RING; fix up the check for that as well]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2651,6 +2651,7 @@ static int packet_release(struct socket
 
 	packet_flush_mclist(sk);
 
+	lock_sock(sk);
 	if (po->rx_ring.pg_vec) {
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 0);
@@ -2660,6 +2661,7 @@ static int packet_release(struct socket
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 1);
 	}
+	release_sock(sk);
 
 	f = fanout_release(sk);
 
@@ -3295,6 +3297,7 @@ packet_setsockopt(struct socket *sock, i
 		union tpacket_req_u req_u;
 		int len;
 
+		lock_sock(sk);
 		switch (po->tp_version) {
 		case TPACKET_V1:
 		case TPACKET_V2:
@@ -3305,14 +3308,19 @@ packet_setsockopt(struct socket *sock, i
 			len = sizeof(req_u.req3);
 			break;
 		}
-		if (optlen < len)
-			return -EINVAL;
-		if (pkt_sk(sk)->has_vnet_hdr)
-			return -EINVAL;
-		if (copy_from_user(&req_u.req, optval, len))
-			return -EFAULT;
-		return packet_set_ring(sk, &req_u, 0,
-			optname == PACKET_TX_RING);
+		if (optlen < len) {
+			ret = -EINVAL;
+		} else if (pkt_sk(sk)->has_vnet_hdr) {
+			ret = -EINVAL;
+		} else {
+			if (copy_from_user(&req_u.req, optval, len))
+				ret = -EFAULT;
+			else
+				ret = packet_set_ring(sk, &req_u, 0,
+						    optname == PACKET_TX_RING);
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_COPY_THRESH:
 	{
@@ -3820,7 +3828,6 @@ static int packet_set_ring(struct sock *
 	/* Added to avoid minimal code churn */
 	struct tpacket_req *req = &req_u->req;
 
-	lock_sock(sk);
 	/* Opening a Tx-ring is NOT supported in TPACKET_V3 */
 	if (!closing && tx_ring && (po->tp_version > TPACKET_V2)) {
 		WARN(1, "Tx-ring is not supported.\n");
@@ -3956,7 +3963,6 @@ static int packet_set_ring(struct sock *
 	if (pg_vec)
 		free_pg_vec(pg_vec, order, req->tp_block_nr);
 out:
-	release_sock(sk);
 	return err;
 }
 

