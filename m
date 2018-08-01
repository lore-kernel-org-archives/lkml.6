Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EE6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FAF2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FAF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733068AbeHAUOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:14:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404271AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9D0471322;
        Wed,  1 Aug 2018 17:11:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 334/336] tcp: ack immediately when a cwr packet arrives
Date:   Wed,  1 Aug 2018 18:51:09 +0200
Message-Id: <20180801165041.808784551@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lawrence Brakmo <brakmo@fb.com>

[ Upstream commit 9aee40006190a3cda9a4d2dbae71e92617c8c362 ]

We observed high 99 and 99.9% latencies when doing RPCs with DCTCP. The
problem is triggered when the last packet of a request arrives CE
marked. The reply will carry the ECE mark causing TCP to shrink its cwnd
to 1 (because there are no packets in flight). When the 1st packet of
the next request arrives, the ACK was sometimes delayed even though it
is CWR marked, adding up to 40ms to the RPC latency.

This patch insures that CWR marked data packets arriving will be acked
immediately.

Packetdrill script to reproduce the problem:

0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
0.000 setsockopt(3, SOL_TCP, TCP_CONGESTION, "dctcp", 5) = 0
0.000 bind(3, ..., ...) = 0
0.000 listen(3, 1) = 0

0.100 < [ect0] SEW 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
0.100 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
0.110 < [ect0] . 1:1(0) ack 1 win 257
0.200 accept(3, ..., ...) = 4

0.200 < [ect0] . 1:1001(1000) ack 1 win 257
0.200 > [ect01] . 1:1(0) ack 1001

0.200 write(4, ..., 1) = 1
0.200 > [ect01] P. 1:2(1) ack 1001

0.200 < [ect0] . 1001:2001(1000) ack 2 win 257
0.200 write(4, ..., 1) = 1
0.200 > [ect01] P. 2:3(1) ack 2001

0.200 < [ect0] . 2001:3001(1000) ack 3 win 257
0.200 < [ect0] . 3001:4001(1000) ack 3 win 257
0.200 > [ect01] . 3:3(0) ack 4001

0.210 < [ce] P. 4001:4501(500) ack 3 win 257

+0.001 read(4, ..., 4500) = 4500
+0 write(4, ..., 1) = 1
+0 > [ect01] PE. 3:4(1) ack 4501

+0.010 < [ect0] W. 4501:5501(1000) ack 4 win 257
// Previously the ACK sequence below would be 4501, causing a long RTO
+0.040~+0.045 > [ect01] . 4:4(0) ack 5501   // delayed ack

+0.311 < [ect0] . 5501:6501(1000) ack 4 win 257  // More data
+0 > [ect01] . 4:4(0) ack 6501     // now acks everything

+0.500 < F. 9501:9501(0) ack 4 win 257

Modified based on comments by Neal Cardwell <ncardwell@google.com>

Signed-off-by: Lawrence Brakmo <brakmo@fb.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -227,8 +227,15 @@ static void tcp_ecn_queue_cwr(struct tcp
 
 static void tcp_ecn_accept_cwr(struct tcp_sock *tp, const struct sk_buff *skb)
 {
-	if (tcp_hdr(skb)->cwr)
+	if (tcp_hdr(skb)->cwr) {
 		tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+
+		/* If the sender is telling us it has entered CWR, then its
+		 * cwnd may be very low (even just 1 packet), so we should ACK
+		 * immediately.
+		 */
+		tcp_enter_quickack_mode((struct sock *)tp, 2);
+	}
 }
 
 static void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)


