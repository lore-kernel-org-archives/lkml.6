Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C91C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C6020862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C6020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbeGaRmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:42:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52135 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeGaRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:42:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkX5d-0002fm-LE; Tue, 31 Jul 2018 16:01:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/tipc: remove redundant variables 'tn' and 'oport'
Date:   Tue, 31 Jul 2018 17:01:37 +0100
Message-Id: <20180731160137.5850-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables 'tn' and 'oport'  are being assigned but are never used hence
they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'oport' set but not used [-Wunused-but-set-variable]
warning: variable 'tn' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/tipc/socket.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 3763bedecf5f..c1e93c9515bc 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -411,7 +411,6 @@ static int tipc_sk_sock_err(struct socket *sock, long *timeout)
 static int tipc_sk_create(struct net *net, struct socket *sock,
 			  int protocol, int kern)
 {
-	struct tipc_net *tn;
 	const struct proto_ops *ops;
 	struct sock *sk;
 	struct tipc_sock *tsk;
@@ -446,7 +445,6 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	INIT_LIST_HEAD(&tsk->publications);
 	INIT_LIST_HEAD(&tsk->cong_links);
 	msg = &tsk->phdr;
-	tn = net_generic(sock_net(sk), tipc_net_id);
 
 	/* Finish initializing socket data structures */
 	sock->ops = ops;
@@ -1117,7 +1115,7 @@ void tipc_sk_mcast_rcv(struct net *net, struct sk_buff_head *arrvq,
 	u32 self = tipc_own_addr(net);
 	u32 type, lower, upper, scope;
 	struct sk_buff *skb, *_skb;
-	u32 portid, oport, onode;
+	u32 portid, onode;
 	struct sk_buff_head tmpq;
 	struct list_head dports;
 	struct tipc_msg *hdr;
@@ -1133,7 +1131,6 @@ void tipc_sk_mcast_rcv(struct net *net, struct sk_buff_head *arrvq,
 		user = msg_user(hdr);
 		mtyp = msg_type(hdr);
 		hlen = skb_headroom(skb) + msg_hdr_sz(hdr);
-		oport = msg_origport(hdr);
 		onode = msg_orignode(hdr);
 		type = msg_nametype(hdr);
 
-- 
2.17.1

