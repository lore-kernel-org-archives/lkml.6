Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691D1C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA3422415
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pwA4IRM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA3422415
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeFUVbo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:31:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933980AbeFUV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HNmaM8ejrAD4rksJ/dN/SH3rhwSSjX8xB4d6SnU8CqA=; b=pwA4IRM22wm/ctNTG2OhLT88V
        xArq7pYvXUgpI90BtkyYs0rp12IPxBEvNQ1RFydC1nLCpYXCxCHUNjA2IgOSF+ldQbZMs4k+weuGU
        32wP0SqcACk0QP+Apy4YtfdYbEj9DMCI58kkHllXgjpIh5SPl7uhlcgb5YGmWw833lE+SgZBrcgGN
        pW1eASQl2O/2ogeyadUtw4L5ySOe/KcrcYXyRNZnRJ8FmfO2KQj/9WeCdo9BfITgINp3MOISE3i9d
        GGTkKMl4KzIBBjDFWGtPN0R/i0HJmJfH34JLS5Dj+m5jMlFgMXf/8tfa6tLxvp6vMRZEYoTExpcrc
        BFLkLA+2A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78h-0001d3-4x; Thu, 21 Jun 2018 21:29:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 23/26] test_ida: Convert check_ida_conv to new API
Date:   Thu, 21 Jun 2018 14:28:32 -0700
Message-Id: <20180621212835.5636-24-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move as much as possible to kernel space; leave the parts in user space
that rely on checking memory allocation failures to detect the
transition between an exceptional entry and a bitmap.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/test_ida.c                      | 31 ++++++++++++++++
 tools/testing/radix-tree/idr-test.c | 56 ++++++-----------------------
 2 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index e8ab544032f9..15e013800171 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -65,6 +65,36 @@ static void ida_check_max(struct ida *ida)
 	}
 }
 
+/*
+ * Check handling of conversions between exceptional entries and full bitmaps.
+ */
+static void ida_check_conv(struct ida *ida)
+{
+	unsigned long i;
+	int id;
+
+	for (i = 0; i < IDA_BITMAP_BITS * 2; i += IDA_BITMAP_BITS) {
+		IDA_BUG_ON(ida, ida_alloc_min(ida, i + 1, GFP_KERNEL) != i + 1);
+		IDA_BUG_ON(ida, ida_alloc_min(ida, i + BITS_PER_LONG,
+					GFP_KERNEL) != i + BITS_PER_LONG);
+		ida_free(ida, i + 1);
+		ida_free(ida, i + BITS_PER_LONG);
+		IDA_BUG_ON(ida, !ida_is_empty(ida));
+	}
+
+	for (i = 0; i < IDA_BITMAP_BITS * 2; i++)
+		IDA_BUG_ON(ida, ida_alloc(ida, GFP_KERNEL) != i);
+	for (i = IDA_BITMAP_BITS * 2; i > 0; i--)
+		ida_free(ida, i - 1);
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+
+	for (i = 0; i < IDA_BITMAP_BITS + BITS_PER_LONG - 4; i++)
+		IDA_BUG_ON(ida, ida_alloc(ida, GFP_KERNEL) != i);
+	for (i = IDA_BITMAP_BITS + BITS_PER_LONG - 4; i > 0; i--)
+		ida_free(ida, i - 1);
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
 static int ida_checks(void)
 {
 	DEFINE_IDA(ida);
@@ -74,6 +104,7 @@ static int ida_checks(void)
 	ida_check_leaf(&ida, 1024);
 	ida_check_leaf(&ida, 1024 * 64);
 	ida_check_max(&ida);
+	ida_check_conv(&ida);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index bd9699327f95..f948e38b9a6b 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -339,59 +339,23 @@ void ida_check_nomem(void)
 /*
  * Check handling of conversions between exceptional entries and full bitmaps.
  */
-void ida_check_conv(void)
+void ida_check_conv_user(void)
 {
 	DEFINE_IDA(ida);
-	int id;
 	unsigned long i;
 
-	for (i = 0; i < IDA_BITMAP_BITS * 2; i += IDA_BITMAP_BITS) {
-		assert(ida_pre_get(&ida, GFP_KERNEL));
-		assert(!ida_get_new_above(&ida, i + 1, &id));
-		assert(id == i + 1);
-		assert(!ida_get_new_above(&ida, i + BITS_PER_LONG, &id));
-		assert(id == i + BITS_PER_LONG);
-		ida_remove(&ida, i + 1);
-		ida_remove(&ida, i + BITS_PER_LONG);
-		assert(ida_is_empty(&ida));
-	}
-
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-
-	for (i = 0; i < IDA_BITMAP_BITS * 2; i++) {
-		assert(ida_pre_get(&ida, GFP_KERNEL));
-		assert(!ida_get_new(&ida, &id));
-		assert(id == i);
-	}
-
-	for (i = IDA_BITMAP_BITS * 2; i > 0; i--) {
-		ida_remove(&ida, i - 1);
-	}
-	assert(ida_is_empty(&ida));
-
-	for (i = 0; i < IDA_BITMAP_BITS + BITS_PER_LONG - 4; i++) {
-		assert(ida_pre_get(&ida, GFP_KERNEL));
-		assert(!ida_get_new(&ida, &id));
-		assert(id == i);
-	}
-
-	for (i = IDA_BITMAP_BITS + BITS_PER_LONG - 4; i > 0; i--) {
-		ida_remove(&ida, i - 1);
-	}
-	assert(ida_is_empty(&ida));
-
 	radix_tree_cpu_dead(1);
 	for (i = 0; i < 1000000; i++) {
-		int err = ida_get_new(&ida, &id);
-		if (err == -EAGAIN) {
-			assert((i % IDA_BITMAP_BITS) == (BITS_PER_LONG - 2));
-			assert(ida_pre_get(&ida, GFP_KERNEL));
-			err = ida_get_new(&ida, &id);
+		int id = ida_alloc(&ida, GFP_NOWAIT);
+		if (id == -ENOMEM) {
+			IDA_BUG_ON(&ida, (i % IDA_BITMAP_BITS) !=
+					(BITS_PER_LONG - 2));
+			id = ida_alloc(&ida, GFP_KERNEL);
 		} else {
-			assert((i % IDA_BITMAP_BITS) != (BITS_PER_LONG - 2));
+			IDA_BUG_ON(&ida, (i % IDA_BITMAP_BITS) ==
+					(BITS_PER_LONG - 2));
 		}
-		assert(!err);
-		assert(id == i);
+		IDA_BUG_ON(&ida, id != i);
 	}
 	ida_destroy(&ida);
 }
@@ -507,7 +471,7 @@ void user_ida_checks(void)
 	ida_destroy(&ida);
 	assert(ida_is_empty(&ida));
 
-	ida_check_conv();
+	ida_check_conv_user();
 	ida_check_random();
 	ida_simple_get_remove_test();
 
-- 
2.17.1

