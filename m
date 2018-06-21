Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBECC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8B722428
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bjfgqofq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8B722428
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934139AbeFUVdB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:33:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933958AbeFUV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UZLX8SnVbDLAC15aGgIwzkKSoZoL4gXIz1I11KZy8AM=; b=BjfgqofqlGN+JfjEa1scQDk0a
        aFn9oPxJEe+69O2SJK2X0cQ8gdUpmZ3TvTrwbSHkZsyWZBfiYTBxj5tAc0Kpkin5+LeQ/qgFrGnZX
        roiyTV2KiIur4Ioob4BSJuA61XeAvqB4Mi4JC0o5waZuzQnz2XfQHS8m7caTwakzravVxr6mNoSi0
        OlWbstveMTJ4HiI6B+mNjM6hHmNIQdwy7BDOy44sHukGBPs0lm97T0g/r0RyxoVUmAjep1vw17YLt
        QJHpWfTk7dHViXLNldhs14eaRCXPe3dl2td6vyegpdECGgSCrOIq//wjBrMW1p0MYvpDABbOSbVA5
        niwl/Uwow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78f-0001bl-27; Thu, 21 Jun 2018 21:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: [PATCH 12/26] Convert net_namespace to new IDA API
Date:   Thu, 21 Jun 2018 14:28:21 -0700
Message-Id: <20180621212835.5636-13-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 net/core/net_namespace.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a11e03f920d3..f447cebdcea3 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -973,22 +973,18 @@ static int register_pernet_operations(struct list_head *list,
 	int error;
 
 	if (ops->id) {
-again:
-		error = ida_get_new_above(&net_generic_ids, MIN_PERNET_OPS_ID, ops->id);
-		if (error < 0) {
-			if (error == -EAGAIN) {
-				ida_pre_get(&net_generic_ids, GFP_KERNEL);
-				goto again;
-			}
+		error = ida_alloc_min(&net_generic_ids, MIN_PERNET_OPS_ID,
+				GFP_KERNEL);
+		if (error < 0)
 			return error;
-		}
+		*ops->id = error;
 		max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
 	}
 	error = __register_pernet_operations(list, ops);
 	if (error) {
 		rcu_barrier();
 		if (ops->id)
-			ida_remove(&net_generic_ids, *ops->id);
+			ida_free(&net_generic_ids, *ops->id);
 	}
 
 	return error;
@@ -999,7 +995,7 @@ static void unregister_pernet_operations(struct pernet_operations *ops)
 	__unregister_pernet_operations(ops);
 	rcu_barrier();
 	if (ops->id)
-		ida_remove(&net_generic_ids, *ops->id);
+		ida_free(&net_generic_ids, *ops->id);
 }
 
 /**
-- 
2.17.1

