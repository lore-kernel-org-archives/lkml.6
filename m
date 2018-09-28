Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26083C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EA02172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EA02172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeI1QdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1QdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:33:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AB20300286E;
        Fri, 28 Sep 2018 10:10:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88B775D777;
        Fri, 28 Sep 2018 10:10:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 4/8] rxrpc: Emit BUSY packets when supposed to rather
 than ABORTs
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:10:21 +0100
Message-ID: <153812942175.10469.7486837009948924652.stgit@warthog.procyon.org.uk>
In-Reply-To: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
References: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 28 Sep 2018 10:10:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the input path, a received sk_buff can be marked for rejection by
setting RXRPC_SKB_MARK_* in skb->mark and, if needed, some auxiliary data
(such as an abort code) in skb->priority.  The rejection is handled by
queueing the sk_buff up for dealing with in process context.  The output
code reads the mark and priority and, theoretically, generates an
appropriate response packet.

However, if RXRPC_SKB_MARK_BUSY is set, this isn't noticed and an ABORT
message with a random abort code is generated (since skb->priority wasn't
set to anything).

Fix this by outputting the appropriate sort of packet.

Also, whilst we're at it, most of the marks are no longer used, so remove
them and rename the remaining two to something more obvious.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |   13 ++++---------
 net/rxrpc/call_accept.c |    6 +++---
 net/rxrpc/input.c       |    2 +-
 net/rxrpc/output.c      |   23 ++++++++++++++++++-----
 4 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9fcb3e197b14..e8861cb78070 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -40,17 +40,12 @@ struct rxrpc_crypt {
 struct rxrpc_connection;
 
 /*
- * Mark applied to socket buffers.
+ * Mark applied to socket buffers in skb->mark.  skb->priority is used
+ * to pass supplementary information.
  */
 enum rxrpc_skb_mark {
-	RXRPC_SKB_MARK_DATA,		/* data message */
-	RXRPC_SKB_MARK_FINAL_ACK,	/* final ACK received message */
-	RXRPC_SKB_MARK_BUSY,		/* server busy message */
-	RXRPC_SKB_MARK_REMOTE_ABORT,	/* remote abort message */
-	RXRPC_SKB_MARK_LOCAL_ABORT,	/* local abort message */
-	RXRPC_SKB_MARK_NET_ERROR,	/* network error message */
-	RXRPC_SKB_MARK_LOCAL_ERROR,	/* local error message */
-	RXRPC_SKB_MARK_NEW_CALL,	/* local error message */
+	RXRPC_SKB_MARK_REJECT_BUSY,	/* Reject with BUSY */
+	RXRPC_SKB_MARK_REJECT_ABORT,	/* Reject with ABORT (code in skb->priority) */
 };
 
 /*
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 9d1e298b784c..e88f131c1d7f 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -353,7 +353,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 
 	trace_rxrpc_abort(0, "INV", sp->hdr.cid, sp->hdr.callNumber, sp->hdr.seq,
 			  RX_INVALID_OPERATION, EOPNOTSUPP);
-	skb->mark = RXRPC_SKB_MARK_LOCAL_ABORT;
+	skb->mark = RXRPC_SKB_MARK_REJECT_ABORT;
 	skb->priority = RX_INVALID_OPERATION;
 	_leave(" = NULL [service]");
 	return NULL;
@@ -364,7 +364,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 	    rx->sk.sk_state == RXRPC_CLOSE) {
 		trace_rxrpc_abort(0, "CLS", sp->hdr.cid, sp->hdr.callNumber,
 				  sp->hdr.seq, RX_INVALID_OPERATION, ESHUTDOWN);
-		skb->mark = RXRPC_SKB_MARK_LOCAL_ABORT;
+		skb->mark = RXRPC_SKB_MARK_REJECT_ABORT;
 		skb->priority = RX_INVALID_OPERATION;
 		_leave(" = NULL [close]");
 		call = NULL;
@@ -373,7 +373,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 
 	call = rxrpc_alloc_incoming_call(rx, local, conn, skb);
 	if (!call) {
-		skb->mark = RXRPC_SKB_MARK_BUSY;
+		skb->mark = RXRPC_SKB_MARK_REJECT_BUSY;
 		_leave(" = NULL [busy]");
 		call = NULL;
 		goto out;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 7f9ed3a60b9a..b0f12471f5e7 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1354,7 +1354,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 protocol_error:
 	skb->priority = RX_PROTOCOL_ERROR;
 post_abort:
-	skb->mark = RXRPC_SKB_MARK_LOCAL_ABORT;
+	skb->mark = RXRPC_SKB_MARK_REJECT_ABORT;
 reject_packet:
 	trace_rxrpc_rx_done(skb->mark, skb->priority);
 	rxrpc_reject_packet(local, skb);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 8a4da3fe96df..e8fb8922bca8 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -524,7 +524,7 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 	struct kvec iov[2];
 	size_t size;
 	__be32 code;
-	int ret;
+	int ret, ioc;
 
 	_enter("%d", local->debug_id);
 
@@ -532,7 +532,6 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 	iov[0].iov_len = sizeof(whdr);
 	iov[1].iov_base = &code;
 	iov[1].iov_len = sizeof(code);
-	size = sizeof(whdr) + sizeof(code);
 
 	msg.msg_name = &srx.transport;
 	msg.msg_control = NULL;
@@ -540,17 +539,31 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 	msg.msg_flags = 0;
 
 	memset(&whdr, 0, sizeof(whdr));
-	whdr.type = RXRPC_PACKET_TYPE_ABORT;
 
 	while ((skb = skb_dequeue(&local->reject_queue))) {
 		rxrpc_see_skb(skb, rxrpc_skb_rx_seen);
 		sp = rxrpc_skb(skb);
 
+		switch (skb->mark) {
+		case RXRPC_SKB_MARK_REJECT_BUSY:
+			whdr.type = RXRPC_PACKET_TYPE_BUSY;
+			size = sizeof(whdr);
+			ioc = 1;
+			break;
+		case RXRPC_SKB_MARK_REJECT_ABORT:
+			whdr.type = RXRPC_PACKET_TYPE_ABORT;
+			code = htonl(skb->priority);
+			size = sizeof(whdr) + sizeof(code);
+			ioc = 2;
+			break;
+		default:
+			rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
+			continue;
+		}
+
 		if (rxrpc_extract_addr_from_skb(local, &srx, skb) == 0) {
 			msg.msg_namelen = srx.transport_len;
 
-			code = htonl(skb->priority);
-
 			whdr.epoch	= htonl(sp->hdr.epoch);
 			whdr.cid	= htonl(sp->hdr.cid);
 			whdr.callNumber	= htonl(sp->hdr.callNumber);

