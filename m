Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F591C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C72084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSESv/5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4C72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbeKCEBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:42 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086002082D;
        Fri,  2 Nov 2018 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184806;
        bh=IuUrZmmVaMPC+lwocT/LsJk9XeOxOOAJHq9wL8S0E84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSESv/5Ne1PthCjY8SMimsq8ZwzAUYs5pBzEGVr7JYVcEUo7F0i4X7wM04hXwX7Vu
         8TUJdoHfleJKBtQvB8UjgyJyK72pVfx/xiO/QVjQvfWfqoc1XozT2Zg/YN/CeIakmf
         9MYJjqrq5BT05zbqZPsIpuVlz8v0WjuyNyupsHbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 099/143] rxrpc: Dont check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()
Date:   Fri,  2 Nov 2018 19:34:44 +0100
Message-Id: <20181102182905.776106146@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



