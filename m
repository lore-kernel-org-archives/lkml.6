Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EBEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1504420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1504420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbeHALij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:38:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387833AbeHALii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:38:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1CF3EED104EF3;
        Wed,  1 Aug 2018 17:53:38 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 17:53:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dhowells@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-afs@lists.infradead.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] rxrpc: remove redundant variables 'sp' and 'did_discard'
Date:   Wed, 1 Aug 2018 17:52:34 +0800
Message-ID: <20180801095234.15060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'sp' and 'did_discard' are being assigned,
but are never used,hence they are redundant and can be removed.

fix fllowing warning:

net/rxrpc/call_event.c:165:25: warning: variable 'sp' set but not used [-Wunused-but-set-variable]
net/rxrpc/conn_client.c:1054:7: warning: variable 'did_discard' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/rxrpc/call_event.c  | 2 --
 net/rxrpc/conn_client.c | 2 --
 2 files changed, 4 deletions(-)

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


