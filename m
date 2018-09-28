Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC72C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879C22172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879C22172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeI1QdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1QdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:33:10 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E567308A94F;
        Fri, 28 Sep 2018 10:10:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73A823091373;
        Fri, 28 Sep 2018 10:10:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 2/8] rxrpc: Fix checks as to whether we should set up a
 new call
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:10:07 +0100
Message-ID: <153812940775.10469.15432267100462706921.stgit@warthog.procyon.org.uk>
In-Reply-To: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
References: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 28 Sep 2018 10:10:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a check in rxrpc_data_ready() that's checking the CLIENT_INITIATED
flag in the packet type field rather than in the packet flags field.

Fix this by creating a pair of helper functions to check whether the packet
is going to the client or to the server and use them generally.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |   10 ++++++++++
 net/rxrpc/conn_object.c |    2 +-
 net/rxrpc/input.c       |   12 ++++--------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c97558710421..9fcb3e197b14 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -463,6 +463,16 @@ struct rxrpc_connection {
 	u8			out_clientflag;	/* RXRPC_CLIENT_INITIATED if we are client */
 };
 
+static inline bool rxrpc_to_server(const struct rxrpc_skb_priv *sp)
+{
+	return sp->hdr.flags & RXRPC_CLIENT_INITIATED;
+}
+
+static inline bool rxrpc_to_client(const struct rxrpc_skb_priv *sp)
+{
+	return !rxrpc_to_server(sp);
+}
+
 /*
  * Flags in call->flags.
  */
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 1746b48cb165..390ba50cfab4 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -96,7 +96,7 @@ struct rxrpc_connection *rxrpc_find_connection_rcu(struct rxrpc_local *local,
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
 
-	if (sp->hdr.flags & RXRPC_CLIENT_INITIATED) {
+	if (rxrpc_to_server(sp)) {
 		/* We need to look up service connections by the full protocol
 		 * parameter set.  We look up the peer first as an intermediate
 		 * step and then the connection from the peer's tree.
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index cfdc199c6351..ec299c627f77 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1177,10 +1177,6 @@ void rxrpc_data_ready(struct sock *udp_sk)
 
 	trace_rxrpc_rx_packet(sp);
 
-	_net("Rx RxRPC %s ep=%x call=%x:%x",
-	     sp->hdr.flags & RXRPC_CLIENT_INITIATED ? "ToServer" : "ToClient",
-	     sp->hdr.epoch, sp->hdr.cid, sp->hdr.callNumber);
-
 	if (sp->hdr.type >= RXRPC_N_PACKET_TYPES ||
 	    !((RXRPC_SUPPORTED_PACKET_TYPES >> sp->hdr.type) & 1)) {
 		_proto("Rx Bad Packet Type %u", sp->hdr.type);
@@ -1189,13 +1185,13 @@ void rxrpc_data_ready(struct sock *udp_sk)
 
 	switch (sp->hdr.type) {
 	case RXRPC_PACKET_TYPE_VERSION:
-		if (!(sp->hdr.flags & RXRPC_CLIENT_INITIATED))
+		if (rxrpc_to_client(sp))
 			goto discard;
 		rxrpc_post_packet_to_local(local, skb);
 		goto out;
 
 	case RXRPC_PACKET_TYPE_BUSY:
-		if (sp->hdr.flags & RXRPC_CLIENT_INITIATED)
+		if (rxrpc_to_server(sp))
 			goto discard;
 		/* Fall through */
 
@@ -1280,7 +1276,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		call = rcu_dereference(chan->call);
 
 		if (sp->hdr.callNumber > chan->call_id) {
-			if (!(sp->hdr.flags & RXRPC_CLIENT_INITIATED)) {
+			if (rxrpc_to_client(sp)) {
 				rcu_read_unlock();
 				goto reject_packet;
 			}
@@ -1303,7 +1299,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	}
 
 	if (!call || atomic_read(&call->usage) == 0) {
-		if (!(sp->hdr.type & RXRPC_CLIENT_INITIATED) ||
+		if (rxrpc_to_client(sp) ||
 		    sp->hdr.callNumber == 0 ||
 		    sp->hdr.type != RXRPC_PACKET_TYPE_DATA)
 			goto bad_message_unlock;

