Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40CDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0F2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA0F2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeI1Qdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:33:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9315 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1Qdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:33:46 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23EF113AB3;
        Fri, 28 Sep 2018 10:10:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02245D723C;
        Fri, 28 Sep 2018 10:10:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 7/8] rxrpc: Fix transport sockopts to get IPv4 errors on
 an IPv6 socket
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:10:43 +0100
Message-ID: <153812944320.10469.17401890782204208383.stgit@warthog.procyon.org.uk>
In-Reply-To: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
References: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 28 Sep 2018 10:10:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that enabling IPV6_RECVERR on an IPv6 socket doesn't also turn on
IP_RECVERR, so neither local errors nor ICMP-transported remote errors from
IPv4 peer addresses are returned to the AF_RXRPC protocol.

Make the sockopt setting code in rxrpc_open_socket() fall through from the
AF_INET6 case to the AF_INET case to turn on all the AF_INET options too in
the AF_INET6 case.

Fixes: f2aeed3a591f ("rxrpc: Fix error reception on AF_INET6 sockets")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/local_object.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 81de7d889ffa..94d234e9c685 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -135,10 +135,10 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	}
 
 	switch (local->srx.transport.family) {
-	case AF_INET:
-		/* we want to receive ICMP errors */
+	case AF_INET6:
+		/* we want to receive ICMPv6 errors */
 		opt = 1;
-		ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
+		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_RECVERR,
 					(char *) &opt, sizeof(opt));
 		if (ret < 0) {
 			_debug("setsockopt failed");
@@ -146,19 +146,22 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		}
 
 		/* we want to set the don't fragment bit */
-		opt = IP_PMTUDISC_DO;
-		ret = kernel_setsockopt(local->socket, SOL_IP, IP_MTU_DISCOVER,
+		opt = IPV6_PMTUDISC_DO;
+		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_MTU_DISCOVER,
 					(char *) &opt, sizeof(opt));
 		if (ret < 0) {
 			_debug("setsockopt failed");
 			goto error;
 		}
-		break;
 
-	case AF_INET6:
+		/* Fall through and set IPv4 options too otherwise we don't get
+		 * errors from IPv4 packets sent through the IPv6 socket.
+		 */
+
+	case AF_INET:
 		/* we want to receive ICMP errors */
 		opt = 1;
-		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_RECVERR,
+		ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
 					(char *) &opt, sizeof(opt));
 		if (ret < 0) {
 			_debug("setsockopt failed");
@@ -166,8 +169,8 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		}
 
 		/* we want to set the don't fragment bit */
-		opt = IPV6_PMTUDISC_DO;
-		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_MTU_DISCOVER,
+		opt = IP_PMTUDISC_DO;
+		ret = kernel_setsockopt(local->socket, SOL_IP, IP_MTU_DISCOVER,
 					(char *) &opt, sizeof(opt));
 		if (ret < 0) {
 			_debug("setsockopt failed");

