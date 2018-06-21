Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56ECC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3CD22421
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPIMdplW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3CD22421
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbeFUVcJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:32:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933976AbeFUV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LysdqBJfTOgdf7ibJBPjyCrUfzJXqcPm5gS200nhsCI=; b=gPIMdplWSCbF1zqTw1xh9+a08
        S2DQ1TvUUtiReJiU/AsB7v5R8rzcx8+GoyLCG6uiZq0w0t8CNLga1bTrBEgfR/jq19F7SvWBrxNjq
        DE+9cWjmTDDEtjzvOnnAvZuXBNkicJG720ty4BaZtXkDoHPMJcBFcTTnj1j1IWjIvXAsjzh4P8OYC
        4wG6cTsEyD1jds8Tb2+X6NCJIDk0NjEOk7xhTluYyR6u6j87i1ztj8nfdrcdSzmCvhFS4/XXQk+Os
        +OVX/WjZ/Lytated3ph1Q+5vyzFXtkcLCOaBwitYTbk9B2ZViCwy58BkOC5Oyo6XHQm9b0f2ZYOlA
        TkPhH8d/w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78g-0001cr-UV; Thu, 21 Jun 2018 21:29:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 22/26] test_ida: Move ida_check_max
Date:   Thu, 21 Jun 2018 14:28:31 -0700
Message-Id: <20180621212835.5636-23-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to new API and move to kernel space.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/test_ida.c                      | 23 +++++++++++++++++++++++
 tools/testing/radix-tree/idr-test.c | 28 ----------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index 50dce991be6b..e8ab544032f9 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -43,6 +43,28 @@ static void ida_check_leaf(struct ida *ida, unsigned int base)
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
+/*
+ * Check allocations up to and slightly above the maximum allowed (2^31-1) ID.
+ * Allocating up to 2^31-1 should succeed, and then allocating the next one
+ * should fail.
+ */
+static void ida_check_max(struct ida *ida)
+{
+	unsigned long i, j;
+
+	for (j = 1; j < 65537; j *= 2) {
+		unsigned long base = (1UL << 31) - j;
+		for (i = 0; i < j; i++) {
+			IDA_BUG_ON(ida, ida_alloc_min(ida, base, GFP_KERNEL) !=
+					base + i);
+		}
+		IDA_BUG_ON(ida, ida_alloc_min(ida, base, GFP_KERNEL) !=
+				-ENOSPC);
+		ida_destroy(ida);
+		IDA_BUG_ON(ida, !ida_is_empty(ida));
+	}
+}
+
 static int ida_checks(void)
 {
 	DEFINE_IDA(ida);
@@ -51,6 +73,7 @@ static int ida_checks(void)
 	ida_check_leaf(&ida, 0);
 	ida_check_leaf(&ida, 1024);
 	ida_check_leaf(&ida, 1024 * 64);
+	ida_check_max(&ida);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index fef1f45b927b..bd9699327f95 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -396,33 +396,6 @@ void ida_check_conv(void)
 	ida_destroy(&ida);
 }
 
-/*
- * Check allocations up to and slightly above the maximum allowed (2^31-1) ID.
- * Allocating up to 2^31-1 should succeed, and then allocating the next one
- * should fail.
- */
-void ida_check_max(void)
-{
-	DEFINE_IDA(ida);
-	int id, err;
-	unsigned long i, j;
-
-	for (j = 1; j < 65537; j *= 2) {
-		unsigned long base = (1UL << 31) - j;
-		for (i = 0; i < j; i++) {
-			assert(ida_pre_get(&ida, GFP_KERNEL));
-			assert(!ida_get_new_above(&ida, base, &id));
-			assert(id == base + i);
-		}
-		assert(ida_pre_get(&ida, GFP_KERNEL));
-		err = ida_get_new_above(&ida, base, &id);
-		assert(err == -ENOSPC);
-		ida_destroy(&ida);
-		assert(ida_is_empty(&ida));
-		rcu_barrier();
-	}
-}
-
 void ida_check_random(void)
 {
 	DEFINE_IDA(ida);
@@ -534,7 +507,6 @@ void user_ida_checks(void)
 	ida_destroy(&ida);
 	assert(ida_is_empty(&ida));
 
-	ida_check_max();
 	ida_check_conv();
 	ida_check_random();
 	ida_simple_get_remove_test();
-- 
2.17.1

