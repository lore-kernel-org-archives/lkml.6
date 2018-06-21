Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE7C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9672241A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M8Nf1Vzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9672241A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933786AbeFUVbm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:31:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933985AbeFUV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X/ZfGE4t/ViC2dt0XRJZtzHKlZ8A2qq/KH35UIDUT2I=; b=M8Nf1VzzzTpqztBCC5w2QORcy
        uYvbUxAtiltJOuUdn5VtZxLAdVFL+K/6PoMliC6XmKvqtWK+O4N04S4Yp0PPFVeZZxhLYQ+qUog8X
        t2bVFAqOV+fqgz7rYwE1/4t6IB2NEZgUzC8U1ugms7dMAruNmtSH5CCCTgFmZzjFDhK4vAZGd5vtH
        F9jFKCsQ8nWkvTA7yen+fCeX5f8YMec3H8NOGxagmNEyMBI9xLoSvZJOkbPnUmab9S0IJT6bQsPmD
        qD6EVvywJmPEWq7Bo3NuCMZVOZU7R/iw3UcVJON8yJXKgwTbxV4XilOJdxwy/SpOTLRZlkqN/9BD3
        oeoSc/bKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78h-0001dD-Bz; Thu, 21 Jun 2018 21:29:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 24/26] test_ida: check_ida_destroy and check_ida_alloc
Date:   Thu, 21 Jun 2018 14:28:33 -0700
Message-Id: <20180621212835.5636-25-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move these tests from the userspace test-suite to the kernel test-suite.
Also convert check_ida_random to the new API.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/test_ida.c                      | 55 ++++++++++++++++++++++-
 tools/testing/radix-tree/idr-test.c | 70 ++---------------------------
 2 files changed, 58 insertions(+), 67 deletions(-)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index 15e013800171..433cb8a69732 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -22,6 +22,58 @@ void ida_dump(struct ida *ida) { }
 	}								\
 } while (0)
 
