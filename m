Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8ABC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A166F2240E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SF6QeT79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A166F2240E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeFUVae (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:30:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933993AbeFUV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nYeeoWQ+885jk0DIMw6lrAOaIXXaNbz0ItnLOxhvbs8=; b=SF6QeT79doMSajD0g7kJyL8o0
        WWx/6Lz89Q/nBZOC2mAVHqsh0HPjMVkbID0DxvC9EReVwv67Ydm5cb3eqZP25lq8TsOMI3h8/lcnp
        oDoBDqDgSAT36+4kVV8C7JV52QNOHJSrHZsYFKMkxrGuWLHJYLKgVMYHpZVySv4Ror2tIid/KMfOb
        8MGIbS2mB6reydyR9XBoeix+RtedZzxS9Fl3q4n3VQtwa8fCZ5Ok5eJl+Um3SDZQaQkYWAdB1lAxd
        PsZaKQ9U7fXFcGrNlXoDvRN2Gj/UL6JGFaIGFxVrCDwVu8nW44rnVowHFC313sjlT71UPecayOhsP
        kmELAK4yw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78h-0001dT-NX; Thu, 21 Jun 2018 21:29:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@google.com>,
        Chris Mi <chrism@mellanox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 26/26] ida: Change ida_get_new_above to return the id
Date:   Thu, 21 Jun 2018 14:28:35 -0700
Message-Id: <20180621212835.5636-27-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This calling convention makes more sense for the implementation as well
as the callers.  It even shaves 32 bytes off the compiled code size.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/idr.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index 1dc52191acb6..fab2fd5bc326 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -363,7 +363,7 @@ EXPORT_SYMBOL(idr_replace);
 
 #define IDA_MAX (0x80000000U / IDA_BITMAP_BITS - 1)
 
-static int ida_get_new_above(struct ida *ida, int start, int *id)
+static int ida_get_new_above(struct ida *ida, int start)
 {
 	struct radix_tree_root *root = &ida->ida_rt;
 	void __rcu **slot;
@@ -402,8 +402,8 @@ static int ida_get_new_above(struct ida *ida, int start, int *id)
 			if (ebit < BITS_PER_LONG) {
 				tmp |= 1UL << ebit;
 				rcu_assign_pointer(*slot, (void *)tmp);
-				*id = new + ebit - RADIX_TREE_EXCEPTIONAL_SHIFT;
-				return 0;
+				return new + ebit -
+					RADIX_TREE_EXCEPTIONAL_SHIFT;
 			}
 			bitmap = this_cpu_xchg(ida_bitmap, NULL);
 			if (!bitmap)
@@ -434,8 +434,7 @@ static int ida_get_new_above(struct ida *ida, int start, int *id)
 						RADIX_TREE_EXCEPTIONAL_ENTRY);
 				radix_tree_iter_replace(root, &iter, slot,
 						bitmap);
-				*id = new;
-				return 0;
+				return new;
 			}
 			bitmap = this_cpu_xchg(ida_bitmap, NULL);
 			if (!bitmap)
@@ -444,8 +443,7 @@ static int ida_get_new_above(struct ida *ida, int start, int *id)
 			radix_tree_iter_replace(root, &iter, slot, bitmap);
 		}
 
-		*id = new;
-		return 0;
+		return new;
 	}
 }
 
@@ -534,7 +532,7 @@ EXPORT_SYMBOL(ida_destroy);
 int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 			gfp_t gfp)
 {
-	int ret, id = 0;
+	int id = 0;
 	unsigned long flags;
 
 	if ((int)min < 0)
@@ -545,24 +543,20 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 
 again:
 	xa_lock_irqsave(&ida->ida_rt, flags);
-	ret = ida_get_new_above(ida, min, &id);
-	if (!ret) {
-		if (id > max) {
-			ida_remove(ida, id);
-			ret = -ENOSPC;
-		} else {
-			ret = id;
-		}
+	id = ida_get_new_above(ida, min);
+	if (id > (int)max) {
+		ida_remove(ida, id);
+		id = -ENOSPC;
 	}
 	xa_unlock_irqrestore(&ida->ida_rt, flags);
 
-	if (unlikely(ret == -EAGAIN)) {
+	if (unlikely(id == -EAGAIN)) {
 		if (!ida_pre_get(ida, gfp))
 			return -ENOMEM;
 		goto again;
 	}
 
-	return ret;
+	return id;
 }
 EXPORT_SYMBOL(ida_alloc_range);
 
-- 
2.17.1

