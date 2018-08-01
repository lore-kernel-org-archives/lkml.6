Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8119C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A189120894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A189120894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbeHAJRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:17:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387517AbeHAJRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:17:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 087CC612D294A;
        Wed,  1 Aug 2018 15:33:28 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 15:33:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dhowells@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-afs@lists.infradead.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] rxrpc: remove redundant variables 'xcall','sp' and 'did_discard'
Date:   Wed, 1 Aug 2018 15:32:51 +0800
Message-ID: <20180801073251.9808-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'xcall','sp' and 'did_discard' are being assigned,
but are never used,hence they are redundant and can be removed.

fix fllowing warning:

net/rxrpc/call_accept.c:110:22: warning: variable ‘xcall’ set but not used [-Wunused-but-set-variable]
net/rxrpc/call_event.c:165:25: warning: variable ‘sp’ set but not used [-Wunused-but-set-variable]
net/rxrpc/conn_client.c:1054:7: warning: variable ‘did_discard’ set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/rxrpc/call_accept.c | 2 --
 net/rxrpc/call_event.c  | 2 --
 net/rxrpc/conn_client.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index a9a9be5..7487a62 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -107,7 +107,6 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 
 	write_lock(&rx->call_lock);
 	if (user_attach_call) {
-		struct rxrpc_call *xcall;
 		struct rb_node *parent, **pp;
 
 		/* Check the user ID isn't already in use */
@@ -115,7 +114,6 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 		parent = NULL;
 		while (*pp) {
 			parent = *pp;
-			xcall = rb_entry(parent, struct rxrpc_call, sock_node);
 			if (user_call_ID < call->user_call_ID)
 				pp = &(*pp)->rb_left;
 			else if (user_call_ID > call->user_call_ID)
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 2021041..8e7434e 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -162,7 +162,6 @@ static void rxrpc_congestion_timeout(struct rxrpc_call *call)
  */
 static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 {
-	struct rxrpc_skb_priv *sp;
 	struct sk_buff *skb;
 	unsigned long resend_at;
 	rxrpc_seq_t cursor, seq, top;
@@ -207,7 +206,6 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 
 		skb = call->rxtx_buffer[ix];
 		rxrpc_see_skb(skb, rxrpc_skb_tx_seen);
-		sp = rxrpc_skb(skb);
 
 		if (anno_type == RXRPC_TX_ANNO_UNACK) {
 			if (ktime_after(skb->tstamp, max_age)) {
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 5736f64..e4bfbd7 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -1051,7 +1051,6 @@ void rxrpc_discard_expired_client_conns(struct work_struct *work)
 		container_of(work, struct rxrpc_net, client_conn_reaper);
 	unsigned long expiry, conn_expires_at, now;
 	unsigned int nr_conns;
-	bool did_discard = false;
 
 	_enter("");
 
@@ -1113,7 +1112,6 @@ void rxrpc_discard_expired_client_conns(struct work_struct *work)
 	 * If someone re-sets the flag and re-gets the ref, that's fine.
 	 */
 	rxrpc_put_connection(conn);
-	did_discard = true;
 	nr_conns--;
 	goto next;
 
-- 
2.7.0


