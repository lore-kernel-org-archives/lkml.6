Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeECGg6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:36:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38196 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeECGgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:36:55 -0400
X-Google-Smtp-Source: AB8JxZqs254fQ8qZOwy7ZCPKTIqefrSpdldFCF7v44ZzYsQ1EhtPSPdRBWcXstLSvPLkxDrYmpzGpw==
From: Jongseok Kim <ks77sj@gmail.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jongseok Kim <ks77sj@gmail.com>
Subject: [PATCH v2] z3fold: fix reclaim lock-ups
Date: Thu,  3 May 2018 15:36:18 +0900
Message-Id: <1525329378-1864-1-git-send-email-ks77sj@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the processing of headless pages, there was a problem that the
zhdr pointed to another page or a page was alread released in
z3fold_free(). So, the wrong page is encoded in headless, or test_bit
does not work properly in z3fold_reclaim_page(). This patch fixed these
problems.

Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
---
 mm/z3fold.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index d5b3f49..a36ffa5ab 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -819,6 +819,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 {
 	int i, ret = 0;
+	bool is_headless;
 	struct z3fold_header *zhdr = NULL;
 	struct page *page = NULL;
 	struct list_head *pos;
@@ -836,11 +837,11 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		}
 		list_for_each_prev(pos, &pool->lru) {
 			page = list_entry(pos, struct page, lru);
+			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
 				/* candidate found */
 				break;
 
-			zhdr = page_address(page);
 			if (!z3fold_page_trylock(zhdr))
 				continue; /* can't evict at this point */
 			kref_get(&zhdr->refcount);
@@ -873,9 +874,11 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			 * reference to this page
 			 */
 			z3fold_page_unlock(zhdr);
+			is_headless = false;
 		} else {
 			first_handle = encode_handle(zhdr, HEADLESS);
 			last_handle = middle_handle = 0;
+			is_headless = true;
 		}
 
 		/* Issue the eviction callback(s) */
@@ -895,11 +898,10 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 				goto next;
 		}
 next:
-		if (test_bit(PAGE_HEADLESS, &page->private)) {
-			if (ret == 0) {
-				free_z3fold_page(page);
+		if (is_headless) {
+			if (ret == 0)
 				return 0;
-			}
+
 			spin_lock(&pool->lock);
 			list_add(&page->lru, &pool->lru);
 			spin_unlock(&pool->lock);
-- 
2.7.4
