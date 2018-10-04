Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE1D2148D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE1D2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeJDUo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30849 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeJDUo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1A273097075;
        Thu,  4 Oct 2018 13:51:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBC4B77BF8;
        Thu,  4 Oct 2018 13:51:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 7/9] rxrpc: Drop the local endpoint arg from
 rxrpc_extract_addr_from_skb()
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:51:32 +0100
Message-ID: <153866109198.27255.11971804489487914762.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 04 Oct 2018 13:51:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_extract_addr_from_skb() doesn't use the argument that points to the
local endpoint, so remove the argument.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    3 +--
 net/rxrpc/call_accept.c |    2 +-
 net/rxrpc/conn_object.c |    2 +-
 net/rxrpc/local_event.c |    2 +-
 net/rxrpc/output.c      |    2 +-
 net/rxrpc/utils.c       |    4 +---
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 9ba87e4d15c7..76569c178915 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1111,8 +1111,7 @@ static inline void rxrpc_sysctl_exit(void) {}
 /*
  * utils.c
  */
-int rxrpc_extract_addr_from_skb(struct rxrpc_local *, struct sockaddr_rxrpc *,
-				struct sk_buff *);
+int rxrpc_extract_addr_from_skb(struct sockaddr_rxrpc *, struct sk_buff *);
 
 static inline bool before(u32 seq1, u32 seq2)
 {
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 9c7f26d06a52..8354cadbb839 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -280,7 +280,7 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 			peer = NULL;
 		if (!peer) {
 			peer = b->peer_backlog[peer_tail];
-			if (rxrpc_extract_addr_from_skb(local, &peer->srx, skb) < 0)
+			if (rxrpc_extract_addr_from_skb(&peer->srx, skb) < 0)
 				return NULL;
 			b->peer_backlog[peer_tail] = NULL;
 			smp_store_release(&b->peer_backlog_tail,
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index fb856a1ccda8..c332722820c2 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -86,7 +86,7 @@ struct rxrpc_connection *rxrpc_find_connection_rcu(struct rxrpc_local *local,
 
 	_enter(",%x", sp->hdr.cid & RXRPC_CIDMASK);
 
-	if (rxrpc_extract_addr_from_skb(local, &srx, skb) < 0)
+	if (rxrpc_extract_addr_from_skb(&srx, skb) < 0)
 		goto not_found;
 
 	if (srx.transport.family != local->srx.transport.family &&
diff --git a/net/rxrpc/local_event.c b/net/rxrpc/local_event.c
index 13bd8a4dfac7..927ead43df42 100644
--- a/net/rxrpc/local_event.c
+++ b/net/rxrpc/local_event.c
@@ -39,7 +39,7 @@ static void rxrpc_send_version_request(struct rxrpc_local *local,
 
 	_enter("");
 
-	if (rxrpc_extract_addr_from_skb(local, &srx, skb) < 0)
+	if (rxrpc_extract_addr_from_skb(&srx, skb) < 0)
 		return;
 
 	msg.msg_name	= &srx.transport;
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 993d4cd247f9..0f0b499d1202 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -561,7 +561,7 @@ void rxrpc_reject_packets(struct rxrpc_local *local)
 			continue;
 		}
 
-		if (rxrpc_extract_addr_from_skb(local, &srx, skb) == 0) {
+		if (rxrpc_extract_addr_from_skb(&srx, skb) == 0) {
 			msg.msg_namelen = srx.transport_len;
 
 			whdr.epoch	= htonl(sp->hdr.epoch);
diff --git a/net/rxrpc/utils.c b/net/rxrpc/utils.c
index 017adaa54e90..ff7af71c4b49 100644
--- a/net/rxrpc/utils.c
+++ b/net/rxrpc/utils.c
@@ -17,9 +17,7 @@
 /*
  * Fill out a peer address from a socket buffer containing a packet.
  */
-int rxrpc_extract_addr_from_skb(struct rxrpc_local *local,
-				struct sockaddr_rxrpc *srx,
-				struct sk_buff *skb)
+int rxrpc_extract_addr_from_skb(struct sockaddr_rxrpc *srx, struct sk_buff *skb)
 {
 	memset(srx, 0, sizeof(*srx));
 

