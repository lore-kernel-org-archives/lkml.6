Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7194CC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2927222434
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sTsAWKBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2927222434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933923AbeFUV3H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933883AbeFUV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KA7I3lyTaAWE3lEhD4aIwohmIUjTSstkt8bvM8SVfWI=; b=sTsAWKBzRlb6Fu4GhWV3JZPSh
        Eq/Ca82ma+LDT6gLuvI4wQyxT9MpjpBrfy/4SQHYhlVTkBzS1MDcHJf+6lE/uloycMCqci0CfJ37Y
        pEw/WmbNSn+OPkXmuPPwDQNEjJGz1i+KEp2Cxhzpvn3HbUcO4U4A38PG+v1/OT6yZHOGIKKV5TORn
        zv8diVkx8HBDgMWffZNMy9L5/ZyZmPKUJNdGun5TQzbT8IkccyqWNksNe41s4xQzH4PpAh9lLCZEw
        O5Vxo2Z9erz9ICobd8/iXJ6iliIiWkWGPlxToJFu4j+Y1gdx4yiHDCE3WP8mJzOGFWgwNrEHSZOmw
        O0EaLK0vw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78W-0001Zw-2b; Thu, 21 Jun 2018 21:29:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 02/26] ida: Lock the IDA in ida_destroy
Date:   Thu, 21 Jun 2018 14:28:11 -0700
Message-Id: <20180621212835.5636-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user has no need to handle locking between ida_simple_get() and
ida_simple_remove().  They shouldn't be forced to think about whether
ida_destroy() might be called at the same time as any of their other
IDA manipulation calls.  Improve the documnetation while I'm in here.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/idr.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index ed9c169c12bd..352c6160e2e0 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -523,25 +523,30 @@ void ida_remove(struct ida *ida, int id)
 EXPORT_SYMBOL(ida_remove);
 
 /**
- * ida_destroy - Free the contents of an ida
- * @ida: ida handle
+ * ida_destroy() - Free all IDs.
+ * @ida: IDA handle.
+ *
+ * Calling this function frees all IDs and releases all resources used
+ * by an IDA.  When this call returns, the IDA is empty and can be reused
+ * or freed.  If the IDA is already empty, there is no need to call this
+ * function.
  *
- * Calling this function releases all resources associated with an IDA.  When
- * this call returns, the IDA is empty and can be reused or freed.  The caller
- * should not allow ida_remove() or ida_get_new_above() to be called at the
- * same time.
+ * Context: Any context.
  */
 void ida_destroy(struct ida *ida)
 {
+	unsigned long flags;
 	struct radix_tree_iter iter;
 	void __rcu **slot;
 
+	xa_lock_irqsave(&ida->ida_rt, flags);
 	radix_tree_for_each_slot(slot, &ida->ida_rt, &iter, 0) {
 		struct ida_bitmap *bitmap = rcu_dereference_raw(*slot);
 		if (!radix_tree_exception(bitmap))
 			kfree(bitmap);
 		radix_tree_iter_delete(&ida->ida_rt, &iter, slot);
 	}
+	xa_unlock_irqrestore(&ida->ida_rt, flags);
 }
 EXPORT_SYMBOL(ida_destroy);
 
-- 
2.17.1

