Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeBJLC4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 06:02:56 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33320 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 06:02:54 -0500
X-Google-Smtp-Source: AH8x2258sdPl2+0Dvvo5fV8gtJaPRku4+7k0xJNRZvwflTwEeyAEh3eaer+kjmXJAVesX4WPrFKs7w==
To: Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com
From: Vitaly Wool <vitalywool@gmail.com>
Subject: [PATCH] z3fold: limit use of stale list for allocation
Message-ID: <47ab51e7-e9c1-d30e-ab17-f734dbc3abce@gmail.com>
Date: Sat, 10 Feb 2018 12:02:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if z3fold couldn't find an unbuddied page it would first
try to pull a page off the stale list. The problem with this
approach is that we can't 100% guarantee that the page is not
processed by the workqueue thread at the same time unless we run
cancel_work_sync() on it, which we can't do if we're in an atomic
context. So let's just limit stale list usage to non-atomic
contexts only.

Signed-off-by: Vitaly Vul <vitaly.vul@sony.com>
---
  mm/z3fold.c | 35 +++++++++++++++++++----------------
  1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 39e1912..9b0d112 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -620,24 +620,27 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
  		bud = FIRST;
  	}
  
-	spin_lock(&pool->stale_lock);
-	zhdr = list_first_entry_or_null(&pool->stale,
-					struct z3fold_header, buddy);
-	/*
-	 * Before allocating a page, let's see if we can take one from the
-	 * stale pages list. cancel_work_sync() can sleep so we must make
-	 * sure it won't be called in case we're in atomic context.
-	 */
-	if (zhdr && (can_sleep || !work_pending(&zhdr->work))) {
-		list_del(&zhdr->buddy);
-		spin_unlock(&pool->stale_lock);
-		if (can_sleep)
+	page = NULL;
+	if (can_sleep) {
+		spin_lock(&pool->stale_lock);
+		zhdr = list_first_entry_or_null(&pool->stale,
+						struct z3fold_header, buddy);
+		/*
+		 * Before allocating a page, let's see if we can take one from
+		 * the stale pages list. cancel_work_sync() can sleep so we
+		 * limit this case to the contexts where we can sleep
+		 */
+		if (zhdr) {
+			list_del(&zhdr->buddy);
+			spin_unlock(&pool->stale_lock);
  			cancel_work_sync(&zhdr->work);
-		page = virt_to_page(zhdr);
-	} else {
-		spin_unlock(&pool->stale_lock);
-		page = alloc_page(gfp);
+			page = virt_to_page(zhdr);
+		} else {
+			spin_unlock(&pool->stale_lock);
+		}
  	}
+	if (!page)
+		page = alloc_page(gfp);
  
  	if (!page)
  		return -ENOMEM;
-- 
2.7.4
