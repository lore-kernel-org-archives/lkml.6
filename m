Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3037C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7169620837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2Bm/IFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7169620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeKCDrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeKCDrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E862082E;
        Fri,  2 Nov 2018 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183969;
        bh=PKRUdq8gpYOPtSMRn9BUjF42MHDYFRiQKlQRh2ERDBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2Bm/IFCfK2tG5bx/uUFkj06t4n0KmLPDr8VzKTqtXoYL1bPiu8+5zYylVys5CJBD
         vaxz7iwWtuqoXwqMg4GPCwrFIESoe2is+594cx1UjnfAVUaxXApRMGaCWEF4pC1jKl
         bbkHIZrvRplKAIjBPkRoreueZaciz4saxZcdk7a4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 038/150] rxrpc: Fix transport sockopts to get IPv4 errors on an IPv6 socket
Date:   Fri,  2 Nov 2018 19:33:20 +0100
Message-Id: <20181102182905.990300511@linuxfoundation.org>
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

[ Upstream commit 37a675e768d7606fe8a53e0c459c9b53e121ac20 ]

It seems that enabling IPV6_RECVERR on an IPv6 socket doesn't also turn on
IP_RECVERR, so neither local errors nor ICMP-transported remote errors from
IPv4 peer addresses are returned to the AF_RXRPC protocol.

Make the sockopt setting code in rxrpc_open_socket() fall through from the
AF_INET6 case to the AF_INET case to turn on all the AF_INET options too in
the AF_INET6 case.

Fixes: f2aeed3a591f ("rxrpc: Fix error reception on AF_INET6 sockets")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/local_object.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 5d89ea5c1976..386dc1f20c73 100644
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
-- 
2.17.1



