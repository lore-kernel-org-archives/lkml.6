Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D2EC67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8A21476
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD8A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJIGB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:01:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJIGB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 431F7C058CB9;
        Mon,  8 Oct 2018 22:47:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E41855B0B3;
        Mon,  8 Oct 2018 22:47:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 05/10] rxrpc: Don't check RXRPC_CALL_TX_LAST after
 calling rxrpc_rotate_tx_window()
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:47:56 +0100
Message-ID: <153903887596.17944.993399685251632858.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 08 Oct 2018 22:47:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should only call the function to end a call's Tx phase if we rotated the
marked-last packet out of the transmission buffer.

Make rxrpc_rotate_tx_window() return an indication of whether it just
rotated the packet marked as the last out of the transmit buffer, carrying
the information out of the locked section in that function.

We can then check the return value instead of examining RXRPC_CALL_TX_LAST.

Fixes: 70790dbe3f66 ("rxrpc: Pass the last Tx packet marker in the annotation buffer")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 2dcef482acf2..8834aa627371 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -216,10 +216,11 @@ static void rxrpc_send_ping(struct rxrpc_call *call, struct sk_buff *skb,
 /*
  * Apply a hard ACK by advancing the Tx window.
  */
-static void rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
+static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 				   struct rxrpc_ack_summary *summary)
 {
 	struct sk_buff *skb, *list = NULL;
+	bool rot_last = false;
 	int ix;
 	u8 annotation;
 
@@ -243,15 +244,17 @@ static void rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		skb->next = list;
 		list = skb;
 
-		if (annotation & RXRPC_TX_ANNO_LAST)
+		if (annotation & RXRPC_TX_ANNO_LAST) {
 			set_bit(RXRPC_CALL_TX_LAST, &call->flags);
+			rot_last = true;
+		}
 		if ((annotation & RXRPC_TX_ANNO_MASK) != RXRPC_TX_ANNO_ACK)
 			summary->nr_rot_new_acks++;
 	}
 
 	spin_unlock(&call->lock);
 
-	trace_rxrpc_transmit(call, (test_bit(RXRPC_CALL_TX_LAST, &call->flags) ?
+	trace_rxrpc_transmit(call, (rot_last ?
 				    rxrpc_transmit_rotate_last :
 				    rxrpc_transmit_rotate));
 	wake_up(&call->waitq);
@@ -262,6 +265,8 @@ static void rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		skb->next = NULL;
 		rxrpc_free_skb(skb, rxrpc_skb_tx_freed);
 	}
+
+	return rot_last;
 }
 
 /*
@@ -332,11 +337,11 @@ static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 		trace_rxrpc_timer(call, rxrpc_timer_init_for_reply, now);
 	}
 
-	if (!test_bit(RXRPC_CALL_TX_LAST, &call->flags))
-		rxrpc_rotate_tx_window(call, top, &summary);
 	if (!test_bit(RXRPC_CALL_TX_LAST, &call->flags)) {
-		rxrpc_proto_abort("TXL", call, top);
-		return false;
+		if (!rxrpc_rotate_tx_window(call, top, &summary)) {
+			rxrpc_proto_abort("TXL", call, top);
+			return false;
+		}
 	}
 	if (!rxrpc_end_tx_phase(call, true, "ETD"))
 		return false;
@@ -897,8 +902,12 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 	if (nr_acks > call->tx_top - hard_ack)
 		return rxrpc_proto_abort("AKN", call, 0);
 
-	if (after(hard_ack, call->tx_hard_ack))
-		rxrpc_rotate_tx_window(call, hard_ack, &summary);
+	if (after(hard_ack, call->tx_hard_ack)) {
+		if (rxrpc_rotate_tx_window(call, hard_ack, &summary)) {
+			rxrpc_end_tx_phase(call, false, "ETA");
+			return;
+		}
+	}
 
 	if (nr_acks > 0) {
 		if (skb_copy_bits(skb, offset, buf.acks, nr_acks) < 0)
@@ -907,11 +916,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 				      &summary);
 	}
 
-	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags)) {
-		rxrpc_end_tx_phase(call, false, "ETA");
-		return;
-	}
-
 	if (call->rxtx_annotations[call->tx_top & RXRPC_RXTX_BUFF_MASK] &
 	    RXRPC_TX_ANNO_LAST &&
 	    summary.nr_acks == call->tx_top - hard_ack &&
@@ -933,8 +937,7 @@ static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 
 	_proto("Rx ACKALL %%%u", sp->hdr.serial);
 
-	rxrpc_rotate_tx_window(call, call->tx_top, &summary);
-	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags))
+	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
 		rxrpc_end_tx_phase(call, false, "ETL");
 }
 

