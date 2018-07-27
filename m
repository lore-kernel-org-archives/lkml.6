Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF9C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B746120895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B746120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbeG0LJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388594AbeG0LJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:31 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7B19AF8;
        Fri, 27 Jul 2018 09:48:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Brakmo <brakmo@fb.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 20/66] tcp: fix dctcp delayed ACK schedule
Date:   Fri, 27 Jul 2018 11:45:13 +0200
Message-Id: <20180727093811.420620747@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
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

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit b0c05d0e99d98d7f0cd41efc1eeec94efdc3325d ]

Previously, when a data segment was sent an ACK was piggybacked
on the data segment without generating a CA_EVENT_NON_DELAYED_ACK
event to notify congestion control modules. So the DCTCP
ca->delayed_ack_reserved flag could incorrectly stay set when
in fact there were no delayed ACKs being reserved. This could result
in sending a special ECN notification ACK that carries an older
ACK sequence, when in fact there was no need for such an ACK.
DCTCP keeps track of the delayed ACK status with its own separate
state ca->delayed_ack_reserved. Previously it may accidentally cancel
the delayed ACK without updating this field upon sending a special
ACK that carries a older ACK sequence. This inconsistency would
lead to DCTCP receiver never acknowledging the latest data until the
sender times out and retry in some cases.

Packetdrill script (provided by Larry Brakmo)

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

Reported-by: Larry Brakmo <brakmo@fb.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_dctcp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -134,7 +134,8 @@ static void dctcp_ce_state_0_to_1(struct
 	/* State has changed from CE=0 to CE=1 and delayed
 	 * ACK has not sent yet.
 	 */
-	if (!ca->ce_state && ca->delayed_ack_reserved) {
+	if (!ca->ce_state &&
+	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
 		u32 tmp_rcv_nxt;
 
 		/* Save current rcv_nxt. */
@@ -164,7 +165,8 @@ static void dctcp_ce_state_1_to_0(struct
 	/* State has changed from CE=1 to CE=0 and delayed
 	 * ACK has not sent yet.
 	 */
-	if (ca->ce_state && ca->delayed_ack_reserved) {
+	if (ca->ce_state &&
+	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
 		u32 tmp_rcv_nxt;
 
 		/* Save current rcv_nxt. */


