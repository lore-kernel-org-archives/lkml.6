Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602BAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D58220866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zmmDkPB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D58220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeJPMBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbeJPMBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1212221470;
        Tue, 16 Oct 2018 04:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663181;
        bh=398jYv9gPuKS21PGMRoNHhlP/g9cJKhkfZpoz1S2dXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmmDkPB0W4hCtMACKumxLvlw5yQ4QWF6NQnvQ+5cxV427q7BT29FuwtWCndy4zcqp
         VYdewfjZRyAJhfgjn1fBeZeK0PUky1pd/nzmFjcLAc6snpHW1+mU9kA70qo7ZSmcOj
         KO1rERpCrQcBId0FdpXh+ixcYRZWGD3cfE3wC4Wk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 042/100] rxrpc: Fix transport sockopts to get IPv4 errors on an IPv6 socket
Date:   Tue, 16 Oct 2018 00:11:23 -0400
Message-Id: <20181016041221.135528-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

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

