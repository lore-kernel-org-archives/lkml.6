Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeEKEz6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 00:55:58 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:46197 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeEKEz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 00:55:57 -0400
X-Google-Smtp-Source: AB8JxZprHG4bzHzTyRBFCSNtpmC1RObfc6ClAawSzjq9spUK8k2pTAnE6p4BGYPv9fJcDwIT13DV1Q==
From: Jongseok Kim <ks77sj@gmail.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jongseok Kim <ks77sj@gmail.com>
Subject: RE: [PATCH v2] z3fold: fix reclaim lock-ups
Date: Fri, 11 May 2018 13:55:24 +0900
Message-Id: <1526014524-5888-1-git-send-email-ks77sj@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525846319-6179-1-git-send-email-ks77sj@gmail.com>
References: <1525846319-6179-1-git-send-email-ks77sj@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A headless page also need to be set UNDER_RECLAIM in previous
reply, but I missed it.

---
 mm/z3fold.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 5f659ab..8536a47 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -849,10 +849,10 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
-			set_bit(UNDER_RECLAIM, &page->private);
 			break;
 		}
 
+		set_bit(UNDER_RECLAIM, &page->private);
 		list_del_init(&page->lru);
 		spin_unlock(&pool->lock);
 
@@ -899,6 +899,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		}
 next:
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
+			clear_bit(UNDER_RECLAIM, &page->private);
 			if (ret == 0) {
 				free_z3fold_page(page);
 				atomic64_dec(&pool->pages_nr);
-- 
2.7.4
