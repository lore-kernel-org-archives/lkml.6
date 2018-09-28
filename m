Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06244C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43FE2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43FE2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbeI1QdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1QdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:33:18 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F913723D9;
        Fri, 28 Sep 2018 10:10:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 698BA3091882;
        Fri, 28 Sep 2018 10:10:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 3/8] rxrpc: Fix RTT gathering
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:10:14 +0100
Message-ID: <153812941462.10469.480051247101168310.stgit@warthog.procyon.org.uk>
In-Reply-To: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
References: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 28 Sep 2018 10:10:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix RTT information gathering in AF_RXRPC by the following means:

 (1) Enable Rx timestamping on the transport socket with SO_TIMESTAMPNS.

 (2) If the sk_buff doesn't have a timestamp set when rxrpc_data_ready()
     collects it, set it at that point.

 (3) Allow ACKs to be requested on the last packet of a client call, but
     not a service call.  We need to be careful lest we undo:

	bf7d620abf22c321208a4da4f435e7af52551a21
	Author: David Howells <dhowells@redhat.com>
	Date:   Thu Oct 6 08:11:51 2016 +0100
	rxrpc: Don't request an ACK on the last DATA packet of a call's Tx phase

     but that only really applies to service calls that we're handling,
     since the client side gets to send the final ACK (or not).

 (4) When about to transmit an ACK or DATA packet, record the Tx timestamp
     before only; don't update the timestamp afterwards.

 (5) Switch the ordering between recording the serial and recording the
     timestamp to always set the serial number first.  The serial number
     shouldn't be seen referenced by an ACK packet until we've transmitted
     the packet bearing it - so in the Rx path, we don't need the timestamp
     until we've checked the serial number.

Fixes: cf1a6474f807 ("rxrpc: Add per-peer RTT tracker")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/input.c        |    8 ++++++--
 net/rxrpc/local_object.c |    9 +++++++++
 net/rxrpc/output.c       |   31 ++++++++++++++++++-------------
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index ec299c627f77..7f9ed3a60b9a 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -622,13 +622,14 @@ static void rxrpc_input_requested_ack(struct rxrpc_call *call,
 		if (!skb)
 			continue;
 
+		sent_at = skb->tstamp;
+		smp_rmb(); /* Read timestamp before serial. */
 		sp = rxrpc_skb(skb);
 		if (sp->hdr.serial != orig_serial)
 			continue;
-		smp_rmb();
-		sent_at = skb->tstamp;
 		goto found;
 	}
+
 	return;
 
 found:
@@ -1143,6 +1144,9 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		return;
 	}
 
+	if (skb->tstamp == 0)
+		skb->tstamp = ktime_get_real();
+
 	rxrpc_new_skb(skb, rxrpc_skb_rx_received);
 
 	_net("recv skb %p", skb);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 777c3ed4cfc0..81de7d889ffa 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -173,6 +173,15 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 			_debug("setsockopt failed");
 			goto error;
 		}
+
+		/* We want receive timestamps. */
+		opt = 1;
+		ret = kernel_setsockopt(local->socket, SOL_SOCKET, SO_TIMESTAMPNS,
+					(char *)&opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
 		break;
 
 	default:
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ccf5de160444..8a4da3fe96df 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -124,7 +124,6 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 	struct kvec iov[2];
 	rxrpc_serial_t serial;
 	rxrpc_seq_t hard_ack, top;
-	ktime_t now;
 	size_t len, n;
 	int ret;
 	u8 reason;
@@ -196,9 +195,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 		/* We need to stick a time in before we send the packet in case
 		 * the reply gets back before kernel_sendmsg() completes - but
 		 * asking UDP to send the packet can take a relatively long
-		 * time, so we update the time after, on the assumption that
-		 * the packet transmission is more likely to happen towards the
-		 * end of the kernel_sendmsg() call.
+		 * time.
 		 */
 		call->ping_time = ktime_get_real();
 		set_bit(RXRPC_CALL_PINGING, &call->flags);
@@ -206,9 +203,6 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, bool ping,
 	}
 
 	ret = kernel_sendmsg(conn->params.local->socket, &msg, iov, 2, len);
-	now = ktime_get_real();
-	if (ping)
-		call->ping_time = now;
 	conn->params.peer->last_tx_at = ktime_get_seconds();
 	if (ret < 0)
 		trace_rxrpc_tx_fail(call->debug_id, serial, ret,
@@ -363,8 +357,14 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
+	 *
+	 * However, we mustn't request an ACK on the last reply packet of a
+	 * service call, lest OpenAFS incorrectly send us an ACK with some
+	 * soft-ACKs in it and then never follow up with a proper hard ACK.
 	 */
-	if (!(sp->hdr.flags & RXRPC_LAST_PACKET) &&
+	if ((!(sp->hdr.flags & RXRPC_LAST_PACKET) ||
+	     rxrpc_to_server(sp)
+	     ) &&
 	    (test_and_clear_bit(RXRPC_CALL_EV_ACK_LOST, &call->events) ||
 	     retrans ||
 	     call->cong_mode == RXRPC_CALL_SLOW_START ||
@@ -390,6 +390,11 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		goto send_fragmentable;
 
 	down_read(&conn->params.local->defrag_sem);
+
+	sp->hdr.serial = serial;
+	smp_wmb(); /* Set serial before timestamp */
+	skb->tstamp = ktime_get_real();
+
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet
 	 *   to go out of the interface
@@ -413,12 +418,8 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	trace_rxrpc_tx_data(call, sp->hdr.seq, serial, whdr.flags,
 			    retrans, lost);
 	if (ret >= 0) {
-		ktime_t now = ktime_get_real();
-		skb->tstamp = now;
-		smp_wmb();
-		sp->hdr.serial = serial;
 		if (whdr.flags & RXRPC_REQUEST_ACK) {
-			call->peer->rtt_last_req = now;
+			call->peer->rtt_last_req = skb->tstamp;
 			trace_rxrpc_rtt_tx(call, rxrpc_rtt_tx_data, serial);
 			if (call->peer->rtt_usage > 1) {
 				unsigned long nowj = jiffies, ack_lost_at;
@@ -457,6 +458,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 
 	down_write(&conn->params.local->defrag_sem);
 
+	sp->hdr.serial = serial;
+	smp_wmb(); /* Set serial before timestamp */
+	skb->tstamp = ktime_get_real();
+
 	switch (conn->params.local->srx.transport.family) {
 	case AF_INET:
 		opt = IP_PMTUDISC_DONT;

