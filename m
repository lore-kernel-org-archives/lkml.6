Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF86C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D59522421
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mZEJRUnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D59522421
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbeFUVcL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:32:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933971AbeFUV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9SEwNvigDV/5jpbl7n9wxNcQyUvd2+z/RP3TzKYnH8w=; b=mZEJRUnBGEkwyV8agi7Witixf
        BtXeY75l6O6YCT0Q9loUzoEg5ZfsEsat4fsLE896zmhGJc7vm/x2aUmb3ivDOdiz4h59ZYyy4CMoF
        ytzHAo4KfiaqSKb6GwtD+X2xvcO1b1JVEtnP4/yva366X3eUcRu8KZShkNs0bfdChz9NKz2UbyLTc
        ZAbuxtCCJU3tdv2JiweIxrrmjk19StYzbk7SarGDIdR3oJC/JzXCbkRNSgH7LtLeYvdNUHmAeXauD
        knpODlfOe2mJDwjiZAn7yfHzyvVQgVQtapECEV1dXMvA8Omv/l89Pl9w+kT0cmoK7WsPJ2juJApdq
        SQDSQVrsQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78g-0001cf-Nw; Thu, 21 Jun 2018 21:29:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 21/26] test_ida: Move ida_check_leaf
Date:   Thu, 21 Jun 2018 14:28:30 -0700
Message-Id: <20180621212835.5636-22-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to new API and move to kernel space.  Take the opportunity to
test the situation a little more thoroughly (ie at different offsets).

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/test_ida.c                      | 24 ++++++++++++++++++++++++
 tools/testing/radix-tree/idr-test.c | 27 ---------------------------
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index 5a5a742d5f09..50dce991be6b 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -22,11 +22,35 @@ void ida_dump(struct ida *ida) { }
 	}								\
 } while (0)
 
+/*
+ * Check what happens when we fill a leaf and then delete it.  This may
+ * discover mishandling of IDR_FREE.
+ */
+static void ida_check_leaf(struct ida *ida, unsigned int base)
+{
+	unsigned long i;
+
+	for (i = 0; i < IDA_BITMAP_BITS; i++) {
+		IDA_BUG_ON(ida, ida_alloc_min(ida, base, GFP_KERNEL) !=
+				base + i);
+	}
+
+	ida_destroy(ida);
+	assert(ida_is_empty(ida));
+
+	IDA_BUG_ON(ida, ida_alloc(ida, GFP_KERNEL) != 0);
+	ida_free(ida, 0);
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
 static int ida_checks(void)
 {
 	DEFINE_IDA(ida);
 
 	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
+	ida_check_leaf(&ida, 0);
+	ida_check_leaf(&ida, 1024);
+	ida_check_leaf(&ida, 1024 * 64);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 0f557784327d..fef1f45b927b 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -336,32 +336,6 @@ void ida_check_nomem(void)
 	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
 }
 
-/*
- * Check what happens when we fill a leaf and then delete it.  This may
- * discover mishandling of IDR_FREE.
- */
-void ida_check_leaf(void)
-{
-	DEFINE_IDA(ida);
-	int id;
-	unsigned long i;
-
-	for (i = 0; i < IDA_BITMAP_BITS; i++) {
-		assert(ida_pre_get(&ida, GFP_KERNEL));
-		assert(!ida_get_new(&ida, &id));
-		assert(id == i);
-	}
-
-	ida_destroy(&ida);
-	assert(ida_is_empty(&ida));
-
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-	assert(!ida_get_new(&ida, &id));
-	assert(id == 0);
-	ida_destroy(&ida);
-	assert(ida_is_empty(&ida));
-}
-
 /*
  * Check handling of conversions between exceptional entries and full bitmaps.
  */
@@ -560,7 +534,6 @@ void user_ida_checks(void)
 	ida_destroy(&ida);
 	assert(ida_is_empty(&ida));
 
-	ida_check_leaf();
 	ida_check_max();
 	ida_check_conv();
 	ida_check_random();
-- 
2.17.1

