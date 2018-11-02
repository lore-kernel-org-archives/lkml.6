Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268EEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7A820833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqO3WwDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7A820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeKCDrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeKCDrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:35 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C94762082E;
        Fri,  2 Nov 2018 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183963;
        bh=6AEzY/DjNTx8EqRmXs7BWaaiXbOuKDnFLtV2J2h4/D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqO3WwDzzx9Tc+SOAQF87KuCFdULOI9RTF+wyL3qFAZXUyQgkbDxyWrVNItfo76ut
         4GOuptYXz0reK/ivSEsxyppwUNBcwhWDRLZaVovc6VEK3AYPv54RNr0E1CkxUowUs6
         LJ5w68BTckrKDUCThfV3ehQvnPjJfVAzkz3iYCpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 036/150] rxrpc: Fix checks as to whether we should set up a new call
Date:   Fri,  2 Nov 2018 19:33:18 +0100
Message-Id: <20181102182905.833538952@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit dc71db34e4f3c06b8277c8f3c2ff014610607a8c ]

There's a check in rxrpc_data_ready() that's checking the CLIENT_INITIATED
flag in the packet type field rather than in the packet flags field.

Fix this by creating a pair of helper functions to check whether the packet
is going to the client or to the server and use them generally.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h | 10 ++++++++++
 net/rxrpc/conn_object.c |  2 +-
 net/rxrpc/input.c       | 12 ++++--------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 707630ab4713..5069193d2cc1 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -462,6 +462,16 @@ struct rxrpc_connection {
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
index 4c77a78a252a..c37bf8e282b9 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -99,7 +99,7 @@ struct rxrpc_connection *rxrpc_find_connection_rcu(struct rxrpc_local *local,
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
 
-	if (sp->hdr.flags & RXRPC_CLIENT_INITIATED) {
+	if (rxrpc_to_server(sp)) {
 		/* We need to look up service connections by the full protocol
 		 * parameter set.  We look up the peer first as an intermediate
 		 * step and then the connection from the peer's tree.
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 608d078a4981..338fbbf216a9 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1171,10 +1171,6 @@ void rxrpc_data_ready(struct sock *udp_sk)
 
 	trace_rxrpc_rx_packet(sp);
 
-	_net("Rx RxRPC %s ep=%x call=%x:%x",
-	     sp->hdr.flags & RXRPC_CLIENT_INITIATED ? "ToServer" : "ToClient",
-	     sp->hdr.epoch, sp->hdr.cid, sp->hdr.callNumber);
-
 	if (sp->hdr.type >= RXRPC_N_PACKET_TYPES ||
 	    !((RXRPC_SUPPORTED_PACKET_TYPES >> sp->hdr.type) & 1)) {
 		_proto("Rx Bad Packet Type %u", sp->hdr.type);
@@ -1183,13 +1179,13 @@ void rxrpc_data_ready(struct sock *udp_sk)
 
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
 
@@ -1269,7 +1265,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		call = rcu_dereference(chan->call);
 
 		if (sp->hdr.callNumber > chan->call_id) {
-			if (!(sp->hdr.flags & RXRPC_CLIENT_INITIATED)) {
+			if (rxrpc_to_client(sp)) {
 				rcu_read_unlock();
 				goto reject_packet;
 			}
@@ -1292,7 +1288,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 	}
 
 	if (!call || atomic_read(&call->usage) == 0) {
-		if (!(sp->hdr.type & RXRPC_CLIENT_INITIATED) ||
+		if (rxrpc_to_client(sp) ||
 		    sp->hdr.callNumber == 0 ||
 		    sp->hdr.type != RXRPC_PACKET_TYPE_DATA)
 			goto bad_message_unlock;
-- 
2.17.1



