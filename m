Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeBFCba (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:31:30 -0500
Received: from mx-fe5-210.meituan.com ([103.37.138.210]:41547 "EHLO
        mx02.meituan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeBFCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:31:23 -0500
DKIM-Filter: OpenDKIM Filter v2.9.2 dx-it-mx02.dx.sankuai.com A6A2D2975C00
From: Wang Long <wanglong19@meituan.com>
To: darrick.wong@oracle.com, tytso@mit.edu, jack@suse.com
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jbd2: remove the conditional test
Date: Mon,  5 Feb 2018 22:24:39 +0800
Message-Id: <1517840679-5902-1-git-send-email-wanglong19@meituan.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_destroy already handles null pointers, so we can remove the
conditional test entirely.

This patch also set NULL after the kmem_cache_destroy in function
jbd2_journal_destroy_handle_cache.

Signed-off-by: Wang Long <wanglong19@meituan.com>
---
 fs/jbd2/journal.c     | 18 +++++++-----------
 fs/jbd2/revoke.c      | 12 ++++--------
 fs/jbd2/transaction.c |  6 ++----
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 93016bb..3c27a61a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2286,8 +2286,7 @@ static void jbd2_journal_destroy_slabs(void)
 	int i;
 
 	for (i = 0; i < JBD2_MAX_SLABS; i++) {
-		if (jbd2_slab[i])
-			kmem_cache_destroy(jbd2_slab[i]);
+		kmem_cache_destroy(jbd2_slab[i]);
 		jbd2_slab[i] = NULL;
 	}
 }
@@ -2388,10 +2387,8 @@ static int jbd2_journal_init_journal_head_cache(void)
 
 static void jbd2_journal_destroy_journal_head_cache(void)
 {
-	if (jbd2_journal_head_cache) {
-		kmem_cache_destroy(jbd2_journal_head_cache);
-		jbd2_journal_head_cache = NULL;
-	}
+	kmem_cache_destroy(jbd2_journal_head_cache);
+	jbd2_journal_head_cache = NULL;
 }
 
 /*
@@ -2649,11 +2646,10 @@ static int __init jbd2_journal_init_handle_cache(void)
 
 static void jbd2_journal_destroy_handle_cache(void)
 {
-	if (jbd2_handle_cache)
-		kmem_cache_destroy(jbd2_handle_cache);
-	if (jbd2_inode_cache)
-		kmem_cache_destroy(jbd2_inode_cache);
-
+	kmem_cache_destroy(jbd2_handle_cache);
+	jbd2_handle_cache = NULL;
+	kmem_cache_destroy(jbd2_inode_cache);
+	jbd2_inode_cache = NULL;
 }
 
 /*
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 696ef15..240779e 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -180,14 +180,10 @@ static struct jbd2_revoke_record_s *find_revoke_record(journal_t *journal,
 
 void jbd2_journal_destroy_revoke_caches(void)
 {
-	if (jbd2_revoke_record_cache) {
-		kmem_cache_destroy(jbd2_revoke_record_cache);
-		jbd2_revoke_record_cache = NULL;
-	}
-	if (jbd2_revoke_table_cache) {
-		kmem_cache_destroy(jbd2_revoke_table_cache);
-		jbd2_revoke_table_cache = NULL;
-	}
+	kmem_cache_destroy(jbd2_revoke_record_cache);
+	jbd2_revoke_record_cache = NULL;
+	kmem_cache_destroy(jbd2_revoke_table_cache);
+	jbd2_revoke_table_cache = NULL;
 }
 
 int __init jbd2_journal_init_revoke_caches(void)
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index ac31103..3b642e0 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -49,10 +49,8 @@ int __init jbd2_journal_init_transaction_cache(void)
 
 void jbd2_journal_destroy_transaction_cache(void)
 {
-	if (transaction_cache) {
-		kmem_cache_destroy(transaction_cache);
-		transaction_cache = NULL;
-	}
+	kmem_cache_destroy(transaction_cache);
+	transaction_cache = NULL;
 }
 
 void jbd2_journal_free_transaction(transaction_t *transaction)
-- 
1.8.3.1
