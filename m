Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E009C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C330F2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C330F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJDUov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeJDUou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0400C03D474;
        Thu,  4 Oct 2018 13:51:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF7662010D7A;
        Thu,  4 Oct 2018 13:51:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 6/9] rxrpc: Use IPv4 addresses throught the IPv6
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:51:22 +0100
Message-ID: <153866108263.27255.7238999208758575702.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 04 Oct 2018 13:51:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AF_RXRPC opens an IPv6 socket through which to send and receive network
packets, both IPv6 and IPv4.  It currently turns AF_INET addresses into
AF_INET-as-AF_INET6 addresses based on an assumption that this was
necessary; on further inspection of the code, however, it turns out that
the IPv6 code just farms packets aimed at AF_INET addresses out to the IPv4
code.

Fix AF_RXRPC to use AF_INET addresses directly when given them.

Fixes: 7b674e390e51 ("rxrpc: Fix IPv6 support")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c      |   29 +++++++++++++++--------------
 net/rxrpc/af_rxrpc.c    |    3 ++-
 net/rxrpc/conn_object.c |    5 +++--
 net/rxrpc/peer_event.c  |   12 +++++++-----
 net/rxrpc/utils.c       |   19 +++++--------------
 5 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 89374de4785c..55a756c60746 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -232,7 +232,7 @@ struct afs_addr_list *afs_dns_query(struct afs_cell *cell, time64_t *_expiry)
  */
 void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 {
-	struct sockaddr_in6 *p;
+	struct sockaddr_rxrpc *srx;
 	u32 addr = ntohl(xdr);
 	int i;
 
@@ -240,9 +240,9 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 		return;
 
 	for (i = 0; i < alist->nr_ipv4; i++) {
-		struct sockaddr_in6 *a = &alist->addrs[i].transport.sin6;
-		u32 a_addr = ntohl(a->sin6_addr.s6_addr32[3]);
-		u16 a_port = ntohs(a->sin6_port);
+		struct sockaddr_in *a = &alist->addrs[i].transport.sin;
+		u32 a_addr = ntohl(a->sin_addr.s_addr);
+		u16 a_port = ntohs(a->sin_port);
 
 		if (addr == a_addr && port == a_port)
 			return;
@@ -257,12 +257,11 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	p = &alist->addrs[i].transport.sin6;
-	p->sin6_port		  = htons(port);
-	p->sin6_addr.s6_addr32[0] = 0;
-	p->sin6_addr.s6_addr32[1] = 0;
-	p->sin6_addr.s6_addr32[2] = htonl(0xffff);
-	p->sin6_addr.s6_addr32[3] = xdr;
+	srx = &alist->addrs[i];
+	srx->transport_len = sizeof(srx->transport.sin);
+	srx->transport.sin.sin_family = AF_INET;
+	srx->transport.sin.sin_port = htons(port);
+	srx->transport.sin.sin_addr.s_addr = xdr;
 	alist->nr_ipv4++;
 	alist->nr_addrs++;
 }
@@ -272,7 +271,7 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
  */
 void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 {
-	struct sockaddr_in6 *p;
+	struct sockaddr_rxrpc *srx;
 	int i, diff;
 
 	if (alist->nr_addrs >= alist->max_addrs)
@@ -296,9 +295,11 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	p = &alist->addrs[i].transport.sin6;
-	p->sin6_port = htons(port);
-	memcpy(&p->sin6_addr, xdr, 16);
+	srx = &alist->addrs[i];
+	srx->transport_len = sizeof(srx->transport.sin6);
+	srx->transport.sin6.sin6_family = AF_INET6;
+	srx->transport.sin6.sin6_port = htons(port);
+	memcpy(&srx->transport.sin6.sin6_addr, xdr, 16);
 	alist->nr_addrs++;
 }
 
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index ac44d8afffb1..2fdd276f6842 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -97,7 +97,8 @@ static int rxrpc_validate_address(struct rxrpc_sock *rx,
 	    srx->transport_len > len)
 		return -EINVAL;
 
-	if (srx->transport.family != rx->family)
+	if (srx->transport.family != rx->family &&
+	    srx->transport.family == AF_INET && rx->family != AF_INET6)
 		return -EAFNOSUPPORT;
 
 	switch (srx->transport.family) {
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 885dae829f4a..fb856a1ccda8 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -89,8 +89,9 @@ struct rxrpc_connection *rxrpc_find_connection_rcu(struct rxrpc_local *local,
 	if (rxrpc_extract_addr_from_skb(local, &srx, skb) < 0)
 		goto not_found;
 
-	/* We may have to handle mixing IPv4 and IPv6 */
-	if (srx.transport.family != local->srx.transport.family) {
+	if (srx.transport.family != local->srx.transport.family &&
+	    (srx.transport.family == AF_INET &&
+	     local->srx.transport.family != AF_INET6)) {
 		pr_warn_ratelimited("AF_RXRPC: Protocol mismatch %u not %u\n",
 				    srx.transport.family,
 				    local->srx.transport.family);
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index f3e6fc670da2..81a7869325a6 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -47,6 +47,8 @@ static struct rxrpc_peer *rxrpc_lookup_peer_icmp_rcu(struct rxrpc_local *local,
 	 */
 	switch (srx->transport.family) {
 	case AF_INET:
+		srx->transport_len = sizeof(srx->transport.sin);
+		srx->transport.family = AF_INET;
 		srx->transport.sin.sin_port = serr->port;
 		switch (serr->ee.ee_origin) {
 		case SO_EE_ORIGIN_ICMP:
@@ -70,20 +72,20 @@ static struct rxrpc_peer *rxrpc_lookup_peer_icmp_rcu(struct rxrpc_local *local,
 
 #ifdef CONFIG_AF_RXRPC_IPV6
 	case AF_INET6:
-		srx->transport.sin6.sin6_port = serr->port;
 		switch (serr->ee.ee_origin) {
 		case SO_EE_ORIGIN_ICMP6:
 			_net("Rx ICMP6");
+			srx->transport.sin6.sin6_port = serr->port;
 			memcpy(&srx->transport.sin6.sin6_addr,
 			       skb_network_header(skb) + serr->addr_offset,
 			       sizeof(struct in6_addr));
 			break;
 		case SO_EE_ORIGIN_ICMP:
 			_net("Rx ICMP on v6 sock");
-			srx->transport.sin6.sin6_addr.s6_addr32[0] = 0;
-			srx->transport.sin6.sin6_addr.s6_addr32[1] = 0;
-			srx->transport.sin6.sin6_addr.s6_addr32[2] = htonl(0xffff);
-			memcpy(srx->transport.sin6.sin6_addr.s6_addr + 12,
+			srx->transport_len = sizeof(srx->transport.sin);
+			srx->transport.family = AF_INET;
+			srx->transport.sin.sin_port = serr->port;
+			memcpy(&srx->transport.sin.sin_addr,
 			       skb_network_header(skb) + serr->addr_offset,
 			       sizeof(struct in_addr));
 			break;
diff --git a/net/rxrpc/utils.c b/net/rxrpc/utils.c
index e801171fa351..017adaa54e90 100644
--- a/net/rxrpc/utils.c
+++ b/net/rxrpc/utils.c
@@ -25,20 +25,11 @@ int rxrpc_extract_addr_from_skb(struct rxrpc_local *local,
 
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP:
-		if (local->srx.transport.family == AF_INET6) {
-			srx->transport_type = SOCK_DGRAM;
-			srx->transport_len = sizeof(srx->transport.sin6);
-			srx->transport.sin6.sin6_family = AF_INET6;
-			srx->transport.sin6.sin6_port = udp_hdr(skb)->source;
-			srx->transport.sin6.sin6_addr.s6_addr32[2] = htonl(0xffff);
-			srx->transport.sin6.sin6_addr.s6_addr32[3] = ip_hdr(skb)->saddr;
-		} else {
-			srx->transport_type = SOCK_DGRAM;
-			srx->transport_len = sizeof(srx->transport.sin);
-			srx->transport.sin.sin_family = AF_INET;
-			srx->transport.sin.sin_port = udp_hdr(skb)->source;
-			srx->transport.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
-		}
+		srx->transport_type = SOCK_DGRAM;
+		srx->transport_len = sizeof(srx->transport.sin);
+		srx->transport.sin.sin_family = AF_INET;
+		srx->transport.sin.sin_port = udp_hdr(skb)->source;
+		srx->transport.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
 		return 0;
 
 #ifdef CONFIG_AF_RXRPC_IPV6

