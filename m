Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B0C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE74220898
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhrB+XCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74220898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeJVSis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbeJVSiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:46 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7896320853;
        Mon, 22 Oct 2018 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203651;
        bh=LoLbC/QBJ0DUinMpR1hFz2dR7ZnkbHAhui0aPebjn1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhrB+XCDPful0n7bX/U5VfGG7qwU5bZ0shhUAMvPu+S2VVmhvyafT2/cqyjHQdj3X
         l/P769Tqq08EmwiFz9F43WvW8lTbygvtIGPkbMGJPhMAaJRwQ1NUf6MH25Y/va9eIf
         lBrfSxMsfheXRWbNLeG+uAy+tKZa93rcRY0oPnIw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 08/15] rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()
Date:   Mon, 22 Oct 2018 06:20:19 -0400
Message-Id: <20181022102026.40869-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102026.40869-1-sashal@kernel.org>
References: <20181022102026.40869-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit c479d5f2c2e1ce609da08c075054440d97ddff52 ]

We should only call the function to end a call's Tx phase if we rotated the
marked-last packet out of the transmission buffer.

Make rxrpc_rotate_tx_window() return an indication of whether it just
rotated the packet marked as the last out of the transmit buffer, carrying
the information out of the locked section in that function.

We can then check the return value instead of examining RXRPC_CALL_TX_LAST.

Fixes: 70790dbe3f66 ("rxrpc: Pass the last Tx packet marker in the annotation buffer")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 5edb636dbc4d..3a501bf0fc1a 100644
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
 				ktime_get_real());
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
@@ -837,8 +842,12 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
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
@@ -847,11 +856,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
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
@@ -873,8 +877,7 @@ static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 
 	_proto("Rx ACKALL %%%u", sp->hdr.serial);
 
-	rxrpc_rotate_tx_window(call, call->tx_top, &summary);
-	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags))
+	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
 		rxrpc_end_tx_phase(call, false, "ETL");
 }
 
-- 
2.17.1

