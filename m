Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D022206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D022206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeIMTUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:20:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbeIMTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 236F2CE7;
        Thu, 13 Sep 2018 13:52:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Tesar <mtesar@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 009/197] tcp: do not restart timewait timer on rst reception
Date:   Thu, 13 Sep 2018 15:29:18 +0200
Message-Id: <20180913131841.941076353@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 63cc357f7bba6729869565a12df08441a5995d9a ]

RFC 1337 says:
 ''Ignore RST segments in TIME-WAIT state.
   If the 2 minute MSL is enforced, this fix avoids all three hazards.''

So with net.ipv4.tcp_rfc1337=1, expected behaviour is to have TIME-WAIT sk
expire rather than removing it instantly when a reset is received.

However, Linux will also re-start the TIME-WAIT timer.

This causes connect to fail when tying to re-use ports or very long
delays (until syn retry interval exceeds MSL).

packetdrill test case:
// Demonstrate bogus rearming of TIME-WAIT timer in rfc1337 mode.
`sysctl net.ipv4.tcp_rfc1337=1`

0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
0.000 bind(3, ..., ...) = 0
0.000 listen(3, 1) = 0

0.100 < S 0:0(0) win 29200 <mss 1460,nop,nop,sackOK,nop,wscale 7>
0.100 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 7>
0.200 < . 1:1(0) ack 1 win 257
0.200 accept(3, ..., ...) = 4

// Receive first segment
0.310 < P. 1:1001(1000) ack 1 win 46

// Send one ACK
0.310 > . 1:1(0) ack 1001

// read 1000 byte
0.310 read(4, ..., 1000) = 1000

// Application writes 100 bytes
0.350 write(4, ..., 100) = 100
0.350 > P. 1:101(100) ack 1001

// ACK
0.500 < . 1001:1001(0) ack 101 win 257

// close the connection
0.600 close(4) = 0
0.600 > F. 101:101(0) ack 1001 win 244

// Our side is in FIN_WAIT_1 & waits for ack to fin
0.7 < . 1001:1001(0) ack 102 win 244

// Our side is in FIN_WAIT_2 with no outstanding data.
0.8 < F. 1001:1001(0) ack 102 win 244
0.8 > . 102:102(0) ack 1002 win 244

// Our side is now in TIME_WAIT state, send ack for fin.
0.9 < F. 1002:1002(0) ack 102 win 244
0.9 > . 102:102(0) ack 1002 win 244

// Peer reopens with in-window SYN:
1.000 < S 1000:1000(0) win 9200 <mss 1460,nop,nop,sackOK,nop,wscale 7>

// Therefore, reply with ACK.
1.000 > . 102:102(0) ack 1002 win 244

// Peer sends RST for this ACK.  Normally this RST results
// in tw socket removal, but rfc1337=1 setting prevents this.
1.100 < R 1002:1002(0) win 244

// second syn. Due to rfc1337=1 expect another pure ACK.
31.0 < S 1000:1000(0) win 9200 <mss 1460,nop,nop,sackOK,nop,wscale 7>
31.0 > . 102:102(0) ack 1002 win 244

// .. and another RST from peer.
31.1 < R 1002:1002(0) win 244
31.2 `echo no timer restart;ss -m -e -a -i -n -t -o state TIME-WAIT`

// third syn after one minute.  Time-Wait socket should have expired by now.
63.0 < S 1000:1000(0) win 9200 <mss 1460,nop,nop,sackOK,nop,wscale 7>

// so we expect a syn-ack & 3whs to proceed from here on.
63.0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 7>

Without this patch, 'ss' shows restarts of tw timer and last packet is
thus just another pure ack, more than one minute later.

This restores the original code from commit 283fd6cf0be690a83
("Merge in ANK networking jumbo patch") in netdev-vger-cvs.git .

For some reason the else branch was removed/lost in 1f28b683339f7
("Merge in TCP/UDP optimizations and [..]") and timer restart became
unconditional.

Reported-by: Michal Tesar <mtesar@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_minisocks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -184,8 +184,9 @@ kill:
 				inet_twsk_deschedule_put(tw);
 				return TCP_TW_SUCCESS;
 			}
+		} else {
+			inet_twsk_reschedule(tw, TCP_TIMEWAIT_LEN);
 		}
-		inet_twsk_reschedule(tw, TCP_TIMEWAIT_LEN);
 
 		if (tmp_opt.saw_tstamp) {
 			tcptw->tw_ts_recent	  = tmp_opt.rcv_tsval;