+/*
+ * Straightforward checks that allocating and freeing IDs work.
+ */
+static void ida_check_alloc(struct ida *ida)
+{
+	int i, id;
+
+	for (i = 0; i < 10000; i++)
+		IDA_BUG_ON(ida, ida_alloc(ida, GFP_KERNEL) != i);
+
+	ida_free(ida, 20);
+	ida_free(ida, 21);
+	for (i = 0; i < 3; i++) {
+		id = ida_alloc(ida, GFP_KERNEL);
+		IDA_BUG_ON(ida, id < 0);
+		if (i == 2)
+			IDA_BUG_ON(ida, id != 10000);
+	}
+
+	for (i = 0; i < 5000; i++)
+		ida_free(ida, i);
+
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 5000, GFP_KERNEL) != 10001);
+	ida_destroy(ida);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
+/* Destroy an IDA with a single entry at @base */
+static void ida_check_destroy_1(struct ida *ida, unsigned int base)
+{
+	IDA_BUG_ON(ida, ida_alloc_min(ida, base, GFP_KERNEL) != base);
+	IDA_BUG_ON(ida, ida_is_empty(ida));
+	ida_destroy(ida);
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
+/* Check that ida_destroy and ida_is_empty work */
+static void ida_check_destroy(struct ida *ida)
+{
+	/* Destroy an already-empty IDA */
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+	ida_destroy(ida);
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+
+	ida_check_destroy_1(ida, 0);
+	ida_check_destroy_1(ida, 1);
+	ida_check_destroy_1(ida, 1023);
+	ida_check_destroy_1(ida, 1024);
+	ida_check_destroy_1(ida, 12345678);
+}
+
 /*
  * Check what happens when we fill a leaf and then delete it.  This may
  * discover mishandling of IDR_FREE.
@@ -71,7 +123,6 @@ static void ida_check_max(struct ida *ida)
 static void ida_check_conv(struct ida *ida)
 {
 	unsigned long i;
-	int id;
 
 	for (i = 0; i < IDA_BITMAP_BITS * 2; i += IDA_BITMAP_BITS) {
 		IDA_BUG_ON(ida, ida_alloc_min(ida, i + 1, GFP_KERNEL) != i + 1);
@@ -100,6 +151,8 @@ static int ida_checks(void)
 	DEFINE_IDA(ida);
 
 	IDA_BUG_ON(&ida, !ida_is_empty(&ida));
+	ida_check_alloc(&ida);
+	ida_check_destroy(&ida);
 	ida_check_leaf(&ida, 0);
 	ida_check_leaf(&ida, 1024);
 	ida_check_leaf(&ida, 1024 * 64);
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index f948e38b9a6b..052c0c4cc0f3 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -364,7 +364,6 @@ void ida_check_random(void)
 {
 	DEFINE_IDA(ida);
 	DECLARE_BITMAP(bitmap, 2048);
-	int id, err;
 	unsigned int i;
 	time_t s = time(NULL);
 
@@ -375,15 +374,11 @@ void ida_check_random(void)
 		int bit = i & 2047;
 		if (test_bit(bit, bitmap)) {
 			__clear_bit(bit, bitmap);
-			ida_remove(&ida, bit);
+			ida_free(&ida, bit);
 		} else {
 			__set_bit(bit, bitmap);
-			do {
-				ida_pre_get(&ida, GFP_KERNEL);
-				err = ida_get_new_above(&ida, bit, &id);
-			} while (err == -EAGAIN);
-			assert(!err);
-			assert(id == bit);
+			IDA_BUG_ON(&ida, ida_alloc_min(&ida, bit, GFP_KERNEL)
+					!= bit);
 		}
 	}
 	ida_destroy(&ida);
@@ -411,66 +406,9 @@ void ida_simple_get_remove_test(void)
 
 void user_ida_checks(void)
 {
-	DEFINE_IDA(ida);
-	int id;
-	unsigned long i;
-
 	radix_tree_cpu_dead(1);
-	ida_check_nomem();
-
-	for (i = 0; i < 10000; i++) {
-		assert(ida_pre_get(&ida, GFP_KERNEL));
-		assert(!ida_get_new(&ida, &id));
-		assert(id == i);
-	}
-
-	ida_remove(&ida, 20);
-	ida_remove(&ida, 21);
-	for (i = 0; i < 3; i++) {
-		assert(ida_pre_get(&ida, GFP_KERNEL));
-		assert(!ida_get_new(&ida, &id));
-		if (i == 2)
-			assert(id == 10000);
-	}
-
-	for (i = 0; i < 5000; i++)
-		ida_remove(&ida, i);
-
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-	assert(!ida_get_new_above(&ida, 5000, &id));
-	assert(id == 10001);
-
-	ida_destroy(&ida);
-
-	assert(ida_is_empty(&ida));
-
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-	assert(!ida_get_new_above(&ida, 1, &id));
-	assert(id == 1);
-
-	ida_remove(&ida, id);
-	assert(ida_is_empty(&ida));
-	ida_destroy(&ida);
-	assert(ida_is_empty(&ida));
-
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-	assert(!ida_get_new_above(&ida, 1, &id));
-	ida_destroy(&ida);
-	assert(ida_is_empty(&ida));
-
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-	assert(!ida_get_new_above(&ida, 1, &id));
-	assert(id == 1);
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-	assert(!ida_get_new_above(&ida, 1025, &id));
-	assert(id == 1025);
-	assert(ida_pre_get(&ida, GFP_KERNEL));
-	assert(!ida_get_new_above(&ida, 10000, &id));
-	assert(id == 10000);
-	ida_remove(&ida, 1025);
-	ida_destroy(&ida);
-	assert(ida_is_empty(&ida));
 
+	ida_check_nomem();
 	ida_check_conv_user();
 	ida_check_random();
 	ida_simple_get_remove_test();
-- 
2.17.1

