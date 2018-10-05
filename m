Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46635C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096EB2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096EB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJEUmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:42:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJEUmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C941530820DB;
        Fri,  5 Oct 2018 13:43:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B04D162487;
        Fri,  5 Oct 2018 13:43:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 2/2] rxrpc: Fix the data_ready handler
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 05 Oct 2018 14:43:10 +0100
Message-ID: <153874699086.18195.6819270943388841145.stgit@warthog.procyon.org.uk>
In-Reply-To: <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk>
References: <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 05 Oct 2018 13:43:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the rxrpc_data_ready() function to pick up all packets and to not miss
any.  There are two problems:

 (1) The sk_data_ready pointer on the UDP socket is set *after* it is
     bound.  This means that it's open for business before we're ready to
     dequeue packets and there's a tiny window exists in which a packet can
     sneak onto the receive queue, but we never know about it.

     Fix this by setting the pointers on the socket prior to binding it.

 (2) skb_recv_udp() will return an error (such as ENETUNREACH) if there was
     an error on the transmission side, even though we set the
     sk_error_report hook.  Because rxrpc_data_ready() returns immediately
     in such a case, it never actually removes its packet from the receive
     queue.

     Fix this by abstracting out the UDP dequeuing and checksumming into a
     separate function that keeps hammering on skb_recv_udp() until it
     returns -EAGAIN, passing the packets extracted to the remainder of the
     function.

and two potential problems:

 (3) It might be possible in some circumstances or in the future for
     packets to be being added to the UDP receive queue whilst rxrpc is
     running consuming them, so the data_ready() handler might get called
     less often than once per packet.

     Allow for this by fully draining the queue on each call as (2).

 (4) If a packet fails the checksum check, the code currently returns after
     discarding the packet without checking for more.

     Allow for this by fully draining the queue on each call as (2).

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---

 net/rxrpc/input.c        |   68 ++++++++++++++++++++++++++--------------------
 net/rxrpc/local_object.c |   11 ++++---
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index c5af9955665b..c3114fa66c92 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1121,7 +1121,7 @@ int rxrpc_extract_header(struct rxrpc_skb_priv *sp, struct sk_buff *skb)
  * shut down and the local endpoint from going away, thus sk_user_data will not
  * be cleared until this function returns.
  */
-void rxrpc_data_ready(struct sock *udp_sk)
+void rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 {
 	struct rxrpc_connection *conn;
 	struct rxrpc_channel *chan;
@@ -1130,39 +1130,11 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	struct rxrpc_local *local = udp_sk->sk_user_data;
 	struct rxrpc_peer *peer = NULL;
 	struct rxrpc_sock *rx = NULL;
-	struct sk_buff *skb;
 	unsigned int channel;
-	int ret, skew = 0;
+	int skew = 0;
 
 	_enter("%p", udp_sk);
 
-	ASSERT(!irqs_disabled());
-
-	skb = skb_recv_udp(udp_sk, 0, 1, &ret);
-	if (!skb) {
-		if (ret == -EAGAIN)
-			return;
-		_debug("UDP socket error %d", ret);
-		return;
-	}
-
-	if (skb->tstamp == 0)
-		skb->tstamp = ktime_get_real();
-
-	rxrpc_new_skb(skb, rxrpc_skb_rx_received);
-
-	_net("recv skb %p", skb);
-
-	/* we'll probably need to checksum it (didn't call sock_recvmsg) */
-	if (skb_checksum_complete(skb)) {
-		rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
-		__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INERRORS, 0);
-		_leave(" [CSUM failed]");
-		return;
-	}
-
-	__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INDATAGRAMS, 0);
-
 	/* The UDP protocol already released all skb resources;
 	 * we are free to add our own data there.
 	 */
@@ -1181,6 +1153,8 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		}
 	}
 
+	if (skb->tstamp == 0)
+		skb->tstamp = ktime_get_real();
 	trace_rxrpc_rx_packet(sp);
 
 	switch (sp->hdr.type) {
@@ -1398,3 +1372,37 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	rxrpc_reject_packet(local, skb);
 	_leave(" [badmsg]");
 }
+
+void rxrpc_data_ready(struct sock *udp_sk)
+{
+	struct sk_buff *skb;
+	int ret;
+
+	for (;;) {
+		skb = skb_recv_udp(udp_sk, 0, 1, &ret);
+		if (!skb) {
+			if (ret == -EAGAIN)
+				return;
+
+			/* If there was a transmission failure, we get an error
+			 * here that we need to ignore.
+			 */
+			_debug("UDP socket error %d", ret);
+			continue;
+		}
+
+		rxrpc_new_skb(skb, rxrpc_skb_rx_received);
+
+		/* we'll probably need to checksum it (didn't call sock_recvmsg) */
+		if (skb_checksum_complete(skb)) {
+			rxrpc_free_skb(skb, rxrpc_skb_rx_freed);
+			__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INERRORS, 0);
+			_debug("csum failed");
+			continue;
+		}
+
+		__UDP_INC_STATS(sock_net(udp_sk), UDP_MIB_INDATAGRAMS, 0);
+
+		rxrpc_input_packet(udp_sk, skb);
+	}
+}
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 94d234e9c685..30862f44c9f1 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -122,6 +122,12 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		return ret;
 	}
 
+	/* set the socket up */
+	sock = local->socket->sk;
+	sock->sk_user_data	= local;
+	sock->sk_data_ready	= rxrpc_data_ready;
+	sock->sk_error_report	= rxrpc_error_report;
+
 	/* if a local address was supplied then bind it */
 	if (local->srx.transport_len > sizeof(sa_family_t)) {
 		_debug("bind");
@@ -191,11 +197,6 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		BUG();
 	}
 
-	/* set the socket up */
-	sock = local->socket->sk;
-	sock->sk_user_data	= local;
-	sock->sk_data_ready	= rxrpc_data_ready;
-	sock->sk_error_report	= rxrpc_error_report;
 	_leave(" = 0");
 	return 0;
 

