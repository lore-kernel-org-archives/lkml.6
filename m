Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69F020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69F020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966314AbeFRI04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:26:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965815AbeFRI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F2DEBAD;
        Mon, 18 Jun 2018 08:26:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 216/279] rxrpc: Fix missing start of call timeout
Date:   Mon, 18 Jun 2018 10:13:21 +0200
Message-Id: <20180618080617.795845373@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit c54e43d752c7187595c8c62a231e0b0d53c7fded ]

The expect_rx_by call timeout is supposed to be set when a call is started
to indicate that we need to receive a packet by that point.  This is
currently put back every time we receive a packet, but it isn't started
when we first send a packet.  Without this, the call may wait forever if
the server doesn't deign to reply.

Fix this by setting the timeout upon a successful UDP sendmsg call for the
first DATA packet.  The timeout is initiated only for initial transmission
and not for subsequent retries as we don't want the retry mechanism to
extend the timeout indefinitely.

Fixes: a158bdd3247b ("rxrpc: Fix call timeouts")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/input.c       |    2 +-
 net/rxrpc/output.c      |   11 +++++++++++
 net/rxrpc/sendmsg.c     |   10 ++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -464,6 +464,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_SEND_PING,		/* A ping will need to be sent */
 	RXRPC_CALL_PINGING,		/* Ping in process */
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
+	RXRPC_CALL_BEGAN_RX_TIMER,	/* We began the expect_rx_by timer */
 };
 
 /*
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -971,7 +971,7 @@ static void rxrpc_input_call_packet(stru
 	if (timo) {
 		unsigned long now = jiffies, expect_rx_by;
 
-		expect_rx_by = jiffies + timo;
+		expect_rx_by = now + timo;
 		WRITE_ONCE(call->expect_rx_by, expect_rx_by);
 		rxrpc_reduce_call_timer(call, expect_rx_by, now,
 					rxrpc_timer_set_for_normal);
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -407,6 +407,17 @@ done:
 							rxrpc_timer_set_for_lost_ack);
 			}
 		}
+
+		if (sp->hdr.seq == 1 &&
+		    !test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER,
+				      &call->flags)) {
+			unsigned long nowj = jiffies, expect_rx_by;
+
+			expect_rx_by = nowj + call->next_rx_timo;
+			WRITE_ONCE(call->expect_rx_by, expect_rx_by);
+			rxrpc_reduce_call_timer(call, expect_rx_by, nowj,
+						rxrpc_timer_set_for_normal);
+		}
 	}
 
 	rxrpc_set_keepalive(call);
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -223,6 +223,15 @@ static void rxrpc_queue_packet(struct rx
 
 	ret = rxrpc_send_data_packet(call, skb, false);
 	if (ret < 0) {
+		switch (ret) {
+		case -ENETUNREACH:
+		case -EHOSTUNREACH:
+		case -ECONNREFUSED:
+			rxrpc_set_call_completion(call,
+						  RXRPC_CALL_LOCAL_ERROR,
+						  0, ret);
+			goto out;
+		}
 		_debug("need instant resend %d", ret);
 		rxrpc_instant_resend(call, ix);
 	} else {
@@ -241,6 +250,7 @@ static void rxrpc_queue_packet(struct rx
 					rxrpc_timer_set_for_send);
 	}
 
+out:
 	rxrpc_free_skb(skb, rxrpc_skb_tx_freed);
 	_leave("");
 }


