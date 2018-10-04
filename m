Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB82084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECB82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJDUoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeJDUoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7AB380F7D;
        Thu,  4 Oct 2018 13:50:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFCB526E78;
        Thu,  4 Oct 2018 13:50:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 1/9] rxrpc: Use rxrpc_free_skb() rather than
 rxrpc_lose_skb()
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:50:43 +0100
Message-ID: <153866104318.27255.15577121226497073775.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 04 Oct 2018 13:50:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_lose_skb() is now exactly the same as rxrpc_free_skb(), so remove it
and use the latter instead.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    1 -
 net/rxrpc/input.c       |    2 +-
 net/rxrpc/skbuff.c      |   15 ---------------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ef9554131434..9ba87e4d15c7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1095,7 +1095,6 @@ void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
-void rxrpc_lose_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_purge_queue(struct sk_buff_head *);
 
 /*
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 4b86b6be6c1f..5b2626929822 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1176,7 +1176,7 @@ void rxrpc_data_ready(struct sock *udp_sk)
 		static int lose;
 		if ((lose++ & 7) == 7) {
 			trace_rxrpc_rx_lose(sp);
-			rxrpc_lose_skb(skb, rxrpc_skb_rx_lost);
+			rxrpc_free_skb(skb, rxrpc_skb_rx_lost);
 			return;
 		}
 	}
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index b8985d01876a..913dca65cc65 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -68,21 +68,6 @@ void rxrpc_free_skb(struct sk_buff *skb, enum rxrpc_skb_trace op)
 	}
 }
 
-/*
- * Note the injected loss of a socket buffer.
- */
-void rxrpc_lose_skb(struct sk_buff *skb, enum rxrpc_skb_trace op)
-{
-	const void *here = __builtin_return_address(0);
-	if (skb) {
-		int n;
-		CHECK_SLAB_OKAY(&skb->users);
-		n = atomic_dec_return(select_skb_count(op));
-		trace_rxrpc_skb(skb, op, refcount_read(&skb->users), n, here);
-		kfree_skb(skb);
-	}
-}
-
 /*
  * Clear a queue of socket buffers.
  */

