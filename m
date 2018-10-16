Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A410C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC6120869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="exwbB/Y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC6120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeJPMBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeJPMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2012145D;
        Tue, 16 Oct 2018 04:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663180;
        bh=kXdB2xLn6SUumt/VHdcolPLq5cTkwsc02Jjfv7pgarw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exwbB/Y7gbwHO9tPi6x9HgvgKDrKY85XaYUVw3spi0r58GSlba6GOmk9HHH+qUAdm
         DzzZTpI3rp4ZcWlGfF46rgOqVKAtwbg3N/Qos7sVC8yun/IEIXAVSddz41J2H3UgIU
         YSTbpPf9wfNlcUW+DUGTFsCnB/e8DpCI87+rcqbM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 041/100] rxrpc: Fix RTT gathering
Date:   Tue, 16 Oct 2018 00:11:22 -0400
Message-Id: <20181016041221.135528-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit b604dd9883f783a94020d772e4fe03160f455372 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c        |  8 ++++++--
 net/rxrpc/local_object.c |  9 +++++++++
 net/rxrpc/output.c       | 31 ++++++++++++++++++-------------
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 338fbbf216a9..f6027c875876 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -616,13 +616,14 @@ static void rxrpc_input_requested_ack(struct rxrpc_call *call,
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
@@ -1137,6 +1138,9 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		return;
 	}
 
+	if (skb->tstamp == 0)
+		skb->tstamp = ktime_get_real();
+
 	rxrpc_new_skb(skb, rxrpc_skb_rx_received);
 
 	_net("recv skb %p", skb);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index b493e6b62740..5d89ea5c1976 100644
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
index 4774c8f5634d..6ac21bb2071d 100644
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
@@ -357,8 +351,14 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 
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
@@ -384,6 +384,11 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
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
@@ -404,12 +409,8 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
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
@@ -448,6 +449,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 
 	down_write(&conn->params.local->defrag_sem);
 
+	sp->hdr.serial = serial;
+	smp_wmb(); /* Set serial before timestamp */
+	skb->tstamp = ktime_get_real();
+
 	switch (conn->params.local->srx.transport.family) {
 	case AF_INET:
 		opt = IP_PMTUDISC_DONT;
-- 
2.17.1

